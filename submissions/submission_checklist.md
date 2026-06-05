# 初赛提交材料 Checklist

> 维护时间：2026-06-05（stage6e 提交材料整理）。
> 这不是最终提交材料，不包含报名信息、个人隐私、账号密码、token 或大型二进制文件。

## 1. 当前提交状态总览

| 项目 | 状态 |
| --- | --- |
| GitLab 主仓库 | 官方比赛 GitLab 为 `origin`；GitHub 仅用于私有备份与协作 |
| `external/xv6-riscv/` | **不提交**（`.gitignore` 已忽略） |
| `logs/*.log` | **不提交**（`.gitignore` 已忽略） |
| patch 文件 | 全部 track 并已从 clean baseline 验证可应用 |
| 文档 | 已撰写，commit hash 大部分已填充（仅最早期 scaffold 阶段仍为 TODO） |
| 技术报告 v0.2 | **TODO**（当前为 v0.1） |
| PPT 成品 | **TODO**（当前仅 `slides/README.md` 结构计划） |
| 队友独立复现 | **TODO** |
| 人工交互录屏 | **TODO** |
| 长期稳定性测试 | **TODO**（当前所有证据均为 timeout 捕获） |

## 2. 官方 GitLab 主仓库说明

- `origin` remote 指向官方比赛 GitLab。
- 最终提交以官方 GitLab 为准。
- GitHub remote 仅用于私有备份和协作，不作为提交目标。
- **禁止修改 remote 地址**。
- **禁止将报名材料、个人隐私、截图原件提交到任何 remote**。

## 3. 当前已完成工程模块

### 3.1 lab0 baseline/build/boot

- xv6-riscv baseline commit: `74f84181a3404d1d6a6ff98d342233979066ebb8`
- 工具链：`riscv64-linux-gnu-gcc` + `qemu-system-riscv64`
- baseline make：成功（`b2ddced`）
- boot evidence：已捕获

### 3.2 lab1 hello/add2

- `hello()` 最小 syscall（`SYS_hello = 22`）：patch `0001-add-hello-syscall.patch`（`be933c4`）
- `add2(int a, int b)` argint 扩展（`SYS_add2 = 23`）：patch `0002-add-argint-add2-syscall.patch`（`4675da7`）
- 独立 patch 可从 clean baseline 顺序应用
- 已真实捕获 `hello syscall returned 2026` 和 `add2(20, 6) returned 26`

### 3.3 lab2 pstate/pcount/pchildtest

- `pstate(int pid)` 进程观察（独立 patch `SYS_pstate = 22`）：`20d43a4`
- lab2 v0.2 扩展：`pcount(int state)` + `pcounttest` + `pchildtest`（integrated `SYS_pcount = 25`）：`10e5d3f`
- 已真实捕获 `pstate(self) = 4 (RUNNING)`, `pcount(RUNNING) =`, `pcount(99) = -1`, `pstate(child) =`
- `pchildtest` 是实际命令名（`pstatechildtest` 因 xv6 `DIRSIZ` 限制无法使用）

### 3.4 lab4 fcount/fcounttest

- `fcount()` 文件表观察：独立 patch + integrated `0005` patch（`8523298`）
- 已真实捕获 `fcount(before) =`, `fcount(after_open) =`, `fcount(after_close) =`, `fcounttest done`
- 具体数字不固定，只验证稳定前缀

### 3.5 integrated-labs 0001-0005

- 综合演示 patch sequence，统一 syscall 编号 (hello=22, add2=23, pstate=24, pcount=25, fcount=26)
- 可从 clean baseline 顺序应用，所有 6 个用户程序在同一构建中验证通过

### 3.6 apply helper

- `scripts/xv6/apply-integrated-labs.sh`：默认预览；`--make --yes` reset/clean/apply `0001-0005` + make
- 安全审计已通过：`--run`/`--make` 始终要求 `--yes`；预览只读（`23dd28e`, `7aad2af`）

### 3.7 boot retry

- `scripts/xv6/boot-xv6.sh` 已加固：默认 45s × 2 次尝试，支持环境变量覆盖（`2e0048f`）

## 4. 当前已完成文档/证据

