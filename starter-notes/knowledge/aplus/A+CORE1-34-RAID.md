---
tags: [knowledge, aplus, core-1-(220-1201)]
created: 2026-04-30
cert: CompTIA A+
chapter: 34
source: rewritten
---

# RAID

**Combining multiple storage devices to protect your data when hardware inevitably fails.**

---

## Overview

Your [[hard drives]] and [[SSDs]] hold mission-critical data, but they're mechanical devices that spin, move, and eventually break. A single drive failure means total data loss. [[RAID]] (Redundant Array of Independent/Inexpensive Disks) solves this by linking multiple drives together so your system survives when one drive dies. For the A+ exam, you need to know which RAID levels offer protection and which don't—plus why RAID is NOT a backup strategy.

---

## Key Concepts

### RAID Fundamentals

**Analogy**: Think of RAID like having multiple copies of important documents. If you store one document in a single filing cabinet and it burns down, you've lost everything. But if you split that document across three filing cabinets—or keep backup copies in each one—you survive the disaster.

**Definition**: [[RAID]] is a storage architecture that combines multiple [[physical drives]] into a single logical unit. Depending on the RAID level, this provides either increased performance, data protection, or both. The key distinction: RAID protects against single-drive failure but is NOT a replacement for [[backup]] procedures.

---

### RAID 0 (Striping)

**Analogy**: Imagine writing a letter across four pieces of paper, one word per paper. You get through the letter four times faster, but if you lose even one paper, the whole letter is gibberish.

**Definition**: [[RAID 0]] splits data across multiple drives in chunks ([[stripes]]). When you write 4 MB of data to a 4-drive RAID 0, each drive gets 1 MB simultaneously. This maximizes speed but offers **zero redundancy**—one drive failure = total data loss.

| Feature | RAID 0 |
|---------|--------|
| **Drives Required** | 2+ |
| **Data Protection** | ❌ None |
| **Performance** | ✅ Maximum |
| **Usable Capacity** | 100% of total |
| **Survives Drive Failure?** | ❌ No |

---

### RAID 1 (Mirroring)

**Analogy**: You write the same letter twice on two separate pieces of paper and store them in different locations. If one burns, you still have the other.

**Definition**: [[RAID 1]] creates an exact duplicate (or [[mirror]]) of your data across two drives. Every byte written to Drive A is simultaneously written to Drive B. If Drive A dies, Drive B contains everything.

| Feature | RAID 1 |
|---------|--------|
| **Drives Required** | 2 (minimum) |
| **Data Protection** | ✅ Yes (1 drive) |
| **Performance** | ⚠️ Good for reads, normal for writes |
| **Usable Capacity** | 50% of total |
| **Survives Drive Failure?** | ✅ Yes (1 drive) |

---

### RAID 5 (Striping with Parity)

**Analogy**: You have three friends and split a secret message across them. Each gets different parts of the message, plus special error-checking info. If any one friend vanishes, the other two can reconstruct the secret.

**Definition**: [[RAID 5]] stripes data across multiple drives (typically 3+) and adds [[parity]] information—mathematical reconstruction data—distributed across all drives. If one drive fails, the remaining drives use parity to rebuild the lost data.

| Feature | RAID 5 |
|---------|--------|
| **Drives Required** | 3+ |
| **Data Protection** | ✅ Yes (1 drive) |
| **Performance** | ✅ Good for reads; writes slower due to parity calculation |
| **Usable Capacity** | (n-1)/n of total (e.g., 4 drives = 75%) |
| **Survives Drive Failure?** | ✅ Yes (1 drive) |
| **Rebuild Time** | ⚠️ Hours to days depending on drive size |

---

### RAID 6 (Dual Parity)

**Analogy**: Same as RAID 5's three friends, but now you split the message across four friends with **two** layers of error-checking. You can lose any two friends and still reconstruct the secret.

**Definition**: [[RAID 6]] operates like [[RAID 5]] but stores **two independent parity blocks** across the drive array. This survives the failure of any two drives simultaneously—critical for large-capacity drives where [[rebuild time]] is dangerously long.

| Feature | RAID 6 |
|---------|--------|
| **Drives Required** | 4+ |
| **Data Protection** | ✅ Yes (2 drives) |
| **Performance** | ⚠️ Slower writes (double parity overhead) |
| **Usable Capacity** | (n-2)/n of total (e.g., 4 drives = 50%) |
| **Survives Drive Failure?** | ✅ Yes (up to 2 drives) |

---

### RAID 10 (1+0, Mirrored Stripes)

**Analogy**: You create two pairs of duplicated documents, then split your data between the pairs. You get both the speed of striping AND the protection of mirroring.

