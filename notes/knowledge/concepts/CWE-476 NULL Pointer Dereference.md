# CWE-476 NULL Pointer Dereference

## What it is
Imagine a librarian handed a sticky note that says "the book is on shelf NULL" — when they walk to shelf NULL, there's nothing there, and everything collapses. A NULL Pointer Dereference occurs when a program attempts to read or write memory at address zero (or null), because a pointer was never properly initialized or a function returned NULL on failure and the code didn't check before using it. This typically crashes the application or, in privileged contexts, can be weaponized for privilege escalation.

## Why it matters
In 2013, the Linux kernel suffered CVE-2013-1763, where a NULL pointer dereference in socket handling allowed local users to gain root privileges by triggering a kernel crash path that mapped attacker-controlled code at address zero. This is the classic attacker playbook: force the NULL dereference, pre-map malicious shellcode at virtual address 0x00000000 (mmap_min_addr bypass), and hijack kernel execution flow.

## Key facts
- NULL pointer dereferences most commonly result in a **Denial of Service** via program crash (SIGSEGV/Access Violation), making this a reliability AND security issue
- In kernel-mode code, dereferencing NULL can lead to **privilege escalation**, not just a crash, because kernel context has unrestricted memory access
- Root cause is almost always **missing return-value validation** after calls like `malloc()`, `fopen()`, or `getenv()`
- Modern OS mitigations include **mmap_min_addr** (Linux) and **NULL page protection** (Windows), which prevent mapping code at address zero
- Ranked in the **CWE Top 25 Most Dangerous Software Weaknesses** and commonly flagged by SAST tools during secure code review

## Related concepts
[[CWE-119 Buffer Overflow]] [[CWE-252 Unchecked Return Value]] [[Privilege Escalation]] [[Memory-Safe Languages]] [[Static Application Security Testing]]