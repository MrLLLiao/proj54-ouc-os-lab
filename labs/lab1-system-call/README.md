# Lab1：你的第一个系统调用

## 这一关学什么

- 给 xv6 加一个最小系统调用 `hello()`（无参数，返回 `2026`），打通"用户程序 → 内核函数 → 返回值"的完整链路。
- 再加一个带参数的 `add2(int a, int b)`，学会用 `argint()` 在内核里取用户传来的整数。
- 记住加 syscall 必改的 7 个文件：`syscall.h`、`syscall.c`、`sysproc.c`、`user.h`、`usys.pl`、`Makefile`、用户测试程序。后面每个 lab 都在重复这套动作。

## 为什么重要

系统调用是用户程序和内核之间唯一的正门。你以后看到的每个实验（观察进程、数页表、查 fd）本质上都是"再加一个 syscall"——所以这一关把路径走熟，后面就只剩"内核里做什么"的差别。`hello()` 故意做到最小，让你第一次成功来得便宜；`add2()` 引入参数传递，是 Lab3/Lab4 进阶里 `argaddr`/`copyout` 的前置。

## 和前后 Lab 的关系

- 前置：Lab0 已经能 `make` + 启动进 shell。
- 后继：Lab2 用同样的套路加 `pstate`/`pcount`，区别是内核里要遍历进程表、拿锁。
- 当前 lab1 只覆盖 syscall 入门与**整数**参数传递，指针参数（`argaddr`）留到 Lab3/Lab4 进阶。

## baseline 与 patch

| 项目 | 内容 |
| --- | --- |
| baseline repo | `https://github.com/mit-pdos/xv6-riscv.git` |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| minimal patch | `patches/lab1-system-call/0001-add-hello-syscall.patch` |
| advanced patch | `patches/lab1-system-call/0002-add-argint-add2-syscall.patch` |
| 应用顺序 | 先 `0001`，再 `0002` |

`external/xv6-riscv/` 被 Git 忽略，不提交第三方源码。lab1 的可提交产物是 patch、文档和测试摘要。

## 前置知识

- user/kernel 边界
- syscall number
- trap / ecall
- syscall dispatch table
- 用户态参数寄存器
- `argint()` 的作用

## minimal: hello()

语义：

```c
int hello(void);
```

预期输出：

```text
hello syscall returned 2026
```

涉及文件：

| 文件 | 作用 |
| --- | --- |
| `kernel/syscall.h` | 分配 `SYS_hello 22`。 |
| `kernel/syscall.c` | 声明并注册 `sys_hello`。 |
| `kernel/sysproc.c` | 实现 `sys_hello()`，返回 `2026`。 |
| `user/user.h` | 声明 `int hello(void);`。 |
| `user/usys.pl` | 增加 `entry("hello")`。 |
| `Makefile` | 将 `_hello` 加入 `UPROGS`。 |
| `user/hello.c` | 用户态测试程序。 |

## advanced: add2(int a, int b)

语义：

```c
int add2(int a, int b);
```

用户程序调用：

```c
add2(20, 6);
```

预期输出：

```text
add2(20, 6) returned 26
```

涉及文件：

| 文件 | 作用 |
| --- | --- |
| `kernel/syscall.h` | 分配 `SYS_add2 23`，不与 `SYS_hello 22` 冲突。 |
| `kernel/syscall.c` | 声明 `sys_add2` 并加入 syscall dispatch table。 |
| `kernel/sysproc.c` | 实现 `sys_add2()`，使用 `argint(0, &a)` 和 `argint(1, &b)` 获取参数。 |
| `user/user.h` | 声明 `int add2(int, int);`。 |
| `user/usys.pl` | 增加 `entry("add2")`。 |
| `Makefile` | 将 `_add2test` 加入 `UPROGS`。 |
| `user/add2test.c` | 用户态测试程序，打印 `add2(20, 6) returned 26`。 |

## argint() 说明

在 xv6-riscv 中，用户态 syscall 参数会按调用约定放入寄存器。用户态 stub 执行 `ecall` 后进入内核，内核可以通过 `argint(n, &value)` 读取第 `n` 个 32-bit 整数参数。

`add2()` 的参数路径：

