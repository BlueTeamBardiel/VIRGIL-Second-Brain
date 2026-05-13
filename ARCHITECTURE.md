# VIRGIL Architecture

How VIRGIL works, what ships in v2.0.0, and what doesn't. Read this before installing if you want to understand what you're getting and why it's shaped the way it is.

Audience: basic Linux comfort. No prior AI tooling experience assumed.

---

## 1. What VIRGIL is

VIRGIL is a cybersecurity study companion built on three things you already understand:

- A folder of Markdown notes (the vault), viewed in Obsidian.
- A terminal AI (Claude Code) that loads a behavioral spec (`soul.md`) and a set of slash commands.
- Two ingest pipelines (CVE and RSS) that keep the vault current while you sleep.

That is the whole product. Everything else in this document is detail.

---

## 2. The scope rule

The public repo ships three categories of content and nothing else:

1. **Certification notes** — A+, Net+, Sec+, CCNA, CySA+. Feynman-style explanations grounded in real-world consequence.
2. **CVE notes** — vulnerabilities translated from raw NVD data into plain-English impact statements.
3. **RSS digests** — a daily digest synthesized from a curated set of threat-intel feeds.

Anything else you may have heard VIRGIL does — homelab fleet orchestration, conversation ingest from Claude.ai, MITRE technique notes, NIST control libraries, OSINT, job-search scaffolding beyond the generic `/job` command — lives in the maintainer's private downstream system. None of it ships here. If you want any of it, fork and build it.

The scope rule is enforced by a gate (see §9.2 and §11.5). The cert/CVE/RSS triple is the contract.

---

## 3. What v2.0.0 ships

You get:

- **Cert notes across five tracks** — A+ (136 notes), CCNA (154), CySA+ (263), Net+ (66), Sec+ (120). 739 notes total, Feynman-style across the cert range. CySA+ is the densest at v2.0.0 day-zero; all five tracks are shipping.
- **239 curated CVE notes** in `notes/knowledge/cve/`. Each is audited for accuracy and leakage. See `notes/knowledge/cve/README.md` for the committed-vs-runtime split.
- **CVE ingest pipeline** that backfills new disclosures from the NVD API.
- **RSS ingest pipeline** with 22 default feeds (`FEEDS.md`).
- **23 slash commands** turning the vault into a study companion. Full list in §6.3.
- **`soul.md`** — the behavioral spec for VIRGIL's voice. Treat this as the most important file in the repo.
- **`install.sh`** — sets up the runtime vault, Ollama (optional), cron jobs, environment.
- **The promotion gate** — produces this repo from the maintainer's private system. Runs five hard-fail checks before any note ships. The gate itself lives in the maintainer's private system; a sanitized reference implementation is planned for v2.1.0. Documented in §11.5.

You do not get:

- A pre-built ChromaDB or RAG index. The vault is browsed via Obsidian and queried via Claude Code's file tools.
- A Slack approval bot. Write operations are gated by Claude Code's built-in permission prompts — the same prompts that gate any tool call.
- A Telegram capture bot.
- Conversation ingest from Claude.ai.
- A pre-populated MITRE technique library, NIST control library, or curated tools index.

---

