# 技术报告 v0.1

项目：`proj54-ouc-os-lab`

队伍：中国海洋大学“蓝色系统队”

赛题：2026 全国大学生计算机系统能力大赛 OS 功能挑战赛 `proj54：面向操作系统课程的操作系统竞赛和实验`

版本说明：本文档是初赛技术报告草案 v0.1，用于整理当前 lab0/lab1 的真实工程闭环。它不是最终报告，不声称完整 OS 实验体系已经完成。

## 1. 项目概述

本项目面向中国海洋大学低年级计算机学生，建设一套 OS 竞赛入门实验体系。当前主线暂定为 xv6-riscv，参考 rCore/uCore 等课程资源的组织方式，逐步形成从环境搭建、baseline 验证、系统调用、进程与调度、页表与内存、文件系统到最终集成的 step by step 实验教程、patch、测试脚本、参考记录和 FAQ。

当前 v0.1 的重点不是堆叠复杂内核功能，而是建立一个诚实、可复现、可扩展的最小工程闭环：

- lab0：环境检查、xv6-riscv baseline 获取、build 与 boot evidence。
- lab1：`hello()` 最小 system call patch、`add2(int a, int b)` 参数传递进阶 patch、构建验证、QEMU 输出捕获、clean baseline 复现审查。
- lab2：`pstate(int pid)` 进程状态观察 patch、进程表查找、进程锁使用说明、QEMU 输出捕获。
- 工程治理：第三方源码隔离、原始日志不提交、patch 作为可提交产物、AI 使用和进度记录透明化。

## 2. 赛题理解

proj54 属于教学型赛题，不是普通的“完成一个 OS 作业”或“只追求内核功能难度”的题目。项目最终需要服务于本校 OS 实验教学和竞赛入门，重点在于：

- 能否把复杂 OS 任务拆成低年级同学可以逐步完成的实验。
- 是否提供清晰的 step by step 过程，而不是只给最终答案。
- 是否能让后续同学复现环境、复现 patch、复现测试结果。
- 是否对引用、改造、第三方源码、AI 使用和测试证据保持诚实记录。

因此，本项目当前选择先打通 lab0/lab1 的最小闭环，再用 lab2 进入进程状态观察。这样比直接堆多个未验证功能更符合教学型赛题的评价方向。

## 3. 总体设计

### 3.1 主线选择

当前主线暂定为 xv6-riscv。

选择理由：

- xv6-riscv 代码规模适中，适合讲解 OS 基础概念。
- 系统调用、进程、页表、文件系统等模块边界清晰，适合拆成独立实验。
- 社区资料较多，便于和教材、课程资源、往年竞赛资料建立引用关系。
- 适合作为低年级同学从“会运行”到“能修改内核”的入门载体。

### 3.2 lab0：环境与 baseline

lab0 的目标是让同学先获得可验证环境，而不是直接进入内核修改。

当前已完成：

- WSL2 Ubuntu 环境下运行 `scripts/check-env.sh`。
- 检测到 `git`、`bash`、`make`、`qemu-system-riscv64`、`riscv64-linux-gnu-gcc`。
- `riscv64-unknown-elf-gcc` 缺失，记录为 WARN。
- 获取 xv6-riscv baseline 到 `external/xv6-riscv/`。
- 记录 baseline commit：`74f84181a3404d1d6a6ff98d342233979066ebb8`。
- baseline `make` 成功。
- 捕获 boot evidence：检测到 `xv6 kernel is booting` 和 `init: starting sh`。

### 3.3 lab1：syscall 入门与参数传递

lab1 的目标是展示从用户态到内核态的系统调用路径，并在最小闭环之后补充整数参数传递。

第一档为 `hello()`：

- 新增 syscall `hello()`。
- 内核返回整数 `2026`。
- 用户态程序 `hello` 输出 `hello syscall returned 2026`。

第二档为 `add2(int a, int b)`：

