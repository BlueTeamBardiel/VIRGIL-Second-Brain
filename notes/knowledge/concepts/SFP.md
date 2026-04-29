# SFP

## What it is
Like a lock that a thief can open with their *own* key by exploiting a flaw in how keys are designed, Saved Frame Pointer (SFP) exploitation manipulates the base pointer stored on the stack to redirect program execution. Specifically, the SFP is the 4-byte value saved by a function prologue that tells the CPU where the *previous* stack frame began, and attackers overwrite it during a buffer overflow to hijack control flow one step before the return address.

## Why it matters
In off-by-one buffer overflow scenarios, an attacker may not be able to fully overwrite the return address (EIP/RIP) but *can* corrupt the SFP by a single byte. When the current function returns and the *caller* executes its epilogue (`leave`/`ret`), the corrupted SFP redirects the stack pointer into attacker-controlled memory, achieving code execution through what looks like a legitimate function return — making it harder for simple stack canaries to detect.

## Key facts
- The SFP (also called saved EBP) sits on the stack **between local variables and the saved return address**
- Off-by-one overflows that miss the return address can still achieve exploitation via SFP corruption
- Stack canaries placed **between local variables and the SFP** do NOT protect against SFP overwrites in all implementations
- The `leave` instruction is equivalent to `mov esp, ebp; pop ebp` — restoring EBP from the (now corrupted) SFP
- Exploit mitigations like **ASLR + stack canaries + SafeSEH** together reduce SFP attack viability, but none alone is sufficient

## Related concepts
[[Buffer Overflow]] [[Stack Canary]] [[Return-Oriented Programming]] [[ASLR]] [[DEP]]