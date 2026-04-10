#!/bin/bash
# pdf-ingest.sh — Convert a PDF to an Obsidian knowledge note via Claude API
#
# Usage: pdf-ingest.sh [--first-pages N] <path-to-pdf> [output-subdir]
#
#   --first-pages N   Extract only the first N pages (useful for large books)
#   output-subdir     Subfolder under notes/knowledge/ (default: general)
#
# Output: notes/knowledge/<subdir>/<slug>.md
# Deps:   pdftotext (poppler-utils), python3, curl
#
# Chunking behaviour:
#   < 80k chars  → single API call
#   ≥ 80k chars  → chunk at 60k boundaries, summarise each chunk, synthesise

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
KNOWLEDGE_DIR="$VIRGIL_DIR/notes/knowledge"
LOGFILE="$VIRGIL_DIR/ingest/pdf-ingest.log"

log() {
    local msg="[pdf-ingest $(date '+%Y-%m-%d %H:%M')] $*"
    echo "$msg" | tee -a "$LOGFILE"
}

die() { log "ERROR: $*"; exit 1; }

# ── Arg parsing ───────────────────────────────────────────────────────────────
FIRST_PAGES=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --first-pages)
            [[ -n "${2:-}" ]] || die "--first-pages requires a numeric argument"
            FIRST_PAGES="$2"
            shift 2
            ;;
        --) shift; break ;;
        -*) die "Unknown flag: $1" ;;
        *)  break ;;
    esac
done

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 [--first-pages N] <path-to-pdf> [output-subdir]" >&2
    exit 1
fi

PDF_PATH="$1"
SUBDIR="${2:-general}"
OUTPUT_DIR="$KNOWLEDGE_DIR/$SUBDIR"

[[ -f "$PDF_PATH" ]] || die "File not found: $PDF_PATH"

# ── Prereqs ───────────────────────────────────────────────────────────────────
if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    eval "$(crontab -l 2>/dev/null | grep 'ANTHROPIC_API_KEY' | sed 's/^/export /')"
fi
[[ -n "${ANTHROPIC_API_KEY:-}" ]] || die "ANTHROPIC_API_KEY is not set."
command -v pdftotext &>/dev/null   || die "pdftotext not found. Install poppler-utils."

