#!/usr/bin/env bash
set -uo pipefail

out="submissions/draft-report-index.md"

status_line() {
  path="$1"
  label="$2"
  content="$3"
  if [ -e "$path" ]; then
    echo "| ${label} | \`${path}\` | exists | ${content} |"
  else
    echo "| ${label} | \`${path}\` | missing | ${content} |"
  fi
}

baseline_record_status() {
  path="external/xv6-baseline-record.md"
  if [ -e "$path" ]; then
    echo "| xv6 baseline metadata | \`${path}\` | exists | metadata generated; records make success and boot evidence; manual interaction TODO |"
  else
    echo "| xv6 baseline metadata | \`${path}\` | missing | TODO: run \`bash scripts/xv6/fetch-xv6.sh --run\` after authorization |"
  fi
}

mkdir -p submissions

{
  echo "# Initial Submission Material Index Draft"
  echo
  echo "Generated time: TODO: fill manually before final submission"
  echo
  echo "This file is generated or updated by \`scripts/collect-report.sh\`."
  echo "It is not the final technical report, does not generate PDF, and does not include registration materials, private data, or fabricated results."
  echo
  echo "## Material Index"
  echo
  echo "| Material | Path | File | Content status |"
  echo "| --- | --- | --- | --- |"
  status_line "README.md" "Project homepage" "MVP draft"
  status_line "docs/00_project_plan.md" "Project plan" "MVP draft"
  status_line "docs/01_requirement_analysis.md" "Requirement and scoring analysis" "MVP draft"
  status_line "docs/02_lab_design.md" "Lab system design" "MVP draft"
  status_line "docs/03_step_by_step_guide.md" "Step-by-step guide outline" "outline draft"
  status_line "docs/04_test_report.md" "Test report" "includes real baseline make, hardened boot evidence retry, lab1/lab2/lab4 outputs, integrated 0001-0005 evidence, and lab2 v0.2 outputs"
  status_line "docs/05_ai_usage_record.md" "AI usage record" "active record"
  status_line "docs/06_progress_log.md" "Progress log" "active record"
  status_line "docs/07_faq_and_issues.md" "FAQ and issue record" "template"
  status_line "docs/08_reference_and_license.md" "Reference and license record" "active record"
  status_line "docs/09_github_workflow.md" "GitHub workflow" "workflow draft"
  status_line "docs/10_red_team_review.md" "Internal red-team review" "draft"
  status_line "docs/11_xv6_baseline_plan.md" "xv6 baseline plan" "stage1b plan"
  status_line "docs/12_lab1_patch_review.md" "lab1 patch reproducibility review" "stage2b red-team; clean-baseline apply/make/hello verified"
  status_line "docs/14_lab1_argint_extension_review.md" "lab1 argint extension review" "stage3b red-team: 0001+0002 reproduced (make/hello/add2); add2 call chain, argint mechanism, teaching-value assessment"
  status_line "docs/15_lab2_process_observation_review.md" "lab2 process observation review" "stage4b red-team: clean-baseline apply/make/pstatetest verified; teaching limits + lab1/lab2 conflict measured"
  status_line "docs/16_patch_strategy_and_integration_plan.md" "patch strategy and integration plan" "stage4b conflict measured; stage4c integrated-labs sequence built and verified"
  status_line "docs/17_integrated_labs_review.md" "integrated-labs review" "stage4d red-team plus stage6a update: 0001-0005 reproduced; hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest in one build"
  status_line "docs/18_integrated_helper_review.md" "integrated apply helper safety review" "stage4f red-team plus stage6a update: preview safe; --run/--make always require --yes; --make --yes applies 0001-0005"
  status_line "docs/19_lab2_v0.2_process_observation_review.md" "lab2 v0.2 process observation review" "stage5a + stage5b red-team: pcount/pcounttest/pchildtest and negative input; integrated 0001-0004 re-reproduced from clean baseline; 0004 patch unchanged; lock/snapshot analysis and benign usys.pl mode warning documented"
  status_line "docs/20_lab4_file_table_observation_review.md" "lab4 file table observation review" "stage6a + stage6b red-team: fcount/fcounttest; independent lab4 patch and integrated 0005 re-reproduced from clean baseline; both patches unchanged; filecount lock/deadlock/no-leak analysis; sys_fcount in sysfile.c; open/close +1/-1 delta; fcount numbers non-fixed"
  status_line "docs/21_submission_readiness_review.md" "submission readiness review" "stage6d red-team: full integrated 0001-0005 reproduced from clean baseline (make/boot x2/hello/add2test/pstatetest/pcounttest+negative/pchildtest/fcounttest); doc consistency audit; risk list and pre-submission must-do (teammate reproduction + manual recording still TODO)"
  status_line "docs/22_teammate_reproduction_troubleshooting.md" "teammate reproduction troubleshooting" "stage7a0: explains apply/make completion, boot normal duration, Ctrl+Z risk, qemu/make cleanup, continuation steps, feedback format, and no-log/no-secret boundaries"
  status_line "docs/23_teammate_quickstart.md" "teammate quickstart" "stage7a2: official teammate testing entry; --full first run, --quick retest after make, local-verify before recording, cleanup-qemu after stuck/Ctrl+Z, summary feedback, no external/logs/secrets"
  status_line "submissions/submission_checklist.md" "submission checklist" "stage7a2 pre-submission checklist: completion status, must-fill items, doctor/full/quick/local workflows, forbidden items, pre-submit commands, and honest-MVP conclusion"
  status_line "docs/13_technical_report_v0.1.md" "Technical report v0.1" "stage2c draft; not final report"
  status_line "reproducibility/README.md" "Reproducibility package" "lab0/lab1/lab2/integrated-labs reproduction checklist and template"
  status_line "labs/lab0-env-setup/README.md" "lab0 environment guide" "xv6 baseline make succeeded; boot evidence found; manual interaction TODO"
  status_line "labs/lab1-system-call/README.md" "lab1 syscall lab" "hello minimal and add2 argint patches generated and verified"
  status_line "labs/lab2-process-and-scheduling/README.md" "lab2 process state observation" "pstate independent patch verified; integrated v0.2 adds pcount, pcounttest, pchildtest"
  status_line "labs/lab3-memory-and-pagetable/README.md" "lab3 memory and pagetable" "planned"
  status_line "labs/lab4-file-system/README.md" "lab4 file system" "file table observation v0.1: fcount/fcounttest verified; not a complete file system lab"
  status_line "labs/lab5-final-integration/README.md" "lab5 final integration" "planned"
  status_line "tests/lab1/README.md" "lab1 test record" "records patched make and hello output evidence"
  status_line "tests/lab2/README.md" "lab2 test record" "records pstatetest, pcounttest, and pchildtest output evidence"
  status_line "tests/lab3/README.md" "lab3 test plan" "draft"
  status_line "tests/lab4/README.md" "lab4 test record" "records fcounttest prefix capture and non-fixed count boundary"
  status_line "scripts/xv6/fetch-xv6.sh" "xv6 fetch script" "stage1b tooling"
  status_line "scripts/xv6/check-xv6-baseline.sh" "xv6 baseline check script" "stage1b tooling; make not run by default"
  status_line "scripts/xv6/boot-xv6.sh" "xv6 boot evidence script" "captures boot keywords under soft+hard timeout; default 45s soft, max(timeout+15,75)s hard, 2 attempts, per-attempt logs, trap cleanup"
  status_line "scripts/xv6/run-xv6-command.sh" "xv6 command evidence script" "captures user program output under soft+hard timeout; default 60s soft, max(timeout+15,75)s hard, 2 attempts, fs.img prebuild, trap cleanup"
  status_line "scripts/xv6/apply-lab1-patch.sh" "lab1 patch apply helper" "preview by default; --run resets clean baseline and applies; --make optional"
  status_line "scripts/xv6/apply-integrated-labs.sh" "integrated labs apply helper" "preview by default; --run/--make always require --yes (reset/clean ignored tree); make has XV6_MAKE_TIMEOUT_SECONDS; make logs ignored"
  status_line "scripts/xv6/doctor.sh" "xv6 doctor script" "stage7a2 read-only environment diagnosis: time/cwd/uname/commit, Git repo, tools, baseline files, logs ignored, QEMU leftovers, /mnt warning; no make or QEMU run"
  status_line "scripts/xv6/cleanup-qemu.sh" "xv6 QEMU cleanup helper" "stage7a2 rescue tool: explains Ctrl+C interrupt vs Ctrl+Z suspend, lists qemu/make qemu processes before/after, warns pkill may affect same-WSL QEMU, exits 0"
  status_line "scripts/xv6/teammate-verify.sh" "teammate one-shot verification" "stage7a2 workflow: --full clean apply+make and --quick retest; doctor/check-env/baseline, boot, hello/add2/pstate/pcount/pchild/fcount verification, copy-to-lead summary in ignored logs"
  status_line "scripts/xv6/local-verify.sh" "local pre-recording verification" "stage7a2 team-lead wrapper around teammate-verify; --full/--quick; recommended --quick before recording"
  status_line "patches/lab1-system-call/0001-add-hello-syscall.patch" "lab1 hello syscall patch" "tracked patch; third-party source not submitted"
  status_line "patches/lab1-system-call/0002-add-argint-add2-syscall.patch" "lab1 add2 argint syscall patch" "commit-ready incremental patch after 0001"
  status_line "patches/lab1-system-call/README.md" "lab1 patch guide" "apply/build/run instructions"
  status_line "patches/lab2-process-observation/0001-add-pstate-syscall.patch" "lab2 pstate syscall patch" "commit-ready independent patch from clean baseline"
  status_line "patches/lab2-process-observation/README.md" "lab2 patch guide" "apply/build/run instructions"
  status_line "patches/lab4-file-table-observation/0001-add-fcount-syscall.patch" "lab4 fcount syscall patch" "commit-ready independent patch from clean baseline"
  status_line "patches/lab4-file-table-observation/README.md" "lab4 patch guide" "apply/build/run instructions"
  status_line "patches/integrated-labs/0001-add-hello-syscall.patch" "integrated hello syscall patch" "comprehensive demo sequence step 1"
  status_line "patches/integrated-labs/0002-add-argint-add2-syscall.patch" "integrated add2 argint syscall patch" "comprehensive demo sequence step 2"
  status_line "patches/integrated-labs/0003-add-pstate-syscall.patch" "integrated pstate syscall patch" "comprehensive demo sequence step 3; uses SYS_pstate 24"
  status_line "patches/integrated-labs/0004-extend-process-observation.patch" "integrated lab2 v0.2 process observation patch" "comprehensive demo sequence step 4; adds SYS_pcount 25, pcounttest, pchildtest"
  status_line "patches/integrated-labs/0005-add-file-table-observation.patch" "integrated lab4 file table observation patch" "comprehensive demo sequence step 5; adds SYS_fcount 26 and fcounttest"
  status_line "patches/integrated-labs/README.md" "integrated patch guide" "apply/build/run instructions for combined lab1+lab2+lab4 demo"
  status_line "external/README.md" "external directory guide" "baseline management notes"
  baseline_record_status
  status_line "logs/README.md" "logs directory guide" "raw logs ignored by default; current make log is not tracked"
  status_line "references/README.md" "reference directory guide" "placeholder"
  status_line "slides/README.md" "PPT structure plan" "stage6a outline includes lab2 v0.2 and lab4 file table observation; actual PPT TODO"
  status_line "videos/README.md" "Demo video notes" "records video policy and TODO status"
  status_line "videos/demo_script.md" "Demo script draft" "2-3 minute lab0/lab1/lab2/lab4 integrated 0001-0005 demo flow; recording TODO"
  echo "| Final submission | \`submissions/\` | - | TODO: organize against official requirements |"
  echo
  echo "## Notes"
  echo
  echo "- File existence is checked by this script; content quality still needs human review."
  echo "- \`external/xv6-riscv/\` is intentionally not listed as a tracked submission artifact."
  echo "- xv6 baseline make, hardened boot evidence retry, lab1 patched make, hello output, add2 output, pstatetest output, pcounttest output, pchildtest output, fcounttest output, and integrated sequence evidence are summarized in docs/04_test_report.md."
  echo "- lab1 now has two patch levels: 0001 hello minimal syscall and 0002 add2 argint extension."
  echo "- lab2 has an independent pstate process observation patch from clean baseline."
  echo "- integrated-labs provides the verified comprehensive demo sequence with hello=22, add2=23, pstate=24, pcount=25, fcount=26."
  echo "- The child-state demo command is pchildtest; the longer pstatechildtest name is not used because xv6 DIRSIZ caused a real mkfs failure."
  echo "- scripts/xv6/apply-integrated-labs.sh is the recommended helper for final integrated demo reproduction and now applies integrated 0001-0005."
  echo "- scripts/xv6/doctor.sh is the read-only environment diagnosis entry and does not run make/QEMU."
  echo "- scripts/xv6/teammate-verify.sh --full is the recommended first teammate workflow; --quick is for retesting after make already succeeded."
  echo "- scripts/xv6/local-verify.sh --quick is recommended for team-lead pre-recording checks."
  echo "- scripts/xv6/cleanup-qemu.sh is the rescue command when QEMU is stuck or Ctrl+Z suspended a job."
  echo "- Technical report v0.1 and reproducibility package are drafts for review, not final submission files."
  echo "- Raw logs remain ignored by Git; do not submit logs/*.log."
  echo "- boot-xv6.sh now defaults to 45s soft timeout, hard timeout max(timeout+15,75), and 2 attempts; QEMU long-running stability and manual interactive shell testing remain TODO."
  echo "- run-xv6-command.sh now defaults to 60s soft timeout, hard timeout max(timeout+15,75), and 2 attempts; success is still based only on real log matching."
  echo "- apply-integrated-labs.sh --make --yes uses XV6_MAKE_TIMEOUT_SECONDS, default 600 seconds; make success is never fabricated."
  echo "- Teammate QEMU cleanup troubleshooting is documented in docs/22_teammate_reproduction_troubleshooting.md."
  echo "- Plain-language teammate quickstart is documented in docs/23_teammate_quickstart.md; teammates should copy the COPY THIS SUMMARY TO TEAM LEAD block to the team lead."
} > "$out"

echo "[OK] report index updated: ${out}"
echo "No PDF or final report was generated."
