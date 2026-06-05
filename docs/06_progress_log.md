# Progress Log

## Rules

- Record only real work.
- Use `TODO`, `pending`, or `not run` for unfinished or unverified items.
- Do not invent commit hashes, test output, build success, or QEMU screenshots.

## 2026-06-03: Scaffold and MVP v0.1

- Commit hash: TODO after commit (spans e354a61+f5f5ae6+50ca6d9; no single commit uniquely matches)
- Completed:
  - Platform placeholder `main.py` removed; reason: `replace platform placeholder with project scaffold`.
  - README, docs, labs, scripts, tests, references, slides, videos, and submissions structure created.
  - MVP v0.1 docs and lightweight scripts prepared.
  - GitHub collaboration workflow configured.
- Verification:
  - `bash scripts/check-env.sh`
  - `bash scripts/run-lab.sh lab0`
  - `bash scripts/run-lab.sh lab1`
  - `bash scripts/collect-report.sh`
  - `git diff --check`

## 2026-06-03: stage1b fetch xv6 baseline and record metadata

- Commit hash: af6a29f
- Completed:
  - Added `scripts/xv6/fetch-xv6.sh`.
  - Added `scripts/xv6/check-xv6-baseline.sh`.
  - Added `logs/README.md`.
  - Updated `.gitignore` to ignore `external/xv6-riscv/` and `logs/*.log` while keeping metadata docs tracked.
  - Updated baseline plan, external directory notes, lab0 environment docs, reference/license notes, AI usage record, and report index script.
  - Actual baseline fetch is authorized for this stage.
- Real environment status from WSL2 Ubuntu 24.04:
  - `git`: OK
  - `bash`: OK
  - `make`: OK
  - `qemu-system-riscv64`: OK
  - `riscv64-linux-gnu-gcc`: OK
  - `riscv64-unknown-elf-gcc`: WARN
- To be filled after stage1b command execution:
  - xv6 clone result: completed in `external/xv6-riscv/`
  - xv6 commit hash: `74f84181a3404d1d6a6ff98d342233979066ebb8`
  - xv6 branch: `riscv`
  - xv6 remote: `https://github.com/mit-pdos/xv6-riscv.git`
  - `external/xv6-baseline-record.md`: generated
  - baseline structure check: `external/xv6-riscv/`, `Makefile`, and `LICENSE` are present
  - toolchain check: `qemu-system-riscv64` OK, `riscv64-linux-gnu-gcc` OK, `riscv64-unknown-elf-gcc` WARN
- Explicitly not run:
  - `bash scripts/xv6/check-xv6-baseline.sh --make`
  - `make`
  - QEMU boot
- Next:
  - Run fetch/status/check scripts.
  - Confirm `external/xv6-riscv/` is ignored.
  - Build verification has now been run separately by the team lead; see the next progress entry.

## 2026-06-03: xv6-riscv baseline make success

- Commit hash: b2ddced
- Completed:
  - The team lead ran `bash scripts/xv6/check-xv6-baseline.sh --make` in WSL2 Ubuntu.
  - xv6-riscv baseline `make` completed successfully.
  - Raw log file exists locally at `logs/xv6-make-20260603-235003.log`.
  - The raw log remains ignored by Git and should not be committed.
  - `docs/04_test_report.md` and `labs/lab0-env-setup/README.md` summarize the real build evidence.
- Real result:
  - Date/time: 2026-06-03 23:50:03 +08:00
  - Toolchain: `riscv64-linux-gnu-gcc`, `riscv64-linux-gnu-ld`
  - `qemu-system-riscv64`: OK
  - `riscv64-unknown-elf-gcc`: WARN
  - Linker warning: `LOAD segment with RWX permissions`
  - make exit result: success
- Explicitly not run:
  - `make qemu`
  - xv6 boot into shell
  - lab1 system call implementation
- Next:
  - Ask the team lead before running QEMU boot verification.
  - If boot is run later, record the exact command, output summary, and risks in `docs/04_test_report.md`.

## 2026-06-04: stage2a boot evidence and lab1 hello syscall

- Commit hash: be933c4
- Completed:
  - Added `scripts/xv6/boot-xv6.sh` to capture xv6 boot evidence without claiming full manual interaction.
  - Ran `bash scripts/xv6/boot-xv6.sh`.
  - Captured baseline boot evidence in `logs/xv6-boot-20260604-001736.log`.
  - Detected `xv6 kernel is booting`.
  - Detected `init: starting sh`.
  - Implemented a minimal `hello()` syscall in the ignored local xv6 tree under `external/xv6-riscv/`.
  - Generated `patches/lab1-system-call/0001-add-hello-syscall.patch` as the tracked lab1 deliverable.
  - Added `patches/lab1-system-call/README.md`.
  - Ran patched xv6 `make` through `bash scripts/xv6/check-xv6-baseline.sh --make`.
  - Captured patched build success in `logs/xv6-make-20260604-001927.log`.
  - Added `scripts/xv6/run-xv6-command.sh` to capture command output evidence from xv6 under timeout.
  - Ran `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"`.
  - Captured hello output evidence in `logs/xv6-command-hello-20260604-002147.log`.
- Real result:
  - baseline boot evidence: found
  - lab1 patched make: success
  - hello output: `hello syscall returned 2026`
