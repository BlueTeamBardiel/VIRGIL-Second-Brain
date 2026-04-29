# MITRE ATT&CK T1564.1

## What it is
Like a spy hiding documents inside a hollowed-out book on a shelf full of normal books, adversaries use hidden files and directories to store malicious tools where casual inspection won't find them. Specifically, T1564.1 describes techniques where attackers set the hidden attribute on files/directories (using `attrib +h` on Windows or prefixing names with `.` on Linux/macOS) to prevent them from appearing in standard directory listings.

## Why it matters
During the 2020 SolarWinds supply chain compromise, attackers stored implant components in directories designed to blend with legitimate software paths and evade routine file system inspection. Defenders who relied solely on GUI-based file browsing or standard `dir` commands without `/a` flags missed malicious artifacts entirely, extending attacker dwell time to months.

## Key facts
- On Windows, `attrib +h filename` sets the hidden attribute; `dir /a:h` reveals hidden files; PowerShell uses `Get-ChildItem -Force`
- On Linux/macOS, any file or folder prefixed with `.` (e.g., `.malware`) is hidden from `ls` by default; `ls -la` exposes them
- This technique is a sub-technique of T1564 (Hide Artifacts), which is under the **Defense Evasion** tactic
- Malware families like Turla and FIN7 routinely stage payloads in hidden directories under `%APPDATA%` or `%TEMP%`
- Detection strategies include file integrity monitoring (FIM), EDR telemetry watching `attrib.exe` execution, and SIEM alerts on hidden-attribute changes in sensitive paths

## Related concepts
[[Defense Evasion]] [[File Integrity Monitoring]] [[T1564 Hide Artifacts]] [[Rootkit Techniques]] [[Living Off the Land Binaries (LOLBins)]]