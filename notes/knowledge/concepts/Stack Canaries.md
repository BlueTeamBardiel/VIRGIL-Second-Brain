# stack canaries

## What it is
Like the coal miners who brought canaries into tunnels to detect deadly gas before humans were harmed, a stack canary is a sentinel value placed between local variables and the return address on the stack — if a buffer overflow overwrites it, the program knows it's been poisoned and terminates before the attacker can redirect execution. Precisely: it's a randomly generated value inserted by the compiler at function entry, checked at function return, and any modification signals a stack smashing attempt.

## Why it matters
In the classic stack buffer overflow attack — exploited brutally in the Morris Worm of 1988 and still relevant today — an attacker overwrites the return address to redirect code execution to shellcode. Stack canaries directly interrupt this chain: even if an attacker overflows a local buffer, overwriting the canary triggers an abort before the corrupted return address is ever used, making simple linear stack smashing attacks ineffective without a canary-bypass technique like format string leaks.

## Key facts
- Introduced in GCC as **Stack Smashing Protector (SSP)**, enabled with the `-fstack-protector` flag
- Three common types: **terminator canaries** (null bytes, CR, LF), **random canaries** (generated at runtime from `/dev/urandom`), and **random XOR canaries** (XORed with the return address for added protection)
- Canary values are stored in **TLS (Thread Local Storage)** to make them harder to predict or read
- **Bypass techniques** include format string vulnerabilities (to leak the canary value), brute-forcing (in forking servers where the canary doesn't change across forks), and heap-based overflows (which bypass the stack entirely)
- Stack canaries are a **compile-time mitigation**, meaning they must be compiled in — they don't protect legacy binaries

## Related concepts
[[buffer overflow]] [[ASLR]] [[DEP/NX bit]] [[return-oriented programming]] [[format string vulnerability]]