# lab1 hello syscall patch

## 目标

该 patch 为 xv6-riscv 增加最小 `hello()` system call。系统调用返回整数 `2026`，用户态测试程序输出：

```text
hello syscall returned 2026
```

本 patch 用于 lab1 教学闭环，重点展示 user space 到 kernel space 的 syscall 路径。

## baseline

| 字段 | 内容 |
| --- | --- |
| baseline repo | `https://github.com/mit-pdos/xv6-riscv.git` |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| baseline branch | `riscv` |
| 本地源码路径 | `external/xv6-riscv/` |
| patch 文件 | `patches/lab1-system-call/0001-add-hello-syscall.patch` |

## 修改文件

patch 修改：

- `kernel/syscall.h`
- `kernel/syscall.c`
- `kernel/sysproc.c`
- `user/user.h`
- `user/usys.pl`
- `Makefile`

patch 新增：

- `user/hello.c`

## 应用方式

从 clean xv6-riscv baseline 开始：

```bash
cd external/xv6-riscv
git status --short
git apply ../../patches/lab1-system-call/0001-add-hello-syscall.patch
```

如果 `git status --short` 在应用 patch 前不为空，应先恢复 clean baseline 或重新 clone。不要在未知状态下应用 patch 后声称复现成功。

## 构建方式

```bash
make
```

在本仓库中，实际验证使用：

```bash
bash scripts/xv6/check-xv6-baseline.sh --make
```

## 运行方式

人工运行：

```bash
make qemu
```

进入 xv6 shell 后输入：

```text
hello
```

预期输出：

```text
hello syscall returned 2026
```

本仓库中还使用以下脚本捕获自动化证据：

```bash
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
```

## 当前真实验证状态

| 检查项 | 状态 | 证据 |
| --- | --- | --- |
| baseline make | PASS | `logs/xv6-make-20260603-235003.log` |
| baseline boot evidence | PASS | `logs/xv6-boot-20260604-001736.log` |
| lab1 patched make | PASS | `logs/xv6-make-20260604-001927.log` |
| hello output evidence | PASS | `logs/xv6-command-hello-20260604-002147.log` |
| 长期稳定性测试 | TODO | 未执行 |
| 人工交互 shell 测试 | TODO | 未执行 |
| 第二名队员复核 | TODO | 未执行 |

原始日志被 Git 忽略。可提交记录位于 `docs/04_test_report.md` 和 `tests/lab1/README.md`。
