# Return Address

## What it is
Like a postal return envelope tucked inside a function call — when a subroutine finishes its job, it needs to know exactly which line of code to go back to. A return address is a value stored on the call stack that tells the CPU where to resume execution after a function completes. It is placed automatically by the `CALL` instruction and retrieved by the `RET` instruction during normal program flow.

## Why it matters
Buffer overflow attacks exploit the return address directly: an attacker floods a vulnerable buffer with more data than it can hold, overwriting the saved return address with one pointing to malicious shellcode. This is the foundational mechanism behind classic stack smashing attacks like the 1988 Morris Worm and countless CVEs since. Defenses like stack canaries, ASLR, and non-executable stacks (NX/DEP) exist specifically to detect or prevent unauthorized overwriting of the return address.

## Key facts
- The return address sits **above local variables** on the stack frame; overflowing a local buffer can reach and overwrite it
- **Stack canaries** place a random sentinel value between the buffer and return address — if the canary changes, the program aborts before `RET` executes
- **ASLR** (Address Space Layout Randomization) randomizes where code loads in memory, making it hard for attackers to know *what* address to write
- **Return-Oriented Programming (ROP)** bypasses NX/DEP by chaining existing code snippets ("gadgets"), each ending in a `RET` instruction — hijacking control flow without injecting new shellcode
- SafeSEH and Control Flow Guard (CFG) are Windows-specific mitigations that validate return/jump targets before execution

## Related concepts
[[Buffer Overflow]] [[Stack Canary]] [[Address Space Layout Randomization]] [[Return-Oriented Programming]] [[DEP/NX Bit]]