## 4. Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                          Your Machine                             │
│                                                                   │
│   ┌─────────────────┐         ┌────────────────────────────────┐ │
│   │   CONTENT       │ ◄────►  │   BRAIN                        │ │
│   │   ~/VIRGIL/     │         │   Claude Code (terminal)       │ │
│   │   the vault     │         │   loads CLAUDE.md + soul.md    │ │
│   │   Obsidian view │         │   23 slash commands            │ │
│   └────────┬────────┘         └───────────────┬────────────────┘ │
│            │                                  │                   │
│            │                                  ▼                   │
│            │                  ┌────────────────────────────────┐ │
│            │                  │   INFERENCE (one of)           │ │
│            │                  │   • Ollama (local, optional)   │ │
│            │                  │   • Anthropic API              │ │
│            │                  └────────────────────────────────┘ │
│            │                                                      │
│            ▼                                                      │
│   ┌──────────────────────────────────────────────────────────┐   │
│   │   PIPELINES (cron, nightly)                              │   │
│   │     • rss-ingest.py  →  notes/feeds/YYYY-MM-DD.md        │   │
│   │     • cve-ingest.py  →  notes/cve/CVE-YYYY-NNNNN.md      │   │
│   └──────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────┘
```

Three layers: content (vault), brain (Claude Code + soul.md), pipelines (CVE + RSS). Local-first. The cloud is opt-in, not default.

---

## 5. The vault

The vault is the system of record. Everything else is glue around it. Two distinct trees matter: the repo you clone, and the runtime layout `install.sh` creates on your machine.

### 5.1 Repo layout (what you clone)

```
virgil-public/
├── notes/
│   └── knowledge/
│       ├── aplus/            ← A+ notes (136)
│       ├── ccna/             ← CCNA notes (154)
│       ├── cysa/             ← CySA+ notes (263)
│       ├── netplus/          ← Network+ notes (66)
│       ├── security-plus/    ← Security+ notes (120)
│       └── cve/              ← 239 curated CVE notes
├── ingest/
│   ├── rss-ingest.py         ← daily threat-intel digest (06:00 cron)
│   ├── cve-ingest.py         ← daily CVE notes from NVD (07:00 cron)
│   ├── url-ingest.sh         ← user-triggered, see §8.3
│   ├── pdf-ingest.sh         ← user-triggered, see §8.3
│   ├── cert-ingest.sh        ← bring-your-own cert material, see §8.3
│   ├── triage-inbox.sh       ← Monday inbox triage (08:00 cron)
│   ├── wikilink-ingest.sh    ← graph densifier (23:30 cron, opt-out)
│   └── orphan-detect.sh      ← called by weekly-rollup
├── hooks/
│   ├── quiz.sh               ← interactive 5-question quiz
│   ├── review.sh             ← spaced-repetition dashboard (SM-2)
│   ├── promote.sh            ← daily-log → memory distiller (01:00 Mon–Sat cron)
│   ├── auto-reflect.sh       ← empty stub filler (23:55 cron)
│   ├── weekly-rollup.sh      ← Sunday digest (01:00 Sun cron)
│   └── vault-backup.sh       ← optional rsync helper
├── scripts/
│   ├── install.sh
│   ├── uninstall.sh
│   ├── check-deps.sh
│   ├── docker-entrypoint.sh
│   └── homelab/
│       └── ad-hardening/     ← AD lab scripts, see §11.6
├── .claude/
│   └── commands/             ← 23 slash commands
├── soul.md                   ← behavioral spec
├── CLAUDE.md                 ← project instructions
├── ARCHITECTURE.md           ← this file
├── GETTING-STARTED.md
├── CONTRIBUTING.md
├── ROADMAP.md
└── FEEDS.md                  ← RSS feed list
```

### 5.2 Runtime layout (what install.sh creates at ~/VIRGIL/)

```
~/VIRGIL/                     ← vault root (override with VIRGIL_DIR)
├── notes/
│   ├── knowledge/            ← copied from the repo on install
│   │   └── cve/              ← the 239 committed starter CVEs
│   ├── cve/                  ← your runtime CVE feed (gitignored, grows)
│   └── feeds/                ← daily RSS digests (gitignored)
├── memory-working.md         ← active pending tasks (cleared weekly)
├── memory-episodic.md        ← session history, promoted facts
├── memory-semantic.md        ← permanent facts: certs, decisions
├── user.md                   ← who you are; created on first /start or /diagnose
├── logs/                     ← ingest logs, quiz-scores.json
└── .env                      ← your config (gitignored, see §10)
```

The repo content is git-tracked and updates with `git pull`. The runtime CVE feed (`~/VIRGIL/notes/cve/`) and daily feed digests are gitignored — your data, your machine. The `memory-*.md` and `user.md` files are gitignored at the repo level too; they are yours.

`install.sh` creates the three `memory-*.md` files as empty starters. `user.md` is created on first run by `/start` or `/diagnose` through a guided interview — name, background, certs in progress, target roles. Once it exists, every session can read it without re-asking. This file is gitignored: it's yours.

### 5.3 Wikilinks and the graph

Notes link via `[[wiki links]]`. A CCNA VLAN note links to the Net+ network-segmentation note, which links to the Sec+ defense-in-depth note. Open Obsidian's graph view (`Ctrl+G`) to see structure.

The graph at install time is sparse — five cert clusters, the CVE corpus, and a handful of shared concepts connecting them. It densifies as the pipelines run and as you add notes. §12 sketches the day-zero shape and what six months of use looks like.

---

## 6. The brain

### 6.1 Claude Code + CLAUDE.md

Claude Code is Anthropic's terminal AI. You run it inside `~/VIRGIL`. On start it loads:

- `CLAUDE.md` — project instructions: paths, conventions, memory file pointers, name and profile fields.
- `soul.md` — the behavioral spec: voice, teaching method, registers, forbidden outputs.

Together these two files configure who VIRGIL is. To retune VIRGIL — for a different domain, a different voice, a different cert — edit these files. The slash commands are the third leg; see §6.3.

### 6.2 soul.md (behavioral spec)

`soul.md` is the most important file in the repo. It defines:

- **Origin** — the Dante framing. VIRGIL guides through the dark wood of IT the way Virgil guided Dante.
- **The Feynman Doctrine** — every concept gets mechanism, consequence, and analogy. No jargon without definition. No definition without grounding.
- **Character** — reason with acknowledged limits, guide not servant, patient teacher who eventually loses patience, protector who warns before breaking things.
- **The four registers** — normal, teaching, urgent, uncertain. The voice shifts with the situation.
- **Forbidden outputs** — what VIRGIL never says. No "great question," no "happy to help," no padding.
- **Output format rules** — short answers stay short. Density is helpfulness.

Forkers building a different study companion should retune this file first, before touching anything else.

### 6.3 Slash commands

In `.claude/commands/`. Each is a Markdown file the LLM reads when the command fires. Edit them to retune behavior.

**Cert study sessions**

| Command | Purpose |
|---|---|
| `/aplus` | A+ Core 1 / Core 2 study session |
| `/netplus` | Network+ session |
| `/secplus` | Security+ SY0-701 session |
| `/ccna` | CCNA routing/switching session |
| `/cysa` | CySA+ CS0-003 session |

**Study support**

| Command | Purpose |
|---|---|
| `/teach` | Free-form Feynman teaching on a vault topic |
| `/diagnose` | Identify weak areas across a cert; creates `user.md` on first run via guided interview |
| `/plan` | Personalized study plan |
| `/challenge` | Stretch question on a topic you already know |
| `/research` | Deep-dive on a topic, writing structured notes |
| `/focus` | Load context for a specific focus area |

**Meta-cognition (the walls)**

These engage when you hit a wall. Different walls need different responses.

| Command | Purpose |
|---|---|
| `/start` | Begin or re-enter a study journey; creates `user.md` on first run via guided interview |
| `/imposter` | Imposter syndrome — shows the receipts of what you've actually done |
| `/burnout` | Burnout / re-entry — one question, smallest re-entry point |
| `/absence` | Returning after time away — adjusts based on how long |

**Session management**

| Command | Purpose |
|---|---|
| `/day` | Process today's intake |
| `/week` | Weekly digest of the past seven days |
| `/reflect` | End-of-session memory distillation |
| `/handoff` | Save dense context before closing |
| `/sync` | Sync user progress markers |
| `/task` | File a task into the configured category list |

`/task` reads its category list from `CLAUDE.md` — edit there if you want different buckets.

**System**

| Command | Purpose |
|---|---|
| `/enrich` | Run the enrichment pipeline interactively |
| `/ingest-chat` | Ingest a Claude.ai conversation transcript |
| `/job` | Generic job-search tracking (Indeed/LinkedIn) |

### 6.4 Memory

Memory is the part of the brain VIRGIL keeps between sessions. Three layers, three files, three jobs.

| Layer | File | Lifespan | What it holds |
|---|---|---|---|
| Working | `memory-working.md` | Cleared weekly | Active tasks, open threads, what you're mid-something on |
| Episodic | `memory-episodic.md` | Append-only | Session history, promoted facts, what you did and when |
| Semantic | `memory-semantic.md` | Append-only | Permanent facts: certs in progress, durable decisions, identity |

**The three layers, with the analogies that make them stick.**

**Working memory is the Skyrim quest journal.** Open it and you see the things you said you'd do but haven't finished — the bounty in Whiterun, the dragon claw you've been carrying around, the misc. objective that's been sitting at "Talk to Delphine" for forty hours. It's short, it's current, and it gets cleared the moment the task is done. Working memory is what's still alive in your head right now.

**Episodic memory is the Dark Souls bonfire history.** Every bonfire you lit, in order, is a record of where you've been. You can scroll back and see the path that got you here — the boss you cleared on the fourth try, the shortcut you finally unlocked, the merchant you killed before realizing you needed him. It's append-only because the past doesn't get rewritten. You re-read it when you want to know "what did I actually do, in what order, and what came of it."

**Semantic memory is the Outer Wilds ship log.** Patterns, not events. After enough loops, the log stops being a list of what you did and starts being a map of what is true: the Sun Station is structurally unstable; the Nomai used quantum stones to teleport. Semantic memory is the same — distilled, durable facts about you and your study path. "Current cert: CySA+. Why: defensive role at a SOC. Pace: 90 minutes a night."

This three-layer split is not arbitrary. It mirrors how working memory, episodic memory, and semantic memory work in cognitive science: short and active, autobiographical and timestamped, generalized and durable. VIRGIL maintains them because a study companion that forgets who you are between sessions is not a study companion.

Claude Code also keeps its own auto-memory under `~/.claude/projects/.../memory/`. That's the conversation-layer record — facts surfaced during a session that Claude has decided are worth keeping. The repo-root files are your study record; the auto-memory is Claude's working record. They complement, not duplicate.

---

## 7. Local AI (optional)

VIRGIL runs against the Anthropic API out of the box. You can run it fully local with Ollama if you have the hardware. There is no fallback chain — it's one or the other, set by `VIRGIL_BACKEND`.

### 7.1 Two backends, picked at config time

```
   ┌─────────────────────────────────────────┐
   │  Option A: Ollama (local)               │
   │  http://localhost:11434                 │
   │  Nothing leaves the machine.            │
   │  VIRGIL_BACKEND=ollama                  │
   └─────────────────────────────────────────┘

                       OR

   ┌─────────────────────────────────────────┐
   │  Option B: Anthropic API                │
   │  Requires ANTHROPIC_API_KEY.            │
   │  VIRGIL_BACKEND=anthropic               │
   └─────────────────────────────────────────┘
