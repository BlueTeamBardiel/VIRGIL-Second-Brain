#!/bin/bash
# weekly-rollup.sh — Sunday 1am digest of the past 7 daily logs
# Calls Claude API to produce a weekly summary, writes to weekly-summaries/,
# and posts to Slack. Runs before promote.sh (1am vs 2am).

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
DAILY_LOGS_DIR="$VIRGIL_DIR/daily-logs"
SUMMARIES_DIR="$VIRGIL_DIR/weekly-summaries"
WEEK_LABEL=$(date +%G-W%V)          # e.g. 2026-W14
OUTPUT_FILE="$SUMMARIES_DIR/$WEEK_LABEL.md"
LOGPREFIX="[weekly-rollup.sh $WEEK_LABEL]"

# ── Slack helper ──────────────────────────────────────────────────────────────
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

# ── 1. Require API key ────────────────────────────────────────────────────────
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    echo "$LOGPREFIX ANTHROPIC_API_KEY is not set. Aborting." >&2
    exit 1
fi

# ── 2. Skip if already rolled up this week ───────────────────────────────────
if [[ -f "$OUTPUT_FILE" ]]; then
    echo "$LOGPREFIX $OUTPUT_FILE already exists. Skipping."
    exit 0
fi

# ── 3. Collect daily logs from the past 7 days ───────────────────────────────
COMBINED=""
LOG_DATES=()

for i in 6 5 4 3 2 1 0; do
    LOG_DATE=$(date -d "$i days ago" +%Y-%m-%d)
    LOG_PATH="$DAILY_LOGS_DIR/$LOG_DATE.md"
    if [[ -f "$LOG_PATH" ]]; then
        COMBINED+="=== $LOG_DATE ===
$(cat "$LOG_PATH")

"
        LOG_DATES+=("$LOG_DATE")
    fi
done

if [[ -z "$COMBINED" ]]; then
    echo "$LOGPREFIX No daily logs found for the past 7 days. Skipping."
    slack_notify "VIRGIL [$WEEK_LABEL] Weekly rollup skipped — no daily logs found for this week."
    exit 0
fi

echo "$LOGPREFIX Found logs: ${LOG_DATES[*]}"

# ── 3b. Collect feed digests from the past 7 days ────────────────────────────
FEEDS_DIR="$VIRGIL_DIR/notes/feeds"
FEED_COMBINED=""

for i in 6 5 4 3 2 1 0; do
    FEED_DATE=$(date -d "$i days ago" +%Y-%m-%d)
    FEED_PATH="$FEEDS_DIR/$FEED_DATE.md"
    if [[ -f "$FEED_PATH" ]]; then
        FEED_COMBINED+="=== Feed Digest $FEED_DATE ===
$(head -100 "$FEED_PATH")

"
    fi
done

# ── 3c. Collect personal study logs from the past 7 days ─────────────────────
STUDY_DIR="$VIRGIL_DIR/notes/personal/study"
STUDY_COMBINED=""

for i in 6 5 4 3 2 1 0; do
    STUDY_DATE=$(date -d "$i days ago" +%Y-%m-%d)
    STUDY_PATH="$STUDY_DIR/$STUDY_DATE.md"
    if [[ -f "$STUDY_PATH" ]]; then
        STUDY_COMBINED+="=== Study Log $STUDY_DATE ===
$(cat "$STUDY_PATH")

"
    fi
done

# ── 4. Build JSON payload ─────────────────────────────────────────────────────
# Note: pipe + heredoc on the same command causes the heredoc to win and the
# pipe to be silently dropped. Write Python to a temp file instead.
_TMPSCRIPT=$(mktemp /tmp/virgil-rollup-XXXXXX.py)
trap "rm -f $_TMPSCRIPT" EXIT

cat > "$_TMPSCRIPT" <<'PYEOF'
import json, sys

combined, feed_combined, study_combined = sys.stdin.read().split("\x00", 2)

