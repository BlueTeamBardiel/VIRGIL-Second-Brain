#!/bin/bash
# virgil-status.sh — Health check for all VIRGIL services
# Usage: bash hooks/virgil-status.sh
# Runs at session start/end. Posts summary to Slack if SLACK_WEBHOOK_URL is set.

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
LOGS_DIR="$VIRGIL_DIR/logs"

VIRGIL_ENV="${HOME}/.config/virgil/.env"
if [[ -f "$VIRGIL_ENV" ]]; then
    set -a; source "$VIRGIL_ENV"; set +a
fi

NOW=$(date '+%Y-%m-%d %H:%M')
TODAY=$(date '+%Y-%m-%d')
HOST=$(hostname)

# ── Helper ────────────────────────────────────────────────────────────────────
http_code() { curl -s -o /dev/null -w "%{http_code}" --connect-timeout 3 "$1" 2>/dev/null; }

# ── 1. ChromaDB bridge (port 5000) ───────────────────────────────────────────
BRIDGE_DETAIL=$(curl -s --connect-timeout 3 http://127.0.0.1:5000/health 2>/dev/null \
    | python3 -c "import json,sys; d=json.load(sys.stdin); print(f'{d[\"chunks\"]} chunks')" 2>/dev/null)
if [[ -n "$BRIDGE_DETAIL" ]]; then
    BRIDGE_LINE="✅ running — $BRIDGE_DETAIL"
    BRIDGE_SLACK="✅"
else
    BRIDGE_LINE="❌ down"
    BRIDGE_SLACK="❌"
fi

