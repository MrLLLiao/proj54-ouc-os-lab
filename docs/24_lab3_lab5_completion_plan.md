# Lab3 and Lab5 Completion Plan

> 维护时间：2026-06-06（stage9b）。
> stage9a 为设计和风险评审；stage9b 已按推荐路线实现 independent Lab3 `pgcount()` patch。本文档仍强调：未新增 integrated `0006`，未修改 `scripts/xv6/`。

## 1. 当前实验覆盖现状

| 实验 | 当前状态 | 真实边界 |
| --- | --- | --- |
| lab0 baseline/build/boot | 已完成 | 覆盖环境、baseline metadata、make、boot evidence |
| lab1 hello/add2 syscall | 已完成 | 覆盖最小 syscall 和整数参数传递 |
| lab2 pstate/pcount/pchildtest | 已完成 | 覆盖进程表观察、状态计数、子进程状态观察 |
| lab3 memory/pagetable | independent patch 已完成 | `pgcount()` 页表映射数量观察；已验证 eager/lazy allocation 对比；未 integrated，未队友复现 |
| lab4 fcount/fcounttest | 已完成 v0.1 | 文件表引用计数观察，不是完整文件系统实验 |
| lab5 final integration | 未完成 | 目前没有独立 capstone 实验文档或验收闭环 |
| integrated-labs 0001-0005 | 已完成 | 这是综合演示 patch 序列，不等同于 lab0-lab5 全部完成 |

当前仍不能写“Lab0-Lab5 全部完成”。准确说法应为：lab0/lab1/lab2/lab3 independent/lab4 已完成，独立 Lab5 仍待补全；integrated-labs `0001-0005` 已完成并验证，但 Lab3 尚未进入 integrated-labs。

两位队友 full verify PASS 锚定在 commit `1ba9db6 tooling: speed up verification and clean repo hygiene`。stage9b 只新增 independent Lab3 patch，没有修改 integrated patch sequence 或 `scripts/xv6/`，因此原队友 PASS 仍只覆盖 integrated `0001-0005` 工作流，不覆盖 Lab3。

## 2. 命名澄清：integrated 0005 != Lab5

`patches/integrated-labs/0005-add-file-table-observation.patch` 是 integrated patch 序列中的第 5 个 patch，内容属于 lab4 文件表观察：`fcount()` 和 `fcounttest`。

它不是 lab5。原因：

- integrated `0005` 的教学主题是文件表引用计数，属于 lab4 范围。
- 独立 lab5 应当是“最终集成 / capstone / 综合复现实验”，关注如何把 lab0-lab4 或后续 lab3 串成可复现、可展示、可报告的完整流程。
- 如果后续新增 lab3 integrated patch，合理编号可能是 integrated `0006`，不能回头改写 `0005` 的含义。

文档中必须避免两种误写：

- “integrated 0001-0005 已完成，所以 Lab0-Lab5 已完成。”
- “0005 是 Lab5 patch。”

## 3. 为什么 Lab3 是冲奖短板

proj54 的强项不只是功能数量，而是教学完整度。当前项目已经覆盖：

- 环境与复现：lab0。
- syscall 入门：lab1。
- 进程观察：lab2。
- 文件表观察：lab4。

缺口是内存 / 页表。对操作系统课程来说，内存管理是核心主题之一；如果 lab3 缺席，评委会看到“系统调用、进程、文件表都有，但内存页表停留在计划”，这会影响实现完整度和文档完整度的观感。

但是 lab3 也是风险最高的一块。页表实验容易出现：

- 输出依赖具体地址或页数，测试不稳定。
- 误暴露物理地址或内核布局，教学边界不好解释。
- 修改页表逻辑导致 boot 或 exec 破坏。
- 文档把“页表观察”夸大成完整虚拟内存实验。

因此 lab3 需要选择一个小、稳、可解释、可验证的观察型实验，而不是临时做复杂内存管理功能。

## 4. Lab3 候选方案对比

