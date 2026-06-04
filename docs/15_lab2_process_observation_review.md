# lab2 process observation 复现审查

## 总体结论

stage4a 新增的 lab2 `pstate(int pid)` syscall patch 已完成真实复现验证。

结论：

- patch 可从 clean baseline commit `74f84181a3404d1d6a6ff98d342233979066ebb8` 直接应用。
- `make` 成功。
- `pstatetest` 输出可被自动脚本捕获。
- 实际输出包含 `pstate(self) = 4 (RUNNING)`。

该实验是进程状态观察入门，不是完整 `ps`，不修改调度器。

## patch 修改文件列表

| 文件 | 说明 |
| --- | --- |
| `kernel/syscall.h` | 增加 `SYS_pstate 22`。 |
| `kernel/syscall.c` | 注册 `sys_pstate`。 |
| `kernel/sysproc.c` | 实现 `sys_pstate()`。 |
| `user/user.h` | 声明 `int pstate(int);`。 |
| `user/usys.pl` | 增加 `entry("pstate");`。 |
| `Makefile` | 增加 `_pstatetest`。 |
| `user/pstatetest.c` | 新增用户态测试程序。 |

## pstate syscall 调用链

```text
pstatetest
  -> getpid()
  -> pstate(pid)
  -> user stub
  -> ecall / trap
  -> syscall dispatcher
  -> sys_pstate
  -> proc table lookup
  -> return state enum value
```

## proc table 查找过程

`sys_pstate()` 通过 `argint(0, &pid)` 获取用户态传入的 pid，然后遍历 `proc[]`：

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

未找到 pid 时返回 `-1`。

## 锁使用分析

`p->state` 是调度、sleep/wakeup、exit/wait 等路径会修改的共享状态。xv6 对 `struct proc` 中的 state、pid 等字段有明确锁约定：访问这些字段时应持有 `p->lock`。

本实验在读取每个 `proc` 的 `pid` 和 `state` 时获取对应 `p->lock`，并保证找到和未找到路径都会释放锁。

## clean baseline apply 验证步骤

已真实执行：

```bash
git -C external/xv6-riscv reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git -C external/xv6-riscv clean -fdx
git -C external/xv6-riscv apply ../../patches/lab2-process-observation/0001-add-pstate-syscall.patch
```

结果：patch 成功应用。过程中出现 `user/usys.pl` file mode warning，但未阻塞应用或构建。

## make 验证结果

已真实执行：

```bash
cd external/xv6-riscv
make
```

结果：

- `make` 成功。
- 使用 `riscv64-linux-gnu-gcc`。
- linker 仍有已知 `LOAD segment with RWX permissions` warning。

## boot / pstatetest 验证结果

已真实执行：

```bash
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

结果：

- boot evidence 捕获成功。
- `pstate(self) =` 捕获成功。
- `RUNNING` 捕获成功。
- 本地 ignored log 中观察到 `pstate(self) = 4 (RUNNING)`。

## 教学价值评估

该实验适合作为 lab1 之后的进程观察实验：

- lab1 已经讲过 syscall 参数传递。
- lab2 使用 pid 作为参数，引导学生进入进程表。
- `pstate()` 只观察单个进程，范围小、可讲清楚。
- 锁设计可以引出并发访问内核数据结构的基本规范。

## 当前不足

- 不是完整 `ps`。
- 不修改调度器。
- 只观察单个 pid。
- timeout 自动捕获不是长期稳定性测试。
- 第二名队员复现 TODO。
- lab2 patch 独立于 lab1 patch；如果后续要合并 lab1 和 lab2，需要重新分配 syscall number。

## 评委复现路径

```bash
bash scripts/check-env.sh
bash scripts/xv6/fetch-xv6.sh --run
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab2-process-observation/0001-add-pstate-syscall.patch
make
cd ../..
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
```

## 后续扩展

- `pcount(state)`: 统计某种状态的进程数量。
- scheduler trace: 记录调度切换过程。
- ps-like summary: 输出简化进程表。
- 负向实验: 错误 pid、锁遗漏、syscall number 冲突等。