- Boundaries:
  - `external/xv6-riscv/` remains ignored and must not be committed.
  - Raw `logs/*.log` files remain ignored and must not be committed.
  - The boot check is evidence capture under timeout, not a long-running stability test.
  - Manual interactive shell testing is TODO.
  - Second-person code review is TODO.

## 2026-06-04: stage2c technical report and reproducibility package

- Commit hash: 78d7b7f
- Completed:
  - Added `docs/13_technical_report_v0.1.md` as the initial technical report draft.
  - Added `reproducibility/README.md` for lab0/lab1 reproduction steps and teammate review template.
  - Added `videos/demo_script.md` for a short lab0/lab1 demo plan.
  - Updated `slides/README.md` with the initial PPT structure plan.
  - Updated `README.md` to include the technical report, reproducibility package, demo script, and current status.
  - Updated `scripts/collect-report.sh` and regenerated `submissions/draft-report-index.md`.
  - Updated AI usage record for stage2c.
- Verification run in this stage:
  - `bash scripts/check-env.sh`
  - `bash scripts/xv6/check-xv6-baseline.sh`
  - `bash scripts/xv6/boot-xv6.sh`
  - `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"`
  - `bash scripts/collect-report.sh`
  - `git diff --check`
- Real result:
  - Environment precheck: OK for required base tools; `riscv64-unknown-elf-gcc` remains WARN.
  - Baseline structure check: OK.
  - Boot evidence: found.
  - hello output evidence: found.
- Boundaries:
  - No new OS feature was implemented in stage2c.
  - No lab2 implementation was started.
  - Second teammate independent reproduction remains TODO.
  - Manual interaction video remains TODO.
  - Third-party source and raw logs remain ignored and must not be committed.

## 2026-06-04: stage3a lab1 argint syscall extension

- Commit hash: 4675da7
- Completed:
  - Added lab1 advanced syscall design: `add2(int a, int b)`.
  - Implemented `sys_add2()` in ignored `external/xv6-riscv/`, using `argint(0, &a)` and `argint(1, &b)`.
  - Added user test program `add2test`.
  - Generated `patches/lab1-system-call/0002-add-argint-add2-syscall.patch` as an incremental patch after `0001`.
  - Verified clean baseline + `0001` + `0002` patch sequence.
  - Ran `make` in WSL/bash successfully.
  - Verified hello still outputs `hello syscall returned 2026`.
  - Verified add2test outputs `add2(20, 6) returned 26`.
  - Added `docs/14_lab1_argint_extension_review.md`.
  - Updated lab1 docs, patch docs, test report, technical report, reproducibility package, demo script, AI record, and report index.
- Real process notes:
  - A direct PowerShell `make` attempt failed because `make` was not available in Windows shell; WSL/bash make succeeded.
  - The first handwritten `0002` patch was malformed; it was regenerated with WSL Git as a clean incremental patch.
  - A Windows Git / WSL Git line-ending risk was observed and corrected by regenerating the patch with WSL Git.
- Boundaries:
  - No lab2/lab4 work was done.
  - Timeout command capture is not long-running stability testing.
  - Manual interaction video remains TODO.
  - Second teammate independent reproduction remains TODO.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.

## 2026-06-04: stage2b red-team lab1 patch reproducibility

- Commit hash: dd23660
- Role: strict reviewer + engineering red team + OS lab TA (Claude Code).
- Goal: verify the lab1 patch is reproducible from a clean baseline and that the evidence chain is honest enough for judges.
- Completed (real runs in WSL2 Ubuntu, inside the ignored `external/xv6-riscv/`):
  - Reviewed `0001-add-hello-syscall.patch`: only lab1-necessary files; no build artifacts/logs/personal paths; `SYS_hello 22` has no conflict; full user->kernel chain present.
  - Reset the ignored baseline tree to commit `74f84181a3404d1d6a6ff98d342233979066ebb8` with `git reset --hard` + `git clean -fdx`; confirmed CLEAN.
  - `git apply --check` returned exit 0 (patch applies cleanly to clean baseline).
  - `git apply` then `make` (clean full build) succeeded (exit 0); only the known `LOAD segment with RWX permissions` linker warning.
  - Captured `hello syscall returned 2026` from xv6 shell (COMMAND_EVIDENCE_FOUND).
  - Added `docs/12_lab1_patch_review.md` (reproduction review report).
  - Added `scripts/xv6/apply-lab1-patch.sh` (preview by default; `--run` resets clean + applies; `--make` optional).
  - Corrected stale README status (baseline imported, lab1 minimal hello verified) without overstating; framed lab1 as a minimal syscall closed loop.
  - Recorded the independent reproduction in `docs/04_test_report.md` and linked it from `tests/lab1/README.md`.
- Real result:
  - clean baseline apply: PASS (`git apply --check` exit 0)
  - clean make: PASS (exit 0)
  - hello output: `hello syscall returned 2026`
  - stage2b make log (ignored): `logs/xv6-make-20260604-004515.log`
  - stage2b hello log (ignored): `logs/xv6-command-hello-20260604-004630.log`
- Boundaries:
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and were not committed (verified `git ls-files` empty for both).
  - Evidence is timeout-based capture, not a long-running stability test or full manual interaction.
  - Single-person + AI reproduction; second-person independent reproduction remains TODO.
