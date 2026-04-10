#!/bin/bash
# auto-reflect.sh — End-of-day auto-fill for unfilled daily log summaries
#
# Schedule (crontab):
#   55 23 * * *   11:55pm daily — fills any remaining placeholders before promote.sh at 2am
#
# Behaviour:
#   - Exits silently if no log exists for today
#   - Exits silently if no <!-- fill in manually --> placeholders remain
#   - For each unfilled placeholder: calls Claude haiku to generate a brief summary
#     from the surrounding session metadata and any External Project Sync entries
#   - Posts Slack notification when auto-fill runs
#   - Never blocks on Slack failure

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$VIRGIL_DIR/daily-logs/$TODAY.md"
LOGPREFIX="[auto-reflect $TODAY]"
HOSTNAME_SHORT=$(hostname -s)

log() { echo "$LOGPREFIX $*" >&2; }

# ── Silent exits ──────────────────────────────────────────────────────────────
[[ -f "$LOG_FILE" ]]                          || exit 0
grep -q '<!-- fill in manually -->' "$LOG_FILE" || exit 0
[[ -n "${ANTHROPIC_API_KEY:-}" ]]             || { log "ANTHROPIC_API_KEY not set — skipping"; exit 0; }

# ── Slack helper ──────────────────────────────────────────────────────────────
slack_notify() {
    [[ -z "${SLACK_WEBHOOK_URL:-}" ]] && return 0
    local payload
    payload=$(python3 -c "import json,sys; print(json.dumps({'text': sys.argv[1]}))" "$1")
    curl -s -o /dev/null --max-time 10 \
        -X POST "$SLACK_WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$payload" || true
}

# ── Count placeholders ────────────────────────────────────────────────────────
PLACEHOLDER_COUNT=$(grep -c '<!-- fill in manually -->' "$LOG_FILE" || true)
log "Found $PLACEHOLDER_COUNT unfilled placeholder(s)"

# ── Extract full log for context ──────────────────────────────────────────────
LOG_CONTENT=$(cat "$LOG_FILE")

# ── Python: fill each placeholder via Claude API ─────────────────────────────
_TMPPY=$(mktemp /tmp/virgil-autoreflect-XXXXXX.py)
trap "rm -f $_TMPPY" EXIT

cat > "$_TMPPY" <<'PYEOF'
import json, os, re, sys, time, urllib.request, urllib.error

API_URL = "https://api.anthropic.com/v1/messages"
MODEL   = "claude-haiku-4-5-20251001"
TODAY   = os.environ["TODAY"]

def api_call(prompt):
    payload = json.dumps({
        "model": MODEL,
        "max_tokens": 512,
        "messages": [{"role": "user", "content": prompt}]
    }).encode()
    req = urllib.request.Request(API_URL, data=payload, headers={
        "x-api-key":            os.environ["ANTHROPIC_API_KEY"],
        "anthropic-version":    "2023-06-01",
        "content-type":         "application/json",
    })
    try:
        with urllib.request.urlopen(req, timeout=60) as r:
            body = json.loads(r.read())
        return body["content"][0]["text"].strip()
    except Exception as e:
        print(f"[auto-reflect-py] API error: {e}", file=sys.stderr)
        return None

def extract_session_block(text, placeholder_pos):
    """Return the ## Session ended at ... block that contains this placeholder."""
    # Walk backwards from placeholder to find the nearest session heading
    before = text[:placeholder_pos]
    session_match = list(re.finditer(r'^## Session ended at .+', before, re.MULTILINE))
    if not session_match:
        return before[-2000:]  # fallback: last 2000 chars
    start = session_match[-1].start()
    # Walk forwards to find the end of this session block (next ## heading or EOF)
    after_start = text[start:]
    end_match = re.search(r'\n## ', after_start[10:])  # skip the heading itself
    end = start + 10 + end_match.start() if end_match else len(text)
    return text[start:end]

def extract_project_syncs(text):
    """Pull all External Project Sync entries from the log."""
    m = re.search(r'## External Project Sync(.+?)(?=\n## Session ended|\Z)', text, re.DOTALL)
    return m.group(1).strip() if m else ""

text = sys.stdin.read()
syncs = extract_project_syncs(text)
filled = 0

# Process placeholders one at a time — re-search after each replacement
while '<!-- fill in manually -->' in text:
    pos = text.index('<!-- fill in manually -->')
    session_block = extract_session_block(text, pos)

    prompt = (
        f"You are VIRGIL, a sysadmin's second brain. Today is {TODAY}.\n\n"
        f"Write a 2–3 sentence past-tense summary of what happened in this Claude Code session, "
        f"based on the session metadata below. Be factual and concise — infer from the git branch, "
        f"file counts, and any project sync entries. If nothing meaningful happened, write: "
        f"'Session opened and closed with no significant activity.'\n\n"
        f"Apply [[wiki links]] to COCYTUS hosts, tools, and concepts (e.g. [[VIRGIL]], [[BEHEMOTH]], [[Ansible]]).\n\n"
        f"Session block:\n{session_block}\n\n"
    )
    if syncs:
        prompt += f"Project sync context (from today's log):\n{syncs}\n\n"
    prompt += "Write only the summary text — no preamble, no labels."

    summary = api_call(prompt)
    if summary is None:
        summary = f"Auto-reflect ran but Claude API was unavailable — session metadata in the block above."

    text = text.replace('<!-- fill in manually -->', summary, 1)
    filled += 1
    if '<!-- fill in manually -->' in text:
        time.sleep(0.6)  # rate-limit between calls

# Write updated log
log_path = os.environ["LOG_FILE"]
with open(log_path, "w", encoding="utf-8") as f:
    f.write(text)

print(filled)
PYEOF

FILLED=$(LOG_FILE="$LOG_FILE" TODAY="$TODAY" \
    python3 "$_TMPPY" <<< "$LOG_CONTENT" \
    2> >(while IFS= read -r line; do log "$line"; done))

log "Auto-filled $FILLED placeholder(s) in $LOG_FILE"

slack_notify "VIRGIL [$TODAY] auto-reflect on $HOSTNAME_SHORT: filled $FILLED summary placeholder(s) in today's log."
