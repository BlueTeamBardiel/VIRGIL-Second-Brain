# log evasion

## What it is
Like a burglar who wears gloves, disables the doorbell camera, and shreds the visitor log before leaving — log evasion is the attacker's deliberate effort to prevent, corrupt, or delete audit trails that would record their actions. Precisely: it is any technique used to inhibit logging systems from capturing malicious activity, or to alter/destroy log data after the fact to obstruct forensic investigation.

## Why it matters
During the 2020 SolarWinds intrusion, threat actors used timestomping and selectively cleared Windows Event Logs on compromised hosts to delay detection and obscure their lateral movement for months. Defenders who had centralized, tamper-resistant SIEM logging (forwarding events off-host in real time) were significantly better positioned to reconstruct the kill chain than those relying solely on local logs.

## Key facts
- **Timestomping** modifies file metadata (MACB timestamps) to make malicious files appear benign or pre-date the intrusion window
- **Event log clearing** via `wevtutil cl Security` or PowerShell clears Windows Security/System/Application logs and itself generates Event ID **1102** (audit log cleared) — a detectable artifact
- **Log flooding** overwhelms a SIEM with high-volume noise to bury malicious entries, exploiting rate-limiting or storage caps
- **NTFS alternate data streams** and direct disk writes can bypass API-level logging hooks used by many EDR/SIEM agents
- The CySA+ exam expects knowledge that **centralized, off-host log forwarding** (e.g., syslog to a SIEM) is the primary control against local log tampering

## Related concepts
[[SIEM]] [[timestomping]] [[Windows Event Logs]] [[anti-forensics]] [[log management]]