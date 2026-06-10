# Final PPT Outline

> 目标：面向 2026 全国大学生计算机系统能力大赛 OS 功能挑战赛道 proj54 评委，展示 OUC xv6 Lab Kit 的项目定位、实验体系、验证证据和教学价值。

## Slide 1. 标题页

**Key message**  
OUC xv6 Lab Kit：面向中国海洋大学 OS 课程的 xv6-riscv 分阶段实验与可复现验证体系。

**Bullet content**

- 赛题：proj54 面向操作系统课程的操作系统竞赛和实验
- 队伍：中国海洋大学“蓝色系统队”
- historical stable checkpoint commit：`e8e2fb9`（integrated `0001-0007`，三方 full PASS）
- evidence commit：`03aad04`（covers `0001-0007`）；新 `0001-0009` final commit / 三方复现 / 视频 / SHA256 为 TBD

**Suggested visual**  
项目标题 + “Lab0-Lab5 / integrated 0001-0009 / 三方复现 PASS（historical 0001-0007；0001-0009 TBD）” 三个标签。

**Speaker notes**  
开场先说明项目不是 LTP 型内核实现项目，而是教学型功能挑战项目，重点是课程实验包与可复现体系。

## Slide 2. 赛题理解：教学型 OS 功能挑战

**Key message**  
proj54 的重点是课程实验设计、文档和复现，不是刷内核测试集。

**Bullet content**

- 文档完整度 50%
- 实现完整度 30%
- 测试完整度 10%
- 创新性 10%
- 材料组织目标：学生能看懂、老师能布置、助教能验收、评委能复现

**Suggested visual**  
评分权重环形图或 4 格矩阵。

**Speaker notes**  
强调设计决策都围绕评分权重：文档体系优先，功能实验适度，验证和证据链完整。

## Slide 3. 痛点：OS 实验难复现、难验收、难讲清

**Key message**  
传统 OS 实验常见问题不是“没有代码”，而是环境、复现和验收链条断裂。

**Bullet content**

- 环境工具链容易卡住
- QEMU 运行和退出体验差
- 同学不知道 make/boot 哪一步算成功
- 单个 syscall demo 难形成课程体系
- 评审材料容易混淆本机验证、队友复现和视频证据

**Suggested visual**  
从“环境失败 / QEMU 卡住 / 证据散落 / 文档不完整”到“one-shot verification”的流程对比。

**Speaker notes**  
引出本项目为什么投入大量工作在 doctor、cleanup、teammate summary、evidence manifest 上。

## Slide 4. 项目定位：OUC xv6 Lab Kit

**Key message**  
这是面向 OUC OS 课程的实验包，不只是若干系统调用样例。

**Bullet content**

- 使用 xv6-riscv 作为教学 baseline
- 不提交上游源码，只提交 patch、脚本、文档和证据摘要
- 学生路径：先会复现，再能修改，再理解机制
- 助教路径：可检查、可维护、可扩展

**Suggested visual**  
四层架构图：baseline -> labs -> integrated patches -> verification/evidence。

**Speaker notes**  
说明项目对课程教学的实际价值：降低上手门槛，同时保留内核机制理解。

## Slide 5. 实验体系总览 Lab0-Lab5

**Key message**  
实验体系从环境到系统调用、进程、页表、文件表，再到 capstone 复现。

**Bullet content**

- Lab0：baseline/build/boot
- Lab1：hello/add2 syscall
- Lab2：pstate/pcount/pchildtest
- Lab3：pgcount + eager/lazy allocation
- Lab4：fcount/fdcount
- Lab5：capstone 综合复现

**Suggested visual**  
横向时间线或阶梯图。

**Speaker notes**  
每个 lab 都是课程知识点，不是孤立功能堆叠。

## Slide 6. Lab1 系统调用机制

**Key message**  
Lab1 用 hello/add2 帮学生建立 syscall 全链路理解。

**Bullet content**

- `hello()`：最小 syscall
- `add2(int,int)`：引入参数传递
- 涉及 syscall number、dispatch table、user stub、kernel handler
- 测试输出稳定，适合作为入门验收

**Suggested visual**  
user program -> usys -> syscall.c -> sysproc.c -> return 的箭头图。

**Speaker notes**  
突出从“能跑”到“知道用户态如何进入内核”的教学转换。

## Slide 7. Lab2 进程观察

**Key message**  
Lab2 把 syscall 和进程表、状态枚举、调度时序连接起来。

**Bullet content**

- `pstate(pid)`：观察进程状态
- `pcount(state)`：统计状态数量
- `pchildtest`：观察子进程状态
- 不固定 `pcount(RUNNING)` 数值，不固定 child 状态

**Suggested visual**  
简化 `proc[]` 表格 + state 字段高亮。

**Speaker notes**  
强调这是观察实验，不修改调度器，不实现完整 `ps`。

## Slide 8. Lab3 页表与 eager/lazy allocation

**Key message**  
Lab3 用 `pgcount()` 把地址空间大小和实际页表映射区分开。

**Bullet content**

- `pgcount()` 统计 `PTE_V && PTE_U`
- eager `sbrk(2*PGSIZE)` delta = 2
- lazy reserve delta = 0
- touch one page delta = 1
- touch two pages delta = 2

