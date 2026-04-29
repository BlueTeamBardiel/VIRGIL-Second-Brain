# Indicator Removal

## What it is
Like a burglar wiping fingerprints and vacuuming footprints before leaving a crime scene, indicator removal is when attackers deliberately destroy or manipulate evidence of their presence after a compromise. Precisely, it is a defense evasion technique (MITRE ATT&CK T1070) where adversaries delete, modify, or obfuscate artifacts — logs, timestamps, files, or network traces — to hinder forensic investigation and incident response.

## Why it matters
During the 2020 SolarWinds supply chain attack, threat actors used timestomping and log deletion to obscure their lateral movement across victim networks for months before detection. Because responders rely on Windows Event Logs and SIEM alerts to reconstruct attack timelines, systematic log clearing left critical gaps that delayed containment and attribution significantly.

## Key facts
- **Sub-techniques include:** Clear Windows Event Logs (T1070.001), Clear Linux/Mac System Logs (T1070.002), File Deletion (T1070.004), Timestomping (T1070.006), and Network Share Connection Removal (T1070.005)
- **Timestomping** modifies MAC (Modified, Accessed, Created) timestamps on files to defeat timeline analysis — a favorite anti-forensics move
- **Detecting indicator removal** often relies on *absence of evidence*: gaps in log sequences, missing event IDs, or sudden jumps in log timestamps are red flags
- **Windows Security Event ID 1102** (Audit log cleared) and **Event ID 104** (System log cleared) are critical monitoring triggers for defenders
- Attackers with **SYSTEM or Administrator privileges** can clear Windows Event Logs using `wevtutil cl` or PowerShell `Clear-EventLog`; proper log forwarding to an immutable SIEM before deletion defeats this

## Related concepts
[[Anti-Forensics]] [[Log Management]] [[MITRE ATT&CK Framework]] [[Timestomping]] [[Defense Evasion]]