# ── Extract text ──────────────────────────────────────────────────────────────
PDF_BASENAME=$(basename "$PDF_PATH" .pdf)
SLUG=$(echo "$PDF_BASENAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
OUTPUT_FILE="$OUTPUT_DIR/${SLUG}.md"

mkdir -p "$OUTPUT_DIR"

if [[ -n "$FIRST_PAGES" ]]; then
    log "Extracting first $FIRST_PAGES page(s) from: $PDF_PATH"
    RAW_TEXT=$(pdftotext -layout -f 1 -l "$FIRST_PAGES" "$PDF_PATH" - 2>/dev/null)
else
    log "Extracting full text from: $PDF_PATH"
    RAW_TEXT=$(pdftotext -layout "$PDF_PATH" - 2>/dev/null)
fi

[[ -n "$RAW_TEXT" ]] || die "pdftotext returned no text. PDF may be image-only or encrypted."

CHAR_COUNT=${#RAW_TEXT}
log "Extracted $CHAR_COUNT characters${FIRST_PAGES:+ (first $FIRST_PAGES pages)}"

# ── Python helper (chunking + API) ────────────────────────────────────────────
_TMPPY=$(mktemp /tmp/virgil-pdf-XXXXXX.py)
trap "rm -f $_TMPPY" EXIT

cat > "$_TMPPY" <<'PYEOF'
import json, os, sys, time, urllib.request, urllib.error

CHUNK_THRESHOLD = 80_000
CHUNK_SIZE      = 60_000
API_URL  = "https://api.anthropic.com/v1/messages"
MODEL    = "claude-haiku-4-5-20251001"

def log(msg):
    print(f"[pdf-ingest-py] {msg}", file=sys.stderr, flush=True)

def api_call(prompt, max_tokens=4096, attempt=1):
    api_key = os.environ["ANTHROPIC_API_KEY"]
    payload = json.dumps({
        "model": MODEL,
        "max_tokens": max_tokens,
        "messages": [{"role": "user", "content": prompt}]
    }).encode()
    req = urllib.request.Request(API_URL, data=payload, headers={
        "x-api-key": api_key,
        "anthropic-version": "2023-06-01",
        "content-type": "application/json",
    })
    try:
        with urllib.request.urlopen(req, timeout=180) as r:
            body = json.loads(r.read())
        text = body["content"][0]["text"]
        if not text.strip():
            raise ValueError("Claude returned empty content")
        return text
    except urllib.error.HTTPError as e:
        err_body = e.read().decode(errors="replace")
        raise RuntimeError(f"HTTP {e.code}: {err_body}") from e

def chunk_text(text, size):
    """Split text into chunks, preferring paragraph breaks near boundaries."""
    chunks = []
    while len(text) > size:
        boundary = text.rfind('\n\n', size // 2, size)
        if boundary == -1:
            boundary = text.rfind('\n', size // 2, size)
        if boundary == -1:
            boundary = size
        chunks.append(text[:boundary])
        text = text[boundary:].lstrip('\n')
    if text.strip():
        chunks.append(text)
    return chunks

def single_call(raw_text, pdf_name):
    log(f"Single-call mode — {len(raw_text):,} chars")
    prompt = (
        f"You are a second-brain assistant for you, a sysadmin/homelab operator studying for your certs.\n"
        f"Convert the following extracted PDF text into a clean Obsidian Markdown knowledge note.\n\n"
        f"Document: {pdf_name}\n\n"
        f"Rules:\n"
        f"- Start with a level-1 heading using the document title (infer from content if needed).\n"
        f"- Add a brief 2–3 sentence summary under the heading.\n"
        f"- Extract key concepts, commands, procedures, and facts as structured sections.\n"
        f"- Use [[wiki links]] for tools, protocols, and concepts (e.g., [[VLAN]], [[Routing]], [[NIST]]).\n"
        f"- Add a ## Tags section at the bottom with relevant tags (no # prefix).\n"
        f"- Be concise. Omit cover pages, legal notices, and filler.\n\n"
        f"PDF text:\n\n{raw_text}"
    )
    return api_call(prompt, max_tokens=4096)

def chunked_call(raw_text, pdf_name):
    chunks = chunk_text(raw_text, CHUNK_SIZE)
    total  = len(chunks)
    log(f"Chunked mode — {len(raw_text):,} chars across {total} chunk(s) of ~{CHUNK_SIZE:,}")

    summaries = []
    for i, chunk in enumerate(chunks, 1):
        log(f"  Chunk {i}/{total} — {len(chunk):,} chars")
        prompt = (
            f"You are extracting structured knowledge from a technical document for you, "
            f"a sysadmin studying for CySA+ and CCNA.\n\n"
            f"Document: \"{pdf_name}\" — Chunk {i} of {total}\n\n"
            f"Extract from this chunk:\n"
            f"- Key concepts and their definitions\n"
            f"- Chapter or section topics covered\n"
            f"- Commands, syntax, or procedures\n"
            f"- Exam-relevant facts (numbers, rules, protocols, comparisons)\n"
            f"- Any important tables or structured data\n\n"
            f"Format as concise bullet points grouped by topic/section. "
            f"Use [[wiki links]] for technical terms (e.g., [[VLAN]], [[STP]], [[OSI]]).\n"
            f"Do not write an intro or outro — extract facts only.\n\n"
            f"Chunk {i}/{total}:\n\n{chunk}"
        )
        summary = api_call(prompt, max_tokens=2048)
        summaries.append(f"### Chunk {i}/{total}\n\n{summary}")
        if i < total:
            time.sleep(0.8)

    log(f"Synthesising {total} chunk summaries into final note...")
    combined = "\n\n---\n\n".join(summaries)
    synthesis_prompt = (
        f"You are a second-brain assistant for you, a sysadmin studying for CySA+ and CCNA.\n"
        f"The following are structured summaries extracted from {total} sequential chunks of:\n"
        f"\"{pdf_name}\"\n\n"
        f"Synthesise these into a single, well-structured Obsidian Markdown knowledge note.\n\n"
        f"Rules:\n"
        f"- Start with a level-1 heading using the document title.\n"
        f"- Add a 2–3 sentence summary of the whole document.\n"
        f"- Organise content into logical sections (by chapter, topic, or domain).\n"
        f"- Deduplicate — merge the same concept if it appears in multiple chunks.\n"
        f"- Use [[wiki links]] for tools, protocols, and concepts.\n"
        f"- Include a ## Key Commands or ## Key Facts section if applicable.\n"
        f"- Add a ## Tags section at the bottom.\n"
        f"- Be thorough but concise — this is a study reference, not a transcript.\n\n"
        f"Chunk summaries:\n\n{combined}"
    )
    return api_call(synthesis_prompt, max_tokens=8192)

# ── Main ──────────────────────────────────────────────────────────────────────
pdf_name = sys.argv[1]
raw_text = sys.stdin.read()

if len(raw_text) < CHUNK_THRESHOLD:
    note = single_call(raw_text, pdf_name)
else:
    note = chunked_call(raw_text, pdf_name)

print(note)
PYEOF

# ── Run the helper ────────────────────────────────────────────────────────────
if [[ $CHAR_COUNT -ge 80000 ]]; then
    log "Large PDF — chunked mode (${CHAR_COUNT} chars)"
else
    log "Standard PDF — single-call mode (${CHAR_COUNT} chars)"
fi

NOTE=$(echo "$RAW_TEXT" | python3 "$_TMPPY" "$PDF_BASENAME" 2> >(while IFS= read -r line; do log "$line"; done))

[[ -n "$NOTE" ]] || die "Python helper returned empty output."

# ── Write note ────────────────────────────────────────────────────────────────
{
    printf '%s\n' "$NOTE"
    printf '\n---\n_Ingested: %s | Source: %s%s_\n' \
        "$(date '+%Y-%m-%d %H:%M')" \
        "$PDF_PATH" \
        "${FIRST_PAGES:+ (first $FIRST_PAGES pages)}"
} > "$OUTPUT_FILE"

log "Written to $OUTPUT_FILE"

# ── Slack notify ──────────────────────────────────────────────────────────────
if [[ -n "${SLACK_WEBHOOK_URL:-}" ]]; then
    MODE_NOTE=""
    [[ $CHAR_COUNT -ge 80000 ]] && MODE_NOTE=" (chunked)"
    [[ -n "$FIRST_PAGES" ]]     && MODE_NOTE="$MODE_NOTE (first $FIRST_PAGES pages)"
    SLACK_MSG="VIRGIL PDF ingest complete: *$PDF_BASENAME*${MODE_NOTE} → \`notes/knowledge/$SUBDIR/$SLUG.md\`"
    SLACK_PAYLOAD=$(python3 -c "import json,sys; print(json.dumps({'text': sys.argv[1]}))" "$SLACK_MSG")
    curl -s -o /dev/null --max-time 10 \
        -X POST "$SLACK_WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$SLACK_PAYLOAD" || true
fi

echo "$OUTPUT_FILE"
