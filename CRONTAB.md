# VIRGIL — Automation Schedule

Everything VIRGIL does automatically, and when.

---

## VIRGIL Crontab

The recommended crontab for a single-machine VIRGIL installation. Adjust paths for your setup.

```cron
# ── Environment ────────────────────────────────────────────────────────────────
ANTHROPIC_API_KEY='your-key-here'
VIRGIL_DIR=/home/youruser/Documents/VIRGIL
SLACK_WEBHOOK_URL='your-webhook-url'   # optional — skip to disable Slack

# ── Morning ingest (runs before you wake up) ───────────────────────────────────
0  6 * * *   python3 $VIRGIL_DIR/ingest/rss-ingest.py >> $VIRGIL_DIR/ingest/rss-ingest.log 2>&1
15 6 * * *   python3 $VIRGIL_DIR/ingest/cve-ingest.py --recent >> $VIRGIL_DIR/ingest/cve-ingest.log 2>&1

# ── Nightly wikilink pass ──────────────────────────────────────────────────────
30 23 * * *  bash $VIRGIL_DIR/ingest/wikilink-ingest.sh >> $VIRGIL_DIR/ingest/wikilink-ingest.log 2>&1

# ── Nightly auto-reflect (fills unfilled session stubs) ───────────────────────
55 23 * * *  bash $VIRGIL_DIR/hooks/auto-reflect.sh

# ── Nightly promote (daily log → memory.md) ───────────────────────────────────
0  2 * * *   bash $VIRGIL_DIR/hooks/promote.sh

# ── Nightly vault backup (rsync → USB, silent if not mounted) ─────────────────
5  2 * * *   bash $VIRGIL_DIR/hooks/vault-backup.sh

# ── Monday inbox triage ───────────────────────────────────────────────────────
0  8 * * 1   bash $VIRGIL_DIR/ingest/triage-inbox.sh >> $VIRGIL_DIR/ingest/triage-inbox.log 2>&1

# ── Sunday weekly rollup ──────────────────────────────────────────────────────
0  1 * * 0   bash $VIRGIL_DIR/hooks/weekly-rollup.sh
5  1 * * 0   bash $VIRGIL_DIR/hooks/vault-backup.sh
```

---

## Schedule at a Glance

```
  TIME         SCRIPT                   WHAT IT DOES
  ──────────── ──────────────────────── ─────────────────────────────────────────────
  06:00 daily  rss-ingest.py            Pull 22 feeds, synthesize → feeds/YYYY-MM-DD.md
  06:15 daily  cve-ingest.py --recent   Pull last 24h CVEs from NVD → notes/cve/
  23:30 daily  wikilink-ingest.sh       Inject [[links]] in recently modified notes
  23:55 daily  auto-reflect.sh          Fill unfilled <!-- placeholders --> in daily log
  02:00 daily  promote.sh               Daily log → memory.md; Slack summary
  02:05 daily  vault-backup.sh          rsync → USB (silent if not mounted)

  08:00 Mon    triage-inbox.sh          Route inbox notes: merge/keep/archive/mitre
  01:00 Sun    weekly-rollup.sh         7-day digest → weekly-summaries/YYYY-WNN.md
  01:05 Sun    vault-backup.sh          Sunday backup (before weekly summary is stale)
```

---

## Claude Code Hooks (non-cron)

These fire on Claude Code session events, not on a schedule.

| Event | Hook | What it does |
|---|---|---|
| `SessionStart` | `hooks/session-start.sh` | Creates today's daily log if missing; shows pending task count |
| `Stop` (session end) | `hooks/session-end.sh` | Appends timestamped session entry to daily log (deduped by session ID) |

Hook configuration goes in `.claude/settings.json`:
```json
{
  "hooks": {
    "SessionStart": [{ "command": "bash $VIRGIL_DIR/hooks/session-start.sh" }],
    "Stop":         [{ "command": "bash $VIRGIL_DIR/hooks/session-end.sh" }]
  }
}
```

---

## Semaphore Scheduled Tasks (Fleet Deployment)

If you're running VIRGIL across a homelab fleet with Semaphore (Ansible UI), these scheduled playbooks maintain the nodes VIRGIL runs on.

| Schedule | Task | What it does |
|---|---|---|
| Mon/Thu 3:00am | APT upgrade | `apt-get update && apt-get upgrade -y` across all nodes |
| Mon/Thu 4:00am | Config backup | Backs up `/etc` and service configs to NAS |
| On-demand | VIRGIL deploy | Deploys updated VIRGIL vault and scripts to fleet |

---

## What Each Script Actually Does

### `rss-ingest.py`
Fetches entries from all 22 feeds published in the last 24 hours. Passes the raw items to Claude Haiku with a structured prompt. Writes the synthesized digest to `notes/feeds/YYYY-MM-DD.md`. If the API is unavailable, exits non-zero and logs the failure — does not write a partial digest.

### `cve-ingest.py --recent`
Queries NVD API v2 for CVEs published or modified in the last 24 hours. For each CVE: writes a structured Obsidian note with CVSS score, vector, affected products, description, and ATT&CK technique mapping where available. Notes link to existing ATT&CK technique notes in `notes/mitre/` via `[[wikilinks]]`.

### `wikilink-ingest.sh`
Scans notes modified in the last 24 hours. For each modified note, checks every word/phrase against the vault's known note titles. Injects `[[wikilink]]` syntax where a match is found. Skips content inside code blocks, YAML frontmatter, and existing links. Does not link a note to itself.

### `auto-reflect.sh`
Reads today's daily log. If `<!-- fill in manually -->` placeholders exist (unfilled session stubs from `session-end.sh`), extracts the surrounding session metadata and feeds it to Claude to generate a brief summary. Fills each stub in-place. Silent exit if no placeholders or no log exists.

### `promote.sh`
Reads the full daily log. Sends it to Claude with a structured extraction prompt. Receives back: completed tasks (matched against `memory-working.md` pending list), new decisions, lessons learned, and facts worth preserving. Writes extracted content to `memory.md`. Posts a Slack summary of what was promoted. Silent if the log doesn't exist or is empty.

### `weekly-rollup.sh`
Reads the last 7 daily logs plus that week's feed digests and notable study notes. Claude synthesizes into a weekly summary with sections for key learnings, decisions made, progress on goals, and orphaned notes. Writes to `weekly-summaries/YYYY-WNN.md`. Posts Slack digest.

### `triage-inbox.sh`
Reads each note in `notes/inbox/`. For each, Claude decides: **merge** (into an existing note), **keep** (as standalone in knowledge/), **archive**, or **mitre** (route to `notes/mitre/`). Applies the routing decision and logs the reasoning. Runs Monday 8am so the inbox is clear before the week starts.

### `vault-backup.sh`
`rsync`s the full vault to a mounted USB drive at a configured path. Exits silently if the drive isn't mounted. On success, posts a Slack notification with the backup size and timestamp. Runs at 2:05am (after promote) and 1:05am Sunday (after weekly-rollup).
