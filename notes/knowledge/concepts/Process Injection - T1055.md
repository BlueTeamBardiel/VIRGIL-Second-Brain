# Process Injection - T1055

## What it is
Like a parasite that hijacks a healthy host organism to survive and reproduce undetected, process injection forces malicious code to run inside a legitimate, trusted process. Specifically, an attacker writes and executes shellcode or a DLL within the memory space of another running process, borrowing its identity and privileges. The malicious code inherits the host process's security context, making detection significantly harder.

## Why it matters
During the SolarWinds supply chain attack, SUNBURST malware injected itself into the legitimate SolarWinds.BusinessLayerHost.exe process to masquerade as normal business software and evade endpoint detection tools that trusted the signed binary. Defenders responding to alerts must look beyond the process name and inspect memory contents and unusual outbound connections originating from otherwise-benign processes.

## Key facts
- **Common sub-techniques** include DLL Injection, Process Hollowing (T1055.012), Thread Execution Hijacking, and Reflective DLL Injection — each uses different Windows APIs but achieves the same goal
- **Classic API chain**: `OpenProcess()` → `VirtualAllocEx()` → `WriteProcessMemory()` → `CreateRemoteThread()` — monitoring these sequences is a key detection signal
- **Process Hollowing** unmaps a legitimate process's code and replaces it with malicious code, making the parent process appear entirely clean to casual inspection
- **Detection indicators**: unusual parent-child process relationships, legitimate processes (e.g., `svchost.exe`, `explorer.exe`) making unexpected network connections, or memory regions marked RWX (Read-Write-Execute)
- **Privilege escalation synergy**: injecting into a high-privilege process like `lsass.exe` can grant SYSTEM-level access without triggering UAC prompts

## Related concepts
[[Defense Evasion - TA0005]] [[DLL Hijacking - T1574]] [[Privilege Escalation - TA0004]] [[Process Hollowing - T1055.012]] [[Endpoint Detection and Response]]