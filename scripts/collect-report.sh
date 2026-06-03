#!/usr/bin/env bash
set -uo pipefail

out="submissions/draft-report-index.md"

status_line() {
  path="$1"
  label="$2"
  if [ -e "$path" ]; then
    echo "| ${label} | \`${path}\` | exists | |"
  else
    echo "| ${label} | \`${path}\` | TODO | missing or not generated yet |"
  fi
}

mkdir -p submissions

{
  echo "# 初赛材料索引草案"
  echo
  echo "生成时间：TODO：由提交前人工补充"
  echo
  echo "本文件由 \`scripts/collect-report.sh\` 生成或更新，用于汇总当前仓库中已有的初赛材料路径。"
  echo
  echo "注意：本文件不是最终技术报告，不生成 PDF，不包含报名材料、隐私信息或虚假运行结果。"
  echo
  echo "## 材料索引"
  echo
  echo "| 材料 | 路径 | 状态 | 备注 |"
  echo "| --- | --- | --- | --- |"
  status_line "README.md" "项目首页"
  status_line "docs/00_project_plan.md" "项目计划"
  status_line "docs/01_requirement_analysis.md" "赛题要求与评分项拆解"
  status_line "docs/02_lab_design.md" "实验体系设计"
  status_line "docs/03_step_by_step_guide.md" "Step by Step 教程结构"
  status_line "docs/04_test_report.md" "测试报告模板"
  status_line "docs/05_ai_usage_record.md" "AI 使用记录"
  status_line "docs/06_progress_log.md" "进度记录"
  status_line "docs/08_reference_and_license.md" "参考资料与许可证"
  status_line "docs/09_github_workflow.md" "GitHub 协作工作流"
  status_line "labs/lab0-env-setup/README.md" "lab0 环境教程"
  status_line "labs/lab1-system-call/README.md" "lab1 系统调用实验设计"
  status_line "tests/lab1/README.md" "lab1 测试计划"
  status_line "tests/lab2/README.md" "lab2 测试计划"
  status_line "tests/lab3/README.md" "lab3 测试计划"
  status_line "tests/lab4/README.md" "lab4 测试计划"
  status_line "references/README.md" "参考资料目录说明"
  status_line "slides/README.md" "PPT TODO"
  status_line "videos/README.md" "Demo 视频 TODO"
  echo "| 最终提交 | \`submissions/\` | TODO | 待对照官方要求整理 |"
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
