# 初赛提交就绪度总审查（submission readiness review）

阶段：stage6d（严格红队 + 完整 integrated 复现 + 提交前总审查）

日期：2026-06-05

baseline commit：`74f84181a3404d1d6a6ff98d342233979066ebb8`

环境：WSL2 Ubuntu-24.04（真实构建/boot/命令均在此执行；Windows MINGW64 / PowerShell 无 RISC-V 工具链，不在其中伪报成功）。

重要声明：本报告只记录真实执行过的命令和结果。`external/xv6-riscv/` 与 `logs/*.log` 均 ignored，不提交。官方 GitLab 是比赛主仓库，GitHub 仅为私有备份。

## 1. 总体结论

**当前状态对初赛是“可信、可复现、可展示”的，但尚未“提交完备”。**

- 可信：所有 make/boot/用户程序证据都来自 WSL2 真实运行，文档边界诚实，未发现伪造或夸大。
- 可复现：`apply-integrated-labs.sh --make --yes` 可从 clean baseline 一键得到 integrated `0001-0005` 构建，boot 与 6 个用户程序输出均可自动捕获。
- 可展示：README、技术报告、复现包、Demo 脚本齐备，syscall 号、命令名、边界说明全仓一致。
- 仍缺：**第二名队员独立复现**与**人工交互录屏**两项硬性证据为 TODO；lab3 未做；lab4 仅文件表观察。这些是“是否拿得出更强初赛材料”的关键短板，但都已被如实标注为 TODO，不构成诚信问题。

红队判断：可以作为一份诚实、自洽的初赛 MVP 提交；冲奖则必须补齐队友复现与录屏，并至少推进 lab3 或深化 lab4。

## 2. 当前完成模块

| 模块 | 状态 | 真实证据要点 |
| --- | --- | --- |
| lab0 环境与 baseline | 完成 | 工具链检查通过；baseline make、boot evidence 已捕获 |
| lab1 hello / add2 | 完成 | `hello syscall returned 2026`、`add2(20, 6) returned 26` |
| lab2 pstate / pcount / pchildtest | 完成 | `pstate(self) = 4 (RUNNING)`、`pcount(RUNNING) = <n>`、`pcount(99) = -1`、`pstate(child) =` |
| lab4 fcount / fcounttest | 完成（v0.1 文件表观察） | `fcount(before/after_open/after_close) =`、`fcounttest done` |
| integrated helper | 完成 | `apply-integrated-labs.sh` 预览只读；`--run/--make` 始终需 `--yes`；应用 `0001-0005`；make 日志 ignored |
| boot retry 加固 | 完成 | `boot-xv6.sh` 默认 45s×2 次，支持 `XV6_BOOT_TIMEOUT_SECONDS`/`XV6_BOOT_RETRIES`，每次尝试写 ignored 日志，输入参数做正整数校验 |
| lab3 内存/页表 | 未完成 | 计划中，未声称完成 |
| lab5 最终集成与报告 | 未完成 | 计划中 |

integrated syscall 号：hello=22、add2=23、pstate=24、pcount=25、fcount=26（independent lab4 单独教学时 `SYS_fcount=22`，与 integrated 的 26 在文档中明确区分）。

## 3. 完整 integrated 复现结果（stage6d，2026-06-05，真实执行）

