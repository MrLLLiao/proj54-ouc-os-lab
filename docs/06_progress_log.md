# 开发进度日志

## 记录原则

- 只记录真实完成的事项。
- 未完成事项必须标注 TODO、待验证或计划中。
- commit hash 在提交后填写，不得伪造。
- 真实运行命令需要记录命令、结果和必要说明。

## 日志模板

### YYYY-MM-DD

- commit hash：TODO: after commit
- 完成人：TODO
- 变更范围：TODO
- 已完成：TODO
- 验证命令：TODO
- 验证结果：TODO
- 遗留问题：TODO
- 下一步：TODO

## 2026-06-03

- commit hash：TODO: after commit
- 完成人：TODO：队长补充
- 变更范围：项目 scaffold、初赛 MVP v0.1 文档脚本、GitHub 私有备份仓库协作配置。
- 已完成：
  - 完成 scaffold 初始化。
  - 删除平台 placeholder `main.py`，删除原因：`replace platform placeholder with project scaffold`。
  - 创建并整理 `docs/`、`labs/`、`scripts/`、`tests/`、`references/`、`slides/`、`videos/`、`submissions/` 等结构。
  - 将 README、赛题拆解、项目计划、实验体系设计、lab0、lab1 文档升级为初版。
  - 将脚本升级为最小可运行工具，不依赖 xv6-riscv 源码。
  - 创建或更新初赛材料索引草案。
  - 确认 `origin` 指向官方 GitLab，`github` 指向私有 GitHub 备份仓库。
  - 使用 GitHub CLI 设置 GitHub 仓库 description、topics、Issues、private visibility，并关闭 Wiki。
  - 创建 GitHub Issue 模板、PR 模板、轻量 CI、CODEOWNERS、`.editorconfig` 和 `.gitattributes`。
  - 创建 GitHub 初始 labels 与 Issues。
- 验证命令：
  - `bash scripts/check-env.sh`
  - `bash scripts/run-lab.sh lab0`
  - `bash scripts/run-lab.sh lab1`
  - `bash scripts/collect-report.sh`
  - `git diff --check`
  - `gh repo view Rainflowers686/proj54-ouc-os-lab`
  - `gh issue list --repo Rainflowers686/proj54-ouc-os-lab`
- 验证结果：
  - `check-env.sh` 可运行，当前环境中 `git`、`bash`、`make` 检查为 `[OK]`。
  - `qemu-system-riscv64` 和 `riscv64-unknown-elf-gcc` 当前检查为 `[WARN]`，说明后续 baseline 跑通前仍需安装或配置。
  - `run-lab.sh lab0` 可定位 lab0 README，并提示运行环境预检查。
  - `run-lab.sh lab1` 可定位 lab1 README，并明确当前为设计阶段。
  - `collect-report.sh` 可生成或更新 `submissions/draft-report-index.md`。
  - `git diff --check` 通过。
  - GitHub 仓库元信息已通过 CLI 查询确认；Issues 已创建。
  - 当前验证不代表 xv6-riscv 已跑通。
- 遗留问题：
  - TODO：xv6-riscv baseline 未引入。
  - TODO：RISC-V toolchain 和 QEMU 安装方式待真实验证。
  - TODO：lab1 系统调用实验尚未实现。
  - TODO：真实测试报告待 baseline 引入后补充。
- 下一步：
  - 完成赛题拆解复核。
  - 完成 lab0 环境真实验证。
  - 确认 xv6-riscv baseline 来源、版本和许可证。
  - 开始 lab1 系统调用最小实现设计与测试计划。
