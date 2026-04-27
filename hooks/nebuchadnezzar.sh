#!/bin/bash
# nebuchadnezzar.sh — VIRGIL vault backup to external drive
#
# Syncs ${SOURCE:-$HOME/Documents/} to ${DEST:-/media/your-username/VIRGIL-Backup/}
# via rsync -av --delete.
#
# Schedule (crontab):
#   5 2 * * *   daily   — 5min after promote.sh
#   5 1 * * 0   Sunday  — 5min after weekly-rollup.sh
#
# Exits silently if the backup drive is not mounted.
# Logs every run to hooks/nebuchadnezzar.log.
# Posts Slack notification on success or drive-missing warning.
#
# Environment variables (set in .env or crontab):
#   SOURCE        — directory to back up (default: $HOME/Documents/)
#   DEST          — backup destination  (default: /media/your-username/VIRGIL-Backup/)
#   MOUNT_POINT   — drive mount point   (default: derived from DEST parent)

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
SOURCE="${SOURCE:-$HOME/Documents/}"
DEST="${DEST:-/media/your-username/VIRGIL-Backup/}"
MOUNT_POINT="${MOUNT_POINT:-$(dirname "${DEST%/}")}"
LOG_FILE="$VIRGIL_DIR/hooks/nebuchadnezzar.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOGPREFIX="[nebuchadnezzar.sh $TIMESTAMP]"

# ── Logging helper ─────────────────────────────────────────────────────────────
log() {
    echo "$LOGPREFIX $*" | tee -a "$LOG_FILE"
}

# ── Source secrets from .env — no eval of untrusted input ─────────────────────
VIRGIL_ENV="${HOME}/.config/virgil/.env"
if [[ -f "$VIRGIL_ENV" ]]; then
    # shellcheck source=/dev/null
    set -a; source "$VIRGIL_ENV"; set +a
fi
if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
    SLACK_WEBHOOK_URL=$(crontab -l 2>/dev/null | grep 'SLACK_WEBHOOK_URL' | cut -d'"' -f2 | head -1)
    [[ -n "$SLACK_WEBHOOK_URL" ]] && export SLACK_WEBHOOK_URL
fi

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

# ── 1. Check drive is mounted ──────────────────────────────────────────────────
if ! mountpoint -q "$MOUNT_POINT" 2>/dev/null; then
    # Silent exit — drive simply isn't plugged in, not an error worth waking anyone
    echo "$LOGPREFIX Drive not mounted at '$MOUNT_POINT'. Skipping." >> "$LOG_FILE"
    slack_notify "VIRGIL [backup] ⚠️ Backup drive not found at '$MOUNT_POINT' — VIRGIL backup skipped ($TIMESTAMP)."
    exit 0
fi

log "Drive found at '$MOUNT_POINT'. Starting rsync."

# ── 2. Ensure destination directory exists ─────────────────────────────────────
mkdir -p "$DEST"

# ── 2b. Safety check — verify destination is reachable and non-empty before
#        allowing --delete to run. A wrong or empty dest + --delete = data loss.
if [[ ! -d "$DEST" ]]; then
    log "ERROR: Destination '$DEST' does not exist after mkdir — aborting."
    slack_notify "VIRGIL [backup] ❌ Backup aborted — destination '$DEST' not found after mkdir. Check drive mount."
    exit 1
fi

DEST_FILE_COUNT=$(find "$DEST" -maxdepth 1 -mindepth 1 2>/dev/null | wc -l | tr -d ' ')
if [[ "$DEST_FILE_COUNT" -eq 0 ]]; then
    log "WARNING: Destination '$DEST' is empty — this may be a first run or wrong mount point."
    log "Proceeding without --delete for safety. Run again after verifying the destination."
    RSYNC_DELETE_FLAG=""
else
    RSYNC_DELETE_FLAG="--delete"
fi

# ── 3. Run rsync ───────────────────────────────────────────────────────────────
# shellcheck disable=SC2086
RSYNC_OUTPUT=$(rsync -av $RSYNC_DELETE_FLAG --stats \
    --exclude='*.swp' \
    --exclude='*.swo' \
    --exclude='.DS_Store' \
    --exclude='Thumbs.db' \
    "$SOURCE" "$DEST" 2>&1) || {
    log "rsync FAILED (exit $?)."
    log "$RSYNC_OUTPUT"
    slack_notify "VIRGIL [backup] ❌ VIRGIL backup FAILED at $TIMESTAMP. Check $LOG_FILE."
    exit 1
}

# ── 4. Parse transfer stats ────────────────────────────────────────────────────
FILES_TRANSFERRED=$(echo "$RSYNC_OUTPUT" \
    | grep 'Number of regular files transferred:' \
    | awk '{print $NF}' || echo "?")

FILES_TOTAL=$(echo "$RSYNC_OUTPUT" \
    | grep 'Number of files:' \
    | head -1 \
    | grep -oP '\d+' \
    | head -1 || echo "?")

BYTES_SENT=$(echo "$RSYNC_OUTPUT" \
    | grep 'Total bytes sent:' \
    | awk '{print $NF}' \
    | numfmt --to=iec 2>/dev/null || \
    echo "$RSYNC_OUTPUT" | grep 'Total bytes sent:' | awk '{print $NF, "bytes"}')

# ── 5. Write log entry ─────────────────────────────────────────────────────────
{
    echo ""
    echo "════════════════════════════════════════"
    echo "$LOGPREFIX Backup complete."
    echo "  Source : $SOURCE"
    echo "  Dest   : $DEST"
    echo "  Files transferred : $FILES_TRANSFERRED"
    echo "  Total files       : $FILES_TOTAL"
    echo "  Bytes sent        : $BYTES_SENT"
    echo "── rsync stats ──"
    echo "$RSYNC_OUTPUT" | grep -E '^(Number of|Total|sent|total size)' || true
    echo "════════════════════════════════════════"
} >> "$LOG_FILE"

log "Done. $FILES_TRANSFERRED file(s) transferred, $FILES_TOTAL total in vault."

# ── 6. Notify Slack ────────────────────────────────────────────────────────────
slack_notify "VIRGIL [backup] ✅ VIRGIL vault synced to backup drive ($TIMESTAMP).
→ $FILES_TRANSFERRED file(s) transferred | $FILES_TOTAL total | $BYTES_SENT sent
→ Dest: $DEST"
