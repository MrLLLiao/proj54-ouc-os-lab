# AI 工具使用记录

## 记录目的

本文件用于持续记录项目中使用 AI 工具辅助生成、改写、检查或总结的内容。AI 可以提高文档和脚本整理效率，但不能替代队伍成员的设计判断、代码实现、测试验证和最终复核。

## 核心声明：AI 输出不得直接视为事实

> **AI 工具（Codex、Claude 等）的输出是「待核验的草稿」，不是「事实」或「已验证结果」。**
>
> - AI 生成的命令、版本号、文件路径、运行输出、测试结论、构建结果，在被人工真实执行并核对前，一律视为未验证，必须标注 TODO/待验证。
> - AI 给出的评分预估、风险判断、红队结论仅供内部决策参考，不代表官方评委意见，不得对外宣称为真实成绩或权威结论。
> - AI 可能产生看似合理但实际错误的内容（包括不存在的文件名、API、命令）；引用前必须由队伍成员核对真实仓库与真实环境。
> - 凡进入最终作品的 AI 辅助内容，必须有明确的人工复核责任人。

## 记录原则

- 不向 AI 工具输入账号密码、token、报名材料、个人隐私或其他敏感信息。
- 不将 AI 未执行的推断写成真实实验结果。
- 不声称 AI 独立完成全部项目。
- AI 输出进入仓库前必须经过人工复核。
- 若 AI 参与最终作品的一部分，应记录使用场景、影响文件和人工核验结论。

## 持续记录模板

| 日期 | 工具 | 使用场景 | 输入范围 | 输出用途 | 人工核验 | 是否进入最终作品 | 影响文件 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| TODO | TODO | TODO | TODO | TODO | TODO | TODO | TODO |

## 本次记录示例

| 日期 | 工具 | 使用场景 | 输入范围 | 输出用途 | 人工核验 | 是否进入最终作品 | 影响文件 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 2026-06-03 | Codex | 项目 scaffold 初始化、文档骨架生成、脚本占位与模板完善 | 队伍提供的项目定位、赛题信息、目录和文档要求 | 生成 README、docs、labs、scripts、tests、submissions 等初版内容 | 由队长检查目录、运行脚本、执行 `git diff --check`；当前记录仍需队长最终确认 | 部分进入，需人工复核 | README、docs、labs、scripts、tests、submissions |
| 2026-06-03 | Codex | GitHub 私有备份仓库协作配置、Issue/PR 模板、轻量 CI、工程配置和工作流说明 | 队伍提供的 GitLab/GitHub 双远程策略、GitHub 仓库地址、模板和 CI 要求 | 生成 `.github/`、`.editorconfig`、`.gitattributes`、`.gitignore` 增量配置和 `docs/09_github_workflow.md` | 已检查 remote、运行 GitHub CLI 配置、创建 Issues、运行本地脚本和 `git diff --check`；仍需队长复核 GitHub 网页设置 | 部分进入，需人工复核 | `.github/`、`.editorconfig`、`.gitattributes`、`.gitignore`、`docs/09_github_workflow.md` |
| 2026-06-03 | Claude (Opus) | 全仓库红队审查；收紧 MVP 范围；改进 README、docs、lab0/lab1、脚本生成器、材料索引 | 队伍提供的 proj54 赛题信息、双远程边界约束、当前仓库现状（仅文档与脚本，未含敏感信息） | 生成 `docs/10_red_team_review.md`，并改写多处文档与 `scripts/collect-report.sh`；运行本地脚本与 `git diff --check` 做验证 | 已实际运行三个脚本（均 exit 0）与 `git diff --check`（通过）；评分预估与风险判断为 AI 内部参考，**仍需队长人工复核，commit hash 待提交后补填** | 部分进入，需人工复核 | `docs/00`、`docs/01`、`docs/02`、`docs/05`、`docs/06`、`docs/08`、`docs/10`、`README.md`、`labs/lab0-env-setup/README.md`、`labs/lab1-system-call/README.md`、`scripts/collect-report.sh`、`submissions/draft-report-index.md` |
| 2026-06-03 | Claude Code | stage1a：xv6 baseline 引入方案、external 管理目录、lab0 真实环境检测与验证记录、check-env.sh 增强 | 队伍 stage1a 任务要求、双远程边界、本机 Windows 与 WSL2 环境（**只读检测**，未安装软件、未含敏感信息） | 生成 `docs/11`、`external/README.md`，强化 lab0 验证记录，增强 `scripts/check-env.sh`，更新 `.gitignore` 与材料索引 | 已实际运行 `check-env.sh`（Git Bash 与 WSL2 Ubuntu 各一次）、`collect-report.sh`、`git diff --check`（均通过）；**环境检测为真实结果，未伪造任何 xv6 构建/启动；未引入 xv6 源码**；commit hash 待提交后补填；待队长复核 | 部分进入，需人工复核 | `docs/11`、`external/README.md`、`.gitignore`、`labs/lab0-env-setup/README.md`、`scripts/check-env.sh`、`scripts/collect-report.sh`、`submissions/draft-report-index.md`、`docs/05`、`docs/06` |

## 人工复核清单

- TODO：检查文档是否存在夸大或未验证表述。
- TODO：检查脚本是否依赖不存在的路径。
- TODO：检查是否误加入隐私、账号、token 或报名材料。
- TODO：检查引用与许可证记录是否完整。
- TODO：检查测试记录是否只包含真实执行结果。
