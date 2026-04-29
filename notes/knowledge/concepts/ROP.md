# ROP

## What it is
Like a criminal who never carries their own weapons but instead grabs scissors from the office, a knife from the kitchen, and rope from the garage — Return-Oriented Programming chains together small snippets of legitimate code already in memory ("gadgets") to perform malicious operations without injecting new shellcode. Each gadget ends in a `RET` instruction, which hijacks the call stack to leap to the next gadget, building a full exploit from borrowed pieces.

## Why it matters
ROP was the primary technique used to bypass DEP/NX protections in exploits like those targeting Adobe Reader and Internet Explorer in the early 2010s. Since DEP marks memory regions non-executable, attackers shifted to ROP to execute payloads entirely within already-executable memory regions — rendering DEP ineffective without additional mitigations like ASLR or CFG.

## Key facts
- ROP bypasses **Data Execution Prevention (DEP/NX)** because gadgets reside in already-executable memory (e.g., loaded DLLs)
- Each gadget is typically 1–5 assembly instructions ending in a `RET` (0xC3) instruction
- **ASLR** (Address Space Layout Randomization) counters ROP by randomizing gadget locations, but memory leaks can defeat it
- **Control Flow Guard (CFG)** and **Shadow Stacks** (Intel CET) are modern hardware-level defenses specifically designed to break ROP chains
- A **stack pivot** gadget (e.g., `XCHG ESP, EAX; RET`) is often the first step, redirecting the stack pointer to attacker-controlled memory

## Related concepts
[[Buffer Overflow]] [[DEP/NX]] [[ASLR]] [[Control Flow Integrity]] [[Stack Smashing]]