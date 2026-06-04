# integrated-labs apply helper 安全性与可复现性审查

本文件是 stage4f 红队对 `scripts/xv6/apply-integrated-labs.sh` 的安全性与可复现性审查，目标是确认这个会执行 `git reset --hard` + `git clean -fdx` 的破坏性脚本，安全边界足够明确、适合交给队友和评委使用。

- 阶段：stage4f
- 日期：2026-06-04
- 角色：严格评委 + 工程红队 + OS 实验助教
- 目标脚本：`scripts/xv6/apply-integrated-labs.sh`
- baseline commit：`74f84181a3404d1d6a6ff98d342233979066ebb8`
- 重要声明：结论来自真实命令输出；第三方源码与原始日志默认不提交；人工录屏、长期稳定性测试、第二名队员复现仍为 TODO。

## 1. 总体结论

**通过（修复一处后）。** 脚本的默认预览安全、固定 baseline、按序应用、日志隔离、失败返回非零、含空格路径处理正确。

stage4f 红队修复了**一处真实安全缺陷**：原脚本的 `--yes` 门控是**条件性**的——只有当 ignored 树存在本地改动时才要求 `--yes`；当树看似干净（`git status --porcelain` 为空）时，`--run`/`--make` 无需 `--yes` 就会执行 `git reset --hard` + `git clean -fdx`（仍会删除 ignored 的构建产物）。这与脚本自身的 usage 文本和约定不一致。**已改为 `--run`/`--make` 始终要求 `--yes`**，并重新验证。

## 2. helper 支持的模式

| 命令 | 行为 | 是否破坏性 |
| --- | --- | --- |
| `bash scripts/xv6/apply-integrated-labs.sh` | 预览：打印仓库根、目标目录、baseline、当前 HEAD、将执行的操作，并对当前树做只读 `git apply --check`。**不 reset、不 clean、不 apply、不 make** | 否 |
| `... --run --yes` | reset/clean ignored 树到 baseline，按序 `git apply` `0001`/`0002`/`0003` | 是（需 `--yes`） |
| `... --make --yes` | 同 `--run`，再 `make` 并把输出写入 `logs/integrated-make-*.log` | 是（需 `--yes`） |
| `... --run` / `... --make`（无 `--yes`） | **拒绝执行**，`[ERROR]` 提示并 exit 1 | 否（被拦截） |
| `-h` / `--help` | 打印用法 | 否 |

`--make` 隐含 `--run`。

## 3. 安全边界

- **默认预览**：不带参数时只读检查，绝不修改 external 树或主仓库（已实测 HEAD 与 `git status --porcelain` 前后一致）。
- **`--yes` 强制确认（本轮加固）**：任何 `--run`/`--make` 都必须显式 `--yes`，因为它们会 `git reset --hard` + `git clean -fdx`，丢弃 ignored 树的本地改动和构建产物。
- **只操作 ignored 第三方树**：所有 `git` 操作通过 `git -C external/xv6-riscv` 进行；脚本不修改主仓库的 tracked 文件（仅向 ignored 的 `logs/` 写日志）。
- **固定 baseline**：默认 `BASELINE_COMMIT=74f84181a3404d1d6a6ff98d342233979066ebb8`（可用 `XV6_BASELINE_COMMIT` 覆盖）；应用前用 `git cat-file -e` 确认该 commit 本地存在。
- **patch 存在性检查**：三个 patch 缺任一即 `[ERROR]` + exit 1。
- **顺序应用**：严格按 `0001` → `0002` → `0003`，每步先 `git apply --check` 再 `git apply`，任一失败 exit 1。
- **日志隔离**：make 输出写入 `logs/integrated-make-YYYYMMDD-HHMMSS.log`（被 `.gitignore` 忽略，不提交）。
- **失败可见**：reset/clean/apply/make 任一失败均返回非零退出码。
- **含空格路径**：仓库路径为 `/mnt/d/Edge Download/...`，脚本用 `git rev-parse --show-toplevel` 取根并全程加引号；patch 路径无空格，word-splitting 安全。
- **输出规范**：统一 `[OK]` / `[WARN]` / `[ERROR]` 前缀。

