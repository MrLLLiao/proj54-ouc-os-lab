# lab0: 环境搭建与 baseline 验证

## 实验目标

lab0 面向第一次接触 OS 实验的低年级同学，目标是完成基础环境检查、获取 xv6-riscv baseline metadata，并记录可复现的 baseline build 与 boot evidence。

本实验不要求修改 xv6 内核代码。

## 推荐环境

当前目标环境：

- Windows 11 + WSL2 Ubuntu 24.04
- Git
- bash
- make
- QEMU RISC-V
- RISC-V cross compiler

## 当前已验证工具状态

`bash scripts/check-env.sh` 已在 WSL2 Ubuntu 24.04 中真实运行。

观察结果：

| 工具 | 状态 | 说明 |
| --- | --- | --- |
| `git` | OK | WSL2 中可用 |
| `bash` | OK | WSL2 中可用 |
| `make` | OK | WSL2 中可用 |
| `qemu-system-riscv64` | OK | WSL2 中可用 |
| `riscv64-linux-gnu-gcc` | OK | WSL2 中可用 |
| `riscv64-unknown-elf-gcc` | WARN | 当前缺失，但已有 `riscv64-linux-gnu-gcc` |

## 手动检查命令

```bash
git --version
bash --version
make --version
qemu-system-riscv64 --version
riscv64-linux-gnu-gcc --version
riscv64-unknown-elf-gcc --version
```

## 获取 xv6 baseline

预览获取命令：

```bash
bash scripts/xv6/fetch-xv6.sh
```

经队长授权后获取 baseline：

```bash
bash scripts/xv6/fetch-xv6.sh --run
```

查看本地 baseline metadata：

```bash
bash scripts/xv6/fetch-xv6.sh --status
```

本地源码目录：

```text
external/xv6-riscv/
```

该目录被 Git 忽略，不应提交第三方源码。

可提交 metadata 文件：

```text
external/xv6-baseline-record.md
```

## baseline 结构检查

```bash
bash scripts/xv6/check-xv6-baseline.sh
```

该命令检查：

- `external/xv6-riscv/`
- `external/xv6-riscv/Makefile`
- `external/xv6-riscv/LICENSE`
- `qemu-system-riscv64`
- `riscv64-unknown-elf-gcc`
- `riscv64-linux-gnu-gcc`

默认不运行 `make`。

## baseline build 真实记录

队长已真实运行：

```bash
bash scripts/xv6/check-xv6-baseline.sh --make
```

结果：

| 项目 | 结果 |
| --- | --- |
| 日期时间 | 2026-06-03 23:50:03 +08:00 |
| 结果 | `make` 成功 |
| 使用 compiler | `riscv64-linux-gnu-gcc` |
| 使用 linker | `riscv64-linux-gnu-ld` |
| QEMU 工具 | `qemu-system-riscv64` 已检测到 |
| warning | linker `LOAD segment with RWX permissions` |
| 日志文件 | `logs/xv6-make-20260603-235003.log` |
| 测试报告 | `docs/04_test_report.md` |

该记录只证明 baseline build 成功，不证明 boot 成功。

## baseline boot evidence 真实记录

已真实运行：

```bash
bash scripts/xv6/boot-xv6.sh
```

结果：

| 项目 | 结果 |
| --- | --- |
| 日期时间 | 2026-06-04 00:17:36 +08:00 |
| 结果 | baseline boot evidence found |
| 检测到 | `xv6 kernel is booting` |
| 检测到 | `init: starting sh` |
| 日志文件 | `logs/xv6-boot-20260604-001736.log` |

该记录只证明脚本捕获到 boot 关键文本；尚未做长期稳定性测试，也尚未做人工 shell 交互测试。

## 当前状态

- xv6-riscv baseline fetch: 已完成，本地目录为 `external/xv6-riscv/`。
- xv6-riscv `make`: 已成功。
- xv6-riscv boot evidence: 已捕获关键文本。
- 原始日志: 被 Git 忽略，不提交 `logs/*.log`。
- lab1 syscall: 已在后续 lab1 生成 patch 并验证 hello 输出，详见 `labs/lab1-system-call/README.md`。
- TODO: 完成长期 QEMU 稳定性测试和人工交互测试。

## 常见问题

### Windows 路径包含空格

当前仓库路径包含空格，现有命令已在该路径下运行成功。后续大量构建、调试和脚本自动化时，仍建议优先考虑 WSL-native 路径，例如 `~/workspace/proj54-ouc-os-lab`。

### `riscv64-unknown-elf-gcc` 缺失

当前 WSL2 环境已有 `riscv64-linux-gnu-gcc`，baseline 和 lab1 构建均已成功。若后续修改 xv6 Makefile 或工具链策略，需要重新检查。

### QEMU 命令不存在

如果 `qemu-system-riscv64` 缺失，`scripts/check-env.sh` 会输出 WARN。安装方式需根据 WSL2 Ubuntu 版本确认，未确认前不要写成已解决。

### shell 脚本换行问题

如果脚本出现 `$'\r': command not found`，优先检查行尾是否为 LF。本仓库使用 `.gitattributes` 和 `.editorconfig` 约束文本文件换行。

### boot evidence 与完整测试不同

`scripts/xv6/boot-xv6.sh` 使用 timeout 自动退出 QEMU。它用于捕获关键文本，不代表长期稳定性或完整交互测试。
