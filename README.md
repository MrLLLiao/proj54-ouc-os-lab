# OUC xv6 Lab Kit：从零开始的操作系统实验

这是一个用 xv6-riscv 学操作系统的教学实验包。它不假设你写过内核：从"把 xv6 跑起来"开始，一关一关带你看懂系统调用、进程、页表、文件表，最后你能自己给内核加一个系统调用，并解释它从用户态到内核态的完整路径。

如果你第一次接触 xv6，可以直接从下面的 [Step 0](#从零开始怎么学) 开始，不需要先读完整个 README。

## 这是什么

- 一套基于 [xv6-riscv](https://github.com/mit-pdos/xv6-riscv) 的分阶段实验：Lab0 到 Lab5，外加一条把所有实验合在一个内核里的 integrated patch 路线（`0001-0009`）。
- 每个实验都是"小步增量"：一个 patch、一个用户测试程序、一组能照抄的验证命令。
- 所有实验都能从干净的 xv6 源码一键复现——这不是口号，仓库里有脚本（`scripts/xv6/`）替你做 reset、apply、make、boot、跑测试。
- 仓库不包含 xv6 源码本体（第三方代码不入库），只包含我们写的 patch、脚本、文档和测试记录。

## 适合谁

- 大一/大二，学过一点 C，但没碰过内核的同学。
- 想提前入门操作系统的高中/初中信息学竞赛学生——只要你会用命令行、能看懂指针，就能跟下来。
- 上 OS 课需要做 xv6 实验、想要一套带验收标准的练习的人。
- 想看一个"实验怎么做到可复现、证据怎么留"的完整工程样例的人。

不适合：想找现成大作业答案直接交的人。每个 lab 的 `student_tasks.md` 留了必做任务，答案要你自己写。

## 你会学到什么

按 Lab 顺序，每一关解决一个具体问题：

| 关卡 | 你会搞明白的事 |
| --- | --- |
| Lab0 | xv6 怎么编译、怎么在 QEMU 里启动、`init: starting sh` 之前发生了什么 |
| Lab1 | 用户程序调用 `hello()` 时，怎么穿过 `usys.pl` 生成的 stub、`ecall`、`syscall.c` 分发表，落到内核函数上；`argint()` 怎么把整数参数取出来 |
| Lab2 | 进程在内核里长什么样（`struct proc`）、状态枚举怎么读、为什么观察进程状态要拿锁 |
| Lab3 | 进程地址空间和页表映射的区别；`sbrk` 立刻给页（eager）和先记账后给页（lazy）在页表里看起来差多少 |
| Lab4 | fd、`struct file`、全局 file table 三层关系；`dup` 为什么让 fd 变多但 file table 不一定变多 |
| Lab3/4 进阶 | 内核怎么把一个结构体安全拷回用户态：`argaddr + copyout + struct ABI`（`memstat`/`fdinfo`），为什么不能直接解引用用户指针 |
| Lab5 | 把前面所有实验从干净源码一次性复现，写出一份有证据的实验报告（capstone，不新增内核机制） |

另外你会顺带学到一套工程习惯：为什么实验要可复现、为什么测试程序要自己算 delta 而不是硬编码输出、为什么日志和第三方源码不进 Git。

## 从零开始怎么学

> 所有 make/QEMU 命令都要在 WSL2 Ubuntu 或等价 Linux 里跑，Windows Git Bash 只能看文档。环境装好前别急着跳关。

- **第 0 步：准备环境。** 看 [docs/final/01_environment_setup.md](docs/final/01_environment_setup.md)，装好 `qemu-system-riscv64` 和 RISC-V gcc，然后跑 `bash scripts/xv6/doctor.sh` 体检。
- **第 1 步：Lab0，把 xv6 跑起来。** [labs/lab0-env-setup/README.md](labs/lab0-env-setup/README.md)。看到 `init: starting sh` 这关就过了。
- **第 2 步：Lab1，第一个系统调用。** [labs/lab1-system-call/README.md](labs/lab1-system-call/README.md)。从 `hello()` 到带参数的 `add2(int, int)`。
- **第 3 步：Lab2，观察进程。** [labs/lab2-process-and-scheduling/README.md](labs/lab2-process-and-scheduling/README.md)。`pstate`/`pcount`/`pchildtest`。
- **第 4 步：Lab3，观察页表。** [labs/lab3-memory-and-pagetable/README.md](labs/lab3-memory-and-pagetable/README.md)。`pgcount` 数页，进阶 `memstat` 用 copyout 拷结构体。
- **第 5 步：Lab4，观察文件表。** [labs/lab4-file-system/README.md](labs/lab4-file-system/README.md)。`fcount`/`fdcount` 数数，进阶 `fdinfo` 看单个 fd 的元数据。
- **第 6 步：Lab5，综合复现。** [labs/lab5-final-integration/README.md](labs/lab5-final-integration/README.md)。把全部实验串成一次验收。
- **第 7 步：integrated `0001-0009`。** 一个内核同时装下全部 9 个实验 syscall（编号 22-30），入口见 [patches/integrated-labs/README.md](patches/integrated-labs/README.md)。

每个 lab 目录里有两个文件：`README.md` 是教程，`student_tasks.md` 是练习和验收标准。建议先读教程、跑通验证命令，再做任务。做完一关可以只测这一关：`bash scripts/labctl.sh test lab3`。

## 如果你只想先跑起来

整个课程有一个统一命令入口 `labctl`（它只是封装下面的现有脚本，不重复实现任何逻辑）。在 WSL2 Ubuntu 里：

```bash
bash scripts/labctl.sh doctor        # 环境体检
bash scripts/labctl.sh setup --yes   # 干净源码 + 全部 9 个 patch + make（会重置 ignored 的 external/xv6-riscv/）
bash scripts/labctl.sh boot          # 启动并抓 boot 证据
bash scripts/labctl.sh test lab1     # 只跑 Lab1 的两条检查
bash scripts/labctl.sh test all      # 跑全部 10 条用户程序检查
bash scripts/labctl.sh verify        # 一键 full 验证（等价 teammate-verify.sh --full）
```

`bash scripts/labctl.sh list` 能看到每个 lab 对应哪些测试。想直接用底层脚本也完全可以（`scripts/xv6/` 下的路径都在 labctl help 里标着）。

卡住、报错、或者误按了 `Ctrl+Z`：先跑 `bash scripts/labctl.sh clean`，再看 [docs/troubleshooting.md](docs/troubleshooting.md)。`/mnt/` 路径下第一次 boot 偏慢是正常的。

## 如果你是老师或助教

- [docs/teacher_guide.md](docs/teacher_guide.md)：怎么把这套实验拆成 2-5 次课、每次讲什么、怎么验收。
- [docs/grading_and_rubric.md](docs/grading_and_rubric.md)：每个 lab 的评分建议和常见扣分点。
- 学生交上来的验证结果统一用 `teammate-verify.sh --full` 输出的 `COPY THIS SUMMARY TO TEAM LEAD` 块；收齐后用 `bash scripts/grade-summaries.sh logs/student-summaries/` 批量解析，它会把 overall 不一致、缺新测试项（旧 suite）、内容雷同的文件标出来——注意这只是辅助验收，最终评分仍按 rubric 和抽查。

## 如果你是评委或在看提交材料

- 证据总索引：[submissions/evidence_manifest.md](submissions/evidence_manifest.md)
- 技术报告：[docs/final/technical_report_v1.0.md](docs/final/technical_report_v1.0.md)
- 答辩 PPT 源稿：[slides/final_ppt.md](slides/final_ppt.md)（成稿 `slides/final_defense_ppt.pptx`）
- 正式文档目录：[docs/final/](docs/final/)，材料索引 [submissions/draft-report-index.md](submissions/draft-report-index.md)
- 外部证据资产包（演示视频、三方复现 summary/截图等大文件，不入 Git）：百度网盘目录 `proj54_submission_assets`，链接 <https://pan.baidu.com/s/1Xt-G6VgP04eEAumqiMo7Uw?pwd=1234>（提取码 `1234`）。下载后可用 `XV6_EVIDENCE_BASE=<解压路径> bash scripts/check-evidence-sha256.sh` 逐文件核对哈希——以仓库内 manifest 和该脚本为准，网盘只是文件的存放处。

比赛信息：2026 全国大学生计算机系统能力大赛 OS 设计赛（全国）OS 功能挑战赛道 proj54，中国海洋大学"蓝色系统队"。

## 当前证据状态（诚实边界）

- 当前最终工程状态 = `db85947 / 0001-0009`（hello=22 … fdinfo=30，连续编号）：rain/root/z2996 三方 `teammate-verify.sh --full` 全 PASS，新演示视频与 SHA256 已登记（详见 [submissions/evidence_manifest.md](submissions/evidence_manifest.md)）。
- `caf8ced` 只是证据文档登记提交，用于记录 final demo、三方复现、SHA256 和外部资产索引；工程复现仍以 `db85947 / 0001-0009` 为准。
- `e8e2fb9 / 0001-0007` 的三方 full PASS 和旧视频 = **historical stable checkpoint**，只覆盖 `0001-0007`，保留不删但不作为 current final。
- 一直成立的边界：`pgcount`/`memstat` 不是完整内存管理，`fcount`/`fdcount`/`fdinfo` 不是完整文件系统，Lab5 不新增内核机制，QEMU timeout 捕获不等于长期稳定性测试。
- 不入 Git 的东西：`external/xv6-riscv/`、`logs/`、视频、截图、`.claude/`、`.vscode/`、隐私材料。提交前三道自查：`bash scripts/check-final-hygiene.sh`（仓库卫生）、`bash scripts/check-docs-consistency.sh`（文档与脚本状态一致）、`bash scripts/check-evidence-sha256.sh`（外部证据哈希）。

---

最后说一句：这套实验包是我们一边踩坑一边整理出来的。给测试程序起名 `pstatechildtest` 结果 `mkfs` 直接构建失败（xv6 的 `DIRSIZ` 限制文件名长度，后来改成了 `pchildtest`）；把 lab2 的 patch 往 lab1 上叠，`git apply` 当场报错，才实测确认了 independent patch 之间 `SYS_*=22` 的编号冲突；`/mnt` 路径下第一次 boot 慢到以为卡死。这些坑的现象和解法都写进了 [docs/troubleshooting.md](docs/troubleshooting.md) 和各 lab 的"常见卡点"，希望你比我们少走点弯路。
