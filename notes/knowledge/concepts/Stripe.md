# Stripe

## What it is
Think of RAID striping like spreading a deck of cards across multiple tables simultaneously — each table holds only part of each card's data, but together they reconstruct the full picture at blazing speed. Striping (RAID Level 0) distributes data sequentially across two or more disks in fixed-size chunks called "stripe units," improving read/write performance by enabling parallel I/O operations.

## Why it matters
In a forensic investigation, a defender recovering data from a striped RAID array faces a critical challenge: if even one disk fails or is missing, *all* data across the entire array becomes unrecoverable — there is zero redundancy. An attacker who physically destroys a single disk in a RAID 0 system achieves total data destruction more efficiently than wiping every disk individually, making striping a silent liability in poorly designed backup architectures.

## Key facts
- **RAID 0 = Striping only** — improves performance but provides **no fault tolerance**; losing one drive means losing all data
- Stripe unit size (chunk size) directly affects performance: smaller chunks favor random reads, larger chunks favor sequential reads
- RAID 0 requires a **minimum of 2 disks**; total capacity = sum of all drives (100% utilization, unlike mirrored arrays)
- Striping is combined with mirroring in **RAID 10 (1+0)** to gain both speed and redundancy — a common enterprise solution
- For forensic imaging of a RAID 0 array, examiners must capture **all member disks** and reassemble the stripe order before analysis; tools like Autopsy and FTK support RAID reconstruction

## Related concepts
[[RAID Levels]] [[Data Redundancy]] [[Disk Mirroring]] [[Forensic Imaging]] [[Fault Tolerance]]