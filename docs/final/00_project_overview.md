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
| 文档完整度 | 50% | `docs/final/` 正式文档、各 lab 教程、常见错误、测试方法、边界说明、AI/许可证声明 |
| 实现完整度 | 30% | lab0/lab1/lab2/lab3 independent/lab4 patch 与 integrated `0001-0005`，覆盖 syscall、进程观察、页表观察和文件表观察 |
| 测试完整度 | 10% | `doctor.sh`、`teammate-verify.sh`、`local-verify.sh`、boot/command evidence、测试覆盖表 |
| 创新性 | 10% | OUC 本校课程叙事、clean baseline patch workflow、队友一键复现、QEMU cleanup/timeout 体验、透明 AI 过程记录 |

## 当前完成状态

| 模块 | 状态 | 说明 |
| --- | --- | --- |
| lab0 | 已完成 | 环境检查、baseline metadata、make、boot evidence |
| lab1 | 已完成 | `hello()` 与 `add2(int,int)` syscall |
| lab2 | 已完成 | `pstate`、`pcount`、`pchildtest` |
| lab3 | independent 已完成 | `pgcount()` 页表映射数量观察；eager/lazy allocation 对比；未 integrated |
| lab4 | 已完成 | `fcount()` 文件表引用计数观察 |
| integrated-labs | 已完成 | `0001-0005` 可从 clean baseline 顺序应用并 make |
| 一键验证 | 已完成 | doctor/local/teammate/cleanup 脚本 |
| 视频 | 已录制 3 段 | 文件在仓库外；文件名/大小/外部位置已记录，时长和平台提交方式待补充 |
| 队友独立复现 | 已收到 2 份 full PASS summary | 原始 logs/summary/截图不入仓；文字摘要见 `submissions/teammate_reproduction_record.md`；真实姓名/系统版本待补充 |

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
- 不把 Lab3 independent patch 写成 integrated `0006` 或队友已复现。
- 不把 timeout 捕获写成长期稳定性测试。
- 不把 lab4 `fcount()` 写成完整文件系统实验。
- 不把队长本机验证写成队友独立复现；队友记录只按已收到 summary/截图摘要整理，未知姓名和系统版本保持待补充。
- 不把本项目表述为 LTP 覆盖或内核实现赛道项目。

## 下一步产出

- 基于 `docs/final/` 整理技术报告 v1.0。
- 基于 `docs/final/00`、`06`、`08` 制作 PPT。
- 补充队友真实姓名和系统版本（如最终材料需要）。
- 补充视频时长和平台提交方式。
- 最终核查参考来源 URL 与许可证。
