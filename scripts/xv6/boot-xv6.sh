#!/usr/bin/env bash
set -u

TARGET_DIR="${XV6_TARGET_DIR:-external/xv6-riscv}"
TIMEOUT_SECONDS="${XV6_BOOT_TIMEOUT_SECONDS:-20}"

mkdir -p logs
ts="$(date +%Y%m%d-%H%M%S)"
log="logs/xv6-boot-${ts}.log"

echo "xv6-riscv boot evidence check"
echo "target : ${TARGET_DIR}"
echo "timeout: ${TIMEOUT_SECONDS}s"
echo "log    : ${log}"
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
  echo "command: timeout ${TIMEOUT_SECONDS}s make -C ${TARGET_DIR} qemu"
  echo "date: $(date -Iseconds)"
  echo "note: timeout exit 124 can be expected because QEMU normally keeps running."
  echo
} >"$log"

timeout "${TIMEOUT_SECONDS}s" make -C "$TARGET_DIR" qemu >>"$log" 2>&1
code="$?"

kernel_found=0
init_found=0

if grep -q "xv6 kernel is booting" "$log"; then
  kernel_found=1
fi

if grep -q "init: starting sh" "$log"; then
  init_found=1
fi

echo "timeout/make exit code: ${code}" >>"$log"
echo >>"$log"

if [ "$kernel_found" -eq 1 ] && [ "$init_found" -eq 1 ]; then
  echo "BOOT_EVIDENCE_FOUND" | tee -a "$log"
  echo "[OK] detected: xv6 kernel is booting"
  echo "[OK] detected: init: starting sh"
  echo "[INFO] QEMU was stopped by timeout; this is not a long-running stability or manual interaction test."
  echo "[INFO] Manual QEMU exit sequence, when used interactively: Ctrl-a then x."
  exit 0
fi

echo "BOOT_EVIDENCE_NOT_FOUND" | tee -a "$log"
if [ "$kernel_found" -eq 1 ]; then
  echo "[OK] detected: xv6 kernel is booting"
else
  echo "[WARN] missing: xv6 kernel is booting"
fi

if [ "$init_found" -eq 1 ]; then
  echo "[OK] detected: init: starting sh"
else
  echo "[WARN] missing: init: starting sh"
fi

echo "[WARN] See log for the real QEMU output: ${log}"
echo "[WARN] Do not claim boot success without evidence."
exit 1
