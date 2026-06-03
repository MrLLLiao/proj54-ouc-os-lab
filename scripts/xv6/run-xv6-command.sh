#!/usr/bin/env bash
set -u

TARGET_DIR="${XV6_TARGET_DIR:-external/xv6-riscv}"
TIMEOUT_SECONDS="${XV6_COMMAND_TIMEOUT_SECONDS:-30}"
COMMAND_TEXT="${1:-hello}"
EXPECTED_TEXT="${2:-hello syscall returned 2026}"

safe_name="$(printf '%s' "$COMMAND_TEXT" | tr -c 'A-Za-z0-9_' '_')"
ts="$(date +%Y%m%d-%H%M%S)"
log="logs/xv6-command-${safe_name}-${ts}.log"

mkdir -p logs

echo "xv6-riscv command evidence check"
echo "target  : ${TARGET_DIR}"
echo "command : ${COMMAND_TEXT}"
echo "expect  : ${EXPECTED_TEXT}"
echo "timeout : ${TIMEOUT_SECONDS}s"
echo "log     : ${log}"
echo

if [ ! -d "$TARGET_DIR" ]; then
  echo "[ERROR] missing baseline directory: ${TARGET_DIR}"
  exit 1
fi

if [ ! -f "$TARGET_DIR/Makefile" ]; then
  echo "[ERROR] missing Makefile: ${TARGET_DIR}/Makefile"
  exit 1
fi

{
  echo "command: send '${COMMAND_TEXT}' to xv6 via make qemu"
  echo "date: $(date -Iseconds)"
  echo "note: timeout exit 124 can be expected because QEMU normally keeps running."
  echo "note: fs.img is built before starting QEMU so command input is not consumed by make."
  echo
} >"$log"

echo "[INFO] ensuring fs.img is up to date before QEMU..."
if ! make -C "$TARGET_DIR" fs.img >>"$log" 2>&1; then
  echo "COMMAND_EVIDENCE_NOT_FOUND" | tee -a "$log"
  echo "[ERROR] failed to build fs.img before QEMU. See log: ${log}"
  exit 1
fi

(
  i=0
  while [ "$i" -lt "$TIMEOUT_SECONDS" ]; do
    sleep 1
    printf '%s\n' "$COMMAND_TEXT"
    i=$((i + 1))
  done
) | timeout "${TIMEOUT_SECONDS}s" make -C "$TARGET_DIR" qemu >>"$log" 2>&1
code="$?"

echo "timeout/make exit code: ${code}" >>"$log"
echo >>"$log"

if grep -q "$EXPECTED_TEXT" "$log"; then
  echo "COMMAND_EVIDENCE_FOUND" | tee -a "$log"
  echo "[OK] detected expected output: ${EXPECTED_TEXT}"
  echo "[INFO] QEMU was stopped by timeout; this is not a long-running stability test."
  exit 0
fi

echo "COMMAND_EVIDENCE_NOT_FOUND" | tee -a "$log"
echo "[WARN] expected output not found: ${EXPECTED_TEXT}"
echo "[WARN] See log for the real QEMU output: ${log}"
exit 1
