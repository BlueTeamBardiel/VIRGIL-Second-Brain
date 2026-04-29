# CWE-119: Improper Restriction of Operations within the Bounds of a Buffer

## What it is
Imagine a parking garage with 10 spaces — if a valet keeps parking cars beyond space 10, they start crushing vehicles in the neighboring lot. A buffer is a fixed-size memory region, and CWE-119 occurs when a program reads from or writes to memory locations outside that allocated region, corrupting adjacent data or code.

## Why it matters
The 1988 Morris Worm exploited a buffer overflow in the Unix `fingerd` daemon by sending input longer than the program's fixed buffer could hold, overwriting the return address on the stack and redirecting execution to attacker-controlled shellcode. This 35-year-old technique still underlies modern exploits because legacy C/C++ codebases remain pervasive in embedded systems, operating systems, and network devices.

## Key facts
- CWE-119 is the **parent category** encompassing both buffer overflows (CWE-120) and buffer over-reads (CWE-126/CWE-125); it covers both reads and writes beyond bounds
- The Heartbleed bug (CVE-2014-0160) was a **buffer over-read** — a child of CWE-119 — that leaked up to 64KB of server memory per request without writing anything
- Mitigations include **Stack Canaries**, **ASLR (Address Space Layout Randomization)**, **DEP/NX (Data Execution Prevention)**, and **safe language adoption** (Rust, Go)
- On the CVSS scale, buffer overflow vulnerabilities frequently score **Critical (9.0+)** due to potential for arbitrary code execution
- Compilers can detect many instances at build time using flags like `-fstack-protector` (GCC) or `/GS` (MSVC), making **secure build pipelines** a first-line defense

## Related concepts
[[Buffer Overflow]] [[Stack Smashing]] [[Address Space Layout Randomization]] [[Memory-Safe Languages]] [[CWE-120: Classic Buffer Overflow]]