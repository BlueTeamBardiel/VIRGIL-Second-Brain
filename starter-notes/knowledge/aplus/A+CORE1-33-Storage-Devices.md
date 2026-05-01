---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 33
source: rewritten
---

# Storage Devices
**Permanent solutions for keeping your data safe when the power goes dark.**

---

## Overview

Your computer's [[RAM]] loses everything the moment you flip the power switch — it's like a whiteboard that erases instantly. To actually *keep* your files, photos, and programs around for the long haul, you need [[Storage Devices]] that persist even without electricity. The A+ exam loves testing your knowledge of how different storage technologies work, their strengths, weaknesses, and when to use each one.

---

## Key Concepts

### Volatile vs. Non-Volatile Memory

**Analogy**: Think of [[RAM]] as a conversation you're having right now — once you stop talking, it's gone forever. [[Storage]] is like a journal you write in; even if you close the book and walk away, the words stay there.

**Definition**: [[Volatile Memory]] (like [[RAM]]) disappears when powered off. [[Non-Volatile Storage]] (hard drives, SSDs, flash drives) permanently retains data regardless of power state.

| Type | Data Persistence | Speed | Cost |
|------|------------------|-------|------|
| [[RAM]] ([[Volatile]]) | Lost on shutdown | Extremely fast | Expensive per GB |
| [[HDD]] ([[Non-Volatile]]) | Permanent | Slower (mechanical) | Cheap per GB |
| [[SSD]] ([[Non-Volatile]]) | Permanent | Very fast | Moderate cost |

---

### Hard Disk Drive (HDD)

**Analogy**: Imagine a record player that spins at insane speeds — instead of a needle reading grooves for music, a tiny arm reads magnetic patterns on spinning platters for data.

**Definition**: A [[Hard Disk Drive]] (HDD) uses rotating magnetic platters and a read/write head on a moving arm to store and retrieve data. It's a [[Random Access Storage]] device, meaning you can jump to any location on the disk instantly without reading sequentially.

**Key Components**:
- **[[Platter]]**: The spinning disk where magnetic data lives (spins 5,400–15,000 RPM)
- **[[Spindle]]**: The motor that rotates the platters
- **[[Read/Write Head]]**: The tiny arm that reads/writes data magnetically
- **[[Actuator Arm]]**: Moves the head across the platter surface
- **[[Sealed Chamber]]**: Must remain dust-free or data corruption occurs

**Mechanical Vulnerability**: Since HDDs have moving parts, any component can fail — bearings wear out, heads crash, motors burn up. This is why [[MTBF]] (Mean Time Before Failure) matters on the exam.

---

### Solid State Drive (SSD)

**Analogy**: Unlike a record player, an [[SSD]] is like a giant library where a computer instantly knows exactly which shelf has your book — no spinning, no mechanical arm hunting around.

**Definition**: A [[Solid State Drive]] stores data in [[Flash Memory]] using electronic cells with no moving parts. Data access is near-instantaneous because there's no mechanical delay.

**Advantages Over HDD**:
- No moving parts = more reliable
- 10-100x faster read/write speeds
- Uses less power
- Generates less heat
- Better for portable devices

**Disadvantage**: Higher cost per gigabyte (though prices are dropping fast).

---

### Flash Memory Storage

**Analogy**: Think of [[Flash Memory]] as a parking garage where each space holds one bit of data. Instead of spinning to find a car, the system just knows exactly which space to access instantly.

**Definition**: [[Flash Memory]] uses transistors to store electrical charge representing 1s and 0s. It's found in [[SSDs]], [[USB Flash Drives]], [[Memory Cards]], and phone storage.

**Key Points**:
- **No moving parts** = extremely durable
- **Write Cycles Limited**: Flash cells degrade after ~10,000–100,000 writes ([[Wear Leveling]] spreads writes to prevent early failure)
- **Faster than mechanical storage** but slower than [[RAM]]

---

### Optical Storage

**Analogy**: A [[CD]]/[[DVD]] is like a physical punch card — data exists as tiny pits burned into the surface, read by a laser beam instead of your eyes.

**Definition**: [[Optical Media]] ([[CD]], [[DVD]], [[Blu-ray]]) stores data as microscopic pits on a reflective surface, read by a laser. It's inexpensive for distribution but slow and increasingly obsolete.

| Format | Capacity | Speed | Use Case |
|--------|----------|-------|----------|
| [[CD]] | 700 MB | ~150 KB/s | Music, old software |
| [[DVD]] | 4.7 GB (single) | ~1.4 MB/s | Movies, backups |
| [[Blu-ray]] | 25-50 GB | ~4.5 MB/s | HD movies, large backups |

---

### Storage Interface Connections

**Definition**: The bridge connecting storage devices to your [[Motherboard]]. CompTIA A+ focuses on these:

| Interface | Speed | Cable Type | Modern Use |
|-----------|-------|-----------|-----------|
| [[SATA]] (Serial ATA) | 600 MB/s max | Flat cable | HDDs, older SSDs |
| [[NVMe]] (M.2) | 3,500+ MB/s | Direct to slot | Modern SSDs |
| [[USB 3.0]] | 400 MB/s | USB-C/Type-A | External drives, flash drives |
| [[IDE]]/[[PATA]] | 133 MB/s | Ribbon cable | **Legacy — exam nostalgia only** |

