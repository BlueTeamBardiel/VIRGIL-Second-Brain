#!/bin/bash
# triage-inbox.sh — Weekly inbox triage for notes/inbox/
#
# For each .md file in notes/inbox/:
#   - Calls Claude Haiku with note content + existing note title list
#   - Haiku returns JSON: {"action": "merge|keep|archive", "target": "...", "reason": "..."}
#   - merge:   appends note content to target note, deletes from inbox
#   - keep:    leaves in inbox, logs reason
#   - archive: moves to notes/archive/
#
# Cron: 0 8 * * 1  (Monday 8am)
# Log:  ingest/triage-inbox.log
# Alias: virgil-triage

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
NOTES_DIR="$VIRGIL_DIR/notes"
INBOX_DIR="$NOTES_DIR/inbox"
ARCHIVE_DIR="$NOTES_DIR/archive"
MITRE_DIR="$NOTES_DIR/mitre"
LOGFILE="$VIRGIL_DIR/ingest/triage-inbox.log"
LOGPREFIX="[triage-inbox $(date '+%Y-%m-%d %H:%M')]"
API_URL="https://api.anthropic.com/v1/messages"
MODEL="claude-haiku-4-5-20251001"

log() { echo "$LOGPREFIX $*" | tee -a "$LOGFILE"; }
die() { log "ERROR: $*"; exit 1; }

# ── Load API key from vault .env if not set in environment ───────────────────
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    # shellcheck source=/dev/null
    set -a; source "$VIRGIL_DIR/.env" 2>/dev/null || true; set +a
fi
[[ -n "${ANTHROPIC_API_KEY:-}" ]] || die "ANTHROPIC_API_KEY is not set."

# ── Check for inbox notes ─────────────────────────────────────────────────────
mkdir -p "$INBOX_DIR" "$ARCHIVE_DIR" "$MITRE_DIR"

mapfile -d '' INBOX_FILES < <(find "$INBOX_DIR" -maxdepth 1 -name "*.md" -print0 2>/dev/null)

