# proj54-ouc-os-lab

## 赛事与赛题信息

- 比赛名称：2026 全国大学生计算机系统能力大赛 OS 功能挑战赛
- 赛题编号：proj54
- 赛题名称：面向操作系统课程的操作系统竞赛和实验
- 赛题类型：教学型
- 队伍：中国海洋大学“蓝色系统队”
- 当前阶段：初赛 MVP v0.1，已打通 lab0/lab1/lab2 的真实工程闭环，并新增 integrated-labs 综合演示序列

## 项目定位

本项目面向中国海洋大学低年级计算机学生，建设一套 OS 竞赛入门实验体系。项目暂定以 xv6-riscv 为主线，参考 rCore/uCore 课程资源的组织方式，构建从环境配置、系统调用、进程与调度、页表与内存、文件系统到最终集成的 step by step 实验教程、代码框架、测试用例、参考实现、FAQ 和过程记录。

这样设计的原因是：proj54 是教学型赛题，最终评价目标不是单纯追求内核实现难度，而是形成适合本校学生学习、复现和继续扩展的实验体系。因此本仓库强调：

- 可复现：环境、命令、patch、baseline commit 和风险边界清楚。
- 可验证：只记录真实运行过的命令和结果。
- 可扩展：lab0-lab5 分阶段推进，不一次性堆未验证功能。
- 可传承：保留 FAQ、进度日志、AI 使用记录、引用与许可证说明。

## 仓库与远程策略

- `origin`：官方比赛 GitLab，最终比赛提交主仓库。
- `github`：用户私有 GitHub 备份与协作仓库，仅用于私有备份、issue 管理和协作。
- 不修改 remote 地址。
- 不把 GitHub 当作最终提交平台。
- 不提交报名材料、个人隐私、账号密码、token、截图原件或大型二进制文件。

## 评委快速查看路径

建议按以下顺序查看：

1. 项目首页：`README.md`
2. 技术报告 v0.1：`docs/13_technical_report_v0.1.md`
3. 复现包：`reproducibility/README.md`
4. Demo 脚本：`videos/demo_script.md`
5. 赛题要求拆解：`docs/01_requirement_analysis.md`
6. 项目计划：`docs/00_project_plan.md`
7. lab0 环境与 baseline：`labs/lab0-env-setup/README.md`
8. lab1 hello syscall：`labs/lab1-system-call/README.md`
9. lab1 patch 说明：`patches/lab1-system-call/README.md`
10. lab1 clean baseline 复现审查：`docs/12_lab1_patch_review.md`
11. lab2 pstate 进程观察：`labs/lab2-process-and-scheduling/README.md`
12. lab2 patch 说明：`patches/lab2-process-observation/README.md`
13. lab2 复现审查：`docs/15_lab2_process_observation_review.md`
14. patch 策略与集成计划：`docs/16_patch_strategy_and_integration_plan.md`
15. integrated-labs 综合 patch 说明：`patches/integrated-labs/README.md`
16. integrated-labs 复现审查：`docs/17_integrated_labs_review.md`
17. integrated apply helper 安全审查：`docs/18_integrated_helper_review.md`
18. lab2 v0.2 进程观察审查：`docs/19_lab2_v0.2_process_observation_review.md`
19. lab4 文件表观察审查：`docs/20_lab4_file_table_observation_review.md`
20. 初赛提交就绪度总审查：`docs/21_submission_readiness_review.md`
21. 队友复现故障排查：`docs/22_teammate_reproduction_troubleshooting.md`
22. 队友一键复现 Quickstart：`docs/23_teammate_quickstart.md`
23. 测试报告：`docs/04_test_report.md`
24. AI 使用记录：`docs/05_ai_usage_record.md`
25. 引用与许可证说明：`docs/08_reference_and_license.md`
26. 初赛材料索引：`submissions/draft-report-index.md`
27. 提交前 Checklist：`submissions/submission_checklist.md`

## 当前状态

