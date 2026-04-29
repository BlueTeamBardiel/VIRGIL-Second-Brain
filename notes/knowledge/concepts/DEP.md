# DEP

## What it is
Think of memory like a city zoning map — some districts are for living (data), others for working (code execution). DEP enforces that zoning: **Data Execution Prevention** is a hardware and software security feature that marks memory regions as either executable or non-executable, preventing code from running in areas designated only for data storage.

## Why it matters
Classic buffer overflow shellcode attacks work by injecting malicious code into the stack or heap, then jumping to it. DEP defeats this by marking the stack as non-executable — when the CPU tries to execute the attacker's shellcode sitting in that data region, it triggers an access violation and crashes the process instead of running the payload. This forced attackers to evolve toward **Return-Oriented Programming (ROP)**, which reuses existing executable code rather than injecting new code.

## Key facts
- **Hardware DEP** (NX/XD bit) is enforced by the CPU — AMD calls it "NX" (No-Execute), Intel calls it "XD" (Execute Disable)
- **Software DEP** is an OS-level fallback for CPUs lacking NX/XD support, providing weaker protection
- Windows implements DEP in four modes: `OptIn`, `OptOut`, `AlwaysOn`, and `AlwaysOff`
- DEP alone is insufficient — attackers bypass it with **ROP chains** that pivot through legitimate executable memory
- DEP is most effective when paired with **ASLR**, since ASLR randomizes where legitimate code lives, making ROP gadget targeting much harder

## Related concepts
[[ASLR]] [[Buffer Overflow]] [[Return-Oriented Programming]] [[Stack Canaries]] [[Memory Segmentation]]