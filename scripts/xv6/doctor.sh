#!/usr/bin/env bash
set -u

missing=0
warnings=0

mark_missing() {
  missing=$((missing + 1))
}

mark_warn() {
  warnings=$((warnings + 1))
}

check_required_tool() {
  tool="$1"
  if command -v "$tool" >/dev/null 2>&1; then
    echo "[OK]   ${tool} -> $(command -v "$tool")"
  else
    echo "[FAIL] ${tool} not found in PATH"
    mark_missing
  fi
}

check_optional_tool() {
  tool="$1"
  note="$2"
  if command -v "$tool" >/dev/null 2>&1; then
    echo "[OK]   ${tool} -> $(command -v "$tool")"
  else
    echo "[WARN] ${tool} not found in PATH - ${note}"
    mark_warn
  fi
}

echo "xv6 teammate verification doctor"
echo "time   : $(date -Iseconds 2>/dev/null || date)"
echo "cwd    : $(pwd)"
echo "uname  : $(uname -a 2>/dev/null || echo unknown)"
echo "commit : $(git log --oneline -1 2>/dev/null || echo unknown)"
echo

echo "[CHECK] git repository"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[OK]   inside a Git repository"
else
  echo "[FAIL] not inside a Git repository"
  mark_missing
fi
echo

echo "[CHECK] required tools"
check_required_tool git
check_required_tool bash
check_required_tool make
check_required_tool qemu-system-riscv64
check_required_tool riscv64-linux-gnu-gcc
check_optional_tool riscv64-unknown-elf-gcc "optional for this repo; riscv64-linux-gnu-gcc is enough for current xv6 build"
echo

echo "[CHECK] xv6 baseline files"
if [ -d "external/xv6-riscv" ]; then
  echo "[OK]   external/xv6-riscv exists"
else
  echo "[FAIL] external/xv6-riscv is missing"
  echo "       Fetch it first: bash scripts/xv6/fetch-xv6.sh --run"
  mark_missing
fi

if [ -f "external/xv6-baseline-record.md" ]; then
  echo "[OK]   external/xv6-baseline-record.md exists"
else
  echo "[WARN] external/xv6-baseline-record.md is missing"
  mark_warn
fi
echo

echo "[CHECK] logs directory"
if [ -d "logs" ]; then
  echo "[OK]   logs/ exists"
else
  echo "[WARN] logs/ is missing; scripts will create it when needed"
  mark_warn
fi

if git check-ignore -q logs/probe.log 2>/dev/null; then
  echo "[OK]   logs/*.log is ignored"
else
  echo "[FAIL] logs/*.log is not ignored"
  mark_missing
fi

if git check-ignore -q logs/teammate-verify-probe.summary.txt 2>/dev/null; then
  echo "[OK]   teammate verify summary files are ignored"
else
  echo "[FAIL] teammate verify summary files are not ignored"
  mark_missing
fi
echo

echo "[CHECK] possible QEMU leftovers"
if pgrep -af 'qemu-system-riscv64|make.*qemu' 2>/dev/null; then
  echo "[WARN] possible QEMU/make qemu process exists; run: bash scripts/xv6/cleanup-qemu.sh"
  mark_warn
else
  echo "[OK]   no qemu-system-riscv64 or make qemu process found"
fi
echo

echo "[CHECK] workspace path"
case "$(pwd -P 2>/dev/null || pwd)" in
  /mnt/*)
    echo "[WARN] current path is under /mnt/. First boot can be slower because of drvfs/mtime behavior."
    mark_warn
    ;;
  *)
    echo "[OK]   current path is not under /mnt/"
    ;;
esac
echo

if [ "$missing" -gt 0 ]; then
  echo "DOCTOR_RESULT: NOT READY"
  echo "[FAIL] missing ${missing} required item(s); warnings: ${warnings}"
  exit 1
fi

if [ "$warnings" -gt 0 ]; then
  echo "DOCTOR_RESULT: READY WITH WARNINGS"
  echo "[WARN] required items are present; warnings: ${warnings}"
  exit 0
fi

echo "DOCTOR_RESULT: READY"
echo "[OK] required environment checks passed with no warnings."
exit 0
