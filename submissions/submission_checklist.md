# Submission Checklist

> 维护时间：2026-06-06（stage8b reproduction evidence record）。
> 本 checklist 面向最终提交前自查，不包含报名信息、个人隐私、token、视频文件或大文件。

## 1. 平台提交合规

| 检查项 | 状态 | 说明 |
| --- | --- | --- |
| 官方主仓库 | 待最终确认 | 最终以比赛 GitLab / 平台要求为准，不修改 remote |
| GitHub 使用边界 | 已说明 | GitHub 仅作私有备份/协作，不作为最终提交平台 |
| 报名材料 | 禁止入库 | 姓名、学号、手机号、身份证等不进 Git |
| 视频文件 | 禁止入库 | 已录制 3 段，文件名/外部位置/约略大小已记录到 `submissions/demo_record.md`；时长和提交方式待补充 |
| 大文件/压缩包 | 禁止入库 | `.mp4/.mov/.zip/.7z/.rar` 等均禁止提交 |

## 2. Git 仓库卫生

| 检查项 | 期望 |
| --- | --- |
| `external/xv6-riscv/` | ignored，不被 `git ls-files` 跟踪 |
| `logs/*.log` | ignored，不被跟踪 |
| `logs/*.summary.txt` | ignored，不被跟踪 |
| `.claude/`、`.vscode/` | ignored，不被跟踪 |
| integrated patches | `patches/integrated-labs/0001-0005` 不在 stage8a 修改 |
| remote | 不修改 GitLab/GitHub remote |

## 3. 工程复现

| 项目 | 命令 | 当前状态 |
| --- | --- | --- |
| 环境诊断 | `bash scripts/xv6/doctor.sh` | PASS；可能有可接受 WARN |
| clean apply + make | `bash scripts/xv6/apply-integrated-labs.sh --make --yes` | PASS |
| boot evidence | `bash scripts/xv6/boot-xv6.sh` | PASS |
| 一键 full 验证 | `bash scripts/xv6/teammate-verify.sh --full` | 队长本机 PASS；已收到 2 份队友 full PASS summary |
| 本地录屏前预检 | `bash scripts/xv6/local-verify.sh --quick` | 队长本机 PASS |
| QEMU cleanup | `bash scripts/xv6/cleanup-qemu.sh` | 可用 |

## 4. 文档材料

| 文档 | 路径 | 状态 |
| --- | --- | --- |
| 评委入口 README | `README.md` | stage8a 已重构 |
| 正式文档入口 | `docs/final/` | stage8a 已新增正式初版 |
| 测试覆盖表 | `docs/final/06_testing_and_verification.md` | 已包含 doctor/baseline/boot/用户程序/local/teammate/manual demo |
| AI 使用声明 | `docs/final/09_ai_usage_and_contribution_statement.md` | 已补充 |
| 引用与许可证声明 | `docs/final/10_reference_and_license_statement.md` | 已补充 xv6 MIT 与参考项目待核对项 |
| 已知限制 | `docs/final/11_known_limits_and_future_work.md` | 已补充 |
| 材料索引 | `submissions/draft-report-index.md` | 由 `scripts/collect-report.sh` 生成 |
| docs 导引 | `docs/README.md` | 已说明正式文档与过程文档边界 |
| 队友复现记录 | `submissions/teammate_reproduction_record.md` | 已记录 2 份队友 full PASS summary 的文字摘要 |

## 5. 视频记录

| 检查项 | 状态 |
| --- | --- |
| 已录制 3 段视频 | 已记录 |
| 视频文件不入库 | 必须保持 |
| 视频文件名 | 已记录 |
| 视频时长 | 待补充 |
| 外部存放位置 | 已记录 |
| 平台提交方式 | 待补充 |
| 隐私/token/密码检查 | 待人工复核 |

记录文件：`submissions/demo_record.md`。

## 6. 队友复现

| 检查项 | 状态 |
| --- | --- |
| 队友使用命令 | `bash scripts/xv6/teammate-verify.sh --full` |
| copy-to-lead summary | 已收到 2 份 full PASS summary；原始 logs/summary/截图不入仓 |
| 失败时 cleanup 流程 | `bash scripts/xv6/cleanup-qemu.sh` |
| 是否伪造队友结果 | 禁止；未知姓名/系统版本保持待补充 |

记录文件：`submissions/teammate_reproduction_record.md`。

## 7. 红队审核

提交前至少检查：

- README 是否是评委入口，而不是开发流水账。
- `docs/final/` 是否覆盖项目概述、环境、每个 lab、测试、队友复现、设计取舍、AI、许可证、限制。
- 是否仍把 timeout 捕获夸大成长期稳定性。
- 是否把 fcount 夸大成完整文件系统。
- 是否把本机验证写成队友复现。
- 是否存在 external/logs/.claude/video/隐私材料入库风险。

## 8. 最终提交前命令

```bash
bash scripts/collect-report.sh
git diff --check
git status --short
git status --ignored --short external logs .claude
git ls-files external/xv6-riscv
git ls-files logs/*.log
git ls-files logs/*.summary.txt
git ls-files logs/*.console.txt
git ls-files .claude
git ls-files | grep -Ei '\.(mp4|mov|avi|mkv|zip|7z|rar)$' || true
```

如需重新验证工程：

```bash
bash scripts/xv6/doctor.sh
bash scripts/xv6/teammate-verify.sh --full
```

## 9. 当前剩余待补充

- 队友真实姓名、系统版本和队友 B 精确 summary 文件冲突（如最终材料需要）。
- 三段视频的时长、平台提交方式和最终隐私复核结论。
- 技术报告 v1.0。
- PPT。
- uCore/rCore/YatSen OS/F-Tutorials/往届资料的最终 URL 与许可证核对。

## 10. 结论

当前工程功能、验证链、两份队友 full PASS 摘要和视频元数据已经形成提交证据基础。冲奖前仍必须补齐技术报告 v1.0、PPT、视频时长/平台提交方式、引用 URL/许可证核对和最终红队审核。