- 新增 syscall `add2()`。
- 用户程序调用 `add2(20, 6)`。
- 内核通过 `argint(0, &a)` 和 `argint(1, &b)` 获取参数。
- 内核返回 `a + b`。
- 用户态程序 `add2test` 输出 `add2(20, 6) returned 26`。

该设计保持小规模，便于讲清楚 syscall number、用户态 stub、trap、dispatcher、`argint()` 参数读取、内核实现和返回值路径。

### 3.4 lab2：进程状态观察

lab2 的目标是从 lab1 syscall 参数传递自然过渡到进程表观察。当前实现选择 `pstate(int pid)`：

- 用户程序通过 `getpid()` 获取自己的 pid。
- 用户程序调用 `pstate(pid)`。
- 内核通过 `argint(0, &pid)` 获取 pid。
- 内核遍历 `proc[]` 查找目标进程。
- 读取 `p->state` 时持有 `p->lock`。
- 用户程序 `pstatetest` 输出 `pstate(self) = 4 (RUNNING)`。

该实验只观察单个 pid，不实现完整 `ps`，不修改调度算法。

### 3.5 后续扩展计划

后续计划不在本轮实现，只记录方向（`add2` 带参数 syscall 已在 3.3 完成，不再列为待办）：

- lab1 教学化：补充学生动手任务（给骨架让学生自己实现 syscall）、负向实验（故意漏 `entry`/dispatch 观察现象）、指针/字符串参数（`argaddr`/`argstr`）和评分标准，使其从"参考实现 demo"升级为"可布置的实验"。
- lab2 扩展：增加 `pcount(state)`、scheduler trace 或 ps-like summary。
- lab4：文件系统实验，例如 inode/file 相关观察或最小功能修改。

lab2 与 lab4 将根据初赛时间和队伍能力二选一深化，不同时推进过多未验证功能。当前 lab1 仅覆盖 syscall 入门与整数参数传递，**未覆盖指针/字符串参数和全部 syscall 机制**（见 `docs/14_lab1_argint_extension_review.md` 教学价值评估）。

## 4. 工程架构

### 4.1 自有仓库

本仓库存放自有文档、脚本、patch、测试记录和提交材料索引。官方 GitLab 是比赛主仓库，GitHub 是私有备份与协作仓库。

### 4.2 第三方源码隔离

xv6-riscv 源码位于：

```text
external/xv6-riscv/
```

该目录被 `.gitignore` 忽略，不提交第三方源码。

可提交 metadata 位于：

```text
external/xv6-baseline-record.md
```

### 4.3 patch 机制

lab1 的源码改动不直接提交 xv6-riscv 源码，而是导出 patch：

```text
patches/lab1-system-call/0001-add-hello-syscall.patch
patches/lab1-system-call/0002-add-argint-add2-syscall.patch
patches/lab2-process-observation/0001-add-pstate-syscall.patch
```

评委或队友可以从 clean baseline 应用 patch 复现。

### 4.4 日志策略

原始日志位于：

```text
logs/*.log
```

这些文件被 Git 忽略，不提交。项目文档只摘录关键命令、结果、环境和风险，不复制完整日志。

### 4.5 双远程策略

- `origin`：官方比赛 GitLab，最终提交主仓库。
- `github`：私有 GitHub 备份与协作仓库，用于 issue、协作和 Codex/Claude 辅助工作。

不得把 GitHub 当作最终比赛提交平台。

## 5. 当前真实成果

