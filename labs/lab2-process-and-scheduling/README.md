# Lab2：进程在内核里长什么样

## 这一关学什么

- 用 Lab1 学会的"加 syscall 七件套"，给内核加观察接口：`pstate(int pid)` 看单个进程状态，`pcount(int state)` 数某种状态的进程个数。
- 第一次接触内核数据结构：`struct proc`、`enum procstate`、进程表 `proc[]`。
- 第一次正经面对并发：为什么读 `p->state` 要 `acquire(&p->lock)`，漏 `release` 会怎样。
- 用 `pchildtest` fork 一个子进程去观察它的状态，亲眼看到调度时序不确定——同一程序两次跑出 `RUNNABLE` 和 `SLEEPING` 都是对的。

## 为什么重要

Lab1 的 syscall 只是"传数字进来、传数字出去"；从这一关开始，syscall 真正去读内核状态。进程表是 OS 里最常被问的结构（面试也躲不开），而"读共享数据要拿锁"是你以后写任何内核代码的本能。负向测试（`pcount(99) = -1`）则是第一次练"内核必须不信任用户输入"。

## 和前后 Lab 的关系

- 前置：Lab1（你得知道加 syscall 要改哪 7 个文件）。
- 后继：Lab3 用同样的"观察"思路去看页表；Lab2 的"状态数字不固定、只验证前缀"的纪律在后面每个 lab 都会复用。

实验分两层：v0.1 `pstate(int pid)`；v0.2 加 `pcount(int state)`、子进程观察和负向输入测试。

本实验目标：

- 理解 xv6 的 `struct proc`。
- 理解 `enum procstate`。
- 理解进程表 `proc[]` 的基本遍历方式。
- 理解 syscall 如何从用户态传入 `pid`。
- 理解读取 `p->state` 时为什么需要持有 `p->lock`。
- 使用用户程序 `pstatetest` 观察当前进程状态。
- 使用 `pcounttest` 观察 `RUNNING` 状态计数并验证无效状态输入。
- 使用 `pchildtest` 观察子进程状态，理解调度时序不确定性。

本实验不实现完整 `ps`，不修改调度算法。

## 前置知识

- process
- pid
- `struct proc`
- `enum procstate`
- proc table
- process lock
- syscall 参数传递

## 实验任务

1. 添加 `pstate(int pid)` syscall。
2. 新增用户程序 `pstatetest`。
3. 在 integrated-labs v0.2 中添加 `pcount(int state)` syscall。
4. 新增用户程序 `pcounttest`。
5. 新增用户程序 `pchildtest`，通过 fork 子进程观察 child pid 的状态。
6. 编译 xv6。
7. 在 xv6 中运行 `pstatetest`、`pcounttest`、`pchildtest`。
8. 记录真实输出。

当前预期输出：

```text
pstate(self) = 4 (RUNNING)
pcount(RUNNING) = <n>
pcount(99) = -1
pstate(child) = <state> (<STATE_NAME>)
```

`pcount(RUNNING)` 的数字可能随环境变化，自动验证只匹配前缀。`pstate(child)` 的状态可能是 `RUNNABLE`、`SLEEPING` 等有效状态，受调度时序影响，不固定要求某个值。

## 修改文件说明

| 文件 | 作用 |
| --- | --- |
| `kernel/syscall.h` | 增加 `SYS_pstate 22`。 |
| `kernel/syscall.c` | 声明 `sys_pstate` 并加入 syscall dispatch table。 |
| `kernel/sysproc.c` | 实现 `sys_pstate()`，使用 `argint()` 获取 pid，遍历 `proc[]`。 |
| `user/user.h` | 声明 `int pstate(int);`。 |
| `user/usys.pl` | 增加 `entry("pstate");`。 |
| `Makefile` | 将 `_pstatetest` 加入 `UPROGS`。 |
| `user/pstatetest.c` | 新增用户态测试程序。 |
| `user/pcounttest.c` | integrated v0.2 新增，测试 `pcount(RUNNING)` 和 `pcount(99)`。 |
| `user/pchildtest.c` | integrated v0.2 新增，fork 子进程后观察 child pid 的状态。 |

## 调用链

```text
用户程序 pstatetest
  -> pstate(pid)
  -> user stub
  -> ecall / trap
  -> syscall dispatcher
  -> sys_pstate
  -> proc table lookup
  -> return state
```

## 锁设计说明

`struct proc` 中的 `state` 字段会被调度器、sleep/wakeup、exit/wait 等路径修改。读取 `p->state` 时如果不持有 `p->lock`，可能读到并发修改中的状态，也会违背 xv6 中关于 `p->state` 的锁约定。

本实验中的核心逻辑：

```c
for (p = proc; p < &proc[NPROC]; p++) {
  acquire(&p->lock);
  if (p->pid == pid && p->state != UNUSED) {
    state = p->state;
    release(&p->lock);
    return state;
  }
  release(&p->lock);
}
```

找到目标进程后，在释放锁前保存状态值；所有路径都必须释放锁。

## 测试方式

从 clean baseline 应用 patch：

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab2-process-observation/0001-add-pstate-syscall.patch
make
```

自动捕获输出：

```bash
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
```

人工运行：

```bash
cd external/xv6-riscv
make qemu
```

进入 xv6 shell 后输入：

```text
pstatetest
```

## 当前真实验证结果

| 项目 | 状态 | 说明 |
| --- | --- | --- |
| clean baseline apply | PASS | lab2 patch 可直接应用到 baseline commit |
| `make` | PASS | WSL/bash 下成功，仍有已知 linker RWX warning |
| `pstate(self) =` 捕获 | PASS | `run-xv6-command.sh` 检测到该前缀 |
| `RUNNING` 捕获 | PASS | 实际输出包含 `pstate(self) = 4 (RUNNING)` |
| integrated `0001-0004` apply | PASS | helper 从 clean baseline 顺序应用 |
| `pcount(RUNNING) =` 捕获 | PASS | 实际观察到 `pcount(RUNNING) = 1`，数值不固定承诺 |
| `pcount(99) = -1` 捕获 | PASS | 无效状态负向测试通过 |
| `pstate(child) =` 捕获 | PASS | 实际观察到 `RUNNABLE` 与 `SLEEPING` 都出现过 |
| 长期稳定性测试 | TODO | 未执行 |
| 人工交互录屏 | TODO | 未执行 |
| 第二名队员独立复现 | TODO | 未执行 |

## 自己动手任务

跑通不等于会。打开 [student_tasks.md](student_tasks.md)：必做任务包括解释锁的每条返回路径、设计一个新的状态观察，并有评分 rubric。

## 常见卡点（常见错误）

| 问题 | 可能原因 | 处理方式 |
| --- | --- | --- |
| syscall number 冲突 | `SYS_pstate` 与已有 syscall 编号冲突 | lab2 patch 独立基于 clean baseline，当前使用 22；若与 lab1 合并需重新分配编号。 |
| 没有更新 `usys.pl` | 用户态没有生成 syscall stub | 增加 `entry("pstate");`。 |
| 没有更新 `user.h` | 用户程序找不到 `pstate()` 声明 | 增加 `int pstate(int);`。 |
| `Makefile` 未加入 `_pstatetest` | xv6 shell 中找不到程序 | 将 `$U/_pstatetest\` 加入 `UPROGS`。 |
| 未释放锁 | 找到或未找到目标进程时遗漏 `release(&p->lock)` | 检查所有返回路径。 |
| patch 基线不一致 | patch 应用到 lab1 或其他修改后的 tree | 从指定 baseline commit 开始应用 lab2 patch。 |
| `pstatechildtest` 文件名导致 `mkfs` 失败 | xv6 `DIRSIZ` 限制目录项文件名长度；`_pstatechildtest` 过长 | integrated v0.2 使用较短命令名 `pchildtest`，输出仍是 `pstate(child) = ...`。 |

## 不要误解什么

- 这不是完整 `ps`，也不修改调度算法——只是状态**观察**。
- `pcount(RUNNING)` 的数字不固定，`pstate(child)` 的状态受调度时序影响；实验报告里写"观察到的一次取值"，不要写成"必然等于"。
- lab2 independent patch 用 `SYS_pstate = 22`，和 lab1 independent 的 `SYS_hello = 22` 冲突——independent patch 之间**不可叠加**，这是实测过的（`git apply --check` 直接失败）。组合演示走 integrated `0001-0009`（integrated 里 pstate=24、pcount=25）。
- timeout 自动捕获只证明"那一次跑出了预期文本"，不是长期稳定性测试。

## 下一步看哪里

- 动手：做 [student_tasks.md](student_tasks.md)。
- 继续闯关：[Lab3 页表观察](../lab3-memory-and-pagetable/README.md)——同样是观察，但对象从进程表换成你自己进程的页表。
- 想看 v0.2 的红队审查（锁的逐路径分析、`pstatechildtest` 名字踩的 `DIRSIZ` 坑）：[docs/19_lab2_v0.2_process_observation_review.md](../../docs/19_lab2_v0.2_process_observation_review.md)。
