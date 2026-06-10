# Lab5：综合复现（capstone）

## 这一关学什么

- 从干净的 xv6 源码出发，一口气应用 integrated `0001-0009` 九个 patch，构建、启动、跑全部 10 个测试程序，并把过程整理成一份有证据的实验报告。
- 学会"可复现"的工程含义：别人在另一台机器上按你的报告操作，应该得到同样的结果。
- 学会区分证据等级：自动捕获 vs 人工演示、本机验证 vs 他人复现、当前结果 vs 历史记录。

## 为什么重要

前四关你每次只面对一个实验；这一关像真实项目验收：环境诊断 → 干净基线 → 按序应用 → 构建 → 验证 → 报告。它不新增任何内核机制，考察的是你能否把已有工作组织成别人可以检查、可以重跑的东西——这恰恰是课程实验和竞赛提交里最常丢分的部分。

## 和前面 Lab 的关系

把 lab0 到 lab4 的内容串成一次完整、可复现、可汇报的 OS 课程综合实验。Lab5 不新增新的内核机制；它要求学生从 clean xv6-riscv baseline 出发，顺序应用 integrated `0001-0009`（stage11b 起的 current integrated suite），完成构建、启动、用户程序验证、证据记录和实验报告。

本实验覆盖：

- lab0：baseline、环境、make、boot。
- lab1：`hello()` 与 `add2(int, int)` 系统调用。
- lab2：`pstate()`、`pcount()` 与子进程状态观察。
- lab3：`pgcount()` 页表映射数量观察，以及 eager/lazy allocation 对比。
- lab4：`fcount()` 全局 file table 观察与 `fdcount()` 当前进程 fd table 观察。
- lab3/lab4 进阶（stage11b 进入 integrated）：`memstat()`（`0008`，argaddr + copyout + struct ABI）与 `fdinfo()`（`0009`，argint + argaddr + copyout + struct ABI）。

## 前置知识

- 已完成 lab0-lab4 的阅读和单项测试。
- 理解 xv6-riscv 的 syscall 添加路径：`syscall.h`、`syscall.c`、`sysproc.c` / `sysfile.c`、`user.h`、`usys.pl`、`Makefile`。
- 理解复现边界：`external/xv6-riscv/` 和 `logs/` 不提交 Git；QEMU timeout 捕获不是长期稳定性测试。
- 知道 `pcount`、`pchildtest`、`fcount` 的具体数值可能受运行时状态影响，不能写死绝对值。

## 学生任务

1. 运行环境诊断：

   ```bash
   bash scripts/xv6/doctor.sh
   ```

2. 从 clean baseline 应用 integrated patch sequence 并构建：

   ```bash
   bash scripts/xv6/apply-integrated-labs.sh --make --yes
   ```

3. 启动 xv6 并捕获 boot evidence：

   ```bash
   bash scripts/xv6/boot-xv6.sh
   ```

4. 运行全部用户程序验证：

   ```bash
   bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
   bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
   bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
   bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
   bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
   bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
   bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
   bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"
   bash scripts/xv6/run-xv6-command.sh fdcounttest "fdcounttest done"
   bash scripts/xv6/run-xv6-command.sh memstattest "memstattest done"
   bash scripts/xv6/run-xv6-command.sh fdinfotest "fdinfotest done"
   ```

5. 阅读 `patches/integrated-labs/0001-0009`，说明每个 patch 对应的 syscall、用户程序和教学主题（`0008`/`0009` 的主题是 argaddr/argint + copyout + struct ABI）。

6. 提交实验报告，报告至少包含：

   - 环境信息和 commit。
   - `apply-integrated-labs.sh --make --yes` 结果。
   - boot evidence。
   - 各用户程序验证结果。
   - 每个 syscall 的实现路径解释。
   - 失败时的排查过程。
   - 没有提交 `external/`、`logs/`、隐私材料的说明。

## 常见错误

