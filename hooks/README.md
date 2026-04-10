# hooks/

> [[VIRGIL]] automation hooks — Claude Code session lifecycle, nightly promotion, weekly digest, and vault backup

Hooks fire automatically via [[Claude Code]] hook events (SessionStart, Stop) or cron on [[ABADDON]] and [[BEHEMOTH]]. They are the connective tissue between [[VIRGIL]]'s daily log, memory, and the broader [[COCYTUS]] vault.

---

## Hook Scripts

### session-start.sh
**Event:** `SessionStart` (fires once per Claude Code session open)
**Purpose:** Prints the VIRGIL startup banner, the 3 most recent `## Promoted` entries from `memory.md`, and any unfilled `<!-- fill in manually -->` placeholders in today's daily log.
**Output:** Terminal only — no files written, no Slack.

---

### session-end.sh
**Event:** `Stop` (fires after every assistant response turn)
**Purpose:** Appends a timestamped `## Session ended at HH:MM:SS` entry to today's daily log. Deduplicates by `session_id` — only the *first* Stop for a given session writes; all subsequent turns in the same session are skipped.
**Output:** `daily-logs/YYYY-MM-DD.md`

---

### promote.sh
**Schedule:** `0 2 * * *` — daily at 2:00 AM
**Purpose:** Reads today's daily log, calls [[Claude]] API to extract key decisions, lessons learned, and promoted facts, then appends a `## Promoted — YYYY-MM-DD` section to `memory.md`. Also diffs completed tasks against the pending list and moves `- [x]` items to `## ✅ Completed Tasks`. Posts Slack notification on success or skip.
**Output:** `memory.md`, Slack

---

### weekly-rollup.sh
**Schedule:** `0 1 * * 0` — Sundays at 1:00 AM (before promote.sh)
**Purpose:** Collects the past 7 daily logs, feed digests (`notes/feeds/`), and study logs (`notes/personal/study/`). Calls [[Claude]] API to synthesise a structured weekly digest. Writes to `weekly-summaries/YYYY-WNN.md` and posts to Slack.
**Output:** `weekly-summaries/YYYY-WNN.md`, Slack
**Related skill:** `/week` — manual trigger from within a Claude Code session

---

### nebuchadnezzar.sh
**Schedule:** `5 2 * * *` (daily, 5min after promote.sh) and `5 1 * * 0` (Sunday, 5min after weekly-rollup.sh)
**Purpose:** rsync backup of the entire [[COCYTUS]] vault (`/home/your-username/Documents/Cocytus/`) to `/media/your-username/USB STICK/COCYTUS-Backup/` with `--delete`. Exits silently if the USB drive is not mounted. Posts Slack notification on success or drive-missing warning.
**Output:** `hooks/nebuchadnezzar.log`, Slack
**Named after:** [[Nebuchadnezzar]] — the ship from *The Matrix*, keeper of the crew between runs

---

## Log Files

| File | Written by |
|------|-----------|
| `promote.log` | `promote.sh` |
| `weekly-rollup.log` | `weekly-rollup.sh` |
| `nebuchadnezzar.log` | `nebuchadnezzar.sh` |

---

## Cron Schedule Summary

| Time | Script | Host |
|------|--------|------|
| SessionStart | `session-start.sh` | any [[Claude Code]] host |
| Stop (per session) | `session-end.sh` | any [[Claude Code]] host |
| Sun 01:00 | `weekly-rollup.sh` | [[ABADDON]] |
| Sun 01:05 | `nebuchadnezzar.sh` | [[BEHEMOTH]] |
| Daily 02:00 | `promote.sh` | [[ABADDON]] |
| Daily 02:05 | `nebuchadnezzar.sh` | [[BEHEMOTH]] |

---

## Related

- [[VIRGIL]] — second brain system these hooks serve
- [[COCYTUS]] — homelab vault backed up by nebuchadnezzar.sh
- [[Nebuchadnezzar]] — namesake of the backup script
- [[ABADDON]] — cron host for promote.sh and weekly-rollup.sh
- [[BEHEMOTH]] — primary workstation, Claude Code session host
