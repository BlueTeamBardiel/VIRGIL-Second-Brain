# integer underflow

## What it is
Like an odometer on a car that reads 00000 and then rolls *backward* to 99999, an integer underflow occurs when a calculation decrements a variable below the minimum value its data type can hold, causing it to wrap around to a very large number. For an unsigned 8-bit integer, subtracting 1 from 0 yields 255 instead of -1. This silent, unexpected wraparound corrupts program logic in ways the developer never intended.

## Why it matters
The 2002 OpenSSH "challenge-response" vulnerability (CAN-2002-0639) involved an integer underflow where a subtraction produced a massive wrapped value used as a memory allocation size, enabling heap corruption and remote code execution. Attackers deliberately craft inputs — such as a length field value of 0 — knowing the subtraction will produce a giant number, letting them overflow a subsequent buffer or bypass a size check entirely.

## Key facts
- Underflow most commonly affects **unsigned integers**; subtracting past zero wraps to `MAX_VALUE` (e.g., 0 - 1 = 4,294,967,295 for a 32-bit unsigned int)
- It is distinct from **floating-point underflow**, which is a precision issue — integer underflow is a discrete wraparound, not a rounding error
- Dangerous pattern: using user-controlled input as a subtracted length operand before a `malloc()` call — the inflated allocation size leads directly to heap overflow
- C and C++ have **no built-in protection**; safe languages like Rust panic on underflow in debug mode and wrap only when explicitly requested
- Mitigations include **input validation**, using signed integers where negatives are meaningful, and compiler flags like `-fsanitize=undefined` (UBSan)

## Related concepts
[[integer overflow]] [[buffer overflow]] [[heap corruption]] [[input validation]]