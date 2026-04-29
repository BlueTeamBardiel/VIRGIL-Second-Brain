# CWE-125 Out-of-Bounds Read

## What it is
Imagine a librarian asked to retrieve book #500 from a shelf that only holds 100 books — they wander into the restricted archive next door and hand you classified documents. An out-of-bounds read occurs when a program reads data from a memory location outside the allocated buffer boundary, accessing adjacent memory it was never authorized to touch.

## Why it matters
The Heartbleed vulnerability (CVE-2014-0160) is the canonical example: a missing bounds check in OpenSSL's heartbeat extension let attackers request up to 64KB of server memory beyond the intended buffer, leaking private keys, session tokens, and plaintext passwords without any authentication. This single flaw exposed an estimated 17% of all HTTPS-secured servers at the time.

## Key facts
- **Classified as a memory safety weakness** under CWE's "Memory Buffer Errors" category; distinct from CWE-787 (Out-of-Bounds Write) because reads cause information disclosure, not direct code execution.
- **Common consequence is data exposure**, not crashes — attackers harvest sensitive adjacent memory contents like cryptographic keys, credentials, or PII.
- **Typical root causes**: missing length validation on user-supplied size parameters, off-by-one errors in loop conditions, or using `strlen()` on non-null-terminated buffers in C/C++.
- **Detection methods** include static analysis tools (Coverity, CodeQL), fuzzing with AddressSanitizer (ASan), and dynamic memory analysis with Valgrind.
- **Language context matters**: memory-safe languages (Rust, Python, Java) enforce bounds checks automatically; C and C++ do not, making them the primary risk environments for this CWE.

## Related concepts
[[Buffer Overflow]] [[CWE-787 Out-of-Bounds Write]] [[Heartbleed CVE-2014-0160]] [[Memory Safety]] [[Fuzzing]]