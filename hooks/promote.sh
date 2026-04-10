#!/bin/bash
# promote.sh — nightly promotion of VIRGIL daily log to memory.md
# Calls Claude API to extract key decisions, lessons learned, and facts.
# Also diffs completed tasks against memory.md pending list and moves them.
# Sends a Slack notification after promotion (or skip). Fails silently on Slack errors.

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
DAILY_LOGS_DIR="$VIRGIL_DIR/daily-logs"
MEMORY_FILE="$VIRGIL_DIR/memory.md"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$DAILY_LOGS_DIR/$TODAY.md"
LOGPREFIX="[promote.sh $TODAY]"

# ── Slack helper — never lets a failure propagate ─────────────────────────────
slack_notify() {
    local message="$1"
    if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
        return 0
    fi
    local payload
    payload=$(python3 -c "import json,sys; print(json.dumps({'text': sys.argv[1]}))" "$message")
    curl -s -o /dev/null --max-time 10 \
        -X POST "$SLACK_WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$payload" || true
}

# ── 1. Log must exist ──────────────────────────────────────────────────────────
if [[ ! -f "$LOG_FILE" ]]; then
    echo "$LOGPREFIX No daily log found. Skipping."
    exit 0
fi

# ── 2. Skip if log is empty or placeholder-only ────────────────────────────────
MEANINGFUL=$(grep -v '^\s*$'            "$LOG_FILE" \
    | grep -v '<!--.*-->'               \
    | grep -v '^#'                      \
    | grep -v '^---'                    \
    | grep -v '^\s*##\s*Session ended'  \
    | grep -v '^\s*###\s*Summary'       \
    | grep -v '^\s*-\s*Working directory:' \
    | grep -v '^\s*-\s*Git branch:'     \
    | grep -v '^\s*-\s*Files modified'  \
    | grep -v '^\s*-\s*n/a\s*$'        \
    || true)

if [[ -z "$MEANINGFUL" ]]; then
    echo "$LOGPREFIX Log is empty or placeholder only. Skipping."
    slack_notify "VIRGIL [$TODAY] Promotion skipped — daily log was empty or placeholder only."
    exit 0
fi

# ── 3. Skip if already promoted today ─────────────────────────────────────────
if grep -q "^## Promoted — $TODAY" "$MEMORY_FILE" 2>/dev/null; then
    echo "$LOGPREFIX Already promoted today. Skipping."
    slack_notify "VIRGIL [$TODAY] Promotion skipped — already ran today."
    exit 0
fi

# ── 4. Require API key ────────────────────────────────────────────────────────
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    echo "$LOGPREFIX ANTHROPIC_API_KEY is not set. Aborting." >&2
    exit 1
fi

