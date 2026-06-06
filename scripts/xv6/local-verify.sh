#!/usr/bin/env bash
set -u

MODE=""

usage() {
  cat <<'EOF'
Usage:
  bash scripts/xv6/local-verify.sh --full
      Local pre-recording verification from clean integrated apply+make.

  bash scripts/xv6/local-verify.sh --quick
      Local pre-recording verification after make already succeeded.
      Recommended before recording a demo.

  bash scripts/xv6/local-verify.sh --help
      Show this help.

Notes:
  - This script reuses scripts/xv6/teammate-verify.sh.
  - It does not implement a separate test path.
  - If QEMU gets stuck, run: bash scripts/xv6/cleanup-qemu.sh
EOF
}

if [ "$#" -eq 0 ]; then
  echo "[ERROR] choose --full or --quick."
  usage
  exit 2
fi

for arg in "$@"; do
  case "$arg" in
    --full) MODE="full" ;;
    --quick) MODE="quick" ;;
    --help|-h) usage; exit 0 ;;
    *)
      echo "[ERROR] unknown argument: ${arg}"
      usage
      exit 2
      ;;
  esac
done

if [ -z "$MODE" ]; then
  echo "[ERROR] choose --full or --quick."
  usage
  exit 2
fi

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$REPO_ROOT" || {
  echo "[ERROR] failed to enter repo root: ${REPO_ROOT}"
  exit 1
}

echo "local pre-recording verification"
echo "mode : ${MODE}"
echo "repo : ${REPO_ROOT}"
echo
echo "[INFO] This is the team lead local pre-recording verification wrapper."
echo "[INFO] Recommended before recording: bash scripts/xv6/local-verify.sh --quick"
echo "[INFO] Reusing teammate workflow so local and teammate checks stay consistent."
echo

exec bash scripts/xv6/teammate-verify.sh "--${MODE}"
