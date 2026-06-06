# Documentation Guide

> 维护时间：2026-06-06（stage8b）。

## 评委快速阅读路径

如果只想快速理解项目，请先看：

1. 根目录 `README.md`：评委入口页，包含项目定位、完成状态、复现命令和边界说明。
2. `docs/final/`：正式提交版文档入口，覆盖项目概述、环境、每个 lab、测试、队友复现、设计取舍、AI 使用、引用许可证和已知限制。
3. `submissions/draft-report-index.md`：当前提交材料索引，由 `scripts/collect-report.sh` 更新。

## 正式文档与过程文档

`docs/final/` 是面向正式提交和评委阅读的文档体系。技术报告 v1.0 和 PPT 应以 `docs/final/` 为主要来源。

`docs/00` 到 `docs/23` 是开发过程、阶段审查、红队记录、测试摘要和问题记录。这些文档保留了真实演进过程，适合追溯为什么做某个设计选择，但不应当直接当作最终技术报告。

## 历史草案说明

`docs/13_technical_report_v0.1.md` 是早期历史草案。它不包含 stage6+ 的完整 lab4 文件表观察、stage7+ verification workflow、stage8 `docs/final/` 正式文档体系和 stage8b 队友复现/视频摘要。

该文件保留用于过程透明，不代表最终技术报告。正式提交应以后续技术报告 v1.0、根 README 和 `docs/final/` 为准。

## 提交材料边界

- 不提交 `external/xv6-riscv/`。
- 不提交 `logs/*.log`、`logs/*.summary.txt`、`logs/*.console.txt`。
- 不提交 `.claude/`、`.vscode/`、视频、大文件、截图或隐私材料。
- 不把队长本机验证写成队友复现。
- 不把 timeout 自动捕获写成长期稳定性测试。
