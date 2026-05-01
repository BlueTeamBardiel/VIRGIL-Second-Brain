# VIRGIL Architecture

How VIRGIL works technically. Target audience: basic Linux knowledge, curious about the system before installing.

---

## Overview

```
┌─────────────────────────────────────────────────────┐
│                    Your Machine                      │
│                                                      │
│  ┌──────────┐    ┌──────────┐    ┌──────────────┐   │
│  │ Obsidian │    │  Claude  │    │    Ollama    │   │
│  │  Vault   │◄──►│   Code   │◄──►│  (local AI)  │   │
│  │ 5000+    │    │ (VIRGIL) │    │  gpt-oss:20b │   │
│  │  notes   │    └────┬─────┘    └──────────────┘   │
│  └──────────┘         │                              │
│                        │                              │
│  ┌────────────────────▼──────────────────────────┐  │
│  │              Automation Layer                  │  │
│  │  promote.sh  │  auto-reflect.sh  │  quiz.sh   │  │
│  │  rss-ingest  │  cve-ingest       │  review.sh │  │
│  └────────────────────────────────────────────────┘  │
│                        │                              │
│  ┌────────────────────▼──────────────────────────┐  │
│  │              Knowledge Base                    │  │
│  │  ChromaDB (RAG) │ memory/ │ daily-logs/        │  │
│  └────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
         │                              │
         ▼                              ▼
    Slack (approvals)            Telegram (capture)
```

---

## Components

### The Vault (Obsidian)

The vault is a directory of Markdown files — nothing proprietary. Obsidian is the viewer. If Obsidian disappeared tomorrow, the files are still plain text.

**Location:** `~/VIRGIL/` (default)

```
~/VIRGIL/
├── notes/
│   ├── inbox/          ← Drop zone. Triage routes to correct location nightly.
│   ├── mitre/          ← ATT&CK technique notes (url-ingest auto-routes here)
│   ├── cve/            ← Per-CVE notes from NVD API (~50/day)
│   ├── feeds/          ← Daily threat intel digest (auto-generated 6am)
│   ├── knowledge/      ← Study library from PDFs, URLs, NIST documents
│   │   ├── attacks/
│   │   ├── ccna/
│   │   ├── concepts/
│   │   └── nist/
│   ├── conversations/  ← Saved Claude.ai sessions
│   └── personal/       ← Your notes (gitignored)
│
├── daily-logs/         ← Session logs (gitignored)
├── weekly-summaries/   ← Weekly digests (gitignored)
│
├── hooks/              ← Automation scripts
│   ├── promote.sh
│   ├── auto-reflect.sh
│   ├── weekly-rollup.sh
│   └── vault-backup.sh
│
├── ingest/             ← Data ingestion scripts
│   ├── rss-ingest.py
│   ├── cve-ingest.py
│   ├── url-ingest.sh
│   ├── pdf-ingest.sh
│   └── wikilink-ingest.sh
│
├── memory/
│   ├── facts.md        ← Permanent facts about your setup
│   ├── lessons.md      ← Lessons learned (distilled from logs)
│   ├── decisions.md    ← Key decisions and why
│   └── questions.md    ← Open questions
│
└── skills/             ← Claude Code slash commands (.md files)
```

Notes use `[[wiki links]]` to connect related concepts. A CVE note links to the ATT&CK technique it exploits. That technique links to the NIST control that mitigates it. The graph view in Obsidian (`Ctrl+G`) shows the full connection map.

---

### Claude Code (The Brain)

Claude Code is the AI that runs inside your terminal in `~/VIRGIL`. When you open it, VIRGIL loads via `CLAUDE.md` — the project instruction file that tells Claude who it is and how to behave.

**Slash commands** are Markdown files in `.claude/commands/`:

| Command | What it does |
|---------|-------------|
| `/cysa` | CySA+ CS0-003 Feynman session, surfaces weak domains |
| `/secplus` | Security+ SY0-701 domain-mapped session |
| `/ccna` | CCNA routing/switching session |
| `/aplus` | A+ Core 1/Core 2 session |
| `/reflect` | End-of-session memory distillation |
| `/handoff` | Save context before closing |
| `/research` | Deep-dive on any topic |

**Hooks** (`.claude/settings.json`) run shell commands automatically:
- `session-start` — shows VIRGIL status dashboard before every session
- `pre-tool-use` — approval gate before any write to the vault