extra_sections = ""
if feed_combined.strip():
    extra_sections += (
        "\n\n**Threat Intel / Feed Highlights:** "
        "(bullet list — notable CVEs, active exploits, or security news from the week's feed digests)\n\n"
    )
if study_combined.strip():
    extra_sections += (
        "**Cert Study Progress:** "
        "(bullet list — topics covered, weak areas identified, CySA+ domain coverage)\n\n"
    )

prompt = (
    "You are a second-brain assistant for a sysadmin/homelab operator. "
    "He runs a homelab called YOUR_LAB, is studying for CySA+, and is job searching. "
    "Synthesize the following data from the past week into a concise weekly digest.\n\n"
    "Structure the output as:\n\n"
    "## Weekly Digest\n\n"
    "**What got done:** (bullet list — completed tasks, deployments, fixes)\n\n"
    "**Decisions made:** (bullet list — architectural or process decisions)\n\n"
    "**Lessons learned:** (bullet list — things that didn't work, root causes found)\n\n"
    + extra_sections +
    "**Still in flight:** (bullet list — things started but not finished)\n\n"
    "**Next week:** (bullet list — highest priority items to tackle next)\n\n"
    "Rules:\n"
    "- Omit sections with nothing meaningful to report.\n"
    "- Be concise. No filler. No preamble.\n"
    "- If no extractable information exists, reply with exactly: SKIP\n\n"
    "=== DAILY LOGS ===\n\n" + combined +
    ("\n\n=== FEED DIGESTS ===\n\n" + feed_combined[:6000] if feed_combined.strip() else "") +
    ("\n\n=== STUDY LOGS ===\n\n" + study_combined if study_combined.strip() else "")
)

payload = {
    "model": "claude-haiku-4-5-20251001",
    "max_tokens": 2048,
    "messages": [{"role": "user", "content": prompt}]
}

print(json.dumps(payload))
PYEOF

PAYLOAD=$(printf '%s\x00%s\x00%s' "$COMBINED" "$FEED_COMBINED" "$STUDY_COMBINED" | python3 "$_TMPSCRIPT")

# ── 5. Call Claude API ────────────────────────────────────────────────────────
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

# ── 6. Extract digest text ────────────────────────────────────────────────────
DIGEST=$(python3 -c "
import json, sys
body = json.loads(sys.stdin.read())
print(body['content'][0]['text'])
" <<< "$BODY")

if [[ -z "$DIGEST" || "$DIGEST" == "SKIP" ]]; then
    echo "$LOGPREFIX Claude found nothing to summarize. Skipping."
    slack_notify "VIRGIL [$WEEK_LABEL] Weekly rollup skipped — Claude found nothing extractable."
    exit 0
fi

# ── 7. Write summary file ─────────────────────────────────────────────────────
mkdir -p "$SUMMARIES_DIR"
{
    printf '# %s — Weekly Digest\n' "$WEEK_LABEL"
    printf '_Generated: %s | Logs: %s_\n\n' "$(date '+%Y-%m-%d %H:%M')" "${LOG_DATES[*]}"
    printf '%s\n' "$DIGEST"
} > "$OUTPUT_FILE"

echo "$LOGPREFIX Written to $OUTPUT_FILE"

# ── 8. Append orphan report to digest file ───────────────────────────────────
if [[ -x "$VIRGIL_DIR/ingest/orphan-detect.sh" ]]; then
    ORPHAN_REPORT=$(bash "$VIRGIL_DIR/ingest/orphan-detect.sh" --quiet 2>/dev/null || true)
    if [[ -n "$ORPHAN_REPORT" ]]; then
        printf '\n---\n\n%s\n' "$ORPHAN_REPORT" >> "$OUTPUT_FILE"
        echo "$LOGPREFIX Orphan report appended to $OUTPUT_FILE"
    fi
fi

# ── 9. Post to Slack ──────────────────────────────────────────────────────────
slack_notify "VIRGIL [$WEEK_LABEL] Weekly digest ready.

$DIGEST"

echo "$LOGPREFIX Done."