```

Pick one. If you change your mind, edit `.env` and rerun the ingest scripts.

### 7.2 Choosing a model

If you're running Ollama, your VRAM dictates what's realistic.

| VRAM | Example model (v2.0.0 era) | Notes |
|---|---|---|
| 8 GB | `llama3.1:8b` | Fast, decent quality. Works on most modern GPUs. |
| 16 GB | `qwen2.5:14b` | Better reasoning. Comfortable middle ground. |
| 24 GB+ | `gpt-oss:20b` | Headroom for long context and reasoning. |
| CPU-only | `llama3.1:8b` | Slow but works. 24-core CPUs run an 8B model in seconds. |

Models age fast. The names above are accurate as of v2.0.0 release. Before pulling, check the Ollama library for current best-in-class at your VRAM tier — what's a sensible default this quarter will be supplanted next quarter. The shape of the choice (small/medium/large + a CPU fallback) doesn't change; the names do.

`OLLAMA_MODEL` in `.env` is a placeholder by default — pick yours and set it.

### 7.3 Reasoning models and num_predict

If you use a reasoning model (`deepseek-r1`, `qwen-thinking`, similar), set `num_predict` to at least 3000. These models burn tokens on internal thinking before they generate visible output. The default `num_predict` is too low; complex questions return empty. This is the most common failure mode for first-time Ollama users on reasoning models.

---

## 8. The pipelines

Two automated pipelines and a handful of user-triggered helpers. All write into the vault. None require manual approval beyond Claude Code's standard tool-use prompts.

### 8.1 RSS ingest

`ingest/rss-ingest.py` runs at 06:00 daily via cron. It pulls the 22 security feeds defined in `FEEDS.md`, deduplicates the last 24 hours of entries, and asks the configured LLM to write one structured digest at `notes/feeds/YYYY-MM-DD.md`.

The digest groups items into sections (threat intel & news, vulnerability advisories, mainstream coverage, community). Swap feeds by editing `FEEDS.md`. Swap the synthesis prompt by editing the script.

### 8.2 CVE ingest

`ingest/cve-ingest.py` runs at 07:00 daily via cron. It pulls recent CVEs from the NVD API, computes severity, and writes one note per CVE to `notes/cve/CVE-YYYY-NNNNN.md` in your runtime vault.

Each note is Feynman-style per `soul.md`: not "JNDI injection via log message interpolation" but "a logging library that was supposed to write error messages to a file could instead be tricked into calling home to an attacker's server."

The 239 CVE notes that ship with v2.0.0 live in `notes/knowledge/cve/` (committed, curated). Your nightly accumulation lives in `notes/cve/` (gitignored, yours). Same graph view, different directories. See `notes/knowledge/cve/README.md` for the rationale.

### 8.3 User-triggered ingest helpers

These run when you tell them to, not on a schedule.

**`ingest/url-ingest.sh`** — paste a URL, get a Feynman-style summary written into the vault. Useful for ingesting blog posts, vendor write-ups, or advisories you want as searchable notes.

**`ingest/pdf-ingest.sh`** — extract text from a local PDF, summarize it into vault notes. **Copyright caveat: the rewritten summary is derivative content. If the source PDF is a copyrighted textbook, redistributing the resulting notes can violate copyright or DMCA. Use this for personal study; don't push the output to a public repo without confirming the source license permits it.**

**`ingest/wikilink-ingest.sh`** — opt-in. Scans the vault for terms that match existing note titles and inserts `[[wikilinks]]` where they're missing. Densifies the graph. Run it occasionally if your notes feel disconnected.

**`ingest/cert-ingest.sh`** — bring your own cert study material. Pass it a PDF, URL, or text transcript plus a cert tag (`virgil-cert-ingest pdf book.pdf "CCNA"`). It chunks the source, rewrites each section in Feynman style per `soul.md` (no verbatim reproduction), and files it into `notes/knowledge/<cert>/` with the standard cert-note structure. Useful if you're studying a cert VIRGIL doesn't yet ship for, or if you want to enrich an existing track with your own textbook content. Copyright caveat from `pdf-ingest.sh` applies: the output is derivative content; don't redistribute beyond personal use without confirming source licensing.

**`ingest/triage-inbox.sh`** — runs weekly at 08:00 Monday via cron, also available as `virgil-triage` for manual runs. Scans `notes/inbox/` for anything you've dropped there during the week, asks the configured LLM whether each note should merge into an existing note, stay in the inbox, or move to `notes/archive/`. The LLM decision arrives as JSON with action and reasoning. Keep the inbox under control without manually filing every drive-by note.

### 8.4 Optional helpers (personal-memory loop)

These scripts ship with the public repo and `install.sh` adds them to your crontab by default. They're labeled "optional" because removing the corresponding line from your crontab disables them cleanly — `crontab -e`, delete the line, save. Nothing else needs to change.

**`hooks/promote.sh`** — distills the last seven daily-log entries into `memory-*.md`. Runs Mon–Sat at 01:00 if enabled. Daily logs are gitignored; this script is how the working/episodic/semantic split gets populated automatically over time.

**`hooks/auto-reflect.sh`** — fills empty stub notes by calling the configured LLM. Runs at 23:55. Useful if you create titled placeholder notes faster than you can write the bodies.

**`hooks/weekly-rollup.sh`** — runs Sunday at 01:00. Produces a digest of the past week's daily logs.

**`hooks/vault-backup.sh`** — rsyncs your vault to a USB drive or NAS. Manual or cron, your call.

**`hooks/quiz.sh`** — `virgil-quiz <topic>` runs a 5-question quiz on a vault topic. It tries ChromaDB for retrieval if you've set that up; otherwise it falls back to `grep` over the vault. Either path works without RAG infrastructure.

**`hooks/review.sh`** — `virgil-review` shows due topics using an SM-2 spaced-repetition algorithm over `logs/quiz-scores.json`. Quiz a topic to populate scores; review surfaces what's overdue.

**`ingest/orphan-detect.sh`** — called by `weekly-rollup.sh`. Finds notes with zero inbound and zero outbound `[[wikilinks]]` — the disconnected ones — and surfaces them in the weekly digest. The graph view in Obsidian shows them visually; this script surfaces them in text so you can address them deliberately.

---

## 9. Security model

### 9.1 Local by default

Your vault, your memory files, your quiz scores, your daily logs — all stay on your machine. There is no telemetry, no analytics, no phoning home. Cron jobs run locally and write locally.

The two things that leave your machine on a schedule are explicit:

1. **RSS feed fetches** — standard HTTP GETs to the 22 feed URLs in `FEEDS.md` at 06:00 daily.
2. **NVD API fetches** — standard HTTP GETs to `https://services.nvd.nist.gov/` at 07:00 daily.

