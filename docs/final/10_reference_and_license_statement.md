# 10 Reference and License Statement

## xv6-riscv baseline

| 字段 | 内容 |
| --- | --- |
| 上游仓库 | `https://github.com/mit-pdos/xv6-riscv.git` |
| baseline commit | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| 本地路径 | `external/xv6-riscv/` |
| metadata | `external/xv6-baseline-record.md` |
| LICENSE | MIT License（已从本地 `external/xv6-riscv/LICENSE` 核对） |

`external/xv6-riscv/` 不入库。本仓库只提交自有文档、脚本、patch、测试摘要和 metadata。

## xv6 MIT License 边界

xv6-riscv 上游 LICENSE 为 MIT License。项目使用 xv6 作为教学 OS baseline，并通过 patch 展示增量修改。提交材料应保留上游来源、baseline commit 和 LICENSE 说明，不应声称拥有 xv6 上游源码版权。

本仓库不复制完整上游源码；如最终提交包需要包含 patch，应说明 patch 是基于上述 baseline 生成的增量。

## 参考项目

以下项目可作为课程组织、实验结构和竞赛材料展示参考。正式报告/PPT 中使用时必须补充具体 URL、许可证和引用位置。

| 参考 | 用途 | 当前状态 |
| --- | --- | --- |
| uCore Tutorial / uCore OS Lab | 分阶段 OS 实验组织参考 | URL/许可证待核对 |
| rCore Tutorial | 教程结构、实验章节化参考 | URL/许可证待核对 |
| YatSen OS | 往届/同类课程 OS 材料展示参考 | URL/许可证待核对 |
| F-Tutorials | tutorial 组织和教学表达参考 | URL/许可证待核对 |
| 往届 OS 竞赛资料 | 提交材料结构、评审关注点参考 | URL/许可证待核对 |

当前 `docs/final/` 中只做定位性对比，不复制上述项目的大段文本、代码或图片。

## 待核对清单

最终技术报告/PPT 引用前必须逐项核对 URL、许可证和引用位置，不要在未核对时补造链接：

- uCore Tutorial / uCore OS Lab。
- rCore Tutorial。
- YatSen OS。
- F-Tutorials。
- xv6-riscv MIT License。
- 往届 OS 竞赛作品仓库。

当前已确认项：xv6-riscv 是本项目上游 baseline，baseline commit 为 `74f84181a3404d1d6a6ff98d342233979066ebb8`，LICENSE 为 MIT License，`external/xv6-riscv/` 不入仓。

## 本队增量贡献

- `patches/lab1-system-call/`：hello/add2 syscall 教学 patch。
- `patches/lab2-process-observation/`：pstate independent patch。
- `patches/lab4-file-table-observation/`：fcount independent patch。
- `patches/integrated-labs/0001-0005`：统一 syscall number 的综合 patch sequence。
- `scripts/xv6/`：fetch/check/apply/boot/run/doctor/local/teammate/cleanup 工具链。
- `docs/final/`：面向提交和评委阅读的正式文档入口。
- OUC 本校课程叙事、一键验证、队友复现流程、测试覆盖表和诚信边界说明。

## 禁止事项

- 不把第三方源码写成自有源码。
- 不提交 `external/xv6-riscv/`。
- 不复制大段外部教程或论文。
- 不在未核对许可证的情况下使用外部图片、PPT、视频或代码。
- 不把参考项目对比写成已完成的功能来源。
