#!/bin/bash
# cert-ingest.sh — Ingest certification study material into VIRGIL
#
# Usage:
#   virgil-cert-ingest pdf /path/to/book.pdf "CCNA"
#   virgil-cert-ingest url https://example.com/study-guide "Security+"
#   virgil-cert-ingest transcript /path/to/transcript.txt "A+"
#
# What it does:
#   1. Reads source material (PDF, URL, or text transcript)
#   2. Breaks it into chapter/topic chunks
#   3. Rewrites each chunk in VIRGIL's voice (Feynman style)
#      so it doesn't reproduce the original text verbatim
#   4. Saves as standardized Obsidian notes in notes/knowledge/[cert]/
#   5. Updates the cert chapter index

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
LOGS_DIR="$VIRGIL_DIR/logs"
TODAY=$(date +%Y-%m-%d)

# ── Source secrets ─────────────────────────────────────────────
VIRGIL_ENV="${HOME}/.config/virgil/.env"
if [[ -f "$VIRGIL_ENV" ]]; then
    set -a; source "$VIRGIL_ENV"; set +a
fi

MODE="${1:-}"
SOURCE="${2:-}"
CERT="${3:-}"

if [[ -z "$MODE" || -z "$SOURCE" || -z "$CERT" ]]; then
    echo "Usage: cert-ingest.sh <pdf|url|transcript> <source> <cert-name>"
    echo ""
    echo "Examples:"
    echo "  cert-ingest.sh pdf ~/books/ccna.pdf 'CCNA'"
    echo "  cert-ingest.sh url https://example.com/guide 'Security+'"
    echo "  cert-ingest.sh transcript ~/notes/aplus.txt 'A+'"
    echo ""
    echo "Output goes to: \$VIRGIL_DIR/notes/knowledge/[cert-slug]/"
    exit 1
fi

CERT_SLUG=$(echo "$CERT" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr '+' 'plus')
CERT_DIR="$VIRGIL_DIR/notes/knowledge/$CERT_SLUG"
mkdir -p "$CERT_DIR"
mkdir -p "$LOGS_DIR"

echo "[cert-ingest] Starting ingestion: $CERT from $MODE source"
echo "[cert-ingest] Output directory: $CERT_DIR"

