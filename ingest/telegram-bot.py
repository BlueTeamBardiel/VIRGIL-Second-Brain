#!/usr/bin/env python3
"""VIRGIL Telegram Capture Bot — routes messages, URLs, and voice notes to notes/inbox/."""

import asyncio
import logging
import os
import re
import subprocess
from datetime import datetime
from pathlib import Path

from dotenv import dotenv_values
from telegram import Update
from telegram.ext import ApplicationBuilder, MessageHandler, filters, ContextTypes

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
log = logging.getLogger(__name__)

# ── Config ─────────────────────────────────────────────────────────────────────

ENV_PATH = Path.home() / ".config/virgil/.env"
env = dotenv_values(ENV_PATH)

BOT_TOKEN = env.get("TELEGRAM_BOT_TOKEN", "")
ALLOWED_USER_ID = env.get("TELEGRAM_USER_ID", "")

VIRGIL_DIR = Path(os.environ.get("VIRGIL_DIR", Path.home() / "Documents/Cocytus/VIRGIL"))
INBOX_DIR = VIRGIL_DIR / "notes/inbox"
URL_INGEST = VIRGIL_DIR / "ingest/url-ingest.sh"

URL_RE = re.compile(r"https?://\S+")

# ── Inbox helpers ──────────────────────────────────────────────────────────────

def inbox_path() -> Path:
    return INBOX_DIR / f"{datetime.now().strftime('%Y-%m-%d')}-telegram.md"


def ensure_note(path: Path) -> None:
    if path.exists():
        return
    INBOX_DIR.mkdir(parents=True, exist_ok=True)
    today = datetime.now().strftime("%Y-%m-%d")
    path.write_text(
        f"---\ndate: {today}\nsource: telegram\ntags: [inbox, capture, telegram]\n---\n"
        f"# Telegram Capture — {today}\n\n## Messages\n\n## URLs\n\n## Voice Notes\n",
        encoding="utf-8",
    )


def append_to_section(path: Path, section: str, line: str) -> None:
    text = path.read_text(encoding="utf-8")
    marker = f"## {section}"
    if marker not in text:
        text += f"\n{marker}\n"
    # Insert after the section header (before the next ## or EOF)
    parts = text.split(marker, 1)
    after = parts[1]
    # Find end of section
    next_header = re.search(r"\n## ", after)
    if next_header:
        insert_at = next_header.start()
        after = after[:insert_at] + f"\n- {line}" + after[insert_at:]
    else:
        after = after.rstrip("\n") + f"\n- {line}\n"
    path.write_text(parts[0] + marker + after, encoding="utf-8")


# ── Handlers ───────────────────────────────────────────────────────────────────

def is_allowed(update: Update) -> bool:
    if not ALLOWED_USER_ID:
        return True
    return str(update.effective_user.id) == str(ALLOWED_USER_ID)


async def handle_text(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    if not is_allowed(update):
        return

    text = update.message.text or ""
    ts = datetime.now().strftime("%H:%M")
    path = inbox_path()
    ensure_note(path)

    urls = URL_RE.findall(text)
    non_url = URL_RE.sub("", text).strip()

    if non_url:
        append_to_section(path, "Messages", f"{ts}: {non_url}")

    for url in urls:
        if URL_INGEST.exists():
            try:
                subprocess.run(
                    ["bash", str(URL_INGEST), url],
                    timeout=30,
                    check=False,
                    capture_output=True,
                )
                log.info("url-ingest called for %s", url)
            except Exception as exc:
                log.warning("url-ingest failed: %s", exc)
                append_to_section(path, "URLs", f"{ts}: {url}")
        else:
            append_to_section(path, "URLs", f"{ts}: {url}")

    await update.message.reply_text("✅ Saved to VIRGIL inbox")


async def handle_voice(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    if not is_allowed(update):
        return

    ts = datetime.now().strftime("%H:%M")
    path = inbox_path()
    ensure_note(path)
    append_to_section(path, "Voice Notes", f"{ts}: [voice note received — manual review needed]")
    await update.message.reply_text("✅ Saved to VIRGIL inbox")


async def handle_document(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    if not is_allowed(update):
        return

    ts = datetime.now().strftime("%H:%M")
    fname = update.message.document.file_name if update.message.document else "unknown"
    path = inbox_path()
    ensure_note(path)
    append_to_section(path, "Messages", f"{ts}: [document received: {fname} — manual review needed]")
    await update.message.reply_text("✅ Saved to VIRGIL inbox")


# ── Main ───────────────────────────────────────────────────────────────────────

def main() -> None:
    if not BOT_TOKEN:
        raise SystemExit(
            "TELEGRAM_BOT_TOKEN not set in ~/.config/virgil/.env — "
            "get a token from @BotFather and add it before starting."
        )

    app = ApplicationBuilder().token(BOT_TOKEN).build()
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_text))
    app.add_handler(MessageHandler(filters.VOICE, handle_voice))
    app.add_handler(MessageHandler(filters.Document.ALL, handle_document))

    log.info("VIRGIL Telegram bot starting (vault: %s)", VIRGIL_DIR)
    app.run_polling(drop_pending_updates=True)


if __name__ == "__main__":
    main()
