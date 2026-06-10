# OUC xv6 Lab Kit 技术报告 v1.0

> 项目：2026 全国大学生计算机系统能力大赛 - 操作系统设计赛（全国）- OS 功能挑战赛道 proj54  
> 队伍：中国海洋大学“蓝色系统队”  
> 定位：面向中国海洋大学操作系统课程的 xv6-riscv 分阶段实验指导、参考实现与可复现验证体系  
> historical stable checkpoint commit：`e8e2fb9 feat(integrated): add lab3 pgcount and lab4 fdcount workflow`（integrated `0001-0007`，rain/root/z2996 三方 full PASS）
> stage11b：integrated 主线扩展为 `0001-0009`（新增 memstat `0008` / fdinfo `0009`）；new final commit、三方 full verify、video、SHA256 均为 TBD
> evidence commit：`03aad04 docs: record final integrated verification evidence`（covers `0001-0007`）

## 1. 摘要

OUC xv6 Lab Kit 是一个面向操作系统课程教学的 xv6-riscv 实验包。本项目不是内核实现赛道的 LTP 覆盖项目，也不是单纯堆叠系统调用 demo，而是围绕 proj54“面向操作系统课程的操作系统竞赛和实验”的要求，构建一套学生能看懂、老师能布置、助教能验收的课程实验体系：每个 lab 配教程式 README 和可直接布置的 `student_tasks.md`（含评分 rubric），教师侧另有 `docs/teacher_guide.md`、`docs/grading_and_rubric.md` 和 `docs/troubleshooting.md`。仓库首页以学习者为第一读者，比赛证据材料分层放在 `submissions/` 与 `docs/final/`。

当前版本完成 Lab0 到 Lab5 的完整教学闭环：Lab0 建立 baseline/build/boot 入口，Lab1 引导学生理解系统调用机制，Lab2 观察进程状态与状态计数，Lab3 通过 `pgcount()` 观察用户页表映射数量并对比 eager/lazy allocation，Lab4 通过 `fcount()` / `fdcount()` 观察全局 file table 与当前进程 fd table，Lab5 将前述实验组织成 capstone 综合复现实验。stage11b 进一步把进阶 `memstat` / `fdinfo` 观察接口（`argaddr/argint + copyout + struct ABI`）纳入 integrated 主线，最终 integrated patch sequence 扩展为 `0001-0009`，可从 clean xv6-riscv baseline 顺序应用并完成构建和验证。

实现主线覆盖 Lab0-Lab4；Lab5 是 capstone 综合复现实验，用于组织 clean baseline、integrated patches、验证命令、证据摘要和实验报告，不是新增内核机制。

已有证据链（historical stable checkpoint）包括队长本机 `rain`、队友 `root`、队友 `z2996` 三方 full verification PASS，以及 final integrated `0001-0007` 演示视频元数据与 SHA256；它们只覆盖 `e8e2fb9 / 0001-0007`。stage11b 把 integrated 扩展为 `0001-0009` 后，队长本机已用 `local-verify --full` 实测 overall PASS（含 memstattest/fdinfotest），但覆盖 `0001-0009` 的 new final commit、rain/root/z2996 三方 full verify、新演示视频和新 SHA256 仍为 **TBD**，须在用户重新复现后填写，不得伪造。原始日志、summary、截图、视频均作为外部证据保存，不提交 Git；仓库只保存摘要、元数据、SHA256 和边界说明。

## 2. 赛题理解与项目定位

proj54 的核心是“面向操作系统课程的操作系统竞赛和实验”。因此，本项目以课程实验包为目标，不把重点放在大规模内核功能扩展或 LTP 指标覆盖上。项目按照评分关注点组织材料：

| 评分项 | 权重 | 本项目对应 |
| --- | ---: | --- |
| 文档完整度 | 50% | `docs/final/` 正式文档、每个 lab 的目标/前置知识/文件/步骤/关键代码/常见错误/测试/预期输出/扩展问题、提交证据 manifest |
| 实现完整度 | 30% | Lab0-Lab4 的功能实验与 integrated `0001-0009` patch sequence（含进阶 memstat `0008` / fdinfo `0009`）；Lab5 capstone 复现实验 |
| 测试完整度 | 10% | `doctor.sh`、`apply-integrated-labs.sh`、`boot-xv6.sh`、`run-xv6-command.sh`、`teammate-verify.sh`、`local-verify.sh`、三方 full verification |
| 创新性 | 10% | OUC 本校课程叙事、clean-baseline patch workflow、一键队友复现、QEMU timeout/cleanup 体验、AI 使用透明记录 |

