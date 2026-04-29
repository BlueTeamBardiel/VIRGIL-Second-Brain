# Off-by-One Errors

## What it is
Imagine a fence with 10 posts but only 9 gaps between them — if you count gaps instead of posts, you'll always be one short. An off-by-one error occurs when a loop boundary or buffer index is miscalculated by exactly one unit, causing code to read or write one element beyond (or before) an intended boundary. These are a subcategory of buffer overflow vulnerabilities rooted in incorrect loop conditions or index arithmetic.

## Why it matters
The 2002 OpenSSH off-by-one heap overflow (CVE-2002-0639) allowed remote attackers to execute arbitrary code by exploiting a single misplaced `<=` instead of `<` in boundary checking code. This demonstrates how a one-character typo in source code translates directly into remote code execution — the most severe possible outcome.

## Key facts
- Off-by-one errors commonly arise from using `<=` instead of `<` (or vice versa) in loop termination conditions, or from forgetting that C arrays are zero-indexed (index 0 through n-1, not 1 through n).
- They can manifest as **heap overflows** or **stack overflows** depending on where the buffer is allocated, both of which are exploitable for privilege escalation or code execution.
- Null-terminator overwrites are a classic off-by-one consequence: writing one byte past a buffer can corrupt the adjacent memory's length field or return address.
- Secure coding standards (CERT C, CWE-193) specifically catalog off-by-one as a distinct weakness class because automated scanners frequently miss them — they look syntactically correct.
- Mitigations include bounds-checked languages (Rust, Java), compiler flags like AddressSanitizer (`-fsanitize=address`), and manual fuzz testing targeting boundary values (0, 1, n-1, n, n+1).

## Related concepts
[[Buffer Overflow]] [[Heap Overflow]] [[Integer Overflow]] [[Memory-Safe Languages]] [[Fuzzing]]