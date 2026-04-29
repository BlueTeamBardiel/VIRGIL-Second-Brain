# out-of-bounds memory access

## What it is
Imagine a hotel with 10 rooms numbered 1–10 — if a guest walks into room 14, they're in unmarked territory where anything could happen. Out-of-bounds memory access occurs when a program reads or writes to memory addresses outside the allocated buffer it was given, potentially touching data belonging to other processes, the OS, or executable code. It is the root mechanism behind both buffer overflows (write OOB) and information disclosure bugs (read OOB).

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) was a read out-of-bounds bug in OpenSSL — an attacker sent a malformed heartbeat request claiming a large payload size, tricking the server into reading up to 64KB beyond the actual buffer and leaking private keys, session tokens, and passwords in plaintext. Patching required updating OpenSSL across millions of servers globally and revoking/reissuing TLS certificates at massive scale.

## Key facts
- **Write OOB** enables code execution by overwriting return addresses, function pointers, or vtables; **read OOB** enables information disclosure (memory leaks, ASLR bypass).
- Modern compilers deploy **AddressSanitizer (ASan)** to detect OOB at runtime during development — it adds "shadow memory" that tracks allocation bounds.
- OS mitigations like **ASLR**, **stack canaries**, and **DEP/NX** raise the cost of exploiting OOB writes but do not prevent the underlying access.
- Languages like C and C++ perform **no automatic bounds checking** on arrays or pointers; Rust prevents OOB at compile time through its ownership/borrow system.
- OOB vulnerabilities are catalogued under **CWE-125** (read) and **CWE-787** (write) — both appear consistently on MITRE's top 25 most dangerous software weaknesses.

## Related concepts
[[buffer overflow]] [[heap spraying]] [[memory-safe languages]] [[ASLR]] [[stack canary]]