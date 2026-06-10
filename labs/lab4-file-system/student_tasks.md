# Lab4 学生任务书：文件表与 fd 观察

> 先读 [README.md](README.md)，跑通 `fcounttest`/`fdcounttest`/`fdinfotest`。本关核心是把"fd → struct file → 全局 file table"三层关系做成可验证的预测。

## 学生目标

能预测并验证 `open`/`dup`/`close` 对三个观察接口的影响，能解释 `fdinfo` 的输入校验和锁的位置。

## 必做任务

1. **T1 预测-验证表**：画一张表，行是操作序列 `open → dup → close(fd) → close(dupfd)`，列是 `fdcount` 和 `fcount` 的变化（+1/0/-1）。先填预测，再跑 `fdcounttest` 对照。重点解释：为什么 `dup` 让 fdcount +1 而 fcount 不变。
2. **T2 fdinfo 校验审查**：对照 `patches/integrated-labs/0009-add-fdinfo-copyout-observation.patch`，回答：
   - `fd < 0 || fd >= NOFILE || p->ofile[fd] == 0` 三个条件各拦截什么攻击/错误？
   - `fileinfo()` 为什么拿 `ftable.lock` 而不是进程锁？
   - 坏指针是在哪一步被拒绝的？
3. **T3 观察 ref**：写一个小实验（改 `fdinfotest` 或新写程序）：open 一个文件后 dup 两次，用 `fdinfo` 看同一个 `struct file` 的 `ref` 怎么变，close 后再看。记录真实输出（`ref` 数值不要求固定，要求趋势解释正确）。
4. **T4 负向用例**：自己再设计两个 `fdinfo` 应该返回 -1 的输入（不许重复 `99` 和已关闭 fd），验证并解释。

## 选做挑战

- **C1**：`fork()` 之后父子进程的 `fdcount` 各是多少？`fcount` 呢？先预测再验证。
- **C2**：读 `kernel/file.c` 的 `filedup()`/`fileclose()`，指出 `ref` 在哪里 ++/--，以及为什么都在 `ftable.lock` 里。

## 提交内容

- T3/T4 的增量 patch 或修改说明（写明基底）。
- 实验报告：T1 预测对照表、T2 三问、T3 输出与解释、T4 用例设计。

## 自检命令

```bash
bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"
bash scripts/xv6/run-xv6-command.sh fdcounttest "fdcounttest done"
bash scripts/xv6/run-xv6-command.sh fdinfotest "fdinfotest done"
```

## 评分 rubric（100 分）

| 项目 | 分值 | 标准 |
| --- | ---: | --- |
| T1 预测-验证 | 25 | 表完整，dup 的解释到位 |
| T2 校验审查 | 25 | 三问准确，锁的归属说得清 |
| T3 ref 观察 | 25 | 真实输出 + 趋势解释，不写死数值 |
| T4 负向用例 | 15 | 用例不重复、解释正确 |
| 报告诚实度 | 10 | 数字标注"本次观察值" |

## 常见扣分点

- 把 `fcount` 绝对值写成固定验收标准。
- 说 `fdinfo` 能看别的进程的 fd（它只查 `myproc()->ofile[fd]`）。
- 说 `fdinfo` 返回文件名/路径（它刻意不返回，避免信息泄露）。
- T4 用例与示例重复，或解释只有"因为它是坏的"。

## 思考题

1. 重定向 `ls > out.txt` 大概动了哪一层：fd 表、struct file，还是 inode？
2. 为什么 `struct fdinfo` 选了 `{type, readable, writable, ref}` 这四个字段，而不带 inode 号？
3. 两个进程 `open` 同一个文件，`fcount` 加几？它们共享 `struct file` 吗？