| 文档 | 路径 | 状态 |
| --- | --- | --- |
| 项目首页 | `README.md` | 已更新到 stage6d |
| 测试报告 | `docs/04_test_report.md` | 包含 lab0/lab1/lab2/lab4 真实证据 |
| 技术报告 v0.1 | `docs/13_technical_report_v0.1.md` | 初版 draft |
| 复现包 | `reproducibility/README.md` | lab0/lab1/lab2/lab4/integrated 复现步骤 |
| Demo 脚本 | `videos/demo_script.md` | 2-3 分钟 demo 流程 |
| PPT 计划 | `slides/README.md` | 结构大纲，成品 TODO |
| AI 使用记录 | `docs/05_ai_usage_record.md` | hash 已填充到 stage6d |
| 进度日志 | `docs/06_progress_log.md` | hash 已填充到 stage6d |
| 审查文档 | `docs/12/14/15/16/17/18/19/20/21` | 全部完成 |
| 提交就绪度审查 | `docs/21_submission_readiness_review.md` | stage6d 总审查 |
| 材料索引 | `submissions/draft-report-index.md` | 自动生成 |
| 提交 Checklist | `submissions/submission_checklist.md` | 本文档 |

## 5. 必须补齐项

| 项目 | 说明 | 负责人 | 截止 |
| --- | --- | --- | --- |
| 第二名队员独立复现 | 在另一台机器上从 clean baseline 完整复现 integrated `0001-0005`，留证（截图/日志/commit 记录） | TODO | 提交前 |
| 人工交互录屏 | 一段真实的 boot + 6 命令手动操作录屏，不做后期配音/伪造 | TODO | 提交前 |
| 最终技术报告 v0.2 | 基于 v0.1 完善，包含完整实验设计、教学价值分析、局限性说明 | TODO | 提交前 |
| PPT 成品 | 基于 `slides/README.md` 结构计划制作 | TODO | 提交前 |
| 最终提交包自查 | 按本 checklist 逐项核对并记录 | TODO | 提交前 |

## 6. 禁止提交项

- `external/xv6-riscv/` — 第三方 xv6 源码，`.gitignore` 已忽略
- `logs/*.log` — 所有原始命令日志，`.gitignore` 已忽略
- 报名材料 — 含姓名、学号、身份证号、手机号等
- 个人隐私 — 含 token、password、API key、cookie 等
- 大型二进制文件 — 含 kernel 镜像、fs.img、QEMU 镜像
- 伪造结果 — 不伪造截图、运行记录、commit hash、视频或评审意见

## 7. 提交前命令清单

```bash
# 1. 确认工作区干净
git status --short
git status --ignored --short external logs

# 2. 确认 external/xv6-riscv/ 未被 track
git ls-files external/xv6-riscv

# 3. 确认 logs/*.log 未被 track
git ls-files logs/*.log

# 4. 综合演示：从 clean baseline 构建并逐项验证
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh

# 5. 6 个用户程序验证
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"

# 6. 可选：boot 环境变量覆盖
XV6_BOOT_TIMEOUT_SECONDS=60 XV6_BOOT_RETRIES=2 bash scripts/xv6/boot-xv6.sh

# 7. 材料索引更新
bash scripts/collect-report.sh

# 8. 代码一致性
git diff --check

# 9. 最终 grep：不应有未处理的 TODO after commit
grep -R "TODO after commit" -n README.md docs labs tests patches reproducibility videos slides submissions scripts || echo "(OK: all resolved or intentionally kept with explanation)"
```

## 8. 当前结论

- **可作为诚实 MVP 提交**：所有声称的功能均有真实 timeout 捕获证据，文档一致、patch 可复现、边界诚实标注。
- **冲奖仍需补齐**：第二名队员独立复现 + 人工交互录屏 + 最终技术报告 v0.2 + PPT 成品。
- **主要风险**：当前所有证据均为单机 timeout 自动捕获，缺乏人工交互演示和跨机器复现证据。

## 9. 变更记录

| 日期 | 变更 | 作者 |
| --- | --- | --- |
| 2026-06-05 | 初始版本，stage6e 提交材料整理 | 蓝色系统队 |
