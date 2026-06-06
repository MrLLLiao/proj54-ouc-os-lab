# 复现包 README

本目录用于整理 lab0-lab2 当前工程闭环的复现流程。复现目标是让队友或评委从清晰步骤开始，验证环境、baseline、patch、build、boot evidence、hello/add2 输出和 pstate 输出。

当前状态：

- 队长 / agent 本地复现已完成。
- stage2b clean baseline hello patch review 已完成，见 `docs/12_lab1_patch_review.md`。
- stage3a add2 argint extension review 已完成，见 `docs/14_lab1_argint_extension_review.md`。
- stage4a lab2 pstate process observation review 已完成，见 `docs/15_lab2_process_observation_review.md`。
- stage4c integrated-labs 综合 patch sequence 已完成，见 `patches/integrated-labs/README.md`。
- stage5a lab2 v0.2 已新增 integrated `0004`，包含 `pcount(int state)`、`pcounttest` 和 `pchildtest`，见 `docs/19_lab2_v0.2_process_observation_review.md`。
- stage7a0 已加固 QEMU timeout/cleanup，队友卡住排查见 `docs/22_teammate_reproduction_troubleshooting.md`。
- stage7a2 已优化队友一键复现脚本，见 `scripts/xv6/doctor.sh`、`scripts/xv6/teammate-verify.sh --full/--quick`、`scripts/xv6/local-verify.sh` 和 `docs/23_teammate_quickstart.md`。
- 第二名队员独立复现：TODO。

## 复现目标

1. 检查本机环境。
2. 获取 xv6-riscv baseline。
3. 复现 lab1 patch sequence：`0001` 后 `0002`。
4. 复现 lab2 独立 patch：`patches/lab2-process-observation/0001-add-pstate-syscall.patch`。
5. 运行 `make`。
6. 捕获 boot evidence。
7. 捕获 `hello syscall returned 2026`。
8. 捕获 `add2(20, 6) returned 26`。
9. 捕获 `pstate(self) = 4 (RUNNING)`。
10. 复现 integrated-labs，确认 hello、add2test、pstatetest、pcounttest、pchildtest、fcounttest 可在同一 xv6 构建中运行。
11. 如失败，记录真实失败原因，不伪造成功。

## 复现前提

推荐环境：

- WSL2 Ubuntu 24.04 或 Linux。
- `git`
- `bash`
- `make`
- `qemu-system-riscv64`
- `riscv64-linux-gnu-gcc`

当前环境中 `riscv64-unknown-elf-gcc` 为 WARN，但 `riscv64-linux-gnu-gcc` 已可完成当前 xv6 构建。复现时应记录自己的工具链状态。

## 复现路径 A：lab1

```bash
bash scripts/check-env.sh
bash scripts/xv6/fetch-xv6.sh --run
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab1-system-call/0001-add-hello-syscall.patch
git apply ../../patches/lab1-system-call/0002-add-argint-add2-syscall.patch
make
cd ../..
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
```

## 复现路径 B：lab2

lab2 patch 独立于 lab1 patch，应从 clean baseline 直接应用：

```bash
bash scripts/check-env.sh
bash scripts/xv6/fetch-xv6.sh --run
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab2-process-observation/0001-add-pstate-syscall.patch
make
cd ../..
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

说明：

- lab1 和 lab2 当前是两组独立 patch，不建议直接混合应用。
- `external/xv6-riscv/` 被 Git 忽略，不提交第三方源码。
- `boot-xv6.sh` 和 `run-xv6-command.sh` 使用 timeout 捕获证据，不代表长期稳定性或人工录屏。

## 复现路径 C：integrated-labs 综合演示

该路径用于最终综合演示。它从 clean baseline 顺序应用 integrated `0001`、`0002`、`0003`、`0004`，统一 syscall 号为 `hello=22/add2=23/pstate=24/pcount=25`。

队友优先使用一键脚本：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

第一次正式复现使用 `--full`，会自动执行 doctor、环境检查、baseline 检查、apply+make、boot 和全部用户程序验证，并把 `COPY THIS SUMMARY TO TEAM LEAD` summary 写入 ignored 的 `logs/teammate-verify-*.summary.txt`。

如果已经看到 `[OK] make completed successfully`，二次重测使用：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

队长录屏前本地预检使用：

```bash
bash scripts/xv6/local-verify.sh --quick
```

如果需要手动分步复现，再使用下面命令。

```bash
bash scripts/check-env.sh
bash scripts/xv6/fetch-xv6.sh --run
bash scripts/xv6/apply-integrated-labs.sh
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

