# AI 工具使用记录

## 记录目的

本文件用于持续记录项目中使用 AI 工具辅助生成、改写、检查或总结的内容。AI 可以提高文档和脚本整理效率，但不能替代队伍成员的设计判断、代码实现、测试验证和最终复核。

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

## 人工复核清单

- TODO：检查文档是否存在夸大或未验证表述。
- TODO：检查脚本是否依赖不存在的路径。
- TODO：检查是否误加入隐私、账号、token 或报名材料。
- TODO：检查引用与许可证记录是否完整。
- TODO：检查测试记录是否只包含真实执行结果。
