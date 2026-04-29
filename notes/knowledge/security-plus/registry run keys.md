# registry run keys

## What it is
Think of them like a restaurant's opening checklist — items written there automatically get executed every time the kitchen "opens." Registry Run keys are specific Windows Registry locations that store references to programs, causing them to launch automatically whenever a user logs in or the system boots.

## Why it matters
Attackers love Run keys because they provide persistence without touching the filesystem's obvious autostart folders. In a real-world intrusion, a RAT (Remote Access Trojan) will write its executable path to `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` so it silently relaunches every time the victim logs in — surviving reboots without admin privileges when using the HKCU hive.

## Key facts
- **Primary locations:** `HKLM\Software\Microsoft\Windows\CurrentVersion\Run` (system-wide, requires admin) and `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` (current user only, no admin needed)
- **RunOnce variants** (`RunOnce`, `RunOnceEx`) execute the entry a single time then delete it — useful for stealthy one-shot payloads that self-clean
- **MITRE ATT&CK T1547.001** specifically catalogs Registry Run Keys as a Boot/Logon Autostart Execution technique
- Defenders use **Autoruns** (Sysinternals) to enumerate all Run key entries and flag unsigned or suspicious binaries
- Detection signatures should monitor registry write events to Run/RunOnce paths via **Sysmon Event ID 13** (Registry value set)

## Related concepts
[[persistence mechanisms]] [[Windows Registry]] [[autoruns and autostart locations]] [[MITRE ATT&CK]] [[privilege escalation]]