| 方案 | 内容 | 教学价值 | 实现难度 | 测试稳定性 | 主要风险 | 结论 |
| --- | --- | --- | --- | --- | --- | --- |
| `pgcount()` | 统计当前进程用户页表中有效用户页数量 | 直接连接 `pagetable_t`、`walk()`、`PTE_V/PTE_U`、`sbrk()` | 中 | 较高，可测试 delta | 需要小心只数用户页，不承诺绝对页数 | 推荐 |
| `memstat()` | 统计空闲物理页数量或内存分配状态 | 可讲 `kalloc.c`、freelist、锁 | 中偏高 | 中，绝对值和运行时状态易变 | 容易被误写成完整内存统计；全局状态更不稳定 | 备选 |
| `pagetest`/`vmprint` | 打印页表结构或映射摘要 | 可视化强，接近 xv6 pgtbl 教学经典路径 | 中偏高 | 中偏低，输出多且脆弱 | grep 易假阳性；输出格式难维护 | 适合文档扩展，不建议先做验收核心 |
| `va2pa()` / pagemap | 用户传虚拟地址返回物理页号或映射信息 | 概念直观 | 高 | 中 | 可能泄露物理地址，教学和安全边界差 | 不推荐 |
| page fault/lazy allocation | 做缺页或懒分配观察 | 教学价值高 | 高 | 低到中 | 修改语义大，易破坏 exec/fork/sbrk | 当前不做 |

## 5. 推荐 Lab3 方案

推荐并已实现 `pgcount()` + `pgcounttest`，定位为“页表映射数量观察实验”。

### 实验目标

让学生理解：

- 用户进程有自己的 `pagetable` 和地址空间大小 `sz`。
- 内核可以通过页表 walk 检查某个虚拟页是否存在有效用户映射。
- baseline 已有 eager/lazy allocation：`sbrk()` 走 eager，扩大用户地址空间并立即映射；`sbrklazy()` 走 lazy，只扩大 `p->sz`，触摸后由 `vmfault()` 分配。
- `sbrk()` 扩大用户地址空间后，有效用户页数量会增加；`sbrklazy()` 触摸前不会增加映射数量。
- 页表观察只能说明某一时刻的映射状态，不能等同于完整内存管理实验。

### 建议接口

```c
int pgcount(void);
```

返回当前进程用户地址空间中有效用户页数量。实现时只遍历 `0 <= va < p->sz`，只统计同时满足 `PTE_V` 和 `PTE_U` 的页表项。

不建议返回物理地址、PTE 原始值或内核映射信息。这样能降低安全/解释风险，也更符合低年级课程入门。

### 建议用户程序输出

```text
pgcount before = <n>
pgcount after sbrk = <m>
pgcount delta = 2
pgcounttest done
```

验收不依赖 `<n>` 或 `<m>` 的绝对值，只依赖 `pgcount delta = 2` 和 `pgcounttest done`。如果后续 xv6 版本或实验改成 lazy allocation，delta 可能需要重新设计，不能硬套。

## 6. Lab3 预计改动文件

本轮不修改这些文件；以下只是未来施工预计改动面。

### independent lab3 patch

建议新增：

- `patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch`
- `patches/lab3-memory-and-pagetable/README.md` 更新或补强
- `labs/lab3-memory-and-pagetable/README.md` 更新为正式实验指导
- `tests/lab3/README.md` 更新真实测试记录
- `docs/final/` 中新增或更新 lab3 正式文档（如果进入最终材料）

预计 xv6 改动文件：

| xv6 文件 | 预计改动 |
| --- | --- |
| `kernel/syscall.h` | 新增 `SYS_pgcount`；independent patch 可用 22，integrated patch 应避开已有 22-26 |
| `kernel/syscall.c` | 声明并注册 `sys_pgcount` |
| `kernel/sysproc.c` | 实现 syscall wrapper，调用页表计数 helper |
| `kernel/vm.c` | 新增只读页表计数 helper，例如 `uvmpagecount(pagetable_t pagetable, uint64 sz)` |
| `kernel/defs.h` | 声明 helper 原型 |
| `user/user.h` | 声明 `int pgcount(void);` |
| `user/usys.pl` | 增加 `entry("pgcount")` |
| `user/pgcounttest.c` | 新增用户态测试程序 |
| `Makefile` | 加入 `_pgcounttest` |

### integrated patch

如果 lab3 进入综合演示，应新增 integrated patch，而不是改 `0001-0005`：

```text
patches/integrated-labs/0006-add-page-count-observation.patch
```

推荐 integrated syscall number：

| syscall | 当前 integrated number |
| --- | ---: |
| `hello` | 22 |
| `add2` | 23 |
| `pstate` | 24 |
| `pcount` | 25 |
| `fcount` | 26 |
| `pgcount` | 27（建议） |

