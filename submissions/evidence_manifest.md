# 证据清单（Evidence Manifest）

> 维护时间：2026-06-11，stage16 最终答辩 PPT 重做后同步。
> 本文件是最终提交证据索引，不保存原始证据文件。视频、截图、console log、summary 原件均保存在仓库外，Git 仓库只保存文字摘要、外部位置、文件大小和 SHA256。

## 记录目的

本文件用于让评委、队友和队长快速定位最终证据集，同时避免把原始视频、截图、summary、console log 等大文件或隐私材料提交进 Git。这里记录：

- 当前最终工程 commit 与 integrated suite 身份；
- 队长和两位队友的 full verification 摘要；
- 最终演示视频的元数据和 SHA256；
- 外部证据资产包位置；
- historical evidence 的边界；
- 不提交原始证据的仓库卫生策略。

## 当前最终证据：`db85947 / 0001-0009`

| 字段 | 内容 |
| --- | --- |
| 最终工程 commit | `db85947 feat(course): add lab runner and grading helpers` |
| 证据文档 commit | `caf8ced docs: record final db85947 evidence` |
| 当前 integrated suite | `0001-0009` |
| historical checkpoint | `e8e2fb9 / 0001-0007`，只作为历史证据 |
| final verification | `rain / root / z2996` full verification 全部 PASS |
| grade-summaries | 3 clean PASS, 0 needs attention |
| evidence SHA256 check | 14/14 matched |

## integrated 补丁序列映射

| 序列 | 内容 | syscall 编号 |
| --- | --- | --- |
| `0001-0007` | hello/add2/pstate/pcount/fcount/pgcount/fdcount | 22-28 |
| `0008` | Lab3 进阶 `memstat()`：通过 `argaddr + copyout + struct ABI` 观察地址空间统计 | `SYS_memstat = 29` |
| `0009` | Lab4 进阶 `fdinfo()`：通过 `argint + argaddr + copyout + struct ABI` 观察单个 fd 元数据 | `SYS_fdinfo = 30` |

边界：`memstat` 不是完整内存管理实现；`fdinfo` 不是完整文件系统实现；timeout 捕获只能说明复现脚本能匹配预期输出，不能写成长期稳定性测试。

## 当前最终验证摘要

| 角色 | user | mode | result | 外部证据 |
| --- | --- | --- | --- | --- |
| 队长本机验证 | `rain` | full | PASS | `teammate_reproduction/db85947_final_0001_0009/teamlead_rain_db85947_full_20260610-221236.summary.txt` |
| 队友 A | `root` | full | PASS | `teammate_reproduction/db85947_final_0001_0009/teammateA_root_db85947_full_20260611-080653.summary.txt` |
| 队友 B | `z2996` | full | PASS | `teammate_reproduction/db85947_final_0001_0009/teammateB_z2996_db85947_full_20260610-221859.summary.txt` |

current final full verification 覆盖以下检查项：

```text
doctor/check-env/baseline/apply+make/boot/hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest/pgcounttest/fdcounttest/memstattest/fdinfotest/overall
```

以上检查项均在外部 summary 中记录为 PASS。原始 summary 文件被 ignore，不提交到 Git。

## 当前最终证据哈希

| 证据文件 | SHA256 |
| --- | --- |
| `videos/20260611_final_integrated_0001_0009_demo.mp4` | `2A2C9863C185846225A98AC874499867A71588CED2020A64249CBF99C7BC0365` |
| `teammate_reproduction/db85947_final_0001_0009/teamlead_rain_db85947_full_20260610-221236.summary.txt` | `C0CBC292DD7C49E7016F4117871CC5F256D3554611E13DB5E8590020BB1DFD50` |
| `teammate_reproduction/db85947_final_0001_0009/teammateA_root_db85947_full_20260611-080653.summary.txt` | `8ED5BDE02B4B14DB94A12BE3C5EA29A76D933DB5649FB6335007BF0C291FFF87` |
| `teammate_reproduction/db85947_final_0001_0009/teammateA_root_db85947_full_20260611-081141.screenshot.jpg` | `86A57BED2A317CD3AB115676923FEFEC3422799793C7F233040B45C41675733C` |
| `teammate_reproduction/db85947_final_0001_0009/teammateB_z2996_db85947_full_20260610-221859.summary.txt` | `5F0973FB54B012C259F6A2E08F6C322F224E356EAFC4BB8A8F684474F941255E` |
| `teammate_reproduction/db85947_final_0001_0009/teammateB_z2996_db85947_full_20260610-222133.screenshot.png` | `E9AEF330994C496C2FD4A257596594732CBA3C0FCE2449C200187A9856FE6150` |

