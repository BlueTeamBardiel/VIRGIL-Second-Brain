# Process Discovery

## What it is
Like a burglar who cases a house by peeking through windows before breaking in, an attacker enumerates running processes to map what's alive on a system before deciding their next move. Process Discovery (MITRE ATT&CK T1057) is a reconnaissance technique where adversaries list active processes on a compromised host to identify security tools, understand the environment, and locate targets of interest.

## Why it matters
During the SolarWinds supply chain attack, implanted malware performed process discovery to detect whether security analysis tools like Wireshark or Procmon were running — if found, the malware would lie dormant to avoid detection. Defenders can flip this around by baselining normal process lists and alerting on anomalous parent-child process relationships, such as `winword.exe` spawning `cmd.exe`.

## Key facts
- **Common commands used**: `tasklist` (Windows), `ps aux` (Linux), `Get-Process` (PowerShell) — all generate detectable command-line telemetry
- **Mapped to MITRE ATT&CK T1057** under the Discovery tactic; frequently chained with Defense Evasion after identifying active security products
- **Detection opportunity**: Process creation events (Windows Event ID 4688 or Sysmon Event ID 1) log the exact commands attackers use during enumeration
- **Living-off-the-land (LotL)** attacks favor built-in tools like `tasklist` and `wmic process list` because they blend with normal admin activity
- **Indicators of compromise**: Unusual processes running process enumeration commands — especially from Office apps, browsers, or other unexpected parent processes

## Related concepts
[[Defense Evasion]] [[Living Off the Land]] [[Privilege Escalation]] [[Endpoint Detection and Response]] [[MITRE ATT&CK Framework]]