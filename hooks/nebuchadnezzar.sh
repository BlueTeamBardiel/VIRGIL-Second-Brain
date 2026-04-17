#!/bin/bash
# nebuchadnezzar.sh — your-lab vault backup to USB STICK
#
# Syncs /home/your-username/Documents/Cocytus/ to
#   /media/your-username/USB STICK/your-lab-Backup/
# via rsync -av --delete.
#
# Schedule (crontab):
#   5 2 * * *   daily   — 5min after promote.sh
#   5 1 * * 0   Sunday  — 5min after weekly-rollup.sh
#
# Exits silently if the USB drive is not mounted.
# Logs every run to hooks/nebuchadnezzar.log.
# Posts Slack notification on success or drive-missing warning.

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
SOURCE="${SOURCE:-$HOME/Documents/Cocytus/}"
DEST="/media/your-username/USB STICK/your-lab-Backup/"
LOG_FILE="$VIRGIL_DIR/hooks/nebuchadnezzar.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOGPREFIX="[nebuchadnezzar.sh $TIMESTAMP]"

# ── Logging helper ─────────────────────────────────────────────────────────────
log() {
    echo "$LOGPREFIX $*" | tee -a "$LOG_FILE"
}

# ── Self-source secrets from crontab if not in environment ───────────────────
if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
    eval "$(crontab -l 2>/dev/null | grep 'SLACK_WEBHOOK_URL' | sed 's/^/export /')"
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
MOUNT_POINT="/media/your-username/USB STICK"

if ! mountpoint -q "$MOUNT_POINT" 2>/dev/null; then
    # Silent exit — drive simply isn't plugged in, not an error worth waking anyone
    echo "$LOGPREFIX Drive not mounted at '$MOUNT_POINT'. Skipping." >> "$LOG_FILE"
    slack_notify "VIRGIL [backup] ⚠️ USB STICK not found at '$MOUNT_POINT' — your-lab backup skipped ($TIMESTAMP)."
    exit 0
fi

log "Drive found at '$MOUNT_POINT'. Starting rsync."

# ── 2. Ensure destination directory exists ─────────────────────────────────────
mkdir -p "$DEST"

# ── 3. Run rsync ───────────────────────────────────────────────────────────────
RSYNC_OUTPUT=$(rsync -av --delete --stats \
    --exclude='*.swp' \
    --exclude='*.swo' \
    --exclude='.DS_Store' \
    --exclude='Thumbs.db' \
    "$SOURCE" "$DEST" 2>&1) || {
    log "rsync FAILED (exit $?)."
    log "$RSYNC_OUTPUT"
    slack_notify "VIRGIL [backup] ❌ your-lab backup FAILED at $TIMESTAMP. Check $LOG_FILE."
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
slack_notify "VIRGIL [backup] ✅ your-lab vault synced to USB STICK ($TIMESTAMP).
→ $FILES_TRANSFERRED file(s) transferred | $FILES_TOTAL total | $BYTES_SENT sent
→ Dest: $DEST"
