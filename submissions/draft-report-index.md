# Initial Submission Material Index Draft

Generated time: TODO: fill manually before final submission

This file is generated or updated by `scripts/collect-report.sh`.
It is not the final technical report, does not generate PDF, and does not include registration materials, private data, or fabricated results.

## Material Index

| Material | Path | File | Content status |
| --- | --- | --- | --- |
| Project homepage | `README.md` | exists | stage15 learner-first homepage: what/for-whom/learning path Step0-7, labctl quick run, teacher and judge pointers, Baidu external-asset link in the judge section, honest evidence status and real-pothole closing note last |
| Documentation guide | `docs/README.md` | exists | stage12 reader routing: first-time learners, lab runners, teachers/TAs, judges, and historical process records (lowest priority for newcomers) |
| teacher guide | `docs/teacher_guide.md` | exists | stage12: 2/3/5-session course plans, mandatory vs optional labs, acceptance via teammate-verify summary blocks, anti-fabrication spot checks, student environment handling |
| grading and rubric | `docs/grading_and_rubric.md` | exists | stage12: four grading dimensions, per-lab focus, unified deduction table (hardcoded outputs = fabrication), bonus items, grade bands |
| troubleshooting | `docs/troubleshooting.md` | exists | stage12: symptom/cause/fix/what-to-report for WSL, PATH, /mnt slowness, Ctrl+Z + cleanup-qemu, git apply order, usys.pl filemode warning, RWX warning, DIRSIZ, timeout semantics |
| Project plan | `docs/00_project_plan.md` | exists | MVP draft |
| Requirement and scoring analysis | `docs/01_requirement_analysis.md` | exists | MVP draft |
| Lab system design | `docs/02_lab_design.md` | exists | MVP draft |
| Step-by-step guide outline | `docs/03_step_by_step_guide.md` | exists | outline draft |
| Test report | `docs/04_test_report.md` | exists | includes real baseline make, hardened boot evidence retry, lab1/lab2/lab3/lab4 outputs, integrated 0001-0007 evidence, and lab2 v0.2 outputs |
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
| submission readiness review | `docs/21_submission_readiness_review.md` | exists | stage6d historical snapshot: full integrated 0001-0005 reproduced at that time; superseded by final e8e2fb9 integrated 0001-0007 evidence manifest |
| teammate reproduction troubleshooting | `docs/22_teammate_reproduction_troubleshooting.md` | exists | stage7a0: explains apply/make completion, boot normal duration, Ctrl+Z risk, qemu/make cleanup, continuation steps, feedback format, and no-log/no-secret boundaries |
| teammate quickstart | `docs/23_teammate_quickstart.md` | exists | stage7a2: official teammate testing entry; --full first run, --quick retest after make, local-verify before recording, cleanup-qemu after stuck/Ctrl+Z, summary feedback, no external/logs/secrets |
| lab3/lab5 completion plan | `docs/24_lab3_lab5_completion_plan.md` | exists | stage9c process record with stage11b banner: described 0001-0007 state is historical; current integrated suite is 0001-0009; e8e2fb9 evidence is a historical stable checkpoint recorded elsewhere |
| final project overview | `docs/final/00_project_overview.md` | exists | stage11b status: OUC xv6 Lab Kit positioning, scoring weights, integrated 0001-0009 (memstat 0008/fdinfo 0009), e8e2fb9 0001-0007 PASS historical, new evidence TBD, evidence boundaries |
| final environment setup | `docs/final/01_environment_setup.md` | exists | stage8a formal environment and repository hygiene guide |
| final lab0 guide | `docs/final/02_lab0_baseline_build_boot.md` | exists | stage8a formal lab0 baseline/build/boot guide |
| final lab1 guide | `docs/final/03_lab1_hello_add2.md` | exists | stage8a formal hello/add2 syscall lab guide |
| final lab2 guide | `docs/final/04_lab2_process_observation.md` | exists | stage8a formal pstate/pcount/pchild process observation lab guide |
| final lab3 guide | `docs/final/04b_lab3_page_table_observation.md` | exists | stage9c formal pgcount page-table observation guide; stage11b advanced memstat section now covers independent + integrated 0008 |
| final lab4 guide | `docs/final/05_lab4_file_table_observation.md` | exists | stage9c formal fcount/fdcount file table and fd table observation lab guide; stage11b advanced fdinfo section now covers independent + integrated 0009 |
| final testing and verification | `docs/final/06_testing_and_verification.md` | exists | stage11b testing coverage table now includes memstat/fdinfo; e8e2fb9 0001-0007 lead/root/z2996 full PASS historical; new 0001-0009 teammate verify TBD; real-result boundaries |
| final teammate reproduction guide | `docs/final/07_teammate_reproduction_guide.md` | exists | stage11b updated teammate reproduction and feedback guide: e8e2fb9 root/z2996 PASS recorded as historical 0001-0007 stable checkpoint; 0001-0009 (with memstattest/fdinfotest) teammate re-verify TBD |
| final design decisions | `docs/final/08_design_decisions_and_tradeoffs.md` | exists | stage8a formal design tradeoffs and scope control |
| final AI usage statement | `docs/final/09_ai_usage_and_contribution_statement.md` | exists | stage8a formal AI usage and contribution statement |
| final reference and license statement | `docs/final/10_reference_and_license_statement.md` | exists | stage8a formal xv6 MIT license boundary and reference-project notes |
| final limits and future work | `docs/final/11_known_limits_and_future_work.md` | exists | stage11b limits: pgcount/fdcount/memstat/fdinfo observation-only scope boundaries, integrated suite 0001-0009, e8e2fb9 evidence historical, new evidence/platform/privacy/reference items still pending |
| technical report v1.0 | `docs/final/technical_report_v1.0.md` | exists | stage11b judge-facing technical report draft: positioning, labs, integrated 0001-0009 (memstat 0008/fdinfo 0009), e8e2fb9 0001-0007 evidence historical, new evidence TBD, teaching value, license/AI/limits |
| submission checklist | `submissions/submission_checklist.md` | exists | stage15 submission checklist: current final db85947/0001-0009 three-way PASS + new video recorded; Baidu external-asset row added; e8e2fb9 0001-0007 historical; remaining items are video duration metadata, platform method, privacy review, PPT rehearsal |
| demo video record | `submissions/demo_record.md` | exists | stage14: current final 0001-0009 video recorded with SHA256 (20260611 demo, db85947); old 0001-0007 video historical stable checkpoint; 3 earlier historical video records; no video files in Git |
| teammate reproduction record | `submissions/teammate_reproduction_record.md` | exists | stage14: current final db85947/0001-0009 three-way full PASS recorded with summary/screenshot SHA256 and grade-summaries 3/3 clean; e8e2fb9 and 1ba9db6 records historical; raw files not committed |
| final evidence manifest | `submissions/evidence_manifest.md` | exists | stage15 central index: current final db85947/0001-0009 with three-way full PASS, grade-summaries 3/3 clean, new video + SHA256 recorded and hash-verified; External Asset Package section with Baidu pan link (proj54_submission_assets); e8e2fb9 0001-0007 historical stable checkpoint; non-committed evidence policy |
| Technical report v0.1 | `docs/13_technical_report_v0.1.md` | exists | historical stage2c draft with stage8b obsolete notice; not final report |
| Reproducibility package | `reproducibility/README.md` | exists | lab0/lab1/lab2/integrated-labs reproduction checklist and template |
| lab0 environment guide | `labs/lab0-env-setup/README.md` | exists | xv6 baseline make succeeded; boot evidence found; manual interaction TODO |
| lab1 syscall lab | `labs/lab1-system-call/README.md` | exists | stage12 tutorial-style: hello minimal and add2 argint, 7-file checklist, call path, hands-on pointer to student tasks |
| lab1 student tasks | `labs/lab1-system-call/student_tasks.md` | exists | stage12 assignment sheet: reproduce, build your own integer syscall, break-and-fix experiment, rubric and deduction list |
| lab2 process state observation | `labs/lab2-process-and-scheduling/README.md` | exists | stage12 tutorial-style: pstate/pcount/pchildtest, proc table and lock discipline, scheduling nondeterminism |
| lab2 student tasks | `labs/lab2-process-and-scheduling/student_tasks.md` | exists | stage12 assignment sheet: lock path audit, new observation syscall, repeated-run timing observation, rubric |
| lab3 memory and pagetable | `labs/lab3-memory-and-pagetable/README.md` | exists | stage12 tutorial-style: pgcount int observation vs memstat struct-copyout observation; eager/lazy delta experiment; integrated 0006/0008 |
| lab3 student tasks | `labs/lab3-memory-and-pagetable/student_tasks.md` | exists | stage12 assignment sheet: predict-then-verify lazy deltas, copyout data-flow walkthrough, add a struct field with padding analysis, rubric |
| lab4 file system | `labs/lab4-file-system/README.md` | exists | stage12 tutorial-style: fcount global trend / fdcount per-process / fdinfo single-fd struct view; open-dup-close contrast; not a complete file system lab |
| lab4 student tasks | `labs/lab4-file-system/student_tasks.md` | exists | stage12 assignment sheet: predict-verify dup effects, fdinfo validation audit, ref observation, negative cases, rubric |
| lab5 final integration | `labs/lab5-final-integration/README.md` | exists | stage12 tutorial-style capstone for integrated 0001-0009; reproducibility and evidence discipline; no new kernel mechanism |
| lab5 student tasks | `labs/lab5-final-integration/student_tasks.md` | exists | stage12 assignment sheet: full-suite reproduction with summary block, patch walkthrough incl. 0008/0009, fault log, evidence boundary statement, rubric |
| lab1 test record | `tests/lab1/README.md` | exists | records patched make and hello output evidence |
| lab2 test record | `tests/lab2/README.md` | exists | records pstatetest, pcounttest, and pchildtest output evidence |
| lab3 test record | `tests/lab3/README.md` | exists | records pgcount eager/lazy output captures from independent and integrated 0006; final teammate coverage recorded in submissions evidence manifest |
| lab4 test record | `tests/lab4/README.md` | exists | records fcounttest/fdcounttest captures and non-fixed count boundary |
| xv6 fetch script | `scripts/xv6/fetch-xv6.sh` | exists | stage1b tooling |
| xv6 baseline check script | `scripts/xv6/check-xv6-baseline.sh` | exists | stage1b tooling; make not run by default |
| xv6 boot evidence script | `scripts/xv6/boot-xv6.sh` | exists | captures boot keywords under soft+hard timeout; default 45s soft, max(timeout+15,75)s hard, 2 attempts, per-attempt logs, trap cleanup |
| xv6 command evidence script | `scripts/xv6/run-xv6-command.sh` | exists | captures user program output under soft+hard timeout; default 60s soft, max(timeout+15,75)s hard, 2 attempts, fs.img prebuild, trap cleanup, fast QEMU exit on expected output match (stage7a3) |
| lab1 patch apply helper | `scripts/xv6/apply-lab1-patch.sh` | exists | preview by default; --run resets clean baseline and applies; --make optional |
| integrated labs apply helper | `scripts/xv6/apply-integrated-labs.sh` | exists | preview by default; --run/--make always require --yes; applies integrated 0001-0009; make has XV6_MAKE_TIMEOUT_SECONDS; make logs ignored |
| xv6 doctor script | `scripts/xv6/doctor.sh` | exists | stage7a2 read-only environment diagnosis: time/cwd/uname/commit, Git repo, tools, baseline files, logs ignored, QEMU leftovers, /mnt warning; no make or QEMU run |
| xv6 QEMU cleanup helper | `scripts/xv6/cleanup-qemu.sh` | exists | stage7a2 rescue tool: explains Ctrl+C interrupt vs Ctrl+Z suspend, lists qemu/make qemu processes before/after, warns pkill may affect same-WSL QEMU, exits 0 |
| teammate one-shot verification | `scripts/xv6/teammate-verify.sh` | exists | stage11b workflow: --full clean apply+make and --quick retest; doctor/check-env/baseline, boot, hello/add2/pstate/pcount/pchild/fcount/pgcount/fdcount/memstat/fdinfo verification, copy-to-lead summary in ignored logs |
| local pre-recording verification | `scripts/xv6/local-verify.sh` | exists | stage7a2 team-lead wrapper around teammate-verify; --full/--quick; recommended --quick before recording |
| course command entry | `scripts/labctl.sh` | exists | stage13 unified dispatcher: doctor/setup/boot/test/verify/quick/precheck/clean/grade/consistency/hygiene/evidence/report subcommands delegate to existing scripts; adds the lab-to-test matrix (test lab1..lab4/all, list) |
| TA summary batch parser | `scripts/grade-summaries.sh` | exists | stage13 acceptance aid (not a grader): parses teammate-verify summary blocks into one row per file; flags overall/item inconsistency, missing memstattest-fdinfotest (old suite), duplicate content, commit mismatch; exit 1 when attention needed |
| docs/state consistency gate | `scripts/check-docs-consistency.sh` | exists | stage13 drift gate: PATCHES list vs patch files, SYS numbers 22-30 in patches, teammate-verify and labctl matrix coverage, stale wording scan outside changelogs, course file presence, report-index freshness |
| final hygiene gate | `scripts/check-final-hygiene.sh` | exists | stage12 read-only pre-submission gate: external/logs/.claude/.vscode/media-office tracking checks with single PPTX whitelist plus git diff --check |
| external evidence SHA256 check | `scripts/check-evidence-sha256.sh` | exists | stage14: hashes both evidence sets in place against recorded SHA256 (historical e8e2fb9/0001-0007 plus current final db85947/0001-0009: video, 3 summaries, 2 screenshots); skips when evidence dir absent; latest real run 14/14 matched |
| lab1 hello syscall patch | `patches/lab1-system-call/0001-add-hello-syscall.patch` | exists | tracked patch; third-party source not submitted |
| lab1 add2 argint syscall patch | `patches/lab1-system-call/0002-add-argint-add2-syscall.patch` | exists | commit-ready incremental patch after 0001 |
| lab1 patch guide | `patches/lab1-system-call/README.md` | exists | apply/build/run instructions |
| lab2 pstate syscall patch | `patches/lab2-process-observation/0001-add-pstate-syscall.patch` | exists | commit-ready independent patch from clean baseline |
| lab2 patch guide | `patches/lab2-process-observation/README.md` | exists | apply/build/run instructions |
| lab3 pgcount syscall patch | `patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch` | exists | stage9b independent patch from clean baseline; SYS_pgcount 22; eager/lazy pgcounttest verified |
| lab3 memstat advanced optional patch | `patches/lab3-memory-and-pagetable/0002-add-memstat-syscall.patch` | exists | stage11a independent advanced patch; memstat(struct memstat*) via argaddr+copyout; SYS_memstat 22; clean-baseline round-trip verified; stage11b also integrates this as integrated 0008 (SYS_memstat 29); independent variant not teammate-verified; does not affect historical e8e2fb9 |
| lab3 patch guide | `patches/lab3-memory-and-pagetable/README.md` | exists | apply/build/run instructions and eager/lazy allocation teaching notes |
| lab4 fcount syscall patch | `patches/lab4-file-table-observation/0001-add-fcount-syscall.patch` | exists | commit-ready independent patch from clean baseline |
| lab4 fdinfo advanced optional patch | `patches/lab4-file-table-observation/0002-add-fdinfo-syscall.patch` | exists | stage11a independent advanced patch; fdinfo(int,struct fdinfo*) via argint+argaddr+copyout; SYS_fdinfo 22; self-only ofile[fd]; clean-baseline round-trip verified; stage11b also integrates this as integrated 0009 (SYS_fdinfo 30); independent variant not teammate-verified; does not affect historical e8e2fb9 |
| lab4 patch guide | `patches/lab4-file-table-observation/README.md` | exists | apply/build/run instructions |
| integrated hello syscall patch | `patches/integrated-labs/0001-add-hello-syscall.patch` | exists | comprehensive demo sequence step 1 |
| integrated add2 argint syscall patch | `patches/integrated-labs/0002-add-argint-add2-syscall.patch` | exists | comprehensive demo sequence step 2 |
| integrated pstate syscall patch | `patches/integrated-labs/0003-add-pstate-syscall.patch` | exists | comprehensive demo sequence step 3; uses SYS_pstate 24 |
| integrated lab2 v0.2 process observation patch | `patches/integrated-labs/0004-extend-process-observation.patch` | exists | comprehensive demo sequence step 4; adds SYS_pcount 25, pcounttest, pchildtest |
| integrated lab4 file table observation patch | `patches/integrated-labs/0005-add-file-table-observation.patch` | exists | comprehensive demo sequence step 5; adds SYS_fcount 26 and fcounttest |
| integrated lab3 pgcount patch | `patches/integrated-labs/0006-add-pgcount-page-table-observation.patch` | exists | comprehensive demo sequence step 6; adds SYS_pgcount 27 and pgcounttest |
| integrated lab4 fdcount patch | `patches/integrated-labs/0007-add-fdcount-observation.patch` | exists | comprehensive demo sequence step 7; adds SYS_fdcount 28 and fdcounttest |
| integrated lab3 memstat patch | `patches/integrated-labs/0008-add-memstat-copyout-observation.patch` | exists | stage11b comprehensive demo sequence step 8; adds SYS_memstat 29 and memstattest; argaddr+copyout+struct ABI; reuses uvmpagecount; address-space observation only, not full memory management |
| integrated lab4 fdinfo patch | `patches/integrated-labs/0009-add-fdinfo-copyout-observation.patch` | exists | stage11b comprehensive demo sequence step 9; adds SYS_fdinfo 30 and fdinfotest; argint+argaddr+copyout+struct ABI; self-only ofile[fd]; fd metadata observation only, not full file system |
| integrated patch guide | `patches/integrated-labs/README.md` | exists | stage11b apply/build/run instructions for combined lab1+lab2+lab3+lab4 demo: sequence 0001-0009 incl. memstat 0008 and fdinfo 0009; old 0001-0007 teammate evidence marked historical; 0001-0009 teammate verify TBD |
| external directory guide | `external/README.md` | exists | baseline management notes |
| xv6 baseline metadata | `external/xv6-baseline-record.md` | exists | metadata generated; records make success and boot evidence; manual interaction TODO |
| logs directory guide | `logs/README.md` | exists | raw logs ignored by default; current make log is not tracked |
| reference directory guide | `references/README.md` | exists | placeholder |
| PPT directory guide | `slides/README.md` | exists | stage10c guide for final PPT source, generator, PPTX output, and no-media boundary |
| final PPT outline | `slides/final_ppt_outline.md` | exists | stage10b 15-slide final defense outline with key message, bullets, visual suggestion, and speaker notes |
| final PPT source | `slides/final_ppt.md` | exists | stage15 16-slide final defense source: core story (lab kit, not just syscalls), current final db85947/0001-0009 three-way PASS, video + Baidu asset link, teaching-material innovation, honest boundaries |
| final PPT generator | `slides/generate_final_ppt.py` | exists | stage10c standard-library OpenXML generator; reads slides/final_ppt.md and writes slides/final_defense_ppt.pptx without embedded media |
| final PPTX | `slides/final_defense_ppt.pptx` | exists | stage10c generated 16:9 defense deck; 16 slides, speaker notes, no embedded video/screenshot media |
| Demo video notes | `videos/README.md` | exists | records video policy and no-video-in-Git boundary |
| Demo script draft | `videos/demo_script.md` | exists | historical 2-3 minute demo flow; final recorded video metadata is tracked in submissions/demo_record.md |
| Final submission | `submissions/` | - | TODO: organize against official requirements |

