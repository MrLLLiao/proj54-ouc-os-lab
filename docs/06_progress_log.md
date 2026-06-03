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
