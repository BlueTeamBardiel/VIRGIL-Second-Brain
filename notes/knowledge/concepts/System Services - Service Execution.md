# System Services - Service Execution

## What it is
Think of Windows services like the building's janitorial staff — they work quietly in the background with master keys to every room, often without anyone watching. Service Execution (MITRE ATT&CK T1569.002) is a technique where attackers create, modify, or abuse Windows services (or similar OS daemons) to execute malicious code, often with SYSTEM-level privileges and persistence across reboots.

## Why it matters
During the NotPetya outbreak, attackers used `sc.exe` to remotely create and start services across networked machines, propagating laterally at machine speed without human interaction. Defenders who monitored for unexpected `CreateService` API calls or new entries under `HKLM\SYSTEM\CurrentControlSet\Services` could catch the activity before encryption began.

## Key facts
- **`sc.exe` and PowerShell's `New-Service`** are the most common living-off-the-land tools attackers use to register malicious services — both are native Windows binaries, making detection harder
- Services run under **LocalSystem, LocalService, or NetworkService** — LocalSystem has unrestricted local access, making it the prime target for privilege escalation
- Malicious services are frequently **disguised with typosquatted names** (e.g., `WindowsUpdateSvc` instead of `wuauserv`) to blend into normal service lists
- **Event ID 7045** (System log) fires when a new service is installed — this single event ID is a high-fidelity detection signal for service-based attacks
- Service binaries stored in **unusual paths** (e.g., `C:\Users\Public\` or `C:\Temp\`) rather than `System32` are a strong indicator of compromise

## Related concepts
[[Privilege Escalation]] [[Persistence Mechanisms]] [[Living Off the Land Binaries (LOLBins)]] [[Windows Registry]] [[Lateral Movement]]