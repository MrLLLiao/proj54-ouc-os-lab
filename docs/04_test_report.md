# 测试报告

本文档记录 `proj54-ouc-os-lab` 已真实执行的测试与验证结果。

记录原则：

- 只记录真实执行过的命令和结果。
- 原始 `logs/*.log` 默认不提交，只在文档中记录路径和关键信息。
- 不将 `make` 成功写成 QEMU boot 成功。
- 不将 boot evidence 写成长期稳定性或完整人工交互测试。
- 不伪造 lab1 syscall 输出。

## 测试记录

### xv6-riscv baseline build test

| 字段 | 内容 |
| --- | --- |
| 测试名称 | xv6-riscv baseline build test |
| 日期时间 | 2026-06-03 23:50:03 +08:00 |
| 命令 | `bash scripts/xv6/check-xv6-baseline.sh --make` |
| baseline 路径 | `external/xv6-riscv/` |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| 结果 | `make` 成功 |
| 日志文件 | `logs/xv6-make-20260603-235003.log` |
| 原始日志是否提交 | 否，`logs/*.log` 被 `.gitignore` 忽略 |

环境与工具链摘要：

| 项目 | 状态 |
| --- | --- |
| baseline directory | OK |
| `Makefile` | OK |
| `LICENSE` | OK |
| `qemu-system-riscv64` | OK |
| `riscv64-linux-gnu-gcc` | OK |
| `riscv64-unknown-elf-gcc` | WARN: 当前环境缺失 |

构建证据摘要：

- 构建过程中使用了 `riscv64-linux-gnu-gcc` 和 `riscv64-linux-gnu-ld`。
- 生成了 kernel 相关构建产物。
- linker 出现 `LOAD segment with RWX permissions` warning。
- 尽管存在该 warning，`make` 退出成功。

未覆盖内容：

- 该记录只证明 baseline build 成功。
- 该记录本身不证明 xv6 已进入 shell。
- linker warning 需要在后续报告中解释风险。

### xv6-riscv baseline boot evidence test

| 字段 | 内容 |
| --- | --- |
| 测试名称 | xv6-riscv baseline boot evidence test |
| 日期时间 | 2026-06-04 00:17:36 +08:00 |
| 命令 | `bash scripts/xv6/boot-xv6.sh` |
| baseline 路径 | `external/xv6-riscv/` |
| 结果 | baseline boot evidence found |
| 日志文件 | `logs/xv6-boot-20260604-001736.log` |
| 原始日志是否提交 | 否，`logs/*.log` 被 `.gitignore` 忽略 |

检测到的关键文本：

- `xv6 kernel is booting`
- `init: starting sh`

边界说明：

- 本次验证使用 timeout 自动退出 QEMU。
- 该结果只记录 boot evidence，不等同于长期稳定性测试。
- 尚未做人工长期交互测试。
- 2026-06-04 00:16:07 +08:00 的一次早期尝试未检测到 boot evidence，原因是 timeout 期间仍在构建用户程序和 `fs.img`；后续复跑后获得上述证据。

### lab1 hello syscall patch test

| 字段 | 内容 |
| --- | --- |
| 测试名称 | lab1 hello syscall patch test |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| patch 文件 | `patches/lab1-system-call/0001-add-hello-syscall.patch` |
| patch 目标 | 新增最小 `hello()` syscall，返回整数 `2026` |
| `make` 命令 | `bash scripts/xv6/check-xv6-baseline.sh --make` |
| `make` 结果 | 成功 |
| `make` 日志 | `logs/xv6-make-20260604-001927.log` |
| hello 验证命令 | `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"` |
| hello 输出结果 | 成功检测到预期输出 |
| hello 日志 | `logs/xv6-command-hello-20260604-002147.log` |
| 原始日志是否提交 | 否，`logs/*.log` 被 `.gitignore` 忽略 |

检测到的用户程序输出：

```text
hello syscall returned 2026
```

实现范围：

- `kernel/syscall.h`: 增加 `SYS_hello`。
- `kernel/syscall.c`: 注册 `sys_hello`。
- `kernel/sysproc.c`: 实现 `sys_hello()`。
- `user/user.h`: 声明 `hello()`。
- `user/usys.pl`: 生成用户态 syscall stub。
- `Makefile`: 将 `_hello` 加入 `UPROGS`。
- `user/hello.c`: 新增用户态测试程序。

边界说明：

- lab1 源码修改发生在被忽略的 `external/xv6-riscv/` 中。
- 可提交交付物是 patch 文件，不提交第三方 xv6 源码。
- 已验证 `make` 成功和 `hello` 输出证据。
- 尚未进行长期 QEMU 稳定性测试。
- 尚未由第二名队员复核 patch。
- 2026-06-04 00:20:22 +08:00 的一次早期自动输入尝试未检测到 hello 输出，原因是输入可能被构建过程消耗；脚本改为先构建 `fs.img` 后复跑，2026-06-04 00:21:47 +08:00 获得预期输出证据。

## 当前风险与后续动作

| 风险 | 状态 / 处理 |
| --- | --- |
| 仓库路径包含空格 | 当前命令已在该路径下运行成功；后续大量实验仍建议优先考虑 WSL-native 路径。 |
| `riscv64-unknown-elf-gcc` 缺失 | 当前 baseline 和 lab1 构建使用 `riscv64-linux-gnu-gcc` 成功；若 Makefile 或工具链策略变化需复查。 |
| linker RWX warning | 当前不阻塞 build，但需要在技术报告中解释。 |
| QEMU 只做 evidence 捕获 | 已检测到 boot 关键文本和 hello 输出，但未做长期稳定性和完整人工交互测试。 |
| patch baseline 依赖 | patch 应用于 `74f84181a3404d1d6a6ff98d342233979066ebb8`；baseline 变化时需重新验证。 |

## 后续记录模板

| 字段 | 内容 |
| --- | --- |
| 测试名称 | TODO |
| 日期时间 | TODO |
| 命令 | TODO |
| 环境 | TODO |
| 结果 | TODO |
| 日志或输出位置 | TODO |
| 风险 | TODO |
| 后续动作 | TODO |
