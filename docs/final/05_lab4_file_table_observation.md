# 05 Lab4 File Table Observation

## 实验目标

通过 `fcount()` syscall 和 `fcounttest`，让学生理解用户态 file descriptor 与内核 `struct file`、全局 file table、引用计数和锁之间的关系。

本实验是文件表观察 v0.1，不是完整文件系统实验。

## 前置知识

- file descriptor。
- `struct file`。
- 全局 `ftable.file[]`。
- `ref` 引用计数。
- `open()` / `close()`。
- `ftable.lock`。
- 为什么绝对数量不固定。

## 涉及文件

| 文件 | 作用 |
| --- | --- |
| `kernel/file.c` | 新增 `filecount()` |
| `kernel/defs.h` | 声明 `filecount()` |
| `kernel/sysfile.c` | 实现 `sys_fcount()` |
| `kernel/syscall.h` | 分配 `SYS_fcount` |
| `kernel/syscall.c` | 注册 `sys_fcount` |
| `user/user.h` | 声明 `fcount()` |
| `user/usys.pl` | 生成用户态 stub |
| `Makefile` | 加入 `_fcounttest` |
| `user/fcounttest.c` | 用户态测试程序 |
| `patches/lab4-file-table-observation/` | independent patch |
| `patches/integrated-labs/0005-add-file-table-observation.patch` | integrated patch |

## 实现步骤

1. 在 `kernel/file.c` 中实现 `filecount()`。
2. 在 `defs.h` 中声明 `filecount()`。
3. 在 `sysfile.c` 中实现 `sys_fcount()`。
4. 注册 syscall 并生成用户态 stub。
5. 新增 `fcounttest`。
6. 通过 open 前、open 后、close 后的输出观察引用数量变化。

## 关键代码解释

`filecount()` 的核心：

```c
int
filecount(void)
{
  struct file *f;
  int count = 0;

  acquire(&ftable.lock);
  for (f = ftable.file; f < ftable.file + NFILE; f++) {
    if (f->ref > 0)
      count++;
  }
  release(&ftable.lock);

  return count;
}
```

这段代码只统计 `ref > 0` 的 `struct file` 条目。它不读取路径、不读取文件内容、不修改文件系统布局。

`sys_fcount()` 放在 `kernel/sysfile.c`，原因是它属于文件相关 syscall。

## 测试方法

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/run-xv6-command.sh fcounttest "fcount(before) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcount(after_open) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcount(after_close) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

## 预期输出

```text
fcount(before) = <n>
fcount(after_open) = <n_or_n_plus_1>
fcount(after_close) = <n>
fcounttest done
```

具体数字不固定。验证只依赖稳定前缀和 `fcounttest done`。

## 当前真实结果

| 测试项 | 结果 |
| --- | --- |
| independent lab4 patch apply/make | PASS |
| integrated `0001-0005` apply/make | PASS |
| `fcount(before) =` | PASS |
| `fcount(after_open) =` | PASS |
| `fcount(after_close) =` | PASS |
| `fcounttest done` | PASS |
| 长期稳定性测试 | 未执行 |
| 队友独立复现 | 已覆盖在 2 份队友 `teammate-verify.sh --full` PASS summary 中；文字摘要见 `submissions/teammate_reproduction_record.md` |

## 常见错误

| 问题 | 原因 | 处理 |
| --- | --- | --- |
| 固定承诺 fcount 数字 | 忽略 shell/console/init 等引用 | 只验证稳定前缀 |
| 忘记 `ftable.lock` | 并发读写风险 | 遍历时持有 lock |
| syscall 放错文件 | 文件相关 syscall 写到 `sysproc.c` | `sys_fcount()` 放在 `sysfile.c` |
| syscall number 冲突 | independent/integrated 编号不同 | independent 用 22；integrated 用 26 |
| 漏 `usys.pl` entry | 用户态无法调用 | 添加 `entry("fcount")` |
| 把 lab4 写成完整文件系统 | 实验范围被夸大 | 明确只是文件表观察 |

## 扩展问题

1. file descriptor 和 `struct file` 是什么关系？
2. 为什么 `open()` 后 file table 数量可能变化？
3. 如何扩展到 per-process fd table 观察？
4. 如何设计 inode 观察实验，同时避免泄漏路径或内容？
