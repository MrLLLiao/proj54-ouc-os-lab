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

## 2026-06-06: stage7a0 qemu cleanup and outer timeout hardening

- Commit hash: TODO after commit
- Goal: fix teammate reproduction getting stuck at `[STEP] attempt 1/2`, especially when `make qemu`, QEMU, `timeout`, `Ctrl+C`, `Ctrl+Z`, or `/mnt/d` mtime skew leaves a long-running or suspended process.
- Completed:
  - Updated `scripts/xv6/boot-xv6.sh`.
  - Added default boot hard timeout: `max(XV6_BOOT_TIMEOUT_SECONDS + 15, 75)`, overrideable with `XV6_BOOT_HARD_TIMEOUT_SECONDS`.
  - Added `EXIT` / `INT` / `TERM` / `TSTP` cleanup traps.
  - Added current-project process cleanup for matching `qemu-system-riscv64` and `make qemu` processes, plus manual cleanup hints.
  - Kept boot success criteria unchanged: the same log attempt must contain both `xv6 kernel is booting` and `init: starting sh`.
  - Updated `scripts/xv6/run-xv6-command.sh`.
  - Changed command default timeout to 60s, default retries to 2, and added `XV6_COMMAND_HARD_TIMEOUT_SECONDS`.
  - Wrapped both `fs.img` build and command QEMU run with hard timeout and cleanup.
  - Fixed a false-positive risk found during validation: the script no longer writes `EXPECTED_TEXT` into the log before grepping that same log.
  - Added `docs/22_teammate_reproduction_troubleshooting.md`.
  - Updated README, reproducibility package, submission checklist, AI record, report index script, and generated material index.
- Real validation (WSL2 Ubuntu-24.04):
  - `bash -n scripts/xv6/boot-xv6.sh`: PASS.
  - `bash -n scripts/xv6/run-xv6-command.sh`: PASS.
  - `bash scripts/xv6/apply-integrated-labs.sh --make --yes`: PASS; `make` exit 0; log `logs/integrated-make-20260606-154044.log` ignored by Git.
  - `bash scripts/xv6/boot-xv6.sh`: PASS; attempt 1 `BOOT_EVIDENCE_FOUND`; 45s soft timeout / 75s hard timeout displayed.
  - `XV6_BOOT_TIMEOUT_SECONDS=10 XV6_BOOT_RETRIES=1 XV6_BOOT_HARD_TIMEOUT_SECONDS=20 bash scripts/xv6/boot-xv6.sh`: PASS; attempt 1 `BOOT_EVIDENCE_FOUND`.
  - `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"`: PASS after the expected-text header fix; log grep showed the expected text in QEMU output lines.
  - `XV6_COMMAND_TIMEOUT_SECONDS=30 XV6_COMMAND_RETRIES=1 XV6_COMMAND_HARD_TIMEOUT_SECONDS=45 bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"`: PASS.
  - `bash scripts/collect-report.sh`: PASS.
- Boundaries:
  - No OS feature was added.
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.
  - Evidence remains timeout-captured log matching, not long-running stability testing, manual recording, or teammate independent reproduction.

## 2026-06-06: stage7a1 teammate one-shot verification workflow

- Commit hash: TODO after commit
- Goal: make teammate reproduction a one-command workflow so teammates do not need to remember every xv6/QEMU command or diagnose Ctrl+Z/QEMU cleanup from scratch.
- Completed:
  - Added `scripts/xv6/cleanup-qemu.sh`.
  - The cleanup helper lists possible `qemu-system-riscv64` / `make qemu` processes, explains `Ctrl+C` vs `Ctrl+Z`, prints `jobs -l` / `kill %1` guidance, runs `pkill -f qemu-system-riscv64 || true` and `pkill -f "make qemu" || true`, and exits 0.
  - Added `scripts/xv6/teammate-verify.sh`.
  - The one-shot verifier prints project/time/cwd/uname/commit/user, runs environment + baseline checks, runs integrated apply+make, boot evidence, and hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest checks.
  - The verifier records PASS/FAIL per step, stops after critical failures, and always writes a summary under ignored `logs/teammate-verify-YYYYMMDD-HHMMSS.summary.txt`.
  - Added make timeout to `scripts/xv6/apply-integrated-labs.sh`: `XV6_MAKE_TIMEOUT_SECONDS`, default 600 seconds, with timeout-hit output and cleanup hint.
  - Added `docs/23_teammate_quickstart.md`.
  - Updated `.gitignore` so teammate summary and console output under `logs/` remain ignored.
  - Updated README, reproducibility package, submission checklist, AI record, report index script, and generated material index.
- Real validation (WSL2 Ubuntu-24.04):
  - `bash -n scripts/xv6/cleanup-qemu.sh`: PASS.
  - `bash -n scripts/xv6/teammate-verify.sh`: PASS.
  - `bash -n scripts/xv6/apply-integrated-labs.sh`: PASS.
  - `bash scripts/xv6/cleanup-qemu.sh`: PASS; no QEMU/make qemu process found; exit 0.
  - `bash scripts/xv6/teammate-verify.sh`: PASS end-to-end with default timeouts.
  - One-shot summary file: `logs/teammate-verify-20260606-160351.summary.txt` (ignored).
  - Summary result: environment PASS, check-env PASS, baseline PASS, apply+make PASS, boot PASS, hello PASS, add2test PASS, pstatetest PASS, pcounttest PASS, pchildtest PASS, fcounttest PASS.
  - `apply-integrated-labs.sh --make --yes` inside the one-shot run used the new make timeout display (`make timeout : 600s`) and make completed successfully.
- Boundaries:
  - No OS feature was added.
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.
  - The one-shot run is still timeout-captured evidence, not long-running stability, manual recording, or a second teammate's independent reproduction.

## 2026-06-06: stage7a2 polish one-shot verification UX before teammate testing

- Commit hash: TODO after commit
- Goal: make teammate official testing and team-lead pre-recording checks use clear one-shot commands with doctor, full/quick modes, local wrapper, copy-to-lead summary, and safer QEMU cleanup messaging.
- Completed:
  - Added `scripts/xv6/doctor.sh`.
  - The doctor script is read-only: it checks current time, cwd, uname, current commit, Git repo status, required tools, optional `riscv64-unknown-elf-gcc`, baseline files, logs ignored status, QEMU leftovers, and `/mnt/` path risk.
  - Updated `scripts/xv6/teammate-verify.sh` to support `--full`, `--quick`, and `--help`.
  - Added `INT` / `TERM` / `TSTP` handling in teammate verification so Ctrl+C/Ctrl+Z paths try cleanup and still write a summary.
  - `--full` runs doctor/check-env/baseline, clean integrated apply+make, boot, and hello/add2test/pstatetest/pcounttest/pcount invalid/pchildtest/fcounttest checks.
  - `--quick` runs doctor/check-env/baseline, skips clean apply+make, then runs boot and the same user-program checks.
  - The final summary includes a `COPY THIS SUMMARY TO TEAM LEAD` block and writes to ignored `logs/teammate-verify-YYYYMMDD-HHMMSS.summary.txt`.
  - Added `scripts/xv6/local-verify.sh` as a team-lead local pre-recording wrapper around teammate workflow.
  - Updated `scripts/xv6/cleanup-qemu.sh` output to explain `Ctrl+C` as interrupt, `Ctrl+Z` as suspend, list processes before/after cleanup, and warn that `pkill` is rescue-level.
  - Rewrote `docs/23_teammate_quickstart.md` so teammate official testing uses `bash scripts/xv6/teammate-verify.sh --full`, retesting after make uses `--quick`, team-lead pre-recording uses `local-verify.sh --quick`, and stuck cleanup uses `cleanup-qemu.sh`.
  - Updated `docs/22_teammate_reproduction_troubleshooting.md`, README, reproducibility package, submission checklist, AI usage record, report index script, and generated material index.