| 模块 | 状态 | 说明 |
| --- | --- | --- |
| scaffold | 已完成 | README、docs、labs、scripts、tests、references、slides、videos、submissions 等结构已建立 |
| xv6-riscv baseline | 已获取但不提交源码 | commit `74f84181a3404d1d6a6ff98d342233979066ebb8`，源码在 ignored 的 `external/xv6-riscv/` |
| lab0 环境与 baseline | 已真实验证 | 工具链检查通过；baseline make 成功；boot evidence 已捕获 |
| lab1 hello syscall | 已形成 patch 并验证 | `0001` 可从 clean baseline 应用；已捕获 `hello syscall returned 2026` |
| lab1 add2 argint syscall | 已形成 patch 并验证 | `0002` 在 `0001` 之后应用；已捕获 `add2(20, 6) returned 26` |
| clean baseline 复现审查 | 已完成 stage2b/stage3a | 记录见 `docs/12_lab1_patch_review.md` 和 `docs/14_lab1_argint_extension_review.md` |
| lab2 pstate 进程观察 | 已形成独立 patch 并验证 | 从 clean baseline 直接应用；已捕获 `pstate(self) = 4 (RUNNING)` |
| lab2 v0.2 pcount/child 观察 | 已形成 integrated `0004` patch 并验证 | 新增 `pcount(int state)`、`pcounttest`、`pchildtest`；已捕获 `pcount(RUNNING) =`、`pcount(99) = -1`、`pstate(child) =` |
| integrated lab1+lab2+lab4 sequence | 已形成 patch 并验证 | `patches/integrated-labs/` 可从 clean baseline 顺序应用 `0001-0005`；同一构建中已捕获 hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest 输出 |
| lab4 fcount 文件表观察 | 已形成 independent patch 和 integrated patch 并验证 | 已捕获 `fcount(before) =`、`fcount(after_open) =`、`fcount(after_close) =`、`fcounttest done`；具体数字不固定 |
| 技术报告 v0.1 | 初版 | 记录见 `docs/13_technical_report_v0.1.md` |
| 复现包 | 初版 | 记录见 `reproducibility/README.md` |
| Demo 脚本 | 初版 | 记录见 `videos/demo_script.md` |
| QEMU timeout/cleanup | 已加固 stage7a0 | `boot-xv6.sh` 与 `run-xv6-command.sh` 均有外层硬 timeout、trap 清理和队友故障排查说明 |
| 队友一键复现 | 已优化 stage7a2 | `scripts/xv6/doctor.sh` 只检查环境；`scripts/xv6/teammate-verify.sh --full/--quick` 自动执行队友正式复现；`scripts/xv6/local-verify.sh --quick` 用于队长录屏前本地检查；summary 写入 ignored 的 `logs/` |
| 队友二次复现 | TODO | 不伪造第二名队员独立复现 |
| 人工交互录屏 | TODO | 目前只有自动捕获证据，不声称已录屏 |
| 提交材料 Checklist | 已完成 | 见 `submissions/submission_checklist.md`；包含状态总览、补齐项、禁止项和提交前命令清单 |
| lab3/lab5 | 计划中 | lab3 尚未完成；lab5 最终集成与报告仍为 TODO |

## 关键边界

- `external/xv6-riscv/` 是第三方源码目录，被 `.gitignore` 忽略，不提交。
- `logs/*.log` 是原始日志，被 `.gitignore` 忽略，不提交。
- 提交物包括自有文档、脚本、patch、metadata 和证据摘要。
- timeout 自动捕获的 boot/hello evidence 不等同于长期稳定性测试。
- lab1/lab2 independent patch 不能直接叠加；综合演示优先使用 `patches/integrated-labs/`。
- 未完成内容必须标注 TODO、待验证或计划中。

## 仓库目录说明

```text
docs/                         项目计划、赛题拆解、实验设计、测试报告、AI 记录、技术报告
labs/lab0-env-setup/          lab0：环境搭建、baseline build 与 boot evidence
labs/lab1-system-call/        lab1：最小 hello syscall 实验
labs/lab2-process-and-scheduling/
                              lab2：进程状态观察实验，已完成 pstate 初版
labs/lab3-memory-and-pagetable/
                              lab3：页表与内存观察实验，计划中
labs/lab4-file-system/        lab4：文件表观察实验 v0.1，已形成 fcount/fcounttest patch
labs/lab5-final-integration/  lab5：最终集成与报告，计划中
patches/lab1-system-call/     lab1 可提交 patch 与说明
patches/integrated-labs/      lab1+lab2+lab4 综合演示 patch sequence，当前包含 0001-0005
reproducibility/              队友和评委复现包
scripts/                      环境检查、baseline、boot、patch、报告索引脚本
tests/                        各 lab 测试记录和测试计划
external/                     第三方源码 metadata；源码目录 ignored
logs/                         原始日志说明；logs/*.log ignored
references/                   参考资料与许可证记录入口
slides/                       初赛 PPT 结构计划
videos/                       Demo 脚本和视频说明，不提交大型视频
submissions/                  初赛材料索引，不存放报名材料或隐私信息
```