If `VIRGIL_BACKEND=anthropic`, prompts you generate also go to the Anthropic API. If `VIRGIL_BACKEND=ollama`, they don't.

### 9.2 The gate as a security boundary

The public repo is downstream of a gate the maintainer can't easily bypass. The gate runs in the maintainer's private system and applies five hard-fail checks before any note can move to this repo:

1. **Scope check** — content must fit cert, CVE, or RSS. Anything else is rejected.
2. **Leakage scan** — strings matching the private-infrastructure blocklist (fleet hostnames, lab IPs, personal identifiers, filesystem paths, API keys) block the note from publishing.
3. **Placeholder leakage** — debug placeholders left in by accident block the note.
4. **Hallucination check** — tiered fuzzy match against per-cert exam objectives plus an acronym corpus. Content that drifts from the syllabus is flagged.
5. **H1 header required** — every published note has a valid H1 title.

A note that passes all five is what you read here. Notes that fail any check stay private and the gate explains which check fired. The leakage scan is the most security-relevant of the five — it's why the public repo has no maintainer hostnames, no lab subnet ranges, no personal paths or identifiers, even though those exist across the maintainer's source notes.

A sanitized reference implementation of the gate is planned for v2.1.0. If you fork and want to run your own promotion pipeline before then, §11.5 documents the checks the gate enforces.

