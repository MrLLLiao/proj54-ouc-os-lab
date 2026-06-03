#!/usr/bin/env bash
# proj54-ouc-os-lab environment precheck (lab0)
# Read-only: detects tool availability only. It does NOT install anything,
# and it does NOT build, boot, or test xv6-riscv.
set -uo pipefail

req_missing=0
riscv_found=0

check_tool() {
  category="$1"
  cmd="$2"
  hint="${3:-}"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[OK]   (${category}) ${cmd} -> $(command -v "$cmd")"
    return 0
  fi
  if [ -n "$hint" ]; then
    echo "[WARN] (${category}) ${cmd} not found in PATH - ${hint}"
  else
    echo "[WARN] (${category}) ${cmd} not found in PATH"
  fi
  return 1
}

echo "=================================================="
echo " proj54-ouc-os-lab environment precheck (lab0)"
echo "=================================================="
echo "Repository : $(pwd)"
echo "Date       : $(date '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo unknown)"
if command -v uname >/dev/null 2>&1; then
  echo "uname      : $(uname -srm 2>/dev/null)"
else
  echo "uname      : (uname not available)"
fi
echo

echo "--- REQUIRED base tools (repo + build driver) ---"
check_tool REQUIRED git || req_missing=$((req_missing + 1))
check_tool REQUIRED bash || req_missing=$((req_missing + 1))
check_tool REQUIRED make || req_missing=$((req_missing + 1))
echo

echo "--- EXPECTED for xv6-riscv ---"
check_tool XV6 qemu-system-riscv64 "QEMU RISC-V system emulator (apt: qemu-system-misc)"
check_tool XV6 riscv64-unknown-elf-gcc "bare-metal RISC-V cross compiler" && riscv_found=1
check_tool XV6 riscv64-linux-gnu-gcc "linux-gnu RISC-V cross compiler (apt: gcc-riscv64-linux-gnu)" && riscv_found=1
echo

echo "=================== summary ==================="
if [ "$req_missing" -gt 0 ]; then
  echo "[RISK] ${req_missing} REQUIRED base tool(s) missing in THIS shell."
  echo "       If you are in Windows Git Bash/MSYS, build and run xv6 inside WSL2 Ubuntu instead."
else
  echo "[OK]   All REQUIRED base tools are present in this shell."
fi

if [ "$riscv_found" -eq 1 ] && command -v qemu-system-riscv64 >/dev/null 2>&1; then
  echo "[OK]   QEMU RISC-V and a RISC-V cross compiler are both present."
  echo "       xv6-riscv build prerequisites look satisfied."
else
  echo "[WARN] QEMU and/or a RISC-V cross compiler are missing; xv6 cannot be built/run yet."
  echo "       xv6 needs QEMU plus ONE of riscv64-unknown-elf-gcc or riscv64-linux-gnu-gcc."
fi
echo

echo "--- next steps ---"
echo "1. Use WSL2 Ubuntu for real xv6 work (not Windows Git Bash)."
echo "2. For baseline structure checks:"
echo "     bash scripts/xv6/check-xv6-baseline.sh"
echo "3. For build verification, use only after team-lead confirmation:"
echo "     bash scripts/xv6/check-xv6-baseline.sh --make"
echo "4. For boot evidence checks:"
echo "     bash scripts/xv6/boot-xv6.sh"
echo
echo "Note: this precheck only detects tools; it does not install, build, or boot xv6."
echo "Current project records show baseline make succeeded and boot evidence was captured."
echo "Long-running stability and manual shell interaction remain TODO."

exit 0
