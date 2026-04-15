# Contributing to VIRGIL

VIRGIL is a personal second-brain system. Contributions that add ingest capabilities, improve existing scripts, or expand the starter knowledge base are welcome.

---

## How to contribute

1. Fork the repo
2. Create a branch: `git checkout -b feat/your-feature`
3. Make your changes (see patterns below)
4. Test locally — run the script against a real vault, confirm output files are correct
5. Submit a PR with a clear description of what it does and why

---

## Adding RSS feeds

Feeds are defined in `ingest/rss-ingest.py` as a Python list near the top of the file.

```python
FEEDS = [
    ("Category Name", "https://example.com/feed.rss"),
    ...
]
```

Guidelines:
- Group by category: Security News, CVE/Vulnerability, Homelab/Tooling, CySA+ Relevant, CCNA/Networking
- Prefer Atom or RSS 2.0 feeds — check that the feed URL actually resolves before submitting
- No paywalled feeds, no feeds that require authentication
- Check for existing overlap before adding a near-duplicate source

The script calls Claude Haiku to synthesize the daily digest — feeds with low signal-to-noise (marketing blogs, vendor press releases) will dilute the summary. Be selective.

---

## Adding a new ingest script

Follow the pattern in `ingest/url-ingest.sh`:

**Required:**
- Self-source `ANTHROPIC_API_KEY` from crontab at the top:
  ```bash
  if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
      eval "$(crontab -l 2>/dev/null | grep 'ANTHROPIC_API_KEY' | sed 's/^/export /')"
  fi
  [[ -n "${ANTHROPIC_API_KEY:-}" ]] || { echo "ERROR: ANTHROPIC_API_KEY not set." >&2; exit 1; }
  ```
- `set -euo pipefail` at the top
- Write output to `notes/<category>/<slug>.md`
- Log to a file in `ingest/` with a consistent prefix: `[script-name YYYY-MM-DD HH:MM]`
- Python API calls: use `urllib.request` only — no `requests` library dependency

**Conventions:**
- Obsidian Markdown output: `[[wiki links]]` for tools, protocols, hosts, concepts
- Add a frontmatter `---` block or `## Tags` section at the bottom
- Include an ingestion timestamp: `_Ingested: YYYY-MM-DD HH:MM | Source: ..._`

**Add an alias** in the script's header comment and document it in `GETTING-STARTED.md`.

---

## Adding a Claude Code skill

Skills live in `.claude/commands/` and are invoked as `/skill-name` in Claude Code sessions.

Follow the pattern in `skills/challenge.md` (or any existing skill file):

```markdown
You are VIRGIL, Morpheus's second brain. [Role description].

$ARGUMENTS

---

## Step 1 — ...

## Step 2 — ...
```

Guidelines:
- Start with a clear role statement
- Use `$ARGUMENTS` to pass user input through
- Break behavior into numbered steps
- Reference concrete file paths — don't say "read the config", say `Read memory-working.md`
- Keep it tight — Claude reads the whole file on every invocation

If your skill makes assumptions about vault structure (specific directories, specific note names), document them clearly at the top.

---

## Submitting improvements via PR

Keep PRs focused. One logical change per PR.

PR description should answer:
- What does this change do?
- What did you test it against? (OS, vault structure, API response)
- Does it add new dependencies? If yes, why is that acceptable?

If you're fixing a bug, include the error output or behavior that prompted the fix.

---

## Code style

**Bash:**
- `set -euo pipefail` always
- Self-source `ANTHROPIC_API_KEY` from crontab (never hardcode, never require env to be pre-set)
- Quote all variables: `"$VAR"` not `$VAR`
- Use `mktemp` for temp files, clean up with `trap "rm -f $_TMP" EXIT`
- Prefer `printf` over `echo` for formatted output

**Python (embedded or standalone):**
- `urllib.request` and `urllib.error` only — no `requests`, no `httpx`
- `json`, `os`, `sys`, `pathlib` from stdlib only
- No third-party dependencies whatsoever — this runs on minimal lab machines
- Strip Claude's markdown code fences before parsing JSON responses (Claude sometimes wraps output in ```json)

**Markdown output:**
- `[[wiki links]]` for all tools, protocols, hosts, concepts
- Consistent heading structure: `#` title, `##` sections, `###` subsections
- Tags at the bottom in a `## Tags` section

---

## What's not in scope

- GUI tools or web UIs — VIRGIL is terminal-first
- Cloud-specific integrations (AWS, GCP, Azure) — this is a homelab system
- Features that require a running Obsidian instance — output is plain Markdown files
- Anything that phones home or sends data to third parties beyond the Anthropic API
