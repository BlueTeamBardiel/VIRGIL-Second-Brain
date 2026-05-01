# Native API

## What it is
Think of Windows as a restaurant where most customers order through a waiter (Win32 API), but Native API is the kitchen door — a direct path to the chef (kernel) that bypasses the front-of-house entirely. Precisely, the Native API (primarily `ntdll.dll`) exposes low-level system calls that communicate directly with the Windows NT kernel, sitting beneath the familiar Win32 API layer that most applications use.

## Why it matters
Malware authors abuse Native API calls like `NtAllocateVirtualMemory`, `NtWriteVirtualMemory`, and `NtCreateThreadEx` to perform process injection while evading security tools that only monitor higher-level Win32 calls. Because many EDR products hook Win32 functions rather than syscalls directly, attackers who invoke syscalls manually (a technique called "direct syscalls") can slip past detection entirely — a tactic seen in tools like Cobalt Strike and custom shellcode loaders.

## Key facts
- **MITRE ATT&CK T1106**: Native API is formally catalogued as an execution technique used to bypass security controls monitoring standard API calls.
- `ntdll.dll` acts as the bridge — it translates Native API calls into system call numbers (syscall stubs) that trigger kernel-mode transitions via the `syscall`/`sysenter` instruction.
- **Direct syscall evasion**: Advanced malware skips `ntdll.dll` entirely and calls the kernel using hardcoded syscall numbers, defeating userland API hooking.
- Native API calls are undocumented by Microsoft — defenders must rely on community research (e.g., ntinternals.net) to understand them.
- Security tools like **Sysmon** and kernel-level EDRs monitor at the syscall layer specifically to counter Native API abuse.

## Related concepts
[[Process Injection - T1055]] [[Defense Evasion]] [[Dynamic-link Library Injection]] [[Hooking]] [[Syscall]]
