# Mitre ATT&CK T1055

## What it is
Like a spy who steals a soldier's uniform to move freely through a military base, Process Injection is when an adversary inserts malicious code into the address space of a legitimate, running process. This allows the attacker to execute under the identity and privileges of a trusted process, effectively hiding inside it. T1055 is the parent technique covering multiple injection sub-techniques (DLL injection, process hollowing, thread execution hijacking, etc.).

## Why it matters
During the SolarWinds attack, malicious code was injected into legitimate Windows processes to blend in with normal system activity and evade EDR tools that whitelist trusted processes. Defenders hunting this technique look for anomalies like `svchost.exe` making outbound network connections it shouldn't, since the payload runs under the host process's identity — not the attacker's own binary.

## Key facts
- **Sub-techniques include:** T1055.001 (DLL Injection), T1055.002 (Portable Executable Injection), T1055.012 (Process Hollowing), and T1055.004 (Asynchronous Procedure Call)
- **Process Hollowing** specifically unmaps a legitimate process's code from memory and replaces it with malicious code — the process looks legitimate from the outside
- **Detection indicators:** Unexpected cross-process memory writes (`WriteProcessMemory`), `CreateRemoteThread` calls, and mismatched process parent-child relationships
- **Privilege escalation link:** Injecting into a process running as SYSTEM (e.g., `lsass.exe`) can grant attackers elevated privileges without explicit privilege escalation
- **Defense evasion overlap:** T1055 is dual-classified — it serves both *execution* and *defense evasion* goals, making it especially dangerous

## Related concepts
[[Defense Evasion]] [[DLL Hijacking]] [[Privilege Escalation]] [[Process Hollowing]] [[LSASS Memory Access]]