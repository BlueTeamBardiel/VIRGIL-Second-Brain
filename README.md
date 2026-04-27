# VIRGIL — Automated Second Brain for Security Learners

> *You're studying for CySA+. You have 47 browser tabs open, three half-finished note apps, and a growing anxiety that you're learning nothing that sticks.*
>
> *VIRGIL is the fix.*

VIRGIL is the second brain I built while transitioning from service desk to security. It's automated, AI-powered, and free. Clone it, adapt it, make it yours.

---

## See it in 30 seconds

```bash
# Ingest any security article into your vault
virgil-url https://attack.mitre.org/techniques/T1059/
```

VIRGIL fetches the page, strips the noise, asks Claude to summarize it in your voice, links it to related notes, and saves it to your vault. That's it. That's the product.

---

## What it does

- **Daily threat intel** — pulls 22 RSS feeds at 6am, Claude synthesizes into a structured digest
- **CVE tracking** — NVD API v2 daily pull, structured notes with CVSS scores and ATT&CK mappings
- **PDF ingestion** — one command converts any SANS paper, NIST doc, or textbook into a linked note
- **URL capture** — `virgil-url <url>` saves any article, routes ATT&CK pages to `notes/mitre/` automatically
- **Inbox triage** — Claude routes your rough notes to the right place every Monday
- **Three-layer memory** — working (active tasks), episodic (history), semantic (permanent facts)
- **Session logging** — Claude Code hooks capture every session automatically
- **Weekly digest** — Sunday synthesis of the week's logs, feeds, and study sessions

---

## Quick Start