## 快速开始

> 构建环境要求：所有真实的 xv6 `make` / `qemu` / boot / 命令验证都必须在 **WSL2 Ubuntu**（或等价的原生 Linux）中执行。Windows 的 Git Bash / MINGW64 / PowerShell 没有 `qemu-system-riscv64` 和 RISC-V 交叉编译器，无法构建，也不要在其中伪报成功。`bash scripts/check-env.sh` 会检测当前 shell 是否满足条件。

1. 克隆仓库。

   ```bash
   git clone <repo-url>
   cd proj54-ouc-os-lab
   ```

2. 检查环境。

   ```bash
   bash scripts/check-env.sh
   ```

3. 获取 xv6 baseline。

   ```bash
   bash scripts/xv6/fetch-xv6.sh --run
   ```

4. 应用 lab1 patch 并构建。

   ```bash
   bash scripts/xv6/apply-lab1-patch.sh --run --make
   ```

5. 捕获 boot evidence。

   ```bash
   bash scripts/xv6/boot-xv6.sh
   ```

   说明：正常应在 1-2 分钟内返回；超过 5 分钟应使用 `Ctrl+C`，不要用 `Ctrl+Z`。卡住后的清理步骤见 `docs/22_teammate_reproduction_troubleshooting.md`。

6. 捕获 hello 和 add2 输出。

   ```bash
   bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
   bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
   ```

7. 综合演示：从 clean baseline 应用 integrated patch sequence。

   ```bash
   bash scripts/xv6/apply-integrated-labs.sh
   bash scripts/xv6/apply-integrated-labs.sh --make --yes
   bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
   bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
   bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
   bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
   bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
   bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
   ```

   说明：`apply-integrated-labs.sh` 默认预览，不修改 external tree；`--make --yes` 会 reset/clean ignored 的 `external/xv6-riscv/`，应用 integrated `0001-0005` 并运行 `make`。子进程观察程序实际命令名为 `pchildtest`，这是为了避开 xv6 `DIRSIZ` 文件名长度限制；输出仍为 `pstate(child) = ...`。`fcounttest` 的具体数字不固定，只验证稳定输出前缀。

8. 可选：单独复现 lab2 independent patch。

   ```bash
   cd external/xv6-riscv
   git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
   git clean -fdx
   git apply ../../patches/lab2-process-observation/0001-add-pstate-syscall.patch
   make
   cd ../..
   bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
   ```

   注意：第 8 步先 `git reset --hard` + `git clean -fdx` 回到 clean baseline，因此该构建**只含 pstate，不含 hello/add2**。lab1 与 lab2 independent patch 不能直接共存（`SYS_hello` 与 `SYS_pstate` 都用 22，已实测冲突），需要同一构建综合演示时使用第 7 步的 `patches/integrated-labs/`。

更多复现说明见 `reproducibility/README.md`。

## 队友一键复现

队友优先使用一键脚本，不需要逐条手敲 QEMU 命令：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

第一次正式复现使用 `--full`。如果已经看到过 `[OK] make completed successfully`，二次重测使用：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

它会自动运行 doctor、环境检查、baseline 检查、integrated `0001-0005` apply+make（quick 模式跳过）、boot evidence，以及 hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest 验证。最后会打印 `COPY THIS SUMMARY TO TEAM LEAD` summary，并写入 ignored 文件：

```text
logs/teammate-verify-YYYYMMDD-HHMMSS.summary.txt
```

如果卡住超过 5 分钟，先 `Ctrl+C`，不要 `Ctrl+Z`。如果已经误按 `Ctrl+Z` 或怀疑 QEMU 残留，运行：

```bash
bash scripts/xv6/cleanup-qemu.sh
```

面向队友的大白话说明见 `docs/23_teammate_quickstart.md`。

队长录屏前推荐先运行本地 wrapper：

```bash
bash scripts/xv6/local-verify.sh --quick
```

## 协作规范

