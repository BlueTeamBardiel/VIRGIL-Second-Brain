# Value Representation

## What it is
Like how the number "10" means ten in decimal but sixteen in hex, computers encode the same underlying value differently depending on context — and the *interpretation* of those bytes is everything. Value representation refers to how data (integers, characters, addresses, flags) is encoded in binary and how a system chooses to read that encoding (signed vs. unsigned, big-endian vs. little-endian, ASCII vs. Unicode).

## Why it matters
Integer representation mismatches cause real exploits: the classic signed/unsigned confusion vulnerability occurs when a function checks `if (user_length < MAX)` treating the value as signed, but then passes it to `memcpy()` which reads it as unsigned. A user-supplied value of `-1` passes the signed check but becomes `0xFFFFFFFF` (4 billion+) in the copy operation, triggering a massive heap overflow — exactly the class of bug behind several OpenSSH and Linux kernel CVEs.

## Key facts
- **Endianness**: x86/x64 systems are little-endian (least significant byte first); network protocols use big-endian (network byte order) — mismatches cause parsing errors exploitable in protocol fuzzing
- **Signed vs. unsigned integers**: A signed 8-bit value ranges from -128 to 127; unsigned ranges from 0 to 255 — the same bit pattern `0xFF` means -1 or 255 depending on interpretation
- **Two's complement**: The dominant method for representing negative integers; flip all bits and add 1
- **Integer overflow**: Adding 1 to a signed 32-bit max (2,147,483,647) wraps to -2,147,483,648, potentially bypassing length/bounds checks
- **Type confusion**: When a value encoded as one type is interpreted as another (e.g., a float read as an integer), memory corruption or logic flaws follow — a common JavaScript engine exploit primitive

## Related concepts
[[Integer Overflow]] [[Buffer Overflow]] [[Type Confusion]] [[Memory Corruption]] [[Endianness]]