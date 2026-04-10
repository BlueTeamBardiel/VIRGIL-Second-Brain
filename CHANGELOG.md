# Changelog

All notable changes to VIRGIL are documented here.

Format: [Semantic Versioning](https://semver.org/) — `MAJOR.MINOR.PATCH`

---

## [1.0.0] — 2026-04-10

### Initial Public Release

#### Ingest Pipeline
- **`ingest/rss-ingest.py`** — Pulls 22 curated security and homelab RSS feeds daily, synthesizes via Claude Haiku into a structured daily digest with Top Stories, CVE coverage, Homelab/Tooling, CySA+ Relevant, and Quick Hits sections
- **`ingest/cve-ingest.py`** — Consumes NVD v2 API for daily CVE ingest; supports `--recent`, `--keyword`, and single CVE ID lookup; CVSS scoring and ATT&CK technique mapping
- **`ingest/pdf-ingest.sh`** — Single-command PDF → Obsidian note conversion; automatic chunked processing for documents >80,000 characters (books, textbooks); `--first-pages N` flag for large documents
- **`ingest/nist-ingest.sh`** — NIST SP/FIPS-specific wrapper around pdf-ingest with exam-oriented framing (CySA+ domain coverage, control families, actionable blue team takeaways)
- **`ingest/url-ingest.sh`** — Fetch any URL → structured note or patch to existing note; MITRE ATT&CK URLs auto-routed to `notes/mitre/`
- **`ingest/triage-inbox.sh`** — Monday 8am cron: Claude Haiku reviews each inbox note and routes to merge/keep/archive/mitre with reasoning logged
- **`ingest/wikilink-ingest.sh`** — Nightly `[[wikilink]]` injection into recently modified notes; code-block aware, skips self-links and short titles
- **`ingest/orphan-detect.sh`** — Finds notes with zero inbound AND zero outbound wikilinks; appended to weekly digest; `--slack` and `--quiet` flags
- **`ingest/personal-ingest.sh`** — Workout, meal, goal, and study log entry capture

#### Automation Hooks
- **`hooks/session-start.sh`** — Claude Code `SessionStart` hook: creates daily log if missing, displays pending task count
- **`hooks/session-end.sh`** — Claude Code `Stop` hook: appends timestamped session entry to daily log (deduped by session ID)
- **`hooks/promote.sh`** — Daily log promotion: Claude extracts completed tasks, marks them done in memory files, posts Slack summary
- **`hooks/promote-patch.py`** — Reads daily log, generates semantic memory updates with supersede syntax (`~~old~~ superseded → new`)
- **`hooks/weekly-rollup.sh`** — Sunday 1am: synthesizes 7 daily logs + feed digests + study notes into structured weekly digest; appends orphan report
- **`hooks/auto-reflect.sh`** — 11:55pm cron: fills any unfilled `<!-- fill in manually -->` session placeholders using Claude
- **`hooks/nebuchadnezzar.sh`** — rsync vault backup to USB drive with Slack notification

#### Memory System
- Three-layer persistent context: `memory-working.md` (active tasks, cleared weekly), `memory-episodic.md` (session history, append-only), `memory-semantic.md` (permanent facts, supersede syntax)
- Supersede syntax: `~~old fact~~ superseded on YYYY-MM-DD → new fact`

#### Claude Code Slash Commands
13 commands in `.claude/commands/`: `/reflect`, `/week`, `/day`, `/lab`, `/deploy`, `/cysa`, `/ccna`, `/challenge`, `/focus`, `/research`, `/job`, `/sync`, `/task`

#### Active Directory Hardening Scripts
11 PowerShell scripts in `scripts/ad/`: DNS records, security groups, service accounts, password/lockout policy, GPO audit policy, PowerShell logging, SMB signing, firewall baseline, LAPS, AppLocker, Windows activation

#### Infrastructure
- **`scripts/setup.sh`** — Interactive first-time setup wizard: prereq check, API key config, vault creation, crontab installation, alias setup, connectivity test
- **`scripts/deploy-machine.sh`** — Deploy VIRGIL to a remote Linux host via SSH
- **`scripts/sync-projects.sh`** — Sync vault across multiple machines
- All scripts use `$VIRGIL_DIR` env var with `$HOME/VIRGIL` fallback — no hardcoded paths
- All scripts self-source `ANTHROPIC_API_KEY` and `SLACK_WEBHOOK_URL` from crontab if not in environment
- MITRE ATT&CK routing: `t[0-9]{4}` slugs and `attack.mitre.org` URLs automatically routed to `notes/mitre/`

#### Documentation
- Comprehensive `README.md` with architecture diagram, feature list, RSS feed catalog, resume bullet points, quick start, full crontab schedule
- `GETTING-STARTED.md` for first-time Obsidian users
- Knowledge base stubs: `notes/inbox/`, `notes/mitre/`, `notes/cve/`, `notes/knowledge/`
- `CLAUDE.md` for Claude Code context
- `.env.example` with all required and optional variables documented

---

## Roadmap

Planned for future releases:

- [ ] `ingest/github-ingest.sh` — track starred repos, new releases from followed projects
- [ ] `ingest/youtube-ingest.sh` — ingest video transcripts (conference talks, tutorials)
- [ ] `notes/playbooks/` — incident response and hardening playbooks directory
- [ ] Web UI dashboard for vault health (orphan count, ingest stats, weekly trend)
- [ ] Automated ATT&CK coverage map generation from mitre/ notes
- [ ] Export: generate a PDF study guide from accumulated notes
