---
name: Feature request
about: Propose a new ingest script, skill, hook, or pipeline improvement
title: '[FEAT] '
labels: enhancement
assignees: ''
---

## Pipeline stage

Which part of VIRGIL does this affect?

- [ ] Ingest (new data source or ingest script)
- [ ] Processing (Claude prompt, output format, routing logic)
- [ ] Storage (note structure, directory layout, Obsidian compatibility)
- [ ] Automation (hooks, cron, promote.sh)
- [ ] Skills / Claude Code commands
- [ ] Documentation

## Use case

What problem does this solve? Who would use it and when?

## Proposed implementation

How would this work? Be as specific as you can.

For a new ingest script:
- Input: what does it consume? (URL, file, API, stdin)
- Output: where does it write? (notes/ subdirectory, daily log, etc.)
- API calls: does it need Claude? Which model? Rough token estimate?
- Dependencies: any new tools required beyond bash/python3/curl/pandoc?

For a new skill:
- Trigger: what command or phrase invokes it?
- Steps: what does it read, decide, and write?

## Alternatives considered

What else could solve this? Why is your approach better?

## Notes

Anything else relevant — edge cases, limitations, related issues.
