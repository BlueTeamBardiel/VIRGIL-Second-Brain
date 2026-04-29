# memcpy

## What it is
Like a moving crew that loads boxes from one room to another without checking if the destination room is big enough — `memcpy` is a C standard library function that copies a specified number of bytes from a source memory address to a destination memory address, with zero bounds checking. If the destination buffer is smaller than the number of bytes being copied, it blindly overwrites whatever memory lies beyond it.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) in OpenSSL used a variant of this problem — a crafted heartbeat request could cause the server to `memcpy` up to 64KB of process memory back to an attacker, leaking private keys, session tokens, and passwords without any authentication. Attackers don't need to crash a program to exploit memory functions; sometimes reading is enough.

## Key facts
- `memcpy` performs **no bounds checking** — the programmer is entirely responsible for ensuring the destination buffer is large enough
- Unsafe use enables **buffer overflow attacks**, where excess data overwrites adjacent memory regions including return addresses and function pointers
- The safer replacement is `memcpy_s` (C11) or platform equivalents like `memmove` when regions may overlap
- Microsoft's SDL (Security Development Lifecycle) explicitly **bans** raw `memcpy` in favor of annotated, bounds-checked alternatives
- Modern compilers with **AddressSanitizer (ASan)** or stack canaries can detect `memcpy` overflows at runtime during testing, but not always in production

## Related concepts
[[Buffer Overflow]] [[Stack Smashing]] [[Heartbleed]] [[Safe C Functions]] [[Address Space Layout Randomization]]