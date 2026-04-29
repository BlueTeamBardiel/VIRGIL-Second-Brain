# registry

## What it is
Think of the Windows Registry as a giant hotel guest book that every program must sign when it checks in — recording its preferences, its room number, and what services it needs. Precisely, it is a hierarchical database in Windows that stores low-level settings for the OS, hardware, installed applications, and user preferences, organized into hives like HKEY_LOCAL_MACHINE and HKEY_CURRENT_USER.

## Why it matters
Attackers use registry run keys — specifically `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` — to achieve persistence, ensuring their malware re-launches every time a user logs in. Defenders use tools like Autorautoruns and SIEM alerting on registry write events to detect these unauthorized modifications before the attacker establishes a deeper foothold.

## Key facts
- **Five root hives**: HKLM (machine-wide settings), HKCU (current user), HKCR (file associations), HKU (all users), HKCC (hardware profile)
- **Registry run keys** are one of the most common persistence mechanisms catalogued in MITRE ATT&CK (T1547.001)
- **Fileless malware** frequently lives entirely in the registry, storing encoded payloads in keys to evade disk-based AV scanning
- **RegEdit.exe** and **reg.exe** are native Windows tools; their unexpected execution is a high-fidelity detection signal
- **Hive files** are stored on disk (e.g., `C:\Windows\System32\config\SAM`) — the SAM hive holds hashed local account credentials and is a prime target for offline attacks

## Related concepts
[[persistence mechanisms]] [[fileless malware]] [[Windows privilege escalation]] [[MITRE ATT&CK]] [[credential dumping]]