# ── 5. Extract current High+Medium pending tasks from memory.md ───────────────
# Used to give Claude context for the completed-task diff.
PENDING_TASKS=$(python3 -c "
import sys, re

text = open('$MEMORY_FILE', encoding='utf-8').read()

# Extract High and Medium priority sections
sections = []
for header in ['## 🔴 High Priority Pending Tasks', '## 🟡 Medium Priority Pending Tasks']:
    m = re.search(re.escape(header) + r'(.*?)(?=\n## |\Z)', text, re.DOTALL)
    if m:
        sections.append(m.group(0).strip())

print('\n\n'.join(sections) if sections else 'No pending tasks found.')
" 2>/dev/null || echo "Could not read pending tasks.")

# ── 6. Build JSON payload via Python ──────────────────────────────────────────
LOG_CONTENT=$(cat "$LOG_FILE")
_TMPSCRIPT=$(mktemp /tmp/virgil-promote-XXXXXX.py)
trap "rm -f $_TMPSCRIPT" EXIT

cat > "$_TMPSCRIPT" <<'PYEOF'
import json, sys

log = sys.stdin.read()

# Read pending tasks passed via environment
import os
pending = os.environ.get('PENDING_TASKS', '')

prompt = (
    "You are a second-brain assistant for a sysadmin/homelab operator. "
    "Process the following daily log and produce TWO sections of output.\n\n"

    "=== SECTION 1: PROMOTION CONTENT ===\n"
    "Extract and summarize into three subsections:\n\n"
    "**Key Decisions:** (bullet list of decisions made)\n"
    "**Lessons Learned:** (bullet list of lessons or insights)\n"
    "**Important Facts:** (bullet list of notable facts, changes, or observations)\n\n"
    "Rules for Section 1:\n"
    "- Omit any subsection that has nothing meaningful to report.\n"
    "- Be concise. No filler. No preamble.\n"
    "- If the log contains no extractable information, write: SKIP\n\n"

    "=== SECTION 2: COMPLETED TASKS ===\n"
    "Review the pending tasks list below against the daily log.\n"
    "List ONLY tasks that are CLEARLY AND DEFINITIVELY completed based on log evidence.\n"
    "Be conservative — if you're not sure, omit it.\n"
    "Format: one task per line, starting with '- COMPLETED: ' followed by the exact task text "
    "from the pending list (copy it exactly).\n"
    "If no tasks are clearly completed, write: NONE\n\n"

    "=== PENDING TASKS (for reference) ===\n"
    + pending + "\n\n"

    "=== DAILY LOG ===\n"
    + log + "\n\n"

    "Now produce your output. Start Section 1 with the line: PROMOTION:\n"
    "Start Section 2 with the line: COMPLETED_TASKS:\n"
)

payload = {
    "model": "claude-haiku-4-5-20251001",
    "max_tokens": 2048,
    "messages": [{"role": "user", "content": prompt}]
}

print(json.dumps(payload))
PYEOF

PAYLOAD=$(PENDING_TASKS="$PENDING_TASKS" LOG_CONTENT="$LOG_CONTENT" \
    bash -c 'echo "$LOG_CONTENT" | python3 '"$_TMPSCRIPT")

# ── 7. Call the Claude API ────────────────────────────────────────────────────
RESPONSE=$(curl -s -w "\n%{http_code}" \
    https://api.anthropic.com/v1/messages \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    -d "$PAYLOAD")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n -1)

if [[ "$HTTP_CODE" != "200" ]]; then
    echo "$LOGPREFIX API call failed (HTTP $HTTP_CODE): $BODY" >&2
    exit 1
fi

# ── 8. Parse response — split into promotion content and completed tasks ───────
_PARSE_SCRIPT=$(mktemp /tmp/virgil-parse-XXXXXX.py)
trap "rm -f $_TMPSCRIPT $_PARSE_SCRIPT" EXIT

cat > "$_PARSE_SCRIPT" <<'PYEOF'
import json, sys, re

body = json.loads(sys.stdin.read())
text = body['content'][0]['text']

# Split on section markers
promotion = ''
completed = []

promo_match = re.search(r'PROMOTION:\s*(.*?)(?=COMPLETED_TASKS:|$)', text, re.DOTALL | re.IGNORECASE)
comp_match  = re.search(r'COMPLETED_TASKS:\s*(.*?)$', text, re.DOTALL | re.IGNORECASE)

if promo_match:
    promotion = promo_match.group(1).strip()
    if promotion.upper() == 'SKIP':
        promotion = ''

if comp_match:
    comp_text = comp_match.group(1).strip()
    if comp_text.upper() != 'NONE':
        for line in comp_text.splitlines():
            line = line.strip()
            if line.startswith('- COMPLETED:'):
                task = line[len('- COMPLETED:'):].strip()
                if task:
                    completed.append(task)

result = {
    'promotion': promotion,
    'completed': completed
}
print(json.dumps(result))
PYEOF

PARSED=$(python3 "$_PARSE_SCRIPT" <<< "$BODY")

PROMOTION=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(d['promotion'])" <<< "$PARSED")
COMPLETED_JSON=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(json.dumps(d['completed']))" <<< "$PARSED")
COMPLETED_COUNT=$(python3 -c "import json,sys; print(len(json.loads(sys.stdin.read())))" <<< "$COMPLETED_JSON")

# ── 9. Process completed tasks — move from pending to completed in memory.md ──
if [[ "$COMPLETED_COUNT" -gt 0 ]]; then
    echo "$LOGPREFIX Moving $COMPLETED_COUNT completed task(s) in memory.md"

    MEMORY_FILE="$MEMORY_FILE" \
    COMPLETED_JSON="$COMPLETED_JSON" \
    TODAY="$TODAY" \
    python3 - <<'PYEOF'
import json, re, sys, os
from pathlib import Path

memory_path = Path(os.environ['MEMORY_FILE'])
text = memory_path.read_text(encoding='utf-8')
completed_tasks = json.loads(os.environ['COMPLETED_JSON'])
moved = []
today = os.environ['TODAY']

for task_text in completed_tasks:
    # Match the task line — look for "- [ ] **text**" or "- [ ] text" patterns
    # Try to find the line containing the task text (fuzzy: first 60 chars of task)
    search_fragment = re.escape(task_text[:60].strip())
    pattern = re.compile(
        r'^(\s*-\s*)\[ \](\s*' + search_fragment + r'.*?)$',
        re.MULTILINE
    )
    match = pattern.search(text)
    if match:
        # Mark as complete with date
        completed_line = match.group(1) + '[x]' + match.group(2) + f' — completed {today}'
        text = text[:match.start()] + completed_line + text[match.end():]
        moved.append(task_text)
        print(f'  Marked complete: {task_text[:80]}')
    else:
        print(f'  Could not match in memory.md: {task_text[:80]}', file=sys.stderr)

if not moved:
    sys.exit(0)

# Ensure ## ✅ Completed Tasks section exists
if '## ✅ Completed Tasks' not in text:
    # Add before the last ## section or at end
    insert_marker = '\n## ✅ Completed Tasks\n\n'
    # Try to insert after the Low Priority section
    low_match = re.search(r'(## 🟢 Low Priority Pending Tasks.*?)(\n## )', text, re.DOTALL)
    if low_match:
        pos = low_match.end(1)
        text = text[:pos] + insert_marker + text[pos:]
    else:
        text = text.rstrip() + insert_marker

# Move completed [x] lines from priority sections to Completed Tasks section
# Find all completed lines in priority sections
completed_section_header = '## ✅ Completed Tasks'
completed_pattern = re.compile(r'^(\s*-\s*\[x\].*?— completed \d{4}-\d{2}-\d{2}.*)$', re.MULTILINE)

lines_to_move = completed_pattern.findall(text)
if lines_to_move:
    # Remove them from priority sections
    for line in lines_to_move:
        text = text.replace(line + '\n', '', 1)

    # Append to Completed Tasks section
    completed_pos = text.find(completed_section_header)
    if completed_pos != -1:
        insert_pos = completed_pos + len(completed_section_header)
        # Skip to end of section header line
        newline_pos = text.find('\n', insert_pos)
        if newline_pos != -1:
            insert_pos = newline_pos + 1
        entries = '\n'.join(lines_to_move) + '\n'
        text = text[:insert_pos] + entries + text[insert_pos:]

memory_path.write_text(text, encoding='utf-8')
print(f'  memory.md updated — {len(moved)} task(s) moved to Completed Tasks')
PYEOF
fi

# ── 10. Append promotion content to memory.md ────────────────────────────────
if [[ -z "$PROMOTION" ]]; then
    echo "$LOGPREFIX Claude found nothing to promote. Skipping promotion."
    if [[ "$COMPLETED_COUNT" -gt 0 ]]; then
        slack_notify "VIRGIL [$TODAY] No promotion content, but $COMPLETED_COUNT task(s) marked complete in memory.md."
    else
        slack_notify "VIRGIL [$TODAY] Promotion skipped — Claude found nothing extractable in the log."
    fi
    exit 0
fi

{
    printf '\n## Promoted — %s\n\n' "$TODAY"
    printf '%s\n' "$PROMOTION"
} >> "$MEMORY_FILE"

echo "$LOGPREFIX Promotion written to memory.md."

# ── 11. Notify Slack ───────────────────────────────────────────────────────────
TASK_NOTE=""
if [[ "$COMPLETED_COUNT" -gt 0 ]]; then
    TASK_NOTE=" | $COMPLETED_COUNT task(s) marked complete."
fi

slack_notify "VIRGIL [$TODAY] Promotion complete.${TASK_NOTE}

$PROMOTION"

# ── 12. Route to three-layer memory (promote-patch.py) ───────────────────────
if [[ -f "$VIRGIL_DIR/hooks/promote-patch.py" ]] && \
   [[ -f "$VIRGIL_DIR/memory-semantic.md" ]]; then
    PATCH_SUMMARY=$(python3 "$VIRGIL_DIR/hooks/promote-patch.py" "$LOG_FILE" "$VIRGIL_DIR" \
        2> >(while IFS= read -r line; do echo "$LOGPREFIX [promote-patch] $line"; done) || true)
    if [[ -n "$PATCH_SUMMARY" ]]; then
        echo "$LOGPREFIX Three-layer update: $PATCH_SUMMARY"
    fi
fi

