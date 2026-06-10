# Lab5 学生任务书：综合复现（capstone）

> 先读 [README.md](README.md)。这一关不写新内核代码，考的是工程素养：复现、记录、解释、诚实。

## 学生目标

独立完成 integrated `0001-0009` 的全流程复现，交出一份别人能照着重跑的实验报告。

## 必做任务

1. **T1 全流程复现**：依次执行环境诊断、clean apply+make、boot、全部用户程序验证（推荐直接 `bash scripts/xv6/teammate-verify.sh --full`）。把最终的 `COPY THIS SUMMARY TO TEAM LEAD` 块原样贴进报告（含 commit 行）。
2. **T2 patch 导读**：从 `patches/integrated-labs/` 的 9 个 patch 里挑 3 个（必须包含 `0008` 或 `0009` 之一），各用 150 字说明：加了什么 syscall、改了哪些文件、教学点是什么。
3. **T3 机制串讲**：回答"一个 syscall 的一生"：以 `memstattest` 调用 `memstat(&st)` 为例，从用户程序写到内核返回，路径上至少点名 6 个文件。
4. **T4 故障记录**：复现过程中至少记录一次真实异常（boot 第一次超时、`Ctrl+Z` 卡住、`/mnt` 慢、make 重编……没有遇到就主动制造一次 `Ctrl+Z` 再救回来），写：症状 → 处理命令（如 `cleanup-qemu.sh`）→ 结果。
5. **T5 证据边界声明**：报告末尾用自己的话写清三句：哪些结果是你本机自动捕获；哪些需要他人复现才算数；为什么不能拿别人旧 commit 的 PASS 当自己的证据。

## 选做挑战

- **C1**：在另一台机器（或同学机器）上重跑 T1，对比两份 summary 的差异并解释。
- **C2**：给 9 个 syscall 画一张"编号 22-30 + 所属 lab + 观察对象"的总览图。

## 提交内容

- 实验报告（含 T1 summary 块、T2-T5）。
- 不提交 `external/xv6-riscv/`、`logs/`、视频、截图原图。

## 自检命令

```bash
bash scripts/xv6/doctor.sh
bash scripts/xv6/teammate-verify.sh --full
# 卡住时：
bash scripts/xv6/cleanup-qemu.sh
```

## 评分 rubric（100 分）

| 项目 | 分值 | 标准 |
| --- | ---: | --- |
| T1 复现 | 25 | summary 真实完整，overall PASS 或如实记录失败 |
| T2 patch 导读 | 20 | 三段都落到具体文件与机制 |
| T3 机制串讲 | 20 | 路径连贯，文件点名准确 |
| T4 故障记录 | 15 | 症状-处理-结果三段齐 |
| T5 证据边界 | 10 | 三句话立场正确 |
| 报告可重跑性 | 10 | 他人按报告能操作 |

## 常见扣分点

- summary 块被手工改过（时间戳/commit 对不上，按伪造处理）。
- 报告只有成功，没有任何异常记录——真实复现几乎不可能零波折。
- 把 timeout 自动捕获说成"长期稳定运行"。
- 把历史 `0001-0007` 证据说成覆盖当前 `0001-0009`。

## 思考题

1. 为什么 integrated 序列要统一编号 22-30，而 independent patch 各自用 22？
2. "在我机器上能跑"和"可复现"之间差的是哪些东西？
3. 如果你是助教，拿到一份全 PASS 的报告，你会抽查什么来确认它不是编的？
