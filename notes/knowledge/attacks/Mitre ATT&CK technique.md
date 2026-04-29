# Mitre ATT&CK technique

## What it is
Think of it like a baseball scouting report — just as coaches catalog every pitch type, speed, and situation an opposing pitcher uses, MITRE ATT&CK catalogs every specific action an adversary takes during an intrusion. A **technique** is a single, documented method an attacker uses to achieve a tactical goal, such as *T1059.001 - PowerShell* (executing malicious commands via PowerShell) within the broader tactic of *Execution*.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used *T1195.002 - Compromise Software Supply Chain* to inject SUNBURST malware into legitimate software updates. Security teams using ATT&CK could map observed behaviors directly to known technique IDs, accelerating threat hunting and enabling defenders to query SIEMs for matching indicators rather than starting from scratch.

## Key facts
- The ATT&CK matrix is organized into **14 tactics** (the "why") containing **hundreds of techniques** (the "how"), with sub-techniques providing further granularity (e.g., T1078.003 = Local Accounts under Valid Accounts)
- Techniques are platform-specific — the Enterprise matrix covers Windows, macOS, Linux, cloud, and containers separately
- Each technique entry includes **real-world procedure examples**, detection guidance, and mitigation recommendations — making it actionable, not just descriptive
- CySA+ exam tests ability to map an incident artifact (e.g., scheduled task creation) to its ATT&CK technique ID for threat categorization
- ATT&CK is **descriptive, not prescriptive** — it documents what adversaries *do*, not what defenders *must* do, distinguishing it from compliance frameworks like NIST

## Related concepts
[[Tactics Techniques and Procedures (TTPs)]] [[MITRE ATT&CK Navigator]] [[Threat Intelligence]] [[Cyber Kill Chain]] [[SIGMA Rules]]