Sessions are context-aware because the vault, memory files, and quiz scores are always loaded. VIRGIL knows what topics you scored poorly on last week.

---

### Ollama (Local AI)

Ollama runs models on your own hardware. No data leaves your machine. No API costs.

**Default model stack:**

| Model | Role | VRAM |
|-------|------|------|
| gpt-oss:20b | Primary inference | ~12 GB |
| qwen2.5:14b | Fallback | ~9 GB |
| nomic-embed-text | Embeddings (RAG) | ~600 MB |

**Three-tier fallback chain:**

```
  Script / Hook
       │
       ▼
┌──────────────────────────────────────────┐
│  llm-client.sh / llm_client.py           │
│  (shared wrapper — all scripts call this) │
└───────────────┬──────────────────────────┘
                │
     ┌──────────▼──────────┐
     │  Tier 1: primary    │  ← Local GPU inference. Any 8GB+ VRAM GPU.
     │  Ollama :11434       │    CPU fallback works if no GPU available.
     │  gpt-oss:20b         │
     └──────────┬──────────┘
                │ FAIL / BUSY
     ┌──────────▼──────────┐
     │  Tier 2: backup     │  ← Optional second node (CPU or GPU).
     │  Ollama :11434       │    Same model set as primary.
     │  qwen2.5:14b         │
     └──────────┬──────────┘
                │ FAIL
     ┌──────────▼──────────┐
     │  Tier 3: Anthropic  │  ← Cloud fallback. Requires ANTHROPIC_API_KEY.
     │  Claude API          │    Disable with VIRGIL_BACKEND=ollama.
     │  claude-haiku-4-5    │
     └─────────────────────┘
```

**Important for reasoning models** (`gpt-oss`, `deepseek-r1`, `qwen-thinking`): these models use internal thinking tokens before generating output. Set `num_predict` to at least 3000 — without this, complex questions may return empty responses because the model exhausted its token budget while thinking.

---

### Automation Layer

Cron jobs handle the routine work so you don't have to.

| Time | Job | What it does |
|------|-----|-------------|
| 6:00am | `virgil-rss` | Pulls 22 threat intel feeds → `notes/feeds/` |
| 6:05am | `virgil-cve` | Pulls latest CVEs from NVD → `notes/cve/` |
| 11:30pm | `virgil-wikilink` | Scans recent notes, injects `[[wiki links]]` |
| 11:55pm | `auto-reflect.sh` | Fills empty daily log placeholders |
| 2:00am | `promote.sh` | Distills daily logs → permanent memory facts |
| 1:30am | `chroma-ingest.py` | Re-embeds new notes into ChromaDB (incremental) |
| Sunday 8am | `weekly-rollup.sh` | Synthesizes week's notes → weekly summary |

**Nightly pipeline flow:**

```
  11:30pm ─── wikilink-ingest.sh
               Scans recently modified notes.
               Injects [[wikilinks]] for known note titles.
               Code-block aware, skips self-links.
                    │
  11:55pm ─── auto-reflect.sh
               Finds unfilled stubs in today's daily log.
               Calls LLM to generate brief summaries from
               surrounding session metadata. Silent if nothing.
                    │
   2:00am ─── promote.sh
               Reads last 7 days of daily logs.
               LLM extracts: decisions, lessons, completed
               tasks, new facts.
               Appends to memory/facts.md and memory/lessons.md.
               Posts Slack summary.
                    │
   2:05am ─── vault-backup.sh
               rsync vault → USB drive.
               Silent if USB not mounted.
```

**Approval gate:** Any write action triggered outside of cron automation posts an interactive approval to Slack before executing. You approve or deny from your phone. No auto-timeout — it waits for you.

```
  VIRGIL Script (promote.sh, enrichment, etc.)
          │
          ▼
  ┌───────────────────────────┐
  │  virgil-approve.sh        │
  └──────────────┬────────────┘
                 │
                 ▼
  ┌───────────────────────────────────────┐
  │  virgil-slack-bot (:3001)             │
  │  Flask API + Slack SocketMode         │
  └──────────┬────────────────────────────┘
             │
             ▼
  ┌─────────────────────────────┐
  │  Slack #virgil channel      │
  │  [  Approve  ]  [  Deny  ] │
  └──────────┬──────────────────┘
             │
             ├─ approved → script continues
             └─ denied   → script exits 1
```