**Suggested visual**  
两列对比：eager 立即映射 vs lazy 触碰后映射。

**Speaker notes**  
明确不是完整内存管理实验，不输出物理地址，不改 page fault。

## Slide 9. Lab4 文件表与 fd table

**Key message**  
Lab4 让学生区分当前进程 fd table 和全局 file table。

**Bullet content**

- `fcount()`：全局 file table 引用观察
- `fdcount()`：当前进程 `ofile[]` 观察
- open/dup/close 展示 fd delta
- `dup()` 增加 fd，但不等于新增全局 file entry

**Suggested visual**  
进程 fd table -> `struct file` -> global file table 的关系图。

**Speaker notes**  
明确不是完整文件系统实现，不涉及 inode/磁盘布局。

## Slide 10. Lab5 capstone 综合复现

**Key message**  
Lab5 把多个实验变成一次可提交、可验收的课程综合实验。

**Bullet content**

- clean baseline
- apply integrated `0001-0009`
- make + boot
- 跑全部用户程序测试
- 阅读 patch 并写实验报告

**Suggested visual**  
capstone checklist。

**Speaker notes**  
强调 Lab5 不是新增内核功能，而是综合复现和报告训练。

## Slide 11. integrated-labs `0001-0009` 与一键验证

**Key message**  
最终 integrated sequence 支持从 clean baseline 一键复现完整实验链。

**Bullet content**

- `0001` hello = 22
- `0002` add2 = 23
- `0003` pstate = 24
- `0004` pcount = 25
- `0005` fcount = 26
- `0006` pgcount = 27
- `0007` fdcount = 28
- `0008` memstat = 29（进阶，argaddr+copyout+struct ABI）
- `0009` fdinfo = 30（进阶，argint+argaddr+copyout+struct ABI）
- `teammate-verify.sh --full`（现含 memstattest/fdinfotest）

**Suggested visual**  
patch sequence 表格 + 命令框。

**Speaker notes**  
说明 integrated patch 解决了独立实验 syscall number 冲突，并形成评委快速复现路径。

## Slide 12. 三方复现证据：rain/root/z2996

**Key message**  
`e8e2fb9 / 0001-0007` 已完成队长本机和两位队友 full verification PASS（historical stable checkpoint）；含 memstat/fdinfo 的 `0001-0009` 三方复现为 TBD。

**Bullet content**

- `rain`：team lead local full PASS
- `root`：teammate A full PASS
- `z2996`：teammate B full PASS
- 覆盖 doctor/check-env/baseline/apply+make/boot/all user tests，但只覆盖 `0001-0007`
- stage11b `0001-0009` 队长本机 `local-verify --full` PASS；`0001-0009` 三方 full verify 为 TBD
- raw summary/log/screenshot 不入 Git

**Suggested visual**  
三列 PASS 证据卡片。

**Speaker notes**  
区分队长本机验证和队友复现；旧 `1ba9db6` 证据只作为 historical。

## Slide 13. 演示视频与 evidence manifest

**Key message**  
证据链以 metadata + SHA256 方式管理，原始大文件保存在仓库外。

**Bullet content**

- `0001-0007` 视频（historical stable checkpoint）：`20260606_final_integrated_0001_0007_demo.mp4`
- 该视频 SHA256：`0FF2D358...668A93B`（只覆盖 `0001-0007`）
- 覆盖 `0001-0009`（含 memstat/fdinfo）的新视频与新 SHA256：TBD，不得伪造
- `submissions/evidence_manifest.md`
- old videos are historical/superseded
- privacy review pending final manual review

**Suggested visual**  
evidence manifest 截图式结构图：final evidence / historical evidence / non-committed policy。

**Speaker notes**  
说明为什么不把视频、截图、raw logs 放入 Git，同时仍可用 SHA256 核验。

## Slide 14. 创新点与教学价值

**Key message**  
项目创新在课程化组织和可复现验收，而不是盲目扩展内核。

**Bullet content**

- 可直接开课：lab 任务书 + 教师指南 + 评分标准 + troubleshooting
- OUC 本校课程叙事
- clean-baseline patch workflow
- full/quick teammate verification
- QEMU timeout/cleanup 体验优化
- AI 使用透明记录
- 证据边界清晰

**Suggested visual**  
创新点六边形或 2x3 卡片。

**Speaker notes**  
把创新性落到教学和工程可维护性上，而不是夸大功能规模。

## Slide 15. 边界、未来工作与总结

**Key message**  
当前成果完整覆盖课程实验闭环，后续可扩展但不夸大已完成内容。

**Bullet content**

- 不声称长期稳定性测试
- `pgcount()` 不是完整内存管理
- `fcount()` / `fdcount()` 不是完整文件系统
- Lab5 不是新内核机制
- 待确认：平台提交方式、隐私复核、引用 URL/许可证、PPT 成稿
- 总结：学生能看懂、老师能布置、助教能验收、评委能复现

**Suggested visual**  
“已完成 / 边界 / 后续”三栏总结。

**Speaker notes**  
用诚实边界收尾，体现材料可信度和后续课程维护价值。
