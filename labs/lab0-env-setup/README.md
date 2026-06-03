# lab0：环境搭建与工具链检查

## 实验目标

lab0 的目标是帮助低年级同学建立 OS 实验的基础开发环境，并学会用脚本和命令检查当前机器是否具备后续运行 xv6-riscv 的基本条件。

本实验当前只覆盖环境预检查。本仓库尚未引入 xv6-riscv baseline，因此本文档不声称已经在所有机器上跑通 xv6。

## 推荐环境

推荐优先使用：

- Windows 11 + WSL2 Ubuntu
- Git
- bash
- make
- GCC/RISC-V toolchain：TODO，待确认推荐安装方式
- QEMU：TODO，待确认推荐安装方式

说明：

- Windows 原生命令行也可以查看文档，但后续 xv6-riscv 构建更建议在 WSL2 Ubuntu 中完成。
- 如果使用 macOS 或 Linux 原生环境，后续需要单独补充安装步骤和差异说明。
- 由于不同机器和软件源差异较大，安装方式需要后续真实验证后再写入正式教程。

## 环境检查命令

可以手动执行以下命令，查看工具是否存在：

```bash
git --version
bash --version
make --version
qemu-system-riscv64 --version
riscv64-unknown-elf-gcc --version
```

如果本机使用的 RISC-V 工具链名称不是 `riscv64-unknown-elf-gcc`，请记录实际命令。后续可能需要兼容 `riscv64-linux-gnu-gcc` 等其他工具链，当前为 TODO，待确认。

## 使用 check-env 脚本

仓库提供了最小环境预检查脚本：

```bash
bash scripts/check-env.sh
```

脚本会检查以下命令是否可在 `PATH` 中找到：

- `git`
- `bash`
- `make`
- `qemu-system-riscv64`
- `riscv64-unknown-elf-gcc`

输出含义：

- `[OK]`：命令存在。
- `[WARN]`：命令不存在，后续运行 xv6-riscv 可能需要安装。

注意：当前脚本不会下载、构建或运行 xv6-riscv。由于 baseline 尚未引入，部分 `[WARN]` 在当前阶段可以接受，但需要在后续环境配置阶段解决。

## 常见问题

### Windows 路径包含空格

当前仓库路径中包含空格，例如 `D:\Edge Download\...`。在 Windows PowerShell 中运行命令时需要注意引号；在 WSL 中访问 Windows 路径时可能对应 `/mnt/d/Edge Download/...`，也需要正确转义或加引号。

建议后续真实运行 xv6-riscv 时，将仓库放在不含空格的 WSL Linux 路径下，例如 `~/workspace/proj54-ouc-os-lab`。该建议待后续验证。

### WSL 未安装

如果 `wsl` 不可用，需要先安装 WSL2 和 Ubuntu。具体安装命令受 Windows 版本影响，当前不在本文档中直接固化，TODO：后续补充经验证的安装步骤。

### Git HTTPS 登录失败

如果克隆或推送 GitLab 仓库失败，可能与账号登录、HTTPS 凭据或网络有关。不要把用户名、密码、token 写入仓库或文档。可记录错误现象，但不要记录敏感凭据。

### QEMU 命令不存在

如果 `qemu-system-riscv64 --version` 提示命令不存在，说明 QEMU 未安装或未加入 `PATH`。当前阶段记录为 `[WARN]` 即可；后续 baseline 跑通前必须解决。

### bash 脚本在 Windows 下换行问题

如果脚本报错类似 `$'\r': command not found`，通常是 CRLF 换行导致。建议保持 `.sh` 文件为 LF 换行。提交前运行：

```bash
git diff --check
```

## 与后续实验的关系

lab0 是 lab1-lab5 的基础。只有在环境可用、baseline 来源和许可证确认后，才能继续补充：

- TODO：xv6-riscv baseline 获取方式。
- TODO：xv6-riscv 构建命令。
- TODO：QEMU 启动命令。
- TODO：真实运行输出和问题排查记录。

## 当前状态

文档初版，环境预检查脚本可运行；xv6-riscv baseline 未引入，完整跑通步骤 TODO。
