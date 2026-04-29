# type confusion

## What it is
Imagine a warehouse worker who grabs a box labeled "apples" but the system secretly swapped it with one labeled "explosives" — the worker handles it like fruit, but it behaves like a bomb. Type confusion occurs when a program allocates memory as one data type but later interprets that same memory as a different type, causing the program to execute unintended operations using attacker-controlled data.

## Why it matters
The 2021 Chrome V8 engine type confusion vulnerabilities (CVE-2021-21224 and others) allowed attackers to achieve remote code execution by causing the JavaScript engine to misidentify object types, enabling out-of-bounds memory reads and writes. Google issued emergency patches within days because exploitation was actively observed in the wild, demonstrating how type confusion can bypass modern browser sandboxes.

## Key facts
- Type confusion is a **memory safety vulnerability** most common in C, C++, and JIT-compiled environments like JavaScript engines and Java VMs
- Exploiting it typically achieves **arbitrary read/write primitives**, which attackers chain with other bugs to escalate to full code execution
- It differs from buffer overflow in that the memory boundary isn't crossed — instead, **the interpretation of valid memory** is corrupted
- Modern mitigations include **Control Flow Integrity (CFI)**, AddressSanitizer, and strongly-typed language features, though none are foolproof in JIT contexts
- Type confusion bugs frequently arise from **improper casting, union misuse, or race conditions** that corrupt type metadata before a function call

## Related concepts
[[use-after-free]] [[memory corruption]] [[heap exploitation]] [[integer overflow]] [[control flow integrity]]