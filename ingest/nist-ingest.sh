#!/bin/bash
# nist-ingest.sh — Ingest a NIST publication PDF into notes/knowledge/nist/
# Thin wrapper around pdf-ingest.sh that sets the output subdir to nist/
# and adjusts the Claude prompt framing for NIST SP / FIPS documents.
# Usage: nist-ingest.sh <path-to-pdf>
# Output: notes/knowledge/nist/<slug>.md
# Deps: pdf-ingest.sh, pdftotext, curl, python3

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
INGEST_DIR="$VIRGIL_DIR/ingest"
KNOWLEDGE_DIR="$VIRGIL_DIR/notes/knowledge/nist"
LOGFILE="$VIRGIL_DIR/ingest/nist-ingest.log"
LOGPREFIX="[nist-ingest $(date '+%Y-%m-%d %H:%M')]"

log() { echo "$LOGPREFIX $*" | tee -a "$LOGFILE"; }

# ── Dynamic user config from CLAUDE.md ───────────────────────────────────────
user_name="the user"
current_cert="their current certification"
if [[ -f "$VIRGIL_DIR/CLAUDE.md" ]]; then
    _name=$(grep -m1 "^name:" "$VIRGIL_DIR/CLAUDE.md" | cut -d: -f2- | xargs 2>/dev/null || true)
    [[ -n "$_name" ]] && user_name="$_name"
    _cert=$(grep -Em1 "^(cert|current_cert):" "$VIRGIL_DIR/CLAUDE.md" | cut -d: -f2- | xargs 2>/dev/null || true)
    [[ -n "$_cert" ]] && current_cert="$_cert"
fi

# ── Args ──────────────────────────────────────────────────────────────────────
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <path-to-pdf>" >&2
    exit 1
fi

PDF_PATH="$1"

if [[ ! -f "$PDF_PATH" ]]; then
    log "ERROR: File not found: $PDF_PATH"
    exit 1
fi

if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    # shellcheck source=/dev/null
    set -a; source "$VIRGIL_DIR/.env" 2>/dev/null || true; set +a
fi
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    log "ERROR: ANTHROPIC_API_KEY is not set."
    exit 1
fi

if ! command -v pdftotext &>/dev/null; then
    log "ERROR: pdftotext not found. Install poppler-utils."
    exit 1
fi

# ── Extract text ──────────────────────────────────────────────────────────────
PDF_BASENAME=$(basename "$PDF_PATH" .pdf)
SLUG=$(echo "$PDF_BASENAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
OUTPUT_FILE="$KNOWLEDGE_DIR/${SLUG}.md"

mkdir -p "$KNOWLEDGE_DIR"

log "Extracting text from $PDF_PATH"
RAW_TEXT=$(pdftotext -layout "$PDF_PATH" - 2>/dev/null | head -c 15000)

if [[ -z "$RAW_TEXT" ]]; then
    log "ERROR: pdftotext returned no text."
    exit 1
fi

# ── Build NIST-specific prompt ────────────────────────────────────────────────
_TMPSCRIPT=$(umask 0177; mktemp /tmp/virgil-nist-XXXXXX.py)
chmod 600 "$_TMPSCRIPT" 2>/dev/null || true
trap "rm -f $_TMPSCRIPT" EXIT

cat > "$_TMPSCRIPT" <<'PYEOF'
import json, sys

pdf_name = sys.argv[1]
user_name = sys.argv[2] if len(sys.argv) > 2 and sys.argv[2] else "the user"
current_cert = sys.argv[3] if len(sys.argv) > 3 and sys.argv[3] else "their current certification"
raw_text = sys.stdin.read()

prompt = (
    f"You are a second-brain assistant for {user_name}, a sysadmin studying for {current_cert}.\n"
    f"Convert this NIST publication PDF into a structured Obsidian note optimized for CySA+ exam relevance.\n\n"
    f"Document: {pdf_name}\n\n"
    f"Required sections:\n"
    f"1. **Title + Publication ID** (e.g., NIST SP 800-53 Rev 5)\n"
    f"2. **Purpose / Scope** — 2-3 sentences\n"
    f"3. **Key Concepts** — bullet list of the most important controls, frameworks, or definitions\n"
    f"4. **{current_cert} Exam Relevance** — which exam objectives this covers (if inferrable)\n"
    f"5. **Control Families / Sections** — structured list of main sections or control families\n"
    f"6. **Actionable Takeaways** — how this applies to a blue team / SOC operator\n"
    f"7. **Tags** — include nist, cysa-plus, and relevant control-family or framework tags\n\n"
    f"Rules:\n"
    f"- Use [[wiki links]] for related NIST publications, frameworks (e.g., [[NIST CSF]], [[MITRE ATT&CK]]), and tools.\n"
    f"- Be concise. Focus on what a security analyst actually needs to know.\n"
    f"- Omit boilerplate, acknowledgements, and table of contents.\n\n"
    f"PDF text:\n\n{raw_text}"
)

payload = {
    "model": "claude-haiku-4-5-20251001",
    "max_tokens": 4096,
    "messages": [{"role": "user", "content": prompt}]
}

print(json.dumps(payload))
PYEOF

log "Calling Claude API (NIST framing)"
PAYLOAD=$(echo "$RAW_TEXT" | python3 "$_TMPSCRIPT" "$PDF_BASENAME" "$user_name" "$current_cert")

RESPONSE=$(curl -s -w "\n%{http_code}" \
    https://api.anthropic.com/v1/messages \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    -d "$PAYLOAD")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n -1)

if [[ "$HTTP_CODE" != "200" ]]; then
    log "ERROR: API call failed (HTTP $HTTP_CODE): $BODY"
    exit 1
fi

NOTE=$(python3 -c "
import json, sys
body = json.loads(sys.stdin.read())
print(body['content'][0]['text'])
" <<< "$BODY")

if [[ -z "$NOTE" ]]; then
    log "ERROR: Claude returned empty response."
    exit 1
fi

{
    printf '%s\n' "$NOTE"
    printf '\n---\n_Ingested: %s | Source: %s_\n' "$(date '+%Y-%m-%d %H:%M')" "$PDF_PATH"
} > "$OUTPUT_FILE"

log "Written to $OUTPUT_FILE"

if [[ -n "${SLACK_WEBHOOK_URL:-}" ]]; then
    SLACK_MSG="VIRGIL NIST ingest: *$PDF_BASENAME* → \`notes/knowledge/nist/$SLUG.md\`"
    SLACK_PAYLOAD=$(python3 -c "import json,sys; print(json.dumps({'text': sys.argv[1]}))" "$SLACK_MSG")
    curl -s -o /dev/null --max-time 10 \
        -X POST "$SLACK_WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$SLACK_PAYLOAD" || true
fi

echo "$OUTPUT_FILE"
