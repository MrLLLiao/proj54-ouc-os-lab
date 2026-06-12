# 最终答辩 PPT 源稿

> stage16-redesign-with-ppt-skill 的 PPT 文案源，用于生成 `slides/final_defense_ppt.pptx`。
> 可见页面以中文为主；commit id、SHA256、命令、文件名和 syscall 名保留原样。
> PPTX 不嵌入视频、截图、raw summaries、raw logs 或网盘资产。

## Slide 1. 从能跑，到能教

**Key message**

我们不只是给 xv6 加了九个系统调用，而是把它整理成一套可学习、可复现、可验收的 OS 入门实验包。

**Bullet content**

- 赛题：2026 OS 功能挑战赛道 proj54
- 队伍：中国海洋大学“蓝色系统队”
- 工程 commit：`db85947`
- 集成补丁：`0001-0009`
- 三方全量验证：rain / root / z2996 全通过

**Visual labels**

- OUC xv6 Lab Kit
- 可学习
- 可复现
- 可验收
- db85947
- 0001-0009
- 三方通过

**Speaker notes**

开场要把主线说清楚：这不是一组零散系统调用展示，而是一套面向课程的 xv6-riscv 实验包。我们的重点是让学生能按阶段学习，让助教能按统一口径验收，让评委能从 干净基线复现。

## Slide 2. 评分口径决定路线

**Key message**

这个赛题不是 LTP 刷分赛道，官方评价把源代码执行、文档、答辩过程和演示材料放在同一条线上。

**Bullet content**

- 初赛：项目/源代码执行展示 50%，文档展示 50%
- 决赛：初赛 20%，决赛 80%
- 决赛阶段：项目/源代码执行展示 15%，设计方案文档 25%，现场答辩/过程记录/源码分析/最终方案/PPT/演示视频 40%
- 我们的路线：代码功能适度，文档体系完整，复现证据可核验

**Visual labels**

- 初赛
- 源代码执行 50%
- 文档展示 50%
- 决赛
- 初赛成绩 20%
- 决赛表现 80%
- 决赛阶段
- 执行展示 15%
- 设计文档 25%
- 答辩/过程/源码/PPT/视频 40%

**Speaker notes**

这一页必须纠正旧版本的非官方权重表述。我们现在按官方口径讲：初赛看执行展示和文档，决赛还看现场答辩、过程记录、源码分析、最终方案、PPT 和演示视频。因此项目建设不能只做内核功能。

## Slide 3. 复现才是第一道坎

**Key message**

真实教学场景里，学生和队友最容易卡在环境、补丁顺序、QEMU、日志和验收口径。

**Bullet content**

- 环境：WSL、RISC-V 工具链、QEMU 版本
- 过程：应用补丁、编译、启动、运行命令容易混在一起
- 运行：Ctrl+Z 会挂起 QEMU，不是退出
- 证据：截图不能替代摘要、命令和 SHA256
- 解决：环境检查 -> 应用编译 -> 启动运行 -> 结果摘要 -> 证据索引

**Visual labels**

- 环境
- 过程
- 运行
- 证据
- 环境检查
- 应用编译
- 启动运行
- 摘要
- 证据索引

**Speaker notes**

这里讲真实痛点，不讲空话。队友复现里曾出现等待过久、误按 Ctrl+Z、不知道哪一步成功的问题，所以我们把“复现体验”作为工程目标来做。

## Slide 4. 项目定位：课程实验包

**Key message**

同一套仓库要让学生能学、老师能布置、助教能验收、评委能复现。

**Bullet content**

- 学生：README、lab README、student_tasks、预期输出
- 老师：teacher guide、课程节奏、评分 rubrics
- 助教：labctl、队友摘要、grade-summaries
- 评委：docs/final、证据索引、最终演示元数据
- 边界：external/xv6-riscv 不入库，raw evidence 不入库

**Visual labels**

- 学生
- 老师
- 助教
- 评委
- OUC xv6 实验包

**Speaker notes**

这个仓库不是只给开发者看的。学生、老师、助教和评委都有不同入口，所以我们把 README、docs/final、labs、scripts、submissions 分开组织。

## Slide 5. 证据从干净基线开始

**Key message**

每次完整复现都从干净 xv6 baseline 出发，补丁、验证和证据文件之间有清晰链路。

**Bullet content**

- 干净 xv6 baseline
- 独立实验补丁
- 集成补丁 0001-0009
- labctl / teammate-verify
- 摘要 / grade-summaries
- 证据索引 / SHA256

**Visual labels**

- 干净基线
- 独立实验
- 集成 0001-0009
- labctl / 验证
- 摘要 / 汇总
- 证据索引
- 不提交 external
- 不提交原始证据

**Speaker notes**