一旦新增 integrated `0006`，后续还需要更新 apply helper、teammate verify、local verify、测试覆盖表、README 和正式文档。那会使 `1ba9db6` 的两份队友 PASS 变成旧版本证据。

## 7. Lab3 测试设计

### 最小验收命令

未来实现后建议至少跑：

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount delta = 2"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"
```

如果新增 independent lab3 helper，还需要验证 independent patch：

```bash
bash scripts/xv6/apply-lab3-patch.sh --make --yes
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount delta = 2"
```

### 回归命令

新增 lab3 不能破坏既有实验：

```bash
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

### 防假阳性规则

- 不要只 grep `pgcounttest done`；必须同时检查 delta 或明确错误路径。
- 不要把 expected text 写进待 grep 的日志。
- 不承诺 `pgcount before = <n>` 的绝对数字。
- 不使用物理地址作为验收输出。
- 如果出现 `/mnt/d` mtime 或首次 build 慢的问题，按现有 QEMU timeout/cleanup 机制处理，不把偶然 timeout 写成内核失败。

## 8. Lab5 综合复现实验设计

Lab5 推荐定位为 capstone 文档和复现实验，不强行新增内核功能。

### Lab5 目标

让学生完成一次从 clean baseline 到综合验证、再到报告摘要的完整闭环：

1. 运行环境诊断。
2. 应用 integrated patch sequence。
3. 构建 xv6。
4. 启动 xv6。
5. 运行所有已完成 lab 用户程序。
6. 记录哪些输出是固定的、哪些输出不固定。
7. 解释一次 QEMU 卡住或 Ctrl+Z 的处理方式。
8. 形成一页复现实验报告。

### Lab5 不建议新增内核功能

理由：

- 当前最大短板是 lab3 缺失，不是缺一个新的 kernel syscall。
- Lab5 如果再加功能，容易变成没有教学主线的“为了数量加功能”。
- capstone 更符合 proj54 教学型赛题：把已有实验组织成可复现、可讲解、可交付的课程闭环。

### Lab5 产物建议

| 产物 | 内容 |
| --- | --- |
| `labs/lab5-final-integration/README.md` | 正式 capstone 指导 |
| `docs/final/12_lab5_capstone_reproduction.md`（可选） | 提交版 lab5 文档 |
| `tests/lab5/README.md`（可选） | 综合验证记录 |
| `submissions/` 更新 | 把 capstone 证据纳入最终报告索引 |

### Lab5 验收方式

如果 lab3 未实现，Lab5 只能写“综合复现实验覆盖 lab0/lab1/lab2/lab4”，不能写“覆盖 lab0-lab5 全部功能”。

如果 lab3 已实现并纳入 integrated `0006`，Lab5 可以覆盖：

```text
doctor -> apply integrated 0001-0006 -> make -> boot -> hello/add2/pstate/pcount/pchild/fcount/pgcount -> summary
```

Lab5 的验收重点是流程完整、证据真实、边界清楚，而不是新增内核代码。

## 9. 完成后的验证与队友复现要求

### 仅完成本文档阶段

本轮 stage9a 只新增设计文档，不修改 patch、kernel 或 `scripts/xv6/`，因此不需要队友重新跑 `teammate-verify.sh --full`。

### 后续实现 Lab3 但不改一键脚本

如果只新增 independent lab3 patch 和独立测试文档，需要队长本机完成：

- clean baseline apply。
- `make`。
- boot。
- `pgcounttest`。
- 既有 hello/add2/pstate/pcount/pchild/fcount 回归。
- `git diff --check` 与 Git 卫生检查。

此时建议至少让一名队友复现 lab3 independent patch；如果最终材料把 lab3 写入“已完成”，只靠队长本机不够强。

### 后续修改 integrated patch sequence 或 scripts/xv6

如果出现任一情况，必须重新跑队友 full verification：

- 新增 `patches/integrated-labs/0006-*`。
- 修改 `scripts/xv6/apply-integrated-labs.sh`。
- 修改 `scripts/xv6/teammate-verify.sh`。
- 修改 `scripts/xv6/local-verify.sh`。
- 修改 `scripts/xv6/run-xv6-command.sh` 或 `boot-xv6.sh`。
- README/正式文档把 lab3 改为已完成。

推荐验证顺序：

