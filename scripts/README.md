# scripts/

Utility scripts that ship with VIRGIL. Most run automatically — `install.sh` invokes some at setup, others run via cron from `~/VIRGIL/`. A few are forker-relevant.

| Script | Purpose |
|---|---|
| `install.sh` | Sets up the runtime vault, dependencies, environment, and cron jobs. The script you run first. |
| `uninstall.sh` | Removes VIRGIL — cron jobs, aliases, env config. Leaves your vault content alone. |
| `check-deps.sh` | Verifies system dependencies. Called by `install.sh`; can be run standalone for diagnostics. |
| `docker-entrypoint.sh` | Container startup script. Used if you run VIRGIL in Docker. |
| `promote-to-public.py` | The gate that produces this public repo from the maintainer's private content. Documented in `ARCHITECTURE.md §11.5`. Useful as a reference if you fork VIRGIL and want to maintain your own public/private split. |
| `homelab/ad-hardening/` | Eleven PowerShell scripts for hardening a Windows Server lab — study-adjacent labs that connect Sec+ and CySA+ concepts to hands-on practice. See `homelab/ad-hardening/README.md`. |

For runtime helpers (memory distillation, weekly digest, vault backup), see `hooks/` instead. For ingest pipelines (RSS, CVE, URL, PDF), see `ingest/`.
