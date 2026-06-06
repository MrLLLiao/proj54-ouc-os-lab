# Demo Video Record

> 维护时间：2026-06-06（stage8b）。
> 本文件只记录视频元数据和提交状态，不保存视频文件。

## 当前状态

| 项目 | 状态 |
| --- | --- |
| 已录制视频数量 | 3 段 |
| 视频文件是否入库 | 不入库 |
| 视频外部保存位置 | `D:\Edge Download\CSCC\proj54_submission_assets\videos` |
| 比赛平台提交方式 | 待确认 |
| 是否含隐私/密码/token | 需人工复核确认 |

## 视频清单

| 文件名 | 用途 | 文件大小 | 时长 | Git 状态 |
| --- | --- | ---: | --- | --- |
| `20260606_auto_verify_demo.mp4` | 自动化验证流程演示 | about 13,043 KB | 待补充 | 不提交 Git |
| `20260606_full_verify_demo.mp4` | full verification 演示 | about 10,475 KB | 待补充 | 不提交 Git |
| `20260606_manual_xv6_shell_demo.mp4` | 人工 xv6 shell 交互演示 | about 15,174 KB | 待补充 | 不提交 Git |

## 提交说明

- 视频文件位于仓库外：`D:\Edge Download\CSCC\proj54_submission_assets\videos`。
- 本仓库只记录视频文件名、用途、大小和待补项，不提交 `.mp4` 本体。
- 平台提交方式仍需按比赛官方要求确认。
- 最终上传前必须人工检查视频画面中没有 token、password、cookie、报名材料、私人聊天、未公开账号或其他隐私信息。

## 合规边界

- 不提交 `.mp4`、`.mov`、`.avi`、`.mkv` 等视频文件到 Git。
- 不提交截图、压缩包或大型二进制文件到 Git。
- 视频中展示的运行结果必须来自真实命令，不用录屏替代脚本验证，也不用 timeout 自动捕获替代人工 shell demo。
- `fcount()` 只展示文件表引用计数观察，不描述为完整文件系统实验。
- timeout/fast-exit 只说明复现脚本能捕获预期输出并退出，不描述为长期稳定性测试。
