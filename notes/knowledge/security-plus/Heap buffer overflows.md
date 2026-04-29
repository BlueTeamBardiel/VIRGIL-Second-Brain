# Heap buffer overflows

## What it is
Imagine renting a storage unit, then quietly stacking boxes into your neighbor's unit because yours is full — that's a heap buffer overflow. It occurs when a program writes more data than allocated to a dynamically allocated memory region (the heap), corrupting adjacent memory structures at runtime rather than at compile-time stack boundaries.

## Why it matters
The 2021 iOS zero-click exploit chain (used by NSO Group's Pegasus spyware) leveraged a heap buffer overflow in Apple's image parsing library — no user interaction required. An attacker sending a malformed image could corrupt heap metadata, redirect execution flow, and achieve remote code execution silently.

## Key facts
- **Heap vs. Stack:** Stack overflows corrupt return addresses; heap overflows corrupt heap metadata (chunk headers, free lists) or adjacent object data — making them harder to detect but equally dangerous.
- **Exploitation techniques:** Attackers manipulate glibc malloc's "unlink" mechanism or abuse use-after-free conditions triggered by corrupted heap structures.
- **Mitigations:** Heap canaries, safe unlinking checks (added in glibc 2.3.4+), ASLR (randomizes heap base address), and Guard Pages reduce exploitability but don't eliminate it.
- **Common root causes:** Incorrect size calculations (`malloc(strlen(s))` forgetting the null terminator), missing bounds checks in loops, and integer overflows passed to allocation functions.
- **Languages:** C and C++ are primary targets; memory-safe languages like Rust eliminate the vulnerability class entirely through ownership models enforced at compile time.

## Related concepts
[[Buffer Overflow]] [[Use-After-Free]] [[ASLR]] [[Memory Safe Languages]] [[Heap Spraying]]