项目的直接教学对象是第一次接触 xv6、Linux 命令行和内核实验的低年级学生。设计原则是“先会复现，再能修改，再理解设计”，尽量把系统调用、进程表、页表、文件表这些抽象概念变成可运行、可观察、可讨论的实验。

## 3. 总体设计：OUC xv6 Lab Kit

本项目采用“文档 + patch + 脚本 + 证据”的组织方式：

| 组成 | 作用 |
| --- | --- |
| `docs/final/` | 面向评委和正式提交的文档体系 |
| `labs/` | 面向学生的分阶段实验说明 |
| `patches/lab*/` | 独立实验 patch，适合单独教学 |
| `patches/integrated-labs/` | 综合演示 patch sequence，统一 syscall number |
| `scripts/xv6/` | baseline 检查、应用 patch、boot/命令验证、队友一键复现、QEMU 清理 |
| `submissions/` | 提交 checklist、证据 manifest、视频和队友复现摘要 |

第三方 xv6-riscv 源码位于 `external/xv6-riscv/`，不进入 Git。仓库提交的是本队增量：patch、文档、脚本、测试记录和证据索引。这样的边界便于评委从 clean baseline 复现，也避免把第三方源码误写成本队代码。

总体架构与证据流如下：

```text
xv6-riscv clean baseline
  -> independent lab patches
  -> integrated-labs 0001-0009
  -> apply/make/boot/run scripts
  -> lead + teammate full verification
  -> evidence manifest + report + PPT
```

## 4. 实验体系总览

| Lab | 主题 | 核心输出 | 教学价值 |
| --- | --- | --- | --- |
| Lab0 | baseline/build/boot | 环境检查、baseline metadata、make、boot evidence | 降低首次进入 xv6 的环境门槛 |
| Lab1 | 系统调用机制 | `hello()`、`add2(int,int)` | 从最小 syscall 到参数传递，理解 user/kernel 边界 |
| Lab2 | 进程状态观察 | `pstate()`、`pcount()`、`pchildtest` | 观察进程表、状态枚举、锁和调度时序 |
| Lab3 | 页表映射观察 | `pgcount()`、`pgcounttest` | 连接用户地址空间、PTE 标志、eager/lazy allocation |
| Lab4 | 文件表与 fd 表观察 | `fcount()`、`fdcount()` | 连接用户 fd、`struct file`、全局 file table、引用计数 |
| Lab5 | capstone 综合复现 | clean baseline -> integrated `0001-0009` -> full verification | 把多个实验组织成可复现、可报告的课程综合实验 |

Lab5 不新增内核机制。它的价值是把课程实验、验证命令、证据记录和报告要求组织成一次综合复现实验。

## 5. Lab0：baseline/build/boot

Lab0 的目标是让学生在正式修改 xv6 之前先建立可信环境。它包括：

- 确认 WSL2 Ubuntu 或等价 Linux 环境。
- 检查 `git`、`bash`、`make`、`qemu-system-riscv64` 和 RISC-V 交叉编译工具链。
- 记录 xv6-riscv baseline commit：`74f84181a3404d1d6a6ff98d342233979066ebb8`。
- 运行 make 与 boot evidence 捕获。

对应脚本包括 `scripts/xv6/check-xv6-baseline.sh`、`scripts/xv6/boot-xv6.sh` 和 `scripts/xv6/doctor.sh`。Lab0 的教学意义在于把“环境是否可用”从经验判断变成可检查、可复现的步骤，减少学生在工具链和 QEMU 问题上消耗过多时间。

## 6. Lab1：系统调用机制 hello/add2

Lab1 从最小系统调用 `hello()` 开始，再扩展到带整数参数的 `add2(int,int)`。它覆盖 xv6 系统调用路径中的关键文件：

- `kernel/syscall.h`
- `kernel/syscall.c`
- `kernel/sysproc.c`
- `user/user.h`
- `user/usys.pl`
- `Makefile`
- 用户测试程序 `hello.c`、`add2test.c`

`hello()` 用于建立“用户态调用 -> syscall stub -> 内核 syscall 分发 -> 返回用户态”的基本链路。`add2()` 则引入参数读取，让学生理解 `argint()` 这类参数解析机制。测试不依赖复杂状态，只匹配 `hello syscall returned 2026` 和 `add2(20, 6) returned 26` 等稳定输出，适合作为后续实验的入门样例。

