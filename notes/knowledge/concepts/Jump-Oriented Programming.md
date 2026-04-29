# Jump-Oriented Programming

## What it is
Like a criminal who controls a puppet by yanking strings attached to its joints rather than its head, JOP hijacks a program's control flow using `JMP` instructions instead of `RET` instructions. It is an exploit technique that chains together small, pre-existing code snippets ("gadgets") ending in indirect jump instructions to execute arbitrary logic without injecting new code. JOP was developed specifically to bypass Return-Oriented Programming (ROP) defenses that monitor or corrupt the stack's return addresses.

## Why it matters
When Microsoft's Enhanced Mitigation Experience Toolkit (EMET) and later Control Flow Guard (CFG) began detecting ROP chains by monitoring `RET` instruction frequency and stack integrity, attackers pivoted to JOP to evade these mitigations. A real-world example is its use in advanced browser exploits where heap sprays set up a dispatcher gadget that cycles through a JOP chain, achieving shellcode-equivalent behavior without ever touching a return address.

## Key facts
- JOP relies on a **dispatcher gadget** — a central loop that reads a "JOP chain table" and jumps to each successive gadget, replacing the function of the stack in ROP
- Gadgets end in `JMP reg` or `JMP [reg]` rather than `RET`, making stack-based defenses like Shadow Stack ineffective alone
- JOP is harder to construct than ROP because gadget availability ending in `JMP` is lower than `RET`-ending gadgets
- It defeats **Return Flow Guard** and similar stack-monitoring mitigations because no `RET` instructions are used in the payload
- Control Flow Integrity (CFI) is the primary modern defense, enforcing that indirect jumps only target valid, compiler-designated locations

## Related concepts
[[Return-Oriented Programming]] [[Control Flow Integrity]] [[Code Reuse Attacks]] [[Address Space Layout Randomization]] [[Heap Spraying]]