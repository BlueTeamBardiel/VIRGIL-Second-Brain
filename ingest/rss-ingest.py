#!/usr/bin/env python3
"""
rss-ingest.py — Pull security/homelab/SDR RSS feeds, filter last 24h, generate digest via Claude.
Usage: rss-ingest.py [--hours N] [--dry-run]
Output: notes/feeds/YYYY-MM-DD.md  +  Slack notification
Deps: feedparser, requests (requests is used for Slack notification only;
      LLM calls go through hooks/llm_client.py)
Feeds: 27 (22 security/homelab + 5 SDR/RF/hardware)
"""

import argparse
import os
import sys
import time
from datetime import datetime, timezone, timedelta
from pathlib import Path

try:
    import feedparser
    import requests
except ImportError:
    print("ERROR: Missing deps. Run: pip3 install feedparser requests", file=sys.stderr)
    sys.exit(1)

# ── Load API key from vault .env if not set in environment ───────────────────
if not os.environ.get("ANTHROPIC_API_KEY"):
    import re as _re
    _virgil_dir = Path(os.environ.get("VIRGIL_DIR", str(Path.home() / "VIRGIL")))
    _env_file = _virgil_dir / ".env"
    if _env_file.exists():
        with open(_env_file) as _f:
            for _line in _f:
                _m = _re.match(r'^ANTHROPIC_API_KEY=["\']?(.+?)["\']?\s*$', _line)
                if _m:
                    os.environ["ANTHROPIC_API_KEY"] = _m.group(1)
                    break

# ── Config ────────────────────────────────────────────────────────────────────
VIRGIL_DIR = Path(os.environ.get("VIRGIL_DIR", str(Path.home() / "VIRGIL")))
FEEDS_DIR = VIRGIL_DIR / "notes" / "feeds"
LOGFILE = VIRGIL_DIR / "ingest" / "rss-ingest.log"

# llm_client lives in hooks/ — sibling directory in the installed vault
sys.path.insert(0, str(VIRGIL_DIR / "hooks"))
try:
    from llm_client import ask, LLMError
except ImportError:
    print("ERROR: Could not import llm_client from hooks/. Is VIRGIL installed correctly? Check hooks/llm_client.py exists.", file=sys.stderr)
    sys.exit(1)

FEEDS = [
    # Threat Intel / News
    ("The Hacker News",         "https://feeds.feedburner.com/TheHackersNews"),
    ("Krebs on Security",       "https://krebsonsecurity.com/feed/"),
    ("Bleeping Computer",       "https://www.bleepingcomputer.com/feed/"),
    ("Schneier on Security",    "https://www.schneier.com/blog/atom.xml"),
    ("Dark Reading",            "https://www.darkreading.com/rss.xml"),
    ("SecurityWeek",            "https://feeds.feedburner.com/securityweek"),
    ("Threatpost",              "https://threatpost.com/feed/"),
    ("Malwarebytes Labs",       "https://blog.malwarebytes.com/feed/"),
    ("Troy Hunt",               "https://www.troyhunt.com/rss/"),
    ("InfoSecurity Magazine",   "https://www.infosecurity-magazine.com/rss/news/"),
    ("PortSwigger Daily Swig",  "https://portswigger.net/daily-swig/rss"),
    # Vulnerability / Advisories
    ("CISA Advisories",         "https://www.cisa.gov/cybersecurity-advisories/all.xml"),
    ("SANS ISC",                "https://isc.sans.edu/rssfeed_full.xml"),
    ("Google Project Zero",     "https://googleprojectzero.blogspot.com/feeds/posts/default"),
    # Wired / Ars Technica Security
    ("Wired Security",          "https://www.wired.com/feed/category/security/latest/rss"),
    ("Ars Technica Security",   "https://feeds.arstechnica.com/arstechnica/security"),
    # Community / Homelab
    ("r/netsec",                "https://www.reddit.com/r/netsec/.rss"),
    ("r/homelab",               "https://www.reddit.com/r/homelab/.rss"),
    ("r/sysadmin",              "https://www.reddit.com/r/sysadmin/.rss"),
    ("r/blueteamsec",           "https://www.reddit.com/r/blueteamsec/.rss"),
    # Tools / Open Source
    ("GitHub Security Lab",     "https://github.blog/category/security/feed/"),
    ("CISA Known Exploited",    "https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json"),
    # SDR / RF / Hardware
    ("RTL-SDR Blog",            "https://www.rtl-sdr.com/feed/"),
    ("Hackaday",                "https://hackaday.com/blog/feed/"),
    ("SDRplay News",            "https://www.sdrplay.com/news/feed/"),
    ("Flipper Zero Blog",       "https://blog.flipper.net/rss/"),
    ("IEEE Spectrum",           "https://spectrum.ieee.org/feeds/feed.rss"),
    # Skipped — no valid RSS found:
    #   f5len.org/feed/          → 404 as of 2026-04-11
    #   radioreference.com       → returns HTML; no public RSS feed
    #   Benn Jordan              → no RSS; find content at youtube.com/@BennJordan
    #   flipperzero.one/blog     → 404; correct URL is blog.flipper.net
    #   thebenji.substack.com/feed → returns HTML as of 2026-04-15
]


