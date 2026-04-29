# integer overflow to buffer overflow

## What it is
Imagine a cashier who calculates your change using a broken register that wraps around from $999 to $0 — you hand over a huge number and suddenly owe nothing, or worse, get a refund that breaks the store. An integer overflow occurs when arithmetic produces a value too large for its data type, wrapping around to a small or negative number; when that corrupted value is then used to allocate or bound a memory buffer, the result is a buffer smaller than expected, enabling a classic buffer overflow exploit. The two vulnerabilities chain together: the overflow poisons the math, the buffer overflow weaponizes it.

## Why it matters
The 2002 OpenSSH integer overflow (CAN-2002-0639) let attackers send a specially crafted packet where a size calculation wrapped to a tiny number, allocating an undersized buffer and allowing heap corruption leading to remote code execution as root. Defenders patch this class of bug by validating that size parameters cannot wrap — using unsigned arithmetic checks or compiler flags like `-fwrapv` and safe integer libraries.

## Key facts
- Integer overflow becomes dangerous when the overflowed value controls `malloc()` size or array index calculations.
- Signed integers wrap to large negatives; unsigned integers wrap to zero or small positives — both can produce undersized buffers.
- Common in C/C++ where there is **no native overflow detection** by default; languages like Python are immune due to arbitrary-precision integers.
- Mitigation includes **integer sanitization** (bounds-checking before allocation), compiler sanitizers (`-fsanitize=integer`), and safe math libraries (e.g., `SafeInt`).
- On the Security+/CySA+ exam, this is classified under **improper input validation** and related to memory management vulnerabilities.

## Related concepts
[[buffer overflow]] [[heap overflow]] [[integer underflow]] [[improper input validation]] [[memory-safe languages]]