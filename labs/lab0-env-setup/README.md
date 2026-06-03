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

## 本机环境验证记录（真实检测，未伪造）

> **失败不是问题，伪造才是问题。** 缺工具、装不上、构建失败都可以如实记录；唯独不能把没跑通的写成跑通了。任何“OK/PASS/已跑通”都必须有真实命令输出支撑。

下表每行对应一次真实检测。**已填行为 2026-06-03 实际检测结果**（Windows 宿主 + WSL2 Ubuntu），由 AI 辅助检测、待队长复核；空行为后续手动验证留用。

| 日期 | 操作系统 | Shell | Git | Bash | Make | QEMU? | RISC-V 工具链? | 结论 | 责任人 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 2026-06-03 | Windows 11 Pro 10.0.26200 | Git Bash (MINGW64/MSYS) | 2.53.0 | 5.2.37 | 缺失 | 否 | 否 | 宿主仅有 git/bash，不适合构建 xv6 | Claude Code 检测，待队长复核 |
| 2026-06-03 | WSL2 Ubuntu 24.04.4 LTS（内核 6.6.87.2） | bash | 存在 | 存在 | 4.3 | 否 | 否 | 基础链(git/make/gcc)就绪，缺 qemu+riscv，xv6 暂不能构建 | Claude Code 检测，待队长复核 |
| TODO | TODO | TODO | TODO | TODO | TODO | TODO | TODO | TODO | TODO |

> 上表 GCC：WSL2 Ubuntu 内 `gcc` 13.3.0 存在。结论部分不声称任何 xv6 构建或启动成功。

## 下一步安装计划（需队长授权后在 WSL2 Ubuntu 执行）

构建 xv6 的目标环境是 WSL2 Ubuntu，不是 Windows Git Bash。按以下顺序推进：

1. **WSL2 Ubuntu 检查**（已确认存在 Ubuntu-24.04，WSL2）。在 Windows PowerShell 中查看分发与版本：

   ```bash
   wsl -l -v
   ```

2. **安装 QEMU 与 RISC-V 工具链**（一条命令覆盖；需联网，需授权）：

   ```bash
   sudo apt update
   sudo apt install -y git build-essential gdb-multiarch qemu-system-misc \
                       gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
   ```

   其中 `qemu-system-misc` 提供 `qemu-system-riscv64`；`gcc-riscv64-linux-gnu` 提供 `riscv64-linux-gnu-gcc`。

3. **确认工具链**：在 WSL2 Ubuntu 仓库目录重跑 `bash scripts/check-env.sh`，确认 `qemu-system-riscv64` 与某个 `riscv64-*-gcc` 为 `[OK]`。
4. **获取 xv6-riscv baseline**：按 [../../docs/11_xv6_baseline_plan.md](../../docs/11_xv6_baseline_plan.md) 与 [../../external/README.md](../../external/README.md) 引入（submodule 优先），并登记许可证到 [../../docs/08_reference_and_license.md](../../docs/08_reference_and_license.md)。
5. **真实构建并记录**：`make` 与 `make qemu`，把命令、输出摘要、失败原因如实写入下方“构建与启动”表和 [../../docs/04_test_report.md](../../docs/04_test_report.md)。

### 哪些命令现在就能跑 / 哪些要装完才能跑

| 现在就能跑（无需安装） | 安装工具链后才能跑 |
| --- | --- |
| `git --version`、`bash --version` | `qemu-system-riscv64 --version` |
| `bash scripts/check-env.sh` | `riscv64-linux-gnu-gcc --version` 或 `riscv64-unknown-elf-gcc --version` |
| `bash scripts/run-lab.sh lab0` / `lab1` | xv6 目录下 `make` |
| `bash scripts/collect-report.sh` | xv6 目录下 `make qemu`（启动到 xv6 shell） |
| WSL2 内 `make --version`、`gcc --version` | — |

## 真实验证记录模板（待真实填写，禁止伪造）

下表用于在真实执行 lab0 后填写。**当前为空模板，所有结果字段保持 TODO，禁止在未真实执行前填入任何输出或 PASS。**

### 基本信息

| 项目 | 内容 |
| --- | --- |
| 验证人 | TODO |
| 验证日期 | TODO |
| 机器与操作系统 | TODO（例如 Windows 11 + WSL2 Ubuntu 24.04） |
| 仓库路径 | TODO |

### xv6-riscv 构建与启动（baseline 引入后填写）

| 步骤 | 命令 | 真实结果 | 状态 |
| --- | --- | --- | --- |
| 获取 baseline | TODO（记录 URL/commit） | TODO | TODO |
| 构建 | TODO | TODO | TODO |
| 启动 QEMU | TODO | TODO | TODO |
| 退出 QEMU | TODO | TODO | TODO |

### 问题与解决记录

| 现象 | 初步原因 | 解决方式 | 关联 issue/commit |
| --- | --- | --- | --- |
| TODO | TODO | TODO | TODO |

> 填写纪律：真实命令的输出建议以文本形式粘贴或附日志文件路径；不要提交大型二进制文件或截图原件；只有真实跑通才能把状态写为 OK/PASS（参见 [../../docs/10_red_team_review.md](../../docs/10_red_team_review.md)）。

## 当前状态

文档初版，环境预检查脚本可运行。2026-06-03 真实检测：WSL2 Ubuntu 24.04 的 git/make/gcc 已就绪，仅缺 QEMU 与 RISC-V 交叉工具链；Windows Git Bash 仅有 git/bash。xv6-riscv baseline 未引入，尚未构建或启动 xv6，完整跑通步骤待队长授权安装工具链后执行（见上方“下一步安装计划”与 [../../docs/11_xv6_baseline_plan.md](../../docs/11_xv6_baseline_plan.md)）。
