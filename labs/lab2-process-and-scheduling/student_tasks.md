# Lab2 学生任务书：进程状态观察

> 先读 [README.md](README.md)，跑通 `pstatetest`/`pcounttest`/`pchildtest`。本关重点不是"加 syscall"（Lab1 学过了），而是"在内核里安全地读共享数据"。

## 学生目标

能解释 xv6 进程表的遍历与加锁规则，并独立写一个带输入校验的进程观察 syscall。

## 必做任务

1. **T1 跑通参考实现**：捕获 `pstate(self) =`、`pcount(RUNNING) =`、`pcount(99) = -1`、`pstate(child) =` 四组输出，贴进报告（写明数值/状态是"本次观察值"）。
2. **T2 锁路径审查**：对照 `sys_pstate()` 的循环，逐条返回路径回答："这条路径上锁释放了吗？"把分析写成表格。然后故意注释掉一个 `release(&p->lock)`，描述（不要求实际跑死锁）这会违反什么约定。
3. **T3 自己加一个观察 syscall**：实现 `pzombie(void)`（统计 ZOMBIE 状态进程数）或 `pmaxpid(void)`（返回当前最大 pid），要求：
   - 遍历 `proc[]` 时按规矩拿锁、放锁。
   - 对无效输入（如果你的设计有参数）返回 -1。
   - 测试程序真实计算/打印，附一次 fork 出 ZOMBIE 或新 pid 的对比观察。
4. **T4 时序观察**：连续运行 `pchildtest` 至少 5 次，记录每次 child 状态。统计出现了哪几种，解释为什么会不同。

## 选做挑战

- **C1**：解释为什么 `pstate(self)` 几乎总是 `RUNNING`（提示：谁在执行这行代码？）。
- **C2**：读 `kernel/proc.c` 的 `scheduler()`，找出 `p->state` 在哪几处被改写，列出文件:行号。

## 提交内容

- 你的增量 patch 与基底说明。
- 实验报告：T1 输出、T2 锁分析表、T3 设计与验证、T4 多次观察记录。
- 不提交 `external/` 与 logs。

## 自检命令

```bash
bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="
bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"
bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="
```

## 评分 rubric（100 分）

| 项目 | 分值 | 标准 |
| --- | ---: | --- |
| T1 复现 | 15 | 四组输出真实，标注"观察值不固定" |
| T2 锁分析 | 25 | 每条路径判断正确；违规后果说得清 |
| T3 新 syscall | 35 | 锁正确、校验正确、测试真实计算 |
| T4 时序观察 | 15 | 有原始记录，解释指向调度时序 |
| 报告诚实度 | 10 | 不把单次观察写成必然值 |

## 常见扣分点

- 把 `pcount(RUNNING) = 1` 写成"恒等于 1"。
- 找到目标进程后 `return` 前忘了 `release`，或先 `release` 再读 `p->state`。
- 新 syscall 没有负向用例。
- 用长命令名导致 `mkfs` 失败还不知道为什么（看 README 里 `DIRSIZ` 那条卡点）。

## 思考题

1. 为什么读 `p->state` 要拿 `p->lock`，而 `pcount` 一次只拿一个进程的锁——这样数出来的总数是"某一瞬间的快照"吗？
2. 子进程刚 fork 完是什么状态？什么时候变 `RUNNING`？
3. 如果想观察"其他用户的进程"，xv6 需要先有什么概念？（提示：xv6 没有用户/权限模型）
