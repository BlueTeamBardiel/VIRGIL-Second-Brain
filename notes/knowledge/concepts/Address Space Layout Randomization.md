# Address Space Layout Randomization

## What it is
Imagine a burglar who memorized the exact floor plan of a house — every night the owners rearrange every room randomly, so the memorized map is useless. ASLR does exactly this: it randomizes the memory addresses where a process loads its stack, heap, and libraries each time a program runs, so attackers cannot reliably predict where their shellcode or target functions will land.

## Why it matters
Return-oriented programming (ROP) attacks chain together existing code snippets ("gadgets") already loaded in memory to bypass non-executable memory protections. ASLR defeats this by making gadget addresses unpredictable — an attacker who hardcodes the address `0x7ffff7a3d2b0` for a libc function will almost certainly crash the process instead of hijacking it. This is why exploitation frameworks like Metasploit often require a separate information-leak vulnerability to defeat ASLR before a full compromise is possible.

## Key facts
- ASLR operates at the OS level; Linux, Windows (Vista+), and macOS all implement it natively
- On 32-bit systems, entropy is low (~16 bits), making brute-force feasible in minutes; 64-bit systems provide ~28–40 bits of entropy, making brute-force impractical
- ASLR must be paired with **DEP/NX** (Data Execution Prevention / No-Execute) to be effective — neither control alone is sufficient
- Executables must be compiled as **Position-Independent Executables (PIE)** for ASLR to randomize the code segment itself; non-PIE binaries load at fixed addresses
- Information disclosure vulnerabilities (e.g., format string bugs) are specifically dangerous because they leak memory addresses, effectively bypassing ASLR

## Related concepts
[[Data Execution Prevention]] [[Return-Oriented Programming]] [[Buffer Overflow]] [[Position-Independent Executable]] [[Memory Corruption Vulnerabilities]]