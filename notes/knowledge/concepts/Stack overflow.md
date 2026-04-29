# Stack overflow

## What it is
Imagine a stack of cafeteria trays where someone keeps adding trays past the shelf's limit — eventually they crash into the ceiling and knock things loose. A stack overflow occurs when a program writes more data to the call stack than it was allocated, overwriting adjacent memory regions including the saved return address, allowing an attacker to redirect execution flow to arbitrary code.

## Why it matters
The classic Morris Worm (1988) exploited a stack overflow in the Unix `fingerd` daemon by sending an oversized string that overwrote the return pointer, redirecting execution to shellcode — one of the first automated exploits in history. Modern defenses like stack canaries, ASLR, and non-executable stacks (NX bit/DEP) exist specifically to detect or neutralize this class of attack.

## Key facts
- **Return address overwrite**: The attacker's goal is to overwrite the saved EIP/RIP on the stack to redirect execution to attacker-controlled shellcode or a ROP chain.
- **Stack canary**: A compiler-inserted random value placed between local variables and the return address; if it's corrupted before function return, the program terminates — this is a primary mitigation on Security+ exams.
- **NX bit / DEP**: Marks the stack memory as non-executable, preventing shellcode injected onto the stack from running; bypassed by Return-Oriented Programming (ROP).
- **ASLR**: Randomizes memory layout at load time, making it harder to predict where injected code or useful gadgets reside in memory.
- **Distinct from heap overflow**: Stack overflows target the call stack (local variables, return addresses); heap overflows target dynamically allocated memory — different exploitation techniques, different mitigations.

## Related concepts
[[Buffer overflow]] [[Return-Oriented Programming]] [[Address Space Layout Randomization]] [[Data Execution Prevention]] [[Stack canary]]