#!/bin/bash
# wikilink-ingest.sh — Nightly auto-wikilink injection for VIRGIL notes
#
# Scans notes modified in the last 24h, injects [[wikilinks]] in-place where
# any other note's title appears as a word. Safe: skips code blocks, headings,
# existing links, self-links, and titles shorter than 4 chars.
#
# Cron: 30 23 * * *   (runs before auto-reflect at 23:55 and promote at 02:00)
# Log:  ingest/wikilink-ingest.log
# Marker: notes/.wikilink-last-run

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
NOTES_DIR="$VIRGIL_DIR/notes"
LOGFILE="$VIRGIL_DIR/ingest/wikilink-ingest.log"
MARKER="$NOTES_DIR/.wikilink-last-run"
LOGPREFIX="[wikilink-ingest $(date '+%Y-%m-%d %H:%M')]"

log() { echo "$LOGPREFIX $*" | tee -a "$LOGFILE"; }

[[ -n "${ANTHROPIC_API_KEY:-}" ]] || true  # API key not needed for this script

# ── Find notes modified since last run ───────────────────────────────────────
if [[ -f "$MARKER" ]]; then
    FIND_ARGS=(-newer "$MARKER")
else
    # First run: process notes modified in last 24h
    FIND_ARGS=(-mmin -1440)
fi

mapfile -d '' MODIFIED < <(
    find "$NOTES_DIR" -maxdepth 2 -name "*.md" \
        ! -name ".wikilink-last-run" \
        "${FIND_ARGS[@]}" \
        -print0 2>/dev/null
)

if [[ ${#MODIFIED[@]} -eq 0 ]]; then
    log "No notes modified since last run. Exiting."
    touch "$MARKER"
    exit 0
fi

log "Processing ${#MODIFIED[@]} modified note(s)"

# ── Build title index (all .md filenames without extension) ──────────────────
_TMPPY=$(umask 0177; mktemp /tmp/virgil-wikilink-XXXXXX.py)
chmod 600 "$_TMPPY" 2>/dev/null || true
trap "rm -f $_TMPPY" EXIT

cat > "$_TMPPY" <<'PYEOF'
import os, re, sys
from pathlib import Path

notes_dir   = sys.argv[1]
target_file = sys.argv[2]
log_prefix  = sys.argv[3]

# Build index of all note titles (filename without .md, any depth up to 2)
all_titles = set()
for root, dirs, files in os.walk(notes_dir):
    # Limit to maxdepth 2
    depth = len(Path(root).relative_to(notes_dir).parts)
    if depth > 1:
        dirs.clear()
        continue
    for fname in files:
        if fname.endswith('.md') and not fname.startswith('.'):
            title = fname[:-3]  # strip .md
            if len(title) >= 4:
                all_titles.add(title)

# Self-title: exclude the target file's own name
self_title = Path(target_file).stem

# Sort longest-first so "Active Directory" matches before "Directory"
sorted_titles = sorted(all_titles - {self_title}, key=len, reverse=True)

if not sorted_titles:
    sys.exit(0)

text = Path(target_file).read_text(encoding='utf-8')
lines = text.splitlines(keepends=True)

in_code_block = False
injected = []
new_lines = []

for line in lines:
    # Track fenced code blocks
    stripped = line.strip()
    if stripped.startswith('```'):
        in_code_block = not in_code_block
        new_lines.append(line)
        continue

    if in_code_block:
        new_lines.append(line)
        continue

    # Skip heading lines
    if re.match(r'^#{1,6}\s', line):
        new_lines.append(line)
        continue

    # Skip lines that are pure frontmatter delimiters
    if stripped == '---':
        new_lines.append(line)
        continue

    new_line = line
    for title in sorted_titles:
        # Already linked? Skip.
        if f'[[{title}]]' in new_line:
            continue
        # Word-boundary match, case-insensitive, not already inside [[ ]]
        pattern = r'(?<!\[)(?<!\[)(\b' + re.escape(title) + r'\b)(?!\])'
        match = re.search(pattern, new_line, re.IGNORECASE)
        if match:
            # Replace first occurrence only per title per line
            def replacer(m):
                return f'[[{m.group(1)}]]'
            new_line_candidate = re.sub(pattern, replacer, new_line, count=1, flags=re.IGNORECASE)
            if new_line_candidate != new_line:
                injected.append(f"  {Path(target_file).name}: '{title}' on line starting '{line[:40].strip()}'")
                new_line = new_line_candidate

    new_lines.append(new_line)

new_text = ''.join(new_lines)
if new_text != text:
    Path(target_file).write_text(new_text, encoding='utf-8')
    for entry in injected:
        print(entry)

PYEOF

TOTAL_INJECTED=0

for NOTE_PATH in "${MODIFIED[@]}"; do
    [[ -f "$NOTE_PATH" ]] || continue
    NOTE_NAME=$(basename "$NOTE_PATH")

    OUTPUT=$(python3 "$_TMPPY" "$NOTES_DIR" "$NOTE_PATH" "$LOGPREFIX" 2>/dev/null || true)

    if [[ -n "$OUTPUT" ]]; then
        COUNT=$(echo "$OUTPUT" | wc -l)
        log "Injected $COUNT link(s) into $NOTE_NAME"
        echo "$OUTPUT" >> "$LOGFILE"
        TOTAL_INJECTED=$(( TOTAL_INJECTED + COUNT ))
    fi
done

touch "$MARKER"
log "Done. Total links injected: $TOTAL_INJECTED across ${#MODIFIED[@]} note(s)."
