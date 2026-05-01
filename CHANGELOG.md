# Changelog

All notable changes to VIRGIL are documented here.

Format: [Semantic Versioning](https://semver.org/) — `MAJOR.MINOR.PATCH`

---

## [1.9.2] — 2026-05-01

- Security hardening: command injection prevention in ingest scripts
- Security hardening: path traversal protection in cert-ingest.sh
- Circuit breaker added to llm_client.py for sustained API failure
- Docker documentation added (`docs/DOCKER.md`)
- Dependency manifest added (`docs/DEPENDENCIES.md`, `scripts/check-deps.sh`)
- Comprehensive CHANGELOG added with all intermediate versions
- False independent audit reference removed from README

---

## [1.9.1] — 2026-05-01

- Audit remediation: version bump to v1.9.0, private data scrub, CI added
- `hooks/llm_client.py`: BEHEMOTH/ABADDON removed; env-var-driven primary/secondary Ollama
- `hooks/llm_client.py`: crontab API key extraction replaced with simple env lookup
- `ingest/rss-ingest.py`: hardcoded personal name replaced with CLAUDE.md dynamic profile; 429 retry added
- `hooks/cert-roadmap.py`: Network+ added to CERT_PATH; cert path updated
- `hooks/quiz.sh`: ChromaDB crash replaced with graceful grep fallback
- `hooks/session-start.sh`: first-session `/start` hint added
- `ingest/cert-ingest.sh`: `echo` replaced with `printf` for safe temp file write
- `scripts/install.sh`: personal vault dirs removed; note count corrected to 1,500+
- `scripts/ad/`: BEHEMOTH/ABADDON replaced with generic hostnames in examples
- `.claude/commands/job.md`: personal employer data removed
- `.github/workflows/ci.yml`: syntax check + private data scan CI added
- `.github/ISSUE_TEMPLATE/content_contribution.md`: new issue template
- `scripts/uninstall.sh`: clean uninstall script added
- `GETTING-STARTED.md`: `virgil-review` daily habit section + first-week guide added

---

## [1.9.0] — 2026-05-01

- Net+ N10-009 starter notes (87 Professor Messer videos ingested)
- Security+ SY0-701 starter notes (121 Professor Messer videos ingested)
- SDR hobbyist series starter notes (28 videos ingested)
- Total starter notes: 236 new notes
- Cert path updated: A+ → Network+ → Security+ → CCNA → CySA+
- `hooks/virgil-progress.py`: `netplus` (5 domains) and `sdr` (4 domains) added to `DOMAIN_MAPS`
- `run-netplus-sdr-ingest.sh`: overnight pipeline for all three playlists

---

## [1.8.1] — 2026-04-30

- A+ Core 1+2 starter notes: 137 notes from Professor Messer transcripts
- `run-aplus-ingest.sh`: overnight VTT → Obsidian pipeline for Core 1 and Core 2

---

## [1.8.0] — 2026-04-30

- CCNA + CySA+ starter notes added to `starter-notes/knowledge/`
- Content ingestion pipeline established for cert note generation
- `hooks/llm_client.py`: Anthropic backend moved to first in fallback order

---

## [1.7.0] — 2026-04-30

- Streak tracking (`hooks/streak.py`): consecutive study days, milestone messages
- Cert roadmap generator (`hooks/cert-roadmap.py`): Obsidian note with progress bars
- Lab status generator (`hooks/lab-generator.py`)
- Progress checkpoint system (`hooks/virgil-progress.py`)
- Proactive absence detection in `hooks/session-start.sh`
- `ingest/cert-ingest.sh`: heredoc special-character corruption bug fixed

---

## [1.6.0] — 2026-04-29

- Learning engine: `/diagnose`, `/plan`, `/teach` slash commands
- `ingest/cert-ingest.sh`: PDF/URL/transcript → Feynman-style vault notes
- `virgil-cert-ingest` alias installed by `scripts/install.sh`
- Student personality profile in `CLAUDE.md`: why, background, analogies, pace, cert goals
- `current_chapter` tracking — read by `/teach`, `/diagnose`, `/plan`, `/reflect`

---

## [1.5.0] — 2026-04-29

- Guide experience: `/start`, `/burnout`, `/imposter`, `/absence` slash commands
- Feynman + Bill Nye voice guidelines across all study commands
- Emotional reflection layer in `/reflect`
- Tiered absence response (3d / 2w / 30d / 60d) in `/absence`

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
- **`hooks/vault-backup.sh`** — rsync vault backup to USB drive with Slack notification

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