**Get an Anthropic API key.** Free tier works. [console.anthropic.com](https://console.anthropic.com)

**Install Obsidian.** Your notes live locally — not in any cloud you don't control. [obsidian.md](https://obsidian.md)

**Clone and run setup:**

```bash
git clone https://github.com/your-username/VIRGIL.git ~/VIRGIL
cd ~/VIRGIL
cp .env.example .env
# Edit .env — set ANTHROPIC_API_KEY at minimum

# Install dependencies
pip install -r requirements.txt
sudo apt install pandoc poppler-utils  # or: brew install pandoc poppler

# Create vault structure
mkdir -p ~/VIRGIL/notes/{inbox,mitre,cve,feeds,knowledge,personal}
mkdir -p ~/VIRGIL/{daily-logs,weekly-summaries}

# Make scripts executable
chmod +x hooks/*.sh ingest/*.sh scripts/*.sh
```

**Add to crontab** (`crontab -e`):

```cron
ANTHROPIC_API_KEY="your-key-here"

0 6 * * *    VIRGIL_DIR=$HOME/VIRGIL python3 $HOME/VIRGIL/ingest/rss-ingest.py
0 7 * * *    VIRGIL_DIR=$HOME/VIRGIL python3 $HOME/VIRGIL/ingest/cve-ingest.py --recent
0 8 * * 1    VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/ingest/triage-inbox.sh
30 23 * * *  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/ingest/wikilink-ingest.sh
55 23 * * *  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/auto-reflect.sh
0 1 * * 1-6  VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/promote.sh
0 1 * * 0    VIRGIL_DIR=$HOME/VIRGIL bash $HOME/VIRGIL/hooks/weekly-rollup.sh
```

Open your vault in Obsidian. Your first digest arrives at 6am.

---

## What you'll build

By running VIRGIL for 30 days, you'll have automated a real threat intel pipeline. That's not resume padding — it's actual experience:

```
• Automated security intelligence pipeline: 22 feeds via RSS/API, synthesized by Claude
  (Python, bash, REST APIs, cron scheduling)

• Three-layer knowledge management system: Obsidian + Claude for persistent context
  across sessions (working/episodic/semantic memory architecture)

• MITRE ATT&CK integration: automated technique ingestion and cross-linking

• CVE tracking pipeline: NVD v2 API, CVSS scores, ATT&CK technique mappings

• Chunked PDF processing: multi-pass summarization → synthesis for large documents

• Daily/weekly synthesis automation with Slack notifications
```

These are things you built, that work, that you can demo.

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
│  promote.sh       →  extracts tasks and decisions from logs │
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

## The 22 Default RSS Feeds

Curated for security learners and homelab builders. Add more in `ingest/rss-ingest.py`.

| Feed | Why |
|------|-----|
| The Hacker News | High-signal daily security news |
| Krebs on Security | Best investigative cybercrime journalism |
| Bleeping Computer | Fast ransomware/malware coverage |
| Schneier on Security | Security policy + cryptography |
| CISA Advisories | Official US advisories — these appear on exams |
| SANS ISC | Daily diary from working incident handlers |
| Google Project Zero | Cutting-edge vulnerability research |
| CISA Known Exploited | Vulns being actively exploited right now |
| r/netsec | Practitioner community — papers, tools, CTF writeups |
| r/blueteamsec | Blue team techniques, detection engineering |
| r/homelab | Lab builds, networking, virtualization |
| r/sysadmin | Real-world IT ops, tooling |
| Wired Security | Long-form security journalism |
| Ars Technica Security | Technical depth on security stories |
| GitHub Security Lab | Open source vulnerability research |
| Dark Reading | Enterprise security ops, SOC perspective |
| SecurityWeek | Vulnerability and threat research |
| Threatpost | Vulnerability and threat research |
| Malwarebytes Labs | Malware analysis, endpoint defense |
| Troy Hunt | Data breach research, HaveIBeenPwned |
| RTL-SDR Blog | Software-defined radio and RF security |
| Hackaday | Hardware hacking, embedded security |

---

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `ANTHROPIC_API_KEY` | Yes | — | Claude API key |
| `VIRGIL_DIR` | No | `$HOME/VIRGIL` | Vault root path |
| `SOURCE` | No | `$HOME/Documents/` | USB backup source |
| `DEST` | No | `/media/your-username/VIRGIL-Backup/` | USB backup destination |
| `SLACK_WEBHOOK_URL` | No | — | Slack notifications (all calls silent if unset) |

---

## Cost

VIRGIL uses Claude Haiku for all automated tasks. Typical monthly cost: **$2–8**.

| Task | Frequency | Cost |
|------|-----------|------|
| RSS digest | Daily | ~$0.01 |
| CVE ingest (10–20 CVEs) | Daily | ~$0.01 |
| Weekly rollup | Weekly | ~$0.02 |
| PDF ingest (book-length) | On demand | ~$0.05–0.15 |

Set a [usage limit](https://console.anthropic.com) if you want a hard cap.

---

## Directory Structure

```
VIRGIL/
├── .claude/commands/      # Claude Code slash commands
├── hooks/                 # Cron-driven automation
│   ├── session-start.sh   # Creates daily log on session open
│   ├── session-end.sh     # Appends entry on session close
│   ├── promote.sh         # Daily log → memory update
│   ├── weekly-rollup.sh   # Weekly digest synthesis
│   ├── auto-reflect.sh    # Fills unfilled session summaries
│   ├── promote-patch.py   # Updates memory-semantic.md
│   └── nebuchadnezzar.sh  # USB backup
├── ingest/
│   ├── rss-ingest.py      # 22 feeds → daily digest
│   ├── cve-ingest.py      # NVD API → CVE notes
│   ├── url-ingest.sh      # URL → inbox or existing note
│   ├── pdf-ingest.sh      # PDF → Obsidian note
│   ├── nist-ingest.sh     # NIST SP/FIPS → exam note
│   ├── triage-inbox.sh    # inbox/ → correct category
│   ├── wikilink-ingest.sh # Inject [[wikilinks]] nightly
│   └── personal-ingest.sh # Workout/study/nutrition logs
├── scripts/
│   ├── deploy-machine.sh  # Deploy VIRGIL to remote host
│   ├── sync-projects.sh   # Sync vault across machines
│   └── ad/                # Active Directory hardening scripts
├── notes/                 # YOUR VAULT — gitignored
├── daily-logs/            # Session logs — gitignored
├── weekly-summaries/      # Weekly digests — gitignored
├── memory-working.md      # Active tasks — gitignored
├── memory-episodic.md     # Session history — gitignored
├── memory-semantic.md     # Permanent facts — gitignored
├── .env                   # Your secrets — gitignored
├── .env.example           # Template
└── requirements.txt       # Pinned Python dependencies
```

---

## The Philosophy

VIRGIL is named for Virgil in Dante's Inferno — the guide through difficult territory.

IT is difficult territory. The field moves fast, the documentation is often terrible, and the gap between "certified" and "actually knows what they're doing" is enormous.

VIRGIL doesn't teach you. It builds a second brain that compounds what you already learn — connecting the CVE you read Tuesday to the ATT&CK technique you studied Thursday to the lab config you built Saturday. After six months you don't have 500 disconnected notes. You have a knowledge graph.

That's the whole idea.

---

## Audit & Security

A four-source independent audit was completed April 2026 (Claude Sonnet, Gemini 1.5 Pro, Claude Haiku, Claude Opus). Full report: [docs/audit-2026-04-27.md](docs/audit-2026-04-27.md)

Known issues addressed in this release: sanitization leaks, dependency pinning, URL validation with SSRF protection.

---

*If you're grinding certs, building labs, and trying to make it into security — this is for you.*
