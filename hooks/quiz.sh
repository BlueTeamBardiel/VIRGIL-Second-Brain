#!/bin/bash
# quiz.sh — Interactive 5-question quiz on a vault topic.
#
# Usage:
#   virgil-quiz "kerberoasting"
#   virgil-quiz                # picks a random vault topic
#
# Pulls the top 3 vault chunks for the topic, asks the LLM to write 5
# multiple-choice questions grounded in those chunks, runs them in the
# terminal with Feynman-style feedback, then updates
# logs/quiz-scores.json and appends the result to today's daily log.

set -euo pipefail

VIRGIL_DIR="${VIRGIL_DIR:-$HOME/VIRGIL}"
DAILY_LOGS_DIR="$VIRGIL_DIR/daily-logs"
LOGS_DIR="$VIRGIL_DIR/logs"
SCORES_FILE="$LOGS_DIR/quiz-scores.json"
TODAY=$(date +%Y-%m-%d)
LOG_FILE="$DAILY_LOGS_DIR/$TODAY.md"

mkdir -p "$LOGS_DIR" "$DAILY_LOGS_DIR"
[[ -f "$SCORES_FILE" ]] || echo '{}' > "$SCORES_FILE"
[[ -f "$LOG_FILE" ]] || printf '# VIRGIL Daily Log — %s\n\n---\n\n' "$TODAY" > "$LOG_FILE"

if [[ -z "${ANTHROPIC_API_KEY:-}" ]]; then
    eval "$(crontab -l 2>/dev/null | grep 'ANTHROPIC_API_KEY' | sed 's/^/export /' || true)"
fi

TOPIC_ARG="${1:-}"

TOPIC="$TOPIC_ARG" \
VIRGIL_DIR="$VIRGIL_DIR" \
SCORES_FILE="$SCORES_FILE" \
LOG_FILE="$LOG_FILE" \
TODAY="$TODAY" \
python3 <<'PYEOF'
import importlib.util, json, os, random, re, sys
from pathlib import Path

VIRGIL_DIR = Path(os.environ["VIRGIL_DIR"])
SCORES_FILE = Path(os.environ["SCORES_FILE"])
LOG_FILE = Path(os.environ["LOG_FILE"])
TODAY = os.environ["TODAY"]
topic = os.environ.get("TOPIC", "").strip()

sys.path.insert(0, str(VIRGIL_DIR / "hooks"))
from llm_client import ask, LLMError  # type: ignore

# Load chroma-query by path (hyphen in filename)
spec = importlib.util.spec_from_file_location(
    "chroma_query", VIRGIL_DIR / "ingest" / "chroma-query.py"
)
cq = importlib.util.module_from_spec(spec)
spec.loader.exec_module(cq)

# ── Open /dev/tty for user input ─────────────────────────────────────────────
# The bash wrapper feeds this Python via heredoc, so stdin is already at EOF
# by the time input() would run. Read answers from /dev/tty directly so the
# quiz works under aliases, pipes, and subprocess invocations.
try:
    TTY = open("/dev/tty", "r")
except OSError:
    print("[quiz] cannot open /dev/tty — this script needs an interactive terminal.",
          file=sys.stderr)
    sys.exit(1)


def prompt_answer() -> str:
    """Loop until the user gives A/B/C/D (or Q to quit). Blanks are ignored."""
    first = True
    while True:
        msg = ("Your answer (A/B/C/D, or q to quit): " if first
               else "Enter A, B, C, or D: ")
        sys.stdout.write(msg)
        sys.stdout.flush()
        line = TTY.readline()
        if not line:
            # Real EOF on /dev/tty — unusual; don't infinite-loop.
            print("\n[quiz] /dev/tty closed unexpectedly — aborting", file=sys.stderr)
            sys.exit(1)
        ans = line.strip().upper()
        if not ans:
            # Blank line: keep the original prompt, do not treat as invalid.
            continue
        if ans == "Q":
            print("Aborted.")
            sys.exit(0)
        if ans in {"A", "B", "C", "D"}:
            return ans
        first = False  # subsequent prompts show the short reminder


# ── Pick topic if none given ─────────────────────────────────────────────────
if not topic:
    candidates = [
        p for p in (VIRGIL_DIR / "notes" / "knowledge").rglob("*.md")
        if "/staging/" not in str(p) and p.stem.lower() not in {"index", "readme"}
    ]
    if not candidates:
        print("No vault notes found.", file=sys.stderr)
        sys.exit(1)
    pick = random.choice(candidates)
    topic = pick.stem.replace("-", " ").replace("_", " ")
    print(f"[quiz] random topic: {topic}")

print(f"\nVIRGIL Quiz — topic: {topic}\n" + "─" * 50)

# ── Pull top 3 chunks from Chroma ────────────────────────────────────────────
try:
    results = cq.query(topic, k=3)
except Exception as e:
    print(f"[quiz] ChromaDB query failed: {e}", file=sys.stderr)
    sys.exit(1)

if not results:
    print(f"[quiz] No vault content found for {topic!r}.", file=sys.stderr)
    sys.exit(1)

