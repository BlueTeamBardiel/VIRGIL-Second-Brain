# heap grooming

## What it is
Like a con artist arranging seats at a poker table before the mark arrives, heap grooming is the art of manipulating memory layout *before* triggering a vulnerability. Precisely, it is a pre-exploitation technique where an attacker makes controlled allocations and deallocations to position specific objects at predictable addresses in heap memory, so a subsequent overflow or use-after-free lands exactly where intended.

## Why it matters
In the 2021 exploitation of CVE-2021-1647 (Microsoft Defender), researchers demonstrated how heap grooming allowed reliable triggering of a use-after-free by spraying crafted objects to fill freed memory slots before the vulnerable code path reused them. Without grooming, the exploit would succeed only probabilistically; with it, the attack becomes deterministic and weaponizable. This is why modern mitigations like randomized allocator behavior (hardened malloc) specifically target grooming's predictability assumptions.

## Key facts
- Heap grooming is **not the same as heap spraying** — grooming shapes *structure*, spraying floods *volume*; they are often combined
- The goal is to control which object occupies a freed chunk, turning a bug into a controlled **type confusion** or **controlled write**
- Effective grooming requires knowledge of the target allocator (e.g., ptmalloc, jemalloc, PartitionAlloc in Chrome)
- **Temporal precision matters**: allocations must happen in the correct sequence relative to the vulnerability trigger
- Mitigations like **PartitionAlloc's type isolation** (separating objects by type into different arenas) directly defeat cross-type grooming strategies

## Related concepts
[[heap spraying]] [[use-after-free]] [[memory allocator internals]] [[type confusion]] [[exploit reliability]]