# CWE-120 Buffer Overflow

## What it is
Imagine pouring a gallon of water into a coffee cup — the overflow spills onto whatever is sitting next to it on the counter. A buffer overflow occurs when a program writes more data into a fixed-size memory buffer than it was allocated to hold, causing the excess data to overwrite adjacent memory regions. This can corrupt data, crash the program, or — critically — redirect execution to attacker-controlled code.

## Why it matters
The Morris Worm of 1988 exploited a buffer overflow in the Unix `fingerd` daemon, becoming the first major self-propagating worm and infecting roughly 6,000 machines. Modern exploits use the same principle: an attacker crafts input that overwrites the **return address** on the stack, redirecting execution to shellcode or a ROP chain. Defenses like ASLR, DEP/NX bits, and stack canaries exist specifically because this vulnerability class is so persistently dangerous.

## Key facts
- **Root cause**: Use of unsafe C/C++ functions (`strcpy`, `gets`, `sprintf`) that perform no bounds checking on input length.
- **Stack vs. heap**: Stack overflows target return addresses and saved frame pointers; heap overflows corrupt heap metadata or adjacent objects.
- **Stack canary**: A random sentinel value placed before the return address; if overwritten, the program terminates — defeating naive stack smashing.
- **ASLR + DEP together**: Address Space Layout Randomization randomizes memory locations; Data Execution Prevention marks the stack non-executable. Both must be bypassed (e.g., via info leaks + ROP) for a reliable modern exploit.
- **CWE-120 vs. CWE-121/122**: CWE-120 is the parent class; CWE-121 specifically is stack-based overflow, CWE-122 is heap-based overflow.

## Related concepts
[[Stack Smashing]] [[Return-Oriented Programming]] [[ASLR]] [[DEP/NX Bit]] [[CWE-122 Heap Overflow]]