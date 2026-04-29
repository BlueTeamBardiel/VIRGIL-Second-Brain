# stack buffer overflow

## What it is
Imagine pouring a 2-liter bottle of water into a 500ml cup — the overflow spills onto whatever is next to it on the counter. A stack buffer overflow happens when a program writes more data into a fixed-size stack buffer than it was allocated, overwriting adjacent memory including the saved return address. An attacker who controls that overwritten return address can redirect execution to malicious shellcode.

## Why it matters
The 1988 Morris Worm exploited a stack buffer overflow in the Unix `fingerd` daemon, making it the first major internet worm and infecting thousands of machines. Modern exploits still target stack overflows in embedded systems and legacy C codebases where protections are absent — such as router firmware — allowing remote code execution with no authentication required.

## Key facts
- The **return address** sits on the stack just above local variables; overwriting it is the core exploitation primitive
- **NOP sleds** (`\x90\x90\x90...`) are prepended to shellcode to increase landing precision when exact addresses are uncertain
- **Stack canaries** (GCC's `-fstack-protector`) place a random sentinel value before the return address; if it changes, the program terminates before returning
- **ASLR (Address Space Layout Randomization)** randomizes stack base addresses, making return address prediction unreliable — but not impossible via brute force or info leaks
- **DEP/NX (Data Execution Prevention / No-Execute bit)** marks the stack non-executable, forcing attackers to pivot to **Return-Oriented Programming (ROP)** instead of injecting shellcode

## Related concepts
[[return-oriented programming]] [[ASLR]] [[stack canary]] [[shellcode]] [[memory corruption vulnerabilities]]