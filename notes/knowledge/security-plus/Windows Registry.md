# Windows Registry

## What it is
Think of it as the nervous system of Windows — a centralized hierarchical database that controls everything from which programs launch at startup to how the OS handles passwords. Precisely, it is a structured repository storing configuration settings, options, and values for the operating system, hardware, and installed applications, organized into hives (e.g., HKEY_LOCAL_MACHINE, HKEY_CURRENT_USER).

## Why it matters
Attackers routinely abuse the registry for **persistence** — malware writes itself to `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` so it survives reboots without touching scheduled tasks or services. During incident response, defenders hunt these "autorun" keys as a primary indicator of compromise, and tools like Autoruns (Sysinternals) are specifically built to expose them.

## Key facts
- **Five root hives**: HKLM (machine-wide settings), HKCU (current user), HKCR (file associations), HKU (all user profiles), HKCC (hardware profile)
- **HKLM\SAM** stores hashed local account credentials — it is ACL-protected and a prime target for credential dumping attacks (e.g., `reg save` + offline cracking)
- Registry values have types: REG_SZ (string), REG_DWORD (32-bit integer), REG_BINARY — malware often hides shellcode in REG_BINARY values
- **Registry Run keys** (`CurrentVersion\Run`, `RunOnce`, `RunServices`) are MITRE ATT&CK T1547.001 — a top persistence technique tested on Security+ and CySA+
- Registry hives are physically stored as files (e.g., `C:\Windows\System32\config\SYSTEM`) and can be parsed offline by forensic tools like RegRipper

## Related concepts
[[Persistence Mechanisms]] [[Credential Dumping]] [[Windows Autoruns]] [[MITRE ATT&CK]] [[Privilege Escalation]]