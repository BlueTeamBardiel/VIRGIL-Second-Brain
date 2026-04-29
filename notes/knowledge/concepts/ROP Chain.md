# ROP chain

## What it is
Like a criminal who can't bring weapons into a building but instead leads guards through a choreographed sequence of their *own* legitimate movements to open the vault — a ROP chain hijacks existing code snippets already loaded in memory to execute malicious logic without injecting new code. It is an exploitation technique where an attacker overwrites the stack with addresses of small, pre-existing instruction sequences (called "gadgets") ending in a `RET` instruction, chaining them together to perform arbitrary computation.

## Why it matters
ROP was developed precisely to defeat DEP (Data Execution Prevention) / NX (No-Execute) protections, which mark memory regions as non-executable. In real attacks, exploits against browsers, PDF readers, and OS kernels — such as the JIT-spraying attacks against Adobe Flash — used ROP chains to bypass DEP and then pivot to running shellcode or disabling ASLR before loading a full payload.

## Key facts
- **Gadgets** are short instruction sequences (2–5 instructions) ending in `RET`, harvested from loaded libraries like `libc` or `ntdll.dll`
- ROP bypasses **DEP/NX** because gadgets live in already-executable memory — no new code is written
- Effective against DEP but weakened by **ASLR**, which randomizes gadget addresses; attackers combine ROP with an **info-leak** vulnerability to defeat ASLR
- **Stack pivoting** is often the first gadget in a chain — it redirects the stack pointer (`RSP`) to attacker-controlled memory
- Mitigations include **Control Flow Integrity (CFI)**, **Shadow Stack** (Intel CET), and **AROP/ROPGuard** mechanisms that validate return addresses at runtime

## Related concepts
[[Buffer Overflow]] [[DEP/NX]] [[ASLR]] [[Stack Canary]] [[Control Flow Integrity]]