- Next:
  - Have a second team member reproduce on another machine per `docs/12` section 9.
  - Consider a lab1 extension syscall that demonstrates argument passing.

## 2026-06-04: stage3b red-team lab1 argint extension and teaching value

- Commit hash: 2b28763
- Role: strict reviewer + OS lab TA + engineering red team (Claude Code).
- Goal: verify the `0002` add2 argint patch is reproducible on top of `0001`, and judge whether lab1 is becoming a teaching lab system rather than two demos.
- Completed (real runs in WSL2 Ubuntu, inside the ignored `external/xv6-riscv/`):
  - Reviewed `0002-add-argint-add2-syscall.patch`: incremental on top of `0001` (its baseline blob indexes equal `0001` output blobs), no overlap; `SYS_add2 23` has no conflict; `argint(0,&a)/argint(1,&b)` correct; `add2test` minimal.
  - Reset the ignored tree to clean baseline `74f84181a3404d1d6a6ff98d342233979066ebb8`; applied `0001` then `0002` (both `git apply --check` exit 0).
  - Clean `make` succeeded (exit 0); only the known `LOAD segment with RWX permissions` linker warning.
  - Captured `hello syscall returned 2026` and `add2(20, 6) returned 26` (both COMMAND_EVIDENCE_FOUND).
  - Strengthened `docs/14_lab1_argint_extension_review.md`: added overall conclusion, add2 call chain, an actual `argint()` mechanism explanation (registers -> trapframe -> argraw), independent reproduction results, a teaching-value assessment, and a judge reproduction path.
  - Fixed `docs/13` section 3.4 (add2 is done, not future) and added an explicit "not all syscall mechanisms covered" note.
  - Added a "teaching next steps (student exercises, design/TODO)" section and an "uncovered" note to `labs/lab1-system-call/README.md`.
- Real result:
  - clean baseline + `0001` + `0002` apply: PASS (`git apply --check` exit 0 for both)
  - clean make: PASS (exit 0)
  - hello output: `hello syscall returned 2026`
  - add2test output: `add2(20, 6) returned 26`
  - stage3b logs (ignored): `logs/xv6-make-20260604-081018.log`, `logs/xv6-command-add2test-20260604-081330.log`
- Red-team teaching-value verdict:
  - lab1 is now an honest, reproducible, two-tier syscall mini-lab (hello -> add2/argint), but NOT yet a full teaching lab system.
  - Missing for a teaching system: student do-it tasks, negative/failure labs, pointer/string args (`argaddr`/`argstr`), boundary cases, and a grading rubric. These are recorded as design/TODO, not claimed done.
- Boundaries:
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and were not committed (verified `git ls-files` empty for both).
  - Evidence is timeout-based capture, not long-running stability or manual interaction.
  - Single-person + AI reproduction; second-person independent reproduction remains TODO; manual demo video remains TODO; no lab2 work was done.
- Next:
  - Build the lab1 student-exercise version (skeleton + rubric) to move toward a teaching lab.
  - Have a second team member reproduce on another machine.

## 2026-06-04: stage4a lab2 process state observation

- Commit hash: 20d43a4
- Completed:
  - Added lab2 experiment design: `pstate(int pid)` process state observation.
  - Implemented `sys_pstate()` in ignored `external/xv6-riscv/`.
  - Added `pstatetest` user program.
  - Generated independent patch `patches/lab2-process-observation/0001-add-pstate-syscall.patch`.
  - Verified clean baseline + lab2 patch apply.
  - Ran `make` in WSL/bash successfully.
  - Verified `pstatetest` output prefix `pstate(self) =`.
  - Verified actual status text `RUNNING`; observed `pstate(self) = 4 (RUNNING)`.
  - Added `docs/15_lab2_process_observation_review.md`.
  - Updated lab2 docs, patch README, test report, technical report, reproducibility package, demo script, slides plan, AI record, and report index.
- Real result:
  - clean apply: PASS
  - make: PASS
  - pstatetest output: PASS
- Boundaries:
  - lab2 patch is independent from lab1 patch.
  - No full `ps` implementation.
  - No scheduler modification.
  - Timeout capture is not long-running stability testing.
  - Manual interaction video remains TODO.
  - Second teammate independent reproduction remains TODO.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.

## 2026-06-04: stage4b red-team lab2 process observation and patch strategy

