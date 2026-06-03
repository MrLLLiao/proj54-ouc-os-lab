# xv6-riscv baseline 引入方案

## 文档目的

本文件规划 xv6-riscv baseline 的引入方式、许可证要求、仓库风险与验收标准，并记录**当前本机的真实环境检测结果**。本轮（stage1a）只做方案与准备，**不引入 xv6 源码、不安装工具链**，实际引入需队长授权后执行。

- 关联文档：[08_reference_and_license.md](08_reference_and_license.md)、[02_lab_design.md](02_lab_design.md)、[10_red_team_review.md](10_red_team_review.md)、[../external/README.md](../external/README.md)
- 关联实验：[../labs/lab0-env-setup/README.md](../labs/lab0-env-setup/README.md)

## 1. 为什么选择 xv6-riscv 作为主线 baseline

- **教学定位匹配**：xv6-riscv 是一个完整但精简的类 Unix 教学内核，覆盖系统调用、trap、进程与调度、虚拟内存/页表、文件系统，恰好对应 lab1-lab4 的教学目标。
- **门槛适中**：代码量小、结构清晰，适合中国海洋大学低年级学生阅读与改造，符合 proj54 教学型赛题“适合本校实验”的要求。
- **生态成熟**：有公开的配套书籍与大量课程实践（如 MIT 6.S081），便于设计 step-by-step 实验与参考实现。
- **许可证友好**：上游通常为 MIT 许可证（以实际仓库为准），允许教学使用与再分发，合规成本低。
- **工具链标准**：在 Linux/WSL 上通过 QEMU + RISC-V 交叉工具链即可构建运行，可复现性强。

候选上游（待队长最终确认并登记到 `docs/08`）：

| 名称 | 仓库 URL | 许可证（待核验） | 说明 |
| --- | --- | --- | --- |
| mit-pdos/xv6-riscv | `https://github.com/mit-pdos/xv6-riscv` | MIT（待核验） | 主流 xv6-riscv 上游，建议优先 |

> 注意：上表 URL/许可证在真实引入前必须由队员打开仓库核对，并把准确 commit/tag 与 LICENSE 全文位置登记到 `docs/08`。

## 2. 候选引入方式对比

| 方式 | 可审计性 | 可复现性 | 许可证清晰度 | 仓库体积 | 主要风险 |
| --- | --- | --- | --- | --- | --- |
| A. 直接复制源码进主仓库 | 中 | 高 | **低**（易与自有代码混淆、易丢版权头） | 增大 | 版权归属混淆、难以更新、看起来像把他人代码当自有 |
| B. git submodule（钉死 commit） | **高** | **高** | **高**（来源与版本显式可查） | 不增大（仅 gitlink） | 评委需 `--recursive` clone；GitLab 子模块需可访问 |
| C. external/ 手动 clone（不提交） | 中 | 中 | 高 | 不增大 | 评委环境无源码，需手动步骤 |
| D. 脚本下载到 external/（不提交，钉死 commit） | 高 | **高** | 高 | 不增大 | 构建期需要网络 |

## 3. 推荐方案

**主推：方式 B（git submodule，钉死到具体 upstream commit），放在 `external/xv6-riscv`。**

- 理由：来源、版本、许可证全部显式可查（最符合“可审计、可复现、低风险”）；第三方源码与自有代码物理隔离，不会污染自有版权；不增大仓库体积。
- 备选：若 eduxiji GitLab 或评委环境对 submodule 支持不佳，则降级为**方式 D（脚本下载到不提交的 `external/xv6-riscv`，钉死 commit）**，并在 `external/README.md` 提供命令。

**本轮明确不执行 submodule 引入**，原因：

1. `git submodule add` 会 clone 第三方源码，属于本轮边界中需谨慎、需先确认许可证记录的动作。
2. 选择哪个上游 commit/tag 是队伍决策，应由队长确认后执行。
3. 本轮先把方案、`external/` 脚手架和许可证清单准备好，把执行权交给队长（见第 6 节命令）。

## 4. 许可证与引用要求

引入前必须完成 [08_reference_and_license.md](08_reference_and_license.md) 中的“后续引入 xv6-riscv 的许可证检查清单”，要点：

- 记录准确的仓库 URL、commit/tag。
- 确认许可证类型（预计 MIT，待核验），确认允许教学使用与再分发。
- 原样保留上游 LICENSE 与源文件版权头，不改写版权人。
- 在 baseline 目录补 NOTICE/来源说明：“本目录基于 `仓库URL@commit`，原许可证为 `LICENSE 名称`”。
- 明确区分“原始 baseline 文件”与“本项目改造/新增文件”，不对第三方代码主张本队版权。
- 引用配套书籍/教程时写改造说明，不复制大段正文。

## 5. 仓库大小与比赛提交风险

- 自有仓库应保持精简：第三方源码不直接提交（用 submodule 或不提交的 external/）。
- 继续禁止提交大型二进制（视频、镜像、PDF 等已在 `.gitignore` 屏蔽）。
- 最终提交以官方 GitLab `origin` 为准；若使用 submodule，需确认评委可在其网络环境拉取，否则改用方式 D 并附下载脚本与校验方式。
- `external/` 下的 baseline 工作树默认不纳入版本控制（见 `.gitignore` 与 `external/README.md`），避免误提交第三方源码。

