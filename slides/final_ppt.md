# Final Defense PPT Source

> Source for `slides/final_defense_ppt.pptx`.  
> Scope: integrated `0001-0009`（stage11b；新增 memstat `0008` / fdinfo `0009`）。Historical stable checkpoint: integrated `0001-0007`, engineering commit `e8e2fb9`, evidence commit `03aad04`. 新 `0001-0009` 的三方 full verify / 视频 / SHA256 为 TBD。
> Boundary: this deck does not embed videos, screenshots, raw logs, teammate private material, or third-party images.

## Slide 1. OUC xv6 Lab Kit

**Key message**  
面向中国海洋大学操作系统课程的 xv6-riscv 分阶段实验指导、参考实现与可复现验证体系。

**Bullet content**

- 赛题：2026 全国大学生计算机系统能力大赛 OS 功能挑战赛道 proj54。
- 队伍：中国海洋大学“蓝色系统队”。
- historical stable checkpoint commit：`e8e2fb9`（integrated `0001-0007`，三方 full PASS）。
- 最终证据 commit：`03aad04`（covers `0001-0007`）；新 `0001-0009` final commit 为 TBD。
- 核心成果：Lab0-Lab5、integrated `0001-0009`（含进阶 memstat/fdinfo）；`0001-0007` 三方 full PASS 为 historical，`0001-0009` 三方复现为 TBD。

**Suggested visual**  
标题页 + 三个证据标签：`Lab0-Lab5`、`integrated 0001-0009`、`rain/root/z2996 PASS（historical 0001-0007；0001-0009 TBD）`。

**Speaker notes**  
开场先明确本项目是教学型功能挑战项目，主线是课程实验体系和可复现验证，不是内核实现赛道的 LTP 覆盖项目。

## Slide 2. 赛题理解：教学型 OS 功能挑战

**Key message**  
proj54 的重点是课程实验设计、文档和复现闭环，不是盲目扩展内核或刷测试集。

**Bullet content**

- 文档完整度 50%：正式文档体系、每个 lab 的教学说明、报告与提交材料。
- 实现完整度 30%：系统调用、进程、页表、文件表和 capstone 复现。
- 测试完整度 10%：脚本验证、QEMU 输出匹配、三方复现证据。
- 创新性 10%：OUC 本校课程化组织、clean-baseline patch、evidence manifest。
- 材料组织目标：学生能看懂、老师能布置、助教能验收、评委能复现。

**Suggested visual**  
4 格评分权重图：文档 / 实现 / 测试 / 创新。

**Speaker notes**  
解释为什么我们没有把目标设成大规模内核功能，也没有把 timeout 证据包装成长期稳定性测试。

## Slide 3. 课程实验痛点

**Key message**  
OS 实验的真实难点经常不是“写不出一行代码”，而是环境、过程、验收和证据链断裂。

**Bullet content**

- 环境工具链复杂：WSL2、RISC-V 工具链、QEMU、xv6 baseline。
- 运行体验不稳定：QEMU 可能卡住，`Ctrl+Z` 是挂起而不是退出。
- 学生难判断哪一步成功：make、boot、用户程序输出边界不清。
- 助教难验收：单个 syscall demo 难形成课程体系。
- 提交材料易混乱：本机验证、队友复现、视频证据和 raw logs 需要分层管理。

**Suggested visual**  
痛点到解决方案的流程图：环境诊断 -> 一键 apply/make -> boot/run -> summary -> manifest。

**Speaker notes**  
这页把工程工具链和文档体系的价值讲清楚：它们不是附属物，而是教学项目能落地的基础设施。

## Slide 4. 项目定位：OUC xv6-riscv 实验包

**Key message**  
本项目把 xv6-riscv 组织成面向 OUC OS 课程的分阶段实验包，而不是孤立的 syscall 样例集合。

**Bullet content**

