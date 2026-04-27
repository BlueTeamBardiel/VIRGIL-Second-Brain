# Contributing to VIRGIL

VIRGIL is open source. Contributions that improve knowledge notes, fix scripts, add ingest capabilities, or expand the starter vault are welcome — including from people who have never contributed to an open source project before.

---

## First time contributing to open source?

Here's the whole process in six steps:

1. **Fork** — click Fork at the top-right of the GitHub page. This creates your own copy.
2. **Clone** — `git clone https://github.com/YOUR-USERNAME/VIRGIL-Second-Brain.git`
3. **Branch** — `git checkout -b feat/what-youre-adding`
4. **Edit** — make your change
5. **Commit** — `git commit -m "brief description of what and why"`
6. **PR** — push to your fork, then open a Pull Request on the main repo

If you get stuck, open an issue and ask. The bar for questions is low.

---

## Good first contributions

These are scoped to be achievable in under an hour without knowing the whole codebase:

**Fix a note:**
Find a knowledge note in `starter-notes/` that has an error, a missing explanation, or a concept that isn't grounded in a real-world example. Fix it. The standard is: could someone who has never heard of this concept understand it after reading this note?

Files to look for:
- Short notes with no "Why does this matter?" section
- Notes that define terms without explaining what breaks when the concept fails
- Exam concept notes missing the trap question (what the test is likely to ask)

**Add a CVE note:**
Pick a recent high-profile CVE from [NVD](https://nvd.nist.gov) and write a note for it in `starter-notes/cve/`. See the existing CVE notes for the format. Every CVE note should answer: what does this vulnerability actually do, who does it affect, what's the real-world impact, and what's the fix.

**Improve an explanation:**
Find any note where the explanation uses jargon without a plain-English definition. Rewrite the opening sentence using an analogy before the technical definition. See the Feynman template below.

**Add a useful RSS feed:**
Add a high-signal security or networking feed to `ingest/rss-ingest.py`. Verify the URL resolves. Check for duplicates first. Explain in the PR why this feed is worth including.

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

## How it's tested (Security+/CySA+)

[The specific way an exam will ask about this. Common traps — closely named concepts, subtle distinctions, trick phrasing.]

## Tags

#security-plus #cysa-plus #[relevant-category]
```

The test for any explanation: can you describe this concept to a smart friend who works in a different field? If you need them to already know IT terminology to understand your explanation, the explanation isn't finished.

---

## How to report a bug in the install script

1. Run the installer with verbose output: `bash -x scripts/install.sh 2>&1 | tee /tmp/virgil-install-debug.log`
2. Open an issue on GitHub and include:
   - Your OS and version (`uname -a`, `lsb_release -a`)
   - The full error output from the log file
   - Which step failed (the installer prints step numbers)
   - Whether you have an Anthropic API key configured (yes/no — don't paste the key)

Issues tagged [`bug: install`](https://github.com/BlueTeamBardiel/VIRGIL-Second-Brain/issues?q=label%3A%22bug%3A+install%22) track reported installer failures.

---

## Adding an RSS feed

Feeds live in `ingest/rss-ingest.py` as a Python list near the top:

```python
FEEDS = [
    ("Category Name", "https://example.com/feed.rss"),
]
```

Guidelines: group by category, verify the URL resolves, avoid paywalled or auth-required feeds, no marketing blogs, check for near-duplicates before adding.

---

## Adding an ingest script

Follow the pattern in `ingest/url-ingest.sh`:
- `set -euo pipefail` at the top
- Use `llm-client.sh` (bash) or `llm_client.py` (Python) for all AI calls — never call the Anthropic API directly
- Write output to `notes/<category>/<slug>.md`
- Log to `ingest/` with a consistent prefix: `[script-name YYYY-MM-DD HH:MM]`

---

## Submitting a PR

Keep PRs focused. One logical change per PR. In the description, answer:
- What does this change do?
- What did you test it against? (OS, with/without API key)
- Does it add new dependencies?

---

## Code style

**Bash:** `set -euo pipefail` always. Quote all variables. Use `mktemp` for temp files. AI calls go through `llm-client.sh`.

**Python:** AI calls via `from llm_client import ask`. Prefer stdlib. Strip LLM markdown code fences before parsing JSON.

**Markdown:** `[[wiki links]]` for tools, protocols, and concepts. Consistent heading structure. Tags at the bottom.