def log(msg: str) -> None:
    ts = datetime.now().strftime("%Y-%m-%d %H:%M")
    line = f"[rss-ingest {ts}] {msg}"
    print(line)
    LOGFILE.parent.mkdir(parents=True, exist_ok=True)
    with open(LOGFILE, "a") as f:
        f.write(line + "\n")


def parse_entry_time(entry) -> datetime | None:
    for field in ("published_parsed", "updated_parsed"):
        t = getattr(entry, field, None)
        if t:
            return datetime(*t[:6], tzinfo=timezone.utc)
    return None


def fetch_feed(name: str, url: str, cutoff: datetime) -> list[dict]:
    """Return list of {title, link, summary} for entries newer than cutoff."""
    try:
        feed = feedparser.parse(url, request_headers={"User-Agent": "VIRGIL-RSS/1.0"})
        items = []
        for entry in feed.entries:
            pub = parse_entry_time(entry)
            if pub and pub < cutoff:
                continue
            title = getattr(entry, "title", "(no title)")
            link = getattr(entry, "link", "")
            summary = getattr(entry, "summary", "") or getattr(entry, "description", "")
            # Strip HTML tags simply
            import re
            summary = re.sub(r"<[^>]+>", "", summary).strip()[:400]
            items.append({"title": title, "link": link, "summary": summary})
        return items
    except Exception as e:
        log(f"WARN: Failed to fetch {name}: {e}")
        return []


def build_raw_digest(items_by_source: dict, date_str: str) -> str:
    """Fallback digest — plain markdown with no AI synthesis."""
    lines = [f"## Daily Feed Digest — {date_str}", "",
             "_No API key configured — raw items only, no synthesis._", ""]
    for source, items in items_by_source.items():
        if not items:
            continue
        lines.append(f"### {source}")
        lines.append("")
        for item in items:
            lines.append(f"- **{item['title']}**")
            if item.get("summary"):
                lines.append(f"  {item['summary'][:200]}")
            if item.get("link"):
                lines.append(f"  {item['link']}")
        lines.append("")
    return "\n".join(lines)


def _read_claude_md_profile() -> tuple[str, str]:
    """Read name and current_cert from CLAUDE.md. Returns (user_name, current_cert)."""
    claude_md = VIRGIL_DIR / "CLAUDE.md"
    user_name = "the user"
    current_cert = "cybersecurity"
    if claude_md.exists():
        for line in claude_md.read_text(encoding="utf-8").splitlines():
            if line.startswith("name:"):
                val = line.split(":", 1)[1].strip()
                if val:
                    user_name = val
            elif line.startswith("current_cert:"):
                val = line.split(":", 1)[1].strip()
                if val:
                    current_cert = val
    return user_name, current_cert


