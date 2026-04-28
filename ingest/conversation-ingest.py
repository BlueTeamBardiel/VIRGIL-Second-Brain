#!/usr/bin/env python3
"""
conversation-ingest.py — Flask endpoint for ingesting Claude.ai conversations.

Accepts pasted conversation text, summarizes via llm_client, saves structured
note to notes/conversations/, and posts a Slack notification.

Port: 5002
"""

import json
import os
import sys
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent / "hooks"))
from llm_client import ask, LLMError

try:
    from flask import Flask, Request as FlaskRequest, request, Response
except ImportError:
    print("ERROR: Flask not installed. Run: pip install flask --break-system-packages", file=sys.stderr)
    sys.exit(1)

try:
    import requests as _requests
except ImportError:
    _requests = None  # type: ignore

VAULT = Path(__file__).parent.parent
CONV_DIR = VAULT / "notes" / "conversations"
LOG_FILE = VAULT / "logs" / "conversation-ingest.log"


class LargeRequest(FlaskRequest):
    max_form_memory_size = 50 * 1024 * 1024
    max_content_length = 50 * 1024 * 1024


app = Flask(__name__)
app.request_class = LargeRequest
app.config['MAX_CONTENT_LENGTH'] = 50 * 1024 * 1024  # 50MB max upload


# ── HTML ──────────────────────────────────────────────────────────────────────

PAGE = """\
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>VIRGIL — Conversation Ingest</title>
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    background: #1a1a1a; color: #e8e8e8;
    font-family: 'Courier New', Courier, monospace;
    padding: 2rem;
    max-width: 860px; margin: 0 auto;
  }}
  h1 {{ color: #a0c4ff; margin-bottom: 0.3rem; font-size: 1.4rem; }}
  p.sub {{ color: #888; font-size: 0.85rem; margin-bottom: 1.5rem; }}
  label {{ display: block; color: #ccc; margin-bottom: 0.3rem; font-size: 0.9rem; }}
  input[type=text] {{
    width: 100%; padding: 0.5rem 0.7rem;
    background: #262626; border: 1px solid #444; color: #e8e8e8;
    font-family: inherit; font-size: 0.95rem; border-radius: 4px;
    margin-bottom: 1.2rem;
  }}
  textarea {{
    width: 100%; padding: 0.6rem 0.8rem;
    background: #262626; border: 1px solid #444; color: #e8e8e8;
    font-family: inherit; font-size: 0.88rem; border-radius: 4px;
    resize: vertical; margin-bottom: 1.2rem;
  }}
  button {{
    background: #2563eb; color: #fff; border: none;
    padding: 0.6rem 1.4rem; font-family: inherit; font-size: 1rem;
    border-radius: 4px; cursor: pointer;
  }}
  button:hover {{ background: #1d4ed8; }}
  .msg {{ margin-top: 1.5rem; padding: 0.8rem 1rem; border-radius: 4px; }}
  .ok  {{ background: #14532d; color: #86efac; }}
  .err {{ background: #7f1d1d; color: #fca5a5; }}
  a {{ color: #a0c4ff; }}
</style>
</head>
<body>
<h1>VIRGIL — Conversation Ingest</h1>
<p class="sub">Paste a Claude.ai session to save a structured summary to the vault.</p>
{message}
<form method="POST" action="/ingest">
  <label for="title">Session title (optional)</label>
  <input type="text" id="title" name="title" placeholder="Leave blank to auto-generate from summary">
  <label for="body">Conversation transcript</label>
  <textarea id="body" name="body" rows="20" placeholder="Paste Claude.ai conversation here..."></textarea>
  <button type="submit">Ingest Conversation</button>
</form>
</body>
</html>
"""

SUCCESS_PAGE = """\
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>VIRGIL — Saved</title>
<style>
  body {{
    background: #1a1a1a; color: #e8e8e8;
    font-family: 'Courier New', Courier, monospace;
    padding: 2rem; max-width: 860px; margin: 0 auto;
  }}
  h1 {{ color: #86efac; margin-bottom: 1rem; }}
  p {{ margin-bottom: 0.6rem; color: #ccc; }}
  a {{ color: #a0c4ff; }}
  code {{ background: #262626; padding: 0.1rem 0.4rem; border-radius: 3px; }}
</style>
</head>
<body>
<h1>Saved</h1>
<p>Note written to <code>{rel_path}</code></p>
<p>Title: <strong>{title}</strong></p>
<p><a href="/">&larr; Ingest another</a></p>
</body>
</html>
"""


# ── Helpers ───────────────────────────────────────────────────────────────────

def log(message: str) -> None:
    LOG_FILE.parent.mkdir(parents=True, exist_ok=True)
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with LOG_FILE.open("a") as fh:
        fh.write(f"{ts} | {message}\n")


