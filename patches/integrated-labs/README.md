# integrated lab patch sequence

## 目的

本目录保存面向最终综合演示的统一 patch sequence。它用于在同一个 xv6-riscv 构建中同时演示：

- lab1 minimal syscall：`hello()`
- lab1 advanced syscall：`add2(int a, int b)`
- lab2 process state observation：`pstate(int pid)`

该序列解决了 stage4b 已实测的 lab1/lab2 独立 patch 冲突问题。原有独立 patch 仍保留，用于单 lab 教学和单独复现；本目录只作为综合演示路径使用。

## 与独立 patch 的关系

| patch 组 | 用途 | 是否替代原 patch |
| --- | --- | --- |
| `patches/lab1-system-call/` | lab1 单独教学与复现 | 否 |
| `patches/lab2-process-observation/` | lab2 单独教学与复现 | 否 |
| `patches/integrated-labs/` | lab1 + lab2 同一 xv6 构建综合演示 | 否，仅新增综合路径 |

不要把 lab2 independent patch 直接叠加到 lab1 patch 之上。综合演示请使用本目录的顺序 patch。

## baseline

| 字段 | 内容 |
| --- | --- |
| baseline repo | `https://github.com/mit-pdos/xv6-riscv.git` |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| 本地源码路径 | `external/xv6-riscv/` |

## syscall number table

| syscall | number | 用户程序 | 说明 |
| --- | --- | --- | --- |
| `hello` | 22 | `hello` | 返回 `2026` |
| `add2` | 23 | `add2test` | 使用 `argint()` 获取两个整数参数并返回和 |
| `pstate` | 24 | `pstatetest` | 根据 pid 查找 `proc[]` 并返回进程状态 |

## 推荐助手脚本

最终综合 Demo 和评委/队友复现建议优先使用助手脚本：

```bash
bash scripts/xv6/apply-integrated-labs.sh
bash scripts/xv6/apply-integrated-labs.sh --make --yes
```

说明：

- 不带参数时是预览模式，不 reset、不 apply、不 make。
- `--make --yes` 会在 ignored 的 `external/xv6-riscv/` 中执行 `git reset --hard` 和 `git clean -fdx`，再应用 integrated `0001`、`0002`、`0003` 并运行 `make`。
- `make` 输出保存到 `logs/integrated-make-YYYYMMDD-HHMMSS.log`，原始日志被 Git 忽略，不提交。
- 该脚本不会修改主仓库 tracked 文件，不会提交第三方源码。

## 手动应用顺序

从 clean baseline 开始：

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/integrated-labs/0001-add-hello-syscall.patch
git apply ../../patches/integrated-labs/0002-add-argint-add2-syscall.patch
git apply ../../patches/integrated-labs/0003-add-pstate-syscall.patch
```

## 构建方式

```bash
make
```

## 自动验证方式

从仓库根目录运行：

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

## 当前真实验证结果

| 检查项 | 状态 |
| --- | --- |
| clean baseline + `0001` + `0002` + `0003` apply | PASS |
| `make` | PASS |
| boot evidence | PASS，检测到 `xv6 kernel is booting` 与 `init: starting sh` |
| `hello` 输出捕获 | PASS，检测到 `hello syscall returned 2026` |
| `add2test` 输出捕获 | PASS，检测到 `add2(20, 6) returned 26` |
| `pstatetest` 输出捕获 | PASS，检测到 `pstate(self) =` 与 `RUNNING` |
| 长期稳定性测试 | TODO |
| 人工交互录屏 | TODO |
| 第二名队员复现 | TODO |

说明：

- `boot-xv6.sh` 和 `run-xv6-command.sh` 使用 timeout 自动退出 QEMU。
- 上述结果证明当前综合构建可捕获关键输出，不等同于长期稳定性测试或人工交互录屏。
- 原始 `logs/*.log` 被 Git 忽略，不提交。

## 禁止事项

- 不提交 `external/xv6-riscv/` 第三方源码。
- 不提交 `logs/*.log` 原始日志。
- 不把 timeout 自动捕获写成人工录屏或长期稳定性测试。
- 不声称原有 independent patch 已被替换；它们仍用于单 lab 教学。
