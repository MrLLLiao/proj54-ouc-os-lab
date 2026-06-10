# Troubleshooting：卡住了先看这里

> 维护时间：2026-06-10（stage12）。覆盖 WSL、QEMU、make、PATH、timeout、`/mnt` 性能等高频问题。每条按"症状 → 可能原因 → 解决 → 报告时带什么信息"组织。

通用第一步：`bash scripts/xv6/doctor.sh`。它只读不写，10 秒告诉你 git/bash/make/qemu/交叉编译器在不在、有没有 QEMU 残留进程、路径在不在 `/mnt` 下。

## 1. `make: command not found` / `qemu-system-riscv64: command not found`

- **症状**：任何脚本一开始就报命令不存在；Windows Git Bash 下尤其常见。
- **可能原因**：在 Windows Git Bash/PowerShell 里跑了只能在 Linux 跑的命令；或 WSL 里没装工具链。
- **解决**：进 WSL2 Ubuntu 再跑。缺包时：`sudo apt install make qemu-system-misc gcc-riscv64-linux-gnu git`。`riscv64-unknown-elf-gcc` 缺失只是 WARN，可忽略。
- **报告带**：`doctor.sh` 完整输出 + `uname -a`。

## 2. 卡在 `[STEP] attempt 1/2` 很久 / 第一次 boot 特别慢

- **症状**：`boot-xv6.sh` 或 `run-xv6-command.sh` 第一次跑停在 attempt 1 不动一两分钟。
- **可能原因**：仓库在 `/mnt/d/...`（Windows 盘挂载，drvfs 慢 + mtime 偏差触发重编 `fs.img`）；不是死机。
- **解决**：等满一个 soft timeout（boot 45s / 命令 60s），脚本自带重试和硬超时，多数 attempt 1 或 2 就过。长期方案：把仓库 clone 进 WSL 的 ext4 路径（如 `~/work/`）。
- **报告带**：对应 `logs/xv6-*-attemptN.log` 的最后 20 行（日志不入 Git，贴文本即可）。

## 3. 按了 `Ctrl+Z`，终端"回来了"但之后一直不对劲

- **症状**：再跑脚本各种端口/进程冲突，或 make 报奇怪的锁文件。
- **可能原因**：`Ctrl+Z` 是挂起不是退出，QEMU/make 还活着。
- **解决**：`bash scripts/xv6/cleanup-qemu.sh`——它是救援工具，会列出并清掉本项目的 `qemu-system-riscv64` 和 `make qemu` 残留进程。以后退出 QEMU 用 `Ctrl-a` 然后 `x`，中断用 `Ctrl+C`。
- **报告带**：`cleanup-qemu.sh` 输出（它清了什么进程）。

## 4. `git apply` 报 `patch does not apply`

- **症状**：手动 apply 某个 patch 失败，一堆 hunk FAILED。
- **可能原因**：(a) 基底不对——没有先 `git reset --hard 74f84181... && git clean -fdx`；(b) 顺序不对——integrated patch 必须 `0001` 到 `0009` 按序；(c) 想把两个 independent patch 叠加——它们的 `SYS_*` 都是 22，本来就互斥，这不是 bug。
- **解决**：用 `bash scripts/xv6/apply-integrated-labs.sh --make --yes`，它替你做 reset + 按序 apply + make。想手动就严格按 patch README 的顺序。
- **报告带**：你执行的完整命令序列 + 第一条报错 hunk。

## 5. apply 时出现 `warning: user/usys.pl has type 100644, expected 100755`

- **症状**：每个 patch 都打这条 warning。
- **可能原因**：`/mnt` 下 NTFS 不保存可执行位（`core.filemode=false`）。
- **解决**：不用管，apply 和 make 都不受影响。这是已知良性告警。
- **报告带**：无需报告。

## 6. `make` 报 `LOAD segment with RWX permissions`

- **症状**：链接末尾出现这条 warning。
- **可能原因**：上游 xv6 + 新 binutils 的已知组合行为，与本实验的任何 patch 无关。
- **解决**：忽略。`make` 退出码为 0 即成功。
- **报告带**：无需报告。

## 7. xv6 shell 里敲程序名说找不到

- **症状**：`memstattest: not found` 之类。
- **可能原因**：(a) `Makefile` 的 `UPROGS` 没加 `_xxx`；(b) 改了代码没重新 `make`；(c) 自己起的程序名太长——xv6 `DIRSIZ` 限制目录项名字长度，`_pstatechildtest` 当年就把 `mkfs` 搞挂了，所以现在叫 `pchildtest`。
- **解决**：检查 `UPROGS`、重新 make、命令名控制在 8 字符左右。
- **报告带**：`grep -n yourprog external/xv6-riscv/Makefile` 的输出。

## 8. `run-xv6-command.sh` 报 `COMMAND_EVIDENCE_NOT_FOUND`

- **症状**：程序其实能跑，但脚本说没匹配到。
- **可能原因**：期望文本和程序实际输出不一致（多个空格都算）；或程序在 QEMU 里崩了。
- **解决**：先 `make qemu` 手动进 shell 跑一次看真实输出，再把期望文本改成稳定前缀。记住设计纪律：只匹配稳定前缀，不匹配会变的数字。
- **报告带**：手动运行的真实输出 + 你给脚本的期望文本。

## 9. timeout 到底说明什么

- `boot-xv6.sh` 默认 45s 软超时/75s 硬超时、2 次尝试；`run-xv6-command.sh` 60s/75s、2 次。环境变量 `XV6_BOOT_TIMEOUT_SECONDS`、`XV6_COMMAND_TIMEOUT_SECONDS` 等可调。
- 命中预期文本后脚本会**立即**杀 QEMU（fast exit），所以"3 秒就结束"是正常的。
- 超时退出码 124 ≠ 永久失败，先看第 2 条的 `/mnt` 原因。
- 反过来也成立：捕获成功只证明那一次匹配到了文本，**不是**长期稳定性测试，报告里别写过头。

## 10. 还是不行

把下面四样东西一起发给助教/队长，基本都能远程定位：

1. `bash scripts/xv6/doctor.sh` 完整输出。
2. 你执行的命令原文（从 clean reset 开始的完整序列）。
3. 失败那一步的屏幕输出或对应 `logs/*.log` 末尾 30 行。
4. 有没有按过 `Ctrl+Z`、跑过 `cleanup-qemu.sh`。
