# VIRGIL — Claude Code Configuration

## Memory Files
- @memory-working.md — active pending tasks (cleared weekly)
- @memory-episodic.md — session history, promoted facts, completed work
- @memory-semantic.md — permanent facts: fleet, certs, architecture, key decisions

## Key Paths
- Vault: ~/VIRGIL/
- Ingest scripts: ingest/
- Hooks: hooks/
- Notes: notes/
- Daily logs: daily-logs/

## Conventions
- [[wiki links]] for all your-lab hosts, tools, protocols, concepts
- Run /reflect at end of each session
- Run /week on Fridays or Sundays for weekly digest

## Task Categories

When `/task` is invoked, VIRGIL reads its category list from this section. Edit the list below to fit your study and work — VIRGIL will use these as the dropdown when filing tasks.

task_categories:
  - Study
  - Notes
  - Lab
  - General
