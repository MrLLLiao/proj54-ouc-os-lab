# 复现包 README

本目录用于整理 lab0-lab2 当前工程闭环的复现流程。复现目标是让队友或评委从清晰步骤开始，验证环境、baseline、patch、build、boot evidence、hello/add2 输出和 pstate 输出。

当前状态：

- 队长 / agent 本地复现已完成。
- stage2b clean baseline hello patch review 已完成，见 `docs/12_lab1_patch_review.md`。
- stage3a add2 argint extension review 已完成，见 `docs/14_lab1_argint_extension_review.md`。
- stage4a lab2 pstate process observation review 已完成，见 `docs/15_lab2_process_observation_review.md`。
- stage4c integrated-labs 综合 patch sequence 已完成，见 `patches/integrated-labs/README.md`。
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
10. 复现 integrated-labs，确认三个用户程序可在同一 xv6 构建中运行。
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

该路径用于最终综合演示。它从 clean baseline 顺序应用 integrated `0001`、`0002`、`0003`，统一 syscall 号为 `hello=22/add2=23/pstate=24`。

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
```

`apply-integrated-labs.sh` 默认预览，不修改 `external/xv6-riscv/`。`--make --yes` 会 reset/clean ignored 的 `external/xv6-riscv/` 并应用 integrated patch sequence，然后运行 `make`。安全提示（stage4f 加固）：`--run`/`--make` **始终要求 `--yes`** 才执行 reset/clean，否则拒绝并退出；安全审查见 [../docs/18_integrated_helper_review.md](../docs/18_integrated_helper_review.md)。当前真实验证状态：helper 预览安全；`--make --yes` 成功；boot evidence、hello、add2test、pstatetest 均已通过。原始日志不提交。

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
```

预期输出：

```text
hello syscall returned 2026
add2(20, 6) returned 26
pstate(self) = 4 (RUNNING)
```

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
- TODO: 第二名队员独立复现 integrated-labs。
