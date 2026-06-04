# lab2 测试记录

## 测试目标

lab2 测试用于验证 `pstate(int pid)` syscall 是否能完成以下闭环：

1. 从 clean baseline 应用 lab2 patch。
2. 构建 xv6。
3. 在 xv6 中运行 `pstatetest`。
4. 捕获 `pstate(self) =` 输出。
5. 捕获实际状态文本 `RUNNING`。

## 已真实执行命令

| 目的 | 命令 | 结果 |
| --- | --- | --- |
| clean baseline apply | `git apply ../../patches/lab2-process-observation/0001-add-pstate-syscall.patch` | PASS |
| 构建 patched xv6 | `cd external/xv6-riscv && make` | PASS |
| 捕获 pstatetest 前缀 | `bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="` | PASS |
| 捕获 RUNNING | `bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"` | PASS |

## 证据摘要

| 证据 | 状态 | 说明 |
| --- | --- | --- |
| patch apply | PASS | lab2 patch 独立应用到 baseline commit |
| make | PASS | 仍有已知 linker RWX warning |
| pstatetest output | PASS | 实际观察到 `pstate(self) = 4 (RUNNING)` |

原始日志被 Git 忽略，不应提交。

## 尚未覆盖

- TODO: 长期 QEMU 稳定性测试。
- TODO: 人工交互 shell 测试与录屏。
- TODO: 第二名队员独立复现。
- TODO: 负向测试，例如错误 pid、锁遗漏、syscall number 冲突。
- TODO: 与 lab1 patch 合并后的 syscall number 规划。

## 与测试报告的关系

正式摘要记录在 `docs/04_test_report.md`。lab2 复现审查见 `docs/15_lab2_process_observation_review.md`。本文件保留 lab2 专项测试说明，不复制完整日志。