系统调用教学路径可以概括为：

```text
user program
  -> user/usys.pl generated stub
  -> ecall into kernel
  -> kernel/syscall.c dispatch table
  -> sys_* handler
  -> return value back to user space
```

## 7. Lab2：进程状态观察 pstate/pcount/pchildtest

Lab2 让学生从系统调用进入进程表。它包括：

- `pstate(pid)`：观察指定进程状态。
- `pcount(state)`：统计处于某个状态的进程数量。
- `pchildtest`：观察子进程状态，帮助理解调度时序。

教学重点不是实现完整 `ps`，也不是修改调度器，而是让学生看见 xv6 进程状态、`struct proc`、锁保护和快照语义。文档明确说明：

- `pcount(RUNNING)` 的具体数字不固定。
- `pchildtest` 的状态受调度时序影响，不应写成固定状态。
- timeout 捕获的输出只是可复现 evidence，不等于长期稳定性测试。

## 8. Lab3：页表映射与 eager/lazy allocation 观察 pgcount

Lab3 的核心是 `pgcount()`：统计当前进程用户页表中有效且用户可访问的页映射数量。integrated `0006` 使用 `SYS_pgcount = 27`。核心逻辑是遍历当前进程 `[0, p->sz)` 范围内的虚拟地址，调用 `walk(pagetable, va, 0)`，只统计 `PTE_V && PTE_U`，不分配页、不修改 PTE、不输出物理地址。

`pgcounttest` 分为 eager 与 lazy 两段：

- eager `sbrk(2 * PGSIZE)` 后，真实计算得到 `pgcount eager delta = 2`。
- lazy `sbrklazy(2 * PGSIZE)` 后，未触碰前 delta 为 0。
- 触碰第一页后 delta 为 1。
- 触碰第二页后 delta 为 2。

这个实验的教学价值在于把“进程地址空间大小”和“页表中实际存在的映射”区分开，并用 baseline 已有 eager/lazy allocation 行为解释按需分配。边界也很明确：它不是完整内存管理实验，不改 page fault/lazy allocation 逻辑，不暴露物理地址。

`pgcount()` 的核心伪代码如下，重点是只读观察，不分配、不修改：

```c
int
uvmpagecount(pagetable_t pagetable, uint64 sz)
{
  int count = 0;
  for(uint64 va = 0; va < sz; va += PGSIZE){
    pte_t *pte = walk(pagetable, va, 0);
    if(pte && (*pte & PTE_V) && (*pte & PTE_U))
      count++;
  }
  return count;
}
```

## 9. Lab4：文件表与 fd table 观察 fcount/fdcount

Lab4 v0.2 包含两个观察接口：

- `fcount()`：观察 xv6 全局 file table 中引用计数大于 0 的 `struct file` 数量。
- `fdcount()`：观察当前进程 `ofile[]` 中非空 fd 数量。

integrated `0005` 引入 `fcount()`，integrated `0007` 引入 `fdcount()`，其中 `SYS_fcount = 26`，`SYS_fdcount = 28`。`fdcounttest` 通过 open、dup、close 观察当前进程 fd table 的变化，并把全局 `fcount()` 作为对比输出。

该实验的教学价值是帮助学生理解：

- 用户态 fd 只是进程内的描述符编号。
- fd 指向内核 `struct file`。
- `dup()` 会增加 fd 引用，但不一定增加全局 file table 条目。
- 全局 file table 和当前进程 fd table 是两个层次。

边界同样明确：`fcount()` / `fdcount()` 不是完整文件系统实现，不涉及 inode 布局、磁盘块管理或完整文件系统工具。

Lab4 的两层观察关系如下：

```text
current proc.ofile[fd]
  -> struct file
  -> global ftable[]

fdcount(): current process fd table
fcount():  global file table entries with ref > 0
```

`fdcount()` 的核心逻辑只遍历当前进程 fd table：

```c
int
sys_fdcount(void)
{
  struct proc *p = myproc();
  int count = 0;
  for(int fd = 0; fd < NOFILE; fd++)
    if(p->ofile[fd] != 0)
      count++;
  return count;
}
```

## 10. Lab5：capstone 综合复现实验

Lab5 是综合复现实验，不是新的内核机制。它要求学生从 clean xv6-riscv baseline 出发，顺序应用 integrated `0001-0009`，完成：