`apply-integrated-labs.sh` 默认预览，不修改 `external/xv6-riscv/`。`--make --yes` 会 reset/clean ignored 的 `external/xv6-riscv/` 并应用 integrated patch sequence，然后运行 `make`。安全提示（stage4f 加固）：`--run`/`--make` **始终要求 `--yes`** 才执行 reset/clean，否则拒绝并退出；安全审查见 [../docs/18_integrated_helper_review.md](../docs/18_integrated_helper_review.md)。当前真实验证状态：helper 预览安全；`--make --yes` 成功；boot evidence、hello、add2test、pstatetest、pcounttest、pchildtest、fcounttest 均已通过。原始日志不提交。

说明：子进程观察程序实际命令名为 `pchildtest`。原计划名 `pstatechildtest` 因 xv6 `DIRSIZ` 文件名限制导致真实 `mkfs` 失败，已改为短命名并记录。

## 人工复现方式

重要：lab1 与 lab2 **independent patch** 不能直接共存于同一个 xv6 构建（`SYS_hello` 与 `SYS_pstate` 都用 22，且 hunk 冲突，已实测，见 [../docs/16_patch_strategy_and_integration_plan.md](../docs/16_patch_strategy_and_integration_plan.md)）。如果要单独复现实验，应按路径 A/B 分两次从 clean baseline 构建；如果要综合演示，应使用路径 C 的 integrated-labs。

- 路径 A 的构建（lab1）：进入 xv6 shell 后运行 `hello`、`add2test`，预期：

  ```text
  hello syscall returned 2026
  add2(20, 6) returned 26
  ```

- 路径 B 的构建（lab2）：进入 xv6 shell 后运行 `pstatetest`，预期：

  ```text
  pstate(self) = 4 (RUNNING)
  ```

  如果 `pstate(self)` 在其他环境中返回有效但不同的状态，应如实记录，不得伪造成 `RUNNING`。

手动退出 QEMU：

```text
Ctrl-a
x
```

integrated-labs 的人工演示预期是在同一个 xv6 shell 中依次运行：

```text
hello
add2test
pstatetest
pcounttest
pchildtest
```

预期输出：

```text
hello syscall returned 2026
add2(20, 6) returned 26
pstate(self) = 4 (RUNNING)
pcount(RUNNING) = <n>
pcount(99) = -1
pstate(child) = <state> (<STATE_NAME>)
```

其中 `<n>` 和 child state 受运行时状态与调度时序影响，不固定承诺。

当前人工交互录屏仍为 TODO。

## 复现记录模板

| 字段 | 内容 |
| --- | --- |
| 复现人 | TODO |
| 日期 | TODO |
| 机器环境 | TODO |
| WSL/Linux 版本 | TODO |
| 工具链状态 | TODO |
| 复现实验 | TODO: lab1 / lab2 |
| 是否使用 integrated-labs | TODO |
| patch sequence | TODO |
| 执行命令 | TODO |
| 输出结果 | TODO |
| 失败原因 | TODO，如未失败写“无” |
| 是否提交给队长核验 | TODO |
| 备注 | TODO |

## 禁止事项

- 不伪造成功。
- 不提交 `external/xv6-riscv/`。
- 不提交 `logs/*.log`。
- 不上传报名材料、个人隐私、账号密码、token、截图原件或大型二进制文件。
- 不把自动 timeout 捕获写成人工录屏或长期稳定性测试。

## 后续 TODO

- TODO: 第二名队员在另一台机器独立复现 lab1/lab2。
- TODO: 失败时补充 FAQ 和 issue 记录。
- TODO: 第二名队员独立复现 integrated-labs `0001-0005`。

## stage6a 更新：lab4 与 integrated 0001-0005

当前 integrated-labs 已扩展到 `0001-0005`，新增 lab4 文件表观察实验：

- `0005-add-file-table-observation.patch`
- `fcount()` syscall
- `fcounttest` 用户程序

推荐综合复现命令：

