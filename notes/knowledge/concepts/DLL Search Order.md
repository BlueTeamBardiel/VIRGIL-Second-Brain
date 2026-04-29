# DLL search order

## What it is
Like a librarian who checks the local branch before driving to the central archive, Windows searches for DLL files in a specific sequence of locations before giving up. When a program calls a DLL by name without a full path, Windows walks through a prioritized list of directories — starting with the application's own folder, then System32, then the current working directory, and so on — loading the first match it finds.

## Why it matters
Attackers exploit this with **DLL hijacking**: they drop a malicious DLL with a legitimate-sounding name (e.g., `version.dll`) into an application's local folder, knowing Windows will load it before the real system DLL. This technique was famously used in the CCleaner supply chain attack and is a common persistence and privilege escalation method because it requires no exploit — just write access to the right folder.

## Key facts
- Default Windows search order (safe DLL search mode enabled): (1) application directory, (2) System32, (3) System16, (4) Windows directory, (5) current working directory, (6) PATH directories
- **Safe DLL Search Mode** (enabled by default via registry key `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\SafeDllSearchMode`) moves the current working directory later in the list, reducing hijacking risk
- Developers can prevent hijacking entirely by specifying **absolute paths** or using `SetDllDirectory()` to control the search path programmatically
- DLL hijacking is categorized under **MITRE ATT&CK T1574.001** (Hijack Execution Flow: DLL Search Order Hijacking)
- Phantom DLL hijacking targets DLLs that an application *tries* to load but that don't exist on the system at all — no real DLL gets displaced

## Related concepts
[[DLL Hijacking]] [[Privilege Escalation]] [[Living Off the Land]] [[Process Injection]] [[MITRE ATT&CK]]