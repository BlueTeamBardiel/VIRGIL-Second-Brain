# stack canary

## What it is
Like the coal miners' canary that died before toxic gas reached the workers, a stack canary is a sentinel value placed between local variables and the return address on the stack — if it's been altered when the function returns, the program knows something walked through it and terminates before the attacker can redirect execution. Specifically, it's a compiler-inserted random value written to the stack frame at function entry and verified at function exit.

## Why it matters
In a classic buffer overflow attack, an adversary overwrites a local buffer to corrupt the saved return address and hijack control flow. Stack canaries intercept this: because the buffer sits *before* the canary, any sequential overflow that reaches the return address must first overwrite the canary, triggering detection and a controlled crash — turning a remote code execution into a denial of service at worst.

## Key facts
- GCC implements stack canaries via the `-fstack-protector` flag; they are a **compile-time mitigation**, not an OS feature
- Three canary types exist: **terminator** (null bytes, CR, LF — stops string functions), **random** (generated at runtime), and **random XOR** (XORed with control data)
- Canaries do **not** protect against arbitrary write primitives or format string attacks that overwrite the return address directly without passing through the canary sequentially
- If an attacker can **leak the canary value** (e.g., via a format string vulnerability), they can overwrite it with its own value and bypass protection entirely
- Stack canaries are one layer in the defense-in-depth stack alongside **ASLR** and **DEP/NX**, none of which are sufficient alone

## Related concepts
[[buffer overflow]] [[ASLR]] [[DEP/NX bit]] [[format string vulnerability]] [[return-oriented programming]]