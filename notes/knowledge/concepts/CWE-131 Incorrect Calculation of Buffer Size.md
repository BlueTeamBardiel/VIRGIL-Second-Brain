# CWE-131 Incorrect Calculation of Buffer Size

## What it is
Imagine a baker calculating how many eggs to buy by counting the cartons but forgetting each carton holds 12 eggs — they order the right number of containers but wrong total quantity. CWE-131 is exactly that mistake applied to memory: a program calculates how many bytes to allocate for a buffer using flawed arithmetic — wrong multipliers, missing null terminators, or ignored data type sizes — resulting in a buffer too small for its actual contents. The allocation succeeds, but subsequent writes overflow into adjacent memory.

## Why it matters
The classic exploitation vector is heap overflow: an attacker provides input precisely sized to exceed the under-allocated buffer, overwriting heap metadata or adjacent objects to redirect execution. OpenSSL's Heartbleed (CVE-2014-0160) involved a related size miscalculation where the requested payload length was trusted without verifying it matched actual buffer bounds, leaking up to 64KB of server memory per request — exposing private keys and session tokens at scale.

## Key facts
- **sizeof() pitfall**: Using `sizeof(pointer)` instead of `sizeof(*pointer)` returns the pointer width (4 or 8 bytes) not the pointed-to data size — a common C/C++ source of this bug
- **Null terminator omission**: Allocating `strlen(s)` instead of `strlen(s) + 1` leaves no room for the null terminator, causing off-by-one overflows
- **Integer overflow cascade**: If size calculation overflows an integer type (e.g., `size_t`), the resulting small value causes catastrophically under-sized allocation
- **Multiplication errors**: Allocating for an array as `n * sizeof(type)` without overflow checking is a textbook CWE-131 pattern
- **Detection**: Static analysis tools (Coverity, CodeQL) and compiler flags like `-fsanitize=address` (AddressSanitizer) reliably catch this class of bug

## Related concepts
[[Buffer Overflow]] [[CWE-190 Integer Overflow]] [[Heap Exploitation]] [[Off-by-One Error]] [[Memory Safety]]