| 成果 | 状态 | 证据位置 |
| --- | --- | --- |
| 环境检测 | 已通过 | `scripts/check-env.sh`，`docs/04_test_report.md` |
| baseline make | 已成功 | `logs/xv6-make-20260603-235003.log` 摘要见 `docs/04_test_report.md` |
| baseline boot evidence | 已捕获 | `logs/xv6-boot-20260604-001736.log` 摘要见 `docs/04_test_report.md` |
| lab1 hello syscall patch | 已生成 | `patches/lab1-system-call/0001-add-hello-syscall.patch` |
| lab1 add2 argint patch | 已生成 | `patches/lab1-system-call/0002-add-argint-add2-syscall.patch` |
| lab2 pstate process observation patch | 已生成 | `patches/lab2-process-observation/0001-add-pstate-syscall.patch` |
| clean baseline apply 复现 | 已通过 stage2b 审查 | `docs/12_lab1_patch_review.md` |
| patched make | 已成功 | 摘要见 `docs/04_test_report.md` 与 `docs/12_lab1_patch_review.md` |
| hello 输出捕获 | 已成功 | 检测到 `hello syscall returned 2026` |
| add2 输出捕获 | 已成功 | 检测到 `add2(20, 6) returned 26`，见 `docs/14_lab1_argint_extension_review.md` |
| pstatetest 输出捕获 | 已成功 | 检测到 `pstate(self) = 4 (RUNNING)`，见 `docs/15_lab2_process_observation_review.md` |

以上均为当前阶段的真实记录。尚未完成的内容继续标记为 TODO。

## 6. lab1 技术说明

### 6.1 修改文件

| 文件 | 作用 |
| --- | --- |
| `kernel/syscall.h` | 增加 `SYS_hello 22` 和 `SYS_add2 23`。 |
| `kernel/syscall.c` | 声明 `sys_hello`、`sys_add2` 并加入 syscall dispatch table。 |
| `kernel/sysproc.c` | 实现 `sys_hello()` 和 `sys_add2()`。 |
| `user/user.h` | 声明 `int hello(void);` 和 `int add2(int, int);`。 |
| `user/usys.pl` | 增加 `entry("hello")` 和 `entry("add2")`，生成用户态 syscall stub。 |
| `Makefile` | 将 `_hello` 和 `_add2test` 加入 `UPROGS`。 |
| `user/hello.c` | 新增 hello 用户态测试程序。 |
| `user/add2test.c` | 新增 add2 用户态测试程序。 |

### 6.2 调用链

```text
user/hello.c
  -> user/user.h 中的 hello() 声明
  -> user/usys.pl 生成的用户态 stub
  -> ecall / trap 进入 kernel
  -> kernel/syscall.c 中的 syscall dispatcher
  -> kernel/sysproc.c 中的 sys_hello()
  -> 返回值通过 a0 回到用户态
  -> printf 输出 hello syscall returned 2026
```

`add2()` 调用链：

```text
user/add2test.c
  -> add2(20, 6)
  -> user/usys.pl 生成的 add2 stub
  -> ecall / trap 进入 kernel
  -> kernel/syscall.c 中的 syscall dispatcher
  -> kernel/sysproc.c 中的 sys_add2()
  -> argint(0, &a) 读取 20
  -> argint(1, &b) 读取 6
  -> 返回 26
```

### 6.3 教学意义

该实验可以引导学生依次理解：

- 用户程序如何声明和调用系统调用。
- syscall number 如何绑定用户态和内核态。
- `usys.pl` 如何生成用户态 stub。
- trap 之后内核如何通过 dispatch table 找到实现函数。
- `argint()` 如何从用户态寄存器约定中取出整数参数。
- 返回值如何从内核回到用户态。

## 7. 测试与证据

### 7.1 环境检查

```bash
bash scripts/check-env.sh
```

当前记录：基础工具 OK，QEMU OK，`riscv64-linux-gnu-gcc` OK，`riscv64-unknown-elf-gcc` WARN。

### 7.2 baseline 结构检查

```bash
bash scripts/xv6/check-xv6-baseline.sh
```

当前记录：baseline directory、`Makefile`、`LICENSE` 存在。

### 7.3 baseline make

```bash
bash scripts/xv6/check-xv6-baseline.sh --make
```

当前记录：已成功。原始日志不提交，摘要见 `docs/04_test_report.md`。

### 7.4 boot evidence

```bash
bash scripts/xv6/boot-xv6.sh
```

当前记录：已检测到 `xv6 kernel is booting` 和 `init: starting sh`。

