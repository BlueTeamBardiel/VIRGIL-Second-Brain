# Getting Started with VIRGIL

Welcome. This guide is for first-time Obsidian users who just cloned VIRGIL and want to understand how the vault is structured.

## Step 0: Open the Vault in Obsidian

1. Open Obsidian
2. Click **Open folder as vault**
3. Navigate to your `VIRGIL_DIR` (wherever `setup.sh` put it, default: `~/Documents/VIRGIL`)
4. Click **Open**

Obsidian will index all the Markdown files. The left sidebar shows your folder structure.

## Step 1: Understand the Note Structure

```
notes/
├── inbox/        ← START HERE. Drop anything here, triage handles routing.
├── mitre/        ← ATT&CK techniques (auto-ingested from attack.mitre.org)
├── cve/          ← CVE notes (auto-generated daily from NVD)
├── feeds/        ← Daily threat intel digests (auto-generated at 6am)
├── knowledge/    ← Your study library (PDFs, URLs, NIST docs)
│   ├── security/
│   ├── networking/
│   └── nist/
└── personal/     ← Fitness, study logs, goals (optional)
```

## Step 2: Enable Graph View

In Obsidian, press `Ctrl+G` (or `Cmd+G` on Mac) to open the graph view. After you've ingested a few notes, you'll start to see the `[[wiki link]]` connections between them.

This is the payoff. Notes about CVEs link to ATT&CK techniques. ATT&CK notes link to NIST controls. Your study session notes link to the concepts they covered. Over time, the graph becomes a map of everything you know.

## Step 3: Run Your First Ingestion

Open a terminal and run:

```bash
# Pull today's security news feeds
virgil-rss

# Ingest an ATT&CK technique
virgil-url https://attack.mitre.org/techniques/T1059/

# Pull recent CVEs
virgil-cve --recent
```

Open Obsidian. You'll see new notes in `notes/feeds/`, `notes/mitre/`, and `notes/cve/`. Click into them. Follow the `[[wiki links]]`.

## Step 4: Set Up the Daily Habit

VIRGIL runs mostly on autopilot once the crontab is configured. Your daily workflow:

1. **Morning**: Check `notes/feeds/YYYY-MM-DD.md` for overnight threat intel digest
2. **During study**: Use `virgil-pdf` and `virgil-url` to capture anything interesting
3. **After a Claude Code session**: Run `/reflect` to fill in your session summary
4. **Sunday**: Check `weekly-summaries/YYYY-WNN.md` for the week's synthesis

## Step 5: Understand Wiki Links

VIRGIL uses `[[wiki links]]` throughout. In Obsidian, `[[T1059]]` creates a clickable link to the note `T1059.md`. `[[Wazuh]]` links to your Wazuh note.

The wikilink-ingest script (runs nightly at 11:30pm) scans recently modified notes and automatically injects `[[wiki links]]` for any mention of a known note title. You don't have to manually link everything.

To manually link something: type `[[` in Obsidian and start typing. Obsidian autocompletes from your existing notes.

## Step 6: The Memory System

Three files track your persistent context (these are gitignored — they stay on your machine):

| File | What It Holds |
|------|--------------|
| `memory-working.md` | Your active tasks and current sprint. Cleared weekly by `promote.sh`. |
| `memory-episodic.md` | Dated history of what you've done. Append-only. |
| `memory-semantic.md` | Permanent facts: your lab setup, certs in progress, key decisions. |

When you run `/reflect` in Claude Code, it reads these files to give you context-aware responses. Update `memory-semantic.md` with facts you want Claude to always know about your setup.

## Step 7: The Inbox Workflow

Anything you're not sure where to file goes in `notes/inbox/`. Every Monday at 8am, `triage-inbox.sh` runs Claude Haiku against each note and makes a routing decision.

You can also run triage manually anytime:
```bash
virgil-triage
```

## Common Obsidian Tips for VIRGIL

- **Search everything**: `Ctrl+Shift+F` — searches all note content
- **Quick switcher**: `Ctrl+O` — jump to any note by name  
- **Graph view**: `Ctrl+G` — see your knowledge graph
- **Backlinks**: In any note, the right panel shows all notes that link to it
- **Tags**: Click any `#tag` to see all notes with that tag
- **Daily notes**: Not required but pairs well with VIRGIL's daily log system

## Troubleshooting

**virgil-rss fails**: Check that `ANTHROPIC_API_KEY` is set — run `echo $ANTHROPIC_API_KEY`. If empty, re-run `setup.sh` or source your `.env` file.

**Notes aren't getting wiki links**: The wikilink script runs at 11:30pm. Run it manually: `virgil-wikilink`

**Triage isn't routing correctly**: Check `ingest/triage-inbox.log` for Claude's reasoning on each note.

**Cron jobs not running**: Verify your crontab has `ANTHROPIC_API_KEY` set: `crontab -l | head -5`