## 4. 真实验证步骤（stage4f）

在 Windows Git Bash 验证门控（破坏性操作前即拦截，安全），在 WSL2 Ubuntu 验证真实 reset/apply/make/run。

| 检查项 | 命令 | 结果 |
| --- | --- | --- |
| 语法 | `bash -n scripts/xv6/apply-integrated-labs.sh` | OK |
| 预览不改动 | `apply-integrated-labs.sh`（WSL） | exit 0；external HEAD 与 `git status --porcelain` 前后一致 |
| `--run` 无 `--yes` | `apply-integrated-labs.sh --run` | **exit 1**，`[ERROR] refusing to reset/clean ... without --yes` |
| `--make` 无 `--yes` | `apply-integrated-labs.sh --make` | **exit 1**，同上拦截 |
| `--make --yes` | `apply-integrated-labs.sh --make --yes`（WSL） | exit 0；reset clean baseline，顺序 apply 三个 patch，`make` 成功 |
| make 日志 | — | `logs/integrated-make-20260604-204228.log`（ignored，不提交） |
| syscall.h | — | 尾部 `SYS_hello 22` / `SYS_add2 23` / `SYS_pstate 24` |

## 5. make / boot / hello / add2test / pstatetest 结果（真实执行）

helper `--make --yes` 构建的同一 integrated xv6 上：

| 检查项 | 结果 |
| --- | --- |
| `make` | 成功（exit 0；仅已知 `LOAD segment with RWX permissions` 警告） |
| boot evidence | `BOOT_EVIDENCE_FOUND`（`xv6 kernel is booting` + `init: starting sh`） |
| `hello` | `COMMAND_EVIDENCE_FOUND`：`hello syscall returned 2026` |
| `add2test` | `COMMAND_EVIDENCE_FOUND`：`add2(20, 6) returned 26` |
| `pstatetest` | `COMMAND_EVIDENCE_FOUND`：`pstate(self) = 4 (RUNNING)`（含 `pstate(self) =` 与 `RUNNING`） |

三个程序输出来自 helper 一键构建的**同一个 xv6 构建**。

## 6. 对队友 / 评委的使用建议

1. 先预览，确认目标目录与 baseline 无误：

   ```bash
   bash scripts/xv6/apply-integrated-labs.sh
   ```

2. 确认可以丢弃 `external/xv6-riscv/` 的本地改动后，一键构建：

   ```bash
   bash scripts/xv6/apply-integrated-labs.sh --make --yes
   ```

3. 捕获证据：

   ```bash
   bash scripts/xv6/boot-xv6.sh
   bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
   bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
   bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
   bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
   ```

- 在 WSL2 Ubuntu 运行（Windows Git Bash 缺 make，无法构建）。
- 单 lab 教学仍用各自独立 patch；综合演示才用 integrated helper。

## 7. 风险

- **`--make --yes` 会 reset/clean ignored external 树**：丢弃其本地改动和构建产物。运行前确认这些改动可丢弃（patch 是可提交的真源，external 树本就不提交）。
- **两套 syscall 号不可混用**：独立 lab2 用 `pstate=22`，integrated 用 `pstate=24`；helper 只应用 integrated 序列。
- **证据为 timeout 自动捕获**：不等于长期稳定性测试。
- **人工交互录屏**：TODO。
- **第二名队员独立复现**：TODO。
- **`user/usys.pl` file mode warning**：apply 时可能出现 100755/100644 不一致告警，不阻塞，但建议后续统一处理。

## 8. 后续建议

1. 可选增加 `--baseline <commit>` 显式参数（当前靠 `XV6_BASELINE_COMMIT` 环境变量），让评委更直观地指定/确认 baseline。
2. 保持脚本克制：不要让 helper 自动声明 boot 或用户程序成功；boot/输出证据继续由 `boot-xv6.sh`、`run-xv6-command.sh` 单独捕获并记录。
3. 第二名队员在另一台机器按第 6 节复现，并录一段真实人工交互演示。
4. 后续新增 lab 时，把新 patch 加入 helper 的 `PATCHES` 列表并复跑本报告第 4-5 节。
5. 统一处理 `usys.pl` file mode warning。
