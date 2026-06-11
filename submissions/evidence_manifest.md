# Evidence Manifest

> 维护时间：2026-06-11（stage14 record final db85947 evidence）。
> 本文件是最终证据索引，不保存原始证据文件。
> 读者定位：这是**评委/提交材料**入口。如果你是来学实验的，请从根 [README.md](../README.md) 开始，不需要读本文件。

## Manifest Purpose

本 manifest 集中记录最终提交证据的文字摘要、外部文件位置、文件大小、时间和 SHA256。它不是 raw evidence storage；视频、截图、console log、summary 原件仍保存在仓库外，不提交 Git。

## Current Final Evidence（stage14）：`db85947 / 0001-0009` — 已完成

> current final commit 为 `db85947 feat(course): add lab runner and grading helpers`，current integrated suite 为 `0001-0009`。rain/root/z2996 三方 `teammate-verify.sh --full` 复现与新演示视频均已**真实完成**并登记如下；外部文件哈希可用 `bash scripts/check-evidence-sha256.sh` 一键核验（本轮实测 14/14 matched，含全部 historical 文件）。旧 `e8e2fb9 / 0001-0007` 证据仍为 historical stable checkpoint（见下方），不作为 current final。

| 序列 | 内容 | syscall |
| --- | --- | --- |
| `0001-0007` | hello/add2/pstate/pcount/fcount/pgcount/fdcount | 22-28 |
| `0008` | Lab3 advanced `memstat()` 地址空间观察（argaddr + copyout + struct ABI） | `SYS_memstat = 29` |
| `0009` | Lab4 advanced `fdinfo()` fd 元数据观察（argint + argaddr + copyout + struct ABI） | `SYS_fdinfo = 30` |

| 字段 | 内容 |
| --- | --- |
| current final commit | `db85947 feat(course): add lab runner and grading helpers` |
| lead `rain` full verify | **PASS**（summary：`teamlead_rain_db85947_full_20260610-221236.summary.txt`，SHA256 `C0CBC292DD7C49E7016F4117871CC5F256D3554611E13DB5E8590020BB1DFD50`） |
| teammate `root` full verify | **PASS**（summary：`teammateA_root_db85947_full_20260611-080653.summary.txt`，SHA256 `8ED5BDE02B4B14DB94A12BE3C5EA29A76D933DB5649FB6335007BF0C291FFF87`；screenshot：`teammateA_root_db85947_full_20260611-081141.screenshot.jpg`，SHA256 `86A57BED2A317CD3AB115676923FEFEC3422799793C7F233040B45C41675733C`） |
| teammate `z2996` full verify | **PASS**（summary：`teammateB_z2996_db85947_full_20260610-221859.summary.txt`，SHA256 `5F0973FB54B012C259F6A2E08F6C322F224E356EAFC4BB8A8F684474F941255E`；screenshot：`teammateB_z2996_db85947_full_20260610-222133.screenshot.png`，SHA256 `E9AEF330994C496C2FD4A257596594732CBA3C0FCE2449C200187A9856FE6150`） |
| grade-summaries 汇总 | `bash scripts/grade-summaries.sh --expect-commit db85947 logs/student-summaries`：parsed 3 / clean PASS 3 / needs attention 0（`GRADE_SUMMARIES_RESULT: OK`） |
| new final video | `20260611_final_integrated_0001_0009_demo.mp4`（31,529,984 bytes，created 2026-06-11 08:26:36，modified 2026-06-11 08:29:50） |
| new final video SHA256 | `2A2C9863C185846225A98AC874499867A71588CED2020A64249CBF99C7BC0365` |

三方 summary 文件位于外部目录 `teammate_reproduction\db85947_final_0001_0009\`，原始文件不入 Git。边界不变：`memstat` 不是完整内存管理，`fdinfo` 不是完整文件系统，timeout 捕获不是长期稳定性测试。

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

> 该视频只演示 `0001-0007`，**不覆盖** `0001-0009`；current final 视频见上方 stage14 表（`20260611_final_integrated_0001_0009_demo.mp4`）。

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

## External Asset Package（百度网盘）

外部证据资产已整体上传百度网盘，目录名 `proj54_submission_assets`：

| 字段 | 内容 |
| --- | --- |
| 链接 | <https://pan.baidu.com/s/1Xt-G6VgP04eEAumqiMo7Uw?pwd=1234> |
| 提取码 | `1234` |
| 包含 | current final `0001-0009` demo video（`20260611_final_integrated_0001_0009_demo.mp4`）；`db85947_final_0001_0009` 三方复现 summaries/screenshots；historical `e8e2fb9_final_0001_0007` 证据；更早的 historical videos 及相关 notes/截图等外部资产 |
| Git 边界 | 所有大文件本体不进入 Git 仓库，仓库只保存元数据与 SHA256 |
| 核验方式 | 下载后 `XV6_EVIDENCE_BASE=<本地路径> bash scripts/check-evidence-sha256.sh`；哈希以本 manifest 与该脚本为准，网盘链接只是文件载体，不是证据索引 |

## External Evidence Directories

| 目录 | 内容 |
| --- | --- |
| `D:\Edge Download\CSCC\proj54_submission_assets\videos` | current final `0001-0009` 视频（`20260611_final_integrated_0001_0009_demo.mp4`）、historical `0001-0007` checkpoint video 与更早 historical videos |
| `D:\Edge Download\CSCC\proj54_submission_assets\teammate_reproduction\db85947_final_0001_0009` | current final（`db85947 / 0001-0009`）三方复现 summary/screenshot evidence |
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