- 基于 xv6-riscv clean baseline，提交增量 patch、脚本、文档和证据摘要。
- 学生路径：先复现，再修改，再解释机制。
- 助教路径：可检查、可复现、可复用、可扩展。
- 仓库边界清晰：`external/xv6-riscv/`、raw logs、视频和截图不入 Git。
- 正式材料入口：`README.md`、`docs/final/`、`submissions/evidence_manifest.md`。

**Suggested visual**  
四层架构：baseline -> labs -> integrated patches -> verification/evidence。

**Speaker notes**  
强调课程适配：降低入门门槛，同时保留对 user/kernel 边界、进程表、页表和文件表的真实理解。

## Slide 5. 实验体系总览：Lab0-Lab5

**Key message**  
实验主线从环境复现逐步推进到系统调用、进程、页表、文件表，最后汇总成 capstone 综合复现实验。

**Bullet content**

- Lab0：baseline/build/boot，先确认环境可靠。
- Lab1：`hello()` / `add2()`，建立 syscall 全链路。
- Lab2：`pstate()` / `pcount()` / `pchildtest`，观察进程状态。
- Lab3：`pgcount()`，观察页表映射数量和 eager/lazy allocation。
- Lab4：`fcount()` / `fdcount()`，观察全局 file table 与当前进程 fd table。
- Lab5：capstone 综合复现，不新增内核机制。

**Suggested visual**  
横向路线图：Lab0 -> Lab1 -> Lab2 -> Lab3 -> Lab4 -> Lab5。

**Speaker notes**  
每个 lab 都对应一个课程知识点，Lab5 是复现与报告训练，不应被理解成新的内核功能。

## Slide 6. Lab1：系统调用机制 hello/add2

**Key message**  
Lab1 用最小 syscall 和带参数 syscall 帮学生建立 user/kernel 调用链路。

**Bullet content**

- `hello()`：最小系统调用，适合建立路径感。
- `add2(int, int)`：引入参数传递和 `argint()`。
- 涉及 syscall number、dispatch table、user stub、kernel handler。
- 测试输出稳定，适合作为后续实验的入门验收。
- integrated 编号：`SYS_hello=22`，`SYS_add2=23`。

**Suggested visual**  
`user/hello.c -> usys.S -> syscall.c -> sysproc.c -> return` 箭头图。

**Speaker notes**  
这不是为了增加一个有业务价值的 syscall，而是让学生第一次完整走通 xv6 系统调用机制。

## Slide 7. Lab2：进程观察 pstate/pcount/pchildtest

**Key message**  
Lab2 把系统调用和 `proc[]`、进程状态枚举、调度时序连接起来。

**Bullet content**

- `pstate(pid)`：观察指定进程状态。
- `pcount(state)`：统计某类状态的进程数量。
- `pchildtest`：观察子进程状态，理解调度时序影响。
- 不固定 `pcount(RUNNING)` 的绝对数字。
- 不把 `pchildtest` 状态写成确定常量。

**Suggested visual**  
简化 `proc[]` 表格，突出 `pid`、`state`、`lock`。

**Speaker notes**  
这里的教学价值是观察和解释，不是实现完整 `ps`，也不是修改调度器。

## Slide 8. Lab3：页表映射与 eager/lazy allocation

**Key message**  
Lab3 用 `pgcount()` 区分“地址空间大小”和“实际页表映射数量”。

**Bullet content**

- `pgcount()` 统计当前进程用户页表中 `PTE_V && PTE_U` 的页。
- eager `sbrk(2*PGSIZE)`：真实计算 delta = 2。
- lazy `sbrklazy(2*PGSIZE)`：touch 前 delta = 0。
- touch one page 后 delta = 1；touch two pages 后 delta = 2。
- 不输出物理地址，不修改 page fault/lazy allocation 逻辑。

**Suggested visual**  
两列对比：eager 立即映射 2 页；lazy 预留后按触碰映射 0/1/2 页。

**Speaker notes**  
明确边界：`pgcount()` 是页表映射观察实验，不是完整内存管理实验。