这一页讲工程可信度。第三方 xv6 源码不进 Git，补丁序列是仓库里的事实，验证脚本把 make、boot、用户程序和 summary 串起来，最后由 证据索引管理外部证据。

## Slide 6. Lab 矩阵：从环境到综合复现

**Key message**

Lab0-Lab5 的设计目标是小步进入 OS 机制，每一阶段都有明确学习点和验收项。

**Bullet content**

- Lab0 | 环境与启动 | build / boot
- Lab1 | 系统调用入口 | hello / add2
- Lab2 | 进程状态观察 | pstate / pcount / pchildtest
- Lab3 | 页表与 copyout | pgcount / memstat
- Lab4 | fd 与 file | fcount / fdcount / fdinfo
- Lab5 | 综合复现 | 全量验证

**Visual labels**

- 实验
- 学什么
- 验什么
- 从环境到综合复现

**Speaker notes**

Lab 矩阵要让评委一眼看到课程设计，而不是看到一堆 syscall 名字。每个 Lab 都有机制、用户程序、测试和文档。

## Slide 7. Lab1/2：先走通内核入口

**Key message**

Lab1/2 让学生从最小系统调用进入内核，再观察进程表和调度带来的非固定输出。

**Bullet content**

- 用户程序 -> usys -> syscall -> sys_* -> kernel helper
- hello：最小系统调用链路
- add2：argint 参数读取
- pstate / pcount：进程状态观察
- pchildtest：调度时序导致输出不固定

**Visual labels**

- 用户程序
- usys
- syscall
- sys_*
- kernel helper
- 进程表快照
- 状态受调度影响

**Speaker notes**

Lab1 是入口，Lab2 是第一个内核表观察。这里强调 pchildtest 输出受调度影响，这不是失败，而是 OS 课程里应该讲清楚的现象。

## Slide 8. Lab3：页表与 copyout

**Key message**

Lab3 通过 pgcount 和 memstat 区分“地址空间增长”和“真实用户页映射”。

**Bullet content**

- pgcount：统计 PTE_V && PTE_U 的用户页映射
- eager sbrk：申请 2 页后 delta = 2
- lazy sbrklazy：touch 前 0，touch 后 1/2
- memstat：argaddr + copyout + struct ABI
- 边界：这是页表观察，不是完整内存管理

**Visual labels**

- eager sbrk
- 立即映射 2 页
- lazy sbrklazy
- touch 前 0
- touch 后 1 / 2
- argaddr
- copyout
- struct memstat

**Speaker notes**

这一页是技术亮点。学生常把“申请地址空间”和“真实映射页面”混在一起。pgcount 和 lazy 对比把这个差异变成可观察结果；memstat 再引入结构化 copyout。

## Slide 9. Lab4：fd 与 file 的关系

**Key message**

Lab4 把当前进程 fd table 和全局 file table 拆开观察，避免把文件系统讲成黑盒。

**Bullet content**

- fcount：观察全局 file table 使用趋势
- fdcount：统计当前进程 ofile[] 非空项
- fdinfo：返回单个 fd 的结构化元数据
- open / dup / close：观察趋势，不依赖绝对数
- 边界：这是文件表观察，不是完整文件系统

**Visual labels**

- 当前进程 ofile[]
- fd 0 / 1 / 2 / 3
- struct file
- 全局 file table
- fcount
- fdcount
- fdinfo

**Speaker notes**

这里要把 fd 和 file 的关系讲出来。fd 是进程视角，file table 是内核全局结构；open、dup、close 的趋势比绝对数更适合教学。

## Slide 10. Lab5：把实验变成验收

**Key message**

Lab5 不新增内核机制，而是把 Lab0-Lab4 串成一次完整的干净基线到全量验证。

**Bullet content**

- 干净基线
- 应用集成补丁 0001-0009
- make
- boot
- 运行全部用户程序测试
- 复制 summary 给队长/助教
- 写清真实结果、失败记录和边界

**Visual labels**

- 干净基线
- 应用 0001-0009
- make
- boot
- 测试
- 摘要
- 报告
- Lab5 = 综合复现

**Speaker notes**

Lab5 的定位要避免误解。它不是新系统调用，而是综合复现实验。学生最终要交的不只是“能跑”，还要说明如何验证、哪里失败过、边界是什么。

## Slide 11. 工具链：从脚本到课程入口

**Key message**

工具链把复杂命令收束成课程入口，同时保留真实日志、摘要和可复核证据。

**Bullet content**

- labctl：课程统一入口
- teammate-verify：全量 / 快速复现流程
- cleanup-qemu：处理 Ctrl+C / Ctrl+Z 后的 QEMU 残留
- grade-summaries：3 clean PASS / 0 needs attention
- check-docs-consistency / check-evidence-sha256：防止状态漂移和证据失真

**Visual labels**

