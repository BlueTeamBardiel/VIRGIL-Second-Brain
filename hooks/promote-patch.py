#!/usr/bin/env python3
"""
promote-patch.py — Three-layer memory router for VIRGIL's nightly promotion.

Called by promote.sh as:
    python3 hooks/promote-patch.py <log_file> <vault_path>

Reads today's log + current semantic memory, calls Claude Haiku, and routes
structured updates to the three memory layer files:
    memory-working.md  — task/status updates
    memory-episodic.md — new promoted entry
    memory-semantic.md — supersede or add permanent facts

Superseded facts written as:
    ~~old fact~~ superseded on YYYY-MM-DD → new fact
"""

import json
import os
import re
import sys
import urllib.request
import urllib.error
from datetime import date
from pathlib import Path

# ── Args ──────────────────────────────────────────────────────────────────────
if len(sys.argv) < 3:
    print(f"Usage: promote-patch.py <log_file> <vault_path>", file=sys.stderr)
    sys.exit(1)

LOG_FILE   = Path(sys.argv[1])
VAULT_PATH = Path(sys.argv[2])
TODAY      = date.today().isoformat()

WORKING_FILE  = VAULT_PATH / "memory-working.md"
EPISODIC_FILE = VAULT_PATH / "memory-episodic.md"
SEMANTIC_FILE = VAULT_PATH / "memory-semantic.md"

API_URL = "https://api.anthropic.com/v1/messages"
MODEL   = "claude-haiku-4-5-20251001"

def log(msg):
    print(f"[promote-patch] {msg}", file=sys.stderr, flush=True)

def api_call(prompt, max_tokens=2048):
    api_key = os.environ.get("ANTHROPIC_API_KEY", "")
    if not api_key:
        log("ANTHROPIC_API_KEY not set")
        sys.exit(1)
    payload = json.dumps({
        "model": MODEL,
        "max_tokens": max_tokens,
        "messages": [{"role": "user", "content": prompt}]
    }).encode()
    req = urllib.request.Request(API_URL, data=payload, headers={
        "x-api-key":         api_key,
        "anthropic-version": "2023-06-01",
        "content-type":      "application/json",
    })
    try:
        with urllib.request.urlopen(req, timeout=120) as r:
            return json.loads(r.read())
    except urllib.error.HTTPError as e:
        log(f"API HTTP {e.code}: {e.read().decode(errors='replace')[:200]}")
        sys.exit(1)
    except Exception as e:
        log(f"API error: {e}")
        sys.exit(1)

# ── Read inputs ───────────────────────────────────────────────────────────────
if not LOG_FILE.exists():
    log(f"Log file not found: {LOG_FILE}")
    sys.exit(0)

log_content = LOG_FILE.read_text(encoding='utf-8')

semantic_context = ""
if SEMANTIC_FILE.exists():
    # Send last 3000 chars of semantic memory for context (avoid token bloat)
    sem_text = SEMANTIC_FILE.read_text(encoding='utf-8')
    semantic_context = sem_text[-3000:] if len(sem_text) > 3000 else sem_text

working_context = ""
if WORKING_FILE.exists():
    wk_text = WORKING_FILE.read_text(encoding='utf-8')
    working_context = wk_text[:2000] if len(wk_text) > 2000 else wk_text

# ── Check if three-layer files exist ─────────────────────────────────────────
if not SEMANTIC_FILE.exists():
    log("memory-semantic.md not found — run migrate-memory.sh first. Skipping promote-patch.")
    sys.exit(0)

# ── Build prompt ──────────────────────────────────────────────────────────────
prompt = f"""You are VIRGIL's memory router. Today is {TODAY}.

Analyze today's daily log and produce a structured JSON update for a three-layer memory system.

=== CURRENT SEMANTIC MEMORY (permanent facts) ===
{semantic_context}

=== CURRENT WORKING MEMORY (active tasks) ===
{working_context}

=== TODAY'S DAILY LOG ===
{log_content}

=== YOUR TASK ===

Produce a JSON object with these four keys:

1. "episodic_entry" (string): A concise dated entry for the episodic log.
   Format as markdown: "## Promoted — {TODAY}\\n\\n**Key Events:**\\n- ...\\n\\n**Completed:**\\n- ..."
   Include only concrete facts from today's log. Omit if nothing meaningful happened (return empty string).

2. "working_updates" (list of objects): Changes to apply to memory-working.md.
   Each object: {{"action": "complete"|"add"|"remove", "task_text": "exact task text"}}
   - "complete": mark a pending task as done (only if clearly evidenced)
   - "add": add a new pending task discovered in the log
   - "remove": remove a task that's no longer relevant
   Return empty list if no changes.

3. "semantic_updates" (list of objects): Facts to add or supersede in memory-semantic.md.
   Each object: {{"type": "new"|"supersede", "section": "section heading to place under",
                  "old_fact": "exact text to supersede (only for type=supersede)",
                  "new_fact": "the new fact to add"}}
   For supersede: the old_fact will be wrapped in ~~strikethrough~~ with a date note.
   Only include genuinely new or changed facts — do not re-state existing facts.
   Return empty list if nothing changed.

4. "slack_summary" (string): One-line Slack-friendly summary of what was promoted.
   Example: "Promoted 2026-04-10: Phase 2.4 OpenVAS deployed on YOUR-LAB-NODE-2. 3 tasks completed."

Return ONLY valid JSON. No prose, no code fences.
"""

