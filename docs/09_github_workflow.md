# GitHub 协作工作流

## 双远程策略

本项目同时维护官方 GitLab 和私有 GitHub 备份仓库：

| remote | 用途 | 地址 | 规则 |
| --- | --- | --- | --- |
| origin | 官方比赛 GitLab，最终比赛提交主线 | `https://gitlab.eduxiji.net/T2026104239911541/project3136859-389476.git` | 禁止修改 remote 地址 |
| github | 用户自己的 GitHub 私有备份与协作仓库 | `https://github.com/Rainflowers686/proj54-ouc-os-lab.git` | 仅用于私有备份、Codex/Claude 协作和 issue 管理 |

GitHub 不是最终比赛提交平台。最终提交仍以官方 GitLab 为准。

## 标准提交流程

```bash
git status
git add .
git commit -m "chore: describe the actual change"
git push origin main
git push github main
```

提交前建议运行：

```bash
bash scripts/check-env.sh
bash scripts/run-lab.sh lab0
bash scripts/run-lab.sh lab1
bash scripts/collect-report.sh
git diff --check
```

注意：如果当前没有真实运行 xv6-riscv，不要在 commit message、PR 或报告中写“xv6 已跑通”。

## Issue 使用规范

优先使用 `.github/ISSUE_TEMPLATE/` 中的模板：

- `bug_report`：记录实验脚本、文档、环境、测试中发现的问题。
- `lab_task`：记录 lab0/lab1/lab2 等实验任务。
- `documentation_task`：记录文档补充、校对和引用检查任务。

Issue 必须避免包含账号密码、token、个人隐私、报名材料、截图原件或大型二进制文件。

## Pull Request 使用规范

- 小步提交，避免一次 PR 混合大量无关内容。
- 不上传敏感信息或大型二进制文件。
- 必须写明实际运行过的验证命令；未运行必须说明原因。
- 必须说明是否使用 AI，以及是否更新 `docs/05_ai_usage_record.md`。
- 涉及第三方资料、代码或图片时，必须更新 `docs/08_reference_and_license.md`。
- 涉及阶段性进展时，建议更新 `docs/06_progress_log.md`。

## GitHub Actions 说明

当前 GitHub Actions 只做轻量检查：

- 检查关键 Markdown 文件是否存在。
- 运行 `scripts/check-env.sh`。
- 运行 `scripts/run-lab.sh lab0`。
- 运行 `scripts/run-lab.sh lab1`。
- 运行 `scripts/collect-report.sh`。
- 运行 `git diff --check`。

CI 不安装 xv6、RISC-V toolchain 或 QEMU，不代表 xv6 baseline 已跑通。`qemu-system-riscv64` 和 `riscv64-unknown-elf-gcc` 缺失只应输出 `[WARN]`，不作为 CI 失败原因。

## GitHub 仓库元信息手动配置清单

若 GitHub CLI 不可用或权限不足，需要队长在 GitHub 网页手动确认：

- Description：`OUC OS contest lab project for CSCC OS Function Challenge proj54: step-by-step xv6-riscv based OS lab tutorials, tests, and reproducible learning materials.`
- Topics：`cscc`、`os`、`operating-system`、`xv6`、`xv6-riscv`、`os-lab`、`education`、`ouc`、`proj54`
- Issues：启用。
- Actions：启用。
- Visibility：保持 private。
- Wiki：默认不启用，除非后续明确需要。
- Branch protection：暂缓。

## 为什么暂缓 branch protection

当前项目处于初期，需要频繁同步官方 GitLab 和 GitHub。过早保护 `main` 可能影响双仓库 push 和比赛仓库主线同步。建议等 v0.2 后，再根据协作稳定性启用 PR review、required checks 等规则。

## 初始 Issues 草案

以下 issue 用于 GitHub 协作和进度管理。若 CLI 创建失败，可由队长手动创建：

- `[lab0] 跑通 WSL2 + Git + bash + make 环境检查`
- `[lab1] 设计并实现最小系统调用实验`
- `[docs] 补齐 proj54 赛题要求与评分项拆解`
- `[docs] 建立引用与许可证记录`
- `[test] 建立初赛 MVP 测试报告模板`
- `[workflow] 验证 GitLab + GitHub 双远程推送流程`

建议标签：

- `lab`
- `docs`
- `test`
- `workflow`
- `priority-high`
- `needs-review`
