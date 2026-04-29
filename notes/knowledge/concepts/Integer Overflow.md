# integer overflow

## What it is
Imagine an old-fashioned odometer that rolls from 99999 back to 00000 — it can't represent 100000, so it wraps around to a nonsensical value. An integer overflow occurs when an arithmetic operation produces a value outside the range a fixed-size variable can hold, causing the processor to silently wrap the result (e.g., a 32-bit unsigned integer rolls from 4,294,967,295 back to 0). Attackers exploit this predictable wrapping behavior to manipulate memory allocations, bypass length checks, or corrupt adjacent data.

## Why it matters
The 2002 OpenSSH "off-by-one" and the classic Windows ANI heap overflow both trace roots to arithmetic boundary failures. A modern scenario: an attacker sends a crafted packet where `length = 0xFFFFFFFF + 1`, which wraps to 0, causing `malloc(0)` to allocate a tiny buffer; subsequent data writes then overflow that buffer, enabling arbitrary code execution. Defending against this requires compiler flags like `-ftrapv` (trap on signed overflow) and using safe integer libraries.

## Key facts
- **Signed vs. unsigned behavior differs**: signed overflow is *undefined behavior* in C/C++; unsigned overflow is defined to wrap modulo 2ⁿ.
- **Common exploit pattern**: overflow shrinks an allocation size, then a heap or stack buffer overflow follows as a second stage.
- **CWE-190** is the official classification for integer overflow; it frequently leads to CWE-122 (heap-based buffer overflow).
- **Mitigation tools**: compiler sanitizers (AddressSanitizer, UBSan), safe integer libraries (SafeInt), and static analysis tools like Coverity detect these at build time.
- Integer overflows were the root cause of vulnerabilities in libpng, libtiff, and the original Xbox security bypass (2003).

## Related concepts
[[buffer overflow]] [[heap corruption]] [[memory-safe languages]] [[input validation]] [[fuzzing]]