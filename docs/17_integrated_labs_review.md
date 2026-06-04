# integrated-labs 综合 patch 序列复现审查

本文件是 stage4d 红队对 `patches/integrated-labs/` 综合 patch 序列的真实复现审查，目标是确认它**真正解决了** stage4b 发现的 lab1/lab2 独立 patch 冲突，使 `hello` / `add2test` / `pstatetest` 能在**同一个 xv6 构建**中运行。

- 阶段：stage4d
- 日期：2026-06-04
- 角色：严格评委 + OS 实验助教 + 工程红队
- baseline commit：`74f84181a3404d1d6a6ff98d342233979066ebb8`
- 重要声明：本报告结论来自真实命令输出；第三方源码与原始日志默认不提交；人工录屏、长期稳定性测试、第二名队员复现仍为 TODO。

## 1. 总体结论

**通过。integrated-labs 真正解决了综合演示问题。**

- 三个 patch 从 clean baseline 顺序应用成功（每个 `git apply --check` 均 exit 0）。
- clean `make` 成功；同一构建里同时存在 `hello`、`add2test`、`pstatetest` 三个用户程序。
- syscall 号重排为 `hello=22 / add2=23 / pstate=24`，**消除了** stage4b 的 22 撞号。
- 同一 xv6 构建中分别捕获到 `hello syscall returned 2026`、`add2(20, 6) returned 26`、`pstate(self) = 4 (RUNNING)`。
- 红队额外核对：integrated `0001`/`0002` 与 lab1 的 `0001`/`0002` **字节一致**，`0003` 的 `pstatetest.c` 与 lab2 的相同——综合序列**没有改动用户程序，只重排了 pstate 的 syscall 号并 rebase 到 `0002` 之后**，原 independent patch 未被改动。

## 2. integrated patch sequence 文件列表

| patch | 基线 | 新增/修改 | syscall 号 | 新增用户程序 |
| --- | --- | --- | --- | --- |
| `0001-add-hello-syscall.patch` | clean baseline | Makefile、syscall.c/.h、sysproc.c、user.h、usys.pl | `SYS_hello 22` | `user/hello.c` |
| `0002-add-argint-add2-syscall.patch` | integrated `0001` 之后 | 同上六处增量 | `SYS_add2 23` | `user/add2test.c` |
| `0003-add-pstate-syscall.patch` | integrated `0001`+`0002` 之后 | 同上六处增量 + `extern struct proc proc[NPROC];` | `SYS_pstate 24` | `user/pstatetest.c` |

red-team 核对（blob 链）：`0003` 的基线 blob（`c0a01a0/8424e97/b69fc0a/8ac20d9/4649e0c/8d7b68e`）正是 `0002` 的输出 blob，证明 `0003` 是 `0001`+`0002` 之上的干净增量，必须按序应用，无重叠。patch 中无 build artifact、日志、个人路径或临时文件。

## 3. syscall number table

| syscall | number | 用户程序 | 与独立 patch 的差异 |
| --- | --- | --- | --- |
| `hello` | 22 | `hello` | 与 lab1 一致 |
| `add2` | 23 | `add2test` | 与 lab1 一致 |
| `pstate` | **24** | `pstatetest` | lab2 独立 patch 用 22，本序列改为 **24** 以避开 `hello` 的 22 |

## 4. clean baseline apply 验证步骤（真实执行）

在 WSL2 Ubuntu、被忽略的 `external/xv6-riscv/` 中执行（主仓库不受影响）：

```bash
git -C external/xv6-riscv reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git -C external/xv6-riscv clean -fdx
( cd external/xv6-riscv && git apply --check ../../patches/integrated-labs/0001-add-hello-syscall.patch && git apply ../../patches/integrated-labs/0001-add-hello-syscall.patch )
( cd external/xv6-riscv && git apply --check ../../patches/integrated-labs/0002-add-argint-add2-syscall.patch && git apply ../../patches/integrated-labs/0002-add-argint-add2-syscall.patch )
( cd external/xv6-riscv && git apply --check ../../patches/integrated-labs/0003-add-pstate-syscall.patch && git apply ../../patches/integrated-labs/0003-add-pstate-syscall.patch )
```

| 步骤 | 结果 |
| --- | --- |
| clean baseline 校验 | CLEAN（HEAD = `74f8418`） |
| `0001` `--check` / apply | exit 0 / exit 0 |
| `0002` `--check` / apply | exit 0 / exit 0 |
| `0003` `--check` / apply | exit 0 / exit 0 |
| 合并文件集 | `M Makefile/syscall.c/syscall.h/sysproc.c/user.h/usys.pl` + `?? user/hello.c` + `?? user/add2test.c` + `?? user/pstatetest.c` |
| `syscall.h` 尾部 | `SYS_hello 22`、`SYS_add2 23`、`SYS_pstate 24` |

## 5. make 验证结果（真实执行）

```bash
bash scripts/xv6/check-xv6-baseline.sh --make
```

| 项目 | 结果 |
| --- | --- |
| 命令退出码 | 0（make 成功） |
| 构建方式 | clean 全量构建（先 `git clean -fdx` 后从零编译） |
| compiler / linker | `riscv64-linux-gnu-gcc` / `riscv64-linux-gnu-ld` |
| warning | 仅已知 `LOAD segment with RWX permissions`（非致命） |
| 本次日志（忽略，不提交） | `logs/xv6-make-20260604-160800.log` |

## 6. boot / hello / add2test / pstatetest 验证结果（真实执行，同一构建）

