# Evidence Manifest

> 维护时间：2026-06-10（stage12 分层说明；证据内容自 stage11b 起未变）。
> 本文件是最终证据索引，不保存原始证据文件。
> 读者定位：这是**评委/提交材料**入口。如果你是来学实验的，请从根 [README.md](../README.md) 开始，不需要读本文件。

## Manifest Purpose

本 manifest 集中记录最终提交证据的文字摘要、外部文件位置、文件大小、时间和 SHA256。它不是 raw evidence storage；视频、截图、console log、summary 原件仍保存在仓库外，不提交 Git。

## Current Final Integrated Suite (stage11b)：`0001-0009`

> stage11b 把 `memstat`(`0008`) 与 `fdinfo`(`0009`) 进入 integrated 主线，final integrated suite 变为 `0001-0009`。旧 `e8e2fb9 / 0001-0007` 三方 full PASS 与旧 final video **降级为 historical stable checkpoint**（见下方），**不覆盖** `0001-0009`。新 final evidence 需要在用户提交 stage11b 并重新复现后填写，当前全部为 TBD，不得伪造。

| 序列 | 内容 | syscall |
| --- | --- | --- |
| `0001-0007` | 见 historical stable checkpoint（hello/add2/pstate/pcount/fcount/pgcount/fdcount） | 22-28 |
| `0008` | Lab3 advanced `memstat()` 地址空间观察（argaddr + copyout + struct ABI） | `SYS_memstat = 29` |
| `0009` | Lab4 advanced `fdinfo()` fd 元数据观察（argint + argaddr + copyout + struct ABI） | `SYS_fdinfo = 30` |

| 字段 | 内容 |
| --- | --- |
| new final commit | TBD after commit |
| lead `rain` full verify | TBD（需重新复现 `0001-0009`） |
| teammate `root` full verify | TBD（需重新复现 `0001-0009`） |
| teammate `z2996` full verify | TBD（需重新复现 `0001-0009`） |
| new final video | TBD |
| new final video SHA256 | TBD |

本机参考（非队友复现，不计入 final evidence）：stage11b 在当前工作树用 `local-verify.sh --full` 实测 `0001-0009` apply+make+boot + 全部 10 个用户程序（含 `memstattest`/`fdinfotest`）`overall: PASS`；该结果只证明工作树可复现，待用户提交新 commit 后由 rain/root/z2996 重新 full verify 才计入 final evidence。边界：`memstat` 不是完整内存管理，`fdinfo` 不是完整文件系统。

## Previous Stable Checkpoint（historical，stage11b 已被 `0001-0009` superseded）

```text
e8e2fb9 feat(integrated): add lab3 pgcount and lab4 fdcount workflow
```

下列 `e8e2fb9 / 0001-0007` 证据是**历史稳定检查点**，证明较早 final integrated suite `0001-0007` 的真实三方复现；它**不覆盖** stage11b 的 `0001-0009`。

| 序列 | 内容 |
| --- | --- |
| `0001-0007` | previous stable integrated suite |
| `0006` | Lab3 `pgcount()` 页表映射数量观察 + eager/lazy allocation 对比 |
| `0007` | Lab4 v0.2 `fdcount()` 当前进程 fd table 观察 |
| Lab5 | capstone 综合复现实验，不是新增内核机制 |

## Previous Stable Checkpoint — Verification Summary（`e8e2fb9 / 0001-0007`，historical）

> 以下三方 PASS 只覆盖 `e8e2fb9` 的 `0001-0007`，**不覆盖** stage11b 的 `0001-0009`。

| 角色 | user | mode | commit | integrated suite | result | 证据记录 |
| --- | --- | --- | --- | --- | --- | --- |
| team lead local verification | `rain` | `full` | `e8e2fb9` | `0001-0007` | PASS | `submissions/teammate_reproduction_record.md` |
| teammate A | `root` | `full` | `e8e2fb9` | `0001-0007` | PASS | external summary + screenshot metadata recorded |
| teammate B | `z2996` | `full` | `e8e2fb9` | `0001-0007` | PASS | external console log + screenshot metadata recorded |

所有 final verification 均覆盖：

