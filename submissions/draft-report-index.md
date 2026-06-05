# Initial Submission Material Index Draft

Generated time: TODO: fill manually before final submission

This file is generated or updated by `scripts/collect-report.sh`.
It is not the final technical report, does not generate PDF, and does not include registration materials, private data, or fabricated results.

## Material Index

| Material | Path | File | Content status |
| --- | --- | --- | --- |
| Project homepage | `README.md` | exists | MVP draft |
| Project plan | `docs/00_project_plan.md` | exists | MVP draft |
| Requirement and scoring analysis | `docs/01_requirement_analysis.md` | exists | MVP draft |
| Lab system design | `docs/02_lab_design.md` | exists | MVP draft |
| Step-by-step guide outline | `docs/03_step_by_step_guide.md` | exists | outline draft |
| Test report | `docs/04_test_report.md` | exists | includes real baseline make, hardened boot evidence retry, lab1/lab2/lab4 outputs, integrated 0001-0005 evidence, and lab2 v0.2 outputs |
| AI usage record | `docs/05_ai_usage_record.md` | exists | active record |
| Progress log | `docs/06_progress_log.md` | exists | active record |
| FAQ and issue record | `docs/07_faq_and_issues.md` | exists | template |
| Reference and license record | `docs/08_reference_and_license.md` | exists | active record |
| GitHub workflow | `docs/09_github_workflow.md` | exists | workflow draft |
| Internal red-team review | `docs/10_red_team_review.md` | exists | draft |
| xv6 baseline plan | `docs/11_xv6_baseline_plan.md` | exists | stage1b plan |
| lab1 patch reproducibility review | `docs/12_lab1_patch_review.md` | exists | stage2b red-team; clean-baseline apply/make/hello verified |
| lab1 argint extension review | `docs/14_lab1_argint_extension_review.md` | exists | stage3b red-team: 0001+0002 reproduced (make/hello/add2); add2 call chain, argint mechanism, teaching-value assessment |
| lab2 process observation review | `docs/15_lab2_process_observation_review.md` | exists | stage4b red-team: clean-baseline apply/make/pstatetest verified; teaching limits + lab1/lab2 conflict measured |
| patch strategy and integration plan | `docs/16_patch_strategy_and_integration_plan.md` | exists | stage4b conflict measured; stage4c integrated-labs sequence built and verified |
| integrated-labs review | `docs/17_integrated_labs_review.md` | exists | stage4d red-team plus stage6a update: 0001-0005 reproduced; hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest in one build |
| integrated apply helper safety review | `docs/18_integrated_helper_review.md` | exists | stage4f red-team plus stage6a update: preview safe; --run/--make always require --yes; --make --yes applies 0001-0005 |
| lab2 v0.2 process observation review | `docs/19_lab2_v0.2_process_observation_review.md` | exists | stage5a + stage5b red-team: pcount/pcounttest/pchildtest and negative input; integrated 0001-0004 re-reproduced from clean baseline; 0004 patch unchanged; lock/snapshot analysis and benign usys.pl mode warning documented |
| lab4 file table observation review | `docs/20_lab4_file_table_observation_review.md` | exists | stage6a + stage6b red-team: fcount/fcounttest; independent lab4 patch and integrated 0005 re-reproduced from clean baseline; both patches unchanged; filecount lock/deadlock/no-leak analysis; sys_fcount in sysfile.c; open/close +1/-1 delta; fcount numbers non-fixed |
| submission readiness review | `docs/21_submission_readiness_review.md` | exists | stage6d red-team: full integrated 0001-0005 reproduced from clean baseline (make/boot x2/hello/add2test/pstatetest/pcounttest+negative/pchildtest/fcounttest); doc consistency audit; risk list and pre-submission must-do (teammate reproduction + manual recording still TODO) |
| submission checklist | `submissions/submission_checklist.md` | exists | stage6e pre-submission checklist: completion status, must-fill items, forbidden items, pre-submit commands, and honest-MVP conclusion |
| Technical report v0.1 | `docs/13_technical_report_v0.1.md` | exists | stage2c draft; not final report |
| Reproducibility package | `reproducibility/README.md` | exists | lab0/lab1/lab2/integrated-labs reproduction checklist and template |
| lab0 environment guide | `labs/lab0-env-setup/README.md` | exists | xv6 baseline make succeeded; boot evidence found; manual interaction TODO |
| lab1 syscall lab | `labs/lab1-system-call/README.md` | exists | hello minimal and add2 argint patches generated and verified |
| lab2 process state observation | `labs/lab2-process-and-scheduling/README.md` | exists | pstate independent patch verified; integrated v0.2 adds pcount, pcounttest, pchildtest |
| lab3 memory and pagetable | `labs/lab3-memory-and-pagetable/README.md` | exists | planned |
| lab4 file system | `labs/lab4-file-system/README.md` | exists | file table observation v0.1: fcount/fcounttest verified; not a complete file system lab |
| lab5 final integration | `labs/lab5-final-integration/README.md` | exists | planned |
| lab1 test record | `tests/lab1/README.md` | exists | records patched make and hello output evidence |
| lab2 test record | `tests/lab2/README.md` | exists | records pstatetest, pcounttest, and pchildtest output evidence |
| lab3 test plan | `tests/lab3/README.md` | exists | draft |
| lab4 test record | `tests/lab4/README.md` | exists | records fcounttest prefix capture and non-fixed count boundary |
| xv6 fetch script | `scripts/xv6/fetch-xv6.sh` | exists | stage1b tooling |
| xv6 baseline check script | `scripts/xv6/check-xv6-baseline.sh` | exists | stage1b tooling; make not run by default |
| xv6 boot evidence script | `scripts/xv6/boot-xv6.sh` | exists | captures boot keywords under timeout; stage6c default 45s and 2 attempts with per-attempt logs |
| xv6 command evidence script | `scripts/xv6/run-xv6-command.sh` | exists | captures user program output under timeout |
| lab1 patch apply helper | `scripts/xv6/apply-lab1-patch.sh` | exists | preview by default; --run resets clean baseline and applies; --make optional |
| integrated labs apply helper | `scripts/xv6/apply-integrated-labs.sh` | exists | preview by default; --run/--make always require --yes (reset/clean ignored tree); make logs ignored |
| lab1 hello syscall patch | `patches/lab1-system-call/0001-add-hello-syscall.patch` | exists | tracked patch; third-party source not submitted |
| lab1 add2 argint syscall patch | `patches/lab1-system-call/0002-add-argint-add2-syscall.patch` | exists | commit-ready incremental patch after 0001 |
| lab1 patch guide | `patches/lab1-system-call/README.md` | exists | apply/build/run instructions |
| lab2 pstate syscall patch | `patches/lab2-process-observation/0001-add-pstate-syscall.patch` | exists | commit-ready independent patch from clean baseline |
| lab2 patch guide | `patches/lab2-process-observation/README.md` | exists | apply/build/run instructions |
| lab4 fcount syscall patch | `patches/lab4-file-table-observation/0001-add-fcount-syscall.patch` | exists | commit-ready independent patch from clean baseline |
| lab4 patch guide | `patches/lab4-file-table-observation/README.md` | exists | apply/build/run instructions |
| integrated hello syscall patch | `patches/integrated-labs/0001-add-hello-syscall.patch` | exists | comprehensive demo sequence step 1 |
| integrated add2 argint syscall patch | `patches/integrated-labs/0002-add-argint-add2-syscall.patch` | exists | comprehensive demo sequence step 2 |
| integrated pstate syscall patch | `patches/integrated-labs/0003-add-pstate-syscall.patch` | exists | comprehensive demo sequence step 3; uses SYS_pstate 24 |
| integrated lab2 v0.2 process observation patch | `patches/integrated-labs/0004-extend-process-observation.patch` | exists | comprehensive demo sequence step 4; adds SYS_pcount 25, pcounttest, pchildtest |
| integrated lab4 file table observation patch | `patches/integrated-labs/0005-add-file-table-observation.patch` | exists | comprehensive demo sequence step 5; adds SYS_fcount 26 and fcounttest |
| integrated patch guide | `patches/integrated-labs/README.md` | exists | apply/build/run instructions for combined lab1+lab2+lab4 demo |
| external directory guide | `external/README.md` | exists | baseline management notes |
| xv6 baseline metadata | `external/xv6-baseline-record.md` | exists | metadata generated; records make success and boot evidence; manual interaction TODO |
| logs directory guide | `logs/README.md` | exists | raw logs ignored by default; current make log is not tracked |
| reference directory guide | `references/README.md` | exists | placeholder |
| PPT structure plan | `slides/README.md` | exists | stage6a outline includes lab2 v0.2 and lab4 file table observation; actual PPT TODO |
| Demo video notes | `videos/README.md` | exists | records video policy and TODO status |
| Demo script draft | `videos/demo_script.md` | exists | 2-3 minute lab0/lab1/lab2/lab4 integrated 0001-0005 demo flow; recording TODO |
| Final submission | `submissions/` | - | TODO: organize against official requirements |

## Notes

- File existence is checked by this script; content quality still needs human review.
- `external/xv6-riscv/` is intentionally not listed as a tracked submission artifact.
- xv6 baseline make, hardened boot evidence retry, lab1 patched make, hello output, add2 output, pstatetest output, pcounttest output, pchildtest output, fcounttest output, and integrated sequence evidence are summarized in docs/04_test_report.md.
- lab1 now has two patch levels: 0001 hello minimal syscall and 0002 add2 argint extension.
- lab2 has an independent pstate process observation patch from clean baseline.
- integrated-labs provides the verified comprehensive demo sequence with hello=22, add2=23, pstate=24, pcount=25, fcount=26.
- The child-state demo command is pchildtest; the longer pstatechildtest name is not used because xv6 DIRSIZ caused a real mkfs failure.
- scripts/xv6/apply-integrated-labs.sh is the recommended helper for final integrated demo reproduction and now applies integrated 0001-0005.
- Technical report v0.1 and reproducibility package are drafts for review, not final submission files.
- Raw logs remain ignored by Git; do not submit logs/*.log.
- boot-xv6.sh now defaults to 45s per attempt and 2 attempts; QEMU long-running stability and manual interactive shell testing remain TODO.
