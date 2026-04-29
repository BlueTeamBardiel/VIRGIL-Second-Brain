#!/bin/bash
# review.sh — Spaced repetition dashboard using SM-2 over quiz-scores.json
# Usage: bash hooks/review.sh
# Alias: virgil-review

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
SCORES_FILE="$VIRGIL_DIR/logs/quiz-scores.json"
TODAY=$(date '+%Y-%m-%d')

if [[ ! -f "$SCORES_FILE" ]]; then
    printf '══════════════════════════════════════════\n'
    printf '  VIRGIL Review Session — %s\n' "$TODAY"
    printf '══════════════════════════════════════════\n'
    printf '  No quiz history found at %s\n' "$SCORES_FILE"
    printf '  Run virgil-quiz to start building your study record.\n'
    printf '══════════════════════════════════════════\n'
    exit 0
fi

# Write top-due topic to a tmpfile so bash can read it for the interactive prompt
TMPFILE=$(mktemp)

SCORES_FILE="$SCORES_FILE" TODAY="$TODAY" VIRGIL_DIR="$VIRGIL_DIR" TMPFILE="$TMPFILE" \
python3 <<'PYEOF'
import json, os, sys
from datetime import date, timedelta
from pathlib import Path

SCORES_FILE = Path(os.environ["SCORES_FILE"])
TODAY_STR    = os.environ["TODAY"]
TMPFILE      = os.environ["TMPFILE"]
today        = date.fromisoformat(TODAY_STR)

# ── Load and validate scores ─────────────────────────────────────────────────
try:
    scores = json.loads(SCORES_FILE.read_text() or "{}")
except Exception as e:
    print(f"  Error reading scores: {e}")
    sys.exit(1)

# ── SM-2: compute / refresh interval_days and next_review ────────────────────
def sm2_interval(entry: dict) -> float:
    score  = entry.get("score", 0)
    out_of = entry.get("out_of", 5)
    prev   = float(entry.get("interval_days", 1))
    ratio  = score / out_of if out_of > 0 else 0
    if ratio >= 0.8:
        return max(1.0, prev * 2.5)
    elif ratio >= 0.6:
        return max(1.0, prev * 1.5)
    else:
        return 1.0

updated = False
for topic, entry in scores.items():
    if not isinstance(entry, dict) or not entry.get("last_tested"):
        continue
    interval   = sm2_interval(entry)
    new_ivl    = round(interval, 1)
    last_tested = date.fromisoformat(entry["last_tested"])
    next_review = (last_tested + timedelta(days=int(interval))).isoformat()
    if entry.get("interval_days") != new_ivl or entry.get("next_review") != next_review:
        entry["interval_days"] = new_ivl
        entry["next_review"]   = next_review
        updated = True

if updated:
    SCORES_FILE.write_text(json.dumps(scores, indent=2, sort_keys=True))

# ── Categorize due vs upcoming ───────────────────────────────────────────────
due    = []  # (overdue_days, topic, score, out_of)
coming = []  # (days_away, topic, score, out_of)

for topic, entry in scores.items():
    if not isinstance(entry, dict) or not entry.get("next_review"):
        continue
    next_review = date.fromisoformat(entry["next_review"])
    days_diff   = (today - next_review).days  # positive = overdue
    score       = entry.get("score", 0)
    out_of      = entry.get("out_of", 5)
    if days_diff >= 0:
        due.append((days_diff, topic, score, out_of))
    else:
        coming.append((-days_diff, topic, score, out_of))

due.sort(reverse=True)   # most overdue first
coming.sort()             # soonest first

# ── Print table ───────────────────────────────────────────────────────────────
print("══════════════════════════════════════════")
print(f"  VIRGIL Review Session — {TODAY_STR}")
print("══════════════════════════════════════════")

if not due and not coming:
    print("  No review history yet. Run virgil-quiz to start.")
    print("══════════════════════════════════════════")
    sys.exit(0)

if due:
    label = f"  Due today ({len(due)} topic{'s' if len(due) != 1 else ''}):"
    print(label)
    for i, (overdue_days, topic, score, out_of) in enumerate(due, 1):
        if overdue_days == 0:
            timing = "due: today      "
        elif overdue_days == 1:
            timing = "overdue: 1 day  "
        else:
            timing = f"overdue: {overdue_days} days"
        print(f"  {i:2d}. {topic:<28} last: {score}/{out_of}  {timing:<18}  → run: virgil-quiz \"{topic}\"")
else:
    print("  Nothing due today. 🎉")

if coming:
    print()
    print("  Coming up:")
    for i, (days_away, topic, score, out_of) in enumerate(coming[:5], len(due) + 1):
        timing = f"due in: {days_away} day{'s' if days_away != 1 else ''}"
        print(f"  {i:2d}. {topic:<28} {timing}")

print("══════════════════════════════════════════")
if due:
    print(f"  Run 'virgil-quiz \"{due[0][1]}\"' to start a quiz, or press Enter to quiz the top item.")

# ── Write top topic for bash interactive prompt ───────────────────────────────
if due:
    with open(TMPFILE, "w") as f:
        f.write(due[0][1])
PYEOF

# ── Interactive prompt ────────────────────────────────────────────────────────
TOP_TOPIC=$(cat "$TMPFILE" 2>/dev/null || true)
rm -f "$TMPFILE"

if [[ -n "$TOP_TOPIC" ]]; then
    printf '\n'
    read -rp "  Quiz the top overdue topic now? (y/N): " ANSWER < /dev/tty 2>/dev/tty || true
    if [[ "${ANSWER,,}" == "y" ]]; then
        exec bash "$VIRGIL_DIR/hooks/quiz.sh" "$TOP_TOPIC"
    fi
fi