# ── Read source content ─────────────────────────────────────────
case "$MODE" in
    pdf)
        if ! command -v pdftotext &>/dev/null; then
            echo "[cert-ingest] ERROR: pdftotext not found."
            echo "  Install with: sudo apt install poppler-utils"
            exit 1
        fi
        echo "[cert-ingest] Extracting text from PDF..."
        RAW_TEXT=$(pdftotext "$SOURCE" - 2>/dev/null)
        ;;
    url)
        if ! command -v curl &>/dev/null; then
            echo "[cert-ingest] ERROR: curl not found."
            exit 1
        fi
        echo "[cert-ingest] Fetching URL..."
        # Validate URL is http/https (SSRF protection)
        if [[ ! "$SOURCE" =~ ^https?:// ]]; then
            echo "[cert-ingest] ERROR: Only http/https URLs are allowed."
            exit 1
        fi
        RAW_TEXT=$(curl -fsSL --max-time 30 "$SOURCE" | python3 -c "
import sys, html, re
content = sys.stdin.read()
content = re.sub('<[^>]+>', ' ', content)
content = html.unescape(content)
content = re.sub(r'\s+', ' ', content)
print(content[:50000])
" 2>/dev/null)
        ;;
    transcript)
        if [[ ! -f "$SOURCE" ]]; then
            echo "[cert-ingest] ERROR: File not found: $SOURCE"
            exit 1
        fi
        echo "[cert-ingest] Reading transcript..."
        RAW_TEXT=$(cat "$SOURCE")
        ;;
    *)
        echo "[cert-ingest] ERROR: Unknown mode '$MODE'. Use: pdf, url, or transcript"
        exit 1
        ;;
esac

if [[ -z "${RAW_TEXT:-}" ]]; then
    echo "[cert-ingest] ERROR: No content extracted from source."
    exit 1
fi

echo "[cert-ingest] Content loaded ($(echo "$RAW_TEXT" | wc -c) bytes)"

# ── Split into chunks and process via LLM ──────────────────────
echo "[cert-ingest] Processing content with AI..."

python3 << PYEOF
import os, sys, json, re
from pathlib import Path

VIRGIL_DIR = Path(os.environ.get("VIRGIL_DIR", str(Path.home() / "VIRGIL")))
CERT_DIR = Path("$CERT_DIR")
CERT_NAME = "$CERT"
TODAY = "$TODAY"

raw_text = r"""$(echo "$RAW_TEXT" | head -c 40000 | sed "s/\\\"\\\"\\\"/'''/g")"""

sys.path.insert(0, str(VIRGIL_DIR / "hooks"))
try:
    from llm_client import ask, LLMError
except ImportError:
    print("[cert-ingest] ERROR: llm_client.py not found in hooks/.")
    print("  Is VIRGIL installed correctly? Check hooks/llm_client.py exists.")
    sys.exit(1)

# ── Identify structure ──────────────────────────────────────────
structure_prompt = f"""Analyze this study material for {CERT_NAME} certification.

Source material (first 8000 chars):
{raw_text[:8000]}

Identify the main chapters or topics. Return ONLY a JSON array, no other text:
[
  {{"chapter": 1, "title": "Chapter title", "start_marker": "first few unique words of this chapter"}},
  ...
]
Maximum 20 items. If chapters are not clearly marked, group into logical topics."""

try:
    structure_raw = ask(structure_prompt, max_tokens=2000, timeout=60)
    m = re.search(r'\[.*?\]', structure_raw, re.DOTALL)
    chapters = json.loads(m.group(0)) if m else []
    if not chapters:
        raise ValueError("Empty structure returned")
except Exception as e:
    print(f"[cert-ingest] WARNING: Could not detect structure ({e}), using single-topic fallback")
    chapters = [{"chapter": 1, "title": "Overview", "start_marker": ""}]

print(f"[cert-ingest] Detected {len(chapters)} chapter(s)/topic(s)")

# ── Process each chapter ────────────────────────────────────────
written = []
for ch in chapters:
    chapter_num = ch.get("chapter", 1)
    chapter_title = ch.get("title", f"Chapter {chapter_num}")
    start_marker = ch.get("start_marker", "")

    # Extract relevant portion
    if start_marker and start_marker in raw_text:
        idx = raw_text.index(start_marker)
        chunk = raw_text[idx:idx + 6000]
    else:
        chunk_size = max(len(raw_text) // max(len(chapters), 1), 1000)
        start_idx = (chapter_num - 1) * chunk_size
        chunk = raw_text[start_idx:start_idx + 6000]

    rewrite_prompt = f"""You are VIRGIL, a cybersecurity study companion teaching {CERT_NAME}.

Rewrite this study material for Chapter {chapter_num}: {chapter_title}.

CRITICAL RULES:
1. Do NOT copy any sentence from the source verbatim — rewrite completely in your own words
2. Feynman method: give a real-world analogy BEFORE the technical definition for every concept
3. Structure the note exactly as shown in the template below
4. Add [[wikilinks]] around technical terms that deserve their own notes
5. Write as if teaching a student — conversational but precise
6. The quiz questions must come from the actual content, not be generic

Source material to rewrite (do not plagiarize):
{chunk}

Output this complete Obsidian note:

---
tags: [knowledge, {CERT_NAME.lower().replace(' ', '-').replace('+', 'plus')}, chapter-{chapter_num}]
created: {TODAY}
cert: {CERT_NAME}
chapter: {chapter_num}
---

# Chapter {chapter_num}: {chapter_title}

> Part of [[{CERT_NAME}]] study notes | [[VIRGIL]] second brain

## What This Chapter Is Actually About

[2-3 sentences: what problem does this chapter solve? Why is it in the cert?]

## Key Concepts

### [Concept 1]

**The analogy:** [Real-world comparison that makes the concept click before any jargon]

**Technical definition:** [Precise definition using correct terminology]

**How it works:** [Step-by-step plain English]

**Exam angle:** [One sentence: how CompTIA/Cisco tests this]

[Repeat for each major concept]

## Things That Trip People Up

- [Common confusion or misconception and why it's wrong]
- [Another trap]

## Quick Quiz

1. [Question] — A) ... B) ... C) ... D) ...
2. [Question] — A) ... B) ... C) ... D) ...
3. [Question] — A) ... B) ... C) ... D) ...

<details><summary>Answers</summary>
1. [Letter] — [One sentence explanation]
2. [Letter] — [One sentence explanation]
3. [Letter] — [One sentence explanation]
</details>

## Related

- [[{CERT_NAME}]]
- [[relevant-concept]]
"""

    try:
        print(f"[cert-ingest] Writing Ch.{chapter_num}: {chapter_title}...")
        note_content = ask(rewrite_prompt, max_tokens=3000, timeout=120)

        safe_title = re.sub(r'[^\w\s-]', '', chapter_title).strip().replace(' ', '-')
        filename = f"Chapter-{chapter_num:02d}-{safe_title}.md"
        note_path = CERT_DIR / filename
        note_path.write_text(note_content, encoding='utf-8')
        written.append((chapter_num, chapter_title, filename))
        print(f"[cert-ingest] ✓ {filename}")

    except Exception as e:
        print(f"[cert-ingest] ✗ Chapter {chapter_num} failed: {e}")
        continue

# ── Write chapter index ─────────────────────────────────────────
cert_slug = CERT_NAME.lower().replace(' ', '-').replace('+', 'plus')
index_lines = [
    f"---",
    f"tags: [knowledge, {cert_slug}, index]",
    f"created: {TODAY}",
    f"cert: {CERT_NAME}",
    f"---",
    f"",
    f"# {CERT_NAME} — Chapter Index",
    f"",
    f"> Generated by VIRGIL cert-ingest on {TODAY}",
    f"> Source: {os.path.basename('$SOURCE')}",
    f"",
    f"## Chapters",
    f"",
]
for num, title, fname in written:
    safe_fname = fname.replace('.md', '')
    index_lines.append(f"- [[{safe_fname}|Chapter {num}: {title}]]")

index_path = CERT_DIR / "index.md"
index_path.write_text('\n'.join(index_lines), encoding='utf-8')

print(f"")
print(f"[cert-ingest] ─────────────────────────────────────────────")
print(f"[cert-ingest] Complete: {len(written)}/{len(chapters)} chapters written")
print(f"[cert-ingest] Index:    {index_path}")
print(f"[cert-ingest] Vault:    {CERT_DIR}")
print(f"[cert-ingest] Next:     Run /teach to start studying")
PYEOF