## Notes

- File existence is checked by this script; content quality still needs human review.
- `external/xv6-riscv/` is intentionally not listed as a tracked submission artifact.
- xv6 baseline make, hardened boot evidence retry, lab1 patched make, hello output, add2 output, pstatetest output, pcounttest output, pchildtest output, fcounttest output, and integrated sequence evidence are summarized in docs/04_test_report.md.
- lab1 now has two patch levels: 0001 hello minimal syscall and 0002 add2 argint extension.
- lab2 has an independent pstate process observation patch from clean baseline.
- lab3 has an independent pgcount patch, integrated 0006 pgcount, and an independent memstat patch also integrated as 0008; e8e2fb9 0001-0007 full verification by lead/root/z2996 is a historical stable checkpoint in submissions/evidence_manifest.md, and the 0001-0009 re-verification is TBD.
- integrated-labs provides the verified comprehensive demo sequence with hello=22, add2=23, pstate=24, pcount=25, fcount=26, pgcount=27, fdcount=28, memstat=29, fdinfo=30.
- The child-state demo command is pchildtest; the longer pstatechildtest name is not used because xv6 DIRSIZ caused a real mkfs failure.
- scripts/xv6/apply-integrated-labs.sh is the recommended helper for final integrated demo reproduction and now applies integrated 0001-0009.
- scripts/xv6/doctor.sh is the read-only environment diagnosis entry and does not run make/QEMU.
- scripts/xv6/teammate-verify.sh --full is the recommended first teammate workflow; --quick is for retesting after make already succeeded.
- scripts/xv6/local-verify.sh --quick is recommended for team-lead pre-recording checks.
- scripts/xv6/cleanup-qemu.sh is the rescue command when QEMU is stuck or Ctrl+Z suspended a job.
- stage12 reorganized the repo learner-first: README and docs/README route students/teachers/judges separately; every lab has a tutorial README plus a student_tasks.md assignment sheet; teacher_guide/grading_and_rubric/troubleshooting support running this as a course; submission evidence stays rigorous under submissions/ and docs/final/.
- scripts/check-final-hygiene.sh and scripts/check-evidence-sha256.sh are the stage12 pre-submission gates; evidence hashes are verified in place outside Git and TBD 0001-0009 evidence is never faked.
- stage13 added scripts/labctl.sh (single course entry + per-lab test matrix), scripts/grade-summaries.sh (TA batch acceptance aid, not a grader), and scripts/check-docs-consistency.sh (mechanical drift gate); all three delegate to or check existing assets instead of reimplementing verification.
- docs/final/ is the formal submission documentation portal for stage8a and should be the basis for technical report v1.0 and PPT.
- docs/README.md explains the boundary between formal docs/final documentation and historical process records.
- Technical report v1.0 draft is docs/final/technical_report_v1.0.md; technical report v0.1 is historical only.
- Final PPT source is slides/final_ppt.md and current PPTX output is slides/final_defense_ppt.pptx; final human review and rehearsal are still required.
- docs/13_technical_report_v0.1.md is explicitly marked as a historical draft superseded by docs/final and a future technical report v1.0.
- Raw logs remain ignored by Git; do not submit logs/*.log.
- boot-xv6.sh now defaults to 45s soft timeout, hard timeout max(timeout+15,75), and 2 attempts; QEMU long-running stability and manual interactive shell testing remain TODO.
- run-xv6-command.sh now defaults to 60s soft timeout, hard timeout max(timeout+15,75), and 2 attempts; success is still based only on real log matching.
- apply-integrated-labs.sh --make --yes uses XV6_MAKE_TIMEOUT_SECONDS, default 600 seconds; make success is never fabricated.
- Teammate QEMU cleanup troubleshooting is documented in docs/22_teammate_reproduction_troubleshooting.md.
- Plain-language teammate quickstart is documented in docs/23_teammate_quickstart.md; teammates should copy the COPY THIS SUMMARY TO TEAM LEAD block to the team lead.
- Video files are not committed; final and historical video metadata plus SHA256 are recorded in submissions/demo_record.md.
- e8e2fb9 lead/root/z2996 full PASS (integrated 0001-0007) is recorded as a historical stable checkpoint in submissions/teammate_reproduction_record.md; the stage11b integrated suite is 0001-0009 and its teammate re-verification is TBD; old 1ba9db6 records remain historical evidence only.
- submissions/evidence_manifest.md is the central final evidence index and does not store raw evidence files.