- Commit hash: 06d3b4a
- Role: strict reviewer + OS lab TA + engineering red team (Claude Code).
- Goal: judge whether lab2 works as a process-observation v0.1, and whether lab1/lab2 patches will conflict in a future integrated demo.
- Completed (real runs in WSL2 Ubuntu, inside the ignored `external/xv6-riscv/`):
  - Reviewed `0001-add-pstate-syscall.patch`: independent from clean baseline; only pstate/pstatetest changes; `argint(0,&pid)` correct; proc table loop acquires/releases `p->lock` on every path; returns -1 when not found or pid<0.
  - Reset to clean baseline `74f84181a3404d1d6a6ff98d342233979066ebb8`; applied lab2 patch (`git apply --check` exit 0); clean `make` exit 0; captured `pstate(self) = 4 (RUNNING)`.
  - MEASURED the lab1/lab2 conflict: lab2 patch does NOT apply on top of lab1 `0001` (or `0001`+`0002`) — `git apply --check` exit 1, all 6 files "patch does not apply"; and `SYS_hello` = `SYS_pstate` = 22.
  - Wrote `docs/16_patch_strategy_and_integration_plan.md` (current patch types, why lab2 is independent, measured conflict, integrated-labs plan with re-planned numbers hello=22/add2=23/pstate=24, current conclusion).
  - Strengthened `docs/15`: red-team teaching limits (pstate(self) is tautologically RUNNING; user/kernel enum coupling; snapshot semantics), quantified the lab1/lab2 collision, added stage4b reproduction results.
  - Fixed combined-build ambiguity: reproducibility "manual" section now says lab1 and lab2 are two separate builds; README step 7 notes the reset wipes lab1; patches/lab2 README and docs/13 link to docs/16.
- Real result:
  - lab2 clean apply: PASS (`git apply --check` exit 0)
  - lab2 clean make: PASS (exit 0)
  - pstatetest output: PASS (`pstate(self) = 4 (RUNNING)`, both `pstate(self) =` and `RUNNING` patterns)
  - lab1+lab2 combined apply: FAILS by design (exit 1; SYS number 22 collision) — this is a finding, not a regression
  - stage4b logs (ignored): `logs/xv6-make-20260604-122410.log`, `logs/xv6-command-pstatetest-20260604-122530.log`
- Red-team verdict:
  - lab2 is a correct, reproducible process-observation INTRO (proc table + lock), suitable as a v0.1, but NOT a full scheduling experiment; observing self is near-tautological RUNNING, so observing other/child processes is the real next step.
  - lab1 and lab2 patches are individually reproducible but CANNOT be combined as-is; an integrated patch sequence with re-planned syscall numbers is required for any unified demo (docs/16).
- Boundaries:
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and were not committed (verified `git ls-files` empty for both).
  - Evidence is timeout-based capture, not long-running stability or manual interaction.
  - No lab3/lab4 work; no integrated patch built this round (TODO for stage4c/5a).
- Next:
  - Build `patches/integrated-labs/` unified sequence (hello=22, add2=23, pstate=24) and validate all three in one build.
  - Extend lab2 to observe a child/other pid to show non-RUNNING states; add negative tests.

## 2026-06-04: stage4c integrated lab1 lab2 patch sequence

- Commit hash: 799e4e9
- Completed:
  - Added `patches/integrated-labs/`.
  - Copied lab1 `0001` and `0002` into the integrated sequence after verifying they apply from clean baseline in order.
  - Generated `patches/integrated-labs/0003-add-pstate-syscall.patch` on top of integrated `0001` + `0002`.
  - Unified syscall numbers for the comprehensive demo: `SYS_hello = 22`, `SYS_add2 = 23`, `SYS_pstate = 24`.
  - Verified clean baseline + integrated `0001` + `0002` + `0003` apply.
  - Ran `make` successfully in WSL/bash.
  - Captured boot evidence.
  - Captured `hello syscall returned 2026`.
  - Captured `add2(20, 6) returned 26`.
  - Captured `pstate(self) =` and `RUNNING`.
  - Added `patches/integrated-labs/README.md`.
  - Updated patch strategy, test report, technical report, README, reproducibility package, demo script, slides plan, AI record, collect-report script, and submission index.
- Real result:
  - clean apply: PASS
  - make: PASS
  - boot evidence: PASS
  - hello output: PASS
  - add2test output: PASS
  - pstatetest output: PASS
- Boundaries:
  - integrated-labs is a separate comprehensive demo sequence; it does not replace lab1/lab2 independent patches.
  - Timeout capture is not long-running stability testing.
  - Manual interaction video remains TODO.
  - Second teammate independent reproduction remains TODO.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.
- Next:
  - Have a second team member reproduce the integrated sequence on another machine.
  - Record an actual manual demo only after confirming no private information is visible.
  - Consider lab2 child-process observation or negative tests as the next teaching extension.

## 2026-06-04: stage4d red-team integrated-labs patch sequence

- Commit hash: 6ea5fd7
- Role: strict reviewer + OS lab TA + engineering red team (Claude Code).
- Goal: verify integrated-labs really solves the combined demo (all three programs in one xv6 build) and that docs are no longer stale.
- Completed (real runs in WSL2 Ubuntu, inside the ignored `external/xv6-riscv/`):
  - Patch audit: integrated `0001`/`0002` are byte-identical to lab1 `0001`/`0002`; `0003` is incremental on `0001`+`0002` (base blobs equal `0002` outputs) and uses `SYS_pstate = 24` (no collision with `SYS_hello = 22`); `0003` pstatetest.c equals lab2's; no build artifacts/logs/personal paths; original independent patches unchanged.
  - Reset to clean baseline `74f84181a3404d1d6a6ff98d342233979066ebb8`; applied integrated `0001`+`0002`+`0003` (all `git apply --check` exit 0); tree has hello.c + add2test.c + pstatetest.c; syscall.h tail shows hello=22/add2=23/pstate=24.
  - Clean `make` exit 0 (only known RWX warning).
  - From the SAME build: boot `BOOT_EVIDENCE_FOUND`; captured `hello syscall returned 2026`, `add2(20, 6) returned 26`, `pstate(self) = 4 (RUNNING)`.
  - Added `docs/17_integrated_labs_review.md`; linked it from `docs/16` and README quick-path.
