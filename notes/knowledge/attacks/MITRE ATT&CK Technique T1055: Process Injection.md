# MITRE ATT&CK Technique T1055: Process Injection

## What it is
Imagine a pickpocket slipping into a crowd by wearing a police officer's uniform — they move freely because everyone trusts the badge. Process injection works the same way: malicious code is inserted into the memory space of a legitimate, trusted running process (like `explorer.exe` or `svchost.exe`), borrowing its identity and permissions to execute undetected.

## Why it matters
During the 2020 SolarWinds breach, attackers used process injection techniques to execute malicious code within trusted system processes, effectively hiding their activity from endpoint detection tools that whitelisted those processes. Defenders who rely solely on process-name allowlisting are blind to this attack — behavioral analysis of memory anomalies and parent-child process relationships is required to catch it.

## Key facts
- **Sub-techniques include:** DLL Injection (T1055.001), Process Hollowing (T1055.012), Thread Execution Hijacking (T1055.003), and Reflective DLL Injection — each uses a different mechanism to load code into another process.
- **Windows APIs abused:** `VirtualAllocEx`, `WriteProcessMemory`, `CreateRemoteThread`, and `SetWindowsHookEx` are the classic injection chain; monitoring these calls is a primary detection strategy.
- **Defense evasion + privilege escalation:** Injection into a high-privilege process (e.g., LSASS) can grant SYSTEM-level access without triggering UAC prompts.
- **Detection approach:** Look for processes with unexpected network connections, memory regions marked RWX (read-write-execute), or unusual parent-child relationships (e.g., `Word.exe` spawning `cmd.exe`).
- **Mapped to:** MITRE Tactic categories **Defense Evasion** and **Privilege Escalation** simultaneously, making it doubly dangerous.

## Related concepts
[[Process Hollowing]] [[DLL Injection]] [[LSASS Credential Dumping]] [[Defense Evasion]] [[Windows API Abuse]]