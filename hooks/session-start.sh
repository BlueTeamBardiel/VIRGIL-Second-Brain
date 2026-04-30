#!/bin/bash
# VIRGIL session-start hook
# Fires once per Claude Code session via the SessionStart event.
# Prints a startup banner, recent promoted memory, and any unfilled log summaries.

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
MEMORY_FILE="$VIRGIL_DIR/memory.md"
LOG_DIR="$VIRGIL_DIR/daily-logs"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$LOG_DIR/$TODAY.md"

# ── Banner ────────────────────────────────────────────────────────────────────
printf '\n'
printf '╔══════════════════════════════════════════╗\n'
printf '║           V I R G I L  Online            ║\n'
printf '╚══════════════════════════════════════════╝\n'
printf '  %s\n' "$(date '+%A, %B %-d %Y  |  %H:%M')"
printf '\n'

# ── 3 most recent ## Promoted — sections from memory.md ──────────────────────
printf '── Recent Memory ──────────────────────────────\n'

if [[ ! -f "$MEMORY_FILE" ]]; then
    printf '  memory.md not found at %s\n' "$MEMORY_FILE"
else
    # Collect each "## Promoted — ..." section (up to the next ## heading or EOF)
    # into null-delimited records, then load into an array.
    mapfile -d '' SECTIONS < <(awk '
        /^## Promoted — / {
            if (buf != "") { printf "%s\0", buf }
            buf = $0
            next
        }
        /^## / && buf != "" && !/^## Promoted — / {
            printf "%s\0", buf
            buf = ""
            next
        }
        buf != "" { buf = buf "\n" $0 }
        END       { if (buf != "") printf "%s\0", buf }
    ' "$MEMORY_FILE")

    COUNT="${#SECTIONS[@]}"
    if [[ "$COUNT" -eq 0 ]]; then
        printf '  (no promoted memory entries yet)\n'
    else
        START=$(( COUNT > 3 ? COUNT - 3 : 0 ))
        for (( i = START; i < COUNT; i++ )); do
            printf '%s\n\n' "${SECTIONS[$i]}"
        done
    fi
fi

printf '───────────────────────────────────────────────\n\n'

# ── Proactive absence detection ───────────────────────────────────────────────
SCORES_FILE="$VIRGIL_DIR/logs/quiz-scores.json"
if [[ -f "$SCORES_FILE" ]]; then
    LAST_TESTED=$(python3 -c "
import json, sys
from pathlib import Path
try:
    scores = json.loads(Path('$SCORES_FILE').read_text())
    dates = [v.get('last_tested','') for v in scores.values() if isinstance(v,dict)]
    dates = [d for d in dates if d]
    print(max(dates)) if dates else print('')
except:
    print('')
" 2>/dev/null)

    if [[ -n "$LAST_TESTED" ]]; then
        DAYS_AWAY=$(python3 -c "
from datetime import date, datetime
try:
    last = datetime.strptime('$LAST_TESTED', '%Y-%m-%d').date()
    print((date.today() - last).days)
except:
    print('')
" 2>/dev/null)

        if [[ -n "$DAYS_AWAY" ]] && [[ "$DAYS_AWAY" -ge 7 ]]; then
            printf '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
            printf '  VIRGIL: You'\''ve been away for %s days.\n' "$DAYS_AWAY"
            printf '  Type /absence in Claude Code to ease back in.\n'
            printf '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        fi
    fi
fi

# ── Create today's log file if it doesn't exist ──────────────────────────────
if [[ ! -f "$LOG_FILE" ]]; then
    mkdir -p "$LOG_DIR"
    cat > "$LOG_FILE" <<EOF
# VIRGIL Daily Log — $TODAY

---

EOF
fi

# ── Warn about unfilled summaries in today's log ──────────────────────────────
if [[ -f "$LOG_FILE" ]]; then
    UNFILLED=$(grep -c '<!-- fill in manually -->' "$LOG_FILE" 2>/dev/null || true)
    if [[ "$UNFILLED" -gt 0 ]]; then
        printf '  WARNING: %s unfilled summar%s in today'\''s log\n' \
            "$UNFILLED" "$( [[ "$UNFILLED" -eq 1 ]] && echo 'y' || echo 'ies' )"
        printf '  %s\n\n' "$LOG_FILE"
    fi
fi
