# out-of-bounds read

## What it is
Like a librarian who, when asked for book #50, accidentally reads the private notes stuffed behind books #51 and #52 — an out-of-bounds read occurs when a program accesses memory *outside* the allocated buffer it was given. The CPU doesn't stop you; it just hands over whatever bytes happen to live at that address, which may include passwords, keys, or other sensitive data.

## Why it matters
The Heartbleed vulnerability (CVE-2014-0160) is the canonical example: a malformed TLS heartbeat request tricked OpenSSL into reading up to 64KB of server memory beyond the intended buffer, leaking private keys, session tokens, and plaintext passwords — no authentication required. Defenders patched by adding proper bounds checks before the memory read and revoking exposed certificates en masse.

## Key facts
- **CWE-125** is the formal identifier; it is distinct from out-of-bounds *write* (CWE-787), which causes corruption rather than disclosure.
- Out-of-bounds reads typically violate **confidentiality**, not integrity or availability — making them prime candidates for information-disclosure attacks.
- They can be exploited to **leak ASLR offsets**, turning a read vulnerability into a stepping stone for a more dangerous write exploit.
- Languages with automatic bounds checking (Rust, Java, Python) raise exceptions before the illegal read; C and C++ do not enforce this by default.
- Detected via **fuzzing**, **AddressSanitizer (ASan)**, and **static analysis tools** (e.g., Coverity, Clang analyzer) — all valid mitigation strategies on the CySA+ exam.

## Related concepts
[[buffer overflow]] [[memory corruption]] [[Heartbleed]] [[ASLR]] [[fuzzing]]