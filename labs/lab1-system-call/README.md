# lab1: 最小 hello 系统调用实验

## 实验目标

lab1 通过新增一个最小 `hello()` system call，帮助同学理解 xv6-riscv 中系统调用从用户态进入内核态、再返回用户态的基本路径。

本实验的 syscall 语义保持简单：

- 新增用户态程序 `hello`。
- 新增系统调用 `hello()`。
- 内核实现返回整数 `2026`。
- 用户程序输出：

```text
hello syscall returned 2026
```

该实验重点是路径讲解和可复现 patch，不追求复杂功能。

## baseline 与 patch

| 项目 | 内容 |
| --- | --- |
| baseline | `mit-pdos/xv6-riscv` |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| patch 文件 | `patches/lab1-system-call/0001-add-hello-syscall.patch` |
| patch 说明 | `patches/lab1-system-call/README.md` |

`external/xv6-riscv/` 被 Git 忽略，不提交第三方源码。lab1 的可提交产物是 patch 文件和复现文档。

## 前置知识

- user/kernel 边界
- syscall number
- trap / ecall
- argument passing
- xv6-riscv 基本目录结构

## 实现路径

| 文件 | 作用 |
| --- | --- |
| `kernel/syscall.h` | 分配 `SYS_hello 22`。 |
| `kernel/syscall.c` | 声明 `sys_hello` 并加入 syscall 分发表。 |
| `kernel/sysproc.c` | 实现 `sys_hello()`，返回 `2026`。 |
| `user/user.h` | 声明 `int hello(void);`，供用户程序调用。 |
| `user/usys.pl` | 生成用户态 syscall stub。 |
| `Makefile` | 将 `_hello` 加入 `UPROGS`，打包进 `fs.img`。 |
| `user/hello.c` | 用户态测试程序，调用 `hello()` 并打印返回值。 |

## 调用链

```text
user/hello.c
  -> user/user.h 中的 hello() 声明
  -> user/usys.pl 生成的用户态 stub
  -> ecall / trap 进入内核
  -> kernel/syscall.c 中的 syscall() dispatcher
  -> kernel/sysproc.c 中的 sys_hello()
  -> 返回值通过 a0 回到用户态
```

## 应用 patch

从 clean baseline 开始：

```bash
cd external/xv6-riscv
git status --short
git apply ../../patches/lab1-system-call/0001-add-hello-syscall.patch
```

如果 baseline commit 不一致，必须先记录差异，再决定是否重新生成 patch。不要把 patch 应用到未知状态的 xv6 tree 后直接声称复现成功。

## 测试方式

构建：

```bash
bash scripts/xv6/check-xv6-baseline.sh --make
```

捕获 boot evidence：

```bash
bash scripts/xv6/boot-xv6.sh
```

自动捕获 `hello` 输出：

```bash
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
```

人工运行方式：

```bash
cd external/xv6-riscv
make qemu
```

进入 xv6 shell 后运行：

```text
hello
```

手动退出 QEMU：`Ctrl-a` 后按 `x`。

## 当前真实验证结果

| 项目 | 状态 | 证据 |
| --- | --- | --- |
| baseline make | PASS | `logs/xv6-make-20260603-235003.log` |
| baseline boot evidence | PASS | `logs/xv6-boot-20260604-001736.log` |
| lab1 patched make | PASS | `logs/xv6-make-20260604-001927.log` |
| hello 输出 | PASS | `logs/xv6-command-hello-20260604-002147.log` |
| 长期稳定性测试 | TODO | 未执行 |
| 人工交互测试 | TODO | 未执行 |
| 第二名队员复核 | TODO | 未执行 |

原始日志被 Git 忽略。正式摘要记录在 `docs/04_test_report.md`。

## 常见错误

| 问题 | 可能原因 | 处理方式 |
| --- | --- | --- |
| syscall number 冲突 | `SYS_hello` 使用了已有编号 | 修改前检查 `kernel/syscall.h`。 |
| 用户态声明遗漏 | `user/user.h` 未声明 `hello()` | 增加 `int hello(void);`。 |
| 用户态 stub 缺失 | `user/usys.pl` 未增加 `entry("hello")` | 增加 entry 后重新构建。 |
| syscall 分发表遗漏 | `kernel/syscall.c` 未注册 `sys_hello` | 增加 extern 声明和分发表项。 |
| xv6 shell 中找不到 `hello` | `Makefile` 未加入 `_hello` | 将 `$U/_hello\` 加入 `UPROGS`。 |
| patch 无法应用 | baseline commit 或工作区状态不一致 | 检查 baseline commit，并从 clean tree 重新应用。 |
