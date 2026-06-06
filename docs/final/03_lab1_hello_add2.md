# 03 Lab1 Hello Add2

## 实验目标

通过 `hello()` 和 `add2(int,int)` 两个递进 syscall，让学生理解 xv6-riscv 从用户态到内核态的系统调用路径。

## 前置知识

- user/kernel 边界。
- syscall number。
- `ecall` / trap。
- syscall dispatch table。
- 用户态 stub。
- `argint()` 参数读取。

## 涉及文件

| 文件 | 作用 |
| --- | --- |
| `kernel/syscall.h` | 分配 syscall number：`SYS_hello=22`，`SYS_add2=23` |
| `kernel/syscall.c` | 声明并注册 `sys_hello`、`sys_add2` |
| `kernel/sysproc.c` | 实现 `sys_hello()`、`sys_add2()` |
| `user/user.h` | 声明用户态函数 |
| `user/usys.pl` | 生成用户态 syscall stub |
| `Makefile` | 把 `_hello`、`_add2test` 加入 `UPROGS` |
| `user/hello.c` | hello 测试程序 |
| `user/add2test.c` | add2 测试程序 |
| `patches/lab1-system-call/` | independent lab1 patch |
| `patches/integrated-labs/0001-0002` | integrated lab1 patch |

## 实现步骤

1. 在 `kernel/syscall.h` 中分配 syscall number。
2. 在 `kernel/syscall.c` 中声明内核实现，并加入 syscall dispatch table。
3. 在 `kernel/sysproc.c` 中实现内核函数。
4. 在 `user/user.h` 中声明用户态接口。
5. 在 `user/usys.pl` 中加入 `entry("hello")` 和 `entry("add2")`。
6. 在 `Makefile` 中加入用户程序。
7. 新增 `user/hello.c` 和 `user/add2test.c`。
8. 从 clean baseline 应用 patch 并 make。

## 关键代码解释

`hello()` 是最小闭环：

```c
uint64
sys_hello(void)
{
  return 2026;
}
```

它不读参数，只返回固定值，适合用来讲 syscall 编号、用户态 stub、dispatcher 和返回路径。

`add2()` 引入整数参数：

```c
uint64
sys_add2(void)
{
  int a;
  int b;

  argint(0, &a);
  argint(1, &b);
  return a + b;
}
```

参数来自用户态寄存器；内核通过 `argint(n, &value)` 读取第 `n` 个整数参数。当前 baseline 的 `argint` 返回 `void`，因此实现不写返回值判断。

## 测试方法

```bash
bash scripts/xv6/apply-integrated-labs.sh --make --yes
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
```

也可以单独应用 lab1 independent patch：

```bash
cd external/xv6-riscv
git reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8
git clean -fdx
git apply ../../patches/lab1-system-call/0001-add-hello-syscall.patch
git apply ../../patches/lab1-system-call/0002-add-argint-add2-syscall.patch
make
```

## 预期输出

```text
hello syscall returned 2026
add2(20, 6) returned 26
```

## 当前真实结果

| 测试项 | 结果 |
| --- | --- |
| clean baseline + `0001` + `0002` apply | PASS |
| make | PASS |
| hello output | PASS |
| add2test output | PASS |
| 长期稳定性测试 | 未执行 |
| 队友独立复现 | 已覆盖在 2 份队友 `teammate-verify.sh --full` PASS summary 中；文字摘要见 `submissions/teammate_reproduction_record.md` |

## 常见错误

| 问题 | 原因 | 处理 |
| --- | --- | --- |
| syscall number 冲突 | 使用已有编号 | integrated 中固定 hello=22、add2=23 |
| 用户态找不到函数 | `user/user.h` 漏声明 | 添加声明后重新 make |
| xv6 shell 找不到程序 | `Makefile` 漏加入 `UPROGS` | 加入 `_hello` 或 `_add2test` |
| 调用后返回异常 | `usys.pl` 漏 entry | 加入 entry 并重新构建 |
| add2 参数错误 | `argint` 序号错 | 使用 `argint(0,&a)` 和 `argint(1,&b)` |
| patch 应用失败 | baseline 不干净或顺序错误 | 从固定 baseline 重置并按顺序 apply |

## 扩展问题

1. 如果把 `SYS_hello` 和 `SYS_add2` 设成同一个编号，会发生什么？
2. `argint()` 如何从 trapframe 中读取用户态参数？
3. 如何扩展到 `argaddr()` / `argstr()`？
4. 如果让学生自己补全 `sys_add2()`，评分点应如何设计？
