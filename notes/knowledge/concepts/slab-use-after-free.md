# slab-use-after-free

## What it is
Like a library book returned to the shelf and immediately checked out by someone else — except the first borrower still has the card and tries to write notes in it. A slab-use-after-free vulnerability occurs when kernel memory allocated from the slab allocator is freed but a dangling pointer still references that memory region, which may have been reallocated to a different kernel object. An attacker can spray the heap to control what lands in that freed slot, then manipulate the stale pointer to corrupt or hijack the new object.

## Why it matters
CVE-2022-0995 (Linux kernel `watch_queue`) was a slab-use-after-free that allowed local privilege escalation to root by corrupting a kernel credential structure placed in the recycled slab slot. Defenders patch these by enabling kernel hardening features like `CONFIG_SLAB_FREELIST_RANDOM` and `CONFIG_INIT_ON_FREE_DEFAULT_ON`, which randomize and zero freed slab memory to break exploit reliability.

## Key facts
- Occurs exclusively in kernel space within the slab/slub/slob memory allocator subsystems — distinct from user-space heap UAF
- Exploitation typically requires **heap spraying**: flooding the allocator with controlled objects to predictably occupy the freed slab slot
- Mitigations include kernel Address Sanitizer (KASAN), which poisons freed slab memory and detects illegal accesses at runtime
- Linux's `CONFIG_SLAB_FREELIST_HARDENED` XORs freelist pointers, making it harder to corrupt the allocator's internal metadata
- These vulnerabilities frequently enable **local privilege escalation (LPE)** rather than remote code execution, making them post-exploitation favorites after initial foothold

## Related concepts
[[use-after-free]] [[heap-spraying]] [[kernel-privilege-escalation]] [[memory-safe-languages]] [[ASLR]]