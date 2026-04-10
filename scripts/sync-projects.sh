#!/bin/bash
# sync-projects.sh — Feed external project progress into VIRGIL
#
# Usage:
#   sync-projects.sh "<ProjectName>" "<Summary of what was done>"
#
# Examples:
#   sync-projects.sh "LOGOS" "Built docker-status schema, portainer-launcher schema."
#   sync-projects.sh "COCYTUS Phase 2" "Deployed Docker on XAPHAN. Portainer running."
#
# What it does:
#   1. Appends a timestamped entry to today's daily log (## External Project Sync)
#   2. Finds the relevant note in notes/ (fuzzy match on project name)
#   3. Appends a ### Update — YYYY-MM-DD section to the note
#   4. Greps memory.md for tasks matching the project and prints any that look done
#   5. Posts to Slack

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
DAILY_LOGS_DIR="$VIRGIL_DIR/daily-logs"
NOTES_DIR="$VIRGIL_DIR/notes"
MEMORY_FILE="$VIRGIL_DIR/memory.md"
TODAY=$(date +%Y-%m-%d)
NOW=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="$DAILY_LOGS_DIR/$TODAY.md"

# ── Usage ──────────────────────────────────────────────────────────────────────
if [[ $# -lt 2 ]]; then
    echo "Usage: sync-projects.sh \"<ProjectName>\" \"<Summary>\""
    echo ""
    echo "Example:"
    echo "  sync-projects.sh \"LOGOS\" \"Built docker-status schema. Portainer launcher validated.\""
    exit 1
fi

PROJECT="$1"
SUMMARY="$2"

# ── Slack helper ───────────────────────────────────────────────────────────────
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

# ── 1. Append to today's daily log ─────────────────────────────────────────────
mkdir -p "$DAILY_LOGS_DIR"

# Create the log file with a header if it doesn't exist
if [[ ! -f "$LOG_FILE" ]]; then
    echo "# Daily Log — $TODAY" > "$LOG_FILE"
    echo "" >> "$LOG_FILE"
fi

# Check if External Project Sync section already exists for today, or create it
if ! grep -q "^## External Project Sync" "$LOG_FILE" 2>/dev/null; then
    printf '\n## External Project Sync\n' >> "$LOG_FILE"
fi

printf '\n### %s — %s\n\n%s\n' "$PROJECT" "$NOW" "$SUMMARY" >> "$LOG_FILE"

echo "✅ Daily log updated: $LOG_FILE"

# ── 2. Find the project note (fuzzy match) ─────────────────────────────────────
# Normalize project name for matching: lowercase, strip spaces
PROJECT_NORMALIZED=$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
PROJECT_LOWER=$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]')

NOTE_PATH=""

# Try exact filename match first (case-insensitive)
while IFS= read -r -d '' candidate; do
    filename=$(basename "$candidate" .md | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    if [[ "$filename" == "$PROJECT_NORMALIZED" ]]; then
        NOTE_PATH="$candidate"
        break
    fi
done < <(find "$NOTES_DIR" -name "*.md" -print0 2>/dev/null)

# Fall back to substring match in filename
if [[ -z "$NOTE_PATH" ]]; then
    while IFS= read -r -d '' candidate; do
        filename=$(basename "$candidate" .md | tr '[:upper:]' '[:lower:]')
        if [[ "$filename" == *"$PROJECT_LOWER"* ]]; then
            NOTE_PATH="$candidate"
            break
        fi
    done < <(find "$NOTES_DIR" -name "*.md" -print0 2>/dev/null)
fi

# Fall back to content match — look for the project name in the first 10 lines
if [[ -z "$NOTE_PATH" ]]; then
    while IFS= read -r candidate; do
        if head -10 "$candidate" 2>/dev/null | grep -qi "$PROJECT"; then
            NOTE_PATH="$candidate"
            break
        fi
    done < <(find "$NOTES_DIR" -name "*.md" 2>/dev/null)
fi

if [[ -n "$NOTE_PATH" ]]; then
    NOTE_NAME=$(basename "$NOTE_PATH")
    printf '\n## Session Update — %s\n\n%s\n' "$TODAY" "$SUMMARY" >> "$NOTE_PATH"
    echo "✅ Note updated: notes/$NOTE_NAME"
else
    echo "⚠️  No matching note found for '$PROJECT' in notes/ — log entry written, note skipped."
    echo "   Create notes/${PROJECT}.md to enable automatic note updates."
fi

# ── 3. Check memory.md for potentially completed tasks ────────────────────────
echo ""
echo "── Checking memory.md for $PROJECT tasks ──────────────────────────────────"

MATCHING_TASKS=$(python3 - <<PYEOF
import re, sys

project = "$PROJECT".lower()
memory = open("$MEMORY_FILE", encoding="utf-8").read()

# Find all pending task lines (- [ ] ...)
pending = re.findall(r'^\s*- \[ \].*$', memory, re.MULTILINE)

# Filter to those that mention the project (case-insensitive)
# Also catch common abbreviations and partial matches
keywords = [w for w in project.replace('-', ' ').split() if len(w) > 2]

matches = []
for task in pending:
    task_lower = task.lower()
    if any(kw in task_lower for kw in keywords):
        matches.append(task.strip())

if matches:
    print("Found {} pending task(s) related to {}:".format(len(matches), "$PROJECT"))
    for t in matches:
        print("  " + t)
    print("")
    print("Run '/reflect' inside a Claude Code session to mark completed tasks.")
else:
    print("No pending tasks found in memory.md matching '$PROJECT'.")
PYEOF
)

echo "$MATCHING_TASKS"

# ── 4. Post to Slack ──────────────────────────────────────────────────────────
NOTE_STATUS=""
if [[ -n "$NOTE_PATH" ]]; then
    NOTE_STATUS=" | Note: notes/$(basename "$NOTE_PATH")"
fi

slack_notify "VIRGIL [sync] 🔄 *$PROJECT* — $NOW${NOTE_STATUS}

$SUMMARY"

echo ""
echo "── Done ─────────────────────────────────────────────────────────────────────"
echo "  Project : $PROJECT"
echo "  Log     : $LOG_FILE"
[[ -n "$NOTE_PATH" ]] && echo "  Note    : notes/$(basename "$NOTE_PATH")"
echo "  Slack   : $( [[ -n "${SLACK_WEBHOOK_URL:-}" ]] && echo "sent" || echo "skipped (no webhook)" )"
