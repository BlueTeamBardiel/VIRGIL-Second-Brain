# API Hooking

## What it is
Imagine slipping a fake receptionist into a doctor's office who intercepts every patient, reads their files, and then passes them along — that's API hooking. It's a technique where code intercepts calls to operating system or application APIs, allowing the hooker to inspect, modify, or block the call before it reaches its intended destination. It operates by redirecting function pointers in memory (e.g., via IAT patching or inline hooking) to point to attacker-controlled code.

## Why it matters
Credential-stealing malware like Mimikatz-adjacent tools use API hooking to intercept calls to `LsaLogonUser` or `BCryptHashData`, capturing plaintext passwords before they're encrypted in memory. Defenders use the same technique in EDR (Endpoint Detection and Response) agents — tools like CrowdStrike hook Windows APIs such as `CreateRemoteThread` or `VirtualAllocEx` to detect suspicious process injection attempts in real time.

## Key facts
- **Two primary methods**: IAT (Import Address Table) hooking replaces function pointers at load time; inline hooking overwrites the first bytes of a function with a `JMP` instruction to attacker code
- **SSDT hooking** targets the System Service Descriptor Table at the kernel level, giving attackers ring-0 visibility — historically used by rootkits like TDL4
- **Userland hooks** can be bypassed by malware making **direct syscalls**, skipping the hooked `ntdll.dll` entirely — a major cat-and-mouse challenge for EDR vendors
- **DLL injection** is a common delivery mechanism — a malicious DLL is loaded into a target process to install hooks from within
- Detected through behavioral analysis and memory integrity scanning — legitimate processes rarely rewrite their own function preambles

## Related concepts
[[Process Injection]] [[DLL Injection]] [[Rootkits]] [[Endpoint Detection and Response]] [[Syscall Evasion]]