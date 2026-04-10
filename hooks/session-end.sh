#!/bin/bash
# VIRGIL session-end hook
# Appends one timestamped entry per Claude Code session to the daily log.
#
# The Stop hook fires after every assistant response turn. To avoid creating
# an entry on every turn, we use the session_id (from the hook's stdin JSON)
# as a dedup key. The first Stop for a given session writes the entry; all
# subsequent Stops for that session are skipped.

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
LOG_DIR="$VIRGIL_DIR/daily-logs"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/$TODAY.md"
TIMESTAMP=$(date +"%H:%M:%S")

# ── Read session_id from stdin JSON ──────────────────────────────────────────
HOOK_INPUT=$(cat)
SESSION_ID=$(printf '%s' "$HOOK_INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('session_id', ''))
" 2>/dev/null)

# If we couldn't parse a session_id, fall back to a date-only key (one entry
# per day at most) so we don't spam on parse errors.
if [[ -z "$SESSION_ID" ]]; then
    SESSION_ID="fallback-$TODAY"
fi

# ── Dedup: skip if this session already wrote an entry ───────────────────────
LOCK_FILE="/tmp/virgil-session-${SESSION_ID}.lock"
if [[ -f "$LOCK_FILE" ]]; then
    exit 0
fi
touch "$LOCK_FILE"

# Clean up lock files older than 2 days so /tmp doesn't accumulate them.
find /tmp -maxdepth 1 -name 'virgil-session-*.lock' -mtime +2 -delete 2>/dev/null || true

# ── Create log file with header if needed ────────────────────────────────────
if [[ ! -f "$LOG_FILE" ]]; then
    cat > "$LOG_FILE" <<EOF
# VIRGIL Daily Log — $TODAY

---

EOF
fi

# ── Capture git context ───────────────────────────────────────────────────────
CWD=$(printf '%s' "$HOOK_INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('cwd', ''))
" 2>/dev/null)
CWD="${CWD:-${PWD:-unknown}}"

GIT_BRANCH=$(git -C "$CWD" rev-parse --abbrev-ref HEAD 2>/dev/null)
if [[ -n "$GIT_BRANCH" ]]; then
    GIT_LINE="- Git branch: $GIT_BRANCH"
    MODIFIED_COUNT=$(git -C "$CWD" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED_LINE="- Files modified this session: $MODIFIED_COUNT"
else
    GIT_LINE="- Git branch: n/a"
    MODIFIED_LINE="- Files modified this session: n/a"
fi

# ── Append session entry ──────────────────────────────────────────────────────
cat >> "$LOG_FILE" <<EOF
## Session ended at $TIMESTAMP

- Working directory: $CWD
$GIT_LINE
$MODIFIED_LINE

### Summary

<!-- fill in manually -->

---

EOF
