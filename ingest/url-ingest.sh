#!/bin/bash
# url-ingest.sh — Fetch a URL and patch it into the VIRGIL knowledge vault
#
# Usage: virgil-url <url> [topic-hint]
#
# Fetches the URL with curl+pandoc, truncates to 6000 chars, calls Claude Haiku
# to decide whether to patch an existing note or create a new one.
#
# Output:
#   NEW         → notes/inbox/<slug>.md
#   patch found → appends section to existing note
#
# Log: ingest/url-ingest.log
# Deps: curl, pandoc, python3

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
NOTES_DIR="$VIRGIL_DIR/notes"
INBOX_DIR="$NOTES_DIR/inbox"
MITRE_DIR="$NOTES_DIR/mitre"
LOGFILE="$VIRGIL_DIR/ingest/url-ingest.log"
LOGPREFIX="[url-ingest $(date '+%Y-%m-%d %H:%M')]"
API_URL="https://api.anthropic.com/v1/messages"
MODEL="claude-haiku-4-5-20251001"
MAX_CONTENT_CHARS=6000

log() { echo "$LOGPREFIX $*" | tee -a "$LOGFILE"; }
die() { log "ERROR: $*"; exit 1; }

# ── Args ──────────────────────────────────────────────────────────────────────
if [[ $# -lt 1 ]]; then
    echo "Usage: virgil-url <url> [topic-hint]" >&2
    exit 1
fi

URL="$1"
TOPIC_HINT="${2:-}"

# ── URL validation ────────────────────────────────────────────────────────────
# Block non-HTTP(S) schemes — prevents file://, ftp://, ssrf vectors
if [[ ! "$URL" =~ ^https?:// ]]; then
    echo "[url-ingest] ERROR: Only http:// and https:// URLs are supported." >&2
    echo "[url-ingest] Received: $URL" >&2
    exit 1
fi

# Block private/local IP ranges — prevents SSRF to internal services
HOSTNAME=$(python3 -c "
from urllib.parse import urlparse
import sys
print(urlparse(sys.argv[1]).hostname or '')
" "$URL" 2>/dev/null)

if python3 -c "
import ipaddress, sys
try:
    ip = ipaddress.ip_address(sys.argv[1])
    if ip.is_private or ip.is_loopback or ip.is_link_local:
        sys.exit(1)
except ValueError:
    pass  # hostname, not IP — allow
sys.exit(0)
" "$HOSTNAME" 2>/dev/null; then
    : # IP is public or it's a hostname — continue
else
    echo "[url-ingest] ERROR: Private/loopback IP addresses are not allowed." >&2
    exit 1
fi

# Blocklist — add domains that should never be ingested
BLOCKLIST=("localhost" "127.0.0.1" "0.0.0.0" "metadata.google.internal" \
           "169.254.169.254" "::1")
for blocked in "${BLOCKLIST[@]}"; do
    if [[ "${HOSTNAME,,}" == "$blocked" ]]; then
        echo "[url-ingest] ERROR: Blocked hostname: $HOSTNAME" >&2
        exit 1
    fi
done

# ── Prereqs ───────────────────────────────────────────────────────────────────
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    ANTHROPIC_API_KEY=$(crontab -l 2>/dev/null | grep 'ANTHROPIC_API_KEY' | cut -d'"' -f2 | head -1)
    [[ -n "$ANTHROPIC_API_KEY" ]] && export ANTHROPIC_API_KEY
fi
[[ -n "${ANTHROPIC_API_KEY:-}" ]] || die "ANTHROPIC_API_KEY is not set."
command -v pandoc &>/dev/null || die "pandoc not found. Install: sudo apt install pandoc"

log "Fetching: $URL"

# ── Fetch + convert to plain text ────────────────────────────────────────────
RAW_HTML=$(curl -sL --max-time 30 --user-agent "Mozilla/5.0 (compatible; VIRGIL/1.0)" "$URL" 2>/dev/null) \
    || die "curl failed fetching $URL"

[[ -n "$RAW_HTML" ]] || die "Empty response from $URL"

PLAIN_TEXT=$(echo "$RAW_HTML" | pandoc -f html -t plain --wrap=none 2>/dev/null \
    | head -c "$MAX_CONTENT_CHARS") \
    || die "pandoc conversion failed"

[[ -n "$PLAIN_TEXT" ]] || die "pandoc returned empty text for $URL"

CHAR_COUNT=${#PLAIN_TEXT}
log "Extracted ${CHAR_COUNT} chars after truncation"

# ── Build list of existing note titles ────────────────────────────────────────
TITLE_LIST=$(find "$NOTES_DIR" -maxdepth 2 -name "*.md" ! -name ".*" \
    -printf "%f\n" 2>/dev/null | sed 's/\.md$//' | sort | head -200)

# ── Python: call Claude Haiku, parse JSON response ───────────────────────────
_TMPPY=$(mktemp /tmp/virgil-url-XXXXXX.py)
trap "rm -f $_TMPPY" EXIT

cat > "$_TMPPY" <<'PYEOF'
import json, os, sys, urllib.request, urllib.error
from pathlib import Path

API_URL  = os.environ["API_URL"]
MODEL    = os.environ["MODEL"]
URL      = os.environ["URL"]
HINT     = os.environ.get("TOPIC_HINT", "")
LOGPFX   = os.environ["LOGPREFIX"]

content      = sys.stdin.read()
title_list   = os.environ["TITLE_LIST"].strip()

hint_clause = f"\nTopic hint from user: {HINT}" if HINT else ""

prompt = f"""You are VIRGIL, a sysadmin's second brain. A URL has been fetched and its content extracted.

URL: {URL}{hint_clause}

Your tasks:
1. Decide whether this content should PATCH an existing note or create a NEW note.
   - Existing note titles (one per line):
{title_list}
   - If the content is clearly about one of these topics, set patch_target to that exact title.
   - Otherwise set patch_target to NEW.

2. Write a clean, concise Obsidian Markdown note or note section from the content.
   - Use [[wiki links]] for tools, protocols, hosts, and concepts.
   - If NEW: include a # Title heading, 2-sentence summary, structured sections, ## Tags at bottom.
   - If patching: write only a ## Source — <today's date> section to append (no top-level heading).
   - Be concise. Strip boilerplate, ads, nav menus.

3. If NEW, provide a short slug for the filename (lowercase, hyphens, no spaces, no .md).

Return ONLY valid JSON in this exact format:
{{
  "patch_target": "<exact note title from list, or NEW>",
  "slug": "<slug if NEW, else null>",
  "note_content": "<full markdown content as a single string with \\n for newlines>"
}}

Content from {URL}:

{content[:5000]}
"""

payload = json.dumps({
    "model": MODEL,
    "max_tokens": 2048,
    "messages": [{"role": "user", "content": prompt}]
}).encode()

req = urllib.request.Request(API_URL, data=payload, headers={
    "x-api-key":         os.environ["ANTHROPIC_API_KEY"],
    "anthropic-version": "2023-06-01",
    "content-type":      "application/json",
})

try:
    with urllib.request.urlopen(req, timeout=90) as r:
        body = json.loads(r.read())
    raw = body["content"][0]["text"].strip()
except urllib.error.HTTPError as e:
    print(f"[url-ingest-py] API HTTP {e.code}: {e.read().decode(errors='replace')}", file=sys.stderr)
    sys.exit(1)
except Exception as e:
    print(f"[url-ingest-py] API error: {e}", file=sys.stderr)
    sys.exit(1)

# Strip markdown code fences if Claude wrapped in ```json
if raw.startswith("```"):
    raw = "\n".join(raw.splitlines()[1:])
    if raw.endswith("```"):
        raw = raw[:-3]

try:
    result = json.loads(raw)
except json.JSONDecodeError as e:
    print(f"[url-ingest-py] JSON parse error: {e}\nRaw: {raw[:200]}", file=sys.stderr)
    sys.exit(1)

print(json.dumps(result))
PYEOF

RESULT=$(API_URL="$API_URL" MODEL="$MODEL" URL="$URL" TOPIC_HINT="$TOPIC_HINT" \
    LOGPREFIX="$LOGPREFIX" TITLE_LIST="$TITLE_LIST" \
    python3 "$_TMPPY" <<< "$PLAIN_TEXT" \
    2> >(while IFS= read -r line; do log "$line"; done)) \
    || die "Python helper failed"

[[ -n "$RESULT" ]] || die "Empty result from Claude"

# ── Parse result and route ────────────────────────────────────────────────────
PATCH_TARGET=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(d.get('patch_target','NEW'))" <<< "$RESULT")
SLUG=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(d.get('slug') or '')" <<< "$RESULT")
NOTE_CONTENT=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read()); print(d.get('note_content',''))" <<< "$RESULT")

if [[ "$PATCH_TARGET" == "NEW" ]]; then
    [[ -n "$SLUG" ]] || SLUG=$(echo "$URL" | sed 's|https\?://||' | tr '/' '-' | tr -cd 'a-z0-9-' | cut -c1-60)

    # ── MITRE fast-path: route ATT&CK technique notes to notes/mitre/ ─────────
    if [[ "$SLUG" =~ ^t[0-9]{4} ]] || [[ "$URL" == *"attack.mitre.org"* ]]; then
        mkdir -p "$MITRE_DIR"
        OUTPUT_FILE="$MITRE_DIR/${SLUG}.md"
        {
            printf '%s\n' "$NOTE_CONTENT"
            printf '\n---\n_Ingested: %s | Source: %s_\n' "$(date '+%Y-%m-%d %H:%M')" "$URL"
        } > "$OUTPUT_FILE"
        log "MITRE note written to $OUTPUT_FILE"
        echo "$OUTPUT_FILE"
    else
    # ── Standard inbox write ───────────────────────────────────────────────────
    mkdir -p "$INBOX_DIR"
    OUTPUT_FILE="$INBOX_DIR/${SLUG}.md"
    {
        printf '%s\n' "$NOTE_CONTENT"
        printf '\n---\n_Ingested: %s | Source: %s_\n' "$(date '+%Y-%m-%d %H:%M')" "$URL"
    } > "$OUTPUT_FILE"
    log "NEW note written to $OUTPUT_FILE"
    echo "$OUTPUT_FILE"
    fi
else
    # Find the matching note file
    NOTE_FILE=$(find "$NOTES_DIR" -maxdepth 2 -name "${PATCH_TARGET}.md" 2>/dev/null | head -1)
    if [[ -z "$NOTE_FILE" ]]; then
        log "WARNING: patch target '$PATCH_TARGET' not found on disk — falling back to inbox"
        mkdir -p "$INBOX_DIR"
        [[ -n "$SLUG" ]] || SLUG=$(echo "$PATCH_TARGET" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
        OUTPUT_FILE="$INBOX_DIR/${SLUG}-patch.md"
        printf '%s\n\n---\n_Source: %s_\n' "$NOTE_CONTENT" "$URL" >> "$OUTPUT_FILE"
        log "Fallback: written to $OUTPUT_FILE"
        echo "$OUTPUT_FILE"
    else
        {
            printf '\n'
            printf '%s\n' "$NOTE_CONTENT"
            printf '\n_Source: %s_\n' "$URL"
        } >> "$NOTE_FILE"
        log "Patched existing note: $NOTE_FILE"
        echo "$NOTE_FILE"
    fi
fi