- Real result:
  - integrated `0001`+`0002`+`0003` clean apply: PASS (all --check exit 0)
  - clean make: PASS
  - hello / add2test / pstatetest in one build: PASS
  - stage4d logs (ignored): `logs/xv6-make-20260604-160800.log` and the corresponding command logs
- Red-team verdict:
  - integrated-labs PASSES: it genuinely runs hello/add2test/pstatetest in a single xv6 build with no syscall-number collision, solving the stage4b conflict.
  - No patch change was needed. Independent and integrated patch sets remain correctly distinct (independent pstate=22, integrated pstate=24); docs keep them separate and do not claim arbitrary composability.
- Boundaries:
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and were not committed (verified `git ls-files` empty for both).
  - Evidence is timeout-based capture, not long-running stability or manual interaction.
  - lab2 is still process-observation v0.1; lab3/lab4 not done; manual video and second-person reproduction remain TODO.
- Next:
  - Consider `scripts/xv6/apply-integrated-labs.sh` (preview/--run/--make) to lower judge reproduction friction.
  - Second teammate reproduces the integrated sequence; record a real manual demo.

## 2026-06-04: stage4e integrated labs apply helper

- Commit hash: 23dd28e
- Completed:
  - Added `scripts/xv6/apply-integrated-labs.sh`.
  - Default mode is preview only; it checks target directory, baseline commit, patch files, and prints planned operations without reset/apply/make.
  - `--run --yes` resets and cleans ignored `external/xv6-riscv/`, then applies integrated `0001` + `0002` + `0003`.
  - `--make --yes` implies `--run`, then runs `make` and saves `logs/integrated-make-YYYYMMDD-HHMMSS.log`.
  - Updated integrated patch README, reproducibility package, Demo script, README, technical report, integrated review, AI usage record, and report index script.
- Real validation:
  - `bash scripts/xv6/apply-integrated-labs.sh`: PASS; preview mode only printed status and planned operations, with no reset/apply/make.
  - External tree status before and after preview was unchanged.
  - `bash scripts/xv6/apply-integrated-labs.sh --make --yes`: PASS; reset/cleaned ignored `external/xv6-riscv/`, applied integrated `0001` + `0002` + `0003`, and completed `make`.
  - Make log: `logs/integrated-make-20260604-163022.log` (ignored, not committed).
  - `bash scripts/xv6/boot-xv6.sh`: PASS; boot evidence found.
  - `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pstatetest "RUNNING"`: PASS.
- Boundaries:
  - The helper only operates on ignored `external/xv6-riscv/` and ignored `logs/*.log`.
  - No remote changes.
  - No manual recording or teammate reproduction is claimed.

## 2026-06-04: stage4f red-team integrated apply helper safety

- Commit hash: 7aad2af
- Role: strict reviewer + engineering red team + OS lab TA (Claude Code).
- Goal: verify `scripts/xv6/apply-integrated-labs.sh` is safe and reproducible enough for teammates/judges.
- Finding and fix:
  - The `--yes` confirmation gate was CONDITIONAL: it only required `--yes` when the ignored xv6 tree had local changes. On a porcelain-clean tree, `--run`/`--make` would run `git reset --hard` + `git clean -fdx` WITHOUT `--yes` (still deletes ignored build artifacts), contradicting the documented `--run --yes`/`--make --yes` contract.
  - Fixed: `--run`/`--make` now ALWAYS require `--yes`; otherwise they print `[ERROR]` and exit 1. Updated the safety-model comment and the preview `[INFO]` note (0002 needs 0001; 0003 needs 0001+0002).
- Audit result (12 checks): preview is read-only; baseline commit pinned; 3 patches existence-checked; ordered apply with per-step `git apply --check`; make log to `logs/integrated-make-*.log` (ignored); no main-repo tracked files touched; non-zero exit on failure; space-containing repo path handled via quoted `git rev-parse --show-toplevel`; clear `[OK]`/`[WARN]`/`[ERROR]` output.
- Real verification (Git Bash gate + WSL2 build/run):
  - `bash -n` syntax OK.
  - preview: exit 0; external HEAD and `git status --porcelain` unchanged before/after.
  - `--run` without `--yes`: exit 1 (`[ERROR] refusing to reset/clean ... without --yes`).
  - `--make` without `--yes`: exit 1 (same gate).
  - `--make --yes`: exit 0; reset clean baseline, applied integrated `0001`+`0002`+`0003`, `make` succeeded; log `logs/integrated-make-20260604-204228.log` (ignored).
  - boot: `BOOT_EVIDENCE_FOUND`; hello `hello syscall returned 2026`; add2test `add2(20, 6) returned 26`; pstatetest `pstate(self) = 4 (RUNNING)`.
- Added `docs/18_integrated_helper_review.md`; linked from docs/17 and README quick-path; updated reproducibility note and collect-report helper status to the `--yes`-always behavior.
- Boundaries:
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and were not committed (verified `git ls-files` empty for both).
  - Evidence is timeout-based capture, not long-running stability or manual interaction.
  - Manual interaction video and second-person reproduction remain TODO; lab3/lab4 not done.
