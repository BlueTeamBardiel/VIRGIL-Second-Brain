#!/usr/bin/env python3
"""streak.py — Study streak tracker for VIRGIL.

Reads and updates logs/streak.json.
Called by quiz.sh after every completed quiz.
Also callable standalone: python3 hooks/streak.py

streak.json format:
{
  "current_streak": 5,
  "longest_streak": 12,
  "last_study_date": "2026-04-30",
  "total_study_days": 23,
  "milestones_hit": [1, 3, 7, 14]
}
"""

import json
import sys
from datetime import date, datetime, timedelta
from pathlib import Path

VIRGIL_DIR = Path(__file__).parent.parent
STREAK_FILE = VIRGIL_DIR / "logs" / "streak.json"

MILESTONE_MESSAGES = {
    1:   "First day on the path. Every expert started here.",
    3:   "Three days straight. You're building a habit.",
    7:   "One week. Most people don't make it this far.",
    14:  "Two weeks. You're not dabbling anymore — this is real.",
    21:  "Three weeks. Neuroscience says this is where habits stick.",
    30:  "Thirty days. One month of showing up. That's not nothing.",
    50:  "Fifty days. You're past the point where most people quit.",
    75:  "Seventy-five days. You've earned the right to feel good about this.",
    100: "One hundred days. VIRGIL has seen a lot of students. Not many make it here.",
}


def load_streak() -> dict:
    if not STREAK_FILE.exists():
        return {
            "current_streak": 0,
            "longest_streak": 0,
            "last_study_date": "",
            "total_study_days": 0,
            "milestones_hit": []
        }
    try:
        return json.loads(STREAK_FILE.read_text())
    except Exception:
        return {
            "current_streak": 0,
            "longest_streak": 0,
            "last_study_date": "",
            "total_study_days": 0,
            "milestones_hit": []
        }


def save_streak(data: dict) -> None:
    STREAK_FILE.parent.mkdir(parents=True, exist_ok=True)
    STREAK_FILE.write_text(json.dumps(data, indent=2))


def update_streak() -> dict:
    """Update streak after a study session. Returns streak data with any milestone message."""
    data = load_streak()
    today = date.today().isoformat()

    last = data.get("last_study_date", "")

    if last == today:
        data["milestone_message"] = None
        return data

    if last:
        last_date = datetime.strptime(last, "%Y-%m-%d").date()
        delta = (date.today() - last_date).days

        if delta == 1:
            data["current_streak"] = data.get("current_streak", 0) + 1
        elif delta > 1:
            data["current_streak"] = 1
    else:
        data["current_streak"] = 1

    data["last_study_date"] = today
    data["total_study_days"] = data.get("total_study_days", 0) + 1

    if data["current_streak"] > data.get("longest_streak", 0):
        data["longest_streak"] = data["current_streak"]

    milestones_hit = data.get("milestones_hit", [])
    milestone_message = None
    for days, msg in MILESTONE_MESSAGES.items():
        if data["current_streak"] >= days and days not in milestones_hit:
            milestones_hit.append(days)
            milestone_message = f"\U0001f525 {data['current_streak']}-day streak — {msg}"

    data["milestones_hit"] = milestones_hit
    data["milestone_message"] = milestone_message

    save_streak(data)
    return data


def show_streak() -> None:
    """Display current streak status."""
    data = load_streak()
    current = data.get("current_streak", 0)
    longest = data.get("longest_streak", 0)
    total = data.get("total_study_days", 0)
    last = data.get("last_study_date", "never")

    print(f"\n{'━' * 48}")
    print(f"  Study Streak")
    print(f"{'━' * 48}")
    print(f"  Current streak:  {current} day{'s' if current != 1 else ''}")
    print(f"  Longest streak:  {longest} day{'s' if longest != 1 else ''}")
    print(f"  Total days:      {total}")
    print(f"  Last session:    {last}")

    if current > 0:
        next_milestone = None
        for days in sorted(MILESTONE_MESSAGES.keys()):
            if days > current:
                next_milestone = days
                break
        if next_milestone:
            print(f"  Next milestone:  {next_milestone} days ({next_milestone - current} to go)")

    print(f"{'━' * 48}\n")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "show":
        show_streak()
    else:
        result = update_streak()
        if result.get("milestone_message"):
            print(f"\n{result['milestone_message']}\n")
        show_streak()
