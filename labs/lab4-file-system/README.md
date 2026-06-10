# Lab4：fd 后面到底是什么

## 这一关学什么

三个观察接口，从粗到细看清"fd → `struct file` → 全局 file table"三层关系：

- `fcount()`：看**全局** file table 里 `ref > 0` 的 `struct file` 有几个——系统级趋势。
- `fdcount()`：看**当前进程** `ofile[]` 里非空 fd 有几个——你自己开了几个文件。
- 进阶 `fdinfo(int fd, struct fdinfo *out)`：看**单个 fd** 的结构化状态 `{type, readable, writable, ref}`，用 `argint + argaddr + copyout` 拷回来。

配套实验：`open` 让 fcount/fdcount 都 +1；`dup` 让 fdcount +1 但 fcount **不变**（两个 fd 指向同一个 `struct file`，只是 `ref` +1）；`close` 反向。这一组对比做完，三层关系就不再是背的。

## 为什么重要

"fd 只是个整数索引"这句话，直到你看见 `dup` 后 fdcount 涨了而 fcount 没涨，才真正懂。引用计数、全局表和每进程表的区别，是以后理解管道、重定向、`fork` 共享文件偏移的地基。进阶 `fdinfo` 还复用了 Lab3 学的 copyout：同一个机制第二次出现，你就掌握了。

## 和前后 Lab 的关系

- 前置：Lab1（syscall 套路）、Lab2（锁纪律——这次拿的是 `ftable.lock`）、Lab3 进阶（copyout 写法）。
- 后继：Lab5 把全部实验串成一次综合验收。
- 边界：文件表**观察** v0.2，不观察 inode、不改文件系统布局——不是完整文件系统实验。

## 前置知识

- file descriptor：用户态看到的整数 fd，是进程打开文件表的索引。
- `struct file`：xv6 内核中表示打开文件、管道或设备的对象。
- global file table：xv6 使用全局 `ftable.file[]` 管理系统范围内的 `struct file`。
- `ref` 引用计数：`ref > 0` 表示该 `struct file` 正在被引用。
- `open/close`：`open` 会分配或引用内核文件对象，`close` 会释放引用。
- file table lock：读取 `ftable.file[]` 和 `ref` 时需要持有 `ftable.lock`，避免并发读写导致不一致。
- 为什么 count 不是固定值：shell、console、init、测试程序自身打开的文件和调度时序都会影响当前文件表引用数量。

## 实验任务

1. 新增 `fcount()` syscall。
2. 在内核中实现 `filecount()`，统计全局文件表中 `ref > 0` 的 `struct file` 数量。
3. 新增 `fdcount()` syscall。
4. 新增用户程序 `fcounttest` 和 `fdcounttest`。
5. 在用户程序中观察临时文件打开、dup、关闭前后的 file table / fd table 变化。
5. 记录真实构建命令、运行命令、输出前缀和风险边界。

## 修改文件说明

| 文件 | 作用 |
| --- | --- |
| `kernel/file.c` | 新增 `filecount()`，在持有 `ftable.lock` 时遍历 `ftable.file[]`。 |
| `kernel/defs.h` | 声明 `int filecount(void);`。 |
| `kernel/syscall.h` | 新增 syscall number。independent patch 使用 `SYS_fcount = 22`；integrated patch 使用 `SYS_fcount = 26`。 |
| `kernel/syscall.c` | 声明并注册 `sys_fcount`。 |
| `kernel/sysfile.c` | 新增 `sys_fcount()`，返回 `filecount()` 的结果。 |
| `user/user.h` | 声明 `int fcount(void);`。 |
| `user/usys.pl` | 新增 `entry("fcount");` 生成用户态 syscall stub。 |
| `Makefile` | 将 `_fcounttest` 加入 `UPROGS`。 |
| `user/fcounttest.c` | 新增用户态测试程序。 |
| `kernel/sysfile.c` | stage9c 新增 `sys_fdcount()`，统计当前进程 `ofile[]`。 |
| `user/user.h` | stage9c 新增 `int fdcount(void);`。 |
| `user/usys.pl` | stage9c 新增 `entry("fdcount");`。 |
| `Makefile` | stage9c 将 `_fdcounttest` 加入 `UPROGS`。 |
| `user/fdcounttest.c` | stage9c 新增 fd table 对比测试程序。 |

## 调用链

```text
用户程序 fcounttest
  -> user stub: fcount()
  -> ecall / trap
  -> syscall dispatcher
  -> sys_fcount()
  -> filecount()
  -> ftable.file[] / f->ref
  -> 返回用户态
```

## 锁设计说明

`filecount()` 读取的是全局 `ftable.file[]`。该表可能被其他进程通过 `open`、`close`、`dup` 等路径修改，因此统计时需要：

1. `acquire(&ftable.lock)`。
2. 遍历 `ftable.file[]`。
3. 统计 `f->ref > 0` 的条目。
4. `release(&ftable.lock)`。

本实验只做瞬时观察，不承诺得到系统全局长期稳定数量。

## 测试方式

