# T1055 - Process Injection

## What it is
Like a puppeteer slipping their hand inside an existing marionette rather than building a new one, process injection is the technique of inserting malicious code into the memory space of a legitimate, already-running process. This allows the attacker's code to execute under the identity and permissions of the host process, effectively borrowing its reputation.

## Why it matters
During the 2017 NotPetya campaign, attackers used process injection to run malicious code inside legitimate Windows processes like `lsass.exe`, bypassing application whitelisting controls that would have blocked a standalone malicious executable. Defenders watching for new process creation would see nothing suspicious — the threat was hiding inside trusted infrastructure.

## Key facts
- **Common sub-techniques** include DLL injection, process hollowing, reflective DLL loading, and thread execution hijacking — each a distinct delivery mechanism but same core goal.
- **Process hollowing** (T1055.012) unmaps a legitimate process's code from memory and replaces it with malicious code — the process shell looks real, the contents are not.
- **Detection pivot**: Look for processes with network connections that don't normally make them (e.g., `notepad.exe` calling out to an external IP), or mismatched parent-child process relationships.
- **Antivirus evasion** is the primary motivation — injected code runs in memory without touching disk, defeating signature-based file scanning.
- Security tools like **EDR (Endpoint Detection and Response)** detect injection by monitoring Windows API calls such as `VirtualAllocEx`, `WriteProcessMemory`, and `CreateRemoteThread` — the three-step fingerprint of classic DLL injection.

## Related concepts
[[T1055.012 - Process Hollowing]] [[T1059 - Command and Scripting Interpreter]] [[T1562 - Impair Defenses]] [[EDR Detection]] [[DLL Hijacking]]