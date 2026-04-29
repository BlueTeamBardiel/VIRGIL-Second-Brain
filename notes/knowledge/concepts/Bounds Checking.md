# bounds checking

## What it is
Like a bouncer who checks that your guest list number falls between 1 and 500 before letting you in — bounds checking is the process of verifying that an index, pointer, or input value stays within its valid allocated memory range before using it. Without it, a program may read or write memory it was never meant to touch, corrupting data or handing control to an attacker.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) in OpenSSL is a textbook failure of bounds checking: an attacker could request up to 64KB of server memory by sending a malformed heartbeat packet with a falsely inflated length field, and the code never verified whether the claimed length matched the actual data. This leaked private keys, passwords, and session tokens from millions of servers worldwide without leaving a trace in logs.

## Key facts
- **Buffer overflow** attacks are the direct consequence of missing bounds checking — writing past an array's end can overwrite return addresses and redirect execution flow
- Languages like C and C++ perform **no automatic bounds checking**, making them high-risk; languages like Java, Rust, and Python enforce it by default
- **Stack canaries**, **ASLR**, and **DEP/NX bits** are OS/compiler mitigations that compensate for missing bounds checks but do not replace them
- CWE-119 (Improper Restriction of Operations within the Bounds of a Memory Buffer) is one of MITRE's most critical weakness categories and appears frequently on Security+ exam content
- **Fuzzing** is the primary dynamic testing technique used to discover bounds-checking failures by feeding programs unexpected oversized or malformed inputs

## Related concepts
[[buffer overflow]] [[heap spray]] [[memory-safe languages]] [[address space layout randomization]] [[fuzzing]]