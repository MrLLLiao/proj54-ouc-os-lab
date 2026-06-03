#!/usr/bin/env bash
set -uo pipefail

check_cmd() {
  cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    path="$(command -v "$cmd")"
    echo "[OK]   ${cmd} -> ${path}"
  else
    echo "[WARN] ${cmd} not found in PATH"
  fi
}

echo "proj54-ouc-os-lab lab0 environment precheck"
echo "Repository: $(pwd)"
echo

check_cmd git
check_cmd bash
check_cmd make
check_cmd qemu-system-riscv64
check_cmd riscv64-unknown-elf-gcc

echo
echo "Note: this script is a lab0 precheck only."
echo "xv6-riscv baseline has not been imported yet, so some WARN items are acceptable at MVP v0.1."
echo "Before claiming xv6 is runnable, record the real baseline version, commands, and outputs."
