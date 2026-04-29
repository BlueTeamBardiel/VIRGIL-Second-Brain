# heap buffer

## What it is
Think of the heap like a busy restaurant kitchen where cooks (programs) grab cutting boards (memory blocks) on demand — unlike a stack of preset trays, you request exactly what you need, when you need it. Precisely: a heap buffer is a region of dynamically allocated memory (via `malloc`, `new`, etc.) stored in the heap segment, used at runtime when the size of data isn't known at compile time. Unlike stack memory, heap memory persists until explicitly freed and is managed by the programmer.

## Why it matters
Heap buffer overflows were central to exploiting the 2021 **Sudo vulnerability (CVE-2021-3156)**, where an attacker could overflow a heap-allocated buffer by crafting malicious arguments, ultimately achieving root privileges on Linux systems. Defenders mitigate this by enabling heap protections like **ASLR** (Address Space Layout Randomization) and **safe unlinking** checks, which disrupt an attacker's ability to predict or corrupt adjacent memory structures reliably.

## Key facts
- A **heap buffer overflow** occurs when data written to a heap-allocated buffer exceeds its allocated size, corrupting adjacent heap metadata or other objects.
- Unlike stack overflows, heap overflows typically don't directly overwrite return addresses — instead they corrupt **function pointers, vtables, or heap chunk metadata**.
- **Use-after-free** is a related heap vulnerability: accessing heap memory after it's been freed, often allowing attackers to inject malicious data into the recycled memory.
- Mitigations include **heap canaries**, **guard pages**, **ASLR**, and memory-safe allocators (e.g., jemalloc with hardened options).
- Heap vulnerabilities are frequently weaponized in **browser exploits** because JavaScript engines heavily use dynamic memory allocation.

## Related concepts
[[buffer overflow]] [[use-after-free]] [[ASLR]] [[memory corruption]] [[stack buffer]]