def build_digest(items_by_source: dict, date_str: str) -> str:
    """Synthesize feed items into a digest via the LLM abstraction layer.

    Routes through hooks/llm_client.py — respects backend selection,
    circuit breaker, and the Ollama→Anthropic fallback chain.

    TODO(v2.1.0): the env var llm_client.py reads (VIRGIL_LLM_BACKEND) and
    the backend value names (primary/secondary/anthropic) don't yet match
    what ARCHITECTURE.md §7.1 documents (VIRGIL_BACKEND, ollama/anthropic,
    no fallback chain). Backend abstraction alignment is a v2.1.0 item —
    see ROADMAP.md.

    Raises LLMError if all backends fail; caller decides whether to fall
    back to raw digest.
    """
    user_name, current_cert = _read_claude_md_profile()

    # Build compact feed text
    feed_text = ""
    total = 0
    for source, items in items_by_source.items():
        if not items:
            continue
        feed_text += f"\n### {source}\n"
        for item in items:
            feed_text += f"- **{item['title']}**\n  {item['summary'][:200]}\n  {item['link']}\n"
            total += 1

    if not feed_text:
        return ""

    prompt = (
        f"You are a security intelligence analyst. {user_name} is a cybersecurity learner studying for {current_cert}.\n"
        f"The following are RSS feed items from {date_str}. Synthesize them into a concise daily threat and news digest.\n\n"
        f"Structure:\n"
        f"## Daily Feed Digest — {date_str}\n\n"
        f"### Top Stories\n(3–5 most significant items — new vulnerabilities, active exploits, major incidents)\n\n"
        f"### Homelab / Tooling\n(items relevant to homelabs, self-hosted tools, Ansible, Docker, Linux)\n\n"
        f"### {current_cert} Relevant\n(items touching on blue team concepts, SOC operations, threat hunting, SIEM, IDS)\n\n"
        f"### Quick Hits\n(remaining notable items — one line each)\n\n"
        f"Rules:\n"
        f"- Use [[wiki links]] for tools and concepts (e.g., [[Wazuh]], [[Suricata]], [[CVE]]).\n"
        f"- Be concise. No filler. Skip sections with nothing relevant.\n"
        f"- Include source URLs for Top Stories items.\n\n"
        f"Feed items ({total} total):\n{feed_text[:12000]}"
    )

    return ask(prompt, max_tokens=3000)


def slack_notify(message: str) -> None:
    url = os.environ.get("SLACK_WEBHOOK_URL")
    if not url:
        return
    try:
        requests.post(url, json={"text": message}, timeout=10)
    except Exception:
        pass


def main() -> None:
    parser = argparse.ArgumentParser(description="VIRGIL RSS ingest")
    parser.add_argument("--hours", type=int, default=24, help="Lookback window in hours (default: 24)")
    parser.add_argument("--dry-run", action="store_true", help="Fetch feeds but skip Claude call and file write")
    args = parser.parse_args()

    now = datetime.now(timezone.utc)
    cutoff = now - timedelta(hours=args.hours)
    date_str = now.strftime("%Y-%m-%d")
    output_file = FEEDS_DIR / f"{date_str}.md"

    FEEDS_DIR.mkdir(parents=True, exist_ok=True)

    log(f"Starting RSS ingest — {len(FEEDS)} feeds, lookback {args.hours}h")

    items_by_source: dict[str, list] = {}
    total_items = 0

    for name, url in FEEDS:
        items = fetch_feed(name, url, cutoff)
        items_by_source[name] = items
        if items:
            log(f"  {name}: {len(items)} new items")
        total_items += len(items)
        time.sleep(0.5)  # polite delay

    log(f"Total items: {total_items}")

    if total_items == 0:
        log("No new items found. Exiting.")
        return

    if args.dry_run:
        log("Dry run — skipping Claude call and file write.")
        return

    log("Calling LLM for digest synthesis (via hooks/llm_client.py)")
    try:
        digest = build_digest(items_by_source, date_str)
    except LLMError as e:
        log(f"All LLM backends failed: {e}")
        log("Falling back to raw digest (no AI synthesis)")
        digest = build_raw_digest(items_by_source, date_str)
        output_file.write_text(
            f"{digest}\n\n---\n_Generated: {now.strftime('%Y-%m-%d %H:%M UTC')} | {total_items} items from {len(FEEDS)} feeds (raw, no AI synthesis — all LLM backends failed)_\n"
        )
        log(f"Written raw digest to {output_file}")
        slack_notify(
            f"⚠ VIRGIL RSS digest — {date_str} (raw fallback, {total_items} items)\n"
            f"All LLM backends failed. Raw items saved to `notes/feeds/{date_str}.md` — no AI synthesis."
        )
        return

    if not digest:
        log("LLM returned empty digest. Exiting.")
        return

    output_file.write_text(
        f"{digest}\n\n---\n_Generated: {now.strftime('%Y-%m-%d %H:%M UTC')} | {total_items} items from {len(FEEDS)} feeds_\n"
    )
    log(f"Written to {output_file}")

    slack_notify(
        f"VIRGIL RSS digest ready — {date_str} ({total_items} items)\n"
        f"See `notes/feeds/{date_str}.md` in Obsidian."
    )


if __name__ == "__main__":
    main()