```text
doctor/check-env/baseline/apply+make/boot/hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest/pgcounttest/fdcounttest/overall
```

结果均为 PASS。

## Previous Stable Checkpoint — Video Evidence（`e8e2fb9 / 0001-0007`，historical）

> 该视频只演示 `0001-0007`，**不覆盖** stage11b 的 `0001-0009`；新视频为 TBD。

| 字段 | 内容 |
| --- | --- |
| filename | `20260606_final_integrated_0001_0007_demo.mp4` |
| external path | `D:\Edge Download\CSCC\proj54_submission_assets\videos` |
| size | `12,120,565 bytes` |
| duration | `00:01:32` |
| resolution | `2560x1440` |
| frame rate | `60 fps` |
| SHA256 | `0FF2D3581552B3FD3A2630E827251CF46C36BC3BE8F8B9D9DDB691FC0668A93B` |
| scope | final integrated `0001-0007` verification demo for commit `e8e2fb9` |

## Final Presentation Deliverable

| 字段 | 内容 |
| --- | --- |
| PPT source | `slides/final_ppt.md` |
| PPT generator | `slides/generate_final_ppt.py` |
| PPTX file | `slides/final_defense_ppt.pptx` |
| PPTX size | `63,695 bytes` |
| slide count | 16 |
| notes count | 16 speaker notes |
| media embedding | none detected in `ppt/media/` after generation |
| review status | requires final human review and rehearsal before defense |

PPTX 是提交展示材料，不是 raw verification evidence。它不嵌入视频、截图、summary 原件、console log 或隐私材料；最终视频仍按外部文件和 SHA256 管理。

## Historical Evidence

| 证据 | 范围 | 状态 |
| --- | --- | --- |
| old teammate summaries at `1ba9db6` | earlier integrated `0001-0005` / stage7-stage8 workflow | historical / superseded |
| `20260606_auto_verify_demo.mp4` | earlier integrated `0001-0005` / stage7-stage8 workflow | historical / superseded |
| `20260606_full_verify_demo.mp4` | earlier integrated `0001-0005` / stage7-stage8 workflow | historical / superseded |
| `20260606_manual_xv6_shell_demo.mp4` | earlier integrated `0001-0005` / stage7-stage8 workflow | historical / superseded |

这些 historical evidence 不覆盖最终 commit `e8e2fb9` 的 integrated `0001-0007`。

## External Evidence Directories

| 目录 | 内容 |
| --- | --- |
| `D:\Edge Download\CSCC\proj54_submission_assets\videos` | historical `0001-0007` checkpoint video 与更早 historical videos；覆盖 `0001-0009` 的新视频待录制后存放于此 |
| `D:\Edge Download\CSCC\proj54_submission_assets\teammate_reproduction\e8e2fb9_final_0001_0007` | historical stable checkpoint（`e8e2fb9 / 0001-0007`）teammate reproduction summary/log/screenshot evidence（目录名沿用当时命名） |
| `D:\Edge Download\CSCC\proj54_submission_assets\teammate_reproduction\historical_1ba9db6_0001_0005` | historical teammate evidence for earlier workflow |

## Non-Committed Evidence Policy

- Videos are not committed.
- Screenshots are not committed.
- Raw logs are not committed.
- Raw summary files are not committed.
- Git repository stores metadata and summaries only.
- `external/xv6-riscv/`, `logs/*.log`, `logs/*.summary.txt`, `logs/*.console.txt`, `.claude/`, `.vscode/`, videos, screenshots and large binary files must stay out of Git.

## Integrity Notes

- SHA256 hashes allow external file verification.
- No token/password/cookie should be included in final evidence files.
- Platform upload method still needs final confirmation.
- Privacy review status for videos/screenshots remains `pending final manual review` unless manually confirmed later.
- Final PPTX has been generated from a tracked Markdown source, but still requires final human review and rehearsal.
- timeout capture is evidence of expected-output matching, not long-running stability testing.
- `fcount()` / `fdcount()` are file table / fd table observation experiments, not a complete file system.
- Lab5 is a capstone reproduction experiment, not a new kernel mechanism.
