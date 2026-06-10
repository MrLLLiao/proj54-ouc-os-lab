# docs 导航：你该看哪个文件

> 维护时间：2026-06-10（stage12 learner-first 重构）。current integrated suite 为 `0001-0009`。

docs 目录里既有教程、教师材料，也有比赛报告和大量过程记录。不同的人该看的东西不一样，按下面对号入座，不要从 `docs/00` 顺序读到 `docs/24`——那是给追溯历史的人准备的。

## 1. 第一次学 OS 实验：按这个顺序看

1. 根目录 [README.md](../README.md)：学习路线总览（Step 0 到 Step 7）。
2. [docs/final/01_environment_setup.md](final/01_environment_setup.md)：装环境。
3. `labs/lab0` → `lab1` → `lab2` → `lab3` → `lab4` → `lab5`，每个目录先读 `README.md` 再做 `student_tasks.md`。
4. 卡住了看 [docs/troubleshooting.md](troubleshooting.md)。

学习阶段不需要读 `docs/final/` 的报告，也不需要读编号文档。

## 2. 已经能跑 xv6：直接进 Lab

- 想一次跑全部：`bash scripts/xv6/teammate-verify.sh --full`（覆盖 integrated `0001-0009` 的 10 个测试程序）。
- 想理解某个 syscall 的实现：看对应 lab 的 README，再直接读 `patches/integrated-labs/` 里那个 patch——每个 patch 就是一次完整的"加 syscall"操作记录。
- 想理解 `argaddr + copyout + struct ABI`：Lab3 进阶 `memstat`（integrated `0008`）和 Lab4 进阶 `fdinfo`（integrated `0009`）。

## 3. 老师/助教：布置与验收

- [docs/teacher_guide.md](teacher_guide.md)：课次安排、必做/选做划分、验收方式、学生环境问题处理。
- [docs/grading_and_rubric.md](grading_and_rubric.md)：评分建议与常见扣分点。
- 每个 lab 的 `student_tasks.md` 可以直接当作业布置；验收统一收 `teammate-verify.sh` 的 summary 块。

## 4. 比赛/提交材料：证据在哪

- [docs/final/](final/)：正式提交文档（项目概述、各 lab 正式版、测试覆盖、设计取舍、AI/许可证声明、技术报告 v1.0）。
- [submissions/evidence_manifest.md](../submissions/evidence_manifest.md)：证据总索引——哪些已验证、哪些是 historical checkpoint（`e8e2fb9 / 0001-0007`）、哪些还是 TBD（`0001-0009` 的队友复现/新视频/新 SHA256）。
- [submissions/draft-report-index.md](../submissions/draft-report-index.md)：全部材料清单，由 `scripts/collect-report.sh` 生成。
- [slides/final_ppt.md](../slides/final_ppt.md)：答辩 PPT 源稿。

## 5. 过程记录：历史在这里，新手别先读

`docs/00` 到 `docs/24` 是按阶段留下的开发与红队记录（计划、审查、踩坑、阶段结论），`docs/05_ai_usage_record.md` 和 `docs/06_progress_log.md` 是逐条流水账。它们的价值是"为什么当时这么做"可以追溯，但其中的"当前状态"描述只对所写阶段成立——例如 stage9c 文档里的 `0001-0007` 早已被 `0001-0009` 取代。想追溯历史时再来，新手优先级最低。

`docs/13_technical_report_v0.1.md` 是早期草案，已被 `docs/final/technical_report_v1.0.md` 取代，仅作过程透明保留。

## 提交边界（一直成立）

- 不提交 `external/xv6-riscv/`、`logs/*.log`、`logs/*.summary.txt`、`logs/*.console.txt`、`.claude/`、`.vscode/`、视频、截图、大文件、隐私材料。
- 不把队长本机验证写成队友复现；不把 timeout 捕获写成长期稳定性测试。
- 旧证据不冒充新证据：`0001-0007` 三方 PASS 不覆盖 `0001-0009`。
