#!/usr/bin/env bash
set -uo pipefail

usage() {
  echo "Usage: bash scripts/run-lab.sh <lab0|lab1|lab2|lab3|lab4|lab5>"
}

lab="${1:-}"

if [ -z "$lab" ]; then
  usage
  exit 0
fi

case "$lab" in
  lab0)
    readme="labs/lab0-env-setup/README.md"
    ;;
  lab1)
    readme="labs/lab1-system-call/README.md"
    ;;
  lab2)
    readme="labs/lab2-process-and-scheduling/README.md"
    ;;
  lab3)
    readme="labs/lab3-memory-and-pagetable/README.md"
    ;;
  lab4)
    readme="labs/lab4-file-system/README.md"
    ;;
  lab5)
    readme="labs/lab5-final-integration/README.md"
    ;;
  *)
    echo "[WARN] Unknown lab: ${lab}"
    usage
    exit 0
    ;;
esac

echo "proj54-ouc-os-lab lab entry"
echo "Requested lab: ${lab}"
echo

if [ -f "$readme" ]; then
  echo "[OK] README found: ${readme}"
else
  echo "[WARN] README missing: ${readme}"
fi

echo
case "$lab" in
  lab0)
    echo "Next step: run environment precheck:"
    echo "  bash scripts/check-env.sh"
    ;;
  lab1)
    echo "Current status: design stage."
    echo "Next step: import and verify xv6-riscv baseline before adding real build/run commands."
    ;;
  *)
    echo "Current status: planned."
    echo "Next step: read the lab README and wait for xv6-riscv baseline plus detailed test commands."
    ;;
esac

echo
echo "This script does not build, boot, or test xv6-riscv at MVP v0.1."