| 检查项 | 命令 | 结果 | 实测要点 |
| --- | --- | --- | --- |
| 环境检查 | `bash scripts/check-env.sh` | PASS | git/make/qemu/riscv64-linux-gnu-gcc 就绪；`riscv64-unknown-elf-gcc` WARN（可选，不影响构建） |
| baseline 检查 | `bash scripts/xv6/check-xv6-baseline.sh` | PASS | baseline 目录/Makefile/LICENSE 存在 |
| helper 预览 | `bash scripts/xv6/apply-integrated-labs.sh` | PASS | 只读；列出 `0001-0005` |
| clean apply + make | `bash scripts/xv6/apply-integrated-labs.sh --make --yes` | PASS | 5 个 patch 全部 `[OK]`；make 成功（日志 `logs/integrated-make-20260605-081851.log`，ignored） |
| boot（默认 45s×2） | `bash scripts/xv6/boot-xv6.sh` | PASS | attempt 1 即 `BOOT_EVIDENCE_FOUND` |
| boot（60s×2 覆盖） | `XV6_BOOT_TIMEOUT_SECONDS=60 XV6_BOOT_RETRIES=2 bash scripts/xv6/boot-xv6.sh` | PASS | attempt 1 即 `BOOT_EVIDENCE_FOUND`；env 覆盖生效（timeout 显示 60s） |
| hello | `run-xv6-command.sh hello "hello syscall returned 2026"` | PASS | `hello syscall returned 2026` |
| add2test | `run-xv6-command.sh add2test "add2(20, 6) returned 26"` | PASS | `add2(20, 6) returned 26` |
| pstatetest | `run-xv6-command.sh pstatetest "pstate(self) ="` | PASS | `pstate(self) = 4 (RUNNING)` |
| pcounttest（RUNNING） | `run-xv6-command.sh pcounttest "pcount(RUNNING) ="` | PASS | `pcount(RUNNING) = 1`（不固定承诺） |
| pcounttest（负向） | `run-xv6-command.sh pcounttest "pcount(99) = -1"` | PASS | `pcount(99) = -1` |
| pchildtest | `run-xv6-command.sh pchildtest "pstate(child) ="` | PASS | 同一 boot 内观察到 `2 (SLEEPING)` 与 `3 (RUNNABLE)`（调度时序不确定） |
| fcounttest | `run-xv6-command.sh fcounttest "fcounttest done"` | PASS | `before=1 → after_open=2 → after_close=1`、`fcounttest done`（`+1/-1` 差值稳定，绝对值不固定） |

结论：integrated `0001-0005` 在本轮从 clean baseline **完整复现成功**，10 个预期输出前缀全部在真实日志中命中。

## 4. 文档一致性审查结果

逐项核查（README、docs/04/13/17/18/19/20、reproducibility、videos、slides、patches/integrated-labs、labs/lab1/lab2/lab4、submissions 索引）：

| 检查点 | 结论 |
| --- | --- |
| 统一写 integrated `0001-0005` | 通过。当前/最终路径均为 `0001-0005`；残留的 `0001-0004` 仅为历史记录或“`0005` 应用在 `0001-0004` 之后”这类正确相对描述。 |
| 残留 `pstatechildtest` 实际调用 | 无。全部 `pstatechildtest` 字样都是“解释改名为 `pchildtest` 的原因”的历史说明，无任何真实命令调用。 |
| 固定承诺 `pcount(RUNNING)=1` / fcount 数值 | 无。所有数值出现处均标注“不固定承诺/一次真实样例”。 |
| 误称 lab3 完成 | 无。处处标 lab3 未完成/计划中。 |
| 误称完整文件系统实验完成 | 无。明确“lab4 只是文件表观察 v0.1，不是完整文件系统”。 |
| 误称录屏/队友复现/长期稳定性完成 | 无。三项均标 TODO。 |
| GitLab 为主仓库 | 已说明（README、docs/13）。 |
| external/logs 不提交 | 已说明（README、reproducibility、patches/integrated-labs）。 |
| 真实构建必须走 WSL2 Ubuntu | 已在 docs/13、reproducibility 与 README 快速开始中说明（stage6d 在 README 补强）。 |

本轮一致性修正：README“评委快速查看路径”补入 `docs/20` 与本 `docs/21`，并在快速开始中显式提示 WSL2 构建要求。未对历史记录段的 `0001-0004` 做改写（避免篡改真实历史）。

## 5. 风险列表

