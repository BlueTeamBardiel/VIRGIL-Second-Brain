# VIRGIL — AI-Powered Second Brain for Cybersecurity Learners

> Your personal knowledge base that studies with you, not for you.
> Local. Private. Free.

![Version](https://img.shields.io/badge/version-v1.3.0-blue) ![Platform Linux](https://img.shields.io/badge/platform-Linux-informational) ![Platform macOS](https://img.shields.io/badge/platform-macOS-informational) ![Platform Windows WSL2](https://img.shields.io/badge/platform-Windows%20WSL2-informational) ![License MIT](https://img.shields.io/badge/license-MIT-green)

## What it does

VIRGIL ingests threat intel daily, lets you quiz yourself on weak topics, tracks what you know and what you don't, and compounds knowledge automatically over time. Runs on your own hardware via [Ollama](https://ollama.com). No subscription. No data leaving your machine.

## What you get on day one

- **5,000+ knowledge notes** — Security+, CySA+, CCNA, MITRE ATT&CK, 350+ CVEs with Feynman explanations
- **Daily threat intel** — 22 RSS feeds + NVD CVE pipeline, automated every morning
- **Study commands** — `/cysa`, `/ccna`, `/secplus`, `/aplus` — domain-mapped Feynman sessions
- **Spaced repetition** — `virgil-review` surfaces what's due based on your quiz scores
- **Conversation capture** — save any Claude.ai session to your vault in one click

## Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/BlueTeamBardiel/VIRGIL-Second-Brain/main/scripts/install.sh)
```

**Requires:** Linux / macOS / WSL2 · [Ollama](https://ollama.com) · [Obsidian](https://obsidian.md) · [Claude Code](https://claude.ai/code)

### Which setup is right for you?

| Situation | Recommended path |
|-----------|-----------------|
| Have an API key | Set `ANTHROPIC_API_KEY` in `.env` — fastest setup |
| GPU with 8 GB+ VRAM | Install Ollama, pull `qwen2.5:14b` |
| Laptop / no GPU | Use API key — Ollama will be too slow |
| Just want to try it | Use API key, free tier works fine |

No API key required. Twenty-minute setup.

## Quick start

After install:

1. Open Obsidian → point it at `~/VIRGIL/notes`
2. Run `claude` in `~/VIRGIL` — VIRGIL introduces itself
3. Type `/cysa` or `/secplus` to start a study session
4. Type `/virgil-quiz "topic"` to quiz yourself on any topic
5. Type `/handoff` when ending a session to save context

## What it looks like

### Study session (type `/cysa` in Claude Code)
```
VIRGIL Session — 2026-04-29
Weakest topics: Kerberoasting, Lateral Movement, SIEM Architecture

Topic 1: Kerberoasting
─────────────────────────────────────────────────────
Analogy: Imagine a bouncer who hands out wristbands (tickets)
to prove you're allowed in. Kerberoasting is when an attacker
steals those wristband templates and forges their own offline,
without ever needing to talk to the bouncer again.

In a real attack: attacker requests a Kerberos service ticket
for any SPN, extracts the ticket, and cracks it offline with
hashcat to recover the service account password.

Q: What makes a service account vulnerable to Kerberoasting?
   A) It uses NTLM authentication
   B) Its password hash is embedded in the Kerberos ticket
   C) It has local admin rights
   D) It uses LDAP for authentication

Your answer: _
```

### Vault health check (run `virgil-review`)
```
══════════════════════════════════════════
  VIRGIL Review Session — 2026-04-29
══════════════════════════════════════════
  Due today (3 topics):
  1. kerberoasting      last: 2/5  overdue: 8 days
  2. lateral movement   last: 3/5  overdue: 3 days
  3. SIEM Architecture  last: 4/5  due: today

  Coming up:
  4. SQL Injection       due in: 2 days
  5. Active Directory    due in: 5 days
══════════════════════════════════════════
Quiz the top overdue topic now? (y/N):
```

### System status (runs at every session start)
```
══════════════════════════════════════════
  VIRGIL Status — 2026-04-29 09:00
══════════════════════════════════════════
  Bridge (ChromaDB):     ✅ running — 7868 chunks
  Ollama:                ✅ running — gpt-oss:20b
  OpenWebUI:             ✅ running (port 3000)
  Conversation ingest:   ✅ running (port 5002)
  Promote.sh:            ✅ ran today
  Vault:                 ✅ 5030 notes
  Ghost-fill:            ✅ complete (4664/4664)
  Health check:          ✅ today