## 6. Windows/WSL 环境注意事项

- **构建环境用 WSL2 Ubuntu，不要用 Windows Git Bash/MSYS 构建 xv6**（MSYS 缺少 make 与交叉工具链，且路径/换行差异大）。
- 建议把仓库或 baseline 放在 WSL 原生路径（如 `~/workspace/`）而非 `/mnt/d/Edge Download/...`：含空格的 Windows 路径在 WSL 下易出错，且 `/mnt` 跨文件系统编译较慢。
- 保持 `.sh` 为 LF 换行（`.gitattributes` 已强制），避免 `$'\r'` 报错。
- 队长在 WSL2 Ubuntu 中安装工具链（**需授权后执行**）：

  ```bash
  sudo apt update
  sudo apt install -y git build-essential gdb-multiarch qemu-system-misc \
                      gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
  ```

  说明：`qemu-system-misc` 提供 `qemu-system-riscv64`；`gcc-riscv64-linux-gnu` 提供 `riscv64-linux-gnu-gcc`，xv6-riscv 的 Makefile 可自动识别该前缀（也兼容 `riscv64-unknown-elf-`）。

- 引入 baseline（方式 B，**需授权后执行**）：

  ```bash
  # 在 WSL2 Ubuntu 的仓库根目录
  git submodule add https://github.com/mit-pdos/xv6-riscv external/xv6-riscv
  cd external/xv6-riscv && git checkout <选定的commit> && cd -
  # 之后把 URL、commit、LICENSE 登记到 docs/08
  ```

## 7. baseline 验收标准

只有以下各项都有**真实证据**时，才视为 baseline 引入成功（任何一项失败都如实记录失败原因，不得伪造）：

| 验收项 | 通过判据 | 证据形式 |
| --- | --- | --- |
| 能获取源码 | submodule/clone 成功，commit 可查 | commit hash、`git submodule status` 输出 |
| 能确认许可证 | LICENSE 类型与位置已核对并登记 | `docs/08` 记录 + 仓库内 LICENSE 路径 |
| 能安装/检查工具链 | `qemu-system-riscv64` 与某 `riscv64-*-gcc` 均 FOUND | `bash scripts/check-env.sh`（WSL 内）输出 |
| 能 make / make qemu | 构建成功并启动到 xv6 shell，或明确记录失败原因 | 命令 + 输出摘要（文本）+ 失败时的报错 |
| 能留下可复现记录 | 命令、输出摘要、环境信息齐全 | `labs/lab0-env-setup/README.md` 验证表 + `docs/04` |

## 8. 当前本机真实状态（2026-06-03 检测，未伪造）

检测方式：在 Windows Git Bash 运行 `scripts/check-env.sh` 与只读探测；通过 `wsl.exe` 在 WSL2 Ubuntu 内只读检测工具是否存在。**未安装任何软件，未构建 xv6。**

### Windows 宿主 / Git Bash（MSYS）

| 项目 | 实测结果 |
| --- | --- |
| 操作系统 | Windows 11 Pro 10.0.26200 |
| Shell | Git Bash MINGW64（`MINGW64_NT-10.0-26200 ... Msys`） |
| git | FOUND，2.53.0.windows.1 |
| bash | FOUND，5.2.37 |
| make | **MISSING**（Git Bash 默认无 make） |
| qemu-system-riscv64 | **MISSING** |
| riscv64-unknown-elf-gcc / riscv64-linux-gnu-gcc | **MISSING** |

### WSL2 Ubuntu（真正的构建目标环境）

| 项目 | 实测结果 |
| --- | --- |
| 安装状态 | 已安装：默认分发 Ubuntu-24.04，WSL 版本 2，检测前为 Stopped |
| 发行版 | Ubuntu 24.04.4 LTS |
| 内核 | Linux 6.6.87.2-microsoft-standard-WSL2 |
| git | FOUND（`/usr/bin/git`） |
| make | FOUND（`/usr/bin/make`，GNU Make 4.3） |
| gcc | FOUND（`/usr/bin/gcc`，13.3.0） |
| qemu-system-riscv64 | **MISSING** |
| riscv64-unknown-elf-gcc | **MISSING** |
| riscv64-linux-gnu-gcc | **MISSING** |
| gdb-multiarch | **MISSING** |

### 结论

- 好消息：WSL2 Ubuntu 24.04 的**基础构建链（git + make + gcc）已就绪**。
- 待办：仅缺 `qemu-system-riscv64` 与 RISC-V 交叉工具链，可通过第 6 节的 `apt` 命令安装（需队长授权）。
- 现状判定：**尚不能构建/运行 xv6**；当前不声称任何 xv6 构建或启动成功。下一步是队长授权安装工具链后，在 WSL 内重跑 `scripts/check-env.sh` 并按第 7 节验收。
