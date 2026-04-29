# Data Execution Prevention

## What it is
Think of DEP like a library where certain shelves are *read-only* — you can read the books, but you absolutely cannot write new text in them, and you certainly cannot perform a magic show from them. DEP is a hardware and software security feature that marks memory regions as either executable (code can run there) or non-executable (data lives there, nothing runs), preventing attackers from injecting and executing malicious code in data segments like the stack or heap. It is implemented at the CPU level via the NX (No-Execute) bit on AMD or XD (Execute Disable) bit on Intel processors.

## Why it matters
Classic buffer overflow attacks work by stuffing shellcode into the stack and then redirecting execution to that injected payload. DEP stops this cold — even if an attacker successfully overwrites the return address to point at their shellcode, the CPU raises an access violation when execution hits the non-executable stack region, killing the exploit before any damage is done. This is why attackers pivoted to Return-Oriented Programming (ROP), which reuses *already-executable* code rather than injecting new code.

## Key facts
- DEP has two modes: **hardware-enforced DEP** (uses NX/XD CPU bit) and **software-enforced DEP** (uses SafeSEH; protects fewer memory regions)
- Windows implements DEP with four policy levels: OptIn, OptOut, AlwaysOn, AlwaysOff — configurable via `bcdedit /set nx`
- DEP alone does **not** stop ROP attacks because ROP chains execute within already-legitimate, executable code pages
- DEP is most effective when combined with **ASLR**, making it far harder to predict where legitimate code gadgets reside
- On Linux, the equivalent mechanism is enforced via the **NX bit** and kernel's `mprotect()` system call restrictions

## Related concepts
[[Buffer Overflow]] [[Address Space Layout Randomization]] [[Return-Oriented Programming]]