```
Example NVMe Install:
1. Open M.2 slot cover on motherboard
2. Insert NVMe SSD at 30-degree angle
3. Press down and secure with single screw
4. Reinstall cover
Result: Blazingly fast storage with zero cables!
```

---

### Partitioning & File Systems

**Analogy**: A [[Partition]] is like dividing one large warehouse into separate sections — each section can have its own filing system ([[File System]]).

**Definition**: [[Partitions]] divide physical storage into logical sections. Each partition needs a [[File System]] to organize files.

**Common File Systems**:
- **[[NTFS]]**: Windows modern standard (secure, supports large files)
- **[[FAT32]]**: Legacy, cross-platform but max 4GB file size
- **[[exFAT]]**: Modern replacement for FAT32 (USB drives, external HDDs)
- **[[ext4]]**: Linux standard
- **[[HFS+]]/[[APFS]]**: macOS

```
Viewing disk partitions (Windows PowerShell):
Get-Disk | Select-Object Number, HealthStatus, Size

Viewing partitions (Linux):
lsblk
```

---

## Exam Tips

### Question Type 1: Storage Device Selection
- *"A client needs fast, reliable storage for video editing workstations. Which is the best choice?"* → [[SSD]] or [[NVMe]] (speed over HDD cost savings)
- *"A company needs cheap bulk storage for archived files accessed rarely."* → [[HDD]] (cost-effective despite slower access)
- **Trick**: The exam may ask which is "most reliable" — **SSDs win** because no moving parts. HDDs fail more often due to mechanical wear.

### Question Type 2: Interface Speed Ranking
- *"Rank these from fastest to slowest: SATA, NVMe, USB 3.0, IDE"* → NVMe (3,500+ MB/s) > SATA (600 MB/s) > USB 3.0 (400 MB/s) > IDE (133 MB/s)
- **Trick**: Don't memorize exact numbers — just know NVMe destroys everything else, SATA is mid-range, USB is variable.

### Question Type 3: HDD Components
- *"Which HDD part moves the read/write head across the platter?"* → [[Actuator Arm]]
- *"What spins the platters?"* → [[Spindle]] (motor)
- **Trick**: Confusing "spindle" with "platter" loses points. **Spindle = motor. Platter = storage disk.**

### Question Type 4: File System Limitations
- *"You're formatting a USB drive for use on Windows and Mac. Which file system?"* → [[exFAT]] (modern, cross-platform)
- *"Why can't you store a 5GB file on FAT32?"* → FAT32 max file size = 4GB
- **Trick**: The exam loves testing FAT32's 4GB limit — it's ancient but keeps appearing.

---

## Common Mistakes

### Mistake 1: Confusing HDD Speed with SSD Speed

**Wrong**: "My hard drive spins at 7,200 RPM, so it's fast like an SSD."
**Right**: [[RPM]] (rotations per minute) is mechanical speed, not actual data transfer speed. Even a 15,000 RPM HDD reads/writes slower than a budget [[SSD]] because mechanical latency kills performance.
**Impact on Exam**: You'll miss questions comparing storage device performance. **Always choose SSD for speed questions** unless the question specifically asks about cost.

---

### Mistake 2: Thinking Flash Memory Never Fails

**Wrong**: "SSDs have no moving parts, so they last forever."
**Right**: [[Flash Memory]] has a finite number of write cycles (~10,000–100,000 per cell). After that, cells fail. [[Wear Leveling]] helps, but SSDs *can* fail.
**Impact on Exam**: The exam tests whether you know **SSDs are more reliable than HDDs, but not immortal**. Watch for trick questions claiming "SSDs never fail."

---

### Mistake 3: Mixing Up Storage Interfaces

**Wrong**: "NVMe and M.2 are the same thing."
**Right**: **M.2 is a *form factor*** (physical shape). **NVMe is a *protocol*** (how data moves). M.2 can use SATA or NVMe protocols. (Most modern M.2 drives use NVMe, which is why people confuse them.)
**Impact on Exam**: A question asking "What's the fastest M.2 drive?" expects **NVMe** as the answer, not just "M.2" (which could technically be slow SATA).

---

### Mistake 4: Forgetting Optical Media Exists

**Wrong**: "Nobody uses CDs or DVDs anymore, so the A+ won't test it."
**Right**: The exam *still* includes legacy storage. You need to know [[CD]] = 700 MB, [[DVD]] = 4.7 GB, and that they're read by lasers.
**Impact on Exam**: Expect 1–2 legacy questions. Don't skip the optical section just because it feels old.

---

## Related Topics
- [[RAM]] (volatile memory vs. storage)
- [[Motherboard Connections]] (how storage plugs in)
- [[Data Backup Strategies]]
- [[Disk Partitioning & MBR/GPT]]
- [[BIOS/UEFI]] (boot drive detection)
- [[Troubleshooting Storage Failures]]
- [[Device Drivers]] (storage controller drivers)

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) Lecture | [[A+]] Certification Study Material*