```text
user/add2test.c
  -> add2(20, 6)
  -> user/usys.pl 生成的 add2 stub
  -> ecall / trap 进入 kernel
  -> syscall() 根据 a7 中的 SYS_add2 分发
  -> sys_add2()
  -> argint(0, &a) 读取第一个参数 20
  -> argint(1, &b) 读取第二个参数 6
  -> return a + b
  -> 返回值通过 a0 回到用户态
```

## 应用 patch

从 clean baseline 开始：

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab1-system-call/0001-add-hello-syscall.patch
git apply ../../patches/lab1-system-call/0002-add-argint-add2-syscall.patch
```

## 测试方式

构建：

```bash
cd external/xv6-riscv
make
```

捕获 boot evidence：

```bash
bash scripts/xv6/boot-xv6.sh
```

捕获 hello 输出：

```bash
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
```

捕获 add2 输出：

```bash
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
```

## 当前真实验证结果

| 项目 | 状态 | 说明 |
| --- | --- | --- |
| clean baseline + `0001` + `0002` apply | PASS | 已从 baseline commit 重新应用两个 patch |
| `make` | PASS | WSL/bash 下成功；仍有已知 linker RWX warning |
| hello 输出 | PASS | 捕获到 `hello syscall returned 2026` |
| add2test 输出 | PASS | 捕获到 `add2(20, 6) returned 26` |
| 长期稳定性测试 | TODO | 未执行 |
| 人工交互录屏 | TODO | 未执行 |
| 第二名队员独立复现 | TODO | 未执行 |

原始日志被 Git 忽略。正式摘要记录在 `docs/04_test_report.md` 和 `docs/14_lab1_argint_extension_review.md`。

## 自己动手任务

照着教程跑通不算完成。打开 [student_tasks.md](student_tasks.md)：必做任务是自己实现一个新 syscall（不是抄 `hello`/`add2`），那里有验收标准、提交内容和评分 rubric。

## 常见卡点（常见错误）

下面这张表不是凭空列的：开发记录里真实出现过"在 Windows PowerShell 里跑 `make` 直接失败"和"手写 patch 格式损坏导致 apply 不上"这类事故（见 `docs/06_progress_log.md` 的 stage3a 条目），所以第一次卡住很正常，按表排查就行。

| 问题 | 可能原因 | 处理方式 |
| --- | --- | --- |
| syscall number 冲突 | `SYS_add2` 使用了已有编号 | 检查 `kernel/syscall.h`，当前 `hello=22`，`add2=23`。 |
| 用户态声明遗漏 | `user/user.h` 未声明 `add2()` | 增加 `int add2(int, int);`。 |
| 用户态 stub 缺失 | `user/usys.pl` 未增加 `entry("add2")` | 增加 entry 后重新构建。 |
| 参数错误 | `sys_add2()` 未使用正确参数序号 | 使用 `argint(0, &a)` 和 `argint(1, &b)`。 |
| xv6 shell 找不到 `add2test` | `Makefile` 未加入 `_add2test` | 将 `$U/_add2test\` 加入 `UPROGS`。 |
| patch 无法应用 | 未先应用 `0001` 或 baseline 不一致 | 从指定 baseline 开始，按 `0001` 后 `0002` 顺序应用。 |

## 不要误解什么

- lab1 只覆盖 syscall 入门与**整数参数**传递，**未覆盖**指针参数（`argaddr`）、字符串参数（`argstr`）、参数校验语义——这些在 Lab3/Lab4 进阶（`memstat`/`fdinfo`）里才出现。
- 不要把 lab1 表述为"已覆盖全部 syscall 机制"。
- `hello()` 返回固定值 `2026` 是刻意设计（让验证文本稳定），不代表 syscall 都该返回常量。
- 注意编号：independent patch 里 `SYS_hello = 22`；integrated 序列里 hello 也是 22，但 lab2/lab3/lab4 的 independent patch 各自也用 22——所以 independent patch 互相**不可叠加**，组合演示必须走 integrated `0001-0009`（编号 22-30 连续分配）。

## 下一步看哪里

- 动手：做 [student_tasks.md](student_tasks.md) 的必做任务。
- 继续闯关：[Lab2 进程状态观察](../lab2-process-and-scheduling/README.md)，同样的 7 文件套路，但内核侧要遍历 `proc[]` 并拿锁。
- 想看教学价值评估和踩坑记录：[docs/14_lab1_argint_extension_review.md](../../docs/14_lab1_argint_extension_review.md)。
