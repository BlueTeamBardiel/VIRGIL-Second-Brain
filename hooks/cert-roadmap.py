#!/usr/bin/env python3
"""cert-roadmap.py — Generate a visual cert progress roadmap in Obsidian.

Creates notes/cert-roadmap.md showing the full A+ → Sec+ → CCNA → CySA+
path with current position marked and progress bars.

Usage:
  python3 hooks/cert-roadmap.py
  virgil-roadmap  (via alias)
"""

import json
import os
from datetime import date
from pathlib import Path

VIRGIL_DIR = Path(os.environ.get("VIRGIL_DIR", str(Path.home() / "VIRGIL")))
SCORES_FILE = VIRGIL_DIR / "logs" / "quiz-scores.json"
STREAK_FILE = VIRGIL_DIR / "logs" / "streak.json"
CLAUDE_MD = VIRGIL_DIR / "CLAUDE.md"
ROADMAP_NOTE = VIRGIL_DIR / "notes" / "cert-roadmap.md"

CERT_PATH = [
    {
        "cert": "A+",
        "full_name": "CompTIA A+ (220-1101 / 220-1102)",
        "domains": [
            "Mobile Devices",
            "Networking",
            "Hardware",
            "Virtualization & Cloud",
            "Hardware & Network Troubleshooting",
            "Operating Systems",
            "Security",
            "Software Troubleshooting",
            "Operational Procedures",
        ],
        "total_topics": 40,
        "slug": "aplus",
        "command": "/aplus",
    },
    {
        "cert": "Security+",
        "full_name": "CompTIA Security+ (SY0-701)",
        "domains": [
            "General Security Concepts",
            "Threats, Vulnerabilities & Mitigations",
            "Security Architecture",
            "Security Operations",
            "Security Program Management",
        ],
        "total_topics": 28,
        "slug": "security-plus",
        "command": "/secplus",
    },
    {
        "cert": "CCNA",
        "full_name": "Cisco CCNA (200-301)",
        "domains": [
            "Network Fundamentals",
            "Network Access",
            "IP Connectivity",
            "IP Services",
            "Security Fundamentals",
            "Automation & Programmability",
        ],
        "total_topics": 31,
        "slug": "ccna",
        "command": "/ccna",
    },
    {
        "cert": "CySA+",
        "full_name": "CompTIA CySA+ (CS0-003)",
        "domains": [
            "Security Operations",
            "Vulnerability Management",
            "Incident Response & Management",
            "Reporting & Communication",
        ],
        "total_topics": 22,
        "slug": "cysa",
        "command": "/cysa",
    },
]


def load_scores() -> dict:
    if not SCORES_FILE.exists():
        return {}
    try:
        return json.loads(SCORES_FILE.read_text())
    except Exception:
        return {}


def load_streak() -> dict:
    if not STREAK_FILE.exists():
        return {}
    try:
        return json.loads(STREAK_FILE.read_text())
    except Exception:
        return {}


def read_claude_md() -> dict:
    """Parse key fields from CLAUDE.md."""
    profile = {
        "name": "Student",
        "current_cert": "",
        "current_chapter": 1,
    }
    if not CLAUDE_MD.exists():
        return profile
    for line in CLAUDE_MD.read_text().splitlines():
        if line.startswith("name:"):
            val = line.split(":", 1)[1].strip()
            if val:
                profile["name"] = val
        elif line.startswith("current_cert:"):
            profile["current_cert"] = line.split(":", 1)[1].strip()
        elif line.startswith("current_chapter:"):
            try:
                profile["current_chapter"] = int(line.split(":", 1)[1].strip())
            except ValueError:
                pass
    return profile


def progress_bar(pct: float, width: int = 20) -> str:
    filled = int(pct / 100 * width)
    empty = width - filled
    if pct >= 80:
        emoji = "\U0001f7e2"  # green circle
    elif pct >= 40:
        emoji = "\U0001f7e1"  # yellow circle
    elif pct > 0:
        emoji = "\U0001f534"  # red circle
    else:
        emoji = "⬜"      # white square
    return f"{emoji} {'█' * filled}{'░' * empty} {pct:.0f}%"


