# Array

## What it is
Like a row of numbered mailboxes in an apartment building — each slot holds exactly one item and you retrieve it by its box number. An array is a contiguous block of memory that stores a fixed collection of elements, each accessible via a zero-based index. The ordered, sequential layout means element N lives at base address + (N × element size).

## Why it matters
Buffer overflow attacks exploit how arrays handle memory. When a C program allocates an array of 64 bytes for user input but fails to check input length, an attacker can write beyond the array's boundary, overwriting adjacent memory including return addresses — the basis of classic stack smashing attacks like the Morris Worm and modern ROP chain exploitation.

## Key facts
- **Off-by-one errors** are a common array vulnerability: using `<=` instead of `<` in a loop condition can write one element past the array's end, corrupting adjacent memory
- Arrays in C/C++ have **no built-in bounds checking**, making them inherently unsafe without explicit validation — unlike Java or Python which throw exceptions on out-of-bounds access
- **Heap vs. stack arrays** matter for exploitation: stack-based overflows can hijack return addresses; heap-based overflows can corrupt metadata used by the memory allocator
- **ASLR (Address Space Layout Randomization)** mitigates array-based exploits by randomizing where arrays are loaded in memory, making it harder to predict target addresses
- Input validation (checking length *before* copying into an array) is a primary **CWE-119** mitigation and appears directly in secure coding standards like CERT C

## Related concepts
[[Buffer Overflow]] [[Stack Smashing]] [[Input Validation]] [[ASLR]] [[Heap Exploitation]]