# VIRGIL — System Architecture

---

## Vault Structure

```
~/VIRGIL/
├── notes/
│   ├── inbox/          ← Drop zone. Triage routes to correct location Monday 8am.
│   ├── mitre/          ← ATT&CK technique notes (url-ingest auto-routes here)
│   ├── cve/            ← Per-CVE notes from NVD API (~50/day)
│   ├── feeds/          ← Daily threat intel digest (auto-generated 6am)
│   ├── knowledge/      ← Study library from PDFs, URLs, NIST documents
│   │   ├── security/
│   │   ├── networking/
│   │   └── nist/
│   └── personal/       ← Optional: fitness, goals, study logs (gitignored)
│
├── daily-logs/         ← Session logs (gitignored — stays on your machine)
├── weekly-summaries/   ← Weekly digests (gitignored)
│
├── hooks/              ← Automation scripts run by cron and Claude Code hooks
│   ├── session-start.sh
│   ├── session-end.sh
│   ├── promote.sh
│   ├── auto-reflect.sh
│   ├── weekly-rollup.sh
│   └── vault-backup.sh
│
├── ingest/             ← Data ingestion scripts
│   ├── rss-ingest.py
│   ├── cve-ingest.py
│   ├── pdf-ingest.sh
│   ├── url-ingest.sh
│   ├── nist-ingest.sh
│   ├── triage-inbox.sh
│   └── wikilink-ingest.sh
│
├── scripts/            ← Setup, deployment, and maintenance
├── skills/             ← Claude Code slash commands (.md files)
├── memory-working.md   ← Active sprint (cleared weekly)
├── memory-episodic.md  ← Session history (append-only, gitignored)
├── memory-semantic.md  ← Permanent facts about your setup (gitignored)
└── memory.md           ← Promoted daily log facts (gitignored)
```

---

## Three-Tier LLM Inference Stack

VIRGIL routes inference requests through a fallback chain. Local-first: if GPU inference is available, no API call is made. Cloud is the last resort.

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
     │  Tier 1: primary    │  ← Primary local node. GPU inference recommended.
     │  Ollama :11434       │    Any AMD/NVIDIA GPU with 8GB+ VRAM
     │  gpt-oss:20b         │    CPU fallback works if no GPU available
     └──────────┬──────────┘
                │ FAIL / BUSY
     ┌──────────▼──────────┐
     │  Tier 2: backup     │  ← Optional second node. CPU or GPU.
     │  Ollama :11434       │    Same model set as primary
     │  qwen2.5:14b         │    Used when primary is busy or down
     └──────────┬──────────┘
                │ FAIL
     ┌──────────▼──────────┐
     │  Tier 3: Anthropic  │  ← Cloud fallback. Requires ANTHROPIC_API_KEY.
     │  Claude API          │    Used when local stack is unavailable.
     │  claude-haiku-4-5    │
     └─────────────────────┘
```

Recommended models (pull via `ollama pull <model>`):
- `gpt-oss:20b` (13GB) — best structured output and wikilink syntax; requires 16GB+ VRAM or 32GB+ RAM for CPU
- `qwen2.5:14b` (9GB) — solid balance of quality and speed; recommended for 8–12GB VRAM GPUs
- `llama3.1:8b` (4.9GB) — fast; suitable for low-stakes summaries on CPU-only setups

---

## Nightly Pipeline Flow

Every night while you sleep, VIRGIL processes the day's session logs and promotes knowledge into permanent memory.

```
  11:30pm ─── wikilink-ingest.sh
               Scans recently modified notes.
               Injects [[wikilinks]] for known note titles.
               Code-block aware, skips self-links.
                    │
  11:55pm ─── auto-reflect.sh
               Finds unfilled <!-- fill in manually --> stubs
               in today's daily log.
               Calls LLM to generate brief summaries from
               surrounding session metadata.
               Silent if nothing to fill.
                    │
   2:00am ─── promote.sh ◄────────────────────────────────────┐
               Reads daily log.                                │
               LLM extracts: decisions, lessons, completed     │
               tasks, new facts.                               │
               Diffs against memory-working.md task list.      │
               Marks completed tasks done.                     │
               Appends to memory.md.                           │
               Posts Slack summary.                            │
                    │                                          │
   2:05am ─── vault-backup.sh                         Sunday only:
               rsync vault → USB drive.                1:00am weekly-rollup.sh
               Silent if USB not mounted.              Synthesizes 7 daily logs +
               Slack notification on success.          feed digests + study notes.
                                                       Writes weekly-summaries/.
                                                       Posts Slack digest.
                                                               │
                                                       1:05am vault-backup.sh