def slack_notify(message: str) -> None:
    url = os.environ.get("SLACK_WEBHOOK_URL")
    if not url or _requests is None:
        return
    try:
        _requests.post(url, data=json.dumps({"text": message}),
                       headers={"Content-Type": "application/json"}, timeout=10)
    except Exception:
        pass


def summarize(transcript: str) -> str:
    prompt = (
        "You are VIRGIL, a cybersecurity knowledge assistant. "
        "Analyze the following Claude.ai conversation transcript and produce a structured summary.\n\n"
        "Output exactly these sections (omit a section only if there is truly nothing to report):\n\n"
        "## Summary\n"
        "2-3 sentences describing what was worked on.\n\n"
        "## Key Decisions\n"
        "- Bullet list of decisions made.\n\n"
        "## Tasks Completed\n"
        "- Bullet list of tasks finished during this session.\n\n"
        "## Tasks Pending\n"
        "- Bullet list of open/unfinished tasks.\n\n"
        "## Key Facts & Configs\n"
        "- Bullet list of facts, configs, commands, or values worth remembering.\n\n"
        "Be concise and specific. Use wikilinks [[like this]] for tools and concepts.\n\n"
        f"--- TRANSCRIPT START ---\n{transcript[:12000]}\n--- TRANSCRIPT END ---"
    )
    return ask(prompt, max_tokens=1200, timeout=120)


def extract_title_from_summary(summary: str) -> str:
    for line in summary.splitlines():
        line = line.strip()
        if line and not line.startswith("#") and not line.startswith("-"):
            words = line.split()[:8]
            return " ".join(words).rstrip(".,;:")
    return "Claude session"


# ── Routes ────────────────────────────────────────────────────────────────────

@app.route("/", methods=["GET"])
def index():
    return Response(PAGE.format(message=""), mimetype="text/html")


@app.route("/ingest", methods=["POST"])
def ingest():
    transcript = (request.form.get("body") or "").strip()
    title_input = (request.form.get("title") or "").strip()

    if not transcript:
        msg = '<div class="msg err">No transcript provided.</div>'
        return Response(PAGE.format(message=msg), mimetype="text/html", status=400)

    try:
        summary = summarize(transcript)
    except LLMError as exc:
        log(f"LLM error: {exc}")
        msg = f'<div class="msg err">LLM error: {exc}</div>'
        return Response(PAGE.format(message=msg), mimetype="text/html", status=502)

    title = title_input or extract_title_from_summary(summary)

    now = datetime.now()
    date_str = now.strftime("%Y-%m-%d")
    ts_str = now.strftime("%Y-%m-%d-%H-%M")
    filename = f"{ts_str}.md"

    frontmatter = (
        f"---\n"
        f"date: {date_str}\n"
        f'title: "{title}"\n'
        f"tags: [conversation, claude-session]\n"
        f"---\n"
    )
    note_body = (
        f"# {title}\n\n"
        f"{summary}\n\n"
        f"## Full Transcript\n\n"
        f"{transcript}\n"
    )
    note_content = frontmatter + note_body

    CONV_DIR.mkdir(parents=True, exist_ok=True)
    out_path = CONV_DIR / filename
    out_path.write_text(note_content, encoding="utf-8")

    rel_path = f"notes/conversations/{filename}"
    log(f"saved | {title} | {rel_path}")

    slack_notify(
        f"VIRGIL [conversation-ingest] ✅ New session saved: {title} → {rel_path}"
    )

    return Response(
        SUCCESS_PAGE.format(rel_path=rel_path, title=title),
        mimetype="text/html",
    )


# ── Entrypoint ────────────────────────────────────────────────────────────────

def main():
    # Load secrets from ~/.config/virgil/.env if not already in environment
    if not os.environ.get("ANTHROPIC_API_KEY"):
        env_path = Path.home() / ".config" / "virgil" / ".env"
        if env_path.exists():
            for line in env_path.read_text().splitlines():
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    key, _, val = line.partition("=")
                    val = val.strip().strip('"').strip("'")
                    if val:
                        os.environ[key.strip()] = val

    if not os.environ.get("SLACK_WEBHOOK_URL"):
        env_path = Path.home() / ".config" / "virgil" / ".env"
        if env_path.exists():
            for line in env_path.read_text().splitlines():
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    key, _, val = line.partition("=")
                    val = val.strip().strip('"').strip("'")
                    if val:
                        os.environ.setdefault(key.strip(), val)

    log("startup | conversation-ingest service starting on port 5002")
    app.run(host="0.0.0.0", port=5002, debug=False)


if __name__ == "__main__":
    main()
