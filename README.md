# VIRGIL

![Version](https://img.shields.io/badge/version-v2.0.0-blue) ![Platform Linux](https://img.shields.io/badge/platform-Linux-informational) ![Platform macOS](https://img.shields.io/badge/platform-macOS-informational) ![Platform Windows WSL2](https://img.shields.io/badge/platform-Windows%20WSL2-informational) ![License MIT](https://img.shields.io/badge/license-MIT-green)

A cybersecurity study companion built on three things you already understand: a folder of Markdown notes (the vault), a terminal AI that loads a behavioral spec, and two ingest pipelines that keep the vault current while you sleep. Local-first. Forkable. No telemetry. No subscription.

## The scope rule

The public repo holds three categories of content and nothing else:

1. **Certification notes** — A+, Net+, Sec+, CCNA, CySA+. Feynman-style, grounded in real-world consequence.
2. **CVE notes** — vulnerabilities translated from raw NVD data into plain-English impact statements.
3. **RSS digests** — a daily digest synthesized from 22 curated security feeds.

Anything else you may have seen VIRGIL do — homelab orchestration, MITRE/NIST libraries, conversation ingest, mobile capture — lives in the maintainer's private downstream system. Fork the repo if you want any of it; the architecture supports it.

## What ships in v2.0.0

- **739 cert notes** — A+ (136), CCNA (154), CySA+ (263), Net+ (66), Sec+ (120). All Feynman-style per `soul.md`.
- **239 audited CVE notes** in `notes/knowledge/cve/` plus a nightly runtime pipeline that adds more.
- **23 slash commands** — cert sessions, teaching, diagnosis, the four meta-cognition "wall" commands, session management.
- **`soul.md`** — the behavioral spec. Voice, teaching method, what VIRGIL never says. The most important file in the repo.
- **The promotion gate** — produces this repo from the maintainer's private system. Five hard-fail checks before any note publishes. Runs in the maintainer's private system, not shipped here; a sanitized reference implementation is planned for v2.1.0.
- **Two backends** — Ollama (local) or Anthropic API. Pick one at install time.

## Quickstart

```bash
git clone https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain.git
cd VIRGIL-Second-Brain
bash scripts/install.sh
```

The installer is interactive. Every prompt explains what saying yes vs. no will do. Decline anything you don't want — saying no is always safe.

Then:

```bash
cd ~/VIRGIL && claude
```

In Claude Code, run `/start`. VIRGIL conducts a brief onboarding interview and writes the answers to `user.md`. After that, pick a cert:

```
/secplus    /ccna    /cysa    /aplus    /netplus
```

Full setup walkthrough: [`GETTING-STARTED.md`](GETTING-STARTED.md).

## What it looks like

### A cert study session (`/secplus` in Claude Code)

```
Topic: Kerberoasting

Think of Kerberos like a club's coat check. You hand over your ticket
(your password), the bouncer hands you a wristband. You show the wristband
to anyone inside, and they trust it. Kerberoasting is when someone steals
the template the bouncer uses to make wristbands, takes it home, and
brute-forces their way to making their own.

Service accounts get this attack because their wristband templates use
the account's password as the secret. Crack the wristband offline, you
have the password.

Q: What makes a service account vulnerable to Kerberoasting?
   A) NTLM authentication enabled
   B) Password hash embedded in the Kerberos ticket
   C) Local admin rights
   D) LDAP fallback

Your answer:
```

### A spaced-repetition review (`virgil-review`)

```
══════════════════════════════════════════
  VIRGIL Review Session — 2026-05-12
══════════════════════════════════════════
  Due today (3):
    1. kerberoasting       last 2/5   overdue 8 days
    2. lateral movement    last 3/5   overdue 3 days
    3. SIEM architecture   last 4/5   due today

  Coming up:
    4. SQL injection       due in 2 days
    5. Active Directory    due in 5 days
══════════════════════════════════════════
Quiz the top overdue topic now? (y/N):
```

## How it's organized

VIRGIL is three layers:

| Layer | What it is |
|---|---|
| **Content** | The vault at `~/VIRGIL/`. Markdown files. Obsidian view. |
| **Brain** | Claude Code loading `CLAUDE.md` + `soul.md` + 23 slash commands. |
| **Pipelines** | Two cron jobs that pull threat intel and CVEs nightly. |

Pick a backend (Ollama or Anthropic API) at install time. Set it in `.env`. No fallback chain — one or the other.

Full architectural breakdown: [`ARCHITECTURE.md`](ARCHITECTURE.md).

## The operating-system framing

VIRGIL is not a course you buy or a product you subscribe to. It's a small operating system for studying — bring your own content, retune the voice, swap the inference backend, fork the gate. The shape is generic; only the cybersecurity flavor is opinionated.

Five places to retune it for your own use:

1. **Add a cert.** Create `notes/knowledge/<cert>/`, write notes per `soul.md`, add a slash command. ARCHITECTURE.md §11.1.
2. **Retune the voice.** Edit `soul.md`. The Dante framing is one metaphor — pick another. §11.2.
3. **Swap a backend.** Point `hooks/llm_client.py` at any OpenAI-compatible endpoint. §11.3.
4. **Add a feed.** Edit `FEEDS.md`. §11.4.
5. **Bring your own content pipeline.** A sanitized reference implementation is planned for v2.1.0. Until then, §11.5 documents the five checks the gate enforces so you can build your own.

The point: depth over bloat. The shipped surface is small on purpose so the fork-and-adapt path is short.

## Why "VIRGIL"

Named for Publius Vergilius Maro — Roman poet, author of the Aeneid, guide to Dante through Inferno and Purgatorio. He lives in Limbo among the virtuous pagans: not in torment, but permanently outside Paradise. He does the work anyway.

That's the model. The dark wood is the field you're entering. VIRGIL navigates it ahead of you, points at what each thing is, and tells you what to fear and what is just decoration. It will not lift you. But it walks in front of you.

The full framing is in [`soul.md`](soul.md). Read it before forking — that file is the soul of the project.

## Status and roadmap

v2.0.0 is the current shipped release. Planning for v2.1.0 lives in [`ROADMAP.md`](ROADMAP.md). Release notes for what landed in v2.0.0: [`CHANGELOG.md`](CHANGELOG.md).

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md). The scope rule applies — PRs that re-add cut features (Slack bot, ChromaDB, MITRE library) will be closed with a pointer to the gate.

## Security

- All inference, all notes, all memory stays on your machine unless `VIRGIL_BACKEND=anthropic`.
- No telemetry. No analytics. No update pings.
- `gitleaks` runs pre-commit on this repo. Set it up locally if you fork — `pip install pre-commit && pre-commit install`.
- The gate runs a leakage scan, scope check, placeholder check, hallucination check, and H1 check before any note publishes. The gate runs in the maintainer's private system. ARCHITECTURE.md §9.2.

## Further reading

- [`soul.md`](soul.md) — the behavioral spec
- [`ARCHITECTURE.md`](ARCHITECTURE.md) — full architectural breakdown
- [`GETTING-STARTED.md`](GETTING-STARTED.md) — install walkthrough
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — fork-and-contribute guide
- [`FEEDS.md`](FEEDS.md) — the 22 RSS feeds
- [`ROADMAP.md`](ROADMAP.md) — what's planned for v2.1.0

---

*"I have come to lead you to the other shore; into eternal darkness; into fire and into ice."* — Inferno Canto III

The path is real. It does not get easier. You get more capable — a different thing.
