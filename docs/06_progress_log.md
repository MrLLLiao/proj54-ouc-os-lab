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

## 2026-06-03（红队审查与修复轮）

- commit hash：TODO: after commit
- 完成人：Claude（AI 辅助）+ TODO：队长复核
- 变更范围：内部红队审查与低风险文档/脚本改进，未引入任何第三方源码，未改动 remote。
- 已完成：
  - 新增内部红队审查报告 `docs/10_red_team_review.md`（总体结论、按评分项预估、风险 Top 10、必改/可留/可缓、证据清单、两周路线、自查表、MVP 差距判定）。
  - README 增加「代码仓库与提交说明」「评委快速查看路径」「当前未完成事项」，并明确 GitHub 为私有备份、GitLab 为比赛主仓库。
  - `docs/01` 强化「题目二为主、题目一为辅」论证，并把评分项一一对应到具体文件路径与「是否已有证据」。
  - `docs/00` 收缩为 6/30 前可完成的 v0.1/v0.2/v0.3/final 四里程碑，新增止损线与三角色协作节奏。
  - `docs/02` 明确 MVP 强保 lab0+lab1、lab2/lab4 二选一、lab3/lab5 扩展，并为每个 lab 增加「验收证据」字段。
  - lab0 增加真实验证记录模板（留空待填、禁止伪造）；lab1 增加实现前置检查清单与代码修改点清单（文件名待 baseline 核对）。
  - 重写 `scripts/collect-report.sh`：材料索引覆盖 `docs/07`、`docs/10` 与全部 lab，并新增「内容状态」列。
  - `docs/05` 增加「AI 输出不得直接视为事实」声明与本轮 Claude 红队审查记录。
  - `docs/08` 增加 xv6 许可证检查清单与「引用外部资料必须写改造说明」的硬性要求。
- 验证命令：
  - `bash scripts/check-env.sh`
  - `bash scripts/run-lab.sh lab0`
  - `bash scripts/run-lab.sh lab1`
  - `bash scripts/collect-report.sh`
  - `git diff --check`
- 验证结果：
  - 三个脚本均 exit 0；缺少 `make`、`qemu-system-riscv64`、`riscv64-unknown-elf-gcc` 时优雅输出 `[WARN]`。
  - `git diff --check` 通过；脚本与文档均为 LF 换行，无 CRLF 风险。
  - `collect-report.sh` 重新生成的 `submissions/draft-report-index.md` 已包含 `docs/10` 与内容状态列。
  - 本轮验证不涉及 xv6 构建或运行，不代表 xv6 已跑通。
- 遗留问题：
  - **xv6-riscv baseline 仍未引入。**
  - **QEMU 与 RISC-V 工具链仍未在本项目环境中真实验证（当前为 WARN）。**
  - lab1 系统调用实验仍未实现，代码修改点清单中的文件名待真实核对。
  - 真实测试报告、技术报告、PPT、Demo 视频仍为 TODO。
  - 队内三角色仍未具名；仓库根目录仍无自有 LICENSE。
  - 红队报告中的评分预估为 AI 内部参考，需队长人工复核后采纳。
- 下一步：
  - 队长复核本轮红队报告，确认范围收缩与里程碑。
  - 进入 v0.2：确认 xv6-riscv baseline 来源/commit/许可证，真实跑通 lab0 并捕获日志。
  - 三角色具名，开始按协作节奏推进。

## 2026-06-03（stage1a：xv6 baseline 方案与 lab0 验证准备）

- commit hash：TODO: after commit
- 完成人：Claude Code（AI 辅助）+ TODO：队长复核
- 工具：Claude Code
- 变更范围：xv6 baseline 引入方案、external 管理目录、lab0 真实环境检测与验证记录、check-env.sh 增强、材料索引。**未引入 xv6 源码，未安装任何工具链，未改动 remote。**
- 已完成：
  - 新增 `docs/11_xv6_baseline_plan.md`：baseline 选型、四种引入方式对比、推荐 submodule、许可证要求、仓库风险、Windows/WSL 注意事项、验收标准、**本机真实环境检测**。
  - 新增 `external/README.md`：第三方源码隔离管理原则、引入命令占位、许可证入口；并在 `.gitignore` 增加规则（保留 `external/README.md`，忽略 `external/` 下源码树）。
  - 强化 `labs/lab0-env-setup/README.md`：新增「本机环境验证记录」表（含 2026-06-03 真实检测两行）、「失败不是问题，伪造才是问题」、下一步安装计划、现在可跑/装后可跑命令对照。
  - 增强 `scripts/check-env.sh`：区分 REQUIRED（git/bash/make）与 XV6 期望工具（qemu、riscv64-unknown-elf-gcc、riscv64-linux-gnu-gcc），新增 uname、风险提示与 next steps，退出码保持 0。
  - 更新 `scripts/collect-report.sh` 与材料索引：加入 `docs/11`、`external/README.md`，调整 lab0/lab1 状态措辞。
- 验证命令：
  - `bash scripts/check-env.sh`（Git Bash 与 WSL2 Ubuntu 各运行一次）
  - `bash scripts/run-lab.sh lab0` / `lab1`
  - `bash scripts/collect-report.sh`
  - `git diff --check`、`git status --short`
- 验证结果（真实，未伪造）：
  - check-env.sh 在 Git Bash：git/bash=OK，make=WARN（触发 RISK 提示），qemu/riscv=WARN；exit 0。
  - check-env.sh 在 WSL2 Ubuntu 24.04.4：git/bash/make=OK，qemu/riscv=WARN；exit 0。脚本能正确区分两种环境。
  - 真实环境检测：WSL2 Ubuntu 的 git+make(4.3)+gcc(13.3.0) 已就绪，缺 qemu-system-riscv64 与 RISC-V 交叉工具链。
  - `git diff --check` 通过；所有改动/新增文件为 LF；`external/README.md` 可追踪、`external/` 下源码树会被忽略（已 `git add --dry-run` 验证）。
- 遗留问题：
  - **xv6-riscv baseline 仍未引入**（待队长授权按 docs/11 引入，submodule 优先）。
  - **QEMU 与 RISC-V 工具链仍未安装**（待队长授权在 WSL2 执行 apt 安装）。
  - 尚未真实构建或启动 xv6，无任何 xv6 跑通记录。
  - lab1 仍未实现；技术报告、PPT、Demo、真实测试报告仍为 TODO；三角色仍未具名；根目录仍无自有 LICENSE。
- 下一步（需队长亲自执行）：
  - 在 WSL2 Ubuntu 安装工具链：`sudo apt install -y ... qemu-system-misc gcc-riscv64-linux-gnu ...`。
  - 确认 xv6-riscv 上游 URL/commit/许可证并登记 `docs/08`，按 submodule 方式引入到 `external/xv6-riscv`。
  - 在 WSL2 内重跑 `scripts/check-env.sh`、`make`、`make qemu`，把真实输出写入 lab0 验证表与 `docs/04`。