- Next:
  - Optional `--baseline <commit>` flag for judges to confirm baseline explicitly.
  - Second teammate reproduces via the helper on another machine; record a real manual demo.

## 2026-06-04: stage5a lab2 v0.2 process observation extension

- Commit hash: 10e5d3f
- Goal: extend lab2 beyond `pstate(self)` by adding process-state counting, child-process observation, and negative input checks in the integrated-labs path.
- Completed:
  - Added `patches/integrated-labs/0004-extend-process-observation.patch`.
  - Added integrated syscall number `SYS_pcount = 25`, keeping `hello=22`, `add2=23`, `pstate=24`.
  - Added `pcount(int state)` with `argint(0, &state)`, valid state range check, and per-process `p->lock` while reading `p->state`.
  - Added user programs `pcounttest` and `pchildtest`.
  - Updated `scripts/xv6/apply-integrated-labs.sh` so the helper applies integrated `0001`+`0002`+`0003`+`0004`.
  - Documented a real implementation issue: the originally planned command name `pstatechildtest` caused `mkfs` failure because xv6 `DIRSIZ` limits directory entry names; the program was shortened to `pchildtest`, while its output remains `pstate(child) = ...`.
- Real validation:
  - `bash scripts/xv6/apply-integrated-labs.sh`: PASS; preview only.
  - `bash scripts/xv6/apply-integrated-labs.sh --make --yes`: PASS; clean baseline + integrated `0001-0004` applied and `make` succeeded.
  - `bash scripts/xv6/boot-xv6.sh`: PASS; boot evidence found.
  - `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh add2test "add2(20, 6) returned 26"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pstatetest "pstate(self) ="`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(RUNNING) ="`: PASS; actual observed value included `pcount(RUNNING) = 1`, but the number is not fixed by the test.
  - `bash scripts/xv6/run-xv6-command.sh pcounttest "pcount(99) = -1"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pchildtest "pstate(child) ="`: PASS; actual observed states included `RUNNABLE` and `SLEEPING` in local logs, so docs only require the stable prefix.
- Boundaries:
  - This is lab2 process observation v0.2, not a full `ps` tool and not a scheduler modification.
  - Evidence is timeout-based capture, not long-running stability or manual interaction.
  - Manual interaction video and second-person reproduction remain TODO.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.

## 2026-06-04: stage5b red-team review of lab2 v0.2 process observation

- Commit hash: 932bb0a
- Goal: strictly re-verify whether lab2 v0.2 truly improves teaching depth and whether the `0004` patch is clean, reproducible, and safe.
- Verdict: `0004` patch is clean/minimal/correct and needs NO code change; v0.2 genuinely deepens teaching over v0.1. Work this round is documentation + honest-boundary completion only.
- `0004` patch audit (read-only):
  - Contains ONLY `pcount`/`pcounttest`/`pchildtest` increments — no 0001/0002/0003 content, no build artifacts, logs, personal paths, or temp files.
  - Reuses the `extern struct proc proc[NPROC];` that `0003` added to `kernel/sysproc.c` (no duplicate declaration); correct incremental layering, must apply after `0003`.
  - `SYS_pcount = 25` does not collide (22/23/24/25).
  - `sys_pcount` uses `argint(0, &state)`; in this baseline `argint` returns `void`, so there is no return to check (matches `sys_pause`/`sys_add2`/`sys_pstate`).
  - Range check `state < UNUSED || state > ZOMBIE` == `0..5` for `enum procstate {UNUSED..ZOMBIE}`; compiles clean under `-Wall -Werror`.
  - Locking is correct: per-slot `acquire/release(&p->lock)`; the running caller does NOT hold its own `p->lock` in the kernel, so scanning its own slot does not self-deadlock. Limitation (not a bug): one lock at a time means the count is a non-atomic aggregate, not a whole-table snapshot.
  - `pcount(99) = -1` and `pstate(-1) = -1` are real, working negative tests.
- Real validation (clean baseline, WSL2 Ubuntu-24.04):
  - `apply-integrated-labs.sh --make --yes`: PASS; clean reset + apply `0001-0004` (all `git apply --check`/apply `[OK]`) + `make` exit 0.
  - `boot-xv6.sh`: PASS.
  - hello / add2test / pstatetest / pcounttest(`pcount(RUNNING) =`) / pcounttest(`pcount(99) = -1`) / pchildtest(`pstate(child) =`): all PASS.
  - Observed values: `pstate(self) = 4 (RUNNING)`, `pcount(RUNNING) = 1` (not fixed), `pcount(99) = -1`; `pchildtest` printed BOTH `3 (RUNNABLE)` and `2 (SLEEPING)` within a single boot — direct evidence of scheduling-timing nondeterminism.
- Findings:
  - Benign, reproducible `git apply` warning `warning: user/usys.pl has type 100644, expected 100755` on every patch; apply + make still succeed. Cause: `/mnt/d` (NTFS over WSL) `core.filemode=false` drops the executable bit; upstream `usys.pl` is `100755`. Documented in `docs/19`; patches intentionally NOT re-exported.
  - No residual wrong command name: all `pstatechildtest` mentions are historical rename explanations; the actual command is `pchildtest` everywhere.
  - `pchildtest`/`pcounttest` depend on the baseline's `pause` (this pinned baseline renamed xv6 `sleep` → `pause`); safe only under the pinned `baseline commit 74f84181...`.