- labctl
- teammate-verify
- QEMU
- 摘要
- grade-summaries
- 文档一致性
- SHA256 核验
- 课程入口

**Speaker notes**

这一页讲工具链升级。我们不是把脚本堆在一起，而是把它组织成课程入口、复现入口、验收入口和提交前门禁。

## Slide 12. 三方复现证据

**Key message**

最终 HEAD 的结果不是单机截图，而是队长和两位队友的全量验证摘要。

**Bullet content**

- rain：全量验证通过
- root：全量验证通过
- z2996：全量验证通过
- grade-summaries：3 clean PASS / 0 needs attention
- 工程复现 commit：db85947

**Visual labels**

- rain
- root
- z2996
- 全量验证通过
- grade-summaries
- 3 clean PASS
- 0 needs attention
- 工程复现 commit：db85947

**Speaker notes**

这里保持克制：我们只说已经有 summary 和外部证据的事实，不编造队友真实姓名或系统版本。root 和 z2996 是终端 user。三方 full verification summary 的 current commit 是 db85947；caf8ced 只是 evidence documentation commit，用于记录 final demo、三方复现、SHA256 和外部资产索引。

## Slide 13. 证据链可以重新计算

**Key message**

视频和截图不进 Git，但外部文件名、大小、时长、SHA256 和网盘位置都可以复核。

**Bullet content**

- 文件：20260611_final_integrated_0001_0009_demo.mp4
- 时长/规格：00:03:12，2560×1440，60 fps
- 大小：31,529,984 bytes
- SHA256：2A2C9863C185846225A98AC874499867A71588CED2020A64249CBF99C7BC0365
- 网盘：proj54_submission_assets，提取码 1234
- 哈希检查：14/14 matched

**Visual labels**

- 最终视频
- 元数据
- SHA256
- 网盘资产包
- 14/14 matched
- Git 只保存摘要

**Speaker notes**

这页解决“证据在哪里”和“如何证明没改过”。仓库不提交大文件，但记录了足够的元数据和 SHA256；下载外部资产后可以用脚本重新核验。

## Slide 14. 与 uCore/rCore 的差异

**Key message**

本项目不是替代 uCore/rCore，而是面向 OUC 课程的轻量 xv6 入门实验包。

**Bullet content**

- uCore/rCore 等课程生态覆盖更广，适合完整 OS 课程体系
- 本项目不试图替代它们，而是聚焦 OUC 的 xv6-riscv 入门实验
- 左侧是完整课程生态：覆盖更广，学习周期更长
- 右侧是本项目：更轻量，更适合入门实验和可复现验收
- 重点是小步 patch workflow、clean baseline 复现、Lab0-Lab5 教学路径、三方 full verify 和证据 manifest

**Visual labels**

- 完整课程生态
- 本项目
- 覆盖更广
- 更轻量
- 学习周期更长
- 可复现验收

**Speaker notes**

不要贬低同类项目，也不要在答辩页上放旁支引用说明。这里强调差异：本项目更轻、更贴近本校课程，更强调干净基线、三方复现和证据边界。

## Slide 15. 创新在组织方式

**Key message**

创新不只在系统调用，而在实验组织、工具入口、复现证据和诚信边界同时可执行。

**Bullet content**

- 干净基线补丁流
- copyout advanced labs：memstat / fdinfo
- 课程材料：student_tasks、teacher guide、rubric
- 复现工具：doctor、teammate-verify、cleanup-qemu
- 验收证据：grade-summaries、证据索引、SHA256

**Visual labels**

- 基线补丁流
- copyout 进阶实验
- 课程材料
- 复现工具
- 验收证据
- 可执行的组织创新

**Speaker notes**

这页不能写成“赋能”“闭环”。直接指向仓库里的东西：补丁序列、课程材料、验证脚本、摘要解析和证据索引。

## Slide 16. 边界与总结

**Key message**

边界说清楚，可信度才站得住：它不是完整内核工程，但是真实、可复现、可教学。

**Bullet content**

- 已完成：integrated 0001-0009，Lab0-Lab5 课程实验体系
- 已验证：rain / root / z2996 全量验证通过，14/14 SHA256 matched
- 历史点：e8e2fb9 / 0001-0007 只作为历史检查点
- 不夸大：pgcount/memstat 不是完整内存管理，fcount/fdcount/fdinfo 不是完整文件系统
- 提交前最后确认：平台提交方式最终确认；PPT 5-8 分钟人工排练；按 submission_checklist 跑最终全检

**Visual labels**

- 已完成
- 已验证
- 历史点
- 不夸大
- 最后确认
- 真实
- 可复现
- 可教学

**Speaker notes**

最后回到可信度。我们完成了课程实验包和证据链，但不把观察型实验包装成完整内核能力。答辩收束在“真实、可复现、可教学”。
