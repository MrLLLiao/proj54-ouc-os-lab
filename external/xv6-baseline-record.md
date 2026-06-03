# xv6-riscv Baseline Record

This file records metadata for the local xv6-riscv baseline used by proj54-ouc-os-lab.
It is safe to commit this metadata file. Do not commit the third-party source tree at `external/xv6-riscv/`.

| Field | Value |
| --- | --- |
| Upstream URL | `https://github.com/mit-pdos/xv6-riscv.git` |
| Local path | `external/xv6-riscv` |
| Current commit hash | `74f84181a3404d1d6a6ff98d342233979066ebb8` |
| Current branch | `riscv` |
| Remote URL | `https://github.com/mit-pdos/xv6-riscv.git` |
| LICENSE file exists | yes |
| Record generated at | 2026-06-03T23:27:49+08:00 |
| Built | yes, `make` completed successfully at 2026-06-03 23:50:03 +08:00 |
| Build log | `logs/xv6-make-20260603-235003.log` (ignored by Git) |
| Boot evidence | yes, detected `xv6 kernel is booting` and `init: starting sh` at `logs/xv6-boot-20260604-001736.log` |
| Manual interaction | no, not tested |

## Notes

- `external/xv6-riscv/` is ignored by `.gitignore` and should not be committed as third-party source code.
- This record claims that `make` completed successfully and boot evidence was captured by script. It does not claim long-running stability or manual shell interaction.
- Future build logs should be generated only from real commands and recorded under `logs/` or summarized in project docs.