# ── Call API ──────────────────────────────────────────────────────────────────
log("Calling Claude Haiku for three-layer routing...")
body = api_call(prompt, max_tokens=2048)
raw = body["content"][0]["text"].strip()

# Strip code fences if present
if raw.startswith("```"):
    raw = "\n".join(raw.splitlines()[1:])
    if raw.endswith("```"):
        raw = raw[:-3].rstrip()

try:
    result = json.loads(raw)
except json.JSONDecodeError as e:
    log(f"JSON parse error: {e} — raw: {raw[:300]}")
    sys.exit(1)

# ── Apply episodic entry ──────────────────────────────────────────────────────
episodic_entry = result.get("episodic_entry", "").strip()
if episodic_entry and EPISODIC_FILE.exists():
    existing = EPISODIC_FILE.read_text(encoding='utf-8')
    # Skip if already promoted today
    if f"## Promoted — {TODAY}" not in existing:
        EPISODIC_FILE.write_text(existing.rstrip() + f"\n\n{episodic_entry}\n", encoding='utf-8')
        log("Episodic entry written")
    else:
        log("Episodic: already promoted today, skipping")

# ── Apply working updates ─────────────────────────────────────────────────────
working_updates = result.get("working_updates", [])
if working_updates and WORKING_FILE.exists():
    wtext = WORKING_FILE.read_text(encoding='utf-8')
    changed = 0
    for update in working_updates:
        action    = update.get("action", "")
        task_text = update.get("task_text", "").strip()
        if not task_text:
            continue
        if action == "complete":
            # Mark [ ] → [x] with date
            pattern = re.compile(
                r'^(\s*-\s*)\[ \](\s*' + re.escape(task_text[:50]) + r')',
                re.MULTILINE
            )
            new_wtext = pattern.sub(
                lambda m: m.group(1) + '[x]' + m.group(2) + f' — completed {TODAY}',
                wtext, count=1
            )
            if new_wtext != wtext:
                wtext = new_wtext
                changed += 1
                log(f"Working: marked complete — {task_text[:60]}")
        elif action == "add":
            # Append to first High Priority section or end of file
            insert_marker = "## 🔴 High Priority Pending Tasks"
            if insert_marker in wtext:
                # Insert after the header line
                idx = wtext.find(insert_marker) + len(insert_marker)
                newline_idx = wtext.find('\n', idx)
                insert_pos = newline_idx + 1 if newline_idx != -1 else len(wtext)
                wtext = wtext[:insert_pos] + f"\n- [ ] {task_text}\n" + wtext[insert_pos:]
            else:
                wtext = wtext.rstrip() + f"\n\n- [ ] {task_text}\n"
            changed += 1
            log(f"Working: added task — {task_text[:60]}")
        elif action == "remove":
            # Remove the line
            pattern = re.compile(
                r'^\s*-\s*\[[ x]\]\s*' + re.escape(task_text[:50]) + r'.*\n?',
                re.MULTILINE
            )
            new_wtext = pattern.sub('', wtext, count=1)
            if new_wtext != wtext:
                wtext = new_wtext
                changed += 1
                log(f"Working: removed — {task_text[:60]}")
    if changed:
        WORKING_FILE.write_text(wtext, encoding='utf-8')
        log(f"Working memory: {changed} update(s) applied")

# ── Apply semantic updates ────────────────────────────────────────────────────
semantic_updates = result.get("semantic_updates", [])
if semantic_updates and SEMANTIC_FILE.exists():
    stext = SEMANTIC_FILE.read_text(encoding='utf-8')
    changed = 0
    for update in semantic_updates:
        utype    = update.get("type", "new")
        section  = update.get("section", "").strip()
        new_fact = update.get("new_fact", "").strip()
        old_fact = update.get("old_fact", "").strip()

        if not new_fact:
            continue

        if utype == "supersede" and old_fact:
            # Wrap old fact in strikethrough
            superseded = f"~~{old_fact}~~ superseded on {TODAY} → {new_fact}"
            if old_fact in stext:
                stext = stext.replace(old_fact, superseded, 1)
                changed += 1
                log(f"Semantic: superseded — {old_fact[:50]}")
            else:
                # Old fact not found — just add the new one
                log(f"Semantic: old fact not found, adding new — {new_fact[:50]}")
                utype = "new"

        if utype == "new":
            # Find section header and append after it
            if section and section in stext:
                idx = stext.find(section) + len(section)
                newline_idx = stext.find('\n', idx)
                insert_pos = newline_idx + 1 if newline_idx != -1 else len(stext)
                stext = stext[:insert_pos] + f"- {new_fact}\n" + stext[insert_pos:]
            else:
                stext = stext.rstrip() + f"\n- {new_fact}\n"
            changed += 1
            log(f"Semantic: added — {new_fact[:60]}")

    if changed:
        SEMANTIC_FILE.write_text(stext, encoding='utf-8')
        log(f"Semantic memory: {changed} update(s) applied")

# ── Output slack summary ──────────────────────────────────────────────────────
slack_summary = result.get("slack_summary", "").strip()
if slack_summary:
    print(slack_summary)
    log(f"Slack summary: {slack_summary}")
