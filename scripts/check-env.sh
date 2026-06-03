#!/usr/bin/env bash
# proj54-ouc-os-lab environment precheck (lab0)
# Read-only: detects tool availability only. It does NOT install anything,
# and it does NOT build, boot, or test xv6-riscv.
set -uo pipefail

req_missing=0     # number of missing REQUIRED base tools
riscv_found=0     # whether at least one RISC-V cross compiler is present

# check_tool <category> <command> [hint]
# prints [OK]/[WARN]; returns 0 if found, 1 if missing.
check_tool() {
  category="$1"
  cmd="$2"
  hint="${3:-}"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[OK]   (${category}) ${cmd} -> $(command -v "$cmd")"
    return 0
  fi
  if [ -n "$hint" ]; then
    echo "[WARN] (${category}) ${cmd} not found in PATH — ${hint}"
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
check_tool REQUIRED git  || req_missing=$((req_missing + 1))
check_tool REQUIRED bash || req_missing=$((req_missing + 1))
check_tool REQUIRED make || req_missing=$((req_missing + 1))
echo

echo "--- EXPECTED for xv6-riscv (not yet imported at MVP v0.1) ---"
check_tool XV6 qemu-system-riscv64 "QEMU RISC-V system emulator (apt: qemu-system-misc)"
check_tool XV6 riscv64-unknown-elf-gcc "bare-metal RISC-V cross compiler" && riscv_found=1
check_tool XV6 riscv64-linux-gnu-gcc "linux-gnu RISC-V cross compiler (apt: gcc-riscv64-linux-gnu)" && riscv_found=1
echo

echo "=================== summary ==================="
if [ "$req_missing" -gt 0 ]; then
  echo "[RISK] ${req_missing} REQUIRED base tool(s) missing in THIS shell."
  echo "       If you are in Windows Git Bash/MSYS, this is expected (e.g. no make):"
  echo "       build and run xv6 inside WSL2 Ubuntu instead, not in Git Bash."
else
  echo "[OK]   All REQUIRED base tools are present in this shell."
fi

if [ "$riscv_found" -eq 1 ] && command -v qemu-system-riscv64 >/dev/null 2>&1; then
  echo "[OK]   QEMU RISC-V and a RISC-V cross compiler are both present."
  echo "       xv6-riscv build prerequisites look satisfied (build still needs the baseline)."
else
  echo "[WARN] QEMU and/or a RISC-V cross compiler are missing — xv6 cannot be built/run yet."
  echo "       Acceptable at MVP v0.1 (xv6 baseline not imported). xv6 needs QEMU plus ONE of"
  echo "       riscv64-unknown-elf-gcc or riscv64-linux-gnu-gcc."
fi
echo

echo "--- next steps ---"
echo "1. Use WSL2 Ubuntu for real xv6 work (not Windows Git Bash)."
echo "2. In WSL2 Ubuntu, install prerequisites (needs team-lead authorization, network):"
echo "     sudo apt update"
echo "     sudo apt install -y git build-essential gdb-multiarch qemu-system-misc \\"
echo "                         gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu"
echo "3. Re-run this script inside WSL2 to confirm qemu-system-riscv64 and a riscv64 gcc are [OK]."
echo "4. See docs/11_xv6_baseline_plan.md and external/README.md for baseline import."
echo
echo "Note: this precheck only detects tools; it does not install, build, or boot xv6."
echo "Do not record xv6 as 'runnable' until a real build/boot log exists (no faking)."

# Exit 0 by design: missing base/optional tools are reported, not treated as failures.
exit 0
