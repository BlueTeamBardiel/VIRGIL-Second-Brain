# MITRE ATT&CK T1070

## What it is
Like a burglar wiping fingerprints off every surface before leaving a crime scene, T1070 — **Indicator Removal** — describes adversaries deliberately destroying or manipulating artifacts that would reveal their presence. This includes clearing event logs, deleting bash history, timestomping files, and removing indicators from the host to frustrate forensic investigation.

## Why it matters
During the 2020 SolarWinds SUNBURST intrusion, attackers systematically deleted Windows Event Logs and modified file timestamps to slow incident responders and obscure their lateral movement timeline. Defenders who rely solely on host-based logs found themselves blind — a stark reminder that log forwarding to a centralized SIEM *before* tampering occurs is non-negotiable.

## Key facts
- **Sub-techniques include:** Clear Windows Event Logs (T1070.001), Clear Linux/Mac System Logs (T1070.002), File Deletion (T1070.004), Timestomping (T1070.006), and Indicator Removal from Tools (T1070.005)
- **Timestomping** modifies MACB timestamps (Modified, Accessed, Changed, Born) to disrupt timeline forensics — a key anti-forensics technique tested on CySA+
- **`wevtutil cl System`** is the canonical Windows command used to clear the System event log; its execution itself generates Event ID 1102 (audit log cleared) — if you catch it
- **Event ID 1102** (Security log cleared) and **Event ID 104** (System log cleared) are critical detection triggers defenders should alert on
- Centralizing logs via SIEM (Splunk, Elastic) or Windows Event Forwarding renders host-side log deletion largely ineffective against a prepared defender

## Related concepts
[[Anti-Forensics]] [[Windows Event Logs]] [[Log Management and SIEM]] [[File System Forensics]] [[Defense Evasion TA0005]]