def calculate_cert_progress(cert_info: dict, scores: dict) -> dict:
    """Calculate mastery % for a cert based on quiz scores."""
    keywords = [d.lower() for d in cert_info["domains"]]
    slug = cert_info["slug"]

    matched = []
    for topic, entry in scores.items():
        topic_lower = topic.lower()
        if any(kw in topic_lower or topic_lower in kw for kw in keywords):
            matched.append(entry)

    # Also match against ingested cert notes
    cert_dir = VIRGIL_DIR / "notes" / "knowledge" / slug
    if cert_dir.exists():
        ingested_topics = [
            n.stem.lower().replace("-", " ")
            for n in cert_dir.glob("*.md")
            if n.stem.lower() not in {"index", "readme"}
        ]
        for topic, entry in scores.items():
            if entry not in matched:
                t = topic.lower()
                if any(it in t or t in it for it in ingested_topics):
                    matched.append(entry)

    if not matched:
        return {"pct": 0, "mastered": 0, "tested": 0, "total": cert_info["total_topics"]}

    mastered = sum(
        1 for e in matched
        if isinstance(e, dict) and e.get("score", 0) / max(e.get("out_of", 5), 1) >= 0.8
    )

    pct = (mastered / cert_info["total_topics"]) * 100
    return {
        "pct": min(pct, 100),
        "mastered": mastered,
        "tested": len(matched),
        "total": cert_info["total_topics"],
    }


def generate_roadmap() -> None:
    scores = load_scores()
    streak = load_streak()
    profile = read_claude_md()
    today = date.today().isoformat()

    current_cert = profile.get("current_cert", "")
    student_name = profile.get("name", "Student")
    current_streak = streak.get("current_streak", 0)
    total_days = streak.get("total_study_days", 0)

    lines = [
        "---",
        "tags: [roadmap, progress, certs]",
        f"updated: {today}",
        "---",
        "",
        f"# {student_name}'s Cert Roadmap",
        "",
        f"*Updated: {today}*",
        "",
    ]

    if current_streak > 0:
        lines += [
            f"\U0001f525 **Current streak:** {current_streak} day{'s' if current_streak != 1 else ''}  ",
            f"\U0001f4c5 **Total study days:** {total_days}",
            "",
        ]

    lines += [
        "---",
        "",
        "## The Path",
        "",
        "```",
        "A+  →  Security+  →  CCNA  →  CySA+",
        "```",
        "",
        "Each cert builds on the last. Complete them in order for maximum retention.",
        "",
        "---",
        "",
    ]

    for i, cert_info in enumerate(CERT_PATH):
        cert_name = cert_info["cert"]
        full_name = cert_info["full_name"]
        command = cert_info["command"]
        progress = calculate_cert_progress(cert_info, scores)

        is_current = (
            current_cert.lower() in cert_name.lower()
            or cert_name.lower() in current_cert.lower()
        )
        is_complete = progress["pct"] >= 80

        if is_complete:
            status = "✅ Complete"
            prefix = "~~"
            suffix = "~~"
        elif is_current:
            status = "\U0001f4cd Current"
            prefix = "**"
            suffix = "**"
        elif i > 0:
            prev_complete = calculate_cert_progress(CERT_PATH[i - 1], scores)["pct"] >= 80
            status = "\U0001f51c Up next" if prev_complete else "\U0001f512 Locked"
            prefix = ""
            suffix = ""
        else:
            status = "\U0001f51c Start here"
            prefix = ""
            suffix = ""

        lines += [
            f"## {prefix}{cert_name} — {status}{suffix}",
            f"*{full_name}*",
            "",
            progress_bar(progress["pct"]),
            f"{progress['mastered']}/{progress['total']} topics mastered",
            "",
            "**Domains:**",
        ]
        for domain in cert_info["domains"]:
            lines.append(f"- {domain}")

        lines += [
            "",
            f"**Study command:** `{command}`",
            "",
            "---",
            "",
        ]

    lines += [
        "## How to use this",
        "",
        "- Open this note in Obsidian to track your path visually",
        "- Run `virgil-roadmap` in the terminal to refresh it",
        "- Run `/diagnose` in Claude Code to update your current cert",
        "- Run `virgil-progress [cert]` for detailed domain breakdown",
        "",
        "*VIRGIL updates this automatically after each quiz session.*",
    ]

    ROADMAP_NOTE.parent.mkdir(parents=True, exist_ok=True)
    ROADMAP_NOTE.write_text("\n".join(lines), encoding="utf-8")
    print(f"[roadmap] Updated: {ROADMAP_NOTE}")
    print(f"[roadmap] Current cert: {current_cert or 'not set — run /diagnose'}")


if __name__ == "__main__":
    generate_roadmap()