```

---

## Slack Approval Gate Flow

Automation scripts that take consequential actions (promoting decisions, modifying memory) route through an interactive Slack approval gate before executing. No action is taken while you sleep that you didn't explicitly approve.

```
  VIRGIL Script (promote.sh, etc.)
          │
          │  source virgil-approve.sh
          │  request_approval "promote.sh" "Promoting 5 decisions..."
          ▼
  ┌───────────────────────────┐
  │  virgil-approve.sh        │  ← Bash wrapper sourced by shell scripts
  │  virgil_approve.py        │  ← Python equivalent for .py scripts
  └──────────────┬────────────┘
                 │  SSH → control-node:localhost:3001/slack/send
                 ▼
  ┌───────────────────────────────────────┐
  │  virgil-slack-bot (:3001)             │
  │  Flask API + slack_bolt SocketMode    │
  │  SQLite: ~/virgil-approvals.db        │
  └──────────┬────────────────────────────┘
             │  chat_postMessage
             ▼
  ┌─────────────────────────────┐
  │  Slack #virgil channel      │
  │                             │
  │  VIRGIL approval request    │
  │  Action: promote.sh         │
  │  Preview: [log content]     │
  │                             │
  │  [  Approve  ]  [  Deny  ] │
  └──────────┬──────────────────┘
             │  Button click → WebSocket → SocketModeHandler
             ▼
  Result: "approved" or "denied"
          │
          ├─ approved → script continues
          └─ denied   → script exits 1
```

The bot connects outbound via WebSocket (Socket Mode) — no public HTTPS endpoint required. It runs as a systemd service and survives reboots.

---

## Ingest Pipeline

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
   NIST SPs)                >80k chars              Security+, NIST SPs)

  MITRE ATT&CK URLs    ──► url-ingest.sh      ──► notes/mitre/TNNNN-name.md
  (attack.mitre.org)        auto-routes             technique notes with
                             to notes/mitre/         [[wikilinks]]

  Any URL              ──► url-ingest.sh      ──► notes/knowledge/ or patch
                             or notes/inbox/         existing note

  notes/inbox/         ──► triage-inbox.sh    ──► merge / keep / archive / mitre
  (Monday 8am)              Claude Haiku            routing with reasoning log

  Modified notes       ──► wikilink-ingest.sh ──► [[links]] injected in-place
  (nightly 11:30pm)         scans vault index       code-block-aware
```

---

## Obsidian Knowledge Graph — ASCII Approximation

The graph view in Obsidian after several months of ingestion looks roughly like this. Each `o` is a note; lines are `[[wikilinks]]`.

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

**Hub nodes** (highest link density): MITRE ATT&CK techniques, CCNA chapter notes, key host entries, NIST control families.

**Satellite clusters** (sparse, specialized): CVE notes (link inward to ATT&CK), NIST SPs (link inward to controls), personal notes (isolated by design).

**The center** is where the value compounds: ATT&CK technique T1059 links to its CVEs, the CCNA note on VLANs links to the network segmentation control in NIST SP 800-53, which links to the CySA+ domain guide for network architecture. This is not manual curation — it is the output of automated `[[wikilink]]` injection over time.
