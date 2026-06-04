# slides

本目录用于存放或说明初赛 PPT / 展示材料。当前不生成 PPT 文件，只维护结构计划。

当前状态：PPT 结构计划初版，实际 PPT 文件 TODO。

## 初赛 PPT 建议结构

1. 项目背景与赛题理解
   - proj54 是教学型赛题。
   - 项目目标是建设适合中国海洋大学低年级学生的 OS 竞赛入门实验体系。

2. 总体设计
   - 主线暂定 xv6-riscv。
   - lab0-lab5 的渐进式实验路线。
   - 当前 v0.1 聚焦 lab0/lab1 最小闭环。

3. 工程治理与第三方源码隔离
   - `external/xv6-riscv/` 不提交。
   - lab1 改动以 patch 形式提交。
   - `logs/*.log` 不提交，只摘录关键证据。

4. lab0 环境与 baseline
   - WSL2 Ubuntu 工具链检查。
   - baseline commit。
   - baseline make 成功。
   - boot evidence 捕获。

5. lab1 hello / add2 syscall
   - 修改文件列表。
   - 用户态到内核态调用链。
   - `hello syscall returned 2026` 输出证据。
   - `add2(int a, int b)` 通过 `argint()` 获取参数。
   - `add2(20, 6) returned 26` 输出证据。

6. clean patch 复现
   - 从 clean baseline reset。
   - 依次应用 `0001` 和 `0002`。
   - `make`。
   - hello 与 add2 输出捕获。

7. lab2 pstate 进程观察
   - `pstate(int pid)` syscall。
   - `struct proc` 和 `enum procstate`。
   - 遍历 `proc[]`。
   - 持有 `p->lock` 读取 `p->state`。
   - `pstate(self) = 4 (RUNNING)` 输出证据。

8. 测试证据
   - `docs/04_test_report.md`。
   - `docs/12_lab1_patch_review.md`。
   - `docs/15_lab2_process_observation_review.md`。
   - 不提交原始日志。

9. 风险与后续计划
   - timeout 自动捕获不是长期稳定性测试。
   - 第二名队员复现 TODO。
   - 人工交互录屏 TODO。
   - lab2 扩展或 lab4 二选一深化。

## 注意事项

- TODO: 不加入报名材料或个人隐私。
- TODO: 不使用未经记录来源和许可证的外部图片。
- TODO: 不把未完成工作写成已完成。
- TODO: 生成 PPT 前先确认比赛平台格式和大小要求。