The bot connects outbound via WebSocket (Socket Mode) — no public HTTPS endpoint required.

---

### ChromaDB (RAG)

ChromaDB is a local vector database. Without it, VIRGIL knows what Claude was trained on. With it, VIRGIL knows what *you* know.

**How it works:**

1. `chroma-ingest.py` runs nightly, reads every note in your vault, converts them to vector embeddings using `nomic-embed-text`
2. `chroma-ingest.py` also serves the ChromaDB collection via the Pipelines service
3. OpenWebUI connects via the Pipelines service on port 9099
4. Every query to the VIRGIL RAG model automatically searches the vault for relevant chunks and injects them into the prompt

**What this means in practice:** Ask "what do my notes say about lateral movement?" and VIRGIL returns an answer grounded in your actual ATT&CK notes, your CVE write-ups, and your lab session logs — not generic internet knowledge.

ChromaDB is optional. The slash commands (`/cysa`, `/secplus`, etc.) work without it. RAG adds depth to open-ended questions.

---

### Memory System

| File | Scope | Written by | Cleared |
|------|-------|-----------|---------|
| `memory/facts.md` | Permanent | `promote.sh` | Never (append-only) |
| `memory/lessons.md` | Permanent | `promote.sh` | Never (append-only) |
| `memory/decisions.md` | Permanent | You / `promote.sh` | Never |
| `memory/questions.md` | Active | You / sessions | Manually |
| `daily-logs/YYYY-MM-DD.md` | Daily | `auto-reflect.sh` | After 90 days |
| `quiz-scores.json` | Rolling | Quiz commands | Never (cumulative) |

`promote.sh` reads the last 7 days of daily logs and asks the local model to extract facts, lessons, and open questions. Study sessions read `quiz-scores.json` to surface your weakest topics. The score file tracks every answer — right, wrong, and skipped — per topic.

---

### Ingest Pipelines

```
  External Sources                 VIRGIL Ingest                   Vault
  ────────────────                 ─────────────                   ─────

  22 RSS Feeds         ──► rss-ingest.py      ──► notes/feeds/YYYY-MM-DD.md
  (daily at 6am)            Claude synthesizes
                             Top Stories / CVEs /
                             Homelab / CySA+ / Hits

  NVD API v2           ──► cve-ingest.py      ──► notes/cve/CVE-YYYY-NNNNN.md
  (~50 CVEs/day)            CVSS scoring            per-CVE note with ATT&CK
                             ATT&CK mapping          technique links

  PDF files            ──► pdf-ingest.sh      ──► notes/knowledge/...
  (textbooks,               auto-chunked            (CCNA Vol 1+2, CySA+,
   NIST SPs)                                         Security+, NIST SPs)

  MITRE ATT&CK URLs    ──► url-ingest.sh      ──► notes/mitre/TNNNN-name.md
  (attack.mitre.org)        auto-routes             technique notes with
                             to notes/mitre/         [[wikilinks]]

  Any URL              ──► url-ingest.sh      ──► notes/knowledge/ or patch
                                                     existing note

  notes/inbox/         ──► triage-inbox.sh    ──► merge / keep / archive / mitre
  (nightly)                 LLM routing            routing with reasoning log

  Modified notes       ──► wikilink-ingest.sh ──► [[links]] injected in-place
  (nightly 11:30pm)         scans vault index       code-block-aware

  Claude.ai sessions   ──► conversation-ingest ──► notes/conversations/
  (bookmarklet)             HTTP port 5002

  Telegram messages    ──► telegram-bot        ──► notes/inbox/
  (mobile capture)          any message to bot
```

---

## Data flow — one complete cycle

What happens between a study session and the next morning:

```
You study → quiz result saved to quiz-scores.json
     │
     ▼
23:55 — auto-reflect.sh
     Checks daily-logs/YYYY-MM-DD.md
     Fills any empty session placeholders
     Adds topic tags based on what you studied
     │
     ▼
1:30am — chroma-ingest.py
     Detects new/modified notes since last run
     Embeds them with nomic-embed-text
     Updates ChromaDB index (incremental, not full rebuild)
     │
     ▼
2:00am — promote.sh
     Reads last 7 days of daily logs
     Asks local model: extract facts, lessons, open questions
     Appends to memory/facts.md and memory/lessons.md
     │
     ▼
6:00am — virgil-rss + virgil-cve
     Pulls 22 feeds + NVD CVEs
     Writes notes/feeds/YYYY-MM-DD.md
     Writes notes/cve/CVE-YYYY-NNNNN.md (new CVEs)
     │
     ▼
Next session start
     VIRGIL Status shows: vault note count, ChromaDB chunks
     virgil-review shows: topics due today from quiz-scores.json
     /cysa session surfaces: your 3 weakest CySA+ topics
```