```bash
bash scripts/xv6/apply-integrated-labs.sh
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

如需单独复现 lab4 independent patch：

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab4-file-table-observation/0001-add-fcount-syscall.patch
make
cd ../..
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

`fcount(...)` 的具体数字不固定；复现记录应写实际观察值，不得为了匹配文档而修改输出或伪造固定数字。

## stage6c 更新：boot evidence retry

`scripts/xv6/boot-xv6.sh` 已加固：

- 默认 timeout：45 秒/次。
- 默认 hard timeout：`max(timeout + 15, 75)` 秒/次，可用 `XV6_BOOT_HARD_TIMEOUT_SECONDS` 覆盖。
- 默认 attempts：2 次。
- 日志格式：`logs/xv6-boot-YYYYMMDD-HHMMSS-attemptN.log`。
- 退出、中断或 `Ctrl+Z/SIGTSTP` 时尝试清理当前项目相关 QEMU/make。
- 支持环境变量覆盖：

```bash
XV6_BOOT_TIMEOUT_SECONDS=60 XV6_BOOT_RETRIES=2 XV6_BOOT_HARD_TIMEOUT_SECONDS=90 bash scripts/xv6/boot-xv6.sh
```

建议复现时优先使用默认命令：

```bash
bash scripts/xv6/boot-xv6.sh
```

如果 clean build 后首次 boot 因 `fs.img` 补建或 mtime skew 超时，脚本会自动重试。若所有尝试仍未检测到 `xv6 kernel is booting` 和 `init: starting sh`，必须记录真实失败原因，不得写成成功。

## stage7a0 更新：队友卡住排查

`scripts/xv6/boot-xv6.sh` 和 `scripts/xv6/run-xv6-command.sh` 都已增加外层硬 timeout、trap cleanup 和失败日志路径提示。`run-xv6-command.sh` 默认 `XV6_COMMAND_TIMEOUT_SECONDS=60`、`XV6_COMMAND_RETRIES=2`，hard timeout 默认为 `max(timeout + 15, 75)` 秒，也可显式覆盖：

```bash
XV6_COMMAND_TIMEOUT_SECONDS=75 XV6_COMMAND_RETRIES=2 XV6_COMMAND_HARD_TIMEOUT_SECONDS=90 bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

队友复现时如果卡在 `[STEP] attempt 1/2`，先看脚本输出的 `log path`，再按 `docs/22_teammate_reproduction_troubleshooting.md` 清理残留进程。看到 `apply-integrated-labs.sh --make --yes` 输出 `[OK] make completed successfully` 后就说明 apply+make 已完成，不要继续等待该命令。

## stage7a1 更新：一键验证 workflow

新增脚本：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

它会自动运行：

- `bash scripts/check-env.sh`
- `bash scripts/xv6/check-xv6-baseline.sh`
- `bash scripts/xv6/apply-integrated-labs.sh --make --yes`
- `bash scripts/xv6/boot-xv6.sh`
- hello / add2test / pstatetest / pcounttest / pchildtest / fcounttest 输出验证

每一步都会记录 PASS/FAIL。关键失败会停止后续 QEMU 测试，但仍输出 summary。summary 同时写入 ignored 文件：

```text
logs/teammate-verify-YYYYMMDD-HHMMSS.summary.txt
```

如果失败或卡住，运行：

```bash
bash scripts/xv6/cleanup-qemu.sh
```

`apply-integrated-labs.sh --make --yes` 的 make 阶段现在也有 timeout：默认 `XV6_MAKE_TIMEOUT_SECONDS=600`，可按需覆盖。队友大白话说明见 `docs/23_teammate_quickstart.md`。

## stage7a2 更新：doctor / full / quick / local verify

新增只读环境诊断：

```bash
bash scripts/xv6/doctor.sh
```

它不运行 make/QEMU，不修改仓库；会检查当前时间、路径、uname、commit、Git 仓库、关键工具、baseline 文件、logs ignored 状态、QEMU 残留进程和 `/mnt/` 路径风险。结论为 `READY`、`READY WITH WARNINGS` 或 `NOT READY`。

队友正式测试：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

已经 make 成功后的重测：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

队长录屏前本地预检：

```bash
bash scripts/xv6/local-verify.sh --quick
```

卡住或误按 `Ctrl+Z` 后：

```bash
bash scripts/xv6/cleanup-qemu.sh
```

`pcount(RUNNING)`、`fcount(...)` 的具体数字不固定；`pchildtest` 状态受调度时序影响。复现只看脚本匹配到的稳定输出前缀和 summary，不伪造固定数字。
