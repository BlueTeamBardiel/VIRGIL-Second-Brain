# heap overflow

## What it is
Imagine a warehouse where workers keep stacking boxes past the marked boundary lines, crushing the inventory records stored in the next aisle — that's a heap overflow. It occurs when a program writes more data into a dynamically allocated heap memory buffer than it was sized to hold, corrupting adjacent heap metadata or other allocated objects. Unlike stack overflows, the attacker targets runtime-allocated memory, making exploitation more complex but equally dangerous.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) in OpenSSL was effectively a heap over-read — a close cousin — that exposed up to 64KB of heap memory per request, leaking private keys, passwords, and session tokens from servers worldwide. Heap overflows enable attackers to corrupt heap management structures (like `free()` list pointers) to redirect code execution. Defenders counter this with heap canaries, ASLR, and safe allocator designs that detect metadata tampering before it causes damage.

## Key facts
- Heap memory is dynamically allocated at runtime via functions like `malloc()` and `new()`; overflowing it corrupts adjacent allocations or heap metadata
- Classic exploitation technique: **heap feng shui** — carefully arranging heap allocations so a vulnerable object sits adjacent to a high-value target object
- **Use-after-free** vulnerabilities often chain with heap overflows to achieve reliable code execution
- Mitigations include Address Space Layout Randomization (ASLR), heap guards/canaries, and safe allocators like DieHard or the Windows Low Fragmentation Heap (LFH)
- Heap overflows are harder to exploit than stack overflows because heap layout is less predictable, but they are also harder for compilers to automatically detect and prevent

## Related concepts
[[buffer overflow]] [[use-after-free]] [[ASLR]] [[memory corruption]] [[stack overflow]]