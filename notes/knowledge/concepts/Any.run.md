# Any.run

## What it is
Think of it like a fishbowl aquarium where you drop in a suspicious fish and watch exactly what it does — without it ever touching your real pond. Any.run is an interactive online malware sandbox that executes suspicious files or URLs in an isolated virtual environment, allowing analysts to observe real-time behavior including network calls, registry changes, and process trees.

## Why it matters
A SOC analyst receives a phishing email with an attached `.docx` file. Rather than opening it on a live workstation, they upload it to Any.run and watch in real time as the document spawns `PowerShell`, reaches out to a C2 server at a suspicious IP, and drops a second-stage payload — all safely contained. This behavioral evidence gives the team concrete IOCs to block before a single endpoint is compromised.

## Key facts
- Any.run is an **interactive sandbox** — unlike automated tools, analysts can click, type, and interact with the running malware sample in real time through a browser interface
- Provides a full **process tree visualization**, showing parent-child relationships between spawned processes (e.g., `winword.exe` → `cmd.exe` → `powershell.exe`)
- Captures **network IOCs** including DNS queries, HTTP requests, and C2 callback domains/IPs during execution
- Classifies threats using **MITRE ATT&CK mappings**, tagging observed behaviors to specific tactics and techniques
- Free tier submissions are **publicly visible** — uploading sensitive internal documents is an OPSEC risk organizations must manage carefully

## Related concepts
[[Malware Sandboxing]] [[Dynamic Analysis]] [[Indicators of Compromise]] [[MITRE ATT&CK]] [[Threat Intelligence]]