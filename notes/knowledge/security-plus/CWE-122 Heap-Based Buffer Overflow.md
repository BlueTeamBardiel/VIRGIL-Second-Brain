# CWE-122 Heap-Based Buffer Overflow

## What it is
Imagine a restaurant where waiters write customer orders on sticky notes, but someone orders a 500-item meal and the waiter keeps writing, scribbling over the neighboring table's check — and their reservation details. A heap-based buffer overflow occurs when a program writes more data into a heap-allocated memory buffer than it was sized to hold, corrupting adjacent heap memory containing other objects, metadata, or function pointers.

## Why it matters
The 2021 exploitation of CVE-2021-1675 (PrintNightmare) leveraged heap corruption primitives to achieve remote code execution on Windows print spoolers. Attackers manipulate overflowed heap data to overwrite heap management metadata or object vtable pointers, redirecting execution flow to attacker-controlled shellcode — a technique that bypasses many stack-based protections since stack canaries don't protect the heap.

## Key facts
- Unlike stack overflows, heap overflows target dynamically allocated memory (via `malloc`, `new`, etc.) and don't directly overwrite return addresses — instead they corrupt heap metadata or adjacent objects
- Heap overflows can enable **use-after-free** conditions and **type confusion** attacks by corrupting allocator bookkeeping structures
- Mitigations include **heap canaries**, **safe unlinking** (validates freelist pointers before unlinking), **ASLR** (randomizes heap base), and allocators like **DieHard** that randomize object placement
- Exploitability depends heavily on **heap feng shui** — attackers deliberately groom heap layout to place target objects adjacent to the vulnerable buffer
- CWE-122 is a child of CWE-119 (Improper Restriction of Operations within the Bounds of a Memory Buffer) and commonly leads to CWE-788 (Access of Memory Location After End of Buffer)

## Related concepts
[[CWE-119 Buffer Overflow]] [[Use-After-Free (CWE-416)]] [[ASLR]] [[Heap Spraying]] [[Memory-Safe Languages]]