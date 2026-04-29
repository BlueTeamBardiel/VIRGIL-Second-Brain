# DLL Injection

## What it is
Imagine slipping a fake ingredient into a chef's mise en place — the chef grabs it automatically and unknowingly cooks it into every dish. DLL injection is the technique of forcing a running process to load a malicious Dynamic Link Library (DLL) into its address space, executing attacker-controlled code under the identity and privileges of the target process. The injected code runs as part of a legitimate process, inheriting its permissions and evading process-level detection.

## Why it matters
The Cobalt Strike red-team framework uses DLL injection extensively to migrate shellcode into trusted processes like `explorer.exe` or `svchost.exe`, making malicious activity blend with normal system behavior and evade endpoint detection tools that filter on process names. Defenders hunting for this technique monitor for suspicious calls to `CreateRemoteThread` combined with `VirtualAllocEx` and `WriteProcessMemory` — the classic Windows API triad that signals injection in progress.

## Key facts
- **Classic injection API chain:** `OpenProcess` → `VirtualAllocEx` → `WriteProcessMemory` → `CreateRemoteThread` (or `LoadLibrary` as the thread entry point)
- **Reflective DLL injection** loads the DLL directly from memory without touching disk, bypassing file-based AV scanning — a key evasion advancement
- **Process hollowing** is a related but distinct technique; DLL injection *adds* code to a live process, while hollowing *replaces* a process's code entirely
- Injecting into a high-privilege process (e.g., `lsass.exe`) can grant SYSTEM-level code execution without a separate privilege escalation step
- Detection artifacts include unexpected loaded modules in a process (auditable via `Process Hacker` or Sysmon **Event ID 7**) and anomalous cross-process memory writes

## Related concepts
[[Process Hollowing]] [[Privilege Escalation]] [[Reflective Loading]] [[Living off the Land]] [[Endpoint Detection and Response]]