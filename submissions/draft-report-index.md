# 初赛材料索引草案

生成时间：TODO：由提交前人工补充

本文件由 `scripts/collect-report.sh` 生成或更新，用于汇总当前仓库中已有的初赛材料路径与状态。

注意：本文件不是最终技术报告，不生成 PDF，不包含报名材料、隐私信息或虚假运行结果。状态列含义见文末说明。

## 材料索引

| 材料 | 路径 | 文件 | 内容状态 |
| --- | --- | --- | --- |
| 项目首页 | `README.md` | 存在 | 已完成初版 |
| 项目计划 | `docs/00_project_plan.md` | 存在 | 已完成初版 |
| 赛题要求与评分项拆解 | `docs/01_requirement_analysis.md` | 存在 | 已完成初版 |
| 实验体系设计 | `docs/02_lab_design.md` | 存在 | 已完成初版 |
| Step by Step 教程结构 | `docs/03_step_by_step_guide.md` | 存在 | 结构初版，正文待填写 |
| 测试报告模板 | `docs/04_test_report.md` | 存在 | 模板待真实测试填写 |
| AI 使用记录 | `docs/05_ai_usage_record.md` | 存在 | 已完成初版 |
| 进度记录 | `docs/06_progress_log.md` | 存在 | 已完成初版 |
| FAQ 与 Issue 记录 | `docs/07_faq_and_issues.md` | 存在 | 模板待真实问题填写 |
| 参考资料与许可证 | `docs/08_reference_and_license.md` | 存在 | 已完成初版 |
| GitHub 协作工作流 | `docs/09_github_workflow.md` | 存在 | 已完成初版 |
| 内部红队审查报告 | `docs/10_red_team_review.md` | 存在 | 已完成初版 |
| xv6 baseline 引入方案 | `docs/11_xv6_baseline_plan.md` | 存在 | 已完成初版（含真实环境检测） |
| lab0 环境教程 | `labs/lab0-env-setup/README.md` | 存在 | 环境文档初版，真实工具链待验证 |
| lab1 系统调用实验设计 | `labs/lab1-system-call/README.md` | 存在 | 实验设计初版，待 baseline 引入后实现 |
| lab2 进程与调度 | `labs/lab2-process-and-scheduling/README.md` | 存在 | 计划中占位 |
| lab3 页表与内存 | `labs/lab3-memory-and-pagetable/README.md` | 存在 | 计划中占位 |
| lab4 文件系统 | `labs/lab4-file-system/README.md` | 存在 | 计划中占位 |
| lab5 最终集成 | `labs/lab5-final-integration/README.md` | 存在 | 计划中占位 |
| lab1 测试计划 | `tests/lab1/README.md` | 存在 | 计划初版，真实测试待补 |
| lab2 测试计划 | `tests/lab2/README.md` | 存在 | 计划初版 |
| lab3 测试计划 | `tests/lab3/README.md` | 存在 | 计划初版 |
| lab4 测试计划 | `tests/lab4/README.md` | 存在 | 计划初版 |
| 第三方源码管理说明 | `external/README.md` | 存在 | 已完成初版，baseline 待引入 |
| 参考资料目录说明 | `references/README.md` | 存在 | 占位，引用待补 |
| PPT 说明 | `slides/README.md` | 存在 | TODO 占位 |
| Demo 视频说明 | `videos/README.md` | 存在 | TODO 占位 |
| 最终提交 | `submissions/` | - | TODO：待对照官方要求整理 |

## 状态列说明

- 文件：由脚本检测路径是否存在（存在/缺失），不代表内容质量。
- 内容状态：人工维护的真实进度标注，取值如「已完成初版 / 模板待填写 / 设计初版 / 计划中占位 / 待真实验证」。
- 本索引为草案，非最终版；任何「待真实验证」的材料在真实执行前不得标注为完成。

## 待补充

- TODO：技术报告正文。
- TODO：PPT。
- TODO：Demo 视频或视频说明。
- TODO：真实测试报告和命令输出。
- TODO：最终提交前人工复核清单。