1. 环境诊断。
2. clean baseline apply。
3. `make`。
4. boot evidence。
5. hello/add2/pstate/pcount/pchild/fcount/pgcount/fdcount/memstat/fdinfo 全部用户程序验证。
6. 阅读每个 patch 对应的教学机制。
7. 提交实验报告和证据摘要。

Lab5 的价值在于把多个分散实验整理成一次完整课程验收流程，使学生不仅能写一个 syscall，也能说明它在整个实验体系中的位置。

## 11. integrated-labs `0001-0009` 补丁序列

最终 integrated sequence 统一了 syscall number，避免独立 patch 之间的编号冲突：

| Patch | 内容 | syscall |
| --- | --- | --- |
| `0001` | hello syscall | `SYS_hello = 22` |
| `0002` | add2 argint syscall | `SYS_add2 = 23` |
| `0003` | pstate syscall | `SYS_pstate = 24` |
| `0004` | pcount + process observation tests | `SYS_pcount = 25` |
| `0005` | fcount file table observation | `SYS_fcount = 26` |
| `0006` | pgcount page-table observation | `SYS_pgcount = 27` |
| `0007` | fdcount fd table observation | `SYS_fdcount = 28` |
| `0008` | memstat 地址空间观察（argaddr + copyout + struct ABI；复用 `uvmpagecount`） | `SYS_memstat = 29` |
| `0009` | fdinfo fd 元数据观察（argint + argaddr + copyout + struct ABI；自查 `ofile[fd]`） | `SYS_fdinfo = 30` |

该序列可由 `scripts/xv6/apply-integrated-labs.sh --make --yes` 从 clean baseline 应用并构建。它既保留了独立实验 patch 的教学用途，也提供了评委和队友可一次性复现的综合演示路径。

## 12. 自动化验证与队友复现体系

本项目的验证体系包括：

| 工具 | 作用 |
| --- | --- |
| `doctor.sh` | 只读环境诊断，不运行 make/QEMU |
| `apply-integrated-labs.sh` | clean baseline reset/clean/apply integrated patches，可选 make |
| `boot-xv6.sh` | 捕获 boot 关键文本并处理 timeout/cleanup |
| `run-xv6-command.sh` | 运行 xv6 用户程序并匹配真实 QEMU 输出 |
| `teammate-verify.sh` | 队友一键 full/quick 验证，输出 copy-to-lead summary |
| `local-verify.sh` | 队长本机录屏前预检 wrapper |
| `cleanup-qemu.sh` | 处理 QEMU 卡住或 Ctrl+Z suspend 的救援工具 |

历史稳定检查点（historical stable checkpoint）的三方 full verification 已完成，覆盖 `e8e2fb9 / 0001-0007`：

| 角色 | user | commit | suite | mode | result |
| --- | --- | --- | --- | --- | --- |
| 队长本机 | `rain` | `e8e2fb9` | `0001-0007` | full | PASS（historical） |
| 队友 A | `root` | `e8e2fb9` | `0001-0007` | full | PASS（historical） |
| 队友 B | `z2996` | `e8e2fb9` | `0001-0007` | full | PASS（historical） |

该三方 full verification 覆盖 doctor/check-env/baseline/apply+make/boot/hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest/pgcounttest/fdcounttest/overall，但**只覆盖 `0001-0007`**（不含 memstat/fdinfo）。stage11b 把 integrated 扩展为 `0001-0009` 后，队长本机已用 `local-verify --full` 实测 overall PASS（新增 memstattest/fdinfotest），但 `0001-0009` 的 rain/root/z2996 三方 full verify 尚未进行，为 **TBD**，须在用户重新复现后填写，不得伪造。原始 summary、console log 和截图不提交 Git；文字摘要与 SHA256 记录在 `submissions/teammate_reproduction_record.md` 和 `submissions/evidence_manifest.md`。

## 12.1 进阶观察实验：memstat / fdinfo（独立 + integrated `0008` / `0009`）

项目提供两个进阶观察接口，演示内核如何用 `copyout` 把结构体安全拷回用户态。它们同时有 independent 版（`SYS_*=22`，单独教学）和 integrated 版（stage11b 进入主线 `0008` / `0009`）：

