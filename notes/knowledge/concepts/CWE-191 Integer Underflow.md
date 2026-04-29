# CWE-191 Integer Underflow

## What it is
Like an odometer rolling backward past zero and suddenly reading 999,999, an integer underflow occurs when a subtraction operation produces a result below the minimum value a variable type can hold, causing it to wrap around to a large positive number. Precisely, CWE-191 describes a condition where an integer variable decrements below its minimum bound, producing an unexpected and typically enormous value that the program treats as legitimate.

## Why it matters
In 2002, a Linux kernel vulnerability allowed an attacker to trigger an underflow in memory allocation size calculation — a negative size wrapped to a huge unsigned value, causing a heap buffer overflow that enabled privilege escalation. Defenders must validate that subtracted values never produce results below zero, particularly before using the result in memory allocation or loop boundary calculations.

## Key facts
- Underflow most commonly occurs with **unsigned integers**: subtracting 1 from `uint8_t` value `0` yields `255`, not `-1`
- The danger pattern is `size_t len = input_len - HEADER_SIZE` — if `input_len < HEADER_SIZE`, `len` wraps to a massive allocation/loop count
- Often **chained with buffer overflows**: the underflowed value becomes a buffer size or index, leading to out-of-bounds writes
- Unlike signed overflow (undefined behavior in C), unsigned underflow is **defined by the C standard** — it wraps predictably, making it exploitable but harder to detect with sanitizers
- Mitigations include: input validation before arithmetic, compiler flags like `-ftrapv`, safe integer libraries (e.g., SafeInt), and static analysis tools flagging unchecked subtractions

## Related concepts
[[CWE-190 Integer Overflow]] [[CWE-122 Heap-Based Buffer Overflow]] [[CWE-20 Improper Input Validation]]