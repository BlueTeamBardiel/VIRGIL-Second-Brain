# VIRGIL — Claude Code Configuration

## Profile
- @user.md — your name, background, certs in progress, target roles. Read first when a command needs context.

## Memory Files
- @memory-working.md — active pending tasks (cleared weekly)
- @memory-episodic.md — session history, promoted facts, completed work
- @memory-semantic.md — permanent facts: certs in progress, key decisions, durable identity

## Key Paths
- Vault: ~/VIRGIL/
- Ingest scripts: ingest/
- Hooks: hooks/
- Notes: notes/
- Daily logs: daily-logs/ (gitignored, user-runtime)

## Conventions
- `[[wiki links]]` for topics, tools, certs, and concepts that already have (or could have) a note in the vault
- Run `/reflect` at the end of a session
- Run `/week` on Fridays or Sundays for the weekly digest

## Task Categories

When `/task` is invoked, VIRGIL reads its category list from this section. Edit the list below to fit your study and work — VIRGIL will use these as the dropdown when filing tasks.

task_categories:
  - Study
  - Notes
  - Lab
  - General
