# Lab3：亲眼看到页表在变

> 维护时间：2026-06-10（stage12 教程化；实现自 stage9b/stage11b）。

## 这一关学什么

- 给内核加 `pgcount()`：数一数当前进程页表里"有效且用户可访问"（`PTE_V && PTE_U`）的页有几个。返回值就是一个 int。
- 用它做一个对比实验：`sbrk(2 页)` 后 pgcount 立刻 +2（eager），`sbrklazy(2 页)` 后 pgcount 先 +0，等你真的去写那两页才逐页 +1（lazy）。按需分配从概念变成你亲手量出来的数字。
- 进阶 `memstat()`：观察结果从单个 int 升级为一个结构体 `{sz_bytes, mapped_pages, page_size}`，用 `argaddr + copyout` 拷回用户态。两种返回方式的对比就是本关的进阶教学点。

## 为什么重要

"进程地址空间大小"（`p->sz`）和"页表里实际有映射的页"是两回事——lazy allocation 时它们会差出好几页。大多数教材只把这句话写在纸上，这一关让你用自己加的 syscall 量出来。`pgcount` 用 int 返回值就够了；但当你想一次带回多个观察值时，就必须学内核↔用户态的结构体传输（`argaddr + copyout + struct ABI`），这是 Lab4 进阶 `fdinfo` 和以后读真实内核代码的基础。

## 和前后 Lab 的关系

- 前置：Lab1（加 syscall 套路）、Lab2（"观察 + 不固定值"的纪律）。
- 后继：Lab4 把观察对象换成文件表；`memstat` 的 copyout 写法在 Lab4 进阶 `fdinfo` 里再用一次。
- 边界：这是页表**观察**实验，不改 page fault 逻辑、不分配页、不输出物理地址——不是完整内存管理实验。

## 前置知识

- RISC-V Sv39 页表基本概念。
- `pagetable_t`、PTE、`PTE_V`、`PTE_U`。
- `PGSIZE = 4096`。
- xv6 进程结构中的 `struct proc.sz` 和 `struct proc.pagetable`。
- baseline 已内置 eager/lazy allocation：
  - `sbrk(n)` 走 `SBRK_EAGER`，立即分配并映射用户页。
  - `sbrklazy(n)` 走 `SBRK_LAZY`，只扩大进程大小，实际页由 `vmfault()` 按需分配。

## 实验任务

1. 阅读 `kernel/vm.c` 中 `walk()`、`uvmalloc()`、`uvmdealloc()` 和 `vmfault()`。
2. 阅读 `kernel/sysproc.c` 中 `sys_sbrk()` 的 eager/lazy 分支。
3. 应用 independent Lab3 patch：

   ```bash
   cd external/xv6-riscv
   git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
   git clean -fdx
   git apply ../../patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch
   make
   ```

4. 运行 `pgcounttest`，观察 eager 与 lazy 的页表映射数量差异。

## 关键代码解释

Lab3 patch 在 `kernel/vm.c` 中新增只读 helper：

```c
int uvmpagecount(pagetable_t pagetable, uint64 sz)
```

它遍历 `0 <= va < sz` 的用户虚拟页：

- 使用 `walk(pagetable, va, 0)` 查询 PTE。
- 不分配页表页，不修改 PTE。
- 只统计同时满足 `PTE_V` 和 `PTE_U` 的页。

`sys_pgcount()` 只统计当前进程：

```c
struct proc *p = myproc();
return uvmpagecount(p->pagetable, p->sz);
```

不接收 pid，不输出物理地址，不暴露内核页表细节。

## 测试方法

在仓库根目录执行：

```bash
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount eager delta = 2"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta before touch = 0"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta after two touches = 2"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"
```

## 预期输出

```text
pgcount eager delta = 2
pgcount lazy delta before touch = 0
pgcount lazy delta after one touch = 1
pgcount lazy delta after two touches = 2
pgcounttest done
```

`pgcount before/after` 的绝对值不固定，不作为验收标准。

## 当前真实结果

