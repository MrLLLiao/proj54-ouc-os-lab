# 00 Project Overview

## 一句话简介

OUC xv6 Lab Kit 是面向中国海洋大学操作系统课程的 xv6-riscv 分阶段实验指导、参考实现与可复现验证体系。

## 赛题定位

本项目对应 2026 全国大学生计算机系统能力大赛 - 操作系统设计赛（全国）- OS 功能挑战赛道 proj54：面向操作系统课程的操作系统竞赛和实验。

proj54 是教学型功能挑战，不是“内核实现赛道刷 LTP”项目。本项目的核心价值不是堆叠大量未验证内核功能，而是把低年级同学可以理解、可以复现、可以继续扩展的 OS 实验链条搭起来。

## 面向对象

- 中国海洋大学计算机相关专业低年级学生。
- 第一次从 Linux/命令行进入 xv6 实验的同学。
- 准备参加 OS 功能挑战赛、需要理解 syscall、进程表和文件表的同学。
- 后续维护课程实验包的助教和队员。

## 评分权重对应

| 赛题关注点 | 权重 | 本项目对应材料 |
| --- | ---: | --- |
| 文档完整度 | 50% | `docs/final/` 正式文档、各 lab 教程式 README 与 `student_tasks.md`（必做/选做/评分 rubric）、教师指南/评分标准/troubleshooting（`docs/teacher_guide.md` 等）、常见错误、测试方法、边界说明、AI/许可证声明 |
| 实现完整度 | 30% | lab0/lab1/lab2/lab3/lab4 与 integrated `0001-0009`（含进阶 memstat `0008` / fdinfo `0009`），覆盖 syscall、进程观察、页表观察、file table / fd table 观察和 copyout struct ABI |
| 测试完整度 | 10% | `doctor.sh`、`teammate-verify.sh`、`local-verify.sh`、boot/command evidence、测试覆盖表 |
| 创新性 | 10% | OUC 本校课程叙事、clean baseline patch workflow、队友一键复现、QEMU cleanup/timeout 体验、透明 AI 过程记录 |

## 当前完成状态

| 模块 | 状态 | 说明 |
| --- | --- | --- |
| lab0 | 已完成 | 环境检查、baseline metadata、make、boot evidence |
| lab1 | 已完成 | `hello()` 与 `add2(int,int)` syscall |
| lab2 | 已完成 | `pstate`、`pcount`、`pchildtest` |
| lab3 | integrated 已完成 | `pgcount()` 页表映射数量观察；eager/lazy allocation 对比；integrated `0006`；stage11b 进阶 `memstat()` 进入 integrated `0008`（`SYS_memstat = 29`，argaddr + copyout + struct ABI） |
| lab4 | v0.2 已完成 | `fcount()` 全局 file table 观察；`fdcount()` 当前进程 fd table 观察；stage11b 进阶 `fdinfo()` 进入 integrated `0009`（`SYS_fdinfo = 30`，argint + argaddr + copyout + struct ABI） |
| lab5 | capstone 已完成 | 综合复现实验文档；不新增内核机制；workflow 基于 integrated `0001-0009` |
| integrated-labs | `0001-0009`（stage11b） | `0001-0009` 可从 clean baseline 顺序应用并 make；队长本机 `local-verify --full` overall PASS（含 memstattest/fdinfotest） |
| 一键验证 | 已更新 | doctor/local/teammate/cleanup 脚本；local/teammate 覆盖 pgcounttest、fdcounttest、memstattest 和 fdinfotest |
| 视频 | `0001-0007` historical；`0001-0009` TBD | `e8e2fb9` / integrated `0001-0007` 视频已记录大小、时长、SHA256，降级为 historical stable checkpoint，只覆盖 `0001-0007`；覆盖 `0001-0009` 的新视频与新 SHA256 为 TBD；旧三段视频为 historical evidence |
| 队友独立复现 | `0001-0007` historical；`0001-0009` TBD | root 与 z2996 两份 `e8e2fb9` / integrated `0001-0007` full PASS 已记录，为 historical stable checkpoint，不覆盖 `0001-0009`；含 memstat/fdinfo 的 `0001-0009` 队友 full verify 为 TBD，不得伪造；旧 `1ba9db6` 只作 historical evidence |
| 教学材料（stage12） | 已完成 | 每个 lab 配教程式 README + `student_tasks.md`（必做/选做/rubric/扣分点）；`docs/teacher_guide.md`（2/3/5 次课排法与验收）、`docs/grading_and_rubric.md`、`docs/troubleshooting.md`；根 README 与 docs 导航改为学习者优先，比赛证据分层到 `submissions/` 与 `docs/final/` |

