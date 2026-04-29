# ROP chains

## What it is
Like a heist crew that never carries their own tools — they steal a crowbar from a hardware store, bolt cutters from a janitor's closet, and a getaway car from the parking lot — a ROP chain stitches together pre-existing code fragments already inside a program's memory. Return-Oriented Programming (ROP) is an exploitation technique where an attacker hijacks a program's control flow by chaining together small existing code sequences (called **gadgets**) ending in a `RET` instruction, executing arbitrary logic without injecting new shellcode.

## Why it matters
ROP was developed specifically to bypass **Data Execution Prevention (DEP/NX)**, which marks memory regions as non-executable. In the 2015 exploitation of Adobe Flash (CVE-2015-0311), attackers used ROP chains to bypass DEP, pivot execution into a shellcode payload, and achieve remote code execution — demonstrating that DEP alone is insufficient without complementary mitigations like ASLR.

## Key facts
- **Gadgets** are short instruction sequences (typically 1–5 instructions) ending in `RET`; attackers scan binaries and loaded libraries to find them
- ROP defeats **NX/DEP** because the executed code already lives in legitimate, executable memory regions — no new code is injected
- **ASLR (Address Space Layout Randomization)** is the primary mitigation that makes ROP harder by randomizing gadget locations at each execution
- **Stack canaries** do not stop ROP — they detect stack smashing but once a canary is leaked, the attacker can still overwrite the return address precisely
- **Control Flow Integrity (CFI)** is the strongest modern defense: it enforces that indirect branches and returns only target valid, intended destinations, breaking the ROP gadget chain logic

## Related concepts
[[Buffer Overflow]] [[DEP/NX]] [[ASLR]] [[Control Flow Integrity]] [[Stack Canaries]]