```bash
bash -n scripts/xv6/*.sh
bash scripts/xv6/doctor.sh
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/teammate-verify.sh --full
bash scripts/xv6/local-verify.sh --quick
bash scripts/collect-report.sh
git diff --check
git status --short
git status --ignored --short external logs .claude
git ls-files external/xv6-riscv
git ls-files logs/*.log
git ls-files logs/*.summary.txt
git ls-files logs/*.console.txt
git ls-files .claude
git ls-files | grep -Ei '\.(mp4|mov|avi|mkv|zip|7z|rar)$' || true
```

队友复现判断：如果 Lab3 进入 integrated/teammate workflow，则两位队友在 commit `1ba9db6` 的 PASS 只能作为历史证据。新 commit 必须至少重新收集一份，冲奖标准建议收集两份。

## 10. 风险与止损条件

### 实现难度风险

`pgcount()` 需要正确遍历用户页表。如果 helper 错数内核映射、trampoline、guard page 或未映射区，测试会失真。

止损线：如果 1 天内不能在 clean baseline 上稳定 `make` + `pgcount delta = 2`，停止写代码，保留 lab3 计划，不把 lab3 写成已完成。

### 页表稳定性风险

当前 xv6 baseline 的 `sbrk()` 会实际分配用户页，因此 delta 测试可控。但如果后续引入 lazy allocation，delta 语义会变化。

止损线：如果同一 integrated build 连续 3 次 `pgcount delta` 不稳定，不纳入 teammate verify，只保留人工分析记录。

### 测试假阳性风险

只匹配 `pgcounttest done` 可能掩盖计数错误；匹配绝对页数又会过度依赖环境。

止损线：验收必须至少匹配一个稳定行为断言，例如 `pgcount delta = 2`。不能只用完成提示。

### 文档夸大风险

`pgcount()` 是页表观察实验，不是完整虚拟内存管理、缺页处理、内存分配器实验。

止损线：最终 README 和报告中只能写“lab3 page-table observation / pgcount”，不能写“完整内存管理实验已完成”。

### 综合 patch 风险

新增 integrated `0006` 会改变最终复现目标，现有队友 summary 失效，需要重新 full verify。syscall number 也必须避开 22-26。

止损线：如果无法在当天完成 integrated `0006` + helper + teammate verify，全局提交材料不要把 lab3 纳入 integrated completed 状态。

## 11. 下一步施工建议

推荐顺序：

1. 先把 `labs/lab3-memory-and-pagetable/README.md` 改成正式教学文档，但仍标注未实现。
2. 在 ignored `external/xv6-riscv/` 中实现 independent `pgcount()`，导出 `patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch`。
3. 验证 independent lab3：apply、make、boot、`pgcounttest`。
4. 红队审核 `pgcount()`：只数用户页、不泄露物理地址、不承诺绝对数值。
5. 决定是否进入 integrated `0006`。如果时间不足，不要硬塞 integrated。
6. 若进入 integrated，更新 helper/teammate/local verify，并重新跑队友 `--full`。
7. 最后把 Lab5 写成 capstone：综合复现、summary、报告模板和视频脚本，不新增内核功能。

阶段结论：建议继续实现 Lab3，但只做 `pgcount()` 这种小范围页表观察实验；Lab5 建议优先做 capstone 文档和综合复现实验，不再新增内核功能。

## 12. stage9b 实施结果

stage9b 已完成 independent Lab3 patch：

```text
patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch
```

实际实现：

- `SYS_pgcount = 22`，仅用于 clean baseline independent patch。
- `sys_pgcount()` 只统计当前进程，不接收 pid。
- `uvmpagecount(pagetable, sz)` 遍历 `0 <= va < sz`，使用 `walk(pagetable, va, 0)`，只统计 `PTE_V && PTE_U`。
- 不输出物理地址，不暴露 PTE 原始值，不修改 page fault 或 lazy allocation 逻辑。
- `pgcounttest` 真实计算 delta，不硬编码成功。

真实验证：

```bash
bash scripts/xv6/check-xv6-baseline.sh
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch
make
cd ../..
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount eager delta = 2"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta before touch = 0"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta after two touches = 2"
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"
```

结果：以上均 PASS。`make` 只出现 baseline 常见 `LOAD segment with RWX permissions` linker warning。

仍未完成：

- 没有新增 integrated `0006`。
- 没有修改 `scripts/xv6/`。
- 没有把 Lab3 加入 `teammate-verify.sh --full`。
- 两位队友在 commit `1ba9db6` 的 full PASS 不覆盖 Lab3。
