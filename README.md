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
18. 测试报告：`docs/04_test_report.md`
19. AI 使用记录：`docs/05_ai_usage_record.md`
20. 引用与许可证说明：`docs/08_reference_and_license.md`
21. 初赛材料索引：`submissions/draft-report-index.md`

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
| integrated lab1+lab2 sequence | 已形成 patch 并验证 | `patches/integrated-labs/` 可从 clean baseline 顺序应用；同一构建中已捕获 hello/add2test/pstatetest 输出 |
| 技术报告 v0.1 | 初版 | 记录见 `docs/13_technical_report_v0.1.md` |
| 复现包 | 初版 | 记录见 `reproducibility/README.md` |
| Demo 脚本 | 初版 | 记录见 `videos/demo_script.md` |
| 队友二次复现 | TODO | 不伪造第二名队员独立复现 |
| 人工交互录屏 | TODO | 目前只有自动捕获证据，不声称已录屏 |
| lab3-lab5 | 计划中 | 后续选择 lab2 扩展或 lab4 二选一深化 |

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
labs/lab4-file-system/        lab4：文件系统实验，计划中
labs/lab5-final-integration/  lab5：最终集成与报告，计划中
patches/lab1-system-call/     lab1 可提交 patch 与说明
patches/integrated-labs/      lab1+lab2 综合演示 patch sequence
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
   ```

   说明：`apply-integrated-labs.sh` 默认预览，不修改 external tree；`--make --yes` 会 reset/clean ignored 的 `external/xv6-riscv/`，应用 integrated patch sequence 并运行 `make`。

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
