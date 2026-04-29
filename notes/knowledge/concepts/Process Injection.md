# Process Injection

## What it is
Imagine a pickpocket slipping their hand into your jacket pocket — not stealing the jacket, but *using your pocket* to hide their hand from security cameras. Process injection works the same way: an attacker inserts malicious code into a legitimate, already-running process (like `explorer.exe` or `svchost.exe`) so that the malware executes under that trusted process's identity, inheriting its permissions and blending into normal system activity.

## Why it matters
In the SolarWinds attack, threat actors used process injection techniques to execute code within trusted processes, evading endpoint detection tools that whitelisted those processes by default. Defenders must look beyond *what process is running* and examine *what that process is actually doing* — unusual memory allocations, unexpected network connections, or cross-process memory writes are the red flags that betray injected code.

## Key facts
- **Classic technique:** `VirtualAllocEx` + `WriteProcessMemory` + `CreateRemoteThread` — three Windows API calls that allocate space, write shellcode, and execute it inside a target process.
- **DLL Injection** is the most common variant; `SetWindowsHookEx` and `AppInit_DLLs` registry keys are frequent abuse vectors.
- **Process Hollowing** (a subtype) replaces a legitimate process's code entirely with malicious code while keeping the process name intact — harder to detect than basic injection.
- **MITRE ATT&CK:** Process Injection is catalogued under **T1055**, with over a dozen documented sub-techniques.
- **Detection signals:** Unexpected `OpenProcess` calls, memory regions marked `RWX` (read-write-execute), and processes spawning threads not originating from their own image.

## Related concepts
[[DLL Hijacking]] [[Privilege Escalation]] [[Defense Evasion]] [[Living off the Land]] [[MITRE ATT&CK Framework]]