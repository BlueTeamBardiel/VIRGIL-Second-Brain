# VIRGIL — Second Brain Automation System

VIRGIL is an automation layer for an [Obsidian](https://obsidian.md) knowledge vault. It ingests PDFs, URLs, CVEs, and RSS feeds into structured Markdown notes, runs end-of-session reflections via Claude, promotes daily logs to weekly digests, and keeps a wikilink graph connected.

Designed for a sysadmin/homelab operator studying for security certifications. Works with any Obsidian vault.

---

## Architecture

```
Obsidian Vault ($VIRGIL_DIR)
├── notes/           ← generated knowledge notes (gitignored)
├── daily-logs/      ← session logs (gitignored)
├── weekly-summaries/← weekly digests (gitignored)
│
├── ingest/          ← pull external content into notes
├── hooks/           ← Claude Code lifecycle hooks + cron automation
├── scripts/         ← deploy, sync, AD hardening
└── .claude/commands/← slash commands for Claude Code
```

**Data flow:**

```
External sources ──► ingest/ ──► notes/inbox/ ──► triage-inbox.sh ──► notes/<category>/
                                                                     ↘ notes/archive/

Claude Code session ──► hooks/session-start.sh  (creates daily log)
                   └──► hooks/session-end.sh    (appends session entry)
                   └──► /reflect slash command   (fills log summary)

Daily log ──► hooks/promote.sh (1am Sun–Sat) ──► weekly-summaries/
          └──► hooks/weekly-rollup.sh (Sun 1am) ──► weekly-summaries/YYYY-WNN.md
```

---

## Requirements

- Linux/macOS (bash 4+, Python 3.9+)
- [Claude Code CLI](https://claude.ai/code) — for slash commands and hooks
- `curl`, `pandoc`, `pdftotext` (poppler-utils)
- Python packages: `feedparser requests` (for RSS ingest)
- Anthropic API key ([console.anthropic.com](https://console.anthropic.com))
- Slack incoming webhook (optional — all Slack calls fail silently if unset)

---

## Setup

### 1. Clone and configure

```bash
git clone https://github.com/your-username/VIRGIL.git ~/VIRGIL
cd ~/VIRGIL
cp .env.example .env
# Edit .env — set ANTHROPIC_API_KEY and optionally SLACK_WEBHOOK_URL
```

### 2. Set VIRGIL_DIR

All scripts default to `$HOME/VIRGIL` if `$VIRGIL_DIR` is not set.
To use a different path, export it before running scripts or add it to your shell profile:

```bash
export VIRGIL_DIR="$HOME/Documents/MyVault"
```

### 3. Add API key to crontab

Scripts that call Claude self-source the API key from crontab if it isn't in the environment. Add these lines to your crontab (`crontab -e`):

```
ANTHROPIC_API_KEY="sk-ant-your-key-here"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."
```

### 4. Make scripts executable

```bash
chmod +x hooks/*.sh ingest/*.sh ingest/*.py scripts/*.sh
```

### 5. Create vault structure

```bash
mkdir -p "$VIRGIL_DIR"/{notes/{inbox,archive,feeds,knowledge,mitre,personal/{workouts,study,nutrition},cve},daily-logs,weekly-summaries,ingest}
```

### 6. Register Claude Code hooks (optional)

Add to your Claude Code `settings.json`:

```json
{
  "hooks": {
    "SessionStart": [{"command": "bash $VIRGIL_DIR/hooks/session-start.sh"}],
    "Stop":         [{"command": "bash $VIRGIL_DIR/hooks/session-end.sh"}]
  }
}
```

### 7. Install crontab entries

```bash
crontab -e
```

Recommended schedule:

```cron
ANTHROPIC_API_KEY="your-key"
SLACK_WEBHOOK_URL="your-webhook"

# Daily log promotion — Mon–Sat 1am
0 1 * * 1-6  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/promote.sh

# Weekly digest — Sunday 1am
0 1 * * 0    VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/weekly-rollup.sh

# RSS feed ingest — 6am daily
0 6 * * *    VIRGIL_DIR=$HOME/VIRGIL python3 $HOME/VIRGIL/ingest/rss-ingest.py

# CVE ingest — 7am daily
0 7 * * *    VIRGIL_DIR=$HOME/VIRGIL python3 $HOME/VIRGIL/ingest/cve-ingest.py --recent

# Inbox triage — Monday 8am
0 8 * * 1    VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/ingest/triage-inbox.sh

# Wikilink injection — 11:30pm daily
30 23 * * *  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/ingest/wikilink-ingest.sh

# Auto-reflect — 11:55pm daily
55 23 * * *  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/auto-reflect.sh
```

---

## Ingest Scripts

| Script | Alias | Purpose |
|--------|-------|---------|
| `ingest/pdf-ingest.sh <file> [subdir]` | `virgil-pdf` | Convert PDF to Obsidian note via Claude. Chunks large PDFs (>80k chars) automatically. Output: `notes/knowledge/<subdir>/<slug>.md` |
| `ingest/nist-ingest.sh <file>` | `virgil-nist` | Like pdf-ingest but with NIST SP framing (control families, CySA+ relevance). Output: `notes/knowledge/nist/<slug>.md` |
| `ingest/url-ingest.sh <url> [hint]` | `virgil-url` | Fetch URL via curl+pandoc, let Claude decide to patch existing note or create new one. MITRE ATT&CK URLs route to `notes/mitre/` automatically. |
| `ingest/rss-ingest.py [--hours N]` | `virgil-rss` | Pull 20+ security/homelab RSS feeds, synthesize daily digest via Claude. Output: `notes/feeds/YYYY-MM-DD.md` |
| `ingest/cve-ingest.py --recent` | `virgil-cve` | Pull recent CVEs from NVD v2 API, write individual notes. Also supports `--keyword` and single CVE ID. Output: `notes/cve/CVE-YYYY-NNNNN.md` |
| `ingest/nist-ingest.sh <file>` | `virgil-nist` | NIST publication ingest with exam-oriented framing |
| `ingest/personal-ingest.sh workout\|meal\|goal\|study` | `virgil-workout` etc. | Log personal tracking entries (fitness, nutrition, study sessions) |
| `ingest/triage-inbox.sh` | `virgil-triage` | Monday 8am cron: Haiku triages each `notes/inbox/` note — merge into existing note, keep, archive, or route to `notes/mitre/` |
| `ingest/wikilink-ingest.sh` | `virgil-wikilink` | Scan recently modified notes, inject `[[wikilinks]]` for known titles. Skips code blocks, self-links, short titles. |
| `ingest/orphan-detect.sh [--slack] [--quiet]` | `virgil-orphans` | Find notes with zero inbound AND zero outbound wikilinks. Appended to weekly digest. |

---

## Hooks

All hooks live in `hooks/`. Claude Code hooks run automatically; cron hooks run on schedule.

| Hook | Trigger | Purpose |
|------|---------|---------|
| `session-start.sh` | Claude Code `SessionStart` | Creates today's daily log if missing, shows pending task count |
| `session-end.sh` | Claude Code `Stop` | Appends timestamped session entry to daily log (deduped by session ID) |
| `promote.sh` | Cron 1am Mon–Sat | Calls Claude to extract completed tasks from daily log, marks them done in `memory.md`, posts Slack summary |
| `promote-patch.py` | Called by promote.sh | Updates `memory-semantic.md` with superseded facts using `~~strikethrough~~` syntax |
| `weekly-rollup.sh` | Cron 1am Sunday | Synthesizes last 7 daily logs + feed digests + study logs into weekly digest. Appends orphan report. |
| `auto-reflect.sh` | Cron 11:55pm daily | Fills any unfilled `<!-- fill in manually -->` session placeholders in today's log using Claude |
| `nebuchadnezzar.sh` | Manual | rsync vault to USB backup drive. Posts Slack on success or drive-missing. |

---

## Slash Commands (Claude Code)

Claude Code slash commands live in `.claude/commands/`. Invoke with `/command-name` in Claude Code.

| Command | Purpose |
|---------|---------|
| `/reflect` | End-of-session reflection: fill log summary, update notes, mark completed tasks |
| `/week` | Generate weekly digest from last 7 daily logs |
| `/day` | Start-of-day briefing: pending tasks, yesterday summary, today's focus |
| `/lab` | Homelab status check and task planning |
| `/deploy` | Run deployment checklist for a target host |
| `/cysa` | CySA+ study session with practice questions and exam tips |
| `/ccna` | CCNA study session grounded in real lab gear |
| `/challenge` | Cross-reference a decision against vault knowledge — flags conflicts |
| `/research` | Deep research on a topic with vault integration |
| `/focus` | Pomodoro-style focus session with task tracking |
| `/job` | Job search assistant — resume, applications, interview prep |
| `/sync` | Sync vault state across machines |
| `/task` | Task management — add, update, list, complete |

---

## AD Hardening Scripts

`scripts/ad/` contains PowerShell scripts for hardening an Active Directory lab environment. Run these on a domain controller after promotion.

| Script | Purpose |
|--------|---------|
| `01-dns-records.ps1` | Create A records for all fleet hosts |
| `02-security-groups.ps1` | Create role-based security groups (Admins, Servers, Workstations, etc.) |
| `03-service-accounts.ps1` | Create gMSA/standard service accounts |
| `04-password-lockout-policy.ps1` | Fine-grained password and lockout policies |
| `05-gpo-audit-policy.ps1` | GPO: comprehensive audit policy (logon, object access, privilege use) |
| `06-gpo-powershell-logging.ps1` | GPO: PowerShell ScriptBlock + module + transcription logging |
| `07-gpo-smb-signing.ps1` | GPO: enforce SMB signing (disables NTLM relay vectors) |
| `08-gpo-firewall.ps1` | GPO: Windows Firewall baseline rules |
| `09-gpo-laps.ps1` | GPO: Windows LAPS (local admin password rotation) |
| `10-gpo-applocker.ps1` | GPO: AppLocker baseline (executables, scripts, MSI) |
| `11-activate-windows.ps1` | Activate Windows Server via KMS or volume license |

---

## Memory System (Three-Layer)

VIRGIL uses three Markdown files for persistent context (gitignored — personal content):

| File | Purpose | Cleared |
|------|---------|---------|
| `memory-working.md` | Active tasks, current sprint, in-flight work | Weekly by promote.sh |
| `memory-episodic.md` | Dated session history, promoted facts, completed work | Never (append-only) |
| `memory-semantic.md` | Permanent facts: fleet, certs, architecture, key decisions | Updated with supersede syntax |

Supersede syntax in `memory-semantic.md`:
```
~~old fact~~ superseded on YYYY-MM-DD → new fact
```

---

## Environment Variables

See `.env.example` for the full list. Summary:

| Variable | Required | Default | Purpose |
|----------|----------|---------|---------|
| `ANTHROPIC_API_KEY` | Yes | — | Claude API access |
| `VIRGIL_DIR` | No | `$HOME/VIRGIL` | Vault root path |
| `SLACK_WEBHOOK_URL` | No | — | Slack notifications (silently skipped if unset) |
| `ABADDON` | deploy scripts | — | Control node IP/hostname |
| `ABADDON_USER` | deploy scripts | — | SSH username on control node |
| `REMOTE_DIR` | deploy scripts | `$HOME/VIRGIL` | Remote vault path |

---

## License

MIT
