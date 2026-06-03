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
| Test report | `docs/04_test_report.md` | exists | includes real baseline make, boot evidence, and lab1 hello output evidence |
| AI usage record | `docs/05_ai_usage_record.md` | exists | active record |
| Progress log | `docs/06_progress_log.md` | exists | active record |
| FAQ and issue record | `docs/07_faq_and_issues.md` | exists | template |
| Reference and license record | `docs/08_reference_and_license.md` | exists | active record |
| GitHub workflow | `docs/09_github_workflow.md` | exists | workflow draft |
| Internal red-team review | `docs/10_red_team_review.md` | exists | draft |
| xv6 baseline plan | `docs/11_xv6_baseline_plan.md` | exists | stage1b plan |
| lab0 environment guide | `labs/lab0-env-setup/README.md` | exists | xv6 baseline make succeeded; boot evidence found; manual interaction TODO |
| lab1 syscall lab | `labs/lab1-system-call/README.md` | exists | hello syscall patch generated and verified |
| lab2 process and scheduling | `labs/lab2-process-and-scheduling/README.md` | exists | planned |
| lab3 memory and pagetable | `labs/lab3-memory-and-pagetable/README.md` | exists | planned |
| lab4 file system | `labs/lab4-file-system/README.md` | exists | planned |
| lab5 final integration | `labs/lab5-final-integration/README.md` | exists | planned |
| lab1 test record | `tests/lab1/README.md` | exists | records patched make and hello output evidence |
| lab2 test plan | `tests/lab2/README.md` | exists | draft |
| lab3 test plan | `tests/lab3/README.md` | exists | draft |
| lab4 test plan | `tests/lab4/README.md` | exists | draft |
| xv6 fetch script | `scripts/xv6/fetch-xv6.sh` | exists | stage1b tooling |
| xv6 baseline check script | `scripts/xv6/check-xv6-baseline.sh` | exists | stage1b tooling; make not run by default |
| xv6 boot evidence script | `scripts/xv6/boot-xv6.sh` | exists | captures boot keywords under timeout |
| xv6 command evidence script | `scripts/xv6/run-xv6-command.sh` | exists | captures user program output under timeout |
| lab1 hello syscall patch | `patches/lab1-system-call/0001-add-hello-syscall.patch` | exists | tracked patch; third-party source not submitted |
| lab1 patch guide | `patches/lab1-system-call/README.md` | exists | apply/build/run instructions |
| external directory guide | `external/README.md` | exists | baseline management notes |
| xv6 baseline metadata | `external/xv6-baseline-record.md` | exists | metadata generated; records make success and boot evidence; manual interaction TODO |
| logs directory guide | `logs/README.md` | exists | raw logs ignored by default; current make log is not tracked |
| reference directory guide | `references/README.md` | exists | placeholder |
| PPT notes | `slides/README.md` | exists | TODO |
| Demo video notes | `videos/README.md` | exists | TODO |
| Final submission | `submissions/` | - | TODO: organize against official requirements |

## Notes

- File existence is checked by this script; content quality still needs human review.
- `external/xv6-riscv/` is intentionally not listed as a tracked submission artifact.
- xv6 baseline make, boot evidence, lab1 patched make, and hello output are summarized in docs/04_test_report.md.
- Raw logs remain ignored by Git; do not submit logs/*.log.
- QEMU long-running stability and manual interactive shell testing remain TODO.
