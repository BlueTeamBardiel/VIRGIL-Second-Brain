# CWE-252 Unchecked Return Value

## What it is
Imagine a surgeon asking a nurse for a scalpel, and the nurse drops it — but the surgeon operates anyway, assuming the tool arrived. CWE-252 occurs when code calls a function and ignores whether it succeeded or failed, blindly proceeding as if the operation completed correctly.

## Why it matters
The 2014 Apple "goto fail" SSL bug (CVE-2014-1266) is a famous cousin of this pattern — critical security checks were bypassed because return values from signature verification were not properly evaluated. An attacker performing a man-in-the-middle attack could present a forged certificate that the client silently accepted, compromising TLS integrity entirely.

## Key facts
- Functions like `malloc()`, `fopen()`, `read()`, and `write()` in C return NULL or -1 on failure; ignoring these is a classic CWE-252 instance
- This weakness is categorized under MITRE's **CWE-754** (Improper Check for Unusual or Exceptional Conditions) as a child node
- Exploitation can lead to null pointer dereference, use of uninitialized memory, or privilege escalation depending on what operation was skipped
- Static analysis tools (e.g., Coverity, Splint) specifically flag unchecked return values as a high-priority finding
- CERT C Secure Coding Standard rule **ERR33-C** mandates detecting and handling standard library errors explicitly
- Common in memory allocation failures — if `malloc()` returns NULL and code proceeds, writing to address 0x0 causes undefined behavior or crash-as-DoS

## Related concepts
[[Null Pointer Dereference]] [[Error Handling]] [[CWE-754 Improper Check for Exceptional Conditions]] [[Memory Safety]] [[Static Analysis]]