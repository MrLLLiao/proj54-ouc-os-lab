# 教师/助教指南：怎么用这套实验上课

> 维护时间：2026-06-10（stage12）。适用 suite：integrated `0001-0009`。

这份指南写给要把 OUC xv6 Lab Kit 布置给学生的老师和助教。学生侧入口是根 [README.md](../README.md) 和各 lab 的 `README.md` + `student_tasks.md`；这里只讲怎么排课、怎么验收、怎么处理学生环境问题。

## 课次安排：2 次、3 次、5 次三种切法

**2 次课（最小可用，适合讲座+一次大作业）**

| 次 | 内容 | 布置 |
| --- | --- | --- |
| 1 | 环境 + Lab0 boot + Lab1 syscall 路径现场走一遍 | Lab1 student_tasks（必做 T1-T3） |
| 2 | Lab2/Lab3 的"观察"思想 + copyout 讲解 | Lab5 capstone 当大作业 |

**3 次课（推荐）**

| 次 | 内容 | 布置 |
| --- | --- | --- |
| 1 | 环境、Lab0、Lab1（syscall 七件套现场演示一次破坏-修复） | Lab1 任务书 |
| 2 | Lab2 进程表+锁，Lab3 页表+eager/lazy 现场量 delta | Lab2 或 Lab3 任务书（二选一必做，另一份选做） |
| 3 | Lab4 三层关系 + `memstat`/`fdinfo` 的 copyout 对比 | Lab4 任务书 + Lab5 capstone |

**5 次课（完整）**：每个 lab 一次课，Lab5 当期末验收。每次课结构建议：前 30 分钟讲机制（用 lab README 的"这一关学什么/为什么重要"当提纲），中间 40 分钟学生跑验证命令，最后 20 分钟讲常见卡点。

## 哪些必做、哪些是扩展

- **必做主线**：Lab0 → Lab1 → Lab2（或 Lab3）→ Lab5。这条线覆盖 syscall、锁、可复现三大目标。
- **强烈建议**：Lab3 的 `memstat` 和 Lab4 的 `fdinfo`（copyout + struct ABI）。如果学生只学 int 返回值的 syscall，等于没见过内核↔用户态数据传输的正经写法。
- **选做**：各任务书的 C 题；Lab4 的 `fork` 共享实验（C1）。
- **不要布置**：修改调度器、改文件系统布局之类的"大手术"——这套实验的边界刻意停在"观察"，扩展请先看 `docs/final/11_known_limits_and_future_work.md`。

## 怎么验收

1. **统一收 summary**：要求学生报告里贴 `teammate-verify.sh --full` 输出的 `COPY THIS SUMMARY TO TEAM LEAD` 块。它自带时间、commit、user、逐项 PASS/FAIL，批量核对很快。
2. **抽查防伪**：随机抽 10-20% 学生，当面让他重跑一条命令（比如 `run-xv6-command.sh memstattest "memstattest done"`），或问一个 T3 级别的路径问题。summary 的 commit 行和时间戳对不上的直接谈话。
3. **看增量 patch 而不是全目录**：学生交 `git diff` 出来的 patch。patch 里若出现打印写死答案的测试程序，按伪造处理（评分标准见 [grading_and_rubric.md](grading_and_rubric.md)）。
4. **报告里必须有失败**：要求至少一条真实异常记录（Lab5 任务书 T4 已内置）。全程零波折的报告基本是抄的。

## 学生环境问题怎么处理

最常见的五类问题和处理顺序在 [troubleshooting.md](troubleshooting.md)，助教先读一遍。要点：

- 统一要求 WSL2 Ubuntu（或实验室 Linux）。Windows Git Bash 只能看文档，不能 make。
- 开课前发 `bash scripts/xv6/doctor.sh`，让学生把输出带来——它会检查 git/make/qemu/交叉编译器，10 秒定位环境缺什么。
- `/mnt/d/...` 路径下第一次 boot 慢是 drvfs 特性，不是坏了；愿意折腾的学生可以把仓库放进 WSL 的 ext4 家目录。
- 学生说"卡住了"：第一句话永远是"你按过 Ctrl+Z 吗"，第二句是"跑 `bash scripts/xv6/cleanup-qemu.sh`"。
- `riscv64-unknown-elf-gcc` 缺失是 WARN 不是错误，`riscv64-linux-gnu-gcc` 就够。

## 给助教的三个提醒

1. independent patch 之间 `SYS_*` 都是 22，**互相不可叠加**——学生把 lab2 patch 往 lab1 之上 apply 失败不是 bug，是设计（教材级的编号冲突案例，可以现场讲）。组合一律走 integrated `0001-0009`（编号 22-30）。
2. `pcount`/`fcount` 的数值、`pchildtest` 的状态都不固定，验收只认前缀和 delta。别给学生定"必须输出 1"的标准。
3. timeout 自动捕获只证明那次匹配到了预期文本。学生（或你自己）都不要把它写成长期稳定性测试。