- `memstat`：independent `patches/lab3-memory-and-pagetable/0002-add-memstat-syscall.patch`，integrated `patches/integrated-labs/0008-add-memstat-copyout-observation.patch`（`SYS_memstat = 29`，复用 `0006` 的 `uvmpagecount()`）。`memstat(struct memstat *out)` 返回 `{sz_bytes, mapped_pages, page_size}`，教学点 `argaddr + copyout + struct ABI`。
- `fdinfo`：independent `patches/lab4-file-table-observation/0002-add-fdinfo-syscall.patch`，integrated `patches/integrated-labs/0009-add-fdinfo-copyout-observation.patch`（`SYS_fdinfo = 30`，`fileinfo()` 在 `ftable.lock` 下读取）。`fdinfo(int fd, struct fdinfo *out)` 返回 `{type, readable, writable, ref}`，教学点 `argint + argaddr + copyout + struct ABI`，只查当前进程 `ofile[fd]`，不返回路径/inode 号/内容。

这两个实验的教学价值不在于"多了两个 syscall"，而在于补上了前七个实验都没覆盖的机制：前面所有 syscall 都用 int 返回值就能交差，`memstat`/`fdinfo` 第一次要求内核把**结构体**安全地写回用户缓冲区——学生因此必须面对 `argaddr` 取用户指针、`copyout` 做地址检查、内核/用户共享 struct ABI、坏指针返回 -1 这一整条链路，这正是读懂真实内核接口（如 Linux 的 `stat`/`sysinfo`）的最小前置。

independent 版从 clean baseline round-trip 验证通过（`SYS_*=22`，彼此不可叠加）；integrated 版已进入主线 `0001-0009`，并在队长本机 `local-verify --full` overall PASS（含 memstattest/fdinfotest）。但上面表中的三方 full verification 和 final video 只覆盖 `0001-0007`（historical），**不覆盖** `0001-0009`；含 memstat/fdinfo 的 `0001-0009` 队友 full verify、重录视频、重算 SHA256 仍为 **TBD**，不得伪造。两个结构体均在 copyout 前写满且无 padding，不泄漏未初始化内核栈字节；`memstat` 不是完整内存管理实验，`fdinfo` 不是完整文件系统实验，二者都不返回物理地址/路径/inode 号/内容。

## 13. 演示视频与证据链

历史稳定检查点（historical stable checkpoint）的视频证据为（只覆盖 `0001-0007`）：

| 字段 | 内容 |
| --- | --- |
| 文件名 | `20260606_final_integrated_0001_0007_demo.mp4` |
| scope | historical stable checkpoint：integrated `0001-0007` verification demo for commit `e8e2fb9`（不覆盖 `0001-0009`） |
| 大小 | `12,120,565 bytes` |
| 时长 | `00:01:32` |
| 分辨率 | `2560x1440` |
| 帧率 | `60 fps` |
| SHA256 | `0FF2D3581552B3FD3A2630E827251CF46C36BC3BE8F8B9D9DDB691FC0668A93B` |

旧三段视频和旧 `1ba9db6` 队友证据保留为 historical/superseded evidence，只能说明 earlier integrated `0001-0005` / stage7-stage8 workflow，不覆盖 final `e8e2fb9`。

覆盖 `0001-0009`（含 memstat/fdinfo）的新演示视频和新 SHA256 尚未录制，为 **TBD**，须在用户重新复现后录制并登记，不得伪造。视频、截图、raw logs 和 summary 原件均保存在仓库外，仓库只记录元数据和 SHA256。视频/截图最终隐私复核仍为 `pending final manual review`，平台提交方式也仍需最终确认。

## 14. 创新点与教学价值

本项目的创新点不在于把 xv6 改成复杂内核，而在于把课程实验真正做成可教学、可复现、可验收的体系：

1. **分阶段教学路径清晰**：从环境、系统调用、进程、页表、文件表逐步深入，最后用 `memstat`/`fdinfo` 补上 copyout/struct ABI 这块常被入门实验跳过的拼图。
2. **clean-baseline patch workflow**：每个实验可追溯到 baseline，integrated sequence 可统一演示。
3. **队友一键复现**：将复杂 QEMU/make/timeout 过程封装成 full/quick workflow。
4. **证据链透明**：区分本机验证、队友复现、视频证据、历史证据和未提交原始材料。
5. **诚实边界明确**：不把 timeout 写成长期稳定性，不把 fcount/fdcount 写成完整文件系统，不把 pgcount 写成完整内存管理。
6. **可直接开课的教学材料**：每个 lab 有教程式 README + 学生任务书（必做/选做/评分 rubric/常见扣分点），配教师指南（2/3/5 次课三种排法）、评分标准和按"症状-原因-解决"组织的 troubleshooting，学生任务以预测-验证和破坏-修复为主，刻意不给现成答案。
7. **OUC 本校适配**：面向低年级学生和助教维护，把竞赛项目转化为课程实验包。

