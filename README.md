# VIRGIL — Your Study Operating System for Cybersecurity

> *You're studying for CySA+. You're building a homelab. You have 47 browser tabs open, three half-finished note apps, a Reddit saved folder you'll never read, and a growing anxiety that you're learning nothing that sticks.*
>
> *VIRGIL is the fix.*

---

## What Is VIRGIL?

VIRGIL is an **automated knowledge pipeline** built on top of [Obsidian](https://obsidian.md). It pulls from 22 security and homelab RSS feeds, ingests PDFs and URLs, tracks CVEs, and uses Claude AI to synthesize everything into structured, cross-linked notes — automatically, every day.

It's not a note-taking app. It's a **study operating system**.

Every morning you wake up to a fresh threat intel digest. Every Sunday you get a synthesized weekly summary of what you studied, what you deployed, and what you still need to tackle. Every time you read a SANS whitepaper or NIST doc, one command converts it into a clean, searchable Obsidian note with wiki links back to everything you already know.

**Built for:** Security students, homelab builders, cert chasers (CySA+, CCNA, CompTIA Security+), and working IT professionals who want their knowledge to compound instead of evaporate.

---

## The Problem VIRGIL Solves

Your learning resources are scattered across:

- Reddit (`r/netsec`, `r/blueteamsec`, `r/sysadmin`) — good signal, buried in noise
- CISA advisories and CVE databases — critical, but formatted for machines not humans
- SANS reading room — dense PDFs you download and never finish
- YouTube videos — you watched it, you forgot it
- ATT&CK framework — huge, intimidating, no clear path
- Your own lab notes — a graveyard of half-documented configs

None of it connects. None of it compounds. You read something Tuesday, it doesn't link to what you learned Thursday, and by Saturday you're starting over.

VIRGIL connects the dots. Every note links to related notes via `[[wiki links]]`. Your CVE notes link to ATT&CK techniques. Your lab configs link to the NIST controls they implement. Your study sessions link to the exam objectives they cover.

After six months, you don't have 500 disconnected notes. You have a knowledge graph that reflects everything you've learned — and Claude can query it.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    EXTERNAL SOURCES                         │
│  RSS Feeds (22)  │  URLs  │  PDFs  │  NVD CVE API  │  NIST │
└────────┬─────────┴────┬───┴───┬────┴───────┬────────┴───┬──┘
         │              │       │             │             │
         ▼              ▼       ▼             ▼             ▼
┌─────────────────────────────────────────────────────────────┐
│                    INGEST LAYER                             │
│  rss-ingest.py  url-ingest.sh  pdf-ingest.sh  cve-ingest.py│
│  nist-ingest.sh  personal-ingest.sh  wikilink-ingest.sh    │
└─────────────────────────┬───────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│                  OBSIDIAN VAULT                             │
│  notes/inbox/   notes/mitre/   notes/cve/                  │
│  notes/feeds/   notes/knowledge/   notes/personal/          │
└──────────┬──────────────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────────────────────────┐
│               CLAUDE AI SYNTHESIS LAYER                     │
│  triage-inbox.sh  →  routes notes to correct category       │
│  promote.sh       →  extracts completed tasks from logs     │
│  promote-patch.py →  updates permanent knowledge base       │
│  weekly-rollup.sh →  synthesizes 7 days into weekly digest  │
│  auto-reflect.sh  →  fills session summaries automatically  │
└──────────┬──────────────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────────────────────────┐
│                 THREE-LAYER MEMORY SYSTEM                   │
│  memory-working.md   ← active tasks, cleared weekly         │
│  memory-episodic.md  ← session history, completed work      │
│  memory-semantic.md  ← permanent facts, decisions, lessons  │
└─────────────────────────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────────────────────────┐
│              CLAUDE CODE SLASH COMMANDS                     │
│  /reflect  /week  /day  /lab  /cysa  /ccna  /challenge      │
│  /deploy   /focus  /research  /job  /sync  /task            │
└─────────────────────────────────────────────────────────────┘
```

---

## Features

### Automated Threat Intel
Every morning at 6am, VIRGIL pulls from 22 RSS feeds and asks Claude to synthesize them into a structured daily digest covering top stories, active exploits, homelab-relevant tooling, and exam-relevant blue team concepts. Saved to `notes/feeds/YYYY-MM-DD.md`.

### CVE Tracking
Daily NVD API pulls at 7am. Recent high-severity CVEs become individual notes with CVSS scores, affected software, mitigation steps, and ATT&CK technique mappings. Query by keyword anytime: `virgil-cve --keyword apache`.

### PDF Ingestion
One command converts any PDF into a structured Obsidian note. Handles books (1M+ chars) by chunking into segments, summarizing each, then synthesizing a final note. `virgil-pdf ~/Downloads/SANS-401.pdf security`.

### URL Capture
`virgil-url https://attack.mitre.org/techniques/T1059/` — VIRGIL fetches the page, strips navigation and boilerplate, and either creates a new note or patches relevant content into an existing one. ATT&CK URLs route to `notes/mitre/` automatically.

### Inbox Triage
Drop anything into `notes/inbox/`. Every Monday at 8am, Claude reviews each note and decides: merge into an existing note, keep for further work, archive as stale, or route to `notes/mitre/` if it's an ATT&CK technique.

### Wikilink Injection
Nightly scan of recently modified notes. Any mention of a known title gets converted to a `[[wiki link]]` automatically, keeping your knowledge graph connected without manual linking.

### Weekly Digests
Every Sunday morning, Claude reads your last 7 daily logs, your feed digests, and your study notes, and synthesizes a structured weekly summary: what you accomplished, decisions made, lessons learned, still-in-flight items, and next week's priorities.

### Session Logging
Claude Code hooks automatically create a timestamped daily log when you start a session and append a structured entry when you end one. `/reflect` fills in the summary using Claude.

### Three-Layer Memory
- **Working memory** (`memory-working.md`): Active tasks, current sprint. Cleared weekly.
- **Episodic memory** (`memory-episodic.md`): Dated history, completed work. Append-only.
- **Semantic memory** (`memory-semantic.md`): Permanent facts — your lab, certs, key decisions. Updated with supersede syntax when facts change.

### Active Directory Hardening Scripts
A full suite of PowerShell scripts for hardening an AD lab: GPO audit policy, PowerShell logging, SMB signing enforcement, LAPS, AppLocker baseline, DNS records, security groups, and service accounts. Reference material for blue team exam prep and real-world AD administration.

### Claude Code Slash Commands
`/reflect`, `/week`, `/day`, `/lab`, `/deploy`, `/cysa`, `/ccna`, `/challenge`, `/focus`, `/research`, `/job`, `/sync`, `/task` — a full set of context-aware commands that query your vault and memory layers to give Claude the right context for any task.

---

## What You'll Learn by Building This

If you set up VIRGIL and actually use it, here's what you can put on your resume:

```
• Built automated security intelligence pipeline ingesting 22 threat feeds via
  RSS/API, synthesized daily by Claude AI (Python, bash, REST APIs, cron)

• Designed and implemented a three-layer knowledge management system using
  Obsidian + Claude for persistent context across study sessions

• Integrated MITRE ATT&CK framework into personal knowledge base with
  automated technique ingestion and cross-linking via wiki graph

• Deployed CVE tracking pipeline consuming NVD v2 API, generating structured
  notes with CVSS scores, affected software, and ATT&CK technique mappings

• Implemented chunked PDF processing pipeline handling 1M+ char documents
  via Claude API (multi-pass summarization → synthesis)

• Automated AD lab hardening using 11 PowerShell GPO scripts: audit policy,
  PowerShell logging, SMB signing, LAPS, AppLocker (Windows Server 2022)

• Built daily/weekly knowledge synthesis automation with Slack notifications
  using Claude Haiku API (cost-optimized model selection)
```

These aren't just talking points. They're things you actually built, that actually work, that you can demo.

---

## The 22 Default RSS Feeds

VIRGIL ships with feeds curated for security students and homelab builders. You can add more in `ingest/rss-ingest.py`.

### Threat Intel & News
| Feed | Why It Matters |
|------|---------------|
| **The Hacker News** | High-signal daily security news, strong CVE coverage |
| **Krebs on Security** | Brian Krebs — best investigative cybercrime journalism |
| **Bleeping Computer** | Fast ransomware/malware coverage, solid technical detail |
| **Schneier on Security** | Security policy + cryptography from a legend in the field |
| **Dark Reading** | Enterprise security ops, good SOC perspective |
| **SecurityWeek** | Vendor/product security news, ICS/OT coverage |
| **Threatpost** | Vulnerability and threat research |
| **Malwarebytes Labs** | Malware analysis, endpoint defense, consumer threats |
| **Troy Hunt** | Data breach research, HaveIBeenPwned author |
| **InfoSecurity Magazine** | Broad industry coverage, good for exam awareness |
| **PortSwigger Daily Swig** | Web security research from the Burp Suite team |

### Vulnerability & Advisories
| Feed | Why It Matters |
|------|---------------|
| **CISA Advisories** | Official US government advisories — these are on the exam |
| **SANS ISC** | Daily diary from actual incident handlers |
| **Google Project Zero** | Cutting-edge vuln research — understand attacker mindset |
| **CISA Known Exploited** | KEV catalog — vulns being actively exploited right now |

### Tech & Analysis
| Feed | Why It Matters |
|------|---------------|
| **Wired Security** | Long-form security journalism, great for context |
| **Ars Technica Security** | Technical depth on security stories |
| **GitHub Security Lab** | Open source vulnerability research and tooling |

### Community
| Feed | Why It Matters |
|------|---------------|
| **r/netsec** | Practitioner community — papers, tools, CTF writeups |
| **r/homelab** | Lab builds, networking configs, virtualization |
| **r/sysadmin** | Real-world IT ops, war stories, tooling |
| **r/blueteamsec** | Blue team techniques, detection engineering |

---

## Quick Start

### Prerequisites

- Linux (Ubuntu/Debian) or macOS
- Python 3.9+
- `curl`, `pandoc`, `git`
- [Obsidian](https://obsidian.md) (free)
- [Claude Code CLI](https://claude.ai/code) (optional — for slash commands and hooks)
- Anthropic API key ([console.anthropic.com](https://console.anthropic.com)) — ~$1–5/month for typical use

```bash
# Ubuntu/Debian
sudo apt install python3 python3-pip curl pandoc git poppler-utils

# macOS
brew install python curl pandoc git poppler

# Python deps
pip3 install feedparser requests
```

### Install

```bash
git clone https://github.com/your-username/VIRGIL.git ~/VIRGIL
cd ~/VIRGIL
bash scripts/setup.sh
```

`setup.sh` handles everything: prompts for your API key, creates the vault structure, adds crontab entries, sets up aliases, and runs a connectivity test.

### Manual Setup (if you prefer)

```bash
# 1. Configure
cp .env.example .env
# Edit .env — set ANTHROPIC_API_KEY at minimum

# 2. Create vault structure
export VIRGIL_DIR="$HOME/Documents/VIRGIL"  # or wherever you want it
mkdir -p "$VIRGIL_DIR"/{notes/{inbox,archive,feeds,mitre,cve,knowledge/{security,networking,nist},personal/{workouts,study,nutrition}},daily-logs,weekly-summaries}

# 3. Make scripts executable
chmod +x hooks/*.sh ingest/*.sh ingest/*.py scripts/*.sh

# 4. Add to crontab (see schedule below)
crontab -e
```

### First Test

```bash
# Test the ingest pipeline with a real ATT&CK technique
virgil-url https://attack.mitre.org/techniques/T1059/
# → Creates notes/mitre/t1059-command-and-scripting-interpreter.md

# Pull today's security news
virgil-rss
# → Creates notes/feeds/YYYY-MM-DD.md

# Ingest a PDF
virgil-pdf ~/Downloads/some-security-paper.pdf security
# → Creates notes/knowledge/security/<slug>.md
```

---

## Crontab Schedule

Add your API key and webhook to crontab so all scheduled scripts can access them:

```cron
ANTHROPIC_API_KEY="your-key-here"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/..."

# RSS threat intel digest — every morning at 6am
0 6 * * *    VIRGIL_DIR=$HOME/VIRGIL python3 $HOME/VIRGIL/ingest/rss-ingest.py

# CVE ingest from NVD — 7am daily
0 7 * * *    VIRGIL_DIR=$HOME/VIRGIL python3 $HOME/VIRGIL/ingest/cve-ingest.py --recent

# Inbox triage — Monday 8am (Claude reviews and routes inbox notes)
0 8 * * 1    VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/ingest/triage-inbox.sh

# Wikilink injection — 11:30pm (link recently modified notes)
30 23 * * *  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/ingest/wikilink-ingest.sh

# Auto-fill session summary — 11:55pm
55 23 * * *  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/auto-reflect.sh

# Daily log promotion — 1am Mon–Sat (extract tasks, update memory)
0 1 * * 1-6  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/promote.sh

# Weekly digest — Sunday 1am (synthesize the week)
0 1 * * 0    VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/weekly-rollup.sh
```

| Script | Schedule | What It Does |
|--------|----------|-------------|
| `rss-ingest.py` | 6am daily | Pulls 22 feeds, Claude synthesizes daily digest |
| `cve-ingest.py` | 7am daily | NVD API pull, writes CVE notes |
| `triage-inbox.sh` | Mon 8am | Routes inbox notes to correct category |
| `wikilink-ingest.sh` | 11:30pm | Injects `[[wikilinks]]` into recent notes |
| `auto-reflect.sh` | 11:55pm | Fills unfilled session summaries |
| `promote.sh` | 1am Mon–Sat | Promotes daily log, updates task lists |
| `weekly-rollup.sh` | Sun 1am | Weekly synthesis digest |

---

## Directory Structure

```
VIRGIL/
├── .claude/
│   └── commands/          # Claude Code slash commands (/reflect, /week, /cysa, etc.)
├── hooks/
│   ├── session-start.sh   # Claude Code: creates daily log on session open
│   ├── session-end.sh     # Claude Code: appends entry on session close
│   ├── promote.sh         # Cron: daily log → memory update
│   ├── weekly-rollup.sh   # Cron: weekly digest synthesis
│   ├── auto-reflect.sh    # Cron: fills unfilled session summaries
│   ├── promote-patch.py   # Updates memory-semantic.md with new facts
│   └── vault-backup.sh  # USB backup of entire vault
├── ingest/
│   ├── pdf-ingest.sh      # PDF → Obsidian note (with chunking for large docs)
│   ├── nist-ingest.sh     # NIST SP/FIPS → exam-optimized note
│   ├── url-ingest.sh      # URL → inbox note or patch existing note
│   ├── rss-ingest.py      # 22 RSS feeds → daily digest
│   ├── cve-ingest.py      # NVD API → CVE notes
│   ├── triage-inbox.sh    # inbox/ → route to correct category
│   ├── wikilink-ingest.sh # inject [[wikilinks]] into modified notes
│   ├── orphan-detect.sh   # find notes with no connections
│   └── personal-ingest.sh # workout/meal/study log entries
├── scripts/
│   ├── setup.sh           # First-time setup wizard
│   ├── deploy-machine.sh  # Deploy VIRGIL to a remote host via SSH
│   ├── sync-projects.sh   # Sync vault across machines
│   └── ad/                # Active Directory hardening scripts (PowerShell)
├── skills/                # Claude skill definitions
├── notes/                 # YOUR VAULT — gitignored, stays local
│   ├── inbox/             # Drop zone — triage every Monday
│   ├── mitre/             # ATT&CK technique notes
│   ├── cve/               # CVE notes from NVD
│   ├── feeds/             # Daily RSS digests
│   ├── knowledge/         # Ingested PDFs and URLs
│   │   ├── security/
│   │   ├── networking/
│   │   └── nist/
│   └── personal/          # Fitness, nutrition, study logs
├── daily-logs/            # Session logs — gitignored
├── weekly-summaries/      # Weekly digests — gitignored
├── memory-working.md      # Active tasks — gitignored
├── memory-episodic.md     # Session history — gitignored
├── memory-semantic.md     # Permanent facts — gitignored
├── .env                   # Your secrets — gitignored
├── .env.example           # Template
├── CLAUDE.md              # Claude Code config
└── GETTING-STARTED.md     # First-time user guide
```

---

## Extending VIRGIL

### Add an RSS Feed
Edit `ingest/rss-ingest.py` and add a tuple to the `FEEDS` list:
```python
("Your Feed Name", "https://example.com/feed.rss"),
```

### Add an Ingest Script
Copy an existing script as a template. Follow the pattern:
1. Set `VIRGIL_DIR` with env-var fallback
2. Self-source `ANTHROPIC_API_KEY` from crontab
3. Write output to the appropriate `notes/` subdirectory
4. Log to `ingest/<script-name>.log`
5. Optionally post to `$SLACK_WEBHOOK_URL`

### Customize Memory Layers
The three memory files are plain Markdown. Customize what gets tracked:
- `memory-working.md`: Add your own task categories with emoji headers
- `memory-semantic.md`: Add sections for your fleet, certs, job search, anything permanent
- Supersede outdated facts: `~~old fact~~ superseded on YYYY-MM-DD → new fact`

### Add a Slash Command
Create `.claude/commands/your-command.md`. The filename becomes the `/your-command` trigger. See existing commands for structure — they read vault state, query memory, and give Claude the right framing for the task.

### Use VIRGIL Without Claude Code
All ingest scripts work standalone. You don't need Claude Code for RSS/CVE/PDF ingestion, cron automation, or the web hooks. Claude Code is only needed for the slash commands and session hooks.

---

## Cost

VIRGIL uses **Claude Haiku** (the cheapest Claude model) for all automated tasks. At typical usage:

| Task | Frequency | Approximate cost |
|------|-----------|-----------------|
| RSS digest | Daily | ~$0.01 |
| CVE ingest (10–20 CVEs) | Daily | ~$0.01 |
| Weekly rollup | Weekly | ~$0.02 |
| PDF ingest (short) | On demand | ~$0.01 |
| PDF ingest (book-length) | On demand | ~$0.05–0.15 |
| Inbox triage (10 notes) | Weekly | ~$0.02 |

**Estimated monthly total: $2–8** depending on how many PDFs you ingest. Set a [usage limit](https://console.anthropic.com) in the Anthropic console if you want a hard cap.

---

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `ANTHROPIC_API_KEY` | Yes | — | Claude API key — get at [console.anthropic.com](https://console.anthropic.com) |
| `VIRGIL_DIR` | No | `$HOME/VIRGIL` | Path to your vault root |
| `SLACK_WEBHOOK_URL` | No | — | Incoming webhook for notifications. All Slack calls fail silently if unset. |

---

## Requirements

- bash 4+ / Python 3.9+
- `curl`, `pandoc`, `poppler-utils` (for `pdftotext`)
- `pip3 install feedparser requests`
- Anthropic API key

---

---

*Built by a working IT professional for the next generation of security practitioners.*
*If you're grinding certs, building labs, and trying to make it into security — this is for you.*
