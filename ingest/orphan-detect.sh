#!/bin/bash
# orphan-detect.sh — Find notes with zero inbound AND zero outbound [[wikilinks]]
#
# Output: markdown section suitable for weekly digest
# Flags:  --slack    post result to $SLACK_WEBHOOK_URL
#         --quiet    suppress stdout (log only)
#
# Called by: hooks/weekly-rollup.sh (weekly digest)
# Log: ingest/wikilink-ingest.log (shared with wikilink-ingest.sh)

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
NOTES_DIR="$VIRGIL_DIR/notes"
LOGFILE="$VIRGIL_DIR/ingest/wikilink-ingest.log"
LOGPREFIX="[orphan-detect $(date '+%Y-%m-%d %H:%M')]"

SLACK=0
QUIET=0

for arg in "$@"; do
    case "$arg" in
        --slack) SLACK=1 ;;
        --quiet) QUIET=1 ;;
    esac
done

log() { echo "$LOGPREFIX $*" >> "$LOGFILE"; }

# ── Python: find orphans ──────────────────────────────────────────────────────
REPORT=$(python3 - <<'PYEOF'
import os, re, sys
from pathlib import Path

notes_dir = Path(os.environ.get("NOTES_DIR", ""))
if not notes_dir.exists():
    print("_Notes directory not found._")
    sys.exit(0)

# Collect all note files (max depth 2)
all_notes = {}
for root, dirs, files in os.walk(notes_dir):
    depth = len(Path(root).relative_to(notes_dir).parts)
    if depth > 1:
        dirs.clear()
        continue
    for fname in files:
        if fname.endswith('.md') and not fname.startswith('.'):
            title = fname[:-3]
            all_notes[title] = Path(root) / fname

if not all_notes:
    print("_No notes found._")
    sys.exit(0)

WIKILINK_RE = re.compile(r'\[\[([^\]|#]+?)(?:\|[^\]]*)?\]\]')

# Build outbound link map: title → set of titles it links to
outbound = {}
for title, path in all_notes.items():
    try:
        text = path.read_text(encoding='utf-8')
    except Exception:
        outbound[title] = set()
        continue
    links = set(m.group(1).strip() for m in WIKILINK_RE.finditer(text))
    # Resolve to known note titles (case-insensitive)
    resolved = set()
    title_lower = {t.lower(): t for t in all_notes}
    for link in links:
        if link in all_notes:
            resolved.add(link)
        elif link.lower() in title_lower:
            resolved.add(title_lower[link.lower()])
    outbound[title] = resolved

# Build inbound map: title → set of titles that link to it
inbound = {t: set() for t in all_notes}
for src, targets in outbound.items():
    for tgt in targets:
        if tgt in inbound:
            inbound[tgt].add(src)

# Find orphans: zero inbound AND zero outbound
orphans = sorted([
    t for t in all_notes
    if not inbound[t] and not outbound[t]
])

total = len(all_notes)
orphan_count = len(orphans)

lines = [f"## Orphaned Notes ({orphan_count} of {total})\n"]
if not orphans:
    lines.append("_No orphaned notes — all notes have at least one link._\n")
else:
    lines.append(f"_Notes with zero inbound and zero outbound [[wikilinks]]._\n")
    for t in orphans:
        rel = str(all_notes[t].relative_to(notes_dir))
        lines.append(f"- [[{t}]] — `notes/{rel}`")

print('\n'.join(lines))
PYEOF
)

NOTES_DIR="$NOTES_DIR" python3 - <<'PYEOF' 2>/dev/null || REPORT="_(orphan-detect: python error)_"
PYEOF
# Re-run with env var
REPORT=$(NOTES_DIR="$NOTES_DIR" python3 - << 'PYEOF'
import os, re, sys
from pathlib import Path

notes_dir = Path(os.environ["NOTES_DIR"])
if not notes_dir.exists():
    print("_Notes directory not found._")
    sys.exit(0)

all_notes = {}
for root, dirs, files in os.walk(notes_dir):
    depth = len(Path(root).relative_to(notes_dir).parts)
    if depth > 1:
        dirs.clear()
        continue
    for fname in files:
        if fname.endswith('.md') and not fname.startswith('.'):
            title = fname[:-3]
            all_notes[title] = Path(root) / fname

WIKILINK_RE = re.compile(r'\[\[([^\]|#]+?)(?:\|[^\]]*)?\]\]')

outbound = {}
for title, path in all_notes.items():
    try:
        text = path.read_text(encoding='utf-8')
    except Exception:
        outbound[title] = set()
        continue
    links = set(m.group(1).strip() for m in WIKILINK_RE.finditer(text))
    title_lower = {t.lower(): t for t in all_notes}
    resolved = set()
    for link in links:
        if link in all_notes:
            resolved.add(link)
        elif link.lower() in title_lower:
            resolved.add(title_lower[link.lower()])
    outbound[title] = resolved

inbound = {t: set() for t in all_notes}
for src, targets in outbound.items():
    for tgt in targets:
        if tgt in inbound:
            inbound[tgt].add(src)

orphans = sorted([t for t in all_notes if not inbound[t] and not outbound[t]])
total = len(all_notes)
orphan_count = len(orphans)

lines = [f"## Orphaned Notes ({orphan_count} of {total})\n"]
if not orphans:
    lines.append("_No orphaned notes — all notes have at least one link._\n")
else:
    lines.append("_Notes with zero inbound and zero outbound [[wikilinks]]._\n")
    for t in orphans:
        rel = str(all_notes[t].relative_to(notes_dir))
        lines.append(f"- [[{t}]] — `notes/{rel}`")

print('\n'.join(lines))
PYEOF
)

[[ $QUIET -eq 0 ]] && echo "$REPORT"
log "$(echo "$REPORT" | head -1)"

# ── Optional Slack post ───────────────────────────────────────────────────────
if [[ $SLACK -eq 1 ]] && [[ -n "${SLACK_WEBHOOK_URL:-}" ]]; then
    SLACK_MSG="VIRGIL orphan-detect: $(echo "$REPORT" | head -1)"$'\n'"$(echo "$REPORT" | tail -n +2 | head -10)"
    PAYLOAD=$(python3 -c "import json,sys; print(json.dumps({'text': sys.argv[1]}))" "$SLACK_MSG")
    curl -s -o /dev/null --max-time 10 \
        -X POST "$SLACK_WEBHOOK_URL" \
        -H "Content-Type: application/json" \
        -d "$PAYLOAD" || true
    log "Slack notification sent"
fi
