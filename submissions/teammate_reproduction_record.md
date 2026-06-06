# Teammate Reproduction Record

> 维护时间：2026-06-06（stage8b）。
> 本文件只记录队友复现 summary 的文字摘要，不提交原始 `logs/` 文件、summary 文件、截图或隐私材料。

## 记录目的

本记录用于证明已有队友在独立环境中运行过正式复现流程，并把 `teammate-verify.sh` 输出的 summary 反馈给队长。仓库只保留人工整理后的摘要，避免把原始日志、截图、终端历史、账号信息或机器隐私提交到 Git。

正式复现命令：

```bash
bash scripts/xv6/teammate-verify.sh --full
```

## 队友 A 记录

| 字段 | 内容 |
| --- | --- |
| 复现人 | 队友 A（终端 user: `root`，真实姓名待补充） |
| 时间 | `2026-06-06T19:15:02+08:00` |
| repo root | `/root/workspace/proj54-ouc-os-lab` |
| current commit | `1ba9db6 tooling: speed up verification and clean repo hygiene` |
| mode | `full` |
| interrupted | `NO` |
| summary file | `logs/teammate-verify-20260606-191352.summary.txt`（原始文件不入仓） |

| 检查项 | 结果 |
| --- | --- |
| doctor | PASS |
| check-env | PASS |
| baseline | PASS |
| apply+make | PASS |
| boot | PASS |
| hello | PASS |
| add2test | PASS |
| pstatetest | PASS |
| pcounttest | PASS |
| pchildtest | PASS |
| fcounttest | PASS |
| overall | PASS |

## 队友 B 记录

| 字段 | 内容 |
| --- | --- |
| 复现人 | 队友 B（终端 user: `z2996`，真实姓名待补充） |
| 时间 | 来自截图/日志；精确时间戳待核对 |
| repo root | `/home/z2996/workspace/proj54-ouc-os-lab` |
| current commit | `1ba9db6 tooling: speed up verification and clean repo hygiene` |
| mode | `full` |
| interrupted | 待补充 |
| summary file | 截图/日志中显示为 `logs/teammate-verify-20260606-201839.summary.txt` 或相关 teammate summary log；精确原始文件不入仓 |

| 检查项 | 结果 |
| --- | --- |
| doctor | PASS |
| check-env | PASS |
| baseline | PASS |
| apply+make | PASS |
| boot | PASS |
| hello | PASS |
| add2test | PASS |
| pstatetest | PASS |
| pcounttest | PASS |
| pchildtest | PASS |
| fcounttest | PASS |
| overall | PASS |

说明：队友 B 的记录基于队友提供的截图/log 摘要整理。若截图与日志中的时间戳或 summary 文件名存在不完全一致，最终报告中应写明“z2996 teammate full summary, timestamp from screenshot/log, exact raw file not committed”，不要补造不存在的原始文件。

## 诚信边界

- 不提交 `logs/*.log`。
- 不提交 `logs/*.summary.txt`。
- 不提交 `logs/*.console.txt`。
- 不提交截图、录屏、终端历史或个人隐私材料。
- 不记录 token、password、cookie、报名材料或未公开账号信息。
- 本记录基于队友提供的 summary 文本/截图整理；未知的真实姓名、系统版本和精确文件冲突保持“待补充/待核对”。
