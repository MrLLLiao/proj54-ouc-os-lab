#!/usr/bin/env bash
set -u

echo "xv6 QEMU cleanup helper"
echo "time : $(date -Iseconds 2>/dev/null || date)"
echo "cwd  : $(pwd)"
echo

echo "[INFO] Ctrl+C = interrupt the foreground command."
echo "[INFO] Ctrl+Z = suspend the foreground command; it is not an exit."
echo "[INFO] If your shell shows a stopped job such as %1, run: kill %1"
echo
echo "[WARN] This is a rescue-level cleanup."
echo "[WARN] pkill may affect other xv6/QEMU runs inside the same WSL instance."
echo

echo "[INFO] In the shell where you pressed Ctrl+Z, check jobs with:"
echo "       jobs -l"
echo

echo "[INFO] Current possible QEMU / make qemu processes:"
if pgrep -af 'qemu-system-riscv64|make.*qemu' 2>/dev/null; then
  :
else
  echo "       (none found)"
fi
echo

echo "[STEP] pkill -f qemu-system-riscv64 || true"
pkill -f qemu-system-riscv64 2>/dev/null || true

echo "[STEP] pkill -f \"make qemu\" || true"
pkill -f "make qemu" 2>/dev/null || true

echo
echo "[INFO] Remaining possible QEMU / make qemu processes:"
if pgrep -af 'qemu-system-riscv64|make.*qemu' 2>/dev/null; then
  echo "[WARN] Some matching processes still exist. If they are from this xv6 run, close them manually."
else
  echo "       (none found)"
fi

echo
echo "[OK] cleanup helper finished. This rescue script exits 0 even if nothing needed cleanup."
exit 0
