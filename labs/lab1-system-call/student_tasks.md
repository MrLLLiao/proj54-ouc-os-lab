# Lab1 学生任务书：系统调用

> 先读完 [README.md](README.md) 并跑通 `hello`/`add2`，再开始做任务。做任务时不要照抄参考 patch——抄了你自己心里有数，验收时也讲不出来。

## 学生目标

独立给 xv6 加一个带整数参数的系统调用，并能不看笔记说出从用户程序到内核函数的完整路径。

## 必做任务

1. **T1 跑通参考实现**：从 clean baseline 应用 `0001`+`0002`，`make`，捕获 `hello syscall returned 2026` 和 `add2(20, 6) returned 26`。把两条验证命令和真实输出贴进报告。
2. **T2 自己加一个 syscall**：实现 `mul2(int a, int b)`（返回 `a*b`）或自选一个同等难度的整数 syscall（名字不超过 8 个字符，避开已有编号 22/23）。要求：
   - 7 个文件各改对（`syscall.h`/`syscall.c`/`sysproc.c`/`user.h`/`usys.pl`/`Makefile`/用户测试程序）。
   - 测试程序打印的结果必须由调用返回值算出来，不允许打印写死的字符串。
3. **T3 破坏-修复实验**：故意删掉你的 `entry("...")` 或 dispatch 表项，重新 `make` 并运行，把报错现象记下来，再修复。报告里写：症状是什么、为什么是这个症状、你怎么定位的。

## 选做挑战

- **C1**：给 `add2` 写两个边界用例（如负数、`0x7fffffff` 附近），观察并解释 int 溢出行为。
- **C2**：读 `kernel/syscall.c` 的 `argraw()`，写 200 字说明 `argint(n, &x)` 是怎么从 trapframe 拿到第 n 个参数的。

## 提交内容

- 你的增量 patch（`git diff > my-lab1.patch`，从 baseline 或 `0002` 之后均可，写明基底）。
- 实验报告：环境信息、真实命令与输出、T3 的破坏-修复记录、调用路径讲解（可画图）。
- 不要提交 `external/xv6-riscv/` 整个目录或任何 `logs/*.log`。

## 自检命令

```bash
bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"
bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"
# 你自己的 syscall（示例）：
bash scripts/xv6/run-xv6-command.sh mul2test "mul2(6, 7) returned 42"
```

## 评分 rubric（100 分）

| 项目 | 分值 | 标准 |
| --- | ---: | --- |
| T1 复现 | 20 | 命令与输出真实、完整 |
| T2 新 syscall 正确 | 35 | 7 文件齐全、编译零警告新增、输出由返回值计算 |
| T3 破坏-修复 | 20 | 症状记录真实，解释到点（stub 缺失 vs 表项缺失症状不同） |
| 路径讲解 | 15 | 能从 `ecall` 讲到 `a0` 返回，不背诵 |
| 报告诚实度 | 10 | 失败如实记录；无伪造输出 |

## 常见扣分点

- 测试程序打印写死的"正确答案"（一查 patch 就露馅，按伪造处理）。
- syscall 编号与已有冲突导致行为怪异却没发现。
- 报告里只有成功截图，没有命令；无法复现。
- 把 `external/xv6-riscv/` 或日志塞进提交包。

## 思考题（写进报告加分）

1. 为什么 xv6 让 `usys.pl` 生成 stub，而不是让用户程序直接 `ecall`？
2. 如果两个 syscall 用了同一个编号，链接器和运行时各会发生什么？
3. `argint` 读的是寄存器还是内存？trapframe 在这里扮演什么角色？