- 把 `Ctrl+Z` 当成退出。`Ctrl+Z` 是挂起，卡住后应运行 `bash scripts/xv6/cleanup-qemu.sh`。
- 只看到 `[OK] make completed successfully` 后继续等待。该行出现即说明 apply+make 已完成。
- 把 `pgcount()` 说成完整内存管理实验。它只观察当前进程用户页表映射数量。
- 把 `fcount()` / `fdcount()` 说成完整文件系统实验。它们只观察 file table / fd table 计数。
- 把旧队友 summary 写成新 HEAD 复现。`e8e2fb9 / 0001-0007` 三方 PASS 是 historical stable checkpoint，不覆盖 `0001-0009`；stage11b 后需要重新收集 teammate `--full`。
- 把 `memstat()` 说成完整内存管理或把 `fdinfo()` 说成完整文件系统。它们只是 copyout 结构体观察。

## 评分 Rubric

| 项目 | 分值 | 要求 |
| --- | ---: | --- |
| 环境与构建 | 20 | doctor、clean apply、make 结果真实完整 |
| 启动与验证 | 25 | boot 和全部用户程序验证命令通过 |
| 机制解释 | 25 | 能解释 syscall 路径、进程表、页表、file table、fd table |
| 证据与诚信 | 20 | 不伪造 PASS；不提交 raw logs/external；记录失败和边界 |
| 扩展思考 | 10 | 能提出 lab3/lab4 后续扩展，但不夸大当前实现 |

## 自己动手任务

完整任务书和验收标准见 [student_tasks.md](student_tasks.md)。

## 扩展问题

1. 为什么 `pgcount()` 只统计 `PTE_V && PTE_U`？
2. 为什么 `sbrklazy()` 触摸前 `pgcount` 不增加？
3. `fcount()` 与 `fdcount()` 的观察对象有什么区别？
4. 为什么 `dup(fd)` 会增加 `fdcount()`，但不一定增加 `fcount()`？
5. `memstat()` 和 `fdinfo()` 为什么必须用 `copyout` 而不能直接写用户指针？
6. 如果把 Lab5 拍成演示视频，应如何避免泄露 token、密码和个人信息？

## 不要误解什么

- Lab5 **不新增内核机制**——九个 syscall 都是前面各关加的，这一关考察组织与复现。
- "我机器上跑通了" ≠ "可复现"：报告里要写清 baseline commit、patch 顺序、真实命令和输出，失败也要如实记录。
- 旧证据不覆盖新 suite：`e8e2fb9 / 0001-0007` 三方 PASS 是 historical checkpoint，当前 `0001-0009` 的队友复现/新视频为 TBD。

## 下一步看哪里

- 当助教/老师：[docs/teacher_guide.md](../../docs/teacher_guide.md) 讲怎么布置和验收这套实验。
- 看证据怎么管理：[submissions/evidence_manifest.md](../../submissions/evidence_manifest.md)。
- 卡住了：[docs/troubleshooting.md](../../docs/troubleshooting.md)。

## 当前状态

stage11b 已把 capstone workflow 扩展到 integrated `0001-0009`（新增 memstat `0008` / fdinfo `0009`），并在队长本机完成 `local-verify.sh --full` overall PASS（含 `memstattest`/`fdinfotest`）。证据边界：

- `e8e2fb9` 的 rain/root/z2996 三方 full PASS 与 `0001-0007` 视频是 historical stable checkpoint，只覆盖 `0001-0007`，不覆盖 `0001-0009`。
- 两位队友在更早 commit `1ba9db6` 的 full PASS 只覆盖 earlier `0001-0005`，同样是历史证据。
- 含 `memstattest`/`fdinfotest` 的 `0001-0009` 队友复现、新演示视频、新 SHA256 均为 TBD：正式提交前需要在新 commit 上重新收集团队成员的 `teammate-verify.sh --full` summary 并重录视频，不得伪造。
