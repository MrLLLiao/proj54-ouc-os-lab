#!/usr/bin/env bash
set -uo pipefail

out="submissions/draft-report-index.md"

# status_line <path> <label> <content-status>
# 文件存在性由脚本自动检测；内容状态为人工维护的真实进度标注。
status_line() {
  path="$1"
  label="$2"
  content="$3"
  if [ -e "$path" ]; then
    echo "| ${label} | \`${path}\` | 存在 | ${content} |"
  else
    echo "| ${label} | \`${path}\` | 缺失 | ${content} |"
  fi
}

mkdir -p submissions

{
  echo "# 初赛材料索引草案"
  echo
  echo "生成时间：TODO：由提交前人工补充"
  echo
  echo "本文件由 \`scripts/collect-report.sh\` 生成或更新，用于汇总当前仓库中已有的初赛材料路径与状态。"
  echo
  echo "注意：本文件不是最终技术报告，不生成 PDF，不包含报名材料、隐私信息或虚假运行结果。状态列含义见文末说明。"
  echo
  echo "## 材料索引"
  echo
  echo "| 材料 | 路径 | 文件 | 内容状态 |"
  echo "| --- | --- | --- | --- |"
  status_line "README.md" "项目首页" "已完成初版"
  status_line "docs/00_project_plan.md" "项目计划" "已完成初版"
  status_line "docs/01_requirement_analysis.md" "赛题要求与评分项拆解" "已完成初版"
  status_line "docs/02_lab_design.md" "实验体系设计" "已完成初版"
  status_line "docs/03_step_by_step_guide.md" "Step by Step 教程结构" "结构初版，正文待填写"
  status_line "docs/04_test_report.md" "测试报告模板" "模板待真实测试填写"
  status_line "docs/05_ai_usage_record.md" "AI 使用记录" "已完成初版"
  status_line "docs/06_progress_log.md" "进度记录" "已完成初版"
  status_line "docs/07_faq_and_issues.md" "FAQ 与 Issue 记录" "模板待真实问题填写"
  status_line "docs/08_reference_and_license.md" "参考资料与许可证" "已完成初版"
  status_line "docs/09_github_workflow.md" "GitHub 协作工作流" "已完成初版"
  status_line "docs/10_red_team_review.md" "内部红队审查报告" "已完成初版"
  status_line "docs/11_xv6_baseline_plan.md" "xv6 baseline 引入方案" "已完成初版（含真实环境检测）"
  status_line "labs/lab0-env-setup/README.md" "lab0 环境教程" "环境文档初版，真实工具链待验证"
  status_line "labs/lab1-system-call/README.md" "lab1 系统调用实验设计" "实验设计初版，待 baseline 引入后实现"
  status_line "labs/lab2-process-and-scheduling/README.md" "lab2 进程与调度" "计划中占位"
  status_line "labs/lab3-memory-and-pagetable/README.md" "lab3 页表与内存" "计划中占位"
  status_line "labs/lab4-file-system/README.md" "lab4 文件系统" "计划中占位"
  status_line "labs/lab5-final-integration/README.md" "lab5 最终集成" "计划中占位"
  status_line "tests/lab1/README.md" "lab1 测试计划" "计划初版，真实测试待补"
  status_line "tests/lab2/README.md" "lab2 测试计划" "计划初版"
  status_line "tests/lab3/README.md" "lab3 测试计划" "计划初版"
  status_line "tests/lab4/README.md" "lab4 测试计划" "计划初版"
  status_line "external/README.md" "第三方源码管理说明" "已完成初版，baseline 待引入"
  status_line "references/README.md" "参考资料目录说明" "占位，引用待补"
  status_line "slides/README.md" "PPT 说明" "TODO 占位"
  status_line "videos/README.md" "Demo 视频说明" "TODO 占位"
  echo "| 最终提交 | \`submissions/\` | - | TODO：待对照官方要求整理 |"
  echo
  echo "## 状态列说明"
  echo
  echo "- 文件：由脚本检测路径是否存在（存在/缺失），不代表内容质量。"
  echo "- 内容状态：人工维护的真实进度标注，取值如「已完成初版 / 模板待填写 / 设计初版 / 计划中占位 / 待真实验证」。"
  echo "- 本索引为草案，非最终版；任何「待真实验证」的材料在真实执行前不得标注为完成。"
  echo
  echo "## 待补充"
  echo
  echo "- TODO：技术报告正文。"
  echo "- TODO：PPT。"
  echo "- TODO：Demo 视频或视频说明。"
  echo "- TODO：真实测试报告和命令输出。"
  echo "- TODO：最终提交前人工复核清单。"
} > "$out"

echo "[OK] report index updated: ${out}"
echo "No PDF or final report was generated."