## Slide 9. Lab4：文件表与 fd table 观察

**Key message**  
Lab4 帮学生区分当前进程 fd table 和全局 file table 两个层次。

**Bullet content**

- `fcount()`：观察全局 file table 中引用计数大于 0 的 `struct file`。
- `fdcount()`：观察当前进程 `ofile[]` 中非空 fd 数量。
- `open` / `dup` / `close` 展示 fd 变化趋势。
- `dup()` 会增加 fd 引用，但不等同于新增全局 file entry。
- 进阶 `fdinfo(int fd, struct fdinfo*)`：用 `argint + argaddr + copyout` 把 `{type, readable, writable, ref}` 拷回用户态（只查自己的 `ofile[fd]`，不返回路径/inode/内容）。
- integrated 编号：`SYS_fcount=26`，`SYS_fdcount=28`，进阶 `SYS_fdinfo=30`（integrated `0009`）。

**Suggested visual**  
`proc.ofile[] -> struct file -> ftable` 关系图。

**Speaker notes**  
这页必须避免夸大：这是文件表和 fd 表观察，不是完整文件系统或 inode/磁盘布局实验。

## Slide 10. Lab5：capstone 综合复现

**Key message**  
Lab5 把分散实验组织成一次可提交、可验收、可报告的综合复现实验。

**Bullet content**

- 从 clean xv6-riscv baseline 出发。
- 顺序应用 integrated `0001-0009`。
- 完成 make、boot 和所有用户程序验证。
- 阅读每个 patch 对应的机制和边界。
- 输出实验报告和复现摘要。

**Suggested visual**  
capstone checklist：baseline / apply / make / boot / tests / report。

**Speaker notes**  
Lab5 是课程综合训练，不新增内核机制；它的价值是把工程复现和机制解释连起来。

## Slide 11. integrated-labs 0001-0009 与一键验证

**Key message**  
最终 integrated sequence 支持从 clean baseline 一键复现完整实验链。

**Bullet content**

- `0001-0002`：Lab1 hello/add2。
- `0003-0004`：Lab2 pstate/pcount/pchildtest。
- `0005`：Lab4 fcount。
- `0006`：Lab3 pgcount。
- `0007`：Lab4 v0.2 fdcount。
- `0008`：Lab3 进阶 memstat（`SYS 29`，argaddr+copyout+struct ABI）。
- `0009`：Lab4 进阶 fdinfo（`SYS 30`，argint+argaddr+copyout+struct ABI）。
- 推荐命令：`bash scripts/xv6/teammate-verify.sh --full`（现含 memstattest/fdinfotest）。

**Suggested visual**  
patch sequence 表 + one-shot verification 命令框。

**Speaker notes**  
integrated patch 解决独立 patch 之间的 syscall number 冲突，并提供评委、队友和队长可复现的统一路径。

## Slide 12. 三方复现证据：rain/root/z2996

**Key message**  
`e8e2fb9 / 0001-0007` 已完成队长本机和两位队友的 full verification PASS（historical stable checkpoint）；含 memstat/fdinfo 的 `0001-0009` 三方复现为 TBD。

**Bullet content**

- `rain`：team lead local full verification PASS。
- `root`：teammate A full verification PASS。
- `z2996`：teammate B full verification PASS。
- 覆盖 doctor/check-env/baseline/apply+make/boot/all user tests/overall，但只覆盖 `0001-0007`（不含 memstat/fdinfo）。
- stage11b `0001-0009` 队长本机 `local-verify --full` overall PASS；rain/root/z2996 的 `0001-0009` 三方 full verify 为 TBD，不得伪造。
- raw summary/log/screenshot 不入 Git；仓库只记录摘要和 SHA256。

**Suggested visual**  
三张证据卡片：user、commit、mode、result。

**Speaker notes**  
区分本机验证与队友复现；旧 `1ba9db6` 证据只作为 historical/superseded evidence。