if [[ ${#INBOX_FILES[@]} -eq 0 ]]; then
    log "Inbox is empty. Nothing to triage."
    exit 0
fi

log "Found ${#INBOX_FILES[@]} note(s) in inbox"

# ── Build list of existing note titles (outside inbox/) ──────────────────────
TITLE_LIST=$(find "$NOTES_DIR" -maxdepth 2 -name "*.md" \
    ! -path "$INBOX_DIR/*" \
    ! -path "$ARCHIVE_DIR/*" \
    ! -name ".*" \
    -printf "%f\n" 2>/dev/null \
    | sed 's/\.md$//' | sort)

# ── Python helper: call Claude, parse JSON ───────────────────────────────────
_TMPPY=$(mktemp /tmp/virgil-triage-XXXXXX.py)
trap "rm -f $_TMPPY" EXIT

cat > "$_TMPPY" <<'PYEOF'
import json, os, sys, urllib.request, urllib.error

API_URL    = os.environ["API_URL"]
MODEL      = os.environ["MODEL"]
TITLE_LIST = os.environ["TITLE_LIST"].strip()
NOTE_NAME  = os.environ["NOTE_NAME"]

note_content = sys.stdin.read()

prompt = f"""You are VIRGIL, a sysadmin's second brain. Triage this inbox note.

Inbox note filename: {NOTE_NAME}

Existing note titles in vault (one per line):
{TITLE_LIST}

Your decision (choose exactly one):
- "merge": this note's content belongs in an existing note. Set target to the exact existing title.
- "keep":  this note needs more work or is standalone but not yet ready to file. Leave in inbox.
- "archive": this note is stale, redundant, or no longer relevant. Move to archive.

Special routing rules (apply BEFORE deciding merge/keep/archive):
- If the note is a MITRE ATT&CK technique (filename matches t[0-9]{{4}} pattern, or content
  contains "ATT&CK", "MITRE", or "Technique ID: T"), return action "mitre". These notes belong
  in notes/mitre/ not inbox. Set target to null.

Return ONLY valid JSON, no prose:
{{"action": "merge|keep|archive|mitre", "target": "exact existing note title, or null", "reason": "one line"}}

Inbox note content:
{note_content[:3000]}
"""

payload = json.dumps({
    "model": MODEL,
    "max_tokens": 256,
    "messages": [{"role": "user", "content": prompt}]
}).encode()

req = urllib.request.Request(API_URL, data=payload, headers={
    "x-api-key":         os.environ["ANTHROPIC_API_KEY"],
    "anthropic-version": "2023-06-01",
    "content-type":      "application/json",
})

try:
    with urllib.request.urlopen(req, timeout=60) as r:
        body = json.loads(r.read())
    raw = body["content"][0]["text"].strip()
except urllib.error.HTTPError as e:
    print(f"HTTP {e.code}: {e.read().decode(errors='replace')[:200]}", file=sys.stderr)
    sys.exit(1)
except Exception as e:
    print(f"API error: {e}", file=sys.stderr)
    sys.exit(1)

# Strip code fences if Claude wrapped the JSON
if raw.startswith("```"):
    raw = "\n".join(raw.splitlines()[1:])
    if raw.endswith("```"):
        raw = raw[:-3]

try:
    result = json.loads(raw)
except json.JSONDecodeError as e:
    print(f"JSON parse error: {e} — raw: {raw[:200]}", file=sys.stderr)
    sys.exit(1)

print(json.dumps(result))
PYEOF

# ── Triage each inbox note ────────────────────────────────────────────────────
MERGED=0
KEPT=0
ARCHIVED=0
MITRED=0

for NOTE_PATH in "${INBOX_FILES[@]}"; do
    [[ -f "$NOTE_PATH" ]] || continue
    NOTE_NAME=$(basename "$NOTE_PATH")
    NOTE_CONTENT=$(cat "$NOTE_PATH")

    # ── Fast-path: MITRE ATT&CK detection (no API call needed) ───────────────
    NOTE_STEM="${NOTE_NAME%.md}"
    if [[ "$NOTE_STEM" =~ ^t[0-9]{4}([._-][0-9]+)?$ ]] || \
       echo "$NOTE_CONTENT" | grep -qiE '(ATT&CK|MITRE|Technique ID: T[0-9])'; then
        mv "$NOTE_PATH" "$MITRE_DIR/$NOTE_NAME"
        log "MITRE $NOTE_NAME → notes/mitre/ (pattern match — no API call)"
        MITRED=$(( MITRED + 1 ))
        continue
    fi

    RESULT=$(API_URL="$API_URL" MODEL="$MODEL" TITLE_LIST="$TITLE_LIST" \
        NOTE_NAME="$NOTE_NAME" \
        python3 "$_TMPPY" <<< "$NOTE_CONTENT" \
        2> >(while IFS= read -r line; do log "[haiku] $line"; done)) \
        || { log "SKIP $NOTE_NAME — API call failed"; continue; }

    [[ -n "$RESULT" ]] || { log "SKIP $NOTE_NAME — empty result"; continue; }

    ACTION=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(d.get('action','keep'))" <<< "$RESULT")
    TARGET=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(d.get('target') or '')" <<< "$RESULT")
    REASON=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(d.get('reason',''))" <<< "$RESULT")

    case "$ACTION" in
        mitre)
            mv "$NOTE_PATH" "$MITRE_DIR/$NOTE_NAME"
            log "MITRE $NOTE_NAME → notes/mitre/ | $REASON"
            MITRED=$(( MITRED + 1 ))
            ;;
        merge)
            # Find target note file
            TARGET_FILE=$(find "$NOTES_DIR" -maxdepth 2 -name "${TARGET}.md" \
                ! -path "$INBOX_DIR/*" 2>/dev/null | head -1)
            if [[ -z "$TARGET_FILE" ]]; then
                log "KEEP $NOTE_NAME — merge target '$TARGET' not found on disk"
                KEPT=$(( KEPT + 1 ))
            else
                {
                    printf '\n\n---\n\n'
                    printf '## From inbox: %s — %s\n\n' "$NOTE_NAME" "$(date '+%Y-%m-%d')"
                    cat "$NOTE_PATH"
                    printf '\n'
                } >> "$TARGET_FILE"
                rm "$NOTE_PATH"
                log "MERGE $NOTE_NAME → $TARGET_FILE | $REASON"
                MERGED=$(( MERGED + 1 ))
            fi
            ;;
        archive)
            mv "$NOTE_PATH" "$ARCHIVE_DIR/$NOTE_NAME"
            log "ARCHIVE $NOTE_NAME → notes/archive/ | $REASON"
            ARCHIVED=$(( ARCHIVED + 1 ))
            ;;
        keep|*)
            log "KEEP $NOTE_NAME | $REASON"
            KEPT=$(( KEPT + 1 ))
            ;;
    esac

    # Brief pause between API calls
    sleep 0.5
done

log "Done. Merged: $MERGED | Kept: $KEPT | Archived: $ARCHIVED | MITRE: $MITRED"