- Boundaries:
  - Evidence is timeout-based capture, not long-running stability or manual interaction.
  - Manual interaction video and second-person reproduction remain TODO; lab3/lab4 not done.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.

## 2026-06-04: stage6a lab4 file table observation experiment

- Commit hash: 8523298
- Goal: add a scoped lab4 file table observation experiment with both independent patch and integrated demo patch.
- Completed:
  - Added `patches/lab4-file-table-observation/0001-add-fcount-syscall.patch`.
  - Added `patches/lab4-file-table-observation/README.md`.
  - Added integrated `patches/integrated-labs/0005-add-file-table-observation.patch`.
  - Added `fcount()` syscall and `fcounttest` in the ignored local xv6 tree before exporting patches.
  - Updated `scripts/xv6/apply-integrated-labs.sh` so the helper applies integrated `0001-0005`.
  - Updated lab4 docs, lab4 tests, integrated patch docs, test report, AI record, progress log, and submission material index.
- Real validation:
  - independent lab4 patch from clean baseline: apply PASS, `make` PASS, `fcounttest done` captured.
  - integrated `0001-0005` from clean baseline: helper preview PASS, `--make --yes` PASS, boot evidence PASS.
  - regression commands captured: `hello syscall returned 2026`, `add2(20, 6) returned 26`, `pstate(self) =`, `pcount(RUNNING) =`, `pcount(99) = -1`, `pstate(child) =`.
  - lab4 commands captured: `fcount(before) =`, `fcount(after_open) =`, `fcount(after_close) =`, `fcounttest done`.
- Boundaries:
  - This is file table observation, not a complete file system experiment.
  - `fcount(...)` numeric values are not fixed; local logs showed one sample but the test only uses stable prefixes.
  - Timeout capture is not long-running stability or manual interaction.
  - Manual video and second teammate reproduction remain TODO.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.

## 2026-06-05: stage6b red-team review of lab4 file table observation

- Commit hash: b493333
- Goal: strictly re-verify whether lab4 has real teaching value, whether `fcount`/`filecount` is correct/safe, and whether the independent and integrated patches are clean and reproducible.
- Verdict: independent lab4 patch and integrated `0005` are clean/minimal/correct/safe and need NO code change; lab4 genuinely bridges user fd → kernel `struct file` → `ref` → `ftable.lock`, but remains a file-table count observation, not a full file-system lab. Work this round is documentation + honest-boundary completion only.
- Patch audit (read-only):
  - Independent and integrated patches share byte-identical core logic (`filecount()` in `kernel/file.c`, `sys_fcount()` in `kernel/sysfile.c`, `user/fcounttest.c`); they differ only in `SYS_fcount` number (independent `22` after clean-baseline `SYS_close=21`; integrated `26` after `SYS_pcount=25`) and surrounding context.
  - `0005` adds only fcount/fcounttest increments; no 0001-0004 content duplicated; helper `PATCHES` includes `0005`.
  - `sys_fcount()` is correctly placed in `kernel/sysfile.c` (with the other file syscalls), not `kernel/sysproc.c`; takes no args; returns `filecount()`.
  - `filecount()` acquires only `ftable.lock`, counts `f->ref > 0` over `ftable.file[NFILE]` (NFILE=100), releases; reads `f->ref` under the same lock as `filealloc`/`filedup`/`fileclose`. No nested lock → no deadlock. Returns only an int and never touches `f->ip`/`f->pipe`/paths/content → no information leak.
  - `fcounttest` does `unlink → before=fcount → open(O_CREATE|O_RDWR) → after_open=fcount → write → close → after_close=fcount → unlink → print + done`; prints only, asserts nothing (no fixed number).
- Real validation (clean baseline, WSL2 Ubuntu-24.04):
  - A) independent lab4 patch: `git apply` (only the benign `usys.pl` mode warning) + `make` exit 0 + boot + `fcounttest done`; 9 files changed; observed `fcount(before)=1, after_open=2, after_close=1`.
  - B) integrated `0001-0005` via `apply-integrated-labs.sh --make --yes`: 5 patches all `[OK]`, `make` exit 0 (log `logs/integrated-make-20260605-071545.log`), boot evidence, and hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest all captured.
  - The `open`→`close` delta `+1/-1` was stable across both builds; the absolute number (1) is environment-dependent and intentionally not asserted.
- Findings:
  - Benign reproducible `git apply` warning `warning: user/usys.pl has type 100644, expected 100755` (same `/mnt/d` `core.filemode` cause as lab1/lab2 patches; apply + make still succeed).
  - `make` emits the baseline `riscv64-linux-gnu-ld: warning: kernel/kernel has a LOAD segment with RWX permissions` — a stock-xv6 + binutils warning unrelated to fcount; build still succeeds.
  - stage6a's first-boot timeout is a `/mnt/d` mtime-skew rebuild effect; this run's boots captured directly because fs.img was already built.
- Boundaries:
  - File table observation only; no inode observation, no fdinfo, no per-process fd table query.
  - Timeout capture is not long-running stability or manual interaction.
  - lab3 not done; manual video and second teammate reproduction remain TODO.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.

