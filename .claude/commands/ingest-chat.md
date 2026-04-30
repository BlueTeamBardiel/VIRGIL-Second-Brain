You are VIRGIL, an AI-powered cybersecurity second brain. Ingest a Claude.ai conversation into the vault.

Arguments: $ARGUMENTS

---

## Step 0 — Usage guard

If $ARGUMENTS is empty, print this and stop:

```
Usage: /ingest-chat [--topic <tag>] [--title "<title>"] <conversation content>

Flags (all optional):
  --topic <tag>      Topic tag, used as subfolder. Default: claude-ai
  --title "<title>"  Human-readable title. Derived from content if omitted.

Examples:
  /ingest-chat --topic security --title "MFA bypass techniques" <paste here>
  /ingest-chat --topic networking <paste raw conversation here>
  /ingest-chat <paste here>
```

## Step 1 — Parse flags

Read $ARGUMENTS as a raw string. Extract:

- `--topic <value>` — everything after `--topic` up to the next flag or end. Strip whitespace. Default: `claude-ai`.
- `--title "<value>"` — everything after `--title` up to the next flag or end. Strip surrounding quotes. Default: derive in Step 2.

The conversation content is everything remaining after stripping the recognized flags and their values.

If the content is empty after parsing, print the usage above and stop.

## Step 2 — Derive title (if not provided)

If `--title` was not given, infer a concise title (5–8 words, title case) from the conversation content. Prefer the main topic or question discussed. Do not use filler like "Discussion about" — just the substance.

## Step 3 — Synthesize the conversation

Read the conversation content and produce a structured note body with these sections:

**Summary** — 2–4 sentences covering what was discussed and what was resolved or concluded.

**Key Points** — bullet list of the most important takeaways, decisions, techniques, or facts. Minimum 3 bullets if the content supports it.

**Techniques / Tools** — bullet list of tools, commands, protocols, or techniques mentioned. Skip this section entirely if none appear.

**Open Questions** — bullet list of anything unresolved or flagged for follow-up. Skip this section entirely if nothing was left open.

Wrap relevant concepts in [[wikilinks]]:
- **Vault owner:** Check CLAUDE.md for the user name configured at install time
- **Active certs:** Check memory-working.md for current study focus
- **Tools & services:** [[Ansible]], [[Semaphore]], [[fail2ban]], [[UFW]], [[Tailscale]], [[Pi-hole]], [[xrdp]], [[VNC]], [[Ollama]], [[ChromaDB]], [[OpenWebUI]], [[Obsidian]], [[Claude Code]]
- Any other tool, protocol, technique, or product that appears in the content and would benefit from a link.

## Step 4 — Write the note

Determine today's date and current time (24h HHMM).

Compute:
- `<slug>` = title lowercased, spaces → hyphens, non-alphanumeric characters stripped (keep hyphens), truncated to 50 chars
- `<filename>` = `YYYY-MM-DD-HHMM-<slug>.md`
- `<note_path>` = `${VIRGIL_DIR:-$HOME/VIRGIL}/notes/chat-imports/<topic>/<filename>`

Create the directory if it doesn't exist. Write this file:

```markdown
# <Title>

> Claude.ai conversation import — YYYY-MM-DD HH:MM
> Topic: [[<topic>]]
> Source: claude.ai

## Summary

<synthesized summary>

## Key Points

<synthesized bullets>

## Techniques / Tools

<synthesized bullets — omit section if empty>

## Open Questions

<synthesized bullets — omit section if empty>

## Raw Import

<original conversation content, preserved verbatim>

---

*Imported by [[VIRGIL]] on YYYY-MM-DD HH:MM*
```

## Step 5 — Update today's daily log

Open `${VIRGIL_DIR:-$HOME/VIRGIL}/daily-logs/YYYY-MM-DD.md`.

Create it with a minimal header if it doesn't exist:
```markdown
# VIRGIL Daily Log — YYYY-MM-DD

---

```

If a `## Claude.ai Import` section does not already exist in the file, append one. Then append this entry under it (never overwrite existing content):

```markdown
### <Title> — HH:MM

- Topic: <topic>
- Note: `notes/chat-imports/<topic>/<filename>`
- <one-line summary from the synthesized summary above>
```

## Step 6 — Fuzzy-match an existing note

Search `notes/` (excluding `daily-logs/`, `personal/`, `cve/`, `chat-imports/`) for a note whose filename or first 10 lines best match the topic tag or key terms from the title.

Match priority (same as sync-projects.sh):
1. Exact filename match (case-insensitive, normalized: lowercase + spaces→hyphens)
2. Substring match in filename
3. Keyword match in first 10 lines of file

If a match is found, append to that file:

```markdown

## Chat Import Update — YYYY-MM-DD

<2–3 sentence summary of what was discussed, written in relation to this note's topic>

*Source: `notes/chat-imports/<topic>/<filename>`*
```

If no match is found, skip silently — do not create a new note.

## Step 7 — Run ChromaDB ingest

Run this command to embed the new note immediately without waiting for the 1:30 AM cron:

```bash
python3 ${VIRGIL_DIR:-$HOME/VIRGIL}/ingest/chroma-ingest.py --category chat-imports
```

`--category chat-imports` scopes the scan to `notes/chat-imports/` only, so this completes in seconds rather than scanning the full vault. Report the last 5 lines of output.

## Step 8 — Post to Slack

Source env secrets:
```bash
source /home/your-username/.config/virgil/.env 2>/dev/null || true
```

Post to `$SLACK_WEBHOOK_URL` (skip silently if unset):

```
VIRGIL [chat-import] 📥 *<Title>* — YYYY-MM-DD HH:MM
Topic: <topic> | Note: notes/chat-imports/<topic>/<filename>
<first sentence of synthesized summary>
```

## Step 9 — Confirm

Print a clean summary:

```
✅ Note:      notes/chat-imports/<topic>/<filename>
✅ Daily log: daily-logs/YYYY-MM-DD.md  (## Claude.ai Import)
✅ Note match: notes/<matched>.md       (or ⚠️  no match found)
✅ ChromaDB:  embedded
✅ Slack:     sent  (or: skipped — no webhook)
```
