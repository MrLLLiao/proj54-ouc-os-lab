# lab2 process state observation

## 实验名称

lab2 process state observation

## patch 文件

```text
patches/lab2-process-observation/0001-add-pstate-syscall.patch
```

## baseline

| 字段 | 内容 |
| --- | --- |
| baseline repo | `https://github.com/mit-pdos/xv6-riscv.git` |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| 本地源码路径 | `external/xv6-riscv/` |

该 patch 独立于 lab1 patch，从 clean baseline 直接应用。若要与 lab1 patch 合并，需要重新规划 syscall number。

## 修改文件列表

- `kernel/syscall.h`
- `kernel/syscall.c`
- `kernel/sysproc.c`
- `user/user.h`
- `user/usys.pl`
- `Makefile`
- `user/pstatetest.c`

## 应用方式

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab2-process-observation/0001-add-pstate-syscall.patch
```

## 构建方式

```bash
make
```

## 运行方式

```bash
make qemu
```

进入 xv6 shell 后运行：

```text
pstatetest
```

## 自动验证方式

从仓库根目录运行：

```bash
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"
```

## 当前真实验证状态

| 检查项 | 状态 |
| --- | --- |
| clean baseline apply | PASS |
| `make` | PASS |
| `pstate(self) =` 输出捕获 | PASS |
| `RUNNING` 输出捕获 | PASS |
| 长期稳定性测试 | TODO |
| 人工交互录屏 | TODO |
| 第二名队员复现 | TODO |

实际观察到的输出包含：

```text
pstate(self) = 4 (RUNNING)
```

## 教学价值

该实验让学生在 lab1 syscall 参数传递之后，第一次读取内核进程信息。通过 `pstate(pid)`，学生可以理解：

- 用户态如何传入 pid。
- 内核如何遍历 `proc[]`。
- `struct proc` 中的 `state` 如何表示进程状态。
- 为什么读取 `p->state` 时要持有 `p->lock`。
- syscall 可以作为观察内核状态的教学接口。
