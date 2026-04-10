# Inbox

The inbox is the **drop zone** for anything that needs to be filed. Throw unstructured notes here. VIRGIL handles routing automatically every Monday morning.

## How the Triage Pipeline Works

```
notes/inbox/             ← you drop stuff here
      │
      ▼ (Monday 8am — triage-inbox.sh)
      │
      ├─► notes/mitre/       if it's an ATT&CK technique
      ├─► notes/knowledge/   if it merges with an existing note
      ├─► notes/archive/     if it's stale or redundant
      └─► stays in inbox     if it needs more work
```

Claude Haiku reviews each note and returns one of four decisions:

- **merge** — content belongs in an existing note; appends and deletes from inbox
- **mitre** — filename matches `t[0-9]{4}` or content mentions ATT&CK; routes to `notes/mitre/`
- **archive** — stale, redundant, or no longer relevant; moves to `notes/archive/`
- **keep** — needs more work or is standalone; leaves in inbox with a log entry

## Manual Triage

Run triage anytime (don't wait until Monday):

```bash
virgil-triage
```

## Adding to the Inbox

Any of these methods drop a note into inbox:

```bash
# Capture a URL
virgil-url https://example.com/article

# Quick note (create manually in Obsidian and save to notes/inbox/)

# Paste content from anywhere into a new .md file in inbox/
```

## What NOT to Put in Inbox

- ATT&CK technique URLs — use `virgil-url` which routes them directly to `notes/mitre/`
- PDFs — use `virgil-pdf` which routes directly to `notes/knowledge/`
- CVEs — use `virgil-cve` which routes directly to `notes/cve/`

The inbox is for unstructured content that needs classification, not for content that already has a home.

## Tags

#inbox #triage #workflow