# ── 2. Ollama (port 11434) ───────────────────────────────────────────────────
OLLAMA_DETAIL=$(curl -s --connect-timeout 3 http://127.0.0.1:11434/api/tags 2>/dev/null \
    | python3 -c "
import json,sys
d=json.load(sys.stdin)
models=[m['name'] for m in d.get('models',[])]
print(', '.join(models[:3]))
" 2>/dev/null)
if [[ -n "$OLLAMA_DETAIL" ]]; then
    OLLAMA_LINE="✅ running — $OLLAMA_DETAIL"
    OLLAMA_SLACK="✅"
else
    OLLAMA_LINE="❌ down"
    OLLAMA_SLACK="❌"
fi

# ── 3. OpenWebUI (port 3000) ─────────────────────────────────────────────────
OWUI_CODE=$(http_code http://127.0.0.1:3000)
if [[ "$OWUI_CODE" =~ ^[23] ]]; then
    OWUI_LINE="✅ running (port 3000)"
    OWUI_SLACK="✅"
else
    OWUI_LINE="❌ down"
    OWUI_SLACK="❌"
fi

# ── 4. Conversation ingest (port 5002) ───────────────────────────────────────
INGEST_CODE=$(http_code http://127.0.0.1:5002)
if [[ "$INGEST_CODE" =~ ^[23] ]]; then
    INGEST_LINE="✅ running (port 5002)"
    INGEST_SLACK="✅"
else
    INGEST_LINE="❌ down"
    INGEST_SLACK="❌"
fi

# ── 5. Promote.sh last run ───────────────────────────────────────────────────
PROMOTE_FILE="$LOGS_DIR/promote-last-run"
if [[ -f "$PROMOTE_FILE" ]]; then
    LAST_RUN=$(cat "$PROMOTE_FILE" | tr -d '[:space:]')
    DIFF=$(( ( $(date -d "$TODAY" +%s) - $(date -d "$LAST_RUN" +%s 2>/dev/null || echo 0) ) / 86400 ))
    if [[ "$LAST_RUN" == "$TODAY" ]]; then
        PROMOTE_LINE="✅ ran today"
        PROMOTE_SLACK="✅"
    elif [[ "$DIFF" -le 1 ]]; then
        PROMOTE_LINE="⚠️  ran yesterday"
        PROMOTE_SLACK="⚠️"
    else
        PROMOTE_LINE="❌ not run in $DIFF days"
        PROMOTE_SLACK="❌"
    fi
else
    PROMOTE_LINE="❌ not run"
    PROMOTE_SLACK="❌"
fi

# ── 6. Vault note count ──────────────────────────────────────────────────────
NOTE_COUNT=$(find "$VIRGIL_DIR/notes" -name "*.md" | wc -l | tr -d ' ')
VAULT_LINE="✅ $NOTE_COUNT notes"

# ── 7. Ghost-fill status ─────────────────────────────────────────────────────
GHOST_LOG="$LOGS_DIR/ghost-fill.log"
GHOST_RESUME="$LOGS_DIR/ghost-fill-resume.log"
if [[ -f "$GHOST_RESUME" ]] && grep -q "Done" "$GHOST_RESUME" 2>/dev/null; then
    GHOST_LINE="✅ complete (4664/4664)"
    GHOST_SLACK="✅"
elif [[ -f "$GHOST_LOG" ]]; then
    FILLED=$(wc -l < "$GHOST_LOG" | tr -d ' ')
    if pgrep -f "ghost-fill.py" > /dev/null 2>&1; then
        GHOST_LINE="🔄 in progress ($FILLED/4664)"
        GHOST_SLACK="🔄"
    else
        GHOST_LINE="✅ complete ($FILLED filled)"
        GHOST_SLACK="✅"
    fi
else
    GHOST_LINE="⚠️  not run"
    GHOST_SLACK="⚠️"
fi

# ── 8. Last health check ─────────────────────────────────────────────────────
LATEST_HEALTH=$(ls -1t "$VIRGIL_DIR/notes/reports/health-"*.md 2>/dev/null | head -1)
if [[ -n "$LATEST_HEALTH" ]]; then
    HEALTH_DATE=$(basename "$LATEST_HEALTH" | sed 's/health-//;s/\.md//')
    DIFF_H=$(( ( $(date -d "$TODAY" +%s) - $(date -d "$HEALTH_DATE" +%s 2>/dev/null || echo 0) ) / 86400 ))
    if [[ "$HEALTH_DATE" == "$TODAY" ]]; then
        HEALTH_LINE="✅ today"
        HEALTH_SLACK="✅"
    elif [[ "$DIFF_H" -le 7 ]]; then
        HEALTH_LINE="⚠️  $DIFF_H days ago"
        HEALTH_SLACK="⚠️"
    else
        HEALTH_LINE="❌ $DIFF_H days ago"
        HEALTH_SLACK="❌"
    fi
else
    HEALTH_LINE="❌ never run"
    HEALTH_SLACK="❌"
fi

# ── Print status table ────────────────────────────────────────────────────────
printf '══════════════════════════════════════════\n'
printf '  VIRGIL Status — %s\n' "$NOW"
printf '══════════════════════════════════════════\n'
printf '  %-26s %s\n' "Bridge (ChromaDB):"   "$BRIDGE_LINE"
printf '  %-26s %s\n' "Ollama:"              "$OLLAMA_LINE"
printf '  %-26s %s\n' "OpenWebUI:"           "$OWUI_LINE"
printf '  %-26s %s\n' "Conversation ingest:" "$INGEST_LINE"
printf '  %-26s %s\n' "Promote.sh:"          "$PROMOTE_LINE"
printf '  %-26s %s\n' "Vault:"               "$VAULT_LINE"
printf '  %-26s %s\n' "Ghost-fill:"          "$GHOST_LINE"
printf '  %-26s %s\n' "Health check:"        "$HEALTH_LINE"
printf '══════════════════════════════════════════\n'

# ── Slack notification ────────────────────────────────────────────────────────
if [[ -n "${SLACK_WEBHOOK_URL:-}" ]]; then
    MSG="VIRGIL Status [$NOW] on $HOST
Bridge: $BRIDGE_SLACK | Ollama: $OLLAMA_SLACK | OpenWebUI: $OWUI_SLACK | Ingest: $INGEST_SLACK
Promote: $PROMOTE_SLACK | Vault: $NOTE_COUNT notes | Ghost-fill: $GHOST_SLACK | Health: $HEALTH_SLACK"
    curl -s -X POST -H 'Content-type: application/json' \
        --data "$(python3 -c "import json,sys; print(json.dumps({'text': sys.argv[1]}))" "$MSG")" \
        "$SLACK_WEBHOOK_URL" > /dev/null
fi
