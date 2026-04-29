# Return-Oriented Programming

## What it is
Like a criminal who never touches a weapon but instead puppeteers a hostage's own hands to commit the crime, ROP reuses legitimate code already loaded in memory to execute malicious behavior. It is an exploit technique where an attacker chains together small existing code snippets (called "gadgets") — each ending in a `RET` instruction — to perform arbitrary computation without injecting any new code. This allows attackers to bypass defenses like Data Execution Prevention (DEP/NX) that block execution of attacker-supplied shellcode.

## Why it matters
In 2019, researchers demonstrated ROP chains against iOS kernel exploits, using Apple's own loaded libraries as gadget sources to achieve privilege escalation — completely bypassing NX protections. Defenders counter this with Address Space Layout Randomization (ASLR), which randomizes memory locations, making gadget addresses unpredictable. However, a memory leak vulnerability that reveals base addresses can defeat ASLR and re-enable ROP attacks.

## Key facts
- **Gadgets** are short instruction sequences ending in `RET` (e.g., `pop rax; ret`) found within existing executables or libraries
- ROP **bypasses DEP/NX** because execution happens within legitimate, already-executable memory pages — no new code is written
- **ASLR** is the primary mitigation; combining ASLR with a **stack canary** and **PIE (Position Independent Executable)** significantly raises the attack cost
- A **ROP chain** is a sequence of gadget addresses placed on the stack; the `RET` instruction pops each address and jumps to the next gadget
- Control-Flow Integrity (**CFI**) is a modern hardware/compiler-level mitigation that validates return targets, directly countering ROP

## Related concepts
[[Buffer Overflow]] [[Address Space Layout Randomization]] [[Data Execution Prevention]] [[Stack Canary]] [[Control-Flow Integrity]]