## Slide 13. 演示视频与 evidence manifest

**Key message**  
最终证据以 metadata + SHA256 管理，原始大文件保存在仓库外。

**Bullet content**

- `0001-0007` 视频（historical stable checkpoint）：`20260606_final_integrated_0001_0007_demo.mp4`。
- 该视频 SHA256：`0FF2D3581552B3FD3A2630E827251CF46C36BC3BE8F8B9D9DDB691FC0668A93B`（只覆盖 `0001-0007`）。
- 覆盖 `0001-0009`（含 memstat/fdinfo）的新视频与新 SHA256：TBD，须重新录制，不得伪造。
- 中央索引：`submissions/evidence_manifest.md`。
- historical videos 只覆盖 earlier `0001-0005`，不覆盖 `e8e2fb9`。
- 隐私复核状态：`pending final manual review`。

**Suggested visual**  
evidence manifest 结构图：final evidence / historical evidence / non-committed policy。

**Speaker notes**  
解释为什么不把视频、截图、raw logs 放进 Git：既控制仓库卫生，也避免隐私和大文件风险。

## Slide 14. 同类项目对比与差异化

**Key message**  
uCore/rCore/YatSen/F-Tutorials 更偏完整课程或生态，本项目聚焦 OUC 本校 xv6-riscv 入门实验与提交友好复现。

**Bullet content**

- uCore/rCore：完整 OS 教学体系或 Rust OS 生态，本项目不重写其路线。
- YatSen OS / F-Tutorials：可作为课程材料和展示组织参考。
- 本项目差异：xv6-riscv clean-baseline patch、三方复现、QEMU 体验治理。
- 证据差异：metadata + SHA256 + non-committed raw evidence policy。
- URL/license 未最终核对的参考项保持“待核对”，不编造来源。

**Suggested visual**  
对比表：项目 / 侧重点 / 本项目差异。

**Speaker notes**  
这页的目标不是贬低同类项目，而是讲清本项目为何适合 proj54 和 OUC 课程语境。

## Slide 15. 创新点与教学价值

**Key message**  
创新点集中在课程化组织、可复现验证和诚实证据边界，而不是盲目扩大内核功能。

**Bullet content**

- 分阶段实验体系覆盖 syscall、proc、pagetable、file/fd table，进阶 memstat/fdinfo 补上 copyout + struct ABI。
- 可直接开课：每个 lab 有学生任务书（必做/选做/rubric），配教师指南、评分标准、troubleshooting。
- clean-baseline patch workflow 便于教学、审查和复现。
- full/quick teammate verification 降低队友复现门槛；QEMU timeout/cleanup 处理真实卡点。
- AI 使用透明记录，真实验证不由 AI 替代。

**Suggested visual**  
2x3 卡片：课程体系 / 任务书与教师材料 / patch workflow / teammate verify / evidence / AI transparency。

**Speaker notes**  
把创新性落到可维护、可教学、可验收的工程实践上，而不是夸大为完整内核系统。

## Slide 16. 边界、未来工作与总结

**Key message**  
当前成果已经形成课程实验和验证闭环；剩余事项以人工确认和后续课程扩展为主。

**Bullet content**

- `pgcount()`/`memstat()` 不是完整内存管理；`fcount()`/`fdcount()`/`fdinfo()` 不是完整文件系统。
- Lab5 是 capstone，不是新增内核机制。
- timeout/QEMU 输出捕获不是长期稳定性测试；`0001-0009` 队友复现与新视频为 TBD。
- 待确认：平台提交方式、最终隐私复核、队友真实姓名/系统版本、参考 URL/license。
- 总结：学生能看懂、老师能布置、助教能验收、评委能复现。

**Suggested visual**  
三栏总结：已完成 / 边界 / 后续。

**Speaker notes**  
用诚实边界收尾：材料冲奖的关键不是说满，而是让评委相信每个结论都能追溯到真实证据。
