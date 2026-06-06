# Initial Submission Material Index Draft

Generated time: TODO: fill manually before final submission

This file is generated or updated by `scripts/collect-report.sh`.
It is not the final technical report, does not generate PDF, and does not include registration materials, private data, or fabricated results.

## Material Index

| Material | Path | File | Content status |
| --- | --- | --- | --- |
| Project homepage | `README.md` | exists | judge-facing portal |
| Documentation guide | `docs/README.md` | exists | stage8b guide: docs/final is official documentation portal; docs/00-23 are process records; docs/13 is historical v0.1 draft |
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
| teammate reproduction troubleshooting | `docs/22_teammate_reproduction_troubleshooting.md` | exists | stage7a0: explains apply/make completion, boot normal duration, Ctrl+Z risk, qemu/make cleanup, continuation steps, feedback format, and no-log/no-secret boundaries |
| teammate quickstart | `docs/23_teammate_quickstart.md` | exists | stage7a2: official teammate testing entry; --full first run, --quick retest after make, local-verify before recording, cleanup-qemu after stuck/Ctrl+Z, summary feedback, no external/logs/secrets |
| final project overview | `docs/final/00_project_overview.md` | exists | stage8a formal portal: OUC xv6 Lab Kit positioning, scoring weights, status, OUC teaching value, reference-project comparison, boundaries |
| final environment setup | `docs/final/01_environment_setup.md` | exists | stage8a formal environment and repository hygiene guide |
| final lab0 guide | `docs/final/02_lab0_baseline_build_boot.md` | exists | stage8a formal lab0 baseline/build/boot guide |
| final lab1 guide | `docs/final/03_lab1_hello_add2.md` | exists | stage8a formal hello/add2 syscall lab guide |
| final lab2 guide | `docs/final/04_lab2_process_observation.md` | exists | stage8a formal pstate/pcount/pchild process observation lab guide |
| final lab4 guide | `docs/final/05_lab4_file_table_observation.md` | exists | stage8a formal fcount file table observation lab guide |
| final testing and verification | `docs/final/06_testing_and_verification.md` | exists | stage8a formal testing coverage table with real-result boundaries |
| final teammate reproduction guide | `docs/final/07_teammate_reproduction_guide.md` | exists | stage8a formal teammate reproduction and feedback guide |
| final design decisions | `docs/final/08_design_decisions_and_tradeoffs.md` | exists | stage8a formal design tradeoffs and scope control |
| final AI usage statement | `docs/final/09_ai_usage_and_contribution_statement.md` | exists | stage8a formal AI usage and contribution statement |
| final reference and license statement | `docs/final/10_reference_and_license_statement.md` | exists | stage8a formal xv6 MIT license boundary and reference-project notes |
| final limits and future work | `docs/final/11_known_limits_and_future_work.md` | exists | stage8a formal known limits and follow-up plan |
| submission checklist | `submissions/submission_checklist.md` | exists | stage8b submission checklist: platform compliance, Git hygiene, reproducibility, docs, video metadata, teammate summaries, red-team review, final commands |
| demo video record | `submissions/demo_record.md` | exists | stage8b records 3 video file names, external path, approximate sizes, and no-video-in-Git boundary |
| teammate reproduction record | `submissions/teammate_reproduction_record.md` | exists | stage8b records two teammate --full PASS summary digests; raw logs/summary/screenshots are not committed |
| Technical report v0.1 | `docs/13_technical_report_v0.1.md` | exists | historical stage2c draft with stage8b obsolete notice; not final report |
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
| xv6 boot evidence script | `scripts/xv6/boot-xv6.sh` | exists | captures boot keywords under soft+hard timeout; default 45s soft, max(timeout+15,75)s hard, 2 attempts, per-attempt logs, trap cleanup |
| xv6 command evidence script | `scripts/xv6/run-xv6-command.sh` | exists | captures user program output under soft+hard timeout; default 60s soft, max(timeout+15,75)s hard, 2 attempts, fs.img prebuild, trap cleanup, fast QEMU exit on expected output match (stage7a3) |
| lab1 patch apply helper | `scripts/xv6/apply-lab1-patch.sh` | exists | preview by default; --run resets clean baseline and applies; --make optional |
| integrated labs apply helper | `scripts/xv6/apply-integrated-labs.sh` | exists | preview by default; --run/--make always require --yes (reset/clean ignored tree); make has XV6_MAKE_TIMEOUT_SECONDS; make logs ignored |
| xv6 doctor script | `scripts/xv6/doctor.sh` | exists | stage7a2 read-only environment diagnosis: time/cwd/uname/commit, Git repo, tools, baseline files, logs ignored, QEMU leftovers, /mnt warning; no make or QEMU run |
| xv6 QEMU cleanup helper | `scripts/xv6/cleanup-qemu.sh` | exists | stage7a2 rescue tool: explains Ctrl+C interrupt vs Ctrl+Z suspend, lists qemu/make qemu processes before/after, warns pkill may affect same-WSL QEMU, exits 0 |
| teammate one-shot verification | `scripts/xv6/teammate-verify.sh` | exists | stage7a2 workflow: --full clean apply+make and --quick retest; doctor/check-env/baseline, boot, hello/add2/pstate/pcount/pchild/fcount verification, copy-to-lead summary in ignored logs |
| local pre-recording verification | `scripts/xv6/local-verify.sh` | exists | stage7a2 team-lead wrapper around teammate-verify; --full/--quick; recommended --quick before recording |
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
- scripts/xv6/doctor.sh is the read-only environment diagnosis entry and does not run make/QEMU.
- scripts/xv6/teammate-verify.sh --full is the recommended first teammate workflow; --quick is for retesting after make already succeeded.
- scripts/xv6/local-verify.sh --quick is recommended for team-lead pre-recording checks.
- scripts/xv6/cleanup-qemu.sh is the rescue command when QEMU is stuck or Ctrl+Z suspended a job.
- docs/final/ is the formal submission documentation portal for stage8a and should be the basis for technical report v1.0 and PPT.
- docs/README.md explains the boundary between formal docs/final documentation and historical process records.
- Technical report v0.1 and reproducibility package are drafts for review, not final submission files.
- docs/13_technical_report_v0.1.md is explicitly marked as a historical draft superseded by docs/final and a future technical report v1.0.
- Raw logs remain ignored by Git; do not submit logs/*.log.
- boot-xv6.sh now defaults to 45s soft timeout, hard timeout max(timeout+15,75), and 2 attempts; QEMU long-running stability and manual interactive shell testing remain TODO.
- run-xv6-command.sh now defaults to 60s soft timeout, hard timeout max(timeout+15,75), and 2 attempts; success is still based only on real log matching.
- apply-integrated-labs.sh --make --yes uses XV6_MAKE_TIMEOUT_SECONDS, default 600 seconds; make success is never fabricated.
- Teammate QEMU cleanup troubleshooting is documented in docs/22_teammate_reproduction_troubleshooting.md.
- Plain-language teammate quickstart is documented in docs/23_teammate_quickstart.md; teammates should copy the COPY THIS SUMMARY TO TEAM LEAD block to the team lead.
- Video files are not committed; stage8b video file names, external path, and approximate sizes are recorded in submissions/demo_record.md.
- Two teammate --full verification PASS summaries are recorded as text in submissions/teammate_reproduction_record.md; raw logs/summary files/screenshots are not committed.