### 7.5 hello 输出捕获

```bash
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
```

当前记录：已检测到 `hello syscall returned 2026`。

### 7.6 add2 输出捕获

```bash
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
```

当前记录：已检测到 `add2(20, 6) returned 26`。

### 7.7 clean apply review

stage2b 已完成 clean baseline patch reproducibility review，记录见：

```text
docs/12_lab1_patch_review.md
docs/14_lab1_argint_extension_review.md
docs/15_lab2_process_observation_review.md
```

### 7.8 lab2 pstate 输出捕获

```bash
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

当前记录：已检测到 `pstate(self) = 4 (RUNNING)`。

## 8. 风险与边界

| 风险 / 边界 | 当前处理 |
| --- | --- |
| timeout 自动捕获不是长期稳定性测试 | 文档中只写 boot evidence、hello evidence、add2 evidence 和 pstatetest evidence，不写长期稳定。 |
| 不是人工交互录屏 | 人工 demo 仍为 TODO，见 `videos/demo_script.md`。 |
| 第二名队员复现 | TODO，不伪造队友复现结果。 |
| `riscv64-unknown-elf-gcc` 缺失 | 当前使用 `riscv64-linux-gnu-gcc` 构建成功，继续记录 WARN。 |
| linker RWX warning | 已记录为风险；后续需要解释来源和影响。 |
| patch 绑定 baseline commit | patch 目标 commit 为 `74f84181a3404d1d6a6ff98d342233979066ebb8`，baseline 变化时需重新验证。 |
| lab1/lab2 patch 合并 | lab2 patch 独立于 lab1 patch，未来如要组合使用需要重新规划 syscall number。 |
| 第三方源码提交风险 | `external/xv6-riscv/` 被 `.gitignore` 忽略，验证 `git ls-files external/xv6-riscv` 无输出。 |
| 原始日志提交风险 | `logs/*.log` 被 `.gitignore` 忽略，验证 `git ls-files logs/*.log` 无输出。 |

## 9. AI 使用说明

AI 工具用于：

- 项目计划和文档结构整理。
- shell 脚本草案与审查辅助。
- 测试证据摘要整理。
- patch 复现文档和技术报告草案生成。

AI 工具不得用于：

- 伪造命令输出。
- 伪造测试通过记录。
- 伪造队友复现结果。
- 伪造视频、截图、评审意见或比赛成绩。

真实命令由队长执行或由 agent 在本地环境执行；AI 输出必须经人工复核后才能进入最终作品。持续记录见 `docs/05_ai_usage_record.md`。

## 10. 下一步路线

1. 第二名队员独立复现 lab0/lab1/lab2，并填写复现记录。
2. 完成人工交互 demo：手动进入 xv6 shell，输入 `hello`、`add2test`、`pstatetest`，退出 QEMU。
3. 将 lab1 的 hello/add2 两档内容和 lab2 pstate 内容整理成更完整的 step by step 教程。
4. 在 lab2 扩展或 lab4 中选择一个方向深化，避免同时展开过多内容。
5. 将本文档升级为初赛技术报告 v0.2，并补充 PPT 与 Demo 结果。

## 11. 附录索引

- 项目首页：`README.md`
- 测试报告：`docs/04_test_report.md`
- 内部红队审查：`docs/10_red_team_review.md`
- lab1 clean baseline 复现审查：`docs/12_lab1_patch_review.md`
- lab1 argint 进阶复现审查：`docs/14_lab1_argint_extension_review.md`
- lab1 patch 说明：`patches/lab1-system-call/README.md`
- lab2 进程观察复现审查：`docs/15_lab2_process_observation_review.md`
- lab2 patch 说明：`patches/lab2-process-observation/README.md`
- lab1 patch 应用脚本：`scripts/xv6/apply-lab1-patch.sh`
- 复现包：`reproducibility/README.md`
- Demo 脚本：`videos/demo_script.md`
- 初赛材料索引：`submissions/draft-report-index.md`
