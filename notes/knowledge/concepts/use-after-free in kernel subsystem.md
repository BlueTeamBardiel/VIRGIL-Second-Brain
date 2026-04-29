# use-after-free in kernel subsystem

## What it is
Imagine a hotel room is checked out and reassigned to a new guest — but the previous guest still has a key and walks back in, reading the new guest's documents or planting their own. A use-after-free (UAF) vulnerability occurs when kernel code retains a pointer to a memory object after that object has been freed, then dereferences the pointer while the memory has been reallocated for something else. In the kernel context, this means attacker-controlled data can occupy the freed region, turning a dangling pointer into an arbitrary read/write or privilege escalation primitive.

## Why it matters
CVE-2021-3490 (Linux eBPF) and CVE-2022-8543 illustrate how UAF bugs in kernel subsystems become local privilege escalation exploits: an unprivileged process triggers the free, heap-sprays a crafted object into the freed slot, and when the dangling pointer is dereferenced, the kernel executes attacker-controlled function pointers with ring-0 privileges. Mitigations like SLUB freelist randomization and kernel pointer sanitization (KASLR + `CONFIG_INIT_ON_FREE`) directly target this attack pattern.

## Key facts
- UAF in the kernel is **critical severity** because kernel memory runs with ring-0 privileges — exploitation often yields full root or container escape.
- The **heap spray** technique is the standard exploit primitive: flood the kernel heap with crafted objects sized to match the freed allocation.
- **Temporal memory safety** tools like KASAN (Kernel Address SANitizer) are the primary detection mechanism during development; they poison freed memory to catch dangling pointer dereferences.
- Linux's **CONFIG_SLAB_FREELIST_RANDOM** and **struct_group isolation** reduce determinism, making reliable UAF exploitation significantly harder.
- UAF bugs frequently arise in **reference-counting errors** — forgetting to increment `kref` before releasing a lock is a classic root cause pattern.

## Related concepts
[[heap spray]] [[kernel privilege escalation]] [[memory safety mitigations]] [[dangling pointer]] [[KASLR]]