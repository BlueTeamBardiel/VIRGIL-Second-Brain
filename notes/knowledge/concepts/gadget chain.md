# gadget chain

## What it is
Like a Rube Goldberg machine built from existing kitchen appliances you didn't install yourself, a gadget chain repurposes small fragments of legitimate code — called "gadgets" — already present in memory to perform malicious operations. Precisely: a gadget chain is a sequence of existing code snippets (typically ending in a `RET` instruction) that an attacker strings together via a corrupted stack to execute arbitrary logic without injecting new code. This technique is the backbone of Return-Oriented Programming (ROP) attacks.

## Why it matters
When DEP/NX (Data Execution Prevention) blocks injected shellcode from running, attackers pivot to gadget chains to bypass the protection entirely — because the gadgets are *already executable* legitimate code. The 2015 exploitation of glibc's `__gconv_transform_ascii` function in real-world Linux privilege escalation attacks demonstrated chained ROP gadgets being used to disable ASLR and escalate privileges without ever injecting a single new byte of code.

## Key facts
- Each "gadget" is typically a 1–5 instruction sequence ending in `RET`, `JMP [reg]`, or `CALL [reg]`
- Gadget chains defeat **DEP/NX** because execution stays within legitimate, already-mapped memory pages
- **ASLR** partially mitigates gadget chains by randomizing gadget addresses, but information leaks can defeat ASLR first
- Tools like **ROPgadget**, **pwntools**, and **radare2** automate gadget discovery within binaries
- **Control Flow Integrity (CFI)** is the primary modern defense, enforcing that indirect branches only reach valid targets

## Related concepts
[[Return-Oriented Programming]] [[buffer overflow]] [[DEP/NX]] [[ASLR]] [[Control Flow Integrity]]