Total time from your last keystroke to a fully updated vault: ~4 hours, automated, while you sleep.

---

## Security model

**Local by default.** All notes, all embeddings, all model inference stays on your machine. Nothing is transmitted unless you explicitly configure a remote service.

**Anthropic API** is the last tier in the fallback chain. Set `VIRGIL_BACKEND=ollama` to disable all Anthropic calls and run fully local.

**Slack and Telegram** are optional and off by default. If enabled, Telegram only receives what you explicitly send to it. Slack only receives approval prompts — it does not see note contents.

**Secret scanning.** `gitleaks` runs as a pre-commit hook on the vault repo. It blocks commits that contain API keys, tokens, or private identifiers. The `.gitignore` excludes `notes/personal/`, `memory/`, `daily-logs/`, and `*.env` files.

**Approval gate.** Every AI-initiated write to the vault (outside scheduled cron) requires explicit human approval before execution. No auto-timeout.

**Audit trail.** Every promote, ingest, and enrichment action is logged to `hooks/` log files with timestamps.

Community audits and contributions welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).

---

## Configuration reference

Key environment variables (set in `~/.env`):

| Variable | Default | Effect |
|----------|---------|--------|
| `VIRGIL_BACKEND` | `anthropic` | Set `ollama` to go fully local |
| `OLLAMA_MODEL` | `gpt-oss:20b` | Primary inference model |
| `OLLAMA_URL` | `http://localhost:11434` | Ollama endpoint |
| `ANTHROPIC_API_KEY` | (unset) | Cloud fallback API key |
| `VIRGIL_DIR` | `~/VIRGIL` | Vault root directory |
| `CHROMA_PORT` | `5000` | ChromaDB bridge port |
| `SLACK_BOT_TOKEN` | (unset) | Enables Slack approval gate |
| `TELEGRAM_BOT_TOKEN` | (unset) | Enables Telegram capture |

---

## Knowledge graph — ASCII approximation

The graph view in Obsidian after several months of ingestion. Each `o` is a note; lines are `[[wikilinks]]`.

```
                     o  o
                  o        o
                o    FEEDS   o           o
               o   (daily    o         o   o
                o  digests)  o       o  NIST  o
                  o        o           o   o
                     o  o                o
                          \             /
                    o      \           /      o
                  o   o     \         /     o   o
                o  CVE  o    \       /    o  CCNA  o
                  o   o       \     /      o   o
                    o          \   /         o
                                \ /
              o─────────o────────●────────o─────────o
             /        ┌──────────────────────┐       \
            o         │   CORE HUB CLUSTER   │        o
           /          │                      │         \
          o     o─────┤  ATT&CK Techniques   ├─────o    o
           \   /      │  MITRE Groups/Tools  │      \  /
            o─o       │  Network Concepts    │       o─o
                      │  Security Controls   │
              o─o     │  Host/Service Notes  │     o─o
             /   \    └──────────────────────┘    /   \
            o     o             |                o     o
             \   /              |                 \   /
              o─o         o─────o─────o            o─o
                        o   CySA+   o
                          o       o
                            o   o
                              o
                          (study notes,
                           domain guides,
                           exam objectives)
```

**Hub nodes** (highest link density): MITRE ATT&CK techniques, CCNA chapter notes, NIST control families.

**Satellite clusters** (sparse, specialized): CVE notes link inward to ATT&CK; NIST SPs link inward to controls; personal notes isolated by design.

**The center** is where value compounds: T1059 links to its CVEs, the CCNA note on VLANs links to the network segmentation control in NIST SP 800-53, which links to the CySA+ domain guide. This is not manual curation — it is the output of automated `[[wikilink]]` injection over time.

---

Full install guide: [`GETTING-STARTED.md`](GETTING-STARTED.md)
