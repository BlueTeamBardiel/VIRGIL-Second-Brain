# Shamoon

## What it is
Imagine a disgruntled janitor who, on their last day, doesn't just quit — they smash every computer, shred every file, and burn the building's directory on the way out. Shamoon (also called Disttrack) is a destructive malware family targeting Windows systems that overwrites the Master Boot Record (MBR) and wipes files with garbage data, rendering machines completely unbootable and unrecoverable.

## Why it matters
In 2012, Shamoon hit Saudi Aramco and wiped approximately 35,000 workstations within hours, crippling the world's largest oil company's operations for weeks. The attackers even taunted responders by replacing overwritten files with a burning American flag image — demonstrating that the goal was pure destruction, not data theft, fundamentally shifting how defenders think about insider threats and nation-state sabotage operations.

## Key facts
- **Attribution**: Widely attributed to Iranian state-sponsored threat actors; a resurgence (Shamoon 2) hit Saudi targets again in 2016-2017
- **Wiper mechanism**: Uses a legitimate Eldos RawDisk driver to gain direct disk access and overwrite the MBR without needing low-level OS privileges through conventional channels
- **Three-component architecture**: Dropper installs a wiper module and a reporter module — the reporter communicates back to C2 with infection status before destruction begins
- **Time-triggered payload**: Shamoon 2 was configured to detonate on specific dates tied to Islamic calendar events, indicating careful operational planning
- **Defense implication**: Highlights why offline, immutable backups and network segmentation are critical — once Shamoon executes at scale, restoration from backups is the *only* recovery path

## Related concepts
[[Wiper Malware]] [[Master Boot Record (MBR)]] [[Nation-State Threats]] [[Destructive Attacks]] [[Incident Response]]