# heap

## What it is
Think of the heap like a busy restaurant's open seating section — tables (memory blocks) get claimed and freed constantly, with no fixed order. Technically, the heap is a region of dynamic memory allocated at runtime via functions like `malloc()` and `free()`, managed by the program rather than the CPU stack.

## Why it matters
Heap exploitation is at the core of many critical vulnerabilities. In the infamous **Log4Shell (CVE-2021-44228)**, attackers triggered heap-based deserialization to achieve remote code execution on millions of servers. Understanding heap behavior helps defenders prioritize patching and configure exploit mitigations like ASLR and heap guards.

## Key facts
- **Heap overflow**: Writing beyond an allocated heap buffer can corrupt adjacent memory blocks, overwriting metadata or function pointers to redirect execution flow.
- **Use-After-Free (UAF)**: Accessing heap memory after it's been freed allows attackers to place malicious data into the recycled memory region — a leading exploit class in modern browsers.
- **Heap spraying**: An attacker floods the heap with shellcode/NOP sleds to increase the probability that a hijacked pointer lands in attacker-controlled memory.
- **Mitigations**: Address Space Layout Randomization (ASLR), heap cookies/canaries, and safe unlinking in modern allocators (e.g., glibc's ptmalloc) are designed to defeat heap exploitation.
- **Heap vs. Stack**: The stack is LIFO and fixed-size per frame; the heap is flexible but more complex to manage, making it a richer attack surface for memory corruption bugs.

## Related concepts
[[buffer overflow]] [[use-after-free]] [[ASLR]] [[memory corruption]] [[exploit mitigation]]