# Create or Modify System Process - Windows Service

## What it is
Think of Windows Services like the building's utility staff — they show up before anyone else, work in the background, and nobody questions them. Adversaries exploit this trust by installing malicious code as a service, giving it the same quiet, persistent access. Technically, this is MITRE ATT&CK T1543.003: creating or modifying a Windows Service to execute attacker-controlled binaries, often with SYSTEM-level privileges.

## Why it matters
During the SolarWinds attack, threat actors modified legitimate service configurations to maintain persistence across reboots without triggering obvious alerts. Defenders who monitored Service Control Manager (SCM) event logs (Event ID 7045 — "A new service was installed") caught anomalous service installations that behavioral signatures missed entirely.

## Key facts
- **MITRE ATT&CK T1543.003** — falls under the "Create or Modify System Process" technique family, used for both persistence and privilege escalation
- Services are registered in `HKLM\SYSTEM\CurrentControlSet\Services` — malicious entries here survive reboots and run before user logon
- Attackers commonly use `sc.exe`, `reg.exe`, or PowerShell `New-Service` to install rogue services without GUI interaction
- Key detection event IDs: **7045** (new service created), **7040** (service start type changed), **4697** (security audit log — service installed)
- Privilege requirement: typically requires Administrator or SYSTEM rights to create services, meaning this technique often follows a privilege escalation step

## Related concepts
[[Privilege Escalation]] [[Persistence Mechanisms]] [[Windows Registry]] [[Event Log Monitoring]] [[Endpoint Detection and Response]]