**Definition**: [[RAID 10]] combines [[RAID 1]] mirroring with [[RAID 0]] striping. Data is mirrored across pairs of drives, then those pairs are striped together. Requires minimum 4 drives and offers high performance with solid redundancy (survives any one drive failure, sometimes more depending on layout).

| Feature | RAID 10 |
|---------|--------|
| **Drives Required** | 4+ (must be even) |
| **Data Protection** | ✅ Yes (1+ drives depending on config) |
| **Performance** | ✅ Excellent for reads and writes |
| **Usable Capacity** | 50% of total |
| **Survives Drive Failure?** | ✅ Yes (typically 1-2 drives) |

---

## Exam Tips

### Question Type 1: Identifying RAID Levels by Characteristics

- *"A company needs to survive a single drive failure with maximum read/write performance. They have four 2TB drives. Which RAID level is best?"* → **RAID 10** (mirroring + striping = speed + redundancy)

- *"Which RAID level provides NO redundancy but maximum performance?"* → **RAID 0** (striping only)

- *"You need to protect against two simultaneous drive failures on large capacity drives. What's the minimum RAID level?"* → **RAID 6**

**Trick**: Don't confuse RAID 0+1 with RAID 10. They're different! RAID 0+1 stripes first, then mirrors the stripes (less reliable). RAID 10 mirrors first, then stripes the mirrors (more reliable for A+ purposes).

---

### Question Type 2: Capacity and Overhead Calculations

- *"You have four 1TB drives in RAID 5. How much usable capacity?"* → (4-1) × 1TB = **3TB**

- *"Same setup in RAID 6?"* → (4-2) × 1TB = **2TB** (one drive lost to parity overhead)

**Trick**: Remember the formula: **Usable = (n - parity_drives) × drive_size**. For RAID 5, parity = 1. For RAID 6, parity = 2.

---

### Question Type 3: RAID vs. Backup

- *"Is RAID a backup solution?"* → **NO**. RAID is disaster recovery for hardware failure, not data corruption, ransomware, or accidental deletion.

**Trick**: The exam loves trapping you here. RAID 5 survives a drive dying, but won't save you from a [[virus]] that corrupts files across all drives. You still need separate [[backup]] media.

---

## Common Mistakes

### Mistake 1: Confusing RAID Protection with Backup

**Wrong**: "Our data is safe—we use RAID 5, so we don't need backups."

**Right**: RAID protects against physical drive failure only. Corruption, deletion, and malware can destroy data across the entire array. You need both RAID AND offsite backups.

**Impact on Exam**: A+ questions specifically test this distinction. You'll see scenarios like "A user accidentally deletes files from a RAID 5 array—what recovers them?" Answer: the backup system, not RAID.

---

### Mistake 2: Thinking All RAID Levels Offer Redundancy

**Wrong**: "RAID is redundancy, so RAID 0 is redundant."

**Right**: RAID 0 is striping for speed only. It has NO redundancy. RAID 1, 5, 6, and 10 offer redundancy.

**Impact on Exam**: Expect questions that name a RAID level and ask "Does this protect against drive failure?" Know which do and which don't cold.

---

### Mistake 3: Miscalculating Rebuild Risk

**Wrong**: "RAID 5 is always safe. One drive can fail, so we're fine."

**Right**: While one drive can fail without data loss, the [[rebuild]] process stresses remaining drives. A second failure during rebuild = total data loss. This is why RAID 6 is preferred for large drives (RAID 5 rebuild takes too long).

**Impact on Exam**: You may see a scenario: "A 8TB drive in a 4-drive RAID 5 array fails. During the 18-hour rebuild, a second drive starts clicking. What's the risk?" Answer: Total data loss if the second drive fails during rebuild.

---

### Mistake 4: Confusing RAID 10 vs. RAID 01

**Wrong**: "RAID 10 and RAID 0+1 are the same thing."

**Right**: 
- **RAID 10**: Mirror first (pairs), then stripe the pairs. More redundant.
- **RAID 01**: Stripe first, then mirror the stripes. Less redundant.

**Impact on Exam**: The A+ may only mention "RAID 10," but it's good to know the distinction. RAID 10 is more common in enterprise.

---

## Related Topics

- [[Hard Drives]] – Physical storage devices that RAID protects
- [[SSDs]] – Alternative storage; RAID principles apply
- [[Backup]] – Separate, mandatory protection strategy
- [[Data Recovery]] – What happens when RAID fails
- [[Parity]] – The math behind RAID 5/6
- [[Hot Swap]] – Replacing failed drives without shutdown
- [[Fault Tolerance]] – Design principle RAID implements

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 1 (220-1201) | [[A+]]*