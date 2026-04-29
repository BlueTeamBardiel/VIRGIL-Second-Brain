# KASAN

## What it is
Like a live electrical fence around every box in a warehouse that screams the moment anyone reaches into the wrong one, KASAN (Kernel Address Sanitizer) is a dynamic memory error detection tool built into the Linux kernel. It instruments memory accesses at compile time and uses shadow memory to track valid allocation boundaries, catching out-of-bounds reads/writes and use-after-free bugs the instant they occur — not silently after the damage is done.

## Why it matters
Many critical Linux kernel exploits — including privilege escalation bugs in the `slab` allocator — rely on silent heap corruption that normal execution never flags. KASAN transforms these silent corruptions into immediate kernel panics with detailed stack traces, allowing developers and security researchers to catch and fix exploitable memory bugs before they ship into production kernels or get weaponized as zero-days. CVE-2016-6187 (a heap overflow in OverlayFS) was the class of bug KASAN was designed to surface during fuzzing.

## Key facts
- KASAN uses a **shadow memory region** where 1 byte of shadow tracks 8 bytes of real kernel memory, encoding whether those bytes are accessible
- Operates in two modes: **generic KASAN** (for debugging, ~2× memory overhead) and **hardware-tagged KASAN** (uses ARM MTE for near-zero production overhead)
- Catches **heap out-of-bounds**, **stack out-of-bounds**, **use-after-free**, and **use-after-return** memory errors in kernel space
- Commonly paired with **syzkaller** (kernel fuzzer) to automatically discover kernel memory corruption vulnerabilities
- KASAN is a **defensive development/testing tool**, not a runtime production hardening feature like SMEP or KASLR — it's typically disabled in production builds due to overhead

## Related concepts
[[Heap Overflow]] [[Use-After-Free]] [[KASLR]] [[Kernel Exploitation]] [[Fuzzing]]