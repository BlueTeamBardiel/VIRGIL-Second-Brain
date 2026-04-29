# NX bit

## What it is
Think of RAM like a notebook with two types of pages: ones where you *write* code, and ones where you *store* data — and a rule that says you can never *execute* what's written on a data page. The NX (No-eXecute) bit is a CPU-level hardware flag that marks memory pages as either executable or non-executable, preventing the processor from running code injected into data regions like the stack or heap. Intel calls it XD (Execute Disable); AMD calls it NX; ARM calls it XN (Execute Never).

## Why it matters
Classic stack-based buffer overflow attacks work by injecting shellcode into the stack and then redirecting execution to it. With the NX bit enabled, even if an attacker successfully overwrites a return address to point at their injected payload, the CPU refuses to execute it — triggering a fault instead of running the shellcode. This forced attackers to pivot to techniques like Return-Oriented Programming (ROP), which reuses *existing* executable code rather than injecting new code.

## Key facts
- NX is a **hardware enforcement** mechanism, not software — it operates at the CPU and MMU level
- Enabled by default in all modern 64-bit operating systems (Windows via DEP, Linux via kernel support)
- Windows implements NX as **Data Execution Prevention (DEP)**, configurable in system settings
- NX alone does **not** stop ROP attacks, which bypass it by chaining existing executable gadgets
- BIOS/UEFI settings can disable NX system-wide — a misconfiguration with serious security implications
- Works in conjunction with **ASLR** to make exploitation significantly harder; neither is fully effective alone

## Related concepts
[[Data Execution Prevention (DEP)]] [[Address Space Layout Randomization (ASLR)]] [[Return-Oriented Programming (ROP)]] [[Buffer Overflow]] [[Stack Canaries]]