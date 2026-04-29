# DLL Search Order Hijacking

## What it is
Imagine a librarian who fetches the first book matching a title she finds on a shelf — if you slip a counterfeit book onto an earlier shelf, she grabs yours instead of the real one. DLL Search Order Hijacking works the same way: Windows searches for Dynamic Link Libraries in a predictable sequence of directories, and attackers plant a malicious DLL in a location checked *before* the legitimate one. The application unknowingly loads the attacker's code with the privileges of the legitimate process.

## Why it matters
In 2020, threat actors exploited this technique against legitimate applications like `Teams.exe` and `OneDrive.exe`, dropping malicious DLLs into writable user-controlled directories. Because the hijacked process was signed and trusted, the malicious DLL executed with elevated credibility, bypassing application whitelisting controls and enabling persistent code execution without touching the registry.

## Key facts
- Windows default DLL search order: application directory → `%SystemRoot%\System32` → `%SystemRoot%\System` → `%SystemRoot%` → current working directory → `%PATH%` directories
- **SafeDllSearchMode** (enabled by default since XP SP2) moves the current working directory lower in the search order, reducing but not eliminating risk
- Attackers target **writable directories** that appear early in the search path, especially when a process runs as SYSTEM or a privileged user
- MITRE ATT&CK classifies this as **T1574.001** under Hijack Execution Flow
- Detection methods include monitoring for DLL loads from non-standard paths using Sysmon Event ID 7 and validating DLL signatures at load time

## Related concepts
[[Privilege Escalation]] [[Living off the Land]] [[Process Injection]] [[AppLocker Bypass]] [[Persistence Mechanisms]]