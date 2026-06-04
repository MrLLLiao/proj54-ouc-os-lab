# Progress Log

## Rules

- Record only real work.
- Use `TODO`, `pending`, or `not run` for unfinished or unverified items.
- Do not invent commit hashes, test output, build success, or QEMU screenshots.

## 2026-06-03: Scaffold and MVP v0.1

- Commit hash: TODO after commit
- Completed:
  - Project scaffold initialized.
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

- Commit hash: TODO after commit
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

- Commit hash: TODO after commit
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

- Commit hash: TODO after commit
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

- Commit hash: TODO after commit
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

- Commit hash: TODO after commit
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

- Commit hash: TODO after commit
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

- Commit hash: TODO after commit
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

- Commit hash: TODO after commit
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
