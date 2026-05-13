# Contributing to VIRGIL

VIRGIL is open source. Contributions that improve cert notes, fix scripts, refine `soul.md`, or harden the ingest pipelines are welcome — including from people who have never contributed to an open source project before.

---

## What's in scope

The public repo holds three categories of content and nothing else:

1. **Certification notes** — A+, Net+, Sec+, CCNA, CySA+, Feynman-style.
2. **CVE notes** — vulnerability analyses translated into plain English.
3. **RSS digest pipeline** — the feed list and the synthesis script.

If your contribution doesn't fit one of those three, it likely belongs in your own fork. See [ARCHITECTURE.md §2](ARCHITECTURE.md#2-the-scope-rule) for the scope rule and [§11](ARCHITECTURE.md#11-forking-virgil) for how to fork-and-adapt cleanly.

The maintainer's full system runs many things this repo doesn't ship — homelab orchestration, fleet automation, conversation capture, MITRE/NIST libraries. Those stay private. The public repo is downstream of a gate (`scripts/promote-to-public.py`) that enforces this. PRs that re-add cut features will be closed with a pointer to the gate.

---

## First time contributing to open source?

The whole process in six steps:

1. **Fork** — click Fork at the top-right of the GitHub page. This creates your own copy.
2. **Clone** — `git clone https://github.com/YOUR-USERNAME/virgil-public.git`
3. **Branch** — `git checkout -b feat/what-youre-adding`
4. **Edit** — make your change
5. **Commit** — `git commit -m "brief description of what and why"`
6. **PR** — push to your fork, then open a Pull Request on the main repo

If you get stuck, open an issue and ask. The bar for questions is low.

---

## Good first contributions

These are scoped to be achievable in under an hour without knowing the whole codebase:

**Fix a cert note.**
Find a note in `notes/knowledge/<cert>/` that has an error, a missing explanation, or a concept that isn't grounded in real-world consequence. Fix it. The standard: could someone who has never heard of this concept understand it after reading the note?

Look for:
- Notes that define a term without explaining what breaks when the concept fails.
- Notes missing the "why does this matter" framing.
- Exam concept notes missing the trap question (what the test is likely to ask, what subtle distinction trips people up).

**Improve a CVE note.**
Find a CVE in `notes/knowledge/cve/` that reads like a CVSS report instead of a Feynman explanation. Rewrite the attacker scenario in plain English. Add a real-world impact statement if missing.

**Sharpen an explanation.**
Find any note where the explanation uses jargon without a plain-English unpack. Rewrite the opening sentence using an analogy *before* the technical definition. See the Feynman template below.

**Add a useful RSS feed.**
The feed list lives in `FEEDS.md`. Add a high-signal security feed. Verify the URL resolves. Check for duplicates first. Explain in the PR why this feed is worth including. The script reads feed names from `FEEDS.md` at runtime — no code changes needed.

---

## How to write a knowledge note (Feynman template)

Every note in the knowledge base follows this structure:

```markdown
# [Concept Name]

[One sentence, plain English. No jargon. If you need a technical term, define it immediately.]

---

## How it works

[Mechanism, step by step. Lead with an analogy before the technical definition.]

Example: "Think of it like a bouncer checking IDs at the door — except the bouncer has been told to trust anyone who knows the secret password, and the password is written on the wall."

## Why it matters

[Real-world consequence. What breaks if this fails? What attack does this enable? What does it cost someone?]

## How it's tested ([cert name])

[The specific way an exam asks about this. Common traps — closely named concepts, subtle distinctions, trick phrasing.]

## Tags

#[cert-tag] #[relevant-category]
```

The test for any explanation: can you describe the concept to a smart friend who works in a different field? If they'd need to already know IT terminology to follow you, the explanation isn't finished.

---

## How to report a bug in the install script

1. Run the installer with verbose output: `bash -x scripts/install.sh 2>&1 | tee /tmp/virgil-install-debug.log`
2. Open an issue and include:
   - Your OS and version (`uname -a`, `lsb_release -a` if Linux)
   - The full error output from the log file
   - Which step failed (the installer prints step numbers)
   - Which backend you're using (Ollama or Anthropic API) — don't paste the key

---

## Adding an ingest script

Follow the pattern in `ingest/url-ingest.sh` or `ingest/cve-ingest.py`:

- `set -euo pipefail` at the top of shell scripts.
- Use `hooks/llm_client.py` for all AI calls — never call the API directly. The client respects `VIRGIL_BACKEND`.
- Write output into a vault subdirectory that fits the scope rule.
- Log to `~/VIRGIL/logs/<script-name>.log` when running from cron.

---

## Submitting a PR

One logical change per PR. In the description, answer:

- What does this change do?
- What did you test it against? (OS, which backend)
- Does it add new dependencies?
- Does it stay inside the scope rule?

PRs that touch the gate (`scripts/promote-to-public.py`) or `soul.md` get extra scrutiny — those files shape what the repo is.

---

## Code style

**Bash:** `set -euo pipefail` always. Quote all variables. Use `mktemp` for temp files. AI calls go through `hooks/llm_client.py` (or the bash wrapper if you write one).

**Python:** AI calls via `from llm_client import ask`. Prefer stdlib. Strip LLM markdown code fences before parsing JSON.

**Markdown:** `[[wiki links]]` for topics, tools, certs, and concepts that already have (or could have) a note in the vault. Consistent heading structure. Tags at the bottom.
