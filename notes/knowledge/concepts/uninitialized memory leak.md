# uninitialized memory leak

## What it is
Like renting a hotel room where the previous guest's diary is still in the drawer — the room is "yours," but old contents remain until explicitly cleared. An uninitialized memory leak occurs when a program allocates memory and reads or exposes it to an attacker before writing fresh data to it, allowing leftover bytes from prior processes or heap allocations to be disclosed. The "leak" is informational: secrets escape without the program ever intending to share them.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) in OpenSSL is the canonical example — a malformed heartbeat request tricked the server into returning up to 64 KB of uninitialized heap memory, exposing private keys, session tokens, and plaintext passwords. Defenders patch this class of bug by enforcing zero-initialization of buffers (e.g., using `calloc` instead of `malloc`, or compiler flags like `-ftrivial-auto-var-init`) before any data is read or transmitted.

## Key facts
- **Not a crash, a disclosure:** Unlike buffer overflows, uninitialized memory leaks typically don't cause crashes — they silently expose sensitive residual data.
- **Heap and stack both vulnerable:** Stack variables left uninitialized before use can leak prior function call data; heap allocations via `malloc` carry whatever bytes occupied that memory previously.
- **Heartbleed scored CVSS 7.5** (High) and affected an estimated 17% of trusted HTTPS servers at disclosure in April 2014.
- **Mitigation tools:** AddressSanitizer (ASan) and Valgrind's Memcheck can detect reads from uninitialized memory during testing.
- **CWE-457** (Use of Uninitialized Variable) formally categorizes this weakness in MITRE's enumeration, relevant for exam taxonomy.

## Related concepts
[[buffer over-read]] [[heap memory exploitation]] [[information disclosure vulnerability]]