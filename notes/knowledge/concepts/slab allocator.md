# slab allocator

## What it is
Think of a restaurant that pre-sets tables with identical place settings before service begins — rather than fetching silverware per order, it reuses pre-arranged setups. A slab allocator is a kernel memory management mechanism that pre-allocates fixed-size chunks ("slabs") of memory for frequently used objects (like network sockets or file descriptors), recycling them instead of repeatedly calling `malloc`/`free`. This eliminates fragmentation and speeds up allocation for same-type kernel objects.

## Why it matters
Slab allocators are the target of **heap feng shui** and **slab grooming** attacks, where an attacker manipulates the allocation/deallocation order to place a controlled object adjacent to a target object in memory. The 2021 Linux kernel exploit CVE-2021-22555 used slab grooming to achieve privilege escalation by overwriting adjacent slab objects through a heap overflow in the Netfilter subsystem. Defenders patch kernels and enable mitigations like SLUB hardening (`CONFIG_SLAB_FREELIST_RANDOM`) to randomize free-list order.

## Key facts
- Linux uses three slab allocator variants: **SLAB** (original), **SLUB** (default, simplified), and **SLOB** (embedded/tiny systems)
- Each slab cache holds objects of one specific size/type (e.g., `kmem_cache` for `task_struct`)
- Freed slab objects are **not immediately zeroed** by default — enabling **use-after-free** (UAF) vulnerabilities that leak stale data or pointers
- **Freelist pointer randomization** (`CONFIG_SLAB_FREELIST_RANDOM`) disrupts predictable heap layout exploitation
- **Cross-cache attacks** target type confusion between slab caches, a technique used in advanced kernel exploits

## Related concepts
[[heap overflow]] [[use-after-free]] [[kernel exploitation]] [[memory corruption]] [[ASLR]]