- Real validation (WSL2 Ubuntu-24.04):
  - `bash -n scripts/xv6/doctor.sh`: PASS.
  - `bash -n scripts/xv6/teammate-verify.sh`: PASS.
  - `bash -n scripts/xv6/local-verify.sh`: PASS.
  - `bash -n scripts/xv6/cleanup-qemu.sh`: PASS.
  - `bash scripts/xv6/doctor.sh`: PASS with expected warnings: optional `riscv64-unknown-elf-gcc` missing and current path under `/mnt/`.
  - `bash scripts/xv6/cleanup-qemu.sh`: PASS; no QEMU/make qemu process found.
  - `bash scripts/xv6/teammate-verify.sh --help`: PASS.
  - `bash scripts/xv6/local-verify.sh --help`: PASS.
  - `bash scripts/xv6/local-verify.sh --quick`: PASS; summary `logs/teammate-verify-20260606-163220.summary.txt` ignored; apply+make SKIPPED, boot and all user-program checks PASS.
  - `bash scripts/xv6/teammate-verify.sh --quick`: PASS; summary `logs/teammate-verify-20260606-164138.summary.txt` ignored; apply+make SKIPPED, boot and all user-program checks PASS.
  - Optional `bash scripts/xv6/teammate-verify.sh --full`: PASS; clean apply+make PASS, boot PASS, hello/add2test/pstatetest/pcounttest (`pcount(RUNNING)` and `pcount(99)`)/pchildtest/fcounttest PASS; summary `logs/teammate-verify-20260606-165208.summary.txt` ignored.
  - WSL emitted a localhost/NAT warning on stderr during Start-Process-launched runs; it did not affect command exit or QEMU evidence matching.
  - The known `/mnt/d` `user/usys.pl has type 100644, expected 100755` warning appeared during full apply; apply + make still completed successfully.
- Boundaries:
  - No OS feature was added.
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.
  - Summary files under `logs/` are for feedback only and must not be tracked.
  - The workflow remains timeout-captured evidence, not long-running stability, manual recording, or a second teammate's independent reproduction.

## 2026-06-06: stage8a build submission documentation portal

- Commit hash: TODO after commit
- Goal: shift from MVP engineering notes to judge-facing submission documentation, aligned with proj54 teaching-oriented scoring: documentation 50%, implementation 30%, testing 10%, innovation 10%.
- Completed:
  - Rewrote root `README.md` as a concise judge-facing portal for OUC xv6 Lab Kit.
  - Added `submissions/demo_record.md` to record that 3 videos exist outside Git, with file names/platform submission details pending.
  - Added formal documentation directory `docs/final/`.
  - Added `docs/final/00_project_overview.md`: positioning, scoring-weight mapping, OUC course value, status, same-project comparison, boundaries.
  - Added `docs/final/01_environment_setup.md`: WSL2/Linux setup, baseline, Git hygiene, cleanup.
  - Added `docs/final/02_lab0_baseline_build_boot.md`: lab0 formal guide.
  - Added `docs/final/03_lab1_hello_add2.md`: lab1 formal guide.
  - Added `docs/final/04_lab2_process_observation.md`: lab2 formal guide.
  - Added `docs/final/05_lab4_file_table_observation.md`: lab4 formal guide, explicitly not a full file-system lab.
  - Added `docs/final/06_testing_and_verification.md`: test coverage table, evidence boundaries, manual demo row.
  - Added `docs/final/07_teammate_reproduction_guide.md`: teammate full/quick flow and feedback template.
  - Added `docs/final/08_design_decisions_and_tradeoffs.md`: patch strategy, timeout/cleanup, lab3/lab4 tradeoffs, same-project positioning.
  - Added `docs/final/09_ai_usage_and_contribution_statement.md`: AI tool roles and non-fabrication rules.
  - Added `docs/final/10_reference_and_license_statement.md`: xv6-riscv upstream, baseline commit, MIT license boundary, reference-project TODOs.
  - Added `docs/final/11_known_limits_and_future_work.md`: remaining risks and next steps.
  - Updated `docs/08_reference_and_license.md` to confirm xv6-riscv MIT License from local upstream LICENSE.
  - Rewrote `submissions/submission_checklist.md` around platform compliance, Git hygiene, reproducibility, docs, video, teammate reproduction, red-team review, and final commands.
  - Updated `scripts/collect-report.sh`, `docs/05_ai_usage_record.md`, and this progress log.
- Real validation:
  - `bash scripts/collect-report.sh`: PASS; regenerated `submissions/draft-report-index.md`.
  - `git diff --check`: PASS.
  - `git status --short`: showed only intended docs/index changes and new `docs/final/` plus `submissions/demo_record.md`.
  - `git status --ignored --short external logs .claude`: showed `external/xv6-riscv/`, `.claude/`, and logs as ignored.
  - `git ls-files external/xv6-riscv`: empty.
  - `git ls-files logs/*.log`: empty.
  - `git ls-files logs/*.summary.txt`: empty.
  - `git ls-files logs/*.console.txt`: empty.
  - `git ls-files .claude`: empty.
  - `git ls-files | grep -Ei '\.(mp4|mov|avi|mkv|zip|7z|rar)$' || true`: no tracked video/archive files.
  - `git diff -- patches/integrated-labs/0001-add-hello-syscall.patch ... 0005-add-file-table-observation.patch`: empty; integrated patches unchanged.
- Boundaries:
  - No OS feature was added.
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - No teammate independent reproduction was fabricated; missing teammate summary remains pending.
  - No video file, external source, raw log, summary, `.claude/`, `.vscode/`, large binary, or privacy material should be tracked.

## 2026-06-06: stage7a3 speed up verification and clean repository hygiene

- Commit hash: TODO after commit
- Goal: speed up QEMU command verification by terminating QEMU as soon as expected output is detected (instead of waiting for full timeout), clean `.claude/` from git tracking, harden `.gitignore`, and rewrite root README to be judge-friendly.
- Completed:
  - **Optimized `scripts/xv6/run-xv6-command.sh`**: replaced the outer `timeout` wrapper with a background log watcher that monitors the QEMU output log file. Once `EXPECTED_TEXT` is found, QEMU is terminated immediately via `cleanup_project_processes`, and the script declares success without waiting for the full soft/hard timeout. The watcher uses flag files (`*.found` / `*.timedout`) to avoid race conditions. The hard timeout is still enforced by the watcher itself; if the expected text is not found by the hard deadline, the watcher signals timeout and the script falls through to existing retry/failure logic. All existing trap/cleanup handlers still work correctly — `stop_current_attempt` also cleans up the watcher PID and flag files.
  - **Removed `.claude/` from git tracking**: `git rm -r --cached .claude` removed `.claude/settings.local.json` from the index; the local file is preserved on disk.
  - **Enhanced `.gitignore`**: added `.claude/`, `.cursor/`, `*.code-workspace`, `.DS_Store`, `Thumbs.db`, `logs/*.summary.txt`, `logs/*.console.txt`, `screenshots/`, `submission_assets/`, `proj54_submission_assets/`, `*.env`, `*.token`, `*_token_*`, `*_secret_*`, `*password*`, `local.properties`. Preserved all existing ignore rules including `external/xv6-riscv/` and log patterns.
  - **Rewrote root `README.md`**: condensed from ~370 lines to ~120 lines; added completion status table, judge quick-reproduction section (doctor + teammate-verify), directory overview, key doc links, integrity/boundary section, known limitations, and collaboration rules. Removed stage-by-stage accumulation in favor of a single judge-friendly page.
  - Updated `scripts/xv6/teammate-verify.sh` help text to mention fast QEMU exit.
  - Updated `docs/23_teammate_quickstart.md` section 5 (timing expectations: "30 秒内返回").
  - Updated `docs/22_teammate_reproduction_troubleshooting.md` section 2 (timing + fast exit mechanism).
  - Updated `docs/05_ai_usage_record.md`, `docs/06_progress_log.md`, `scripts/collect-report.sh`, `submissions/draft-report-index.md`, `submissions/submission_checklist.md`, `reproducibility/README.md`.