independent lab4 patch：

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab4-file-table-observation/0001-add-fcount-syscall.patch
make
cd ../..
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

integrated demo：

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/run-xv6-command.sh fcounttest "fcount(before) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcount(after_open) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcount(after_close) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
bash scripts/xv6/run-xv6-command.sh fdcounttest "fdcounttest done"
```

自动验证只匹配稳定前缀，不固定具体数字。

## 自己动手任务

打开 [student_tasks.md](student_tasks.md)：必做任务包括预测-验证 `dup` 对两个计数的影响、解释 `fdinfo` 为什么拒绝坏 fd，并有评分 rubric。

## 常见卡点（常见错误）

- syscall number 与已有实验冲突（independent 各自用 22，不可叠加；integrated 里 fcount=26、fdcount=28、fdinfo=30）。
- 忘记更新 `user/user.h` 或 `user/usys.pl`。
- `Makefile` 未加入 `_fcounttest` / `_fdcounttest` / `_fdinfotest`。
- 读取 `ftable.file[]` 时忘记释放 `ftable.lock`。
- 在文档或测试中固定承诺 `fcount` 的具体数字（shell/console/init 都会占用文件表）。
- 把 integrated patch 和 independent patch 的 syscall number 混用。

## 当前验证结果

当前真实结果：

- independent lab4 patch 已生成：`patches/lab4-file-table-observation/0001-add-fcount-syscall.patch`。
- independent patch 已从 clean baseline 应用并 `make` 成功。
- integrated `0005-add-file-table-observation.patch` 已生成，基于 integrated `0001-0004`。
- integrated `0001-0009`（stage11b，含 memstat `0008` / fdinfo `0009`）已通过 helper 从 clean baseline 应用并 `make` 成功（队长本机 `local-verify --full` overall PASS）。
- 已真实捕获 `fcount(before) =`、`fcount(after_open) =`、`fcount(after_close) =` 和 `fcounttest done`。
- stage9c 已真实捕获 `fdcounttest done`，并观察到 fd delta open=1、dup=2、close one=1、close two=0。
- 本地一次日志中观察到 `before=1`、`after_open=2`、`after_close=1`，但该数字不作为固定验收标准。

## 进阶可选实验：fdinfo（advanced optional, independent + integrated `0009`）

`fcount()`/`fdcount()` 之后，可以做一个进阶可选实验 `fdinfo()`，把"数 fd"升级为"看一个 fd 的内核元数据"。

- patch：`patches/lab4-file-table-observation/0002-add-fdinfo-syscall.patch`（独立于 `0001`）。
- 接口：`int fdinfo(int fd, struct fdinfo *out)`，返回 `{type, readable, writable, ref}`。
- 教学点：`argint + argaddr + copyout + struct ABI`——内核如何按 fd 取出 `struct file` 的元数据并安全拷回用户态；只查 `myproc()->ofile[fd]`，在 `ftable.lock` 下读取，不返回路径/inode 号/内容/物理地址。
- 验证：`bash scripts/xv6/run-xv6-command.sh fdinfotest "fdinfotest done"`，clean baseline round-trip 已通过（`open fd ok`、`dup fd ok`、`closed fd = -1`、`bad fd = -1`）。

边界与状态：仍然是 fd table **观察**实验，不是完整文件系统；independent 版 `SYS_fdinfo = 22` 与 `fcount` 相同，两个 independent patch **不可叠加**，各自从 clean baseline 单独应用。stage11b 起 `fdinfo` **已进入** integrated `0009`（`patches/integrated-labs/0009-add-fdinfo-copyout-observation.patch`，`SYS_fdinfo = 30`），current integrated suite 为 `0001-0009`，队长本机 `local-verify --full` overall PASS（含 `fdinfotest`）。证据边界：`e8e2fb9 / 0001-0007` 三方 full PASS 是 historical stable checkpoint，**不覆盖** `0001-0009`；含 fdinfo 的 `0001-0009` 队友 full verify、新视频、新 SHA256 均为 TBD，待重新复现后填写，不得伪造。

## 不要误解什么

- 这不是完整文件系统实验：不观察 inode，不修改文件系统布局，`fdinfo` 不返回路径/inode 号/文件内容。
- `fdinfo` 只能查**自己**的 fd（`myproc()->ofile[fd]`），没有实现跨进程的 `fdinfo(pid, fd)`，也没有 open file summary。
- `fcount` 的绝对数字不固定，稳定的只有 open/close 的 +1/-1 delta。
- timeout 自动捕获不等于长期稳定性测试；`0001-0009` 的队友复现/新视频仍为 TBD。

## 下一步看哪里

- 动手：做 [student_tasks.md](student_tasks.md)。
- 最后一关：[Lab5 综合复现](../lab5-final-integration/README.md)——把 Lab0 到 Lab4 的全部成果从干净源码一次复现并写报告。
- 想看 fcount 的红队审查（锁/死锁/无泄漏分析）：[docs/20_lab4_file_table_observation_review.md](../../docs/20_lab4_file_table_observation_review.md)。