| 项目 | 结果 |
| --- | --- |
| independent patch 生成 | PASS |
| clean baseline apply | PASS |
| `make` | PASS |
| `pgcount eager delta = 2` | PASS |
| `pgcount lazy delta before touch = 0` | PASS |
| `pgcount lazy delta after two touches = 2` | PASS |
| `pgcounttest done` | PASS |
| integrated `0006` | PASS；已进入 `patches/integrated-labs/0006-add-pgcount-page-table-observation.patch` |
| teammate full verification | 旧 `1ba9db6` summary 不覆盖；stage9c 新 HEAD 待重跑 |

## 自己动手任务

打开 [student_tasks.md](student_tasks.md)：必做任务包括预测-验证 lazy 行为、解释 `walk(..., 0)` 的第三个参数，并有评分 rubric。

## 常见卡点（常见错误）

- 只统计 `PTE_V`，忘记检查 `PTE_U`，会混淆非用户映射。
- 在 helper 中调用 `walk(..., 1)`，导致观察函数意外分配页表页——观察代码必须只读。
- 依赖 `pgcount before = <n>` 的绝对值；不同程序大小或构建状态会影响它。验收只看 delta。
- 把 `pgcount()` 说成完整内存管理实验。
- 把旧队友 summary 写成新 HEAD 复现（旧证据只覆盖它所在的 commit 和 suite）。

## 扩展问题

1. 为什么 `sbrklazy(2 * PGSIZE)` 后 `pgcount` 不立即增加？
2. 为什么触摸 lazy 区域会让 `pgcount` 增加？
3. 如果只统计 `PTE_V` 而不统计 `PTE_U`，教学语义会有什么问题？
4. 为什么本实验不返回物理地址或 PTE 原始值？

## 进阶可选实验：memstat（advanced optional, independent + integrated `0008`）

`pgcount()` 之后，可以做一个进阶可选实验 `memstat()`，把"数页"升级为"用 `copyout` 把一个结构体拷回用户态"。

- patch：`patches/lab3-memory-and-pagetable/0002-add-memstat-syscall.patch`（独立于 `0001`）。
- 接口：`int memstat(struct memstat *out)`，返回 `{sz_bytes, mapped_pages, page_size}`。
- 教学点：`argaddr + copyout + struct ABI`——内核如何安全地把结构体写回用户缓冲区；`copyout` 失败返回 -1。
- 验证：`bash scripts/xv6/run-xv6-command.sh memstattest "memstattest done"`，clean baseline round-trip 已通过（`page_size = 4096`、`mapped delta = 2`、`size delta = 8192`、`invalid pointer = -1`）。

边界与状态：仍然是页表/地址空间**观察**实验，不是完整内存管理；independent 版 `SYS_memstat = 22` 与 `pgcount` 相同，两个 independent patch **不可叠加**，各自从 clean baseline 单独应用。stage11b 起 `memstat` **已进入** integrated `0008`（`patches/integrated-labs/0008-add-memstat-copyout-observation.patch`，`SYS_memstat = 29`），current integrated suite 为 `0001-0009`，队长本机 `local-verify --full` overall PASS（含 `memstattest`）。证据边界：`e8e2fb9 / 0001-0007` 三方 full PASS 是 historical stable checkpoint，**不覆盖** `0001-0009`；含 memstat 的 `0001-0009` 队友 full verify、新视频、新 SHA256 均为 TBD，待重新复现后填写，不得伪造。

## 不要误解什么

- `pgcount()` 是 **int 返回值**观察（一个数），`memstat()` 是 **struct copyout** 结构化观察（一次带回 `{sz_bytes, mapped_pages, page_size}`）——后者多出来的不是功能，是"内核怎么安全地把结构体写回用户缓冲区"这个机制。
- 两者都不输出物理地址、不修改 PTE、不分配页；不要写成"实现了内存管理"。
- lazy 实验依赖本 baseline 内置的 `sbrklazy()`；换别的 xv6 版本该函数可能不存在。

## 下一步看哪里

- 动手：做 [student_tasks.md](student_tasks.md)。
- 继续闯关：[Lab4 文件表观察](../lab4-file-system/README.md)——观察对象换成 fd 和 file table，进阶 `fdinfo` 会再次用到 copyout。
- 想看 patch 细节：independent `patches/lab3-memory-and-pagetable/`，integrated `0006`/`0008`。