- Real validation (WSL2 Ubuntu-24.04):
  - `bash -n scripts/xv6/run-xv6-command.sh`: PASS.
  - `bash -n scripts/xv6/teammate-verify.sh`: PASS.
  - `bash -n scripts/xv6/local-verify.sh`: PASS.
  - `bash -n scripts/xv6/doctor.sh`: PASS.
  - `bash scripts/xv6/doctor.sh`: PASS with expected warnings.
  - `bash scripts/xv6/local-verify.sh --quick`: PASS; apply+make SKIPPED, boot and all user-program checks PASS with fast exit.
  - `bash scripts/xv6/teammate-verify.sh --quick`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh hello "hello syscall returned 2026"`: PASS with fast exit (QEMU terminated early after expected output captured).
  - `bash scripts/xv6/run-xv6-command.sh fcounttest "fcounttest done"`: PASS with fast exit.
  - `bash scripts/collect-report.sh`: PASS.
  - `git diff --check`: PASS.
  - `git ls-files .claude`: empty (was `git rm --cached` in this stage).
  - `git ls-files external/xv6-riscv`: empty.
  - `git ls-files logs/*.log logs/*.summary.txt logs/*.console.txt`: empty.
- Boundaries:
  - No OS feature was added.
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - `.claude/` local files were preserved; only git tracking was removed.
  - `external/xv6-riscv/` and `logs/*.log` remain ignored and must not be committed.
- Evidence remains timeout-captured log matching with early QEMU termination, not long-running stability, manual recording, or a second teammate's independent reproduction.

## 2026-06-06: stage8b record reproduction evidence and fix submission-readiness gaps

- Commit hash: TODO after commit
- Goal: record teammate reproduction evidence and demo video metadata without committing raw logs, summary files, screenshots, videos, secrets, or third-party source.
- Completed:
  - Added `submissions/teammate_reproduction_record.md`.
  - Recorded teammate A full verification summary: user `root`, repo root `/root/workspace/proj54-ouc-os-lab`, time `2026-06-06T19:15:02+08:00`, commit `1ba9db6 tooling: speed up verification and clean repo hygiene`, mode `full`, interrupted `NO`, summary file `logs/teammate-verify-20260606-191352.summary.txt`, all checks PASS.
  - Recorded teammate B full verification summary from screenshot/log: user `z2996`, repo root `/home/z2996/workspace/proj54-ouc-os-lab`, commit `1ba9db6 tooling: speed up verification and clean repo hygiene`, mode `full`, all checks PASS, summary file shown as `logs/teammate-verify-20260606-201839.summary.txt` or related teammate summary log. Exact raw file/timestamp conflict remains noted, not fabricated.
  - Updated `submissions/demo_record.md` with three external video filenames: `20260606_auto_verify_demo.mp4`, `20260606_full_verify_demo.mp4`, `20260606_manual_xv6_shell_demo.mp4`; external path `D:\Edge Download\CSCC\proj54_submission_assets\videos`; approximate sizes 13,043 KB / 10,475 KB / 15,174 KB; durations and platform submission method still pending.
  - Added `docs/README.md` to explain that `docs/final/` is the formal submission documentation portal, while `docs/00-23` are process/red-team/stage records.
  - Marked `docs/13_technical_report_v0.1.md` as a historical draft superseded by `docs/final/` and future technical report v1.0.
  - Updated README, final docs, submission checklist, reference/license notes, AI usage record, collect-report script, and generated material index.
- Real validation:
  - `bash scripts/collect-report.sh`: PASS; regenerated `submissions/draft-report-index.md`.
  - `git diff --check`: PASS.
  - `git status --short`: showed only intended documentation/index changes plus new `docs/README.md` and `submissions/teammate_reproduction_record.md`.
  - `git status --ignored --short external logs .claude`: showed `.claude/`, `external/xv6-riscv/`, and `logs/` artifacts as ignored.
  - `git ls-files external/xv6-riscv`: empty.
  - `git ls-files logs/*.log`: empty.
  - `git ls-files logs/*.summary.txt`: empty.
  - `git ls-files logs/*.console.txt`: empty.
  - `git ls-files .claude`: empty.
  - `git ls-files | grep -Ei '\.(mp4|mov|avi|mkv|zip|7z|rar)$' || true`: no tracked video/archive files.
  - WSL emitted the known localhost/NAT warning on stderr, but all validation commands exited 0.
- Boundaries:
  - No OS feature was added.
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - `external/xv6-riscv/`, raw logs, summary files, screenshots, `.claude/`, videos, archives, large binaries, and privacy materials must not be tracked.
  - Teammate real names, teammate B exact raw summary conflict, teammate system versions, video durations, platform submission method, and final privacy review remain pending unless confirmed later.

## 2026-06-06: stage9b independent Lab3 pgcount page-table observation

- Commit hash: TODO after commit
- Goal: implement Lab3 as an independent `pgcount()` page-table observation patch, using the baseline eager/lazy allocation behavior as the teaching point, without modifying integrated `0001-0005` or `scripts/xv6/`.
- Completed:
  - Reset ignored `external/xv6-riscv/` to baseline commit `74f84181a3404d1d6a6ff98d342233979066ebb8`.
  - Confirmed clean baseline syscall numbers end at `SYS_close = 21`; independent `SYS_pgcount = 22` is available.
  - Confirmed baseline has `sbrk(n)` -> `SBRK_EAGER`, `sbrklazy(n)` -> `SBRK_LAZY`, `walk()`, `PTE_V`, `PTE_U`, `PGSIZE`, `struct proc.sz`, `struct proc.pagetable`, and lazy `vmfault()`.
  - Implemented `uvmpagecount(pagetable, sz)` in `kernel/vm.c`; it uses `walk(pagetable, va, 0)` and counts only `PTE_V && PTE_U`, without allocating or changing PTEs.
  - Implemented `sys_pgcount()` in `kernel/sysproc.c`; it only observes `myproc()` and takes no pid.
  - Added `user/pgcounttest.c` with eager and lazy checks. The test computes real deltas; it does not hard-code success strings.
  - Generated `patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch`.
  - Added `patches/lab3-memory-and-pagetable/README.md`.
  - Updated lab3 docs, tests, final status, submission checklist, AI record, collect-report script, and generated material index.
- Real validation (WSL2 Ubuntu):
  - `bash scripts/xv6/check-xv6-baseline.sh`: PASS.
  - `git -C external/xv6-riscv reset --hard 74f84181a3404d1d6a6ff98d342233979066ebb8 && git -C external/xv6-riscv clean -fdx`: completed.
  - `git apply ../../patches/lab3-memory-and-pagetable/0001-add-pgcount-syscall.patch`: PASS.
  - `cd external/xv6-riscv && make`: PASS; only known baseline `LOAD segment with RWX permissions` linker warning.
  - `bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount eager delta = 2"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta before touch = 0"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcount lazy delta after two touches = 2"`: PASS.
  - `bash scripts/xv6/run-xv6-command.sh pgcounttest "pgcounttest done"`: PASS.
- Boundaries:
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - No integrated `0006` was added.
  - No `scripts/xv6/` file was modified.
  - `external/xv6-riscv/` and raw logs remain ignored and must not be committed.
  - The two teammate full PASS summaries at commit `1ba9db6` do not cover Lab3; teammate full should be rerun only if Lab3 is later integrated into the one-shot workflow or claimed as teammate-verified.
  - Lab3 is a page-table mapping count observation, not a complete memory-management experiment.

## 2026-06-06: stage9c luxury integrated lab suite

- Commit hash: TODO after commit
- Goal: build the high-end integrated lab workflow by adding Lab3 pgcount to integrated-labs, adding Lab4 v0.2 fdcount when stable, updating one-shot verification, and turning Lab5 into a capstone reproduction experiment.
- Completed:
  - Generated `patches/integrated-labs/0006-add-pgcount-page-table-observation.patch`.
  - Generated `patches/integrated-labs/0007-add-fdcount-observation.patch`.
  - `0006` uses `SYS_pgcount = 27`, counts `PTE_V && PTE_U` user mappings below `p->sz`, and keeps eager/lazy `pgcounttest`.
  - `0007` uses `SYS_fdcount = 28`, counts current process `ofile[]` entries, and adds `fdcounttest`.
  - Updated `scripts/xv6/apply-integrated-labs.sh` to apply integrated `0001-0007`.
  - Updated `scripts/xv6/teammate-verify.sh` and `scripts/xv6/local-verify.sh` so full/quick summaries include `pgcounttest` and `fdcounttest`.
  - Rewrote `labs/lab5-final-integration/README.md` as a capstone workflow. It does not introduce another kernel mechanism.
  - Updated README, final docs, Lab3/Lab4/Lab5 docs, submission checklist, teammate/video records, AI usage record, collect-report script, and material index.
- Checkpoint A:
  - Clean baseline apply `0001-0006`: PASS.
  - `make -C external/xv6-riscv`: PASS.
  - `pgcounttest "pgcounttest done"`: PASS.
  - Real log contained `pgcount eager delta = 2`, `pgcount lazy delta before touch = 0`, `pgcount lazy delta after one touch = 1`, `pgcount lazy delta after two touches = 2`, and `pgcounttest done`.
- Checkpoint B:
  - Clean baseline apply `0001-0007`: PASS.
  - `make -C external/xv6-riscv`: PASS.
  - Regression PASS: hello, add2test, pstatetest, pcounttest, pchildtest, fcounttest, pgcounttest, fdcounttest.
  - `fdcounttest` real log contained fd delta open=1, dup=2, close one=1, close two=0, and `fdcounttest done`.
- Checkpoint C:
  - `bash -n scripts/xv6/apply-integrated-labs.sh`: PASS.
  - `bash -n scripts/xv6/teammate-verify.sh`: PASS.
  - `bash -n scripts/xv6/local-verify.sh`: PASS.
- Final local full verification:
  - `bash scripts/xv6/apply-integrated-labs.sh --make --yes`: PASS; clean baseline applied integrated `0001-0007`, and `make` completed successfully.
  - `bash scripts/xv6/boot-xv6.sh`: PASS; boot evidence matched `xv6 kernel is booting` and `init: starting sh`.
  - Command evidence PASS: hello, add2test, pstatetest, pcounttest, pchildtest, fcounttest, pgcounttest, fdcounttest.
  - `bash scripts/xv6/local-verify.sh --full`: PASS; copy-to-lead summary recorded doctor/check-env/baseline/apply+make/boot/hello/add2test/pstatetest/pcounttest/pchildtest/fcounttest/pgcounttest/fdcounttest/overall as PASS.
  - Summary file `logs/teammate-verify-20260606-225912.summary.txt` is ignored and must not be committed.
- Boundaries:
  - No GitLab/GitHub remote was modified.
  - `patches/integrated-labs/0001-0005` were not modified.
  - `external/xv6-riscv/` and raw logs remain ignored and must not be committed.
  - `pgcount()` is page-table mapping observation only, not full memory management.
  - `fcount()` / `fdcount()` are file table / fd table observations only, not a complete file system lab.
  - The two teammate full PASS summaries at commit `1ba9db6` are now historical evidence only; they do not cover current integrated `0001-0007`. New teammate `--full` summaries are required before claiming new-HEAD teammate reproduction.

## 2026-06-07: stage10a final integrated evidence manifest

- Commit hash: TODO after commit
- Goal: record the final evidence manifest for commit `e8e2fb9 feat(integrated): add lab3 pgcount and lab4 fdcount workflow` without changing OS code, integrated patches, or xv6 verification scripts.
- Completed:
  - Updated `submissions/teammate_reproduction_record.md` with final `e8e2fb9` / integrated `0001-0007` verification records.
  - Recorded team lead local full PASS: user `rain`, repo root `/mnt/d/Edge Download/CSCC/proj54-ouc-os-lab`, summary `logs/teammate-verify-20260606-232145.summary.txt`, all checks PASS.
  - Recorded teammate A final full PASS: user `root`, repo root `/root/workspace/proj54-ouc-os-lab`, time `2026-06-06T23:52:59+08:00`, summary `logs/teammate-verify-20260606-235139.summary.txt`, all checks PASS, external summary/screenshot SHA256 recorded.
  - Recorded teammate B final full PASS: user `z2996`, repo root shown as `~/workspace/proj54-ouc-os-lab`, summary `logs/teammate-verify-20260607-114807.summary.txt`, all checks PASS, external console/screenshot SHA256 recorded.
  - Marked the old `1ba9db6` teammate records as historical/superseded evidence for the earlier integrated `0001-0005` / stage7-stage8 workflow.
  - Rewrote `submissions/demo_record.md` with final integrated `0001-0007` video metadata: `20260606_final_integrated_0001_0007_demo.mp4`, size `12,120,565 bytes`, duration `00:01:32`, resolution `2560x1440`, 60 fps, SHA256 `0FF2D3581552B3FD3A2630E827251CF46C36BC3BE8F8B9D9DDB691FC0668A93B`.
  - Preserved the three earlier videos as historical evidence with file sizes, durations, resolution, frame rate, and SHA256.
  - Added `submissions/evidence_manifest.md` as the central final evidence index.
  - Updated README, final docs, submission checklist, AI usage record, collect-report script, and generated material index references.
- Boundaries:
  - No GitLab/GitHub remote was modified.
  - No `patches/integrated-labs/` file was modified.
  - No `scripts/xv6/` file was modified.
  - No OS feature, patch, or verification workflow behavior was changed.
  - `external/xv6-riscv/`, raw logs, summary files, console logs, screenshots, videos, `.claude/`, `.vscode/`, large files, and privacy materials remain outside Git.
  - Video and screenshot privacy status remains `pending final manual review`; platform upload method still needs final confirmation.
  - timeout capture is still not long-running stability testing; `fcount()` / `fdcount()` remain file table / fd table observation only; Lab5 remains capstone only.
- Validation:
  - `bash scripts/collect-report.sh`: PASS; regenerated `submissions/draft-report-index.md`.
  - `git diff --check`: PASS.
  - `git status --short`: showed only intended documentation/index changes plus new `submissions/evidence_manifest.md`.
  - `git status --ignored --short external logs .claude`: showed `external/xv6-riscv/`, `.claude/`, and logs as ignored.
  - `git ls-files external/xv6-riscv`, `git ls-files logs/*.log`, `git ls-files logs/*.summary.txt`, `git ls-files logs/*.console.txt`, and `git ls-files .claude`: no tracked files.
  - `git ls-files | grep -Ei '\.(mp4|mov|avi|mkv|zip|7z|rar|png|jpg|jpeg)$' || true`: no tracked video, archive, screenshot, or image evidence files.
  - `git diff --name-only -- patches/integrated-labs scripts/xv6`: no output; stage10a did not modify integrated patches or xv6 verification scripts.

## 2026-06-07: stage10b technical report v1.0 and PPT outline

- Commit hash: TODO after commit
- Goal: draft a judge-facing technical report v1.0 and final defense PPT outline using final evidence as source of truth, without modifying OS code, integrated patches, or xv6 verification scripts.
- Completed:
  - Added `docs/final/technical_report_v1.0.md`.
  - Added `slides/final_ppt_outline.md`.
  - Updated `docs/final/10_reference_and_license_statement.md` with a final-check table for xv6-riscv, uCore, rCore, YatSen OS, F-Tutorials, and winning-project references.
  - Updated README and `docs/README.md` so report v1.0 and PPT outline are discoverable from the formal reading path.
  - Updated `submissions/submission_checklist.md`, AI usage record, progress log, and `scripts/collect-report.sh`.
  - Marked `docs/21_submission_readiness_review.md` as a stage6d historical snapshot in the generated material index to avoid confusing it with final `e8e2fb9` evidence.
- Report structure:
  - 摘要、赛题理解、总体设计、Lab0-Lab5、integrated `0001-0007`、自动化验证、演示视频与证据链、创新点、引用许可证、AI 使用、已知限制与后续工作。
- PPT outline:
  - 15 slides covering title, scoring understanding, pain points, project positioning, Lab0-Lab5, integrated workflow, three-party evidence, video/evidence manifest, innovation, boundaries and future work.
- Boundaries:
  - No `patches/integrated-labs/` file was modified.
  - No `scripts/xv6/` file was modified.
  - No OS implementation code was modified.
  - No platform submission method, teammate real names, OS versions, privacy review, URL, or license was fabricated.
  - No raw logs, summary files, screenshots, videos, archives, `.claude/`, `.vscode/`, or private materials were added.
- Validation:
  - `bash scripts/collect-report.sh`: PASS; regenerated `submissions/draft-report-index.md`.
  - `git diff --check`: PASS.
  - `git status --short`: showed intended documentation/index changes and new `docs/final/technical_report_v1.0.md`, `slides/final_ppt_outline.md`.
  - `git status --ignored --short external logs .claude`: showed `external/xv6-riscv/`, `.claude/`, and logs as ignored.
  - `git ls-files external/xv6-riscv`, `git ls-files logs/*.log`, `git ls-files logs/*.summary.txt`, `git ls-files logs/*.console.txt`, and `git ls-files .claude`: no tracked files.
  - `git ls-files | grep -Ei '\.(mp4|mov|avi|mkv|zip|7z|rar|png|jpg|jpeg)$' || true`: no tracked video, archive, screenshot, or image evidence files.
  - `git diff --name-only -- patches/integrated-labs scripts/xv6 external`: no output.

## 2026-06-07: stage10c final defense PPT and pre-submission materials

- Commit hash: TODO after commit
- Goal: finalize the defense PPT and close final submission-facing materials without modifying OS code, integrated patches, or xv6 verification scripts.
- Completed:
  - Added `slides/final_ppt.md` as the tracked 16-slide final defense source.
  - Added `slides/generate_final_ppt.py`, a Python standard-library OpenXML generator that reads `slides/final_ppt.md` and writes `slides/final_defense_ppt.pptx`.
  - Generated `slides/final_defense_ppt.pptx`; package inspection found 16 slides, 16 speaker notes, `63,695 bytes`, and no `ppt/media/` files.
  - Rewrote `slides/README.md` so the slide directory records current source/generator/PPTX status instead of the old TODO plan.
  - Lightly enhanced `docs/final/technical_report_v1.0.md` with an explicit Lab0-Lab4/Lab5 boundary, architecture and syscall diagrams, pgcount/fdcount pseudocode, and same-type project differentiation.
  - Updated `docs/final/09_ai_usage_and_contribution_statement.md` and the report AI section to match the team's actual tool configuration.
  - Updated `docs/final/10_reference_and_license_statement.md` to keep only xv6-riscv as confirmed URL/license and leave uCore/rCore/YatSen/F-Tutorials/winning-project references as pending checks.
  - Updated README, docs guide, submission checklist, demo record, evidence manifest, AI usage record, and collect-report indexing.
- Boundaries:
  - No `patches/integrated-labs/` file was modified.
  - No `scripts/xv6/` file was modified.
  - No OS implementation code was modified.
  - No engineering verification result, platform submission method, privacy review, teammate real name, OS version, URL, or license was fabricated.
  - No external source tree, raw logs, summary files, screenshots, videos, archives, `.claude/`, `.vscode/`, or private material was added.
- Validation:
  - Final validation commands are run at the end of stage10c; results are reported in the final assistant response.

## 2026-06-08: stage11a advanced optional independent patches (memstat / fdinfo)

- Commit hash: TODO after commit
- Goal: lift implementation depth with two struct-returning observation syscalls (argaddr/argint + copyout + struct ABI) WITHOUT touching integrated 0001-0007, scripts/xv6, or the e8e2fb9 evidence chain.
- Completed:
  - Added `patches/lab3-memory-and-pagetable/0002-add-memstat-syscall.patch`: `memstat(struct memstat *out)` returns `{sz_bytes, mapped_pages, page_size}` via `argaddr + copyout`; `SYS_memstat = 22` (clean baseline independent).
  - Added `patches/lab4-file-table-observation/0002-add-fdinfo-syscall.patch`: `fdinfo(int fd, struct fdinfo *out)` returns `{type, readable, writable, ref}` via `argint + argaddr + copyout`; self-only `myproc()->ofile[fd]`, read under `ftable.lock`; `SYS_fdinfo = 22`.
  - Both struct fields are fully set before copyout and the structs have no padding, so copyout leaks no uninitialized kernel-stack bytes.
- Real validation (clean baseline round-trip, WSL2 Ubuntu-24.04; red-team re-verified):
  - memstat: apply + `make` (-Werror clean) + `memstattest` -> `page_size = 4096`, `mapped delta = 2`, `size delta = 8192`, `invalid pointer = -1`, `memstattest done`.
  - fdinfo: apply + `make` (-Werror clean) + `fdinfotest` -> `open fd ok`, `dup fd ok`, `closed fd = -1`, `bad fd = -1`, `fdinfotest done`.
  - Deltas/results are computed by the test programs (never hardcoded); any mismatch calls `fail()` + `exit(1)`.
- Boundaries:
  - independent advanced optional only; each uses `SYS_*=22` and the two are mutually exclusive (cannot be stacked); combine via a future integrated `0008/0009` (`SYS_memstat = 29`, `SYS_fdinfo = 30`).
  - NOT in integrated `0001-0007`; NOT covered by rain/root/z2996 full verification; does NOT affect the `e8e2fb9` three-way full PASS, so no teammate re-verify is needed now.
  - `memstat` is not full memory management; `fdinfo` is not a full file system.
  - `patches/integrated-labs/` and `scripts/xv6/` were not modified; external tree restored to integrated `0001-0007`.

## 2026-06-08: stage11a-docs document memstat / fdinfo advanced optional patches

- Commit hash: TODO after commit
- Goal: add the minimum necessary documentation so the two advanced patches are no longer orphan files; no learner-first README overhaul, no integrated 0008/0009, no verification-script changes.
- Completed (documentation only):
  - Added advanced-optional sections to `patches/lab3-memory-and-pagetable/README.md`, `patches/lab4-file-table-observation/README.md`, `labs/lab3-memory-and-pagetable/README.md`, `labs/lab4-file-system/README.md`, `tests/lab3/README.md`, `tests/lab4/README.md`, `docs/final/04b_lab3_page_table_observation.md`, `docs/final/05_lab4_file_table_observation.md`.
  - Added an advanced-optional row and anti-overclaim line to `docs/final/11_known_limits_and_future_work.md`; added a light `12.1` advanced-optional section to `docs/final/technical_report_v1.0.md`; added a status row to `README.md`.
  - Added `0002` patch entries to `scripts/collect-report.sh` and regenerated `submissions/draft-report-index.md`; recorded AI usage in `docs/05_ai_usage_record.md`.
  - Every section states: `SYS_*=22` independent / not stackable / not in integrated 0001-0007 / not teammate-verified / does not affect e8e2fb9 / future integrated 0008/0009 needs full re-verify + re-record + re-SHA256.
- Boundaries:
  - No `patches/integrated-labs/`, `scripts/xv6/`, or OS code modified; no external/logs/video/screenshot/.claude/.vscode added.
  - Did not claim memstat/fdinfo are in final integrated or teammate-verified.

## 2026-06-10: stage11b integrate memstat / fdinfo into integrated 0001-0009

- Commit hash: TODO after commit
- Goal: promote the already red-teamed advanced `memstat`/`fdinfo` observation syscalls from independent-only into the integrated comprehensive demo sequence as integrated `0008`/`0009`, extending the final suite to `0001-0009`, WITHOUT modifying integrated `0001-0007` content.
- Completed:
  - Added `patches/integrated-labs/0008-add-memstat-copyout-observation.patch`: integrated `memstat(struct memstat *out)` returning `{sz_bytes, mapped_pages, page_size}` via `argaddr + copyout`; `SYS_memstat = 29`; reuses the `uvmpagecount()` helper that integrated `0006` already added (independent variant inlines the same walk); `memstattest` user program; 8 files.
  - Added `patches/integrated-labs/0009-add-fdinfo-copyout-observation.patch`: integrated `fdinfo(int fd, struct fdinfo *out)` returning `{type, readable, writable, ref}` via `argint + argaddr + copyout`; `SYS_fdinfo = 30`; self-only `myproc()->ofile[fd]`, read through a `fileinfo()` helper under `ftable.lock`; `fdinfotest` user program; 10 files.
  - Both integrated structs are fully populated before copyout and have no padding, so copyout leaks no uninitialized kernel-stack bytes.
  - Updated `scripts/xv6/apply-integrated-labs.sh` so the helper now applies integrated `0001-0009` (PATCHES list and the 0006/0007/0008/0009 dependency hint).
  - Updated `scripts/xv6/teammate-verify.sh` to add `memstattest`/`fdinfotest` PASS/FAIL steps and the suite description.
  - Updated `scripts/xv6/local-verify.sh` INFO line to list `pgcounttest`, `fdcounttest`, `memstattest`, and `fdinfotest`.
- Real validation (clean baseline, WSL2 Ubuntu-24.04):
  - Generated each integrated patch as a clean increment using a throwaway commit over applied `0001-0007`, then round-trip verified each patch: reset clean baseline -> `git apply` `0001-0009` -> `make` (-Werror clean) -> `run-xv6-command.sh`.
  - `bash scripts/xv6/local-verify.sh --full`: overall PASS; apply+make+boot plus all program checks (hello/add2/pstate/pcount/pchild/fcount/pgcount/fdcount/memstat/fdinfo) captured from real QEMU output.
  - memstat observed: `page_size = 4096`, mapped/size deltas computed by the test (not fixed); fdinfo observed: open/dup ok, closed fd `-1`, bad fd `-1`.
  - `bash -n` syntax checks PASS for the three updated scripts.
- Evidence framing (no fabrication):
  - The previous `e8e2fb9` lead/root/z2996 three-way full PASS, the `0001-0007` final video, and its SHA256 are recorded as a **historical stable checkpoint** that covers only `0001-0007`; they do **not** cover `0001-0009`.
  - The new `0001-0009` final commit, the rain/root/z2996 re-verification, the new demo video, and its SHA256 are recorded as **TBD**; the `local-verify --full` PASS above is team-lead local working-tree evidence only and is not claimed as teammate reproduction.
- Boundaries:
  - Did NOT modify the content of integrated `0001-0007`; only added integrated `0008`/`0009`.
  - `memstat` is address-space (page-count) observation, not full memory management; `fdinfo` is fd-metadata observation, not a full file system.
  - No physical addresses, host paths, inode numbers, or file contents are exposed by either syscall or its test.
  - `external/xv6-riscv/`, `logs/*.log`, summary/console files, screenshots, and videos remain ignored and must not be committed.
- Validation commands are re-run at the end of stage11b; results are reported in the final assistant response.

## 2026-06-10: stage11b-fix reconcile integrated 0001-0009 documentation drift

- Commit hash: TODO after commit (part of the stage11b commit)
- Goal: fix the documentation drift found by the stage11b red-team review — several docs still presented `0001-0007` as the current integrated suite, six stage11a sections still said memstat/fdinfo were "not in integrated / future 0008/0009", and two `draft-report-index.md` descriptors claimed `0001-0009` content that the underlying docs did not yet contain.
- Completed (documentation consistency only):
  - `patches/integrated-labs/README.md`: purpose list, patch sequence table (added `0008`/`0009` rows), helper behavior, manual apply order, auto-verify commands, results table (memstattest/fdinfotest rows, `0001-0009` apply row), and evidence boundaries updated to current suite `0001-0009` with historical/TBD framing.
  - `docs/final/00_project_overview.md`: scoring row and status table updated to `0001-0009`; video and teammate rows reframed as historical `0001-0007` checkpoint + `0001-0009` TBD; added key-boundary lines (old evidence does not cover `0001-0009`; memstat/fdinfo are observation only).
  - `labs/lab5-final-integration/README.md`: capstone workflow, coverage list, verification commands (added memstattest/fdinfotest), patch-reading step, and current status updated to `0001-0009` with historical/TBD evidence boundaries.
  - Six stage11a residue files (`labs/lab3*`, `labs/lab4*`, `tests/lab3`, `tests/lab4`, `patches/lab3*/README.md`, `patches/lab4*/README.md`): kept the independent-patch facts (`SYS_*=22`, mutually exclusive, clean-baseline only) and replaced "未进入 integrated / 未来 0008/0009" with "stage11b 已进入 integrated `0008`/`0009`（`SYS_memstat=29`/`SYS_fdinfo=30`）; `0001-0009` teammate verify / new video / new SHA256 TBD".
  - `docs/final/07_teammate_reproduction_guide.md`: added a stage11b banner; `e8e2fb9` reframed from final commit to historical stable checkpoint covering only `0001-0007`.
  - `docs/24_lab3_lab5_completion_plan.md`: added a prominent stage11b banner declaring the document a stage9c process record; fixed the "currently applies `0001-0007`" line.
  - `reproducibility/README.md`: integrated section updated to `0001-0009` (added `0008`/`0009` bullets and memstattest/fdinfotest coverage); stale "当前 0001-0007" wording and the teammate TODO re-anchored.
  - `submissions/evidence_manifest.md`: external-directory descriptions reframed (historical checkpoint; directory name kept as-is); `docs/final/11` "final commit" wording fixed.
  - `scripts/collect-report.sh`: descriptors for docs/24, docs/final/07, patches/integrated-labs README, and the 04b/05 final guides synchronized with real doc content; regenerated `submissions/draft-report-index.md`.
- Kept as historical (not changed): dated stage entries in `docs/05`/`docs/06`, historical evidence sections in demo/teammate/evidence docs, external asset directory and file names containing `e8e2fb9_final_0001_0007`, and slide headings whose bodies already carry historical/TBD framing.
- Boundaries:
  - No `patches/integrated-labs/0001-0009` patch content, `scripts/xv6/`, or OS code was modified.
  - No teammate reproduction, new video, or new SHA256 was fabricated; all `0001-0009` evidence remains TBD.
  - `external/xv6-riscv/`, logs, summaries, screenshots, videos, `.claude/`, `.vscode/` remain uncommitted.
- Validation: `bash scripts/collect-report.sh`, `git diff --check`, `git status --short`, no-change checks on integrated `0001-0007` patches and `external`, and `git ls-files` hygiene checks; results reported in the final assistant response. `local-verify --full` was not re-run because no engineering file changed (last run on 2026-06-10 remains overall PASS).

## 2026-06-10: stage12 learner-first offensive upgrade

- Commit hash: TODO after commit
- Goal: turn the repo from a competition-submission layout into a course package that a beginner can study, a teacher can assign, and a TA can grade — without touching engineering state or faking any pending evidence.
- Completed (documentation + non-xv6 tooling only):
  - `README.md` rewritten learner-first: what this is / who it is for / what you will learn / Step 0-7 learning path / shortest-run commands / teacher and judge pointers / honest evidence status moved to the last section.
  - `docs/README.md` rebuilt as reader routing: first-time learners, people who can already boot xv6, teachers/TAs, judges, and historical process records (explicitly lowest priority for newcomers).
  - All five lab READMEs tutorialized with a shared frame (what you learn / why it matters / relation to neighbors / hands-on pointer / common snags / what not to misread / where next). Lab3 now contrasts `pgcount` (int observation) vs `memstat` (struct copyout observation); Lab4 explains the three-level view `fcount`/`fdcount`/`fdinfo`; Lab5 states capstone-only and integrated `0001-0009`.
  - Added `labs/*/student_tasks.md` x5: goals, mandatory tasks (predict-then-verify, break-and-fix, path walkthroughs), optional challenges, submission list, self-check commands, 100-point rubric, deduction list, report questions. No ready-made answers.
  - Added `docs/teacher_guide.md` (2/3/5-session plans, acceptance via teammate-verify summary blocks, anti-fabrication spot checks), `docs/grading_and_rubric.md` (four dimensions, unified deduction table), `docs/troubleshooting.md` (symptom/cause/fix/what-to-report for WSL, /mnt slowness, Ctrl+Z + cleanup-qemu, apply order, benign warnings, DIRSIZ, timeout semantics).
  - `docs/final/technical_report_v1.0.md`: abstract now states the learner-first material chain; section 12.1 explains that memstat/fdinfo's value is completing the `argaddr + copyout + struct ABI` teaching chain, not adding two syscalls; innovation list gains the course-material point. `docs/final/00_project_overview.md` gains the teaching-material row.
  - `submissions/evidence_manifest.md` header now routes learners back to the README; evidence content itself unchanged (current `0001-0009` TBD, `e8e2fb9 / 0001-0007` historical).
  - Slides source/outline synced (teaching-material innovation bullet, memstat/fdinfo boundary line, four-beat slogan replaced); `slides/final_defense_ppt.pptx` regenerated from tracked Markdown.
  - Added `scripts/check-final-hygiene.sh` (tracked-material gate with single PPTX whitelist) and `scripts/check-evidence-sha256.sh` (hashes external historical evidence in place, case-insensitive compare, skips when the external directory is absent, never fails on TBD `0001-0009` evidence).
  - `scripts/collect-report.sh` descriptors extended for all new files; `submissions/draft-report-index.md` regenerated.
- Boundaries:
  - No `patches/integrated-labs/` content, `scripts/xv6/`, or OS code modified; engineering state identical to commit `b6014d1`, so `local-verify --full` was not re-run (2026-06-10 runs remain overall PASS).
  - No teammate reproduction, new video, or new SHA256 fabricated; all `0001-0009` evidence remains TBD.
  - No external source, logs, media, archives, `.claude/`, `.vscode/`, or privacy material committed.
- Validation: `bash -n` on both new scripts; `collect-report.sh`; `check-final-hygiene.sh` PASS; `check-evidence-sha256.sh` run on this machine; PPTX zip inspection (16 slides, no `ppt/media/`); `git diff --check`; full `git ls-files` hygiene battery. Results in the final assistant response.

## 2026-06-10: stage13 autonomous engineering upgrade (course tooling)

- Commit hash: TODO after commit
- Goal: close the three biggest "repo vs course product" gaps found by free-form review — scattered command entries, no TA batch-acceptance tool, and recurring docs/state drift that previously needed a human red team.
- Completed:
  - Added `scripts/labctl.sh`: single course entry. Subcommands delegate to existing scripts (doctor/setup/boot/verify/quick/precheck/clean/grade/consistency/hygiene/evidence/report); the only new knowledge is the lab-to-test matrix so `test lab1..lab4 | all | <program>` runs exactly the right `run-xv6-command.sh` checks. `setup` keeps the underlying `--yes` safety contract by refusing to run without an explicit `--yes`.
  - Added `scripts/grade-summaries.sh`: TA batch parser for teammate-verify summaries (marker block or whole file). One row per file (user/commit/mode/overall) plus flags: INCONSISTENT (overall PASS but an item FAIL), MISSING/OLD_SUITE? (no memstattest/fdinfotest -> pre-0001-0009 summary), DUP_OF (byte-identical submissions), COMMIT_MISMATCH (with --expect-commit), MODE_QUICK, NO_BLOCK. Documented as an acceptance aid, not a grader; exit 1 when attention is needed.
  - Added `scripts/check-docs-consistency.sh`: mechanical drift gate — PATCHES list vs patch files (both directions), `+#define SYS_*` numbers in integrated patches vs the documented 22-30 map, teammate-verify coverage of all 10 programs, labctl matrix coverage, stale-wording scan (changelogs excluded), course-critical file presence, report-index freshness; evidence truthfulness is explicitly MANUAL, never auto-passed.
  - `.gitignore`: added `logs/student-summaries/` because `logs/*.summary.txt` only matches direct children — without this, TA-collected student files in a subdirectory would be trackable.
  - Docs sync: README quick-start now leads with labctl (raw script paths still listed); teacher guide gained the grade-summaries workflow and labctl-based classroom demo; grading doc states the parser does not grade; troubleshooting notes labctl is a pure forwarder; submission checklist gained labctl/consistency rows and the three gates in the final command block; collect-report descriptors and index regenerated.
- Real validation:
  - `bash -n` on all three scripts: PASS.
  - `labctl help` / `labctl list`: correct; `labctl test lab1` against live QEMU: 2/2 passed (hello, add2test), exit 0.
  - `grade-summaries.sh` on three real lead-local summaries: parsed all, 3 clean PASS, exit 0; negative-path test with tampered (item FAIL under overall PASS), duplicated, old-suite, and wrong-commit inputs raised INCONSISTENT/DUP_OF/OLD_SUITE?/COMMIT_MISMATCH and exit 1.
  - `check-docs-consistency.sh`: first run caught a real bug in its own check 2 (patches align `#define` columns; comparison was whitespace-sensitive) — fixed, then 7/7 OK, PASS, exit 0 (exit verified with `&&/||` because `$?` is unreliable across the MSYS->WSL boundary).
- Boundaries:
  - No `patches/integrated-labs/`, `scripts/xv6/`, or OS code modified; engineering state unchanged, heavy verification not re-run (2026-06-10 full PASS runs remain valid).
  - grade-summaries checks internal consistency only; it cannot prove a student ran anything — spot checks remain mandatory and grading stays with the teacher.
  - No teammate reproduction, video, or SHA256 fabricated; `0001-0009` evidence remains TBD.
  - Lead-local summary files used for testing stay ignored in `logs/`; nothing generated was committed.

## 2026-06-11: stage14 record final db85947 evidence

- Commit hash: TODO after commit
- Goal: replace every current-final TBD with the real, completed evidence for `db85947 / 0001-0009`, while keeping `e8e2fb9 / 0001-0007` and `1ba9db6` records as historical.
- Real evidence recorded (team-provided, from real runs; hashes machine-verified before recording):
  - Three-way `teammate-verify.sh --full` on commit `db85947`, suite `0001-0009`, all PASS: lead `rain` (summary `teamlead_rain_db85947_full_20260610-221236.summary.txt`), teammate A `root` (summary + screenshot, 2026-06-11), teammate B `z2996` (summary + screenshot, 2026-06-10). SHA256 for all five files recorded in `submissions/teammate_reproduction_record.md` and `submissions/evidence_manifest.md`.
  - Batch acceptance: `bash scripts/grade-summaries.sh --expect-commit db85947 logs/student-summaries` -> parsed 3, clean PASS 3, needs attention 0 (`GRADE_SUMMARIES_RESULT: OK`).
  - New final demo video `20260611_final_integrated_0001_0009_demo.mp4` (31,529,984 bytes, created 2026-06-11 08:26:36, modified 08:29:50), SHA256 `2A2C9863C185846225A98AC874499867A71588CED2020A64249CBF99C7BC0365`; duration/resolution/framerate intentionally left 待人工补充 (not provided, not guessed).
- Completed:
  - `scripts/check-evidence-sha256.sh`: added the 6 new external files (1 video, 3 summaries, 2 screenshots) alongside the 8 historical entries; real run hashed **14/14 matched** (`EVIDENCE_SHA256_RESULT: PASS`) — this was executed BEFORE any document recorded the new values.
  - `submissions/evidence_manifest.md`: Current Final Evidence section now carries the full db85947 record (commit, three-way PASS with file names + SHA256, grade-summaries result, video metadata); external directory table gained `db85947_final_0001_0009`.
  - `submissions/demo_record.md`: new Current Final Video section; status table updated; defense-playback note now points to the new video.
  - `submissions/teammate_reproduction_record.md`: Current Final Verification section rewritten from TBD to the completed three-way table with external file SHA256s.
  - `submissions/submission_checklist.md`: verification/video/teammate rows and conclusion updated; remaining-items list now only video display metadata, real names, platform method, privacy review, PPT rehearsal.
  - docs/final (00/06/07/technical_report/04b/05/11), README, docs/README, docs/24 banner, labs lab3/lab4/lab5, patches integrated/lab3/lab4 READMEs, reproducibility, tests lab3/lab4, slides source+outline: every stale "0001-0009 evidence TBD" claim replaced with the completed db85947 record or a pointer to the manifest; old evidence kept historical everywhere.
  - `scripts/collect-report.sh` descriptors synced (manifest/demo/teammate/checklist/evidence-checker now describe the recorded state); index regenerated; PPTX regenerated from the updated slides source.
- Boundaries:
  - No raw summary/screenshot/video copied into the repo; external files stay outside Git with hashes recorded.
  - No `patches/integrated-labs/` content or `scripts/xv6/` modified; engineering state unchanged, heavy verification not re-run.
  - Old `e8e2fb9 / 0001-0007` three-way PASS + video and `1ba9db6` records remain historical stable checkpoint / superseded evidence; never claimed as current final.
  - Teammate real names / OS versions still 待补充 if the platform requires them; video duration/resolution/framerate 待人工补充.
- Validation: `check-evidence-sha256.sh` 14/14 PASS; `check-final-hygiene.sh`; `check-docs-consistency.sh`; `collect-report.sh`; PPTX zip inspection; `git diff --check`; full `git ls-files` battery. Results in the final assistant response.

## 2026-06-11: stage15 final submission polish and external asset link

- Commit hash: TODO after commit
- Goal: link the externally hosted evidence assets from the submission entry documents and give the whole material set its final human pass, without touching any evidence fact.
- Completed:
  - Baidu pan link for the external asset directory `proj54_submission_assets` (<https://pan.baidu.com/s/1Xt-G6VgP04eEAumqiMo7Uw?pwd=1234>, 提取码 `1234`) written into: README judge section, `submissions/evidence_manifest.md` (new "External Asset Package" section listing contents: final `0001-0009` demo video, `db85947_final_0001_0009` summaries/screenshots, historical `e8e2fb9_final_0001_0007` evidence, earlier historical videos), `submissions/demo_record.md`, `submissions/teammate_reproduction_record.md`, `submissions/submission_checklist.md` (new compliance row), `docs/final/00_project_overview.md` (new section), `docs/final/technical_report_v1.0.md` (evidence-chain paragraph). Every mention states that large files stay out of Git and that the manifest + `check-evidence-sha256.sh` remain the verifiable index — the pan link is a file carrier, not the evidence source of truth.
  - De-AI sweep: greps for the blacklisted phrases (显著提升/全方位赋能/体系化闭环/多维度协同/创新性构建/高质量保障/深度赋能 and a second list incl. 助力/打造/极大地) found zero hits in tracked markdown, so no slogan removal was needed.
  - Human-tone notes added, each grounded in incidents already recorded in this log: README closing note (DIRSIZ `pstatechildtest`→`pchildtest` mkfs failure, lab1+lab2 `git apply` conflict measurement, `/mnt` slow first boot), troubleshooting header line (every entry was really hit at least once), lab1 README pre-table note (stage3a PowerShell make failure + corrupt handwritten patch), technical report section 14 paragraph tracing three design rules back to their real incidents.
  - PPT source + outline: Slide 1 key message replaced with the core story ("我们不只是给 xv6 加了九个系统调用，而是把它们整理成了一个可学习、可复现、可验收的 OS 入门实验包"); evidence slide now mentions the Baidu asset package and the 14/14 hash check; speaker notes adjusted. PPTX regenerated and re-inspected (16 slides, no embedded media).
  - `scripts/collect-report.sh` descriptors for README/manifest/checklist/final_ppt updated; index regenerated.
- Unchanged by design: all SHA256 values, the current/historical boundary (`db85947 / 0001-0009` current final; `e8e2fb9 / 0001-0007` historical), commit references (`db85947` engineering, `caf8ced` evidence-doc commit only), AI usage records, integrated patches, `scripts/xv6/`.
- Validation: `check-evidence-sha256.sh` (expect 14/14), `check-final-hygiene.sh`, `check-docs-consistency.sh`, `collect-report.sh`, `git diff --check`, patch/xv6/external no-diff checks, `git ls-files` battery, PPTX zip inspection. Results in the final assistant response.