### 9.3 gitleaks

`gitleaks` runs as a pre-commit hook on this repo. It blocks commits containing API keys, tokens, or known private identifiers from landing in git history. Set it up locally if you fork — `pip install pre-commit && pre-commit install`.

### 9.4 What leaves your machine and when

| Event | What leaves | When |
|---|---|---|
| RSS ingest | HTTP requests to 22 feed URLs | 06:00 daily |
| CVE ingest | HTTP requests to NVD API | 07:00 daily |
| Anthropic backend | Prompts you generate | When you use Claude Code or run ingest |
| Ollama backend | Nothing | — |
| Your vault, memory, scores | Nothing | Ever |

No analytics. No usage tracking. No update pings.

---

## 10. Configuration reference

Environment variables in `~/VIRGIL/.env`:

| Variable | Default | Effect |
|---|---|---|
| `VIRGIL_BACKEND` | `anthropic` | `ollama` to run fully local; `anthropic` to use the API. |
| `OLLAMA_MODEL` | `<model>` | The Ollama model tag — set this. See §7.2. |
| `OLLAMA_URL` | `http://localhost:11434` | Ollama endpoint. |
| `ANTHROPIC_API_KEY` | unset | Required if `VIRGIL_BACKEND=anthropic`. |
| `VIRGIL_DIR` | `$HOME/VIRGIL` | Vault root directory. |

