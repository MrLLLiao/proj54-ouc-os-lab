# OUC xv6 Lab Kit

面向中国海洋大学操作系统课程的 xv6-riscv 分阶段实验指导、参考实现与可复现验证体系。

## 赛事与赛题

| 项目 | 内容 |
| --- | --- |
| 比赛 | 2026 全国大学生计算机系统能力大赛 - 操作系统设计赛（全国） |
| 赛道 | OS 功能挑战赛道 |
| 赛题 | proj54：面向操作系统课程的操作系统竞赛和实验 |
| 队伍 | 中国海洋大学“蓝色系统队” |
| 项目定位 | 教学型实验包，不是刷 LTP 的内核实现赛道项目 |

本项目围绕“课程实验可教、可复现、可验证、可扩展”推进。当前不盲目新增内核功能，而是把 lab0/lab1/lab2/lab4、综合 patch、验证脚本、队友复现和提交文档整理成评委可快速理解的材料体系。

## 完成状态

| 模块 | 当前状态 | 说明 |
| --- | --- | --- |
| lab0 baseline/build/boot | 已完成 | 环境检查、xv6 baseline metadata、make、boot evidence |
| lab1 hello/add2 | 已完成 | `hello()`、`add2(int,int)` syscall 入门与参数传递 |
| lab2 pstate/pcount/pchildtest | 已完成 | 进程状态观察、状态计数、子进程状态观察 |
| lab4 fcount/fcounttest | 已完成 | 文件表引用计数观察；不是完整文件系统实验 |
| integrated-labs 0001-0005 | 已完成 | clean baseline 可顺序应用并 make；同一构建验证 6 个用户程序 |
| verification scripts | 已完成 | `doctor.sh`、`teammate-verify.sh`、`local-verify.sh`、`cleanup-qemu.sh` |
| 队长本机验证 | 已完成 | local/full 路径已 PASS；summary/raw logs 不入库 |
| 视频记录 | 已录制 3 段 | 视频文件在仓库外，不提交 Git；文件名、大小和待补项记录见 `submissions/demo_record.md` |
| 队友独立复现 | 已收到 2 份 full PASS summary | 原始 logs/summary/截图不入仓；文字摘要见 `submissions/teammate_reproduction_record.md`；队友真实姓名/系统版本待补充 |
| lab3 memory/pagetable | 未完成 | 后续扩展方向 |

## 评委快速复现

所有真实 `make` / QEMU / boot / 命令验证必须在 WSL2 Ubuntu 或等价 Linux 中执行。

```bash
bash scripts/xv6/doctor.sh
bash scripts/xv6/teammate-verify.sh --full
```

如果已经看到过 `[OK] make completed successfully`，二次重测可用：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

队长录屏前本地预检：

```bash
bash scripts/xv6/local-verify.sh --quick
```

卡住或误按 `Ctrl+Z` 后：

```bash
bash scripts/xv6/cleanup-qemu.sh
```

`teammate-verify.sh` 会输出 `COPY THIS SUMMARY TO TEAM LEAD` 块，并把 summary 写入 ignored 的 `logs/teammate-verify-*.summary.txt`。

## 正式文档导航

正式提交/评委入口位于 `docs/final/`：

| 文档 | 内容 |
| --- | --- |
| `docs/final/00_project_overview.md` | 项目定位、评分权重对应、完成状态、同类项目对比 |
| `docs/final/01_environment_setup.md` | WSL2/xv6 环境搭建与仓库卫生 |
| `docs/final/02_lab0_baseline_build_boot.md` | baseline build 与 boot 实验 |
| `docs/final/03_lab1_hello_add2.md` | hello/add2 系统调用实验 |
| `docs/final/04_lab2_process_observation.md` | pstate/pcount/pchildtest 进程观察实验 |
| `docs/final/05_lab4_file_table_observation.md` | fcount 文件表观察实验 |
| `docs/final/06_testing_and_verification.md` | 测试覆盖总表与证据边界 |
| `docs/final/07_teammate_reproduction_guide.md` | 队友复现指南 |
| `docs/final/08_design_decisions_and_tradeoffs.md` | 设计取舍与风险控制 |
| `docs/final/09_ai_usage_and_contribution_statement.md` | AI 使用与贡献说明 |
| `docs/final/10_reference_and_license_statement.md` | 引用与许可证说明 |
| `docs/final/11_known_limits_and_future_work.md` | 已知限制与后续计划 |

提交材料索引见 `submissions/draft-report-index.md`；运行 `bash scripts/collect-report.sh` 可重新生成。

## 视频说明

已录制 3 段视频，视频文件保存在仓库外，不提交 Git。当前仓库只记录视频文件名、用途、约略大小、外部位置和待补项：

```text
submissions/demo_record.md
```

视频不得包含 token、密码、个人隐私、报名材料或未公开账号信息。

## 诚信与边界

- 不提交 `external/xv6-riscv/`、`logs/*.log`、`logs/*.summary.txt`、`.claude/`、`.vscode/`、视频、大文件或隐私材料。
- `patches/integrated-labs/0001-0005` 是当前已验证综合序列，本轮不修改。
- timeout 自动捕获只证明脚本在真实 QEMU 输出中匹配到预期文本，不等同于长期稳定性测试。
- `fcount()` 只是文件表引用计数观察，不是完整文件系统实验。
- `pcount(RUNNING)` 和 `fcount(...)` 的具体数字不固定；`pchildtest` 状态受调度时序影响。
- 已收到两份队友 `--full` verification PASS summary；原始 logs/summary/截图不入仓，文字摘要见 `submissions/teammate_reproduction_record.md`，队友真实姓名/系统版本仍待补充。
- AI 可辅助规划、审查和文档/脚本落地；make/QEMU/PASS 结果必须来自真实命令。

## 已知限制与后续计划

- lab3（内存与页表）未完成。
- lab4 当前为文件表观察 v0.1，后续可扩展 inode、fd table、open-file summary 等内容。
- 技术报告 v1.0 和 PPT 仍需基于 `docs/final/` 整理。
- 队友真实姓名/系统版本、视频时长/平台提交方式、同类项目参考 URL 仍需最终补齐。