- 小步提交，优先提交可复核的文档、脚本、patch 和真实验证记录。
- commit message 建议使用 `type: summary`，例如 `docs: add technical report and reproducibility package`。
- 每 1-2 天至少形成一次有效 commit。
- 不上传报名材料、个人隐私、账号密码、token、截图原件或大型二进制文件。
- 不伪造实验结果、运行截图、测试通过记录、commit hash、视频链接或评审意见。
- 引用外部资料时记录来源、URL、许可证、使用位置和改造说明。
- 修改 xv6 时导出 patch，不提交 `external/xv6-riscv/`。

## AI 工具使用说明

AI 辅助使用记录维护在 `docs/05_ai_usage_record.md`。AI 可用于草案、脚本、文档结构和审查辅助，但不能替代真实命令执行和人工复核，不能将未执行内容写成真实结果。

## 引用与许可证说明

参考资料和许可证记录维护在 `docs/08_reference_and_license.md`。当前第三方 xv6-riscv 源码仅保存在 ignored 的 `external/xv6-riscv/`，不作为本仓库源码提交；后续若引入或改造外部内容，必须保留原许可证与来源说明。

## stage6a 当前补充：lab4 文件表观察

本轮新增 lab4 文件系统观察 v0.1，范围限定为全局文件表观察，不声称完成完整文件系统实验。

新增材料入口：

- lab4 教程：`labs/lab4-file-system/README.md`
- lab4 测试说明：`tests/lab4/README.md`
- lab4 independent patch：`patches/lab4-file-table-observation/0001-add-fcount-syscall.patch`
- lab4 patch 说明：`patches/lab4-file-table-observation/README.md`
- integrated 0005 patch：`patches/integrated-labs/0005-add-file-table-observation.patch`
- lab4 审查报告：`docs/20_lab4_file_table_observation_review.md`

当前 integrated final demo 已扩展为 `0001-0005`：

| syscall | number | 用户程序 | 状态 |
| --- | --- | --- | --- |
| `hello()` | 22 | `hello` | 已真实捕获输出 |
| `add2(int, int)` | 23 | `add2test` | 已真实捕获输出 |
| `pstate(int pid)` | 24 | `pstatetest` | 已真实捕获输出 |
| `pcount(int state)` | 25 | `pcounttest` | 已真实捕获输出 |
| `fcount()` | 26 | `fcounttest` | 已真实捕获输出 |

