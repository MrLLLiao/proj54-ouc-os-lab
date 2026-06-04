# Demo 脚本草案

## Demo 目标

展示当前 lab0/lab1 的最小工程闭环：

- 项目定位是教学型 OS 实验体系。
- xv6-riscv baseline 被隔离在 `external/`，不提交第三方源码。
- lab1 通过 patch 复现最小 `hello()` syscall。
- lab1 进阶 patch 通过 `add2(int a, int b)` 演示 `argint()` 参数传递。
- lab2 通过 `pstate(int pid)` 演示进程表查找和进程状态读取。
- 真实证据包括环境检查、boot evidence、hello/add2 输出捕获和 pstatetest 输出捕获。

当前状态：

- 自动捕获证据已有。
- 人工录屏：TODO。
- 人工交互演示：TODO。

## 录制建议

- 不录个人隐私、聊天窗口、浏览器账号、token、密码或报名材料。
- 不展示身份证明、手机号、邮箱收件箱或系统通知。
- 只录 VS Code、终端、GitLab/GitHub 项目中必要部分。
- 不录制或提交大型原始视频文件，先确认比赛平台要求。
- 若使用外部图表或图片，需记录来源和许可证。

## Demo 流程

建议总时长控制在 2-3 分钟。

1. 打开 `README.md`，说明项目定位和当前状态。
2. 展示 `external/xv6-baseline-record.md`，说明 baseline commit 与第三方源码隔离。
3. 展示 `patches/lab1-system-call/0001-add-hello-syscall.patch`，说明 lab1 提交的是 patch。
4. 运行环境检查：

   ```bash
   bash scripts/check-env.sh
   ```

5. 预览 patch 应用脚本：

   ```bash
   bash scripts/xv6/apply-lab1-patch.sh
   ```

6. 捕获 boot evidence：

   ```bash
   bash scripts/xv6/boot-xv6.sh
   ```

7. 捕获 hello 输出：

   ```bash
   bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
   ```

8. 捕获 add2 输出：

   ```bash
   bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
   ```

9. 捕获 pstatetest 输出：

   ```bash
   bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
   ```

10. 展示 `docs/12_lab1_patch_review.md`、`docs/14_lab1_argint_extension_review.md` 和 `docs/15_lab2_process_observation_review.md`，说明 clean baseline apply 复现已审查。
11. 展示 `docs/04_test_report.md`，说明只记录真实执行证据。

## 可选人工交互流程

该流程尚未录制，完成后再更新状态。

```bash
cd external/xv6-riscv
make qemu
```

进入 xv6 shell 后输入：

```text
hello
add2test
pstatetest
```

预期输出：

```text
hello syscall returned 2026
add2(20, 6) returned 26
pstate(self) = 4 (RUNNING)
```

退出 QEMU：

```text
Ctrl-a
x
```

## 讲解词草案

> 本项目对应 proj54 教学型赛题，目标不是单纯堆内核功能，而是为低年级同学提供可以逐步复现的 OS 竞赛入门实验体系。当前 v0.1 打通了 lab0、lab1 和 lab2 的最小闭环：lab0 完成环境检查、xv6 baseline build 和 boot evidence；lab1 通过 hello 和 add2 讲解 syscall 与 argint 参数传递；lab2 通过 pstate 观察当前进程状态，讲解进程表和进程锁。第三方 xv6 源码放在 ignored 的 external 目录，原始日志也不提交，仓库只提交自有文档、脚本、patch 和证据摘要。未完成的队友复现、人工录屏和长期稳定性测试均明确标记为 TODO。

## 边界说明

- 自动脚本捕获到的 boot/hello evidence 不等同于人工交互视频。
- 当前不声称完成长期稳定性测试。
- 当前不声称第二名队员已独立复现。