## 当前最终视频证据

| 字段 | 内容 |
| --- | --- |
| filename | `20260611_final_integrated_0001_0009_demo.mp4` |
| repository display path | `videos/20260611_final_integrated_0001_0009_demo.mp4` |
| external path | `D:\Edge Download\CSCC\proj54_submission_assets\videos` |
| size | `31,529,984 bytes` |
| duration | `00:03:12` |
| resolution | `2560×1440` |
| frame rate | `60 fps` |
| created | `2026-06-11 08:26:36` |
| modified | `2026-06-11 08:29:50` |
| SHA256 | `2A2C9863C185846225A98AC874499867A71588CED2020A64249CBF99C7BC0365` |
| scope | current final integrated `0001-0009` verification demo for commit `db85947` |

## 最终答辩 PPT 产物

| 字段 | 内容 |
| --- | --- |
| PPT source | `slides/final_ppt.md` |
| PPT outline | `slides/final_ppt_outline.md` |
| PPT generator | `slides/generate_final_ppt.ps1` |
| PPTX file | `slides/final_defense_ppt.pptx` |
| PPTX size | `114,409 bytes` |
| slide count | 16 |
| speaker notes count | 16 |
| media embedding | 生成后 `ppt/media/` 未检测到嵌入媒体 |
| review status | 答辩前仍需人工最终审阅和排练 |

PPTX 是答辩展示材料，不是原始验证证据。它只引用最终视频元数据和 SHA256，不嵌入视频、截图、summary、console log 或隐私材料。

## 外部证据资产包

| 字段 | 内容 |
| --- | --- |
| package directory | `proj54_submission_assets` |
| Baidu link | <https://pan.baidu.com/s/1Xt-G6VgP04eEAumqiMo7Uw?pwd=1234> |
| extraction code | `1234` |
| 下载后核验命令 | `XV6_EVIDENCE_BASE=<local path>/proj54_submission_assets bash scripts/check-evidence-sha256.sh` |

预期外部目录：

- `D:\Edge Download\CSCC\proj54_submission_assets\videos`
- `D:\Edge Download\CSCC\proj54_submission_assets\teammate_reproduction\db85947_final_0001_0009`
- `D:\Edge Download\CSCC\proj54_submission_assets\teammate_reproduction\e8e2fb9_final_0001_0007`
- `D:\Edge Download\CSCC\proj54_submission_assets\teammate_reproduction\historical_1ba9db6_0001_0005`

## 历史证据

### `e8e2fb9 / 0001-0007`

这是历史稳定检查点，已被 current final `db85947 / 0001-0009` 取代。

| 证据 | 状态 |
| --- | --- |
| 队长 `rain` full verify | 只覆盖 `e8e2fb9 / 0001-0007` |
| 队友 `root` full verify | 只覆盖 `e8e2fb9 / 0001-0007` |
| 队友 `z2996` full verify | 只覆盖 `e8e2fb9 / 0001-0007` |
| `20260606_final_integrated_0001_0007_demo.mp4` | 仅作为 historical video |

historical `0001-0007` 视频 SHA256：

```text
0FF2D3581552B3FD3A2630E827251CF46C36BC3BE8F8B9D9DDB691FC0668A93B
```

### 更早的 `1ba9db6 / 0001-0005` 证据

更早的队友记录和三段 `20260606_*` 视频只作为 earlier workflow 的历史证据保留，不覆盖 current final `db85947 / 0001-0009`。

## 不提交原始证据的边界

- 不提交视频本体。
- 不提交截图本体。
- 不提交 raw logs。
- 不提交 raw summary 文件。
- 不提交外部 xv6 源码。
- 不提交 `.claude/`、`.vscode/`、压缩包、私人截图、密码、token 或平台隐私材料。
- Git 仓库只保存元数据、摘要、Markdown 源稿、生成器代码和最终 PPTX。

## 剩余人工确认项

- 平台提交方式：待按官方要求确认。
- 视频和截图隐私复核：用户已人工确认 OK。
- 队友真实姓名和系统版本：不编造，如官方要求再补充。
- 最终 PPT 排练：答辩前仍需人工排练。