推荐综合复现命令：

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
```

说明：`fcount(...)` 的具体数字不固定，只验证稳定输出前缀和 `fcounttest done`。`external/xv6-riscv/` 和 `logs/*.log` 仍不提交。

## stage6c 当前补充：boot evidence timeout 与 retry 加固

`scripts/xv6/boot-xv6.sh` 已加固，用于降低 clean build 后首次 `make qemu` 因 `fs.img` 补建、`/mnt/d` mtime skew 或构建耗时导致的假失败风险。

当前行为：

- 默认 timeout：45 秒/次。
- 默认 hard timeout：`max(timeout + 15, 75)` 秒/次，可用 `XV6_BOOT_HARD_TIMEOUT_SECONDS` 覆盖。
- 默认尝试次数：2 次。
- 每次尝试独立写入 ignored 日志：`logs/xv6-boot-YYYYMMDD-HHMMSS-attemptN.log`。
- `EXIT`/`INT`/`TERM`/`TSTP` 时尝试清理当前项目相关 `qemu-system-riscv64` 与 `make qemu`。
- 检测到 `xv6 kernel is booting` 和 `init: starting sh` 才输出 `BOOT_EVIDENCE_FOUND` 并退出 0。
- 所有尝试均未检测到完整关键文本时，输出 `BOOT_EVIDENCE_NOT_FOUND` 并非 0 退出。

可按需覆盖：

```bash
XV6_BOOT_TIMEOUT_SECONDS=60 XV6_BOOT_RETRIES=2 bash scripts/xv6/boot-xv6.sh
```

说明：timeout 返回 124 不一定代表 boot 永久失败，可能只是 QEMU 被 timeout 停止，或首次 clean boot 仍在补建镜像。该脚本只捕获 boot evidence，不代表长期稳定性、人工交互录屏或队友独立复现。

## stage7a0 当前补充：QEMU cleanup 与命令运行硬 timeout

本轮针对队友真实复现中 `[STEP] attempt 1/2` 长时间不返回、`Ctrl+Z` 挂起 QEMU/make 的问题，加固了 xv6 复现脚本。

脚本变化：

- `scripts/xv6/boot-xv6.sh`：新增外层硬 timeout、`EXIT`/`INT`/`TERM`/`TSTP` cleanup、当前项目相关 QEMU/make 清理、失败日志路径和下一次 attempt 提示。
- `scripts/xv6/run-xv6-command.sh`：默认命令 soft timeout 调整为 60 秒，默认 2 次 attempts，新增 `XV6_COMMAND_TIMEOUT_SECONDS`、`XV6_COMMAND_RETRIES`、`XV6_COMMAND_HARD_TIMEOUT_SECONDS`，并用真实日志匹配预期输出。
- 新增队友故障排查文档：`docs/22_teammate_reproduction_troubleshooting.md`。

如果曾误按 `Ctrl+Z`，先在 WSL2 Ubuntu 中清理：

```bash
jobs -l
kill %1
pkill -f qemu-system-riscv64 || true
pkill -f "make qemu" || true
```

`external/xv6-riscv/` 和 `logs/*.log` 仍不提交；本轮不修改 integrated `0001-0005` patch，也不新增 OS 功能。

## stage7a1 当前补充：队友一键验证 workflow

本轮新增队友一键复现入口：

- `scripts/xv6/teammate-verify.sh`：自动执行 `check-env`、baseline check、`apply-integrated-labs.sh --make --yes`、boot、hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest，并输出 PASS/FAIL summary。
- `scripts/xv6/cleanup-qemu.sh`：救援清理脚本，列出并清理可能残留的 `qemu-system-riscv64` / `make qemu`，解释 `Ctrl+C` 与 `Ctrl+Z` 区别。
- `docs/23_teammate_quickstart.md`：队友只需 `git pull` 后运行 `bash scripts/xv6/teammate-verify.sh`。
- `scripts/xv6/apply-integrated-labs.sh`：`make` 阶段新增 `XV6_MAKE_TIMEOUT_SECONDS`，默认 600 秒；超时会输出 timeout hit、log path 和 cleanup 提示。

一键脚本的 summary 位于 ignored 的 `logs/teammate-verify-*.summary.txt`，用于反馈给队长，不作为 tracked 文件提交。

## stage7a2 当前补充：队友正式测试前 UX 收口

本轮把队友和队长本地验证收敛为三类入口：

- `scripts/xv6/doctor.sh`：只检查环境，不运行 make/QEMU，不修改仓库；缺关键工具时返回非 0；`riscv64-unknown-elf-gcc` 缺失只 WARN。
- `scripts/xv6/teammate-verify.sh --full`：队友第一次正式复现；执行 doctor/check-env/baseline、clean apply+make、boot 和全部用户程序验证。
- `scripts/xv6/teammate-verify.sh --quick`：已经 make 成功后的二次重测；跳过 clean apply+make。
- `scripts/xv6/local-verify.sh --quick`：队长录屏前本地预检，内部复用 teammate workflow。
- `scripts/xv6/cleanup-qemu.sh`：卡住或误按 `Ctrl+Z` 后的 rescue cleanup，清理前后都会列出相关进程。

正式队友说明见 `docs/23_teammate_quickstart.md`；故障排查见 `docs/22_teammate_reproduction_troubleshooting.md`。summary 文件和 raw logs 仍位于 ignored 的 `logs/`，不提交；`external/xv6-riscv/` 仍不提交。

## stage6d 当前补充：初赛提交就绪度总审查

提交前总审查见 `docs/21_submission_readiness_review.md`。本轮在 WSL2 Ubuntu 中从 clean baseline **完整复现 integrated `0001-0005`**：`--make --yes`、两种 boot 配置（默认 45s×2 与 `XV6_BOOT_TIMEOUT_SECONDS=60`）、以及 hello/add2test/pstatetest/pcounttest（含 `pcount(99) = -1`）/pchildtest/fcounttest 全部捕获到预期前缀。

提交前必须补齐（详见 `docs/21`）：

- 官方 GitLab 提交格式核对，整理 `submissions/` 实际材料。
- 干净 commit + 用真实 commit hash 替换文档中的 `TODO after commit` + 打 tag。
- 第二名队员独立复现一次并留证（当前仍为 TODO）。
- 人工交互录屏一段 boot + 6 命令（当前仍为 TODO）。

未完成项保持诚实标注：lab3 未完成、lab4 仅文件表观察 v0.1、长期稳定性/录屏/队友复现均未声称完成。
