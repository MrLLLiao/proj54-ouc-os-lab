# Lab3 学生任务书：页表与内存观察

> 先读 [README.md](README.md)，跑通 `pgcounttest`。本关两个台阶：先用 int 返回值观察（`pgcount`），再用结构体 copyout 观察（`memstat`）。

## 学生目标

能用自己加的 syscall 量出 eager/lazy allocation 的差别，并解释内核为什么必须用 `copyout` 而不能直接写用户指针。

## 必做任务

1. **T1 预测-验证**：跑 `pgcounttest` 之前，先在报告里写下你预测的四个 delta（eager 后 / lazy 触摸前 / 触摸一页后 / 触摸两页后），再跑命令对答案。预测错了不扣分，不解释才扣分。
2. **T2 读懂观察函数**：回答三个问题，各 100 字以内：
   - `walk(pagetable, va, 0)` 第三个参数 0 是什么意思？传 1 会怎样？
   - 为什么要同时检查 `PTE_V` 和 `PTE_U`？
   - 为什么 `pgcount before` 的绝对值不能当验收标准？
3. **T3 memstat 路径讲解**：对照 `patches/integrated-labs/0008-add-memstat-copyout-observation.patch`，画出 `memstattest` 调用 `memstat(&st)` 时数据的流向：用户栈上的 `st` → `argaddr` 拿到的是什么 → 内核栈上的 `struct memstat` → `copyout` 做了什么检查。指出哪一步会让"传坏指针返回 -1"成立。
4. **T4 自己扩展一个字段**：给 `struct memstat` 加第四个字段（如 `stack_pages`，固定为 1，或自选可解释的值），同步改 `memstat.h`/`sys_memstat`/测试程序，验证新字段输出正确。注意：加字段后想想结构体有没有出现 padding，写进报告。

## 选做挑战

- **C1**：把 `sbrk(-2*PGSIZE)` 缩回后再测一次 pgcount，解释 delta。
- **C2**：`memstattest` 用 `0x40000000` 当坏指针。为什么选这个值而不是 `(void*)-1`？（提示：`MAXVA` 和 `walk` 的 panic 条件。）

## 提交内容

- T4 的增量 patch 与基底说明。
- 实验报告：T1 预测对照表、T2 三问、T3 数据流图（手画拍照可以）、T4 padding 分析。

## 自检命令

```bash
bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"
bash scripts/xv6/run-xv6-command.sh memstattest "memstattest done"
```

## 评分 rubric（100 分）

| 项目 | 分值 | 标准 |
| --- | ---: | --- |
| T1 预测-验证 | 15 | 有事前预测，有对照解释 |
| T2 三问 | 25 | 答案准确、不空话 |
| T3 数据流 | 25 | copyout 的检查点指认正确 |
| T4 扩展字段 | 25 | 编译过、输出对、padding 说清 |
| 报告诚实度 | 10 | 失败/意外如实记录 |

## 常见扣分点

- T1 跳过预测直接贴输出。
- 把 `pgcount`/`memstat` 写成"实现了内存管理"。
- T4 加了 `char` 字段却没发现 sizeof 变化里的 padding。
- 在观察函数里用 `walk(..., 1)`（观察代码改了状态，原则性错误）。

## 思考题

1. `p->sz` 和 `mapped_pages * PGSIZE` 什么时候相等、什么时候不等？
2. 如果内核直接 `*(struct memstat*)uaddr = st;` 会有什么安全问题？至少说两个。
3. lazy allocation 省的是什么？代价又是什么？
