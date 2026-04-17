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
