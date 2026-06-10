#!/usr/bin/env bash
# Final pre-submission hygiene gate.
# Checks that forbidden material is not tracked by Git and that the diff is clean.
# Read-only. Exit 0 = all checks pass; exit 1 = at least one FAIL.
#
# Whitelist: slides/final_defense_ppt.pptx is the single allowed Office binary
# (generated from tracked slides/final_ppt.md by slides/generate_final_ppt.py).
set -u

fail=0

repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "[ERROR] not inside a Git repository"
  exit 1
}
cd "$repo_root" || exit 1

echo "final hygiene check"
echo "repo : $repo_root"
echo

check_empty() {
  label="$1"
  shift
  out="$(git ls-files -- "$@" 2>/dev/null)"
  if [ -n "$out" ]; then
    echo "[FAIL] ${label} tracked by Git:"
    echo "$out" | sed 's/^/       /'
    fail=1
  else
    echo "[OK]   ${label}: none tracked"
  fi
}

check_empty "external/xv6-riscv (third-party source)" "external/xv6-riscv"
check_empty "raw logs"            "logs/*.log"
check_empty "verify summaries"    "logs/*.summary.txt"
check_empty "console captures"    "logs/*.console.txt"
check_empty ".claude directory"   ".claude"
check_empty ".vscode directory"   ".vscode"

# Media / archive / office binaries. Whitelist: the generated defense PPTX only.
media="$(git ls-files | grep -Ei '\.(mp4|mov|avi|mkv|zip|7z|rar|png|jpg|jpeg|gif|bmp|pdf|doc|docx|xls|xlsx|ppt|pptx)$' | grep -v '^slides/final_defense_ppt\.pptx$' || true)"
if [ -n "$media" ]; then
  echo "[FAIL] media/archive/office files tracked (whitelist is slides/final_defense_ppt.pptx only):"
  echo "$media" | sed 's/^/       /'
  fail=1
else
  echo "[OK]   media/archive/office: only the whitelisted PPTX (or none)"
fi

if git ls-files --error-unmatch slides/final_defense_ppt.pptx >/dev/null 2>&1; then
  echo "[INFO] whitelisted: slides/final_defense_ppt.pptx (generated from slides/final_ppt.md)"
fi

if git diff --check >/dev/null 2>&1; then
  echo "[OK]   git diff --check: clean"
else
  echo "[FAIL] git diff --check found whitespace problems:"
  git diff --check | sed 's/^/       /'
  fail=1
fi

echo
if [ "$fail" -eq 0 ]; then
  echo "HYGIENE_RESULT: PASS"
else
  echo "HYGIENE_RESULT: FAIL"
fi
exit "$fail"