context = "\n\n".join(
    f"[source: {r['filename']}]\n{r['chunk'].strip()}" for r in results
)


# ── Ask the LLM for N questions, with a retry fallback ───────────────────────
def extract_questions(raw: str, expected: int) -> list | None:
    """Pull the JSON object out of the LLM response and return a clean list
    of question dicts, or None if we can't get a usable set."""
    m = re.search(r"\{.*\}", raw, re.DOTALL)
    if not m:
        return None
    try:
        data = json.loads(m.group(0))
    except Exception:
        return None
    qs = data.get("questions")
    if not isinstance(qs, list) or not qs:
        return None
    clean = []
    for q in qs[:expected]:
        if not isinstance(q, dict):
            continue
        if not all(k in q for k in ("q", "options", "correct")):
            continue
        opts = q.get("options") or {}
        if not all(letter in opts for letter in ("A", "B", "C", "D")):
            continue
        clean.append(q)
    return clean or None


def request_questions(n: int, max_tokens: int, simplify: bool) -> list | None:
    rules = (
        f"Return STRICT JSON of this shape and NOTHING else:\n"
        f'{{"questions":[{{"q":"...","options":{{"A":"...","B":"...","C":"...","D":"..."}},'
        f'"correct":"A","explanation":"..."}}, ...]}}\n\n'
        f"Rules:\n"
        f"- Exactly {n} questions. Exactly 4 options (A/B/C/D). One correct per question.\n"
        f"- Ground every question in the vault content. No generic trivia.\n"
    )
    if simplify:
        # Shorter output, less elaborate explanations — improves odds of a
        # complete JSON response inside the token budget.
        rules += "- Keep each 'explanation' to ONE sentence, under 200 characters.\n"
        rules += "- Keep each 'q' under 140 characters.\n"
        flavor = (
            f"You are VIRGIL. Build a concise {n}-question multiple-choice quiz on "
            f"{topic!r} from the vault content below. No preamble, no markdown, "
            f"no code fences — JSON only."
        )
    else:
        rules += "- Explanations must use analogy-before-definition style.\n"
        flavor = (
            f"You are VIRGIL, a Feynman-style teacher. Build a {n}-question "
            f"multiple-choice quiz on {topic!r} using ONLY the vault content "
            f"below — do not invent facts."
        )

    prompt = f"{flavor}\n\n{rules}\n=== VAULT CONTENT ===\n{context}\n"

    try:
        raw = ask(prompt, max_tokens=max_tokens, timeout=240)
    except LLMError:
        return None
    return extract_questions(raw, expected=n)


questions = request_questions(n=5, max_tokens=6000, simplify=False)
if not questions or len(questions) < 5:
    print("[quiz] first pass didn't return 5 clean questions — retrying with a "
          "shorter 3-question prompt…")
    questions = request_questions(n=3, max_tokens=6000, simplify=True)

if not questions:
    print("[quiz] the model couldn't produce a usable quiz (likely response "
          "truncation). Try again, or pick a topic with more vault coverage.",
          file=sys.stderr)
    sys.exit(1)

total_q = len(questions)

# ── Run the quiz interactively ───────────────────────────────────────────────
correct = 0
transcript: list[str] = []

for i, q in enumerate(questions, 1):
    print(f"\nQ{i}. {q['q']}")
    for letter in ("A", "B", "C", "D"):
        print(f"  {letter}. {q['options'].get(letter, '').strip()}")
    ans = prompt_answer()
    right = q.get("correct", "").upper()
    if ans == right:
        print("✓ Correct.")
        correct += 1
        mark = "✓"
    else:
        print(f"✗ Wrong. Correct: {right}.")
        mark = "✗"
    expl = (q.get("explanation") or "").strip()
    if expl:
        print(f"\n  {expl}\n")
    transcript.append(
        f"Q{i}. {q['q']}  →  your answer: {ans}  |  correct: {right}  {mark}"
    )

score_str = f"{correct}/{total_q}"
print("\n" + "─" * 50)
print(f"Final score on {topic}: {score_str}")

# ── Update quiz-scores.json ──────────────────────────────────────────────────
try:
    scores = json.loads(SCORES_FILE.read_text() or "{}")
except Exception:
    scores = {}

entry = scores.get(topic, {})
if not isinstance(entry, dict):
    entry = {}
entry["score"] = correct
entry["out_of"] = total_q
entry["last_tested"] = TODAY
entry["attempts"] = int(entry.get("attempts", 0)) + 1
scores[topic] = entry

SCORES_FILE.write_text(json.dumps(scores, indent=2, sort_keys=True))
print(f"[quiz] scores updated: {SCORES_FILE}")

# ── Append to daily log ──────────────────────────────────────────────────────
block = [
    "",
    f"## Quiz Result — {TODAY} — {topic}",
    "",
    f"**Score:** {score_str}  |  **Attempts total:** {entry['attempts']}",
    "",
    *[f"- {line}" for line in transcript],
    "",
]
with LOG_FILE.open("a", encoding="utf-8") as f:
    f.write("\n".join(block))
print(f"[quiz] appended to {LOG_FILE}")
PYEOF
