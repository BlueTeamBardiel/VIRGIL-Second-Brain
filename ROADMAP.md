# VIRGIL Roadmap

This document tracks what's shipped, what's planned, and where VIRGIL is headed.

---

## Audit Status — April 2026
Four-source independent audit completed 2026-04-27.
Sources: Claude Sonnet 4.6 | Gemini 1.5 Pro | Claude Haiku 4.5 | Claude Opus 4.6
Full report: [docs/audit-2026-04-27.md](docs/audit-2026-04-27.md)

**Fixed this release:**
- Sanitization leak (private lab name in public scripts)
- Python dependency pinning
- url-ingest.sh URL validation + SSRF protection
- README rewritten — story-first, 2-minute QuickStart

**Top pending items from audit:**
- curl|bash → checksum-verified installer
- virgil status command
- Starter knowledge base (50-100 notes)
- Spaced repetition (highest ROI feature)
- Mobile capture bridge

---

## v1.0.0 — Current release

**Shipped April 2026.**

### Ingest Pipeline
- `rss-ingest.py` — 22 curated security/homelab feeds, daily digest via Claude Haiku
- `cve-ingest.py` — NVD v2 API, daily CVE ingest with CVSS scoring and ATT&CK mapping
- `pdf-ingest.sh` — PDF → Obsidian note; auto-chunked for large documents (textbooks, SPs)
- `nist-ingest.sh` — NIST SP/FIPS wrapper with exam-oriented framing
- `url-ingest.sh` — Fetch any URL → new note or patch existing note; MITRE ATT&CK auto-routing
- `triage-inbox.sh` — Weekly inbox triage: routes notes to merge/keep/archive/mitre
- `wikilink-ingest.sh` — Nightly `[[wikilink]]` injection into recently modified notes

### Automation
- `hooks/session-start.sh` — Creates daily log on session open
- `hooks/promote.sh` — Promotes daily log facts to memory; Slack notification on completion
- `hooks/weekly-rollup.sh` — Sunday digest from feeds, personal study, and CVE notes
- `hooks/auto-reflect.sh` — End-of-day auto-fill for unfilled log summaries
- `hooks/sync-public.sh` — Syncs private vault to public release repo (strips personal content)

### Skills (Claude Code slash commands)
- `/reflect` — End-of-session: summarizes log, marks completed tasks, updates notes
- `/week` — Weekly digest from daily logs
- `/cysa` — CySA+ interactive study session
- `/ccna` — CCNA study session from ingested notes
- `/research` — Structured research → Obsidian note
- `/challenge` — Red-team critique of a proposed decision
- `/lab` — Current lab status report
- `/focus` — Load context for a specific task

### Starter Knowledge Base
- CCNA Vol 1 + 2 notes (chunked from textbook PDFs)
- CySA+ domain notes with anchor links and callout blocks
- MITRE ATT&CK technique notes (url-ingest auto-routing)
- NIST SP notes (800-53, 800-61)
- Security and networking concept indexes

---

## v1.1.0 — Planned

### Spaced repetition quiz system
- `quiz-ingest.sh` — Generate 5-question terminal MCQ quiz from any topic in your notes
- Tracks per-topic scores in a simple JSON log
- `/quiz` Claude Code skill: review weak topics, suggest what to study next based on score history
- Integrates with `/reflect` — surfaces lowest-scoring topics in session summary

### Additional feed categories
- Threat intelligence feeds (CISA KEV, abuse.ch, OTX)
- Networking/infrastructure (network engineering subreddits, RIPE Labs, APNIC blog)
- Certification-specific (CompTIA community, study subreddits via RSS bridges)

### Mobile capture workflow
- `personal-ingest.sh` extensions: voice memo transcription stub, photo-to-note (OCR)
- Shortcuts/Tasker integration guide for capturing notes from mobile to vault via SSH

---

## v1.2.0 — Planned

### Multi-machine sync improvements
- `deploy.sh` — One-command VIRGIL deployment to a new machine (installs deps, clones vault, sets up cron, adds aliases)
- Conflict resolution guide for Obsidian Sync + git-based backup coexistence
- Per-machine config overlay: `settings.local.json` pattern extended for multi-host customization

### Obsidian plugin integration
- Dataview query templates for fleet status dashboards
- Templater templates for consistent note creation (host notes, study notes, lab reports)
- Community plugin recommendations with rationale (no required plugins — all optional)

---

## v2.0.0 — Future

### Guided setup wizard
- Interactive `setup.sh` that walks through: API key, vault path, cron schedule, feed selection, first ingest run
- Validates dependencies (pandoc, python3, curl) and suggests installs
- Generates a custom `GETTING-STARTED.md` from your answers

### Pre-built knowledge packs
Structured note collections ready to drop into your vault:

- **CySA+ Pack** — All five domains with practice questions, weak-area tracking, exam checklist
- **CCNA Pack** — OSI/TCP-IP, subnetting, routing protocols, switching, ACLs — exam-mapped
- **CEH Pack** — Recon, scanning, exploitation phases with tool references
- **Homelab Foundations Pack** — Linux hardening, Docker, firewall basics, monitoring stack

Knowledge packs are Markdown-only, no scripts required.

### Community feed registry
A curated, community-maintained list of high-quality RSS feeds organized by category. Submitted via pull request (see [CONTRIBUTING.md](CONTRIBUTING.md)).

---

## Premium track

Guided video courses and pre-configured knowledge packs with deeper coverage are in development.

**Join the mailing list** to get notified when premium content is available and to influence what gets built first.

> Mailing list coming soon — watch the repo or open an issue tagged `mailing-list` to register interest.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Feature requests and feed suggestions welcome via GitHub Issues.

---

## External Audit Findings — April 2026
See [docs/audit-2026-04-27.md](docs/audit-2026-04-27.md) for full report.

Key verdict from Claude Opus 4.6:
"The work itself is impressive. The Bash and Python are competent,
the architecture is coherent, and the security-domain focus is a
real differentiator. You've built something that actually works."

Positioning recommendation:
"VIRGIL is the second brain I built while transitioning from service
desk to security. It's automated, AI-powered, and free. Clone it,
adapt it, make it yours."
