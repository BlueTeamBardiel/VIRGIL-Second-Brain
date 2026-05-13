# Changelog

All notable changes to VIRGIL are documented here.

Format: [Semantic Versioning](https://semver.org/) — `MAJOR.MINOR.PATCH`

---

## [2.0.0] — 2026-05-12

The scope-defined release. v2.0.0 narrows VIRGIL's public surface to three categories — cert notes, CVE notes, RSS digests — and ships the gate that enforces that scope. Anything previously promised in v1.x that fell outside the scope rule has been cut or moved to private maintainer infrastructure.

### New

- **`soul.md`** — first-class behavioral spec. Dante framing, the Feynman Doctrine, four voice registers (normal / teaching / urgent / uncertain), forbidden outputs. Read this before forking; it shapes everything.
- **`ARCHITECTURE.md`** — full rewrite. 12 sections covering the scope rule, vault layout, brain, two-backend inference, pipelines, security model, configuration, fork-and-adapt paths, and the day-zero knowledge graph.
- **Five cert tracks shipped** — A+ (136 notes), CCNA (154), CySA+ (263), Net+ (66), Sec+ (120). 739 notes total, all Feynman-style.
- **239 audited CVE notes** in `notes/knowledge/cve/` — curated starter corpus with attacker scenario and remediation per note. See `notes/knowledge/cve/README.md` for the committed-vs-runtime split.
- **`scripts/promote-to-public.py`** — the five-stage promotion gate that produces this repo. Documented as a reference implementation for forkers building their own public/private content splits.
- **`user.md` profile** — `install.sh` creates an empty template; `/start` and `/diagnose` populate it via guided interview on first run. Carries name, background, certs in progress, and target roles across sessions.
- **Configurable `/task` categories** — `/task` reads its category list from `CLAUDE.md` instead of a hardcoded list. Edit the list to fit your study and work.
- **Two-backend support** — `VIRGIL_BACKEND` switches between Ollama (local) and Anthropic API. No fallback chain; pick one.
- **Walls commands** — `/start`, `/imposter`, `/burnout`, `/absence` for re-entry, returning after time away, and the cognitive walls students hit.
- **`scripts/homelab/ad-hardening/`** — 11 PowerShell scripts for hardening a Windows Server lab, mapped to Security+ and CySA+ exam objectives.
- **`hooks/quiz.sh` ChromaDB→grep fallback** — quiz works without RAG infrastructure; the grep path is the default for v2.0.0.

### Changed

- **Memory model** — three layers explicit: `memory-working.md` (cleared weekly), `memory-episodic.md` (append-only history), `memory-semantic.md` (durable facts). Replaces the earlier `memory/facts.md`, `memory/lessons.md`, `memory/decisions.md`, `memory/questions.md` structure.
- **Scope rule enforced** — content must be cert, CVE, or RSS. The gate's scope check blocks anything else from publishing.
- **`/diagnose` and `/start` write `user.md`** — previously wrote profile fields to `CLAUDE.md`. `user.md` is now the canonical source of user context.
- **`CLAUDE.md`** — fleet references removed; `user.md` pointer added; task-categories section added.
- **`install.sh` knowledge-base copy** — copies from `notes/` instead of the deleted `starter-notes/`.
- **`Dockerfile`** — copies `notes/`, `soul.md`, and `CLAUDE.md` into the container; adds `VIRGIL_BACKEND` and Ollama env vars; drops `starter-notes/` and `SLACK_WEBHOOK_URL`.
- **`.env.example`** — rewritten around `VIRGIL_BACKEND` as the primary switch; backend-specific sections clearly delimited.
- **`README.md`, `GETTING-STARTED.md`, `CONTRIBUTING.md`, `FEEDS.md`, `ingest/README.md`, `scripts/README.md`** — all rewritten for v2.0.0 reality: scope rule called out, current paths and counts, no marketing register, soul.md voice.

### Removed

- **Slack approval bot** — the universal write-gate from v1.x. Claude Code's built-in permission prompts are the gate in v2.0.0.
- **Telegram capture bot** and **conversation-ingest pipeline** — out of scope per the scope rule.
- **ChromaDB / RAG / OpenWebUI Pipelines stack** — not shipping in v2.0.0. The vault is browsed via Obsidian and queried via Claude Code's file tools.
- **MITRE ATT&CK library, NIST control library, attacks/, concepts/, threat-actors/, tools/, malware/, DFIR/, OSINT/, pentest/, ransomware/, blue-team/, blueteam/, ctf/, social-engineering/, splunk/, tryhackme/, virtualization/, web-security/, windows/, wireless/, automation/, cloud/, cryptography/, homelab/, identity/, imaging/, incident-response/, job-search/, linux/, networking/, network-security/, powershell/, sdr/, security/** — 33 out-of-scope `notes/knowledge/` subdirectories cut (-4,022 files). What remains is cert content and the curated CVE corpus.
- **`starter-notes/`** — replaced by `notes/knowledge/` as the canonical content source.
- **`/lab` and `/deploy` slash commands** — out of scope (homelab fleet orchestration).
- **`scripts/deploy-machine.sh`, `scripts/sync-projects.sh`, `scripts/deploy-control-node.sh`** — fleet/SSH tooling for the maintainer's private system.
- **`COSTS.md`, `CRONTAB.md`, `OBSIDIAN-BRAIN.md`** — private operational tracking and the maintainer's mature-vault snapshot. The public cron schedule is now in `ARCHITECTURE.md` §10.
- **`ingest/conversation-ingest.py/.service`, `ingest/telegram-bot.py/.service`, `ingest/nist-ingest.sh`, `ingest/personal-ingest.sh`** — out-of-scope ingest scripts.
- **Three-tier LLM fallback** — collapsed to two backends, pick one. No backup-node tier (that was a private fleet artifact).
- **Pre-built mature graph** — the aspirational ATT&CK/NIST hub graph from v1.x docs is replaced by an honest v2.0.0 day-zero graph in `ARCHITECTURE.md` §12.

### Fixed

- `cve-ingest.py` — `re.sub` bug that incorrectly stripped characters from CVE descriptions in certain edge cases.
- `cve-ingest.py` `ANALYSIS_PROMPT` — leakage of a maintainer hostname in the embedded prompt string.
- `scripts/ad/` → `scripts/homelab/ad-hardening/` — renamed for clarity; the PowerShell scripts are study-adjacent labs, not maintainer fleet tooling.
- Multiple security scrubs across cert and CVE notes — fleet hostnames, lab IPs, personal identifiers, and filesystem paths removed per the leakage scan.

### Migration notes (v1.x → v2.0.0)

This is a breaking release for users who depended on cut features. If you were using v1.x:

- **Slack bot**: gone. Approve writes via Claude Code's normal permission prompts.
- **ChromaDB**: gone. Use Obsidian search and Claude Code's file tools; quiz.sh falls back to grep.
- **MITRE/NIST notes**: gone from the public repo. If you need them, restore from your private vault or build them in a fork.
- **`memory/*.md`**: replaced by `memory-working.md`, `memory-episodic.md`, `memory-semantic.md` at the vault root.
- **Inference backend**: must set `VIRGIL_BACKEND` explicitly. No more implicit fallback.

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
- `hooks/llm_client.py`: private hostnames removed; env-var-driven primary/secondary Ollama
- `hooks/llm_client.py`: crontab API key extraction replaced with simple env lookup
- `ingest/rss-ingest.py`: hardcoded personal name replaced with CLAUDE.md dynamic profile; 429 retry added
- `hooks/cert-roadmap.py`: Network+ added to CERT_PATH; cert path updated
- `hooks/quiz.sh`: ChromaDB crash replaced with graceful grep fallback
- `hooks/session-start.sh`: first-session `/start` hint added
- `ingest/cert-ingest.sh`: `echo` replaced with `printf` for safe temp file write
- `scripts/install.sh`: personal vault dirs removed; note count corrected to 1,500+
- `scripts/ad/`: private hostnames replaced with generic hostnames in examples
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
