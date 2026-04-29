# ExecShield

## What it is
Like a bouncer who checks IDs at specific sections of a club — some areas are "dance floor only" (execute), others are "sit-down only" (data) — ExecShield enforces strict memory region permissions. It is a Linux kernel security feature that marks memory regions as either executable or non-executable, preventing code stored in data regions (stack, heap) from ever being run.

## Why it matters
Without ExecShield, classic buffer overflow attacks work by injecting shellcode into the stack and redirecting execution to it. With ExecShield enabled, even if an attacker successfully overwrites the return address to point at their injected shellcode, the CPU refuses to execute it because that memory page is flagged as non-executable — the shellcode sits there, harmless, unable to run.

## Key facts
- Introduced in the Linux kernel around 2.6.x era, originally as a Red Hat patch before broader adoption
- Works alongside the CPU's **NX bit** (AMD) / **XD bit** (Intel) hardware feature — ExecShield is the OS-level enforcement layer for this hardware capability
- Mitigates **stack-based and heap-based buffer overflow** exploitation by blocking direct shellcode execution
- Does **not** stop Return-Oriented Programming (ROP) attacks, which reuse existing executable code rather than injecting new code — making ASLR a necessary complement
- On modern Linux systems, ExecShield's functionality is largely superseded by **PaX** and default kernel NX enforcement, but the concept underpins all modern DEP/NX implementations

## Related concepts
[[Data Execution Prevention (DEP)]] [[Address Space Layout Randomization (ASLR)]] [[Buffer Overflow]] [[NX Bit]] [[Return-Oriented Programming (ROP)]]