与同类教学项目相比，本项目的差异化不是“更完整地重做一个 OS 课程生态”，而是聚焦 OUC 本校、xv6-riscv、clean-baseline patch 和提交友好复现：

| 对比对象 | 更典型的侧重点 | 本项目差异化 |
| --- | --- | --- |
| uCore / rCore | 完整课程体系、较完整 OS 教学路线或 Rust OS 生态 | 本项目不重写其路线，聚焦 OUC 低年级 xv6-riscv 入门实验 |
| YatSen OS / F-Tutorials | 课程材料、tutorial 组织和竞赛展示参考 | 本项目只作定位性对比，不复制代码、PPT、图片或大段文本 |
| 本项目 | 课程实验包 + 可复现验证 + 提交证据链 | clean-baseline patch、integrated `0001-0009`、`0001-0007` 三方 full PASS（historical）、evidence manifest |

## 15. 参考来源、许可证与本队增量贡献

本项目基于 xv6-riscv，上游仓库为 `https://github.com/mit-pdos/xv6-riscv.git`，baseline commit 为 `74f84181a3404d1d6a6ff98d342233979066ebb8`，LICENSE 为 MIT License。`external/xv6-riscv/` 不入仓，本仓库只提交增量 patch、脚本、文档和证据摘要。

uCore、rCore、YatSen OS、F-Tutorials 和往届 OS 竞赛作品只作为课程组织和提交材料展示的参考候选。具体 URL 与许可证仍需最终核对；在未核对前，不复制其代码、图片、PPT 或大段文本。

本队增量贡献包括：

- Lab1-Lab4 独立实验 patch 与 integrated `0001-0009`（含进阶 memstat `0008` / fdinfo `0009`）。
- OUC 本校课程化实验组织。
- 一键复现与队友验证 workflow。
- final evidence manifest 和提交边界说明。
- 面向评委的正式文档体系与技术报告。

## 16. AI 工具使用说明

本项目使用 AI 工具辅助规划、任务拆解、红队审查、文档整理和部分工程落地。AI 不替代真实 make/QEMU/boot/用户程序验证，不伪造 PASS，不伪造日志，不伪造队友复现，不提交未验证产物。

已记录的 AI 使用原则包括：

- GPT-5.5 Thinking Advanced 用于全流程问答辅助、任务拆分、红队判断、提示词生成、验收标准和调度。
- Claude Desktop / Opus 4.8 Max 用于困难任务、大方向规划、红队审核。
- Codex 用于中等难度工程落地、文档整理、PPT 生成。
- VSCode 侧边栏 + CCswitch DeepSeek v4pro 1M 用于简单施工，在明确指导下完成低风险任务。

所有最终工程事实以真实命令结果、队友反馈摘要、外部证据元数据和 Git 仓库内容为准。

## 17. 已知限制与后续工作

当前已知限制：

- `pgcount()` 只是页表映射数量观察，不是完整内存管理实验。
- `fcount()` / `fdcount()` 只是 file table / fd table 观察，不是完整文件系统实现。
- `memstat()`（integrated `0008`）只是地址空间页数观察，不是完整内存管理；`fdinfo()`（integrated `0009`）只是 fd 元数据观察，不是完整文件系统；二者都不返回物理地址/路径/inode 号/内容。
- integrated 已扩展为 `0001-0009`，但 `0001-0009` 的 rain/root/z2996 三方 full verify、新视频、新 SHA256 仍为 TBD；旧 `e8e2fb9 / 0001-0007` 三方 full PASS 与 final video 只作 historical stable checkpoint，不覆盖 `0001-0009`。
- Lab5 是 capstone 综合复现实验，不是新增内核机制。
- timeout/fast-exit 证据不等于长期稳定性测试。
- 视频/截图最终隐私复核仍为 `pending final manual review`。
- 平台提交方式仍需按比赛官方要求确认。
- 队友真实姓名、系统版本如最终材料需要，仍需人工补充。
- uCore/rCore/YatSen OS/F-Tutorials/往届作品的 URL 与许可证仍需最终核对。

后续工作建议：

1. 使用 `slides/final_ppt.md` 与 `slides/final_defense_ppt.pptx` 进行最终答辩排练和人工审阅。
2. 完成平台提交方式确认与隐私复核。
3. 对外部证据文件按 SHA256 逐项核验。
4. 如课程后续继续使用，可增加学生骨架版、评分脚本和更多扩展实验。
