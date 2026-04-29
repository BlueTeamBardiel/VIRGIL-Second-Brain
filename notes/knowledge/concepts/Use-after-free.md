# use-after-free

## What it is
Imagine a hotel room that's been checked out and re-rented to a new guest — but the old guest still has a key and walks in whenever they want. Use-after-free (UAF) is a memory corruption vulnerability where a program continues to read or write to a memory region after it has been freed (deallocated), allowing an attacker to plant malicious data in that reclaimed memory and redirect program execution.

## Why it matters
CVE-2021-21166, a UAF vulnerability in Google Chrome's audio component, was actively exploited in the wild to achieve remote code execution — attackers could craft a malicious webpage that triggered the bug, freed the memory, replaced it with shellcode, and then caused Chrome to execute it. Defenders patch these by enforcing memory-safe languages (Rust) or compiler mitigations like AddressSanitizer during development.

## Key facts
- UAF is classified under **CWE-416** and consistently appears in OWASP/MITRE top vulnerability lists for C and C++ codebases
- The root cause is dangling pointers — pointers that still reference freed heap memory, which the allocator may assign to a new, attacker-controlled object
- Exploitation typically follows a **three-step pattern**: trigger the free, groom the heap (fill freed space with attacker data), then trigger the use
- Modern mitigations include **heap isolation, pointer tagging, and MemTagSanitizer** on ARM; Windows deploys **Segment Heap** and **Control Flow Guard (CFG)** to complicate exploitation
- UAF can lead to **arbitrary code execution, privilege escalation, or information disclosure** depending on what data occupies the reclaimed memory

## Related concepts
[[buffer overflow]] [[heap spraying]] [[memory corruption]] [[dangling pointer]] [[control flow hijacking]]