Cron jobs installed by `install.sh` (decline at the prompt to skip all of them):

| Time | Job | Effect |
|---|---|---|
| 06:00 daily | `rss-ingest.py` | Writes the daily threat-intel digest. |
| 07:00 daily | `cve-ingest.py --recent` | Writes new CVE notes from the NVD API. |
| 08:00 Mondays | `triage-inbox.sh` | Routes anything dropped into `notes/inbox/`. |
| 23:30 daily | `wikilink-ingest.sh` | Densifies wikilinks across the vault. |
| 23:55 daily | `auto-reflect.sh` | Fills empty stub notes. |
| 01:00 Mon–Sat | `promote.sh` | Distills daily logs into memory files. |
| 01:00 Sundays | `weekly-rollup.sh` | Writes the weekly digest. |

Disable any job with `crontab -e`. Delete the line. No other entries are touched.

---

## 11. Forking VIRGIL

The shape that ships is a cybersecurity study companion. The shape that the code supports is generic: notes + a behavioral spec + slash commands + ingest. Here's how to retune it.

### 11.1 Add a cert

Create `notes/knowledge/<your-cert>/`. Write notes in Feynman style per `soul.md`. Add a slash command at `.claude/commands/<your-cert>.md` modeled on an existing one — `secplus.md` is a good template; it shows the cert-session structure, the call to the syllabus, and how to anchor questions to objectives.

Update any references to the cert list in `CLAUDE.md` and in `/diagnose`, `/start`, `/plan` if you want it picked up as a default option.

### 11.2 Retune the voice (soul.md)

Edit `soul.md`. The Dante framing is one metaphor — pick a different one if it suits your domain. Maxwell guiding through electromagnetism. Carl Sagan walking the cosmos. Whatever resonates.

Keep the four registers and the Feynman Doctrine sections. They carry the weight. The metaphor decorates; the doctrine works.

