# MITRE ATT&CK: T1055 - Process Injection

## What it is
Like a parasite hijacking a healthy organism's cells to reproduce undetected, process injection is when malware executes its code *inside* a legitimate, trusted process. Precisely: it's a technique where an adversary inserts malicious code into the memory space of a running process — such as `svchost.exe` or `explorer.exe` — causing that trusted process to execute attacker-controlled instructions.

## Why it matters
During the SolarWinds attack, threat actors used process injection to run malicious code inside legitimate Windows processes, bypassing endpoint detection tools that trusted those processes by default. Defenders who rely solely on process name allowlisting are blind to this technique — you must monitor for anomalous memory writes, unexpected cross-process API calls, and unusual parent-child process relationships.

## Key facts
- **Common sub-techniques** include DLL Injection (T1055.001), Process Hollowing (T1055.012), and Thread Execution Hijacking (T1055.003) — each varies in stealth and mechanism
- **Windows APIs abused**: `VirtualAllocEx`, `WriteProcessMemory`, and `CreateRemoteThread` are the classic injection triad — seeing these called in sequence is a major red flag
- **Defense evasion AND privilege escalation**: Process injection serves *both* purposes simultaneously — hiding in a trusted process while potentially inheriting its elevated privileges
- **Detection focus**: Monitor for processes accessing the memory of other processes (e.g., via `OpenProcess` with `PROCESS_VM_WRITE`) and anomalous network connections from normally non-network processes like `notepad.exe`
- **EDR telemetry** is the primary control — traditional AV signatures miss injection because the host binary itself is legitimate; behavioral analysis is required

## Related concepts
[[DLL Hijacking]] [[Defense Evasion]] [[Privilege Escalation]] [[Windows API Abuse]] [[EDR Detection]]