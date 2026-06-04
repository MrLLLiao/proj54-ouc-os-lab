#!/usr/bin/env bash
# Apply the integrated lab1+lab2 patch sequence onto a clean xv6-riscv baseline.
#
# Safety model:
# - Default mode is PREVIEW only: inspect state and print planned operations.
# - --run resets and cleans only the ignored third-party tree, then applies patches.
# - --make implies --run, then runs make and stores the real output in logs/.
# - --run/--make ALWAYS require --yes, because they run 'git reset --hard' and
#   'git clean -fdx' on the ignored xv6 tree, discarding its local changes and
#   build artifacts. Preview never needs --yes and never changes anything.
set -u

TARGET_DIR="${XV6_TARGET_DIR:-external/xv6-riscv}"
BASELINE_COMMIT="${XV6_BASELINE_COMMIT:-74f84181a3404d1d6a6ff98d342233979066ebb8}"
PATCHES="
patches/integrated-labs/0001-add-hello-syscall.patch
patches/integrated-labs/0002-add-argint-add2-syscall.patch
patches/integrated-labs/0003-add-pstate-syscall.patch
"

usage() {
  cat <<EOF
Usage:
  bash scripts/xv6/apply-integrated-labs.sh
      Preview only. No reset, no patch apply, no make.

  bash scripts/xv6/apply-integrated-labs.sh --run --yes
      Reset the ignored xv6 tree to the baseline and apply integrated patches.

  bash scripts/xv6/apply-integrated-labs.sh --make --yes
      Same as --run, then run make and save logs/integrated-make-YYYYMMDD-HHMMSS.log.

Notes:
  - Target tree: ${TARGET_DIR}
  - Baseline commit: ${BASELINE_COMMIT}
  - This script never commits external/xv6-riscv/ or logs/*.log.
  - --make implies --run.
EOF
}

DO_RUN=0
DO_MAKE=0
YES=0

for arg in "$@"; do
  case "$arg" in
    --run) DO_RUN=1 ;;
    --make) DO_MAKE=1 ;;
    --yes) YES=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "[ERROR] unknown argument: ${arg}"; usage; exit 2 ;;
  esac
done

if [ "$DO_MAKE" -eq 1 ]; then
  DO_RUN=1
fi

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || {
  echo "[ERROR] failed to enter repo root: ${REPO_ROOT}"
  exit 1
}

echo "xv6 integrated labs apply helper"
echo "repo root       : ${REPO_ROOT}"
echo "target dir      : ${TARGET_DIR} (ignored third-party tree; not committed)"
echo "baseline commit : ${BASELINE_COMMIT}"
echo "mode            : $(if [ "$DO_RUN" -eq 0 ]; then echo preview; elif [ "$DO_MAKE" -eq 1 ]; then echo make; else echo run; fi)"
echo

if [ ! -d "$TARGET_DIR" ]; then
  echo "[ERROR] missing baseline directory: ${TARGET_DIR}"
  echo "        Fetch it first: bash scripts/xv6/fetch-xv6.sh --run"
  exit 1
fi

if [ ! -d "$TARGET_DIR/.git" ]; then
  echo "[ERROR] ${TARGET_DIR} is not a git repository."
  exit 1
fi

for patch in $PATCHES; do
  if [ -f "$patch" ]; then
    echo "[OK] patch found: ${patch}"
  else
    echo "[ERROR] missing patch: ${patch}"
    exit 1
  fi
done

if git -C "$TARGET_DIR" cat-file -e "${BASELINE_COMMIT}^{commit}" 2>/dev/null; then
  echo "[OK] baseline commit exists locally."
else
  echo "[ERROR] baseline commit not found locally: ${BASELINE_COMMIT}"
  echo "        Fetch/update ${TARGET_DIR} before applying patches."
  exit 1
fi

current_head="$(git -C "$TARGET_DIR" rev-parse HEAD 2>/dev/null || echo unknown)"
tree_status="$(git -C "$TARGET_DIR" status --porcelain)"

echo "current HEAD    : ${current_head}"
if [ -n "$tree_status" ]; then
  echo "[WARN] target tree has local changes or build artifacts:"
  git -C "$TARGET_DIR" status --short
else
  echo "[OK] target tree is clean."
fi
echo

if [ "$DO_RUN" -eq 0 ]; then
  echo "MODE: preview only. No changes were made."
  echo
  echo "What --run --yes would do:"
  echo "  1. git -C ${TARGET_DIR} reset --hard ${BASELINE_COMMIT}"
  echo "  2. git -C ${TARGET_DIR} clean -fdx"
  i=3
  for patch in $PATCHES; do
    echo "  ${i}. git -C ${TARGET_DIR} apply --check ${patch}"
    i=$((i + 1))
    echo "  ${i}. git -C ${TARGET_DIR} apply ${patch}"
    i=$((i + 1))
  done
  echo "  (with --make --yes) run make and write logs/integrated-make-YYYYMMDD-HHMMSS.log"
  echo
  echo "Dry-run apply check against CURRENT tree state:"
  for patch in $PATCHES; do
    patch_abs="${REPO_ROOT}/${patch}"
    if git -C "$TARGET_DIR" apply --check "$patch_abs" 2>/dev/null; then
      echo "[OK] current tree accepts: ${patch}"
    else
      echo "[INFO] current tree does not accept now: ${patch}"
      echo "       Normal if patches are already applied, the tree is not clean baseline, or this"
      echo "       patch needs predecessors (0002 needs 0001; 0003 needs 0001+0002, applied in --run)."
    fi
  done
  exit 0
fi

if [ "$YES" -ne 1 ]; then
  echo "[ERROR] refusing to reset/clean ${TARGET_DIR} without --yes."
  echo "        --run/--make run 'git reset --hard ${BASELINE_COMMIT}' and 'git clean -fdx'"
  echo "        on the ignored third-party tree, discarding its local changes and build artifacts."
  echo "        Re-run with --yes to confirm. Example:"
  echo "          bash scripts/xv6/apply-integrated-labs.sh --make --yes"
  if [ -n "$tree_status" ]; then
    echo "        Note: the target tree currently has local changes/build artifacts (shown above)."
  fi
  exit 1
fi

echo "MODE: run. The ignored target tree will be reset and cleaned (--yes supplied)."

echo "[STEP] git reset --hard ${BASELINE_COMMIT}"
if ! git -C "$TARGET_DIR" reset --hard "$BASELINE_COMMIT" >/dev/null 2>&1; then
  echo "[ERROR] git reset --hard failed."
  exit 1
fi

echo "[STEP] git clean -fdx"
if ! git -C "$TARGET_DIR" clean -fdx >/dev/null 2>&1; then
  echo "[ERROR] git clean -fdx failed."
  exit 1
fi

if [ -n "$(git -C "$TARGET_DIR" status --porcelain)" ]; then
  echo "[ERROR] target tree is not clean after reset/clean."
  git -C "$TARGET_DIR" status --short
  exit 1
fi
echo "[OK] clean baseline at $(git -C "$TARGET_DIR" rev-parse HEAD)"

for patch in $PATCHES; do
  patch_abs="${REPO_ROOT}/${patch}"
  echo "[STEP] git apply --check ${patch}"
  if ! git -C "$TARGET_DIR" apply --check "$patch_abs"; then
    echo "[ERROR] patch check failed: ${patch}"
    exit 1
  fi
  echo "[OK] patch check passed: ${patch}"

  echo "[STEP] git apply ${patch}"
  if ! git -C "$TARGET_DIR" apply "$patch_abs"; then
    echo "[ERROR] patch apply failed after successful check: ${patch}"
    exit 1
  fi
  echo "[OK] patch applied: ${patch}"
done

echo
echo "[OK] integrated patches applied. Current target-tree changes:"
git -C "$TARGET_DIR" status --short

if [ "$DO_MAKE" -eq 0 ]; then
  echo
  echo "Build not run. To build and capture a real log:"
  echo "  bash scripts/xv6/apply-integrated-labs.sh --make --yes"
  exit 0
fi

mkdir -p logs
ts="$(date +%Y%m%d-%H%M%S)"
log="logs/integrated-make-${ts}.log"

echo
echo "[STEP] make -C ${TARGET_DIR}"
{
  echo "command: make -C ${TARGET_DIR} (after apply-integrated-labs.sh --make --yes)"
  echo "date: $(date -Iseconds)"
  echo "baseline commit: ${BASELINE_COMMIT}"
  echo "patch sequence:"
  for patch in $PATCHES; do
    echo "  - ${patch}"
  done
  echo
  make -C "$TARGET_DIR"
} >"$log" 2>&1
code="$?"

if [ "$code" -eq 0 ]; then
  echo "[OK] make completed successfully. Log: ${log} (ignored by Git)"
else
  echo "[ERROR] make failed with exit code ${code}. Log: ${log} (ignored by Git)"
fi
echo "Record the real result in docs/04_test_report.md. Do not fake success."
exit "$code"
