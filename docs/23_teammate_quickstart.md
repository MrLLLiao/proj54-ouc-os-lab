# 队友正式复现 Quickstart

> 维护时间：2026-06-06（stage7a2，队友正式测试前一键流程）。
> 队友正式测试只看本文即可。所有真实 make / QEMU / boot / 命令验证都必须在 WSL2 Ubuntu 里执行。

## 1. 先更新仓库

在 WSL2 Ubuntu 里进入仓库目录：

```bash
git pull
```

不要在 PowerShell、Git Bash 或 MINGW64 里伪报 make/QEMU 成功。

## 2. 第一次正式复现

第一次复现只运行这一条：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

`--full` 会自动执行：

- doctor 环境诊断；
- `scripts/check-env.sh`；
- `scripts/xv6/check-xv6-baseline.sh`；
- `scripts/xv6/apply-integrated-labs.sh --make --yes`；
- `scripts/xv6/boot-xv6.sh`；
- hello / add2test / pstatetest / pcounttest / pchildtest / fcounttest 验证。

每一步都会记录 PASS/FAIL。最后会打印 `COPY THIS SUMMARY TO TEAM LEAD` 块，并写入：

```text
logs/teammate-verify-YYYYMMDD-HHMMSS.summary.txt
```

复制这个 summary 块或 summary 文件内容发给队长。`logs/` 是 ignored，不要提交。

## 3. 已经 make 成功后的二次重测

如果你已经看到过：

```text
[OK] make completed successfully
```

说明 apply + make 阶段已经完成，不要继续等那个命令。二次重测用：

```bash
bash scripts/xv6/teammate-verify.sh --quick
```

`--quick` 会跳过 clean apply + make，只重新跑 doctor、环境/baseline 检查、boot 和用户程序验证。

## 4. 队长录屏前检查

队长本人录屏前推荐先跑：

```bash
bash scripts/xv6/local-verify.sh --quick
```

这是 local pre-recording verification wrapper，内部复用 teammate workflow，避免队长本地检查和队友检查走两套逻辑。

## 5. 卡住或误按 Ctrl+Z

正常情况下 `boot-xv6.sh` 和每个命令验证应在 1-2 分钟内返回。超过 5 分钟先按：

```text
Ctrl+C
```

不要按 `Ctrl+Z`。`Ctrl+Z` 是 suspend（挂起），不是退出，可能把 QEMU 或 `make qemu` 留在后台。

如果卡住、误按 `Ctrl+Z`，或怀疑有 QEMU 残留，运行：

```bash
bash scripts/xv6/cleanup-qemu.sh
```

如果同一个 shell 里显示了 stopped job，再执行：

```bash
jobs -l
kill %1
```

如果 job 编号不是 `%1`，按 `jobs -l` 显示的实际编号改。

## 6. 反馈给队长

请反馈以下内容：

- `COPY THIS SUMMARY TO TEAM LEAD` 整块文本；
- 或 `logs/teammate-verify-YYYYMMDD-HHMMSS.summary.txt` 的文本内容；
- 如果失败，复制失败步骤附近的终端输出；
- 说明是否按过 `Ctrl+Z`，是否运行过 `cleanup-qemu.sh`；
- 说明运行模式是 `--full` 还是 `--quick`。

不要发送 token、密码、cookie、报名材料或包含隐私的截图。

## 7. 常见说明

- `riscv64-unknown-elf-gcc` 缺失只是 WARN；当前 xv6 构建使用 `riscv64-linux-gnu-gcc`。
- `LOAD segment with RWX permissions` 是当前 baseline/binutils 的 linker warning，不等于实验失败。
- `pcount(RUNNING)` 的数字不固定，只验证 `pcount(RUNNING) =` 和 `pcount(99) = -1`。
- `fcount(...)` 的数字不固定，只验证稳定输出和 `fcounttest done`。
- `pchildtest` 的状态受调度时序影响，可能看到 RUNNABLE、SLEEPING 等有效状态；只验证 `pstate(child) =`。

## 8. 禁止事项

- 不提交 `external/xv6-riscv/`。
- 不提交 `logs/*.log`。
- 不提交 `logs/teammate-verify-*.summary.txt`。
- 不发 token、密码、cookie 或隐私截图。
- 不把失败结果改写成成功。
- 不把自动 timeout 捕获说成人工交互录屏。
