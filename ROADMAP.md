# VIRGIL — Public Roadmap

*Built in public. Sequenced by what real users actually need.*

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

## What's shipped — v1.3.0

**Install it and use it today.**

- One-line curl installer — Linux, macOS, Windows via WSL2
- 5,000+ starter knowledge notes — Security+, CySA+, CCNA, MITRE ATT&CK,
  350+ CVEs with Feynman-style explanations
- Automated ingest pipelines — 22 threat intel feeds daily, NVD CVE feed
  daily, URL and PDF ingest
- Nightly memory distillation — session logs → permanent facts and lessons
- Local AI inference via Ollama — runs on your hardware, no API costs
- Three-tier fallback — local GPU → backup node → Anthropic API
- OpenWebUI frontend — browser and mobile access to your local VIRGIL
- Slack integration — approve/deny pipeline actions from your phone
- Pre-commit secret scanning — gitleaks on all repos
- Post-install guided wizard — walks you through first steps after install
- ✅ /secplus slash command — SY0-701 domain-mapped study session:
  - Pulls weak Security+ topics from quiz-scores.json
  - Feynman prompts per domain
  - Ships in .claude/commands/secplus.md
- ✅ /aplus slash command — Core 1/Core 2 domain-mapped study session:
  - Pulls weak A+ topics from quiz-scores.json
  - Feynman prompts per domain
  - Ships in .claude/commands/aplus.md

---

## What's next — v1.2.0

**Make VIRGIL actually think with your notes, not around them.**

### RAG — Retrieval-Augmented Generation
*This is the most important thing on this roadmap.*

Right now VIRGIL has 900+ notes but can't query them in conversation.
This fixes that.

- ChromaDB vector database running locally
- All vault notes embedded with a local model
- Every Feynman session, quiz, and explanation grounded in your vault
- Ask "what do my notes say about lateral movement" — get an answer from
  your actual notes, not the internet
- No manual setup per chat — it just works on every query

### The VIRGIL Session
*One command. One ritual. Every day.*

The core loop VIRGIL is built around:

virgil session

What it does:
- Pulls today's CVE and threat intel digest
- Surfaces your 3–5 weakest topics based on quiz history and session logs
- Generates Feynman-style prompts for each weak topic
- Writes results back into your vault
- Gives you one clear next step

If you do nothing else with VIRGIL, do this. Once a day. It compounds.

### Quiz System
- Generate a quiz on any topic from your own notes — not generic internet
  questions
- Tracks scores per topic
- Surfaces lowest-scoring topics in your daily session
- Feynman-style feedback: not just right/wrong, but "here's why you got
  that wrong and here's the note that explains it"

### Trust and Transparency
For a cybersecurity tool, trust is not optional.

- **Threat model** — what data is stored, what is transmitted, what never
  leaves your machine
- **Local-only mode** — disable all outbound calls, verify with a script
- **Hardening guide** — file permissions, Docker isolation, secrets
  handling, running VIRGIL air-gapped
- **SBOM** — software bill of materials for every release
- **Signed releases** — verify your install is what we shipped

---

## What's planned — v1.3.0

**Turn VIRGIL into a study partner with a memory.**

### Enrichment Pipeline
- Every note in your vault gets a Feynman-style plain-English explanation
  written by your local model
- Staged mode — writes to staging/ first, you approve before it patches
  the original
- Prevents semantic drift, enables rollback

### Interview Mode
- Generate Q&A from your own notes
- Simulate interviewer follow-ups
- Score your answers against your vault — not generic answers
- "You said X. Your notes say Y. Here's the gap."

### Job Gap Analysis
- Paste a job posting
- VIRGIL maps requirements to your vault
- Returns: what you know, what you're missing, what to study first

### Knowledge Health Dashboard
- Orphaned notes, stale notes, thin notes
- Topic clusters with no connections to other clusters
- Surfaces in Obsidian as a weekly digest note

---

## What's coming — v2.0.0

**The platform. For people who want to go deep.**

### Guided Setup Wizard
- Interactive installer that walks through every decision
- No more reading a README to figure out what order to do things
- First VIRGIL Session runs automatically at the end of setup

### Pre-Built Knowledge Packs
Structured note collections ready to drop into your vault.
Markdown-only — no scripts required.

- **CySA+ Pack** — All five domains, practice questions, weak-area
  tracking, exam checklist
- **Security+ Pack** — All six domains, Feynman explanations, exam traps
  flagged
- **CCNA Pack** — OSI/TCP-IP, subnetting, routing, switching, ACLs
- **Homelab Foundations Pack** — Linux hardening, Docker, firewall,
  monitoring, AD basics
- **Blue Team Pack** — SIEM, log analysis, incident response, detection
  engineering

### Community Feed Registry
- Community-maintained list of high-quality RSS feeds by category
- Every feed reviewed before merge

---

## The product track

*VIRGIL will always have a free open-source core.*

### Hosted tier — 2026
For people who want VIRGIL without the hardware.

- Managed inference — no GPU, no Ollama, no cron
- Pre-loaded cert packs included
- Vault sync across machines
- Your notes stay yours — exportable any time
- Pricing: join the mailing list below

### Enterprise — by request
For security teams, MSSPs, and organizations with a knowledge problem.

- Air-gapped deployment — nothing leaves your network
- Custom knowledge base with your runbooks, threat landscape, tools
- Compliance mapping — NIST, SOC2, ISO 27001, CMMC
- Human-in-the-loop approval gate for every AI action
- Full audit log of every AI decision
- SOC analyst copilot — answers from your documentation, not the internet
- New hire onboarding — from zero to productive in days, not months

*Inquiries: open an issue tagged `enterprise` on GitHub.*

---

## What we will not build

- A cloud product that owns your data
- A subscription to someone else's model running your notes
- Gamification, streaks, or engagement mechanics
- Anything that makes money by keeping you dependent

---

## User testing program

We're looking for 10–20 people to run VIRGIL daily for 14 days and tell
us what works, what doesn't, and what breaks.

**Who we want:**
- Studying for Sec+, CySA+, or CCNA
- Applying to SOC, IT, or security roles
- Frustrated with scattered notes and no system

**What you do:**
- Install VIRGIL
- Run `virgil session` once a day
- Answer 3 questions every 3 days: what did you use, what felt pointless,
  what broke

**What you get:**
- Direct input into what gets built next
- Early access to v1.2 features as they ship
- A knowledge base that's actually useful after 14 days

Open an issue tagged `user-testing` to join.

---

## Mailing list

Early access to hosted tier, knowledge packs, and enterprise beta.

Open an issue tagged `mailing-list` to register interest.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
Feature requests and feed suggestions welcome via GitHub Issues.

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

---

*Last updated: April 2026*
*Current version: v1.3.0 tagged | Repo visibility: public*
*Next milestone: v1.4.0 — naming conventions, README rewrite, secret scanning*
*Vault: 5,000+ notes | 3 repos | local GPU inference | one approval gate*
