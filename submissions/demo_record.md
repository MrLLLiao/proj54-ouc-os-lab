# 演示视频记录

> 维护时间：2026-06-11，stage16 最终答辩 PPT 重做后同步。
> 本文件只记录视频元数据、外部位置、SHA256 和提交边界，不保存视频文件本体。

## 当前状态

| 项目 | 状态 |
| --- | --- |
| 当前 integrated suite | `0001-0009` |
| 最终工程 commit | `db85947 feat(course): add lab runner and grading helpers` |
| 证据文档 commit | `caf8ced docs: record final db85947 evidence` |
| 当前最终视频 | 已录制：`20260611_final_integrated_0001_0009_demo.mp4` |
| 外部证据资产包 | `proj54_submission_assets` |
| 视频文件是否被 Git 跟踪 | 否 |
| 隐私复核 | 视频和截图已由用户人工确认 OK |
| 平台提交方式 | 待按比赛平台要求确认 |

## 当前最终视频：`db85947` / integrated `0001-0009`

| 字段 | 内容 |
| --- | --- |
| 文件名 | `20260611_final_integrated_0001_0009_demo.mp4` |
| 仓库展示路径 | `videos/20260611_final_integrated_0001_0009_demo.mp4` |
| 外部路径 | `D:\Edge Download\CSCC\proj54_submission_assets\videos` |
| 大小 | `31,529,984 bytes` |
| 时长 | `00:03:12` |
| 分辨率 | `2560×1440` |
| 帧率 | `60 fps` |
| 创建时间 | `2026-06-11 08:26:36` |
| 修改时间 | `2026-06-11 08:29:50` |
| SHA256 | `2A2C9863C185846225A98AC874499867A71588CED2020A64249CBF99C7BC0365` |
| 覆盖范围 | current final integrated `0001-0009` verification demo for commit `db85947` |
| Git 策略 | 视频文件存放在 Git 仓库外，不提交 |
| 哈希核验 | `bash scripts/check-evidence-sha256.sh` 在最终证据集中报告 `14/14 matched` |

## 外部证据资产包

| 字段 | 内容 |
| --- | --- |
| 目录名 | `proj54_submission_assets` |
| 百度网盘链接 | <https://pan.baidu.com/s/1Xt-G6VgP04eEAumqiMo7Uw?pwd=1234> |
| 提取码 | `1234` |
| 预期内容 | 最终视频、队友复现 summary/截图、historical evidence 文件 |
| 仓库策略 | Git 仓库只记录元数据和 SHA256 |

## 历史视频：`e8e2fb9` / integrated `0001-0007`

这段视频是 historical stable checkpoint，只覆盖 `e8e2fb9 / 0001-0007`，不覆盖 current final `db85947 / 0001-0009`。

| 字段 | 内容 |
| --- | --- |
| 文件名 | `20260606_final_integrated_0001_0007_demo.mp4` |
| 外部路径 | `D:\Edge Download\CSCC\proj54_submission_assets\videos` |
| 大小 | `12,120,565 bytes` |
| 时长 | `00:01:32` |
| 分辨率 | `2560x1440` |
| 帧率 | `60 fps` |
| 创建时间 | `2026-06-07 07:59:04` |
| 修改时间 | `2026-06-07 08:00:37` |
| SHA256 | `0FF2D3581552B3FD3A2630E827251CF46C36BC3BE8F8B9D9DDB691FC0668A93B` |
| 覆盖范围 | integrated `0001-0007` verification demo for commit `e8e2fb9` |

## 更早的历史视频

以下视频只覆盖 earlier `0001-0005` 或 stage7-stage8 workflow，保留为 historical evidence，不覆盖 `db85947 / 0001-0009`。

| 文件名 | 用途 | 大小 | 时长 | 分辨率 | 帧率 | SHA256 |
| --- | --- | ---: | --- | --- | --- | --- |
| `20260606_auto_verify_demo.mp4` | historical 自动验证 demo | `13,355,208 bytes` | `00:01:48` | `2560x1440` | `60 fps` | `8EBC5974364780076172B19C9272B860DC56BF66DE9D08D5ECC8D20C8A236088` |
| `20260606_full_verify_demo.mp4` | historical full verify demo | `10,726,170 bytes` | `00:01:23` | `2560x1440` | `60 fps` | `1963B9FD66E6A25E9EADAA3C81FFC35E360F9D699F2C7CF6C707E85680B1EFE5` |
| `20260606_manual_xv6_shell_demo.mp4` | historical 手动 xv6 shell demo | `15,537,988 bytes` | `00:01:57` | `2560x1440` | `60 fps` | `2CD5DE43D3C262AB26A2A4251AE991ED973FA6A04FA8FD0B0178789563F5EE0B` |

## 合规边界

- 不提交 `.mp4`、截图、raw logs、raw summaries、压缩包或大体积二进制证据文件。
- `slides/final_defense_ppt.pptx` 不嵌入最终视频，只引用文件名、外部资产包和 SHA256。
- 视频和截图隐私复核已由用户人工确认 OK；平台提交方式仍需最终确认。
- `fcount()` / `fdcount()` / `fdinfo()` 是 file table / fd table 观察实验，不是完整文件系统。
- timeout 捕获只能证明复现脚本匹配预期输出并能清理 QEMU；不能写成长期稳定性测试。
