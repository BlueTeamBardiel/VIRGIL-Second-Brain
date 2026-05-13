# VIRGIL — Public Roadmap

The public roadmap. Item lists only what the maintainer has actually committed to working on next. Maybe items live in "open questions" — those are decisions waiting for evidence, not plans.

The maintainer's private operational TODOs do not live here.

---

## v2.0.0 — shipped

The current release. See [`CHANGELOG.md`](CHANGELOG.md) for the full set of changes.

Highlights:

- [x] Scope rule established and enforced by the promotion gate (cert / CVE / RSS only).
- [x] 739 cert notes across five tracks (A+, CCNA, CySA+, Net+, Sec+).
- [x] 239 audited CVE notes in `notes/knowledge/cve/`.
- [x] `soul.md` as a first-class component — voice, registers, Feynman Doctrine.
- [x] 23 slash commands across cert study, study support, walls, session management, system.
- [x] Two-backend support (Ollama or Anthropic API) via `VIRGIL_BACKEND`.
- [x] Memory model: working / episodic / semantic, plus `user.md` profile.
- [x] `scripts/promote-to-public.py` — the public-private gate as a reference implementation.
- [x] Removed: Slack approval bot, Telegram capture bot, ChromaDB/RAG stack, conversation ingest, MITRE/NIST libraries, 33 out-of-scope `notes/knowledge/` subdirectories.

---

## v2.1.0 — planned

Next on the path. Order is rough; what's first depends on which lands cleanly.

- [ ] **Cert content backfill.** The track densities at v2.0.0 are uneven — Net+ at 66 notes is the thinnest. Bring the lighter tracks closer to parity with CySA+.
- [ ] **CVE corpus expansion.** Curate another batch through the audit gate. Target +200 notes weighted toward currently-exploited classes.
- [ ] **Reproducible installer.** Move from `git clone && bash install.sh` to a checksum-verified release tarball. Removes the implicit "trust the latest main" model.
- [ ] **`virgil status` command.** A single command that reports backend health, last-ingest run, vault size, and any cron failures. Today this is scattered across `tail logs/*`.
- [ ] **Cert objective files.** Ship the per-cert exam-objective files the gate's hallucination check uses. Without them, forkers can't run the gate against their own content.
- [ ] **Diagnostic quiz coverage.** `/diagnose` currently runs a generic 10-question quiz per cert. Build per-domain question banks so the diagnostic actually maps to where someone's weakest.

---

## Open questions (waiting for evidence)

These are not commitments. They're decisions the maintainer is undecided on. Forkers tracking the project may want to follow them; PRs that move the conversation forward (data, prototypes, links to relevant prior art) are welcome.

- **RAG / ChromaDB.** v2.0.0 deliberately ships without a vector store — Obsidian search and Claude Code's file tools cover most uses. Whether to ship an opt-in RAG layer in a later version depends on whether users hit the wall where grep stops being enough. Open question: at what vault size does grep stop scaling for the typical user?

- **Additional certs.** CISSP, CCNP, OSCP, AZ-500, AWS Security Specialty have all been suggested. Each adds maintenance load. Question: which adds the most value relative to the audience already studying with VIRGIL?

- **Spaced-repetition algorithm.** `hooks/review.sh` uses SM-2 over `logs/quiz-scores.json`. FSRS is the modern Anki default. Question: does SM-2 underperform enough on this corpus shape to justify the swap?

- **soul.md localization.** The Dante framing reads as Western-canon-coded. Question: is there appetite for parallel soul files in other framings (a Mahabharata guide, a Cosmos-style Sagan voice, a Confucian Analects framing) — and would those be community-maintained or forked?

- **Mobile capture.** Capture-on-the-go was useful in the private system. Question: is there a generic public version that doesn't require everyone running their own server?

- **Browser-extension URL ingest.** `url-ingest.sh` works from the terminal. A right-click "send to VIRGIL" extension would lower friction. Question: is the extension-store hassle worth the friction reduction?

---

## What this roadmap doesn't include

Out of scope for the public repo per the scope rule (see [`ARCHITECTURE.md` §2](ARCHITECTURE.md#2-the-scope-rule)):

- Homelab fleet orchestration, Ansible/Semaphore integration.
- MITRE ATT&CK library, NIST control library, threat-actor profiles.
- Conversation-ingest pipelines for Claude.ai or other transcripts.
- Job-search scaffolding beyond the generic `/job` command.
- Hosted/SaaS offerings.

If you want any of these, fork the repo and add them — the architecture supports it. The fork-and-adapt path is documented in [`ARCHITECTURE.md` §11](ARCHITECTURE.md#11-forking-virgil).

---

## How items move

- An item moves from **Open questions** to **v2.1.0 — planned** when the maintainer commits to it. Until then, no timeline.
- An item moves from **v2.1.0 — planned** to **v2.1.0 — shipped** when it lands in main and clears the gate.
- Anything still in "Open questions" at the next release rolls forward unless explicitly retired.

Tracking issues for individual roadmap items live in GitHub Issues. Tag: `roadmap`.

---

*Last updated alongside the v2.0.0 release. Current version: v2.0.0.*
