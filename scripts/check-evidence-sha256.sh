#!/usr/bin/env bash
# Verify externally stored evidence files against the SHA256 values recorded in
# submissions/evidence_manifest.md and submissions/demo_record.md.
#
# Evidence lives OUTSIDE the repository on purpose (videos, teammate summaries,
# screenshots are never committed). This script never copies them in; it only
# hashes them in place.
#
# Result semantics:
#   - external base directory missing      -> SKIP everything, exit 0
#   - individual file missing              -> WARN (not a failure)
#   - file present and hash matches        -> OK
#   - file present and hash differs        -> FAIL, exit 1
#   - new 0001-0009 evidence (still TBD)   -> NOTE only, never a failure
#
# Override the evidence location with:
#   XV6_EVIDENCE_BASE="/path/to/proj54_submission_assets" bash scripts/check-evidence-sha256.sh
set -u

fail=0
checked=0
matched=0
missing=0

# Locate a sha256 tool (Linux: sha256sum; macOS/Git Bash fallback: shasum).
if command -v sha256sum >/dev/null 2>&1; then
  hash_cmd() { sha256sum "$1" | awk '{print $1}'; }
elif command -v shasum >/dev/null 2>&1; then
  hash_cmd() { shasum -a 256 "$1" | awk '{print $1}'; }
else
  echo "[ERROR] neither sha256sum nor shasum found"
  exit 1
fi

# Candidate base directories (WSL mount, Git Bash mount, env override).
BASE="${XV6_EVIDENCE_BASE:-}"
if [ -z "$BASE" ]; then
  for cand in \
    "/mnt/d/Edge Download/CSCC/proj54_submission_assets" \
    "/d/Edge Download/CSCC/proj54_submission_assets"; do
    if [ -d "$cand" ]; then
      BASE="$cand"
      break
    fi
  done
fi

echo "external evidence SHA256 check"
echo "base : ${BASE:-<not found>}"
echo

if [ -z "$BASE" ] || [ ! -d "$BASE" ]; then
  echo "[SKIP] external evidence directory not present on this machine."
  echo "[SKIP] This is not a failure: evidence is stored outside Git and may"
  echo "[SKIP] only exist on the team lead's machine. Set XV6_EVIDENCE_BASE to check."
  echo
  echo "EVIDENCE_SHA256_RESULT: SKIPPED"
  exit 0
fi

# Recorded historical evidence (relative path|expected SHA256, case-insensitive).
# Source of truth: submissions/evidence_manifest.md, submissions/demo_record.md,
# submissions/teammate_reproduction_record.md.
EXPECTED="
videos/20260606_final_integrated_0001_0007_demo.mp4|0FF2D3581552B3FD3A2630E827251CF46C36BC3BE8F8B9D9DDB691FC0668A93B
videos/20260606_auto_verify_demo.mp4|8EBC5974364780076172B19C9272B860DC56BF66DE9D08D5ECC8D20C8A236088
videos/20260606_full_verify_demo.mp4|1963B9FD66E6A25E9EADAA3C81FFC35E360F9D699F2C7CF6C707E85680B1EFE5
videos/20260606_manual_xv6_shell_demo.mp4|2CD5DE43D3C262AB26A2A4251AE991ED973FA6A04FA8FD0B0178789563F5EE0B
teammate_reproduction/e8e2fb9_final_0001_0007/teammateA_root_e8e2fb9_full_20260606-235139.summary.txt|36E7A57554B524B11E99DF523AF54BCCBC2AA3E1682172899F5DA4A5EDAF90BE
teammate_reproduction/e8e2fb9_final_0001_0007/teammateA_root_e8e2fb9_full_20260606-235641.screenshot.png|4A3679274CA18B2E8BAEB9023C8D6DF7BE76738A5126C0F47ADAA3954ADC19D2
teammate_reproduction/e8e2fb9_final_0001_0007/teammateB_z2996_e8e2fb9_full_20260607-114807.console.log|108A6F254E47049B54CAFDE007542A14BFC2586AC3BA18039E66B3EDF2A9A40E
teammate_reproduction/e8e2fb9_final_0001_0007/teammateB_z2996_e8e2fb9_full_20260607-115137.screenshot.png|7089C1175D6CE49AE8ADA712552C8053FFEE1643B9A3776899FD396D12C085EF
"

while IFS='|' read -r rel expect; do
  [ -z "$rel" ] && continue
  path="$BASE/$rel"
  if [ ! -f "$path" ]; then
    echo "[WARN] missing (not a failure): $rel"
    missing=$((missing + 1))
    continue
  fi
  checked=$((checked + 1))
  actual="$(hash_cmd "$path")"
  expect_lc="$(printf '%s' "$expect" | tr 'A-F' 'a-f')"
  actual_lc="$(printf '%s' "$actual" | tr 'A-F' 'a-f')"
  if [ "$actual_lc" = "$expect_lc" ]; then
    echo "[OK]   $rel"
    matched=$((matched + 1))
  else
    echo "[FAIL] $rel"
    echo "       expected: $expect_lc"
    echo "       actual  : $actual_lc"
    fail=1
  fi
done <<EOF
$EXPECTED
EOF

echo
echo "[NOTE] new 0001-0009 evidence (teammate full verify, new demo video, new"
echo "[NOTE] SHA256) is still TBD and intentionally NOT checked here. Add its"
echo "[NOTE] entries to this script only after the real files and hashes exist."
echo
echo "files present+hashed: $checked  matched: $matched  missing: $missing"
if [ "$fail" -eq 0 ]; then
  echo "EVIDENCE_SHA256_RESULT: PASS"
else
  echo "EVIDENCE_SHA256_RESULT: FAIL"
fi
exit "$fail"
