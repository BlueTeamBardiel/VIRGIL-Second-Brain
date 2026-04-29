# KASLR

## What it is
Imagine a bank that rearranges its vault, teller windows, and security office to a random new location every time it opens — so even if a thief memorized the blueprint, it's useless tomorrow. Kernel Address Space Layout Randomization (KASLR) works the same way: it randomizes the memory address where the OS kernel loads at boot time, so attackers cannot reliably predict where kernel code and data structures live in memory.

## Why it matters
Exploits like ret2kernel and privilege escalation attacks depend on knowing *exact* kernel memory addresses to redirect execution flow or overwrite critical structures. In 2017, the KASLR bypass technique used in attacks against Linux leveraged timing side-channels to infer the kernel base address — demonstrating that KASLR is a speed bump, not a wall. It significantly raises the cost of kernel exploitation but must be paired with other mitigations to be effective.

## Key facts
- KASLR randomizes the kernel's base load address at each boot, typically offering 9–12 bits of entropy on x86-64 Linux systems
- It is a **probabilistic** defense — it reduces attack reliability rather than eliminating vulnerabilities outright
- KASLR can be defeated by **information disclosure vulnerabilities** that leak kernel addresses (e.g., reading `/proc/kallsyms` as root, or exploiting side-channels like Spectre)
- On Windows, KASLR is implemented as part of the broader **ASLR** mechanism, randomizing kernel and driver load addresses
- Works in conjunction with **SMEP** (Supervisor Mode Execution Prevention) and **SMAP** to form a layered kernel defense stack

## Related concepts
[[ASLR]] [[DEP]] [[Privilege Escalation]] [[Spectre]] [[Return-Oriented Programming]]