══════════════════════════════════════════
```

---

## Slash Commands

Run these inside Claude Code (`claude` in your VIRGIL directory).

| Command | What it does |
|---------|-------------|
| `/cysa` | CySA+ CS0-003 study session — Feynman prompts, weak topic bias from quiz-scores.json |
| `/secplus` | Security+ SY0-701 study session — domain-mapped Feynman prompts per SY0-701 objective |
| `/aplus` | A+ Core 1/Core 2 study session — maps topics to 220-1101/1102 exam domains |
| `/ccna` | CCNA study session — topic explainer, lab generator, or quiz mode |
| `/reflect` | End-of-session memory distillation — fills daily log summary, marks completed tasks |
| `/handoff` | Save session context to vault before closing — lets you resume in a new chat |
| `/research` | Structured research on any topic → formatted Obsidian note in the vault |
| `/challenge` | Challenge a proposed decision or architecture — plays devil's advocate |
| `/day` | Brain dump processor — log loose notes, create topic stubs from what you mention |
| `/week` | Synthesize last 7 daily logs into a weekly digest note |
| `/task` | Capture and file a task to the appropriate memory section |
| `/job` | Job search tracker — add posting, draft cover letter, log followups |
| `/lab` | Generate a live fleet status snapshot |
| `/focus` | Load context for a specific mode: `lab`, `study [cert]`, or `jobsearch` |
| `/sync` | Sync external project progress into the vault — updates daily log and memory |
| `/enrich` | Run the enrichment pipeline — fills stub notes via LLM |
| `/ingest-chat` | Ingest a Claude.ai conversation export to the vault |
| `/deploy` | Deploy VIRGIL to a fleet machine via SSH |
| `/start` | Welcome a new or returning student — builds context, surfaces where you left off |
| `/diagnose` | Student intake: records your why, background, and learning style, runs a diagnostic quiz to find your starting chapter |
| `/plan` | Builds a week-by-week study roadmap with chapter checkboxes and a realistic exam timeline |
| `/teach` | Chapter-by-chapter teaching from vault content — Feynman analogies tuned to your background, won't advance until you understand it |
| `/burnout` | Burnout recovery: real talk, one question, smallest possible re-entry point |
| `/imposter` | Imposter syndrome: breaks down your specific wall, runs a gentle quiz to show you what you already know |
| `/absence` | Return-after-gap: tiered response based on how long you've been away |

---

## The Learning Engine

VIRGIL isn't just a note vault — it's a study companion that knows who you are and teaches accordingly.

### Getting started

```
/diagnose    — Tell VIRGIL who you are and where you're going.
               Builds your profile, runs a diagnostic quiz,
               finds your starting point.

/plan        — Generates your week-by-week study roadmap.
               Realistic timelines, chapter checkboxes,
               exam day prep.

/teach       — Chapter-by-chapter teaching from vault content.
               Feynman analogies tuned to your background.
               Won't move on until you understand it.
```

### The cert path

```
A+ → Security+ → CCNA → CySA+
```

Each cert builds on the last. VIRGIL has pre-built content for all four. You don't need the textbook — the vault has everything.

### Bring your own material

```bash
# Ingest a PDF textbook
virgil-cert-ingest pdf ~/books/ccna-guide.pdf "CCNA"

# Ingest a video transcript
virgil-cert-ingest transcript ~/transcripts/sec-plus.txt "Security+"

# Ingest a study guide URL
virgil-cert-ingest url https://example.com/ccna-notes "CCNA"
```

VIRGIL rewrites source material in Feynman style — it doesn't reproduce the original text verbatim. Your notes, your vault, your words.

---

## How it works

![VIRGIL knowledge graph](assets/virgil-graph.gif)

**VIRGIL is an Obsidian vault + automation system.**

The core loop:

1. **Ingest** — threat intel feeds, CVEs, ATT&CK techniques arrive every morning
2. **Connect** — wikilink script runs nightly, linking CVEs → ATT&CK → NIST controls
3. **Study** — Feynman-style sessions push back, find gaps, and record what you got wrong
4. **Distill** — session logs → permanent memory facts via nightly AI distillation
5. **Repeat** — quiz scores surface weak topics; the system knows what to drill

After six months of real use: not 500 disconnected files, but a knowledge graph — CVEs linked to ATT&CK techniques linked to NIST controls linked to the lab config where you saw it in practice.

### Architecture

| Layer | What it does |
|-------|-------------|
| Obsidian vault | Markdown notes, graph view, search |
| Claude Code | AI sessions, study commands, memory |
| Ingest pipelines | RSS, CVE, URL, PDF → notes |
| Ollama | Local inference, no API costs |
| ChromaDB (optional) | Vector search over your vault |
| OpenWebUI (optional) | Browser and mobile access |

Full details: [`ARCHITECTURE.md`](ARCHITECTURE.md)

---

## Philosophy

*Nel mezzo del cammin di nostra vita — midway through the journey of our life, I came to myself in a dark wood, for the straight way was lost.*

Dante wrote that in 1308. Virgil — the Roman poet — was sent to guide him through what came next. Not to skip it. Not to make it comfortable. To make it survivable. To show him the structure of what he was walking through so he could stop being afraid of the wrong things.

This project is named for him. The field is the dark wood. VIRGIL is the guide.

---

You're studying for a cert. Or building a homelab. Or trying to absorb threat intel that drops faster than you can process it.

The advice online is everywhere and contradictory. Every roadmap has an affiliate link. You're studying in the gaps between applications, and nothing is sticking — because there's no system holding it together.

That's a structural problem, not a personal one. VIRGIL is what fixes it.

Built during exactly this grind — not by someone who packaged lessons into a course after making it — but live, under pressure, while studying for CySA+, running a homelab, and navigating a tough job market. You don't have to build it from scratch. Use what's here.

VIRGIL does not congratulate you for showing up. The work is the work. VIRGIL is how you make it compound.

---

## Security

A four-source independent audit was completed April 2026 (Claude Sonnet 4.6, Gemini 1.5 Pro, Claude Haiku 4.5, Claude Opus 4.6). Full report: [docs/audit-2026-04-27.md](docs/audit-2026-04-27.md)

Fixed in this release: sanitization leaks, Python dependency pinning, url-ingest.sh URL validation with SSRF protection, eval+crontab pattern replaced with safe secret loading.

---

*"I have come to lead you to the other shore; into eternal darkness; into fire and into ice."*
*— Virgil, Inferno Canto III*

The path is real. It is not comfortable, and it does not get easier. You get more capable — which is a different thing.
