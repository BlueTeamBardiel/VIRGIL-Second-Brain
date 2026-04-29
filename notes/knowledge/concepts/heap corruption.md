# heap corruption

## What it is
Imagine a warehouse where workers keep rearranging labeled storage bins, but a rogue worker secretly scribbles over the labels and contents of neighboring bins. Heap corruption occurs when a program writes data beyond the boundaries of a dynamically allocated memory region (the heap), overwriting adjacent metadata or objects. Unlike stack overflows, heap corruption targets runtime-allocated memory managed by functions like `malloc()` and `free()`.

## Why it matters
The 2014 Heartbleed vulnerability (CVE-2014-0160) was a heap over-read in OpenSSL that allowed attackers to request up to 64KB of heap memory beyond what was allocated, leaking private keys, passwords, and session tokens from millions of servers. Defenders patching this had to revoke and reissue SSL certificates globally, demonstrating how a single heap flaw can cascade into catastrophic data exposure across the internet.

## Key facts
- **Heap spray** is a common exploitation technique where attackers flood the heap with shellcode-filled allocations, increasing the probability that a corrupted pointer lands on attacker-controlled data.
- Corrupting heap **metadata** (e.g., freelist pointers) can redirect subsequent `free()` or `malloc()` calls to write attacker data to arbitrary memory addresses — this is called an **unlink exploit**.
- **Use-after-free** is a subclass of heap corruption where memory is accessed after being freed, potentially pointing to attacker-controlled content re-allocated in that space.
- Mitigations include **ASLR** (randomizes heap base address), **heap canaries**, and **safe unlinking** checks in modern allocators like `ptmalloc2`.
- Heap corruption is frequently the root cause of **zero-day** vulnerabilities in browsers and PDF readers because they dynamically allocate objects constantly during rendering.

## Related concepts
[[buffer overflow]] [[use-after-free]] [[memory-safe languages]] [[ASLR]] [[heap spray]]