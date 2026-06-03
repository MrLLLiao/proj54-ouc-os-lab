# lab1 测试记录

## 测试目标

lab1 测试用于验证最小 `hello()` system call patch 是否能完成以下闭环：

1. patch 可应用到指定 xv6-riscv baseline。
2. 修改后的 xv6 可以完成 `make`。
3. QEMU 启动过程中可以捕获 boot evidence。
4. 用户态程序 `hello` 可以输出预期结果。

预期输出：

```text
hello syscall returned 2026
```

## 已真实执行命令

| 目的 | 命令 | 结果 |
| --- | --- | --- |
| 构建 patched xv6 | `bash scripts/xv6/check-xv6-baseline.sh --make` | PASS |
| 捕获 boot evidence | `bash scripts/xv6/boot-xv6.sh` | PASS |
| 自动运行 hello | `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"` | PASS |

## 证据摘要

| 证据 | 状态 | 日志 |
| --- | --- | --- |
| baseline make | PASS | `logs/xv6-make-20260603-235003.log` |
| boot evidence | PASS | `logs/xv6-boot-20260604-001736.log` |
| lab1 patched make | PASS | `logs/xv6-make-20260604-001927.log` |
| hello 输出 | PASS | `logs/xv6-command-hello-20260604-002147.log` |

原始日志被 Git 忽略，不应提交。

## 尚未覆盖

- TODO: 长期 QEMU 稳定性测试。
- TODO: 人工交互 shell 测试。
- TODO: syscall number 冲突、用户态 stub 缺失等负向测试。
- TODO: 由第二名队员进行代码和文档复核。

## 与测试报告的关系

正式摘要记录在 `docs/04_test_report.md`。本文件保留 lab1 专项测试说明，不复制完整日志。