```bash
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

| 检查项 | 结果 |
| --- | --- |
| boot evidence | `BOOT_EVIDENCE_FOUND`（`xv6 kernel is booting` + `init: starting sh`） |
| `hello` | `COMMAND_EVIDENCE_FOUND`：`hello syscall returned 2026` |
| `add2test` | `COMMAND_EVIDENCE_FOUND`：`add2(20, 6) returned 26` |
| `pstatetest` | `COMMAND_EVIDENCE_FOUND`：`pstate(self) = 4 (RUNNING)`（含 `pstate(self) =` 与 `RUNNING`） |

> 关键点：以上三个程序的输出来自**同一个 xv6 构建**，证明综合演示路径成立——这是 lab1/lab2 独立 patch 无法做到的。

## 7. independent patch 与 integrated patch 的关系

| patch 组 | 用途 | 是否替代 |
| --- | --- | --- |
| `patches/lab1-system-call/` | lab1 单独教学/复现（hello=22, add2=23） | 否，保留 |
| `patches/lab2-process-observation/` | lab2 单独教学/复现（pstate=22） | 否，保留 |
| `patches/integrated-labs/` | 综合演示，同一构建（hello=22, add2=23, **pstate=24**） | 否，仅新增综合路径 |

- 两套各有独立的 syscall 号方案，**不可混用**：独立 lab2 用 22，综合序列用 24。
- 独立 patch 仍服务"单 lab 教学"；integrated 仅服务"综合演示"。
- 仍然**不要**把独立 lab2 patch 叠到 lab1 之上（已实测冲突，见 [16_patch_strategy_and_integration_plan.md](16_patch_strategy_and_integration_plan.md)）。

## 8. 为什么最终 Demo 应优先使用 integrated-labs

1. **唯一能在一个 xv6 里同时演示三者**：独立 patch 互相冲突，无法组合；integrated 序列做到了。
2. **号段无冲突**：22/23/24 一次规划清楚，避免临场撞号。
3. **可审计、可复现**：固定 baseline + 有序增量 patch + 自动证据脚本，评委可一键复现整条链。
4. **演示叙事完整**：hello（最小）→ add2（参数）→ pstate（进程观察）在同一 shell 连续展示，体现"渐进实验"。

因此 `videos/demo_script.md`、`reproducibility/README.md` 的最终综合演示应指向 `patches/integrated-labs/`，而单 lab 教学仍指向各自的独立 patch。

## 9. 当前边界

- 证据为 timeout 自动捕获，**不等于长期稳定性测试**。
- 人工交互录屏：TODO。
- 第二名队员独立复现：TODO。
- lab2 仍是 process observation v0.1（只观察单进程，self 近乎恒为 RUNNING；见 [15_lab2_process_observation_review.md](15_lab2_process_observation_review.md)）。
- lab3 / lab4 未完成；整体仍只覆盖 lab0/lab1/lab2。
- `external/xv6-riscv/` 与 `logs/*.log` 不提交（已验证 `git ls-files` 为空）。

## 10. 评委复现路径

```bash
# WSL2 Ubuntu，已装 qemu-system-misc 与 gcc-riscv64-linux-gnu
bash scripts/check-env.sh
bash scripts/xv6/fetch-xv6.sh --run            # 或手动 clone 到 external/xv6-riscv
bash scripts/xv6/apply-integrated-labs.sh      # preview only
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

预期：helper 预览模式不修改 external tree；`--make --yes` reset/clean ignored 的 `external/xv6-riscv/`、顺序应用三个 patch 并完成 `make`；输出中分别出现 `hello syscall returned 2026`、`add2(20, 6) returned 26`、`pstate(self) = 4 (RUNNING)`。

stage4e 真实 helper 验证：

| 检查项 | 结果 |
| --- | --- |
| `bash scripts/xv6/apply-integrated-labs.sh` | exit 0；预览模式只打印状态和将执行操作；未 reset、未 apply、未 make |
| 预览前后 external 状态 | 一致，仍为 integrated 已应用的工作树 |
| `bash scripts/xv6/apply-integrated-labs.sh --make --yes` | exit 0；reset/clean ignored tree，顺序 apply 三个 patch，`make` 成功 |
| make log | `logs/integrated-make-20260604-163022.log`（ignored，不提交） |
| 后续 boot evidence | PASS |
| 后续 hello/add2test/pstatetest | PASS |

## 11. 后续建议

1. 把综合演示统一收口到 integrated-labs：Demo 脚本与复现包的"最终演示"段明确指向路径 C，避免再用独立 patch 拼凑。
2. stage4e 已提供并验证 `scripts/xv6/apply-integrated-labs.sh`（预览/`--run --yes`/`--make --yes`）降低评委复现门槛；stage4f 红队对该脚本做了安全审查并加固（`--run`/`--make` 现在**始终要求 `--yes`** 才执行 reset/clean），详见 [18_integrated_helper_review.md](18_integrated_helper_review.md)；后续继续保持该脚本克制，不自动声明 boot 或用户程序成功。
3. 第二名队员按第 10 节在另一台机器独立复现，并录一段真实人工交互演示（手敲 hello/add2test/pstatetest）。
4. 后续若新增 lab（如 lab3/lab4），同步更新 integrated 序列与号段规划（`0004` 起、号 25+），并复跑本报告第 4-6 节。
5. 统一处理 `user/usys.pl` 的 file mode warning（patch 记录 100755，Windows/WSL 检出 100644），避免集成时反复出现告警。
