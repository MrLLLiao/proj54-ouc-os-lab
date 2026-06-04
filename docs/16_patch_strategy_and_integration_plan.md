# patch 策略与综合集成计划

本文件由 stage4b 红队整理，并在 stage4c 更新集成结果。目标是说明当前 lab1/lab2 patch 的组织方式、**已实测的综合应用冲突**，以及综合演示时采用的统一 patch sequence。核心结论：**单个 lab 的 patch 各自可从 clean baseline 独立复现，但 lab1 与 lab2 的 independent patch 不能直接叠加；综合演示应使用 `patches/integrated-labs/` 的统一序列。**

- 阶段：stage4b / stage4c
- 日期：2026-06-04
- baseline commit：`74f84181a3404d1d6a6ff98d342233979066ebb8`

## 1. 当前 patch 类型

| patch | 类型 | 基线 | syscall 号 | 用户程序 |
| --- | --- | --- | --- | --- |
| `patches/lab1-system-call/0001-add-hello-syscall.patch` | lab1 序列第 1 个 | clean baseline | `SYS_hello 22` | `hello` |
| `patches/lab1-system-call/0002-add-argint-add2-syscall.patch` | lab1 序列第 2 个（在 `0001` 之上） | baseline + `0001` | `SYS_add2 23` | `add2test` |
| `patches/lab2-process-observation/0001-add-pstate-syscall.patch` | lab2 独立 patch | clean baseline | `SYS_pstate 22` | `pstatetest` |
| `patches/integrated-labs/0001-add-hello-syscall.patch` | 综合序列第 1 个 | clean baseline | `SYS_hello 22` | `hello` |
| `patches/integrated-labs/0002-add-argint-add2-syscall.patch` | 综合序列第 2 个 | integrated `0001` 之后 | `SYS_add2 23` | `add2test` |
| `patches/integrated-labs/0003-add-pstate-syscall.patch` | 综合序列第 3 个 | integrated `0001`+`0002` 之后 | `SYS_pstate 24` | `pstatetest` |

要点：lab1 是**有序序列**（`0001` 后 `0002`，号 22、23）；lab2 是**独立**从 clean baseline 生成（号 22）。

## 2. 为什么 lab2 现在设计成 independent patch

当前把 lab2 设计成独立 patch（不挂在 lab1 之后）有合理性：

- **便于单独教学**：lab2「进程状态观察」可独立讲，不要求先学完 lab1 的 hello/add2。
- **便于学生只做 lab2**：学生从 clean baseline 直接应用 lab2 patch 即可，路径短、依赖少。
- **便于评委单独复现**：评委可对每个 lab 做最小化、互不干扰的复现，定位问题更清楚。
- **降低耦合**：每个 lab 的 patch 自包含，单点修改不会牵连其它 lab 的 patch。

## 3. 风险（已实测，非推测）

stage4b 在被忽略的 `external/xv6-riscv/` 中实测了"综合应用"，结论是**当前 lab1 与 lab2 不能直接叠加**：

### 3.1 syscall 号直接冲突

- `SYS_hello = 22`（lab1 `0001`）
- `SYS_add2 = 23`（lab1 `0002`）
- `SYS_pstate = 22`（lab2 独立）

→ `SYS_hello` 与 `SYS_pstate` **同为 22**，综合时号段冲突。

### 3.2 git apply hunk 冲突（实测）

在 clean baseline 上先应用 lab1 `0001`，再 `git apply --check` lab2：

```text
error: patch failed: Makefile:128
error: patch failed: kernel/syscall.c:102
error: patch failed: kernel/syscall.h:20
error: patch failed: kernel/sysproc.c:107
error: patch failed: user/user.h:24
error: patch failed: user/usys.pl:42
=> git apply --check exit code = 1 (lab2 不能应用到 lab1 之上)
```

在 clean baseline 上先应用 lab1 `0001`+`0002`，再 `git apply --check` lab2：同样 **exit 1**，6 个文件全部 `patch does not apply`。

原因：两个 lab 的 patch 都基于 clean baseline 的相同上下文（都在 `$U/_echo\` 之后、`sys_close` 之后、`SYS_close 21` 之后等同一处插入），一旦其中一个先应用，另一个的上下文行就不再匹配。

### 3.3 影响

- **不能**简单地 `git apply lab1/* lab2/*` 得到一个同时含 hello/add2/pstate 的 xv6。
- final demo 若要"同时演示 hello / add2 / pstate"，必须另做**统一 patch 序列**并重排 syscall 号。
- 还观察到 `user/usys.pl has type 100644, expected 100755` 的 file mode warning（Windows/WSL 检出与 patch 记录的可执行位不一致），不阻塞应用，但集成时应统一处理。

## 4. stage4c 集成执行结果

stage4c 已新增目录 `patches/integrated-labs/`，存放面向综合演示的统一序列。该序列不替换原有 independent patch，只解决“同一个 xv6 构建同时演示 hello / add2 / pstate”的问题。

统一 syscall 号：

- `SYS_hello = 22`
- `SYS_add2 = 23`
- `SYS_pstate = 24`

真实验证路径：

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/integrated-labs/0001-add-hello-syscall.patch
git apply ../../patches/integrated-labs/0002-add-argint-add2-syscall.patch
git apply ../../patches/integrated-labs/0003-add-pstate-syscall.patch
make
cd ../..
bash scripts/xv6/boot-xv6.sh
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

真实结果：

- clean baseline + integrated `0001` + `0002` + `0003` 顺序应用：PASS。
- `make`：PASS，仍有已知 `LOAD segment with RWX permissions` linker warning。
- boot evidence：PASS，检测到 `xv6 kernel is booting` 和 `init: starting sh`。
- `hello`：PASS，检测到 `hello syscall returned 2026`。
- `add2test`：PASS，检测到 `add2(20, 6) returned 26`。
- `pstatetest`：PASS，检测到 `pstate(self) =` 和 `RUNNING`。

边界：

- 该验证使用 timeout 自动捕获 QEMU 输出，不等同于长期稳定性测试。
- 人工交互录屏仍为 TODO。
- 第二名队员独立复现仍为 TODO。
- 原始 `logs/*.log` 不提交。

## 5. 当前结论

- **lab1 序列（`0001`+`0002`）独立可复现**：stage2b/stage3b 已实测（`git apply --check` exit 0、make、hello/add2 输出捕获）。
- **lab2 独立 patch 可复现**：stage4b 实测（clean baseline → lab2 patch → make → `pstate(self) = 4 (RUNNING)`）。
- **lab1 与 lab2 independent patch 当前不能直接叠加**：已实测 `git apply --check` exit 1，且 `SYS_hello`/`SYS_pstate` 撞号 22。
- **integrated-labs 统一序列已实现并验证**：用于综合演示，采用 `SYS_hello 22`、`SYS_add2 23`、`SYS_pstate 24`。stage4d 红队已独立复现并审查，见 [17_integrated_labs_review.md](17_integrated_labs_review.md)。
- 文档中必须继续区分“单 lab 教学 patch”和“综合演示 patch”，**不得**暗示原有 independent patch 可任意组合。

> 诚实边界：本文件的冲突结论和 integrated-labs 验证结果都来自真实命令输出；人工录屏、长期稳定性测试和第二名队员复现仍为 TODO。