## 2026-06-05: stage6c boot evidence timeout and retry hardening

- Commit hash: 2e0048f
- Goal: reduce false boot evidence failures after clean build when `make qemu` spends the first timeout window rebuilding `fs.img` or reacting to `/mnt/d` mtime skew.
- Completed:
  - Updated `scripts/xv6/boot-xv6.sh`.
  - Default boot timeout changed from 20 seconds to 45 seconds per attempt.
  - Default attempts changed to 2.
  - Added `XV6_BOOT_TIMEOUT_SECONDS` and `XV6_BOOT_RETRIES` environment variable overrides.
  - Each attempt now writes a separate ignored log: `logs/xv6-boot-YYYYMMDD-HHMMSS-attemptN.log`.
  - Script exits 0 only when the same attempt detects both `xv6 kernel is booting` and `init: starting sh`.
  - Script exits non-zero if all attempts fail.
  - Updated README, test report, technical report, lab4 review, reproducibility package, demo script, AI record, and material index.
- Real validation:
  - `bash scripts/xv6/apply-integrated-labs.sh --make --yes`: PASS; clean baseline + integrated `0001-0005` applied and `make` succeeded.
  - `bash scripts/xv6/boot-xv6.sh`: PASS; default 45s / 2 attempts, attempt 1 captured `xv6 kernel is booting` and `init: starting sh`.
  - `XV6_BOOT_TIMEOUT_SECONDS=60 XV6_BOOT_RETRIES=2 bash scripts/xv6/boot-xv6.sh`: PASS; override displayed 60s / 2 attempts, attempt 1 captured boot evidence.
  - `hello`, `add2test`, `pstatetest`, `pcounttest`, `pchildtest`, and `fcounttest` command evidence checks all passed.
- Boundaries:
  - No xv6 patch or OS feature was changed.
  - Timeout exit code 124 is documented as not automatically proving permanent boot failure.
  - This is boot evidence capture hardening, not long-running stability testing.
  - Manual video and second teammate reproduction remain TODO.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.

## 2026-06-05: stage6d red-team submission-readiness review

- Commit hash: a07d555
- Goal: assess whether the repo is trustworthy, reproducible, and presentable for the preliminary (初赛) submission; full integrated reproduction + whole-repo doc consistency audit.
- Verdict: trustworthy / reproducible / presentable, but NOT yet submission-complete. Honest MVP is submittable now; awards require teammate reproduction + manual recording + lab3 or deeper lab4. No OS feature or patch changed this round (documentation only).
- Real validation (WSL2 Ubuntu-24.04, clean baseline):
  - `check-env.sh` / `check-xv6-baseline.sh`: PASS (qemu + riscv64-linux-gnu-gcc present; `riscv64-unknown-elf-gcc` WARN, optional).
  - `apply-integrated-labs.sh` preview: PASS (lists `0001-0005`).
  - `apply-integrated-labs.sh --make --yes`: PASS; 5 patches `[OK]`; `make` exit 0 (log `logs/integrated-make-20260605-081851.log`).
  - `boot-xv6.sh` default 45s/2: PASS (attempt 1 `BOOT_EVIDENCE_FOUND`).
  - `XV6_BOOT_TIMEOUT_SECONDS=60 XV6_BOOT_RETRIES=2 boot-xv6.sh`: PASS (attempt 1; env overrides honored, timeout shown as 60s).
  - hello / add2test / pstatetest / pcounttest(`pcount(RUNNING) = 1`, `pcount(99) = -1`) / pchildtest(`2 (SLEEPING)` and `3 (RUNNABLE)` in one boot) / fcounttest(`before=1, after_open=2, after_close=1`, `fcounttest done`): all PASS — 10 expected prefixes captured.
- Doc consistency audit (README, docs/04/13/17/18/19/20, reproducibility, videos, slides, patches/integrated-labs, labs/lab1/lab2/lab4, submissions index): no fabrication or overclaim found.
  - integrated final path unified to `0001-0005`; residual `0001-0004` are historical records or correct "0005 applies after 0001-0004" statements.
  - No real `pstatechildtest` command invocation (all are rename explanations); command is `pchildtest` everywhere.
  - No fixed `pcount(RUNNING)=1` or fcount number promised (all qualified as not-fixed).
  - lab3 not claimed done; lab4 explicitly "file table observation only, not a full file system"; recording/teammate/long-running stability all TODO.
  - GitLab-as-main-repo and external/logs-not-committed both stated.
- Changes this round (documentation only):
  - Added `docs/21_submission_readiness_review.md`.
  - README: added `docs/20` and `docs/21` to the judge quick-path; added an explicit WSL2 build-requirement note to 快速开始; added a stage6d section.
  - Updated `docs/05_ai_usage_record.md`, `docs/06_progress_log.md`, `scripts/collect-report.sh`, `submissions/draft-report-index.md`.
- Most serious risks: teammate independent reproduction (TODO) and manual recording (TODO) — all evidence is single-machine timeout capture; plus lab3 not done and lab4 not a full file system.
- Boundaries:
  - All PASS is timeout-captured text only; not long-running stability, manual recording, or teammate reproduction.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.
