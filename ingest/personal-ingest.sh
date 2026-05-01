#!/bin/bash
# personal-ingest.sh — Log personal data to VIRGIL notes/personal/
# Usage: personal-ingest.sh <subcommand> [args]
# Subcommands:
#   workout  [notes...]     — Log a workout session
#   meal     [notes...]     — Log meals / nutrition
#   goal     [notes...]     — Log or review goals
#   study    [notes...]     — Log a study session (CySA+, certs, etc.)
# No Slack notifications — personal data stays local.

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
PERSONAL_DIR="$VIRGIL_DIR/notes/personal"
TODAY=$(date '+%Y-%m-%d')
NOW=$(date '+%Y-%m-%d %H:%M')
LOGFILE="$VIRGIL_DIR/ingest/personal-ingest.log"
LOGPREFIX="[personal-ingest $NOW]"

log() { echo "$LOGPREFIX $*" | tee -a "$LOGFILE"; }

# ── Usage ─────────────────────────────────────────────────────────────────────
usage() {
    cat >&2 <<EOF
Usage: $0 <subcommand> [notes...]

Subcommands:
  workout  [notes]   Log a workout session
  meal     [notes]   Log a meal / nutrition entry
  goal     [notes]   Log or update a goal
  study    [notes]   Log a study session

Notes are optional — if omitted, opens \$EDITOR to write interactively.

Examples:
  $0 workout "knee protocol: leg press 3x12, wall sit 2x30s, good"
  $0 study "CySA+ domain 3: vulnerability management, NVD API practice"
  $0 goal "target: pass CySA+ before 2026-06-01"
  $0 meal
EOF
    exit 1
}

# ── Helpers ───────────────────────────────────────────────────────────────────
ensure_dir() {
    mkdir -p "$1"
}

open_editor() {
    local tmpfile
    tmpfile=$(umask 0177; mktemp /tmp/virgil-personal-XXXXXX.md)
    chmod 600 "$tmpfile" 2>/dev/null || true
    ${EDITOR:-nano} "$tmpfile"
    cat "$tmpfile"
    rm -f "$tmpfile"
}

append_entry() {
    local file="$1"
    local header="$2"
    local content="$3"

    if [[ ! -f "$file" ]]; then
        {
            printf '# %s\n\n' "$(basename "$file" .md | tr '-' ' ' | sed 's/\b\w/\u&/g')"
        } > "$file"
    fi

    {
        printf '\n## %s — %s\n\n' "$header" "$NOW"
        printf '%s\n' "$content"
    } >> "$file"

    log "Appended to $file"
    echo "$file"
}

# ── Main ──────────────────────────────────────────────────────────────────────
if [[ $# -lt 1 ]]; then
    usage
fi

SUBCOMMAND="$1"
shift
NOTES="${*:-}"

case "$SUBCOMMAND" in
    workout)
        ensure_dir "$PERSONAL_DIR/workouts"
        OUTPUT_FILE="$PERSONAL_DIR/workouts/$TODAY.md"

        if [[ -z "$NOTES" ]]; then
            TEMPLATE=$(cat <<EOF
<!-- Workout log for $TODAY -->
**Type:**
**Duration:**
**Exercises:**
-

**How it felt:**

**Knee:**

**Notes:**
EOF
)
            CONTENT=$(echo "$TEMPLATE" | open_editor)
        else
            CONTENT="$NOTES"
        fi

        append_entry "$OUTPUT_FILE" "Workout" "$CONTENT"
        log "Workout logged: $OUTPUT_FILE"
        ;;

    meal)
        ensure_dir "$PERSONAL_DIR/nutrition"
        OUTPUT_FILE="$PERSONAL_DIR/nutrition/$TODAY.md"

        if [[ -z "$NOTES" ]]; then
            TEMPLATE=$(cat <<EOF
<!-- Nutrition log for $TODAY -->
**Breakfast:**

**Lunch:**

**Dinner:**

**Snacks:**

**Water:**
**Notes:**
EOF
)
            CONTENT=$(echo "$TEMPLATE" | open_editor)
        else
            CONTENT="$NOTES"
        fi

        append_entry "$OUTPUT_FILE" "Nutrition" "$CONTENT"
        log "Meal logged: $OUTPUT_FILE"
        ;;

    goal)
        ensure_dir "$PERSONAL_DIR"
        OUTPUT_FILE="$PERSONAL_DIR/goals.md"

        if [[ -z "$NOTES" ]]; then
            TEMPLATE=$(cat <<EOF
<!-- Goal entry for $TODAY -->
**Goal:**

**Target date:**

**Progress:**

**Next action:**
EOF
)
            CONTENT=$(echo "$TEMPLATE" | open_editor)
        else
            CONTENT="$NOTES"
        fi

        append_entry "$OUTPUT_FILE" "Goal Update" "$CONTENT"
        log "Goal logged: $OUTPUT_FILE"
        ;;

    study)
        ensure_dir "$PERSONAL_DIR/study"
        OUTPUT_FILE="$PERSONAL_DIR/study/$TODAY.md"

        if [[ -z "$NOTES" ]]; then
            TEMPLATE=$(cat <<EOF
<!-- Study log for $TODAY -->
**Topic / Domain:**

**Resource(s):**

**What I learned:**

**Weak areas:**

**Next:**
EOF
)
            CONTENT=$(echo "$TEMPLATE" | open_editor)
        else
            CONTENT="$NOTES"
        fi

        append_entry "$OUTPUT_FILE" "Study Session" "$CONTENT"
        log "Study session logged: $OUTPUT_FILE"
        ;;

    *)
        echo "Unknown subcommand: $SUBCOMMAND" >&2
        usage
        ;;
esac
