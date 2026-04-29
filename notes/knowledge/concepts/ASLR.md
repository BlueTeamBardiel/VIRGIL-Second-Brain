# ASLR

## What it is
Imagine a bank that moves its vault to a random floor of a skyscraper every night — a thief who memorized "floor 3" now has to guess among hundreds of options. Address Space Layout Randomization (ASLR) works the same way: it randomizes the memory addresses where an operating system loads executable code, stack, heap, and libraries each time a program runs. This forces attackers to guess where their payload lands rather than jumping to a known, hardcoded memory location.

## Why it matters
Before ASLR, return-to-libc attacks were devastatingly reliable — an attacker could overflow a buffer and redirect execution to `system()` at a predictable address in libc. With ASLR enabled, that same exploit crashes instead of executing, because `system()` lives at a different address on every run. It was a foundational mitigation that forced attackers to chain in techniques like heap spraying or information leaks just to recover those randomized addresses.

## Key facts
- ASLR is implemented at the **OS level**, not the application level — Windows, Linux, and macOS all support it natively
- Effective entropy matters: 32-bit systems may offer only ~16 bits of randomization, making brute-force feasible; 64-bit systems provide much stronger protection
- ASLR is **bypassed by information leaks** — any vulnerability that reveals a memory address defeats randomization entirely
- Works best when combined with **DEP/NX** (non-executable memory); neither control alone is sufficient
- Binaries must be compiled as **Position-Independent Executables (PIE)** for ASLR to fully randomize code segment addresses; non-PIE binaries load at fixed addresses regardless

## Related concepts
[[Buffer Overflow]] [[DEP/NX]] [[Return-Oriented Programming]] [[Heap Spraying]] [[Position-Independent Executable]]