| 风险 | 等级 | 说明与现状 |
| --- | --- | --- |
| 队友二次复现 TODO | 高 | 目前所有证据来自单机单人 WSL2，缺少独立第二人复现。诚信上已标 TODO，但对初赛说服力是最大短板。 |
| 人工交互录屏 TODO | 高 | 只有 timeout 自动捕获，无人工 shell 交互录屏。 |
| timeout 自动捕获 ≠ 长期稳定 | 中 | 证据是单次短时捕获，不代表长期稳定性或压力测试。 |
| `/mnt/d` mtime skew | 中 | NTFS over WSL 偶发“未来时间”mtime，使首个 `make qemu` 误判重建、首次 boot 可能超时。已用 `boot-xv6.sh` 45s×2 重试缓解；可先单独 `make` 再 boot。 |
| `riscv64-unknown-elf-gcc` 缺失 | 低 | 构建实际使用 `riscv64-linux-gnu-gcc`，bare-metal 工具链缺失只是 WARN，不影响当前构建；换环境需复查。 |
| GitHub 非主仓库 | 低 | GitHub 仅私有备份，最终提交以官方 GitLab 为准；已在文档明确，勿误提交到 GitHub 当作正式提交。 |
| lab3 未完成 | 中 | 内存/页表实验未做；初赛覆盖面停留在 lab0/1/2/4。 |
| lab4 非完整文件系统 | 中 | 仅 `fcount` 文件表计数观察，不含 inode/磁盘布局/fd 表查询。 |
| `pause` 命名依赖 baseline | 低 | 本 baseline 把 `sleep` 改名 `pause`，`pchildtest` 依赖之；仅在固定 baseline commit 下保证可编译（已锁定并文档化）。 |

## 6. 初赛提交前必须补齐事项（must-have）

1. **核对官方提交格式**：确认 GitLab 主仓库为最终提交载体，按官方要求整理 `submissions/` 实际材料（当前仅索引草稿）。
2. **commit 与 tag**：形成一次干净 commit，把各文档中的 `TODO after commit` 替换为真实 commit hash，并按官方要求打 tag。
3. **至少一次第二人复现**：让第二名队员在另一台机器用 helper 跑通 `0001-0005` 并留下真实证据（哪怕一次）。
4. **至少一段人工交互录屏**：录制 boot + 6 个命令（含 `fcounttest`）的人工 shell 交互，遵守 demo_script 的隐私边界。
5. **复核隐私与第三方**：确认未提交报名材料、隐私、`external/xv6-riscv/`、`logs/*.log`。

## 7. 冲奖增强建议（nice-to-have）

- 推进 **lab3 内存/页表观察**（如 `vmprint` 风格的页表观察或缺页统计），补齐 OS 核心四大块覆盖。
- 深化 **lab4 v0.2**：inode 观察、`fdinfo(pid, fd)`、按 `FD_PIPE/FD_INODE/FD_DEVICE` 统计打开类型。
- 增加 **负向/错误路径实验集**（故意缺锁、错 syscall 号、缺 `usys.pl` entry），强化教学型赛题的“可教学性”。
- 形成 **一键评测脚本**（apply→make→boot→全部命令→汇总 PASS/FAIL），降低评委复现成本。
- 为 lab1/lab2/lab4 各补 **学生练习题 + 参考答案**，体现实验体系而非单点功能。

## 8. 评委快速复现路径

在 WSL2 Ubuntu 中，从仓库根目录：

```bash
bash scripts/check-env.sh
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

预期：boot 捕获 `xv6 kernel is booting` + `init: starting sh`；各命令捕获对应前缀。`pcount(RUNNING)` 与 `fcount(...)` 的具体数字随环境/时序变化，只验证稳定前缀。若首次 boot 超时，重试一次或 `XV6_BOOT_TIMEOUT_SECONDS=60`。

## 9. 下一步行动清单

- [ ] 官方 GitLab 提交格式核对 + 整理 `submissions/` 实际材料。
- [ ] 干净 commit + 替换 `TODO after commit` + 打 tag。
- [ ] 第二名队员独立复现一次并留证。
- [ ] 录制一段人工交互 demo（boot + 6 命令）。
- [ ] （冲奖）推进 lab3 或 lab4 v0.2。
- [ ] （冲奖）一键评测脚本 + 学生练习题。

## 边界

- 本报告的全部 PASS 仅代表 timeout 自动捕获到关键文本，**不代表**长期稳定性测试、人工交互录屏或第二名队员独立复现。
- 未新增任何 OS 功能，未修改 integrated patches。
- `external/xv6-riscv/` 与 `logs/*.log` 不提交。