## OUC 本校课程特色

本项目按“先会复现，再能修改，再理解设计”的课程路径组织：

1. lab0 解决环境和 baseline，降低首次进入 OS 实验的门槛。
2. lab1 从最小 syscall 到带整数参数 syscall，帮助学生理解 user/kernel 边界。
3. lab2 把 syscall 连接到进程表、状态枚举和锁。
4. lab3 把 syscall 连接到用户页表、`PTE_V/PTE_U` 和 eager/lazy allocation 观察。
5. lab4 连接用户态 fd、内核 `struct file`、全局 file table 和引用计数。
6. integrated-labs 让多个实验在同一构建中演示，避免“每个实验只能孤立跑”的问题。

这个组织方式更适合课程教学和竞赛入门，而不是单次功能冲刺。

## 同类项目对比定位

| 项目 | 主要价值 | 本项目借鉴方式 | 本项目差异 |
| --- | --- | --- | --- |
| xv6-riscv | 小型教学 OS，代码适合课堂讲解 | 作为实验主线与 baseline | 本仓库不提交上游源码，只提交 patch、脚本、文档和 metadata |
| uCore | 国内课程 OS 实验体系代表 | 借鉴分阶段实验组织 | 本项目聚焦 OUC 本校 xv6-riscv 入门，不重写 uCore 体系 |
| rCore | Rust OS 教学体系代表 | 借鉴文档结构和 step-by-step 叙事 | 本项目使用 C/xv6-riscv，面向低年级 syscall/进程/文件表入门 |
| YatSen OS / F-Tutorials / 往届作品 | 竞赛材料组织与展示参考 | 作为报告、PPT、实验包对比对象 | 具体 URL、许可证和引用位置待最终补充 |

以上对比用于项目定位，不表示复制其代码或文档。正式引用见 `docs/final/10_reference_and_license_statement.md`。

## 关键边界

- 不提交 `external/xv6-riscv/`。
- 不提交 `logs/*.log`、`logs/*.summary.txt`、视频、大文件、隐私材料。
- 不把旧 commit `1ba9db6` 的队友 PASS 写成 `e8e2fb9` 复现；旧记录只作为 historical/superseded evidence。
- 不把 `e8e2fb9 / 0001-0007` 的三方 full PASS 和旧视频写成覆盖 current integrated `0001-0009`；它们是 historical stable checkpoint，`0001-0009` 的新 commit、三方 full verify、新视频、新 SHA256 均为 TBD。
- 不把 `memstat()` 写成完整内存管理，不把 `fdinfo()` 写成完整文件系统；二者都是只读观察，不返回物理地址、路径、inode 号或文件内容。
- 不把 Lab5 写成新的内核机制；它是 capstone 综合复现实验。
- 不把 timeout 捕获写成长期稳定性测试。
- 不把 lab4 `fcount()` / `fdcount()` 写成完整文件系统实验。
- 不把队长本机验证写成队友独立复现；final 记录中队长本机、队友 root、队友 z2996 分开记录，未知真实姓名和系统版本保持待补充。
- 不把本项目表述为 LTP 覆盖或内核实现赛道项目。

## 下一步产出

- 基于 `docs/final/` 整理技术报告 v1.0。
- 基于 `docs/final/00`、`06`、`08` 制作 PPT。
- 补充队友真实姓名和系统版本（如最终材料需要）。
- 确认平台提交方式和视频/截图最终隐私复核。
- 最终核查参考来源 URL 与许可证。
