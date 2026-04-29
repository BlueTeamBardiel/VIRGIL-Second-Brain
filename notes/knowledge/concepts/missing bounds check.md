# missing bounds check

## What it is
Imagine a parking garage attendant who hands out tickets without ever checking if the lot is full — cars just keep pulling in until they're stacking on top of each other. A missing bounds check is when code fails to verify that input data fits within the allocated memory buffer before writing it, allowing data to spill into adjacent memory regions.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) in OpenSSL exploited a missing bounds check in the heartbeat extension — an attacker could request up to 64KB of memory regardless of the actual payload size, leaking private keys, passwords, and session tokens from server RAM. Defenders patch this by adding explicit length validation before any memory read or write operation.

## Key facts
- Missing bounds checks are the root cause of **buffer overflow attacks**, one of the oldest and most exploited vulnerability classes in software history
- Exploitable in both **stack** (local variables, return addresses) and **heap** (dynamically allocated memory) memory regions
- Languages like C and C++ have **no automatic bounds checking**, making them prime targets; languages like Python and Java perform bounds checking natively at runtime
- Attackers leverage missing bounds checks to achieve **arbitrary code execution** by overwriting the return address with a pointer to shellcode or a ROP chain
- Common defenses include **Address Space Layout Randomization (ASLR)**, **stack canaries**, **Data Execution Prevention (DEP/NX)**, and safe library functions (`strncpy` instead of `strcpy`)

## Related concepts
[[buffer overflow]] [[heap overflow]] [[memory corruption]] [[stack canary]] [[input validation]]