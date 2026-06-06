# 04 Lab2 Process Observation

## 实验目标

通过 `pstate(int pid)`、`pcount(int state)` 和 `pchildtest`，让学生从 syscall 参数传递进一步理解 xv6 的进程表、状态枚举、锁和调度时序不确定性。

## 前置知识

- `struct proc`。
- `enum procstate`。
- `proc[]` 进程表。
- pid 与进程生命周期。
- `p->lock`。
- `fork()`、`pause()`、调度时序。

## 涉及文件

| 文件 | 作用 |
| --- | --- |
| `kernel/syscall.h` | 分配 `SYS_pstate`、`SYS_pcount` |
| `kernel/syscall.c` | 注册 syscall |
| `kernel/sysproc.c` | 实现 `sys_pstate()`、`sys_pcount()` |
| `user/user.h` | 声明用户态接口 |
| `user/usys.pl` | 生成 stub |
| `Makefile` | 加入 `_pstatetest`、`_pcounttest`、`_pchildtest` |
| `user/pstatetest.c` | 观察当前进程状态 |
| `user/pcounttest.c` | 统计状态数量并测试无效输入 |
| `user/pchildtest.c` | 观察子进程状态 |
| `patches/lab2-process-observation/` | independent pstate patch |
| `patches/integrated-labs/0003-0004` | integrated process observation patch |

## 实现步骤

1. 新增 `pstate(int pid)` syscall。
2. 在内核中遍历 `proc[]`，查找 pid。
3. 读取 `p->state` 前持有 `p->lock`。
4. 新增 `pstatetest` 验证 self pid。
5. 在 integrated v0.2 中新增 `pcount(int state)`。
6. 对 state 做范围检查，非法值返回 `-1`。
7. 新增 `pcounttest` 覆盖正常和负向输入。
8. 新增 `pchildtest` 观察子进程状态。

## 关键代码解释

`pstate` 的核心是带锁遍历：

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
return -1;
```

`pcount` 的核心是按状态计数：

```c
if (state < UNUSED || state > ZOMBIE)
  return -1;

for (p = proc; p < &proc[NPROC]; p++) {
  acquire(&p->lock);
  if (p->state == state)
    count++;
  release(&p->lock);
}
return count;
```

这是瞬时观察，不是全表原子快照。`pchildtest` 的输出状态受调度时序影响，因此只验证 `pstate(child) =` 前缀。

## 测试方法

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
```

## 预期输出

```text
pstate(self) = 4 (RUNNING)
pcount(RUNNING) = <n>
pcount(99) = -1
pstate(child) = <state> (<STATE_NAME>)
```

`<n>` 和 child state 不固定。

## 当前真实结果

| 测试项 | 结果 |
| --- | --- |
| pstate independent patch apply/make | PASS |
| integrated `0001-0005` apply/make | PASS |
| `pstate(self) =` | PASS |
| `pcount(RUNNING) =` | PASS |
| `pcount(99) = -1` | PASS |
| `pstate(child) =` | PASS |
| 长期稳定性测试 | 未执行 |
| 队友独立复现 | 已覆盖在 2 份队友 `teammate-verify.sh --full` PASS summary 中；文字摘要见 `submissions/teammate_reproduction_record.md` |

## 常见错误

| 问题 | 原因 | 处理 |
| --- | --- | --- |
| syscall number 冲突 | independent lab2 使用 22，不能直接叠加 lab1 | 综合演示使用 integrated patch，pstate=24 |
| 忘记 `extern struct proc proc[NPROC]` | `sysproc.c` 无法访问进程表 | 按 patch 添加声明 |
| 死锁或 panic | 返回路径漏 release | 每个 acquire 都必须 release |
| 固定 child state | 忽略调度时序 | 只验证 `pstate(child) =` |
| `pstatechildtest` 无法构建 | xv6 `DIRSIZ` 文件名限制 | 使用 `pchildtest` |
| `pcount(99)` 不返回 -1 | 未做范围检查 | 检查 state 合法性 |

## 扩展问题

1. 为什么 `pstate(self)` 通常是 RUNNING？
2. 为什么 `pcount` 不是全局原子快照？
3. 如何设计一个 ps-like summary，但仍控制教学复杂度？
4. 如果要观察调度器行为，需要补哪些事件记录？