### 11.3 Swap an inference backend

`ingest/cve-ingest.py` and `ingest/rss-ingest.py` route through `hooks/llm_client.py`. Point that file at any OpenAI-compatible endpoint by changing the base URL. Together with `VIRGIL_BACKEND`, that's the swap.

### 11.4 Add a feed

Edit `FEEDS.md`. `rss-ingest.py` reads the feed list from there. The format is a Markdown table; add a row and the next 06:00 run picks it up.

### 11.5 Bring your own content pipeline

This is the part of the architecture least visible to runtime users and most useful to forkers.

VIRGIL's public repo is the output of a five-stage pipeline that runs on the maintainer's private system. The gate at the end is what produces this repo. The gate itself runs in the maintainer's private system and is not shipped in this repo. A sanitized reference implementation is planned for v2.1.0 — tracked in `ROADMAP.md`.

```
   1. Generate   →  notes/drafts/<topic>/         (private, raw)
   2. Audit      →  fabrication + leakage checks
   3. Promote    →  notes/knowledge/<topic>/      (private, canonical)
   4. Stage      →  notes/public/<topic>/         (private staging)
   5. Publish    →  your-public-repo/notes/...    (this repo, in our case)
```

The five hard-fail checks at the gate are listed in §9.2. Until the reference implementation ships, §9.2 plus this pipeline shape is what you have to work from if you fork and want your own public/private split.

This is a tool for maintainers and forkers. A runtime user of VIRGIL never invokes it. It's documented here because the architectural shape of the public repo doesn't make sense without it.

### 11.6 Homelab labs (scripts/homelab/ad-hardening/)

`scripts/homelab/ad-hardening/` holds eleven PowerShell scripts for hardening an Active Directory lab — DNS audit, security group review, service account inventory, password and lockout policy, GPO audit-policy, PowerShell logging, SMB signing, host firewall, LAPS, AppLocker, and a Windows activation helper.

These are study-adjacent. They tie cert concepts to hands-on practice: LAPS shows up in Security+, GPO audit-policy in CySA+, AppLocker in both. Stand up a lab Windows Server VM, run the scripts in order, and you've got concrete artifacts to point `/teach` at.

The scripts are forker-relevant in two ways. First, they're examples of the kind of cert-adjacent material that fits the scope rule — cert-relevant labs, not maintainer infrastructure. Second, they show what "study-adjacent" content looks like — a useful model if you want to add similar labs for a different domain.

---

## 12. Day-zero knowledge graph

What the graph in Obsidian looks like the moment you finish `install.sh`:

```
            ┌─────────┐
            │ Sec+    │ ──┐
            └────┬────┘   │
                 │        │
        ┌────────┴────────┴────────┐
        │   shared concepts        │
        │  (subnetting, OSI,       │
        │   AAA, encryption,       │
        │   defense-in-depth)      │
        └───┬───────┬───────┬──────┘
            │       │       │
        ┌───┴──┐ ┌──┴──┐ ┌──┴───┐
        │ CCNA │ │ A+  │ │ Net+ │
        └──────┘ └─────┘ └──────┘

                ┌────────┐
                │ CySA+  │ ── connects via blue-team
                └────────┘    + IR + detection concepts

        ┌──────────────────┐
        │ CVE corpus (239) │ ← linked into Sec+ / CySA+ via vuln class
        │ growing nightly  │
        └──────────────────┘

        ┌──────────────────┐
        │ RSS feeds        │ ← daily digests, dated nodes,
        │ growing nightly  │   linked to CVEs they reference
        └──────────────────┘
```

Five cert clusters connected through a small shared-concept hub. Two satellite clusters (CVEs, feeds) that grow every night the cron jobs run.

After six months of use the shape is different. The CVE corpus is several hundred notes larger. The feeds directory has 180+ dated digests with strong cross-links into CVE notes and back into cert material. The shared-concept hub densifies as you write notes that bridge tracks. If you've also been using `/teach`, `/research`, and `/task`, there are clusters of your own work — projects, deep-dives, open questions — orbiting the cert hubs.

The graph is honest about where it starts. It densifies because you used the system, not because the system pretends it did the work for you.

---

Further reading: [`soul.md`](soul.md) · [`GETTING-STARTED.md`](GETTING-STARTED.md) · [`CONTRIBUTING.md`](CONTRIBUTING.md) · [`ROADMAP.md`](ROADMAP.md)
