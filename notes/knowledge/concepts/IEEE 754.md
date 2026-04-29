# IEEE 754

## What it is
Like trying to measure the distance to the moon using only a 12-inch ruler marked in whole inches — you can get close, but you must round. IEEE 754 is the international standard defining how computers represent floating-point numbers (decimals) in binary, specifying exact bit layouts for single-precision (32-bit) and double-precision (64-bit) formats, including special values like infinity and NaN (Not a Number).

## Why it matters
Floating-point precision errors have caused real security vulnerabilities — most famously, the Ariane 5 rocket explosion (1996) stemmed from a float-to-integer conversion overflow. In security contexts, attackers exploit floating-point comparison logic: code checking `if (balance == 0.1 + 0.2)` will never be true because `0.1 + 0.2` equals `0.30000000000000004` in IEEE 754, potentially bypassing balance checks or authentication thresholds in financial and cryptographic applications.

## Key facts
- **Single precision**: 1 sign bit, 8 exponent bits, 23 mantissa bits (32 bits total); **double precision**: 1 sign, 11 exponent, 52 mantissa (64 bits total)
- **NaN (Not a Number)** comparisons always return false — even `NaN == NaN` is false — creating logic bypass opportunities when NaN is injected as input
- Floating-point arithmetic is **non-associative**: `(a + b) + c ≠ a + (b + c)` in many cases, making cryptographic implementations that rely on exact equality dangerous
- **Integer overflow to float** conversions can silently lose precision — a 64-bit integer beyond 2^53 cannot be exactly represented in a double, enabling value-manipulation attacks
- Many language runtimes (PHP, JavaScript) use IEEE 754 doubles as their default number type, making type-juggling attacks possible when loose comparisons are combined with float inputs

## Related concepts
[[Integer Overflow]] [[Type Confusion]] [[Input Validation]]