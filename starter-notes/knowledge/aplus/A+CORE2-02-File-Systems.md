---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 02
source: rewritten
---

# File Systems
**The organizational blueprint that tells your operating system how to arrange, find, and manage every file on your drive.**

---

## Overview

Think of a [[file system]] as the filing cabinet system in a library—without a standard way to organize books, you'd never find anything. When you [[partition]] a drive and then [[format]] it, you're essentially choosing which organizational method that partition will use. This choice is critical for A+ because different [[operating systems]] speak different file system languages, and knowing which systems work where will definitely appear on your exam.

---

## Key Concepts

### Partition vs. Format

**Analogy**: Partitioning is like dividing a plot of land into separate lots; formatting is like deciding whether each lot will be a house, a business, or a farm.

**Definition**: [[Partitioning]] divides physical storage into separate logical sections. [[Formatting]] writes the file system structure onto that partition, enabling the [[operating system]] to read and write data using that specific system's rules.

---

### File Allocation Table 32 (FAT32)

**Analogy**: FAT32 is like an old-school card catalog where every book location is listed on index cards—simple, but you can only write so many cards before you run out of space.

**Definition**: [[FAT32]] is a legacy [[file system]] using a table-based allocation method. It has a maximum file size of 4 GB and maximum partition size of 2 TB, making it outdated but still cross-compatible.

**Key Limitation**: Cannot handle individual files larger than 4 GB.

---

### NTFS (NT File System)

**Analogy**: NTFS is like upgrading from a card catalog to a modern database system—it tracks everything more efficiently, adds security features, and can handle massive files without breaking a sweat.

**Definition**: [[NTFS]] is Microsoft's modern [[file system]] introduced with Windows NT, featuring virtually unlimited file sizes, built-in [[file compression]], [[file encryption]] ([[EFS]]), [[file quotas]], and advanced security attributes (ACLs).

**Real-world advantage**: Most Windows systems use NTFS; many modern [[Linux]] and [[macOS]] versions can read and write NTFS natively.

---

### exFAT (Extended FAT)

**Analogy**: exFAT is the Goldilocks of file systems—it keeps FAT32's simplicity but removes the artificial size limits, perfect for USB drives and SD cards.

**Definition**: [[exFAT]] bridges FAT32 and NTFS by supporting files larger than 4 GB while remaining lightweight and cross-platform compatible across Windows, Mac, and Linux.

---

### REFS (Resilient File System)

**Analogy**: REFS is like NTFS's next-generation successor—same brand, but with reinforced safety features and built-in redundancy to prevent data corruption.

**Definition**: [[REFS]] is Microsoft's next-generation [[file system]] designed as an upgrade to NTFS, with improved reliability, automatic error correction, and support for massive storage volumes. Currently found on Windows Server and high-end storage systems.

---

### File System Comparison Table

| Feature | FAT32 | exFAT | NTFS | REFS |
|---------|-------|-------|------|------|
| Max File Size | 4 GB | 16 EB | 16 EB | 16 EB |
| Max Partition | 2 TB | 128 PB | 16 EB | 16 EB |
| Encryption | ❌ | ❌ | ✅ ([[EFS]]) | ✅ |
| Compression | ❌ | ❌ | ✅ | ✅ |
| Quotas | ❌ | ❌ | ✅ | ✅ |
| Cross-Platform | ✅ | ✅ | ⚠️ (Read-only on older Mac/Linux) | ❌ (Windows only) |
| Common Use | Legacy USB drives | USB/SD cards | Windows primary | Windows Server/Enterprise |

---

### Linux File Systems

**Analogy**: Linux file systems are like regional dialects—multiple versions exist, but ext4 is the "standard English" you'll encounter most.

**Definition**: [[ext4]] (Fourth Extended File System) is the dominant [[Linux]] [[file system]], supporting modern features like journaling, extents, and large file support. Other [[Linux]] systems include [[ext3]], [[Btrfs]], and [[XFS]].

---

### macOS File Systems

**Analogy**: macOS switched filing systems the way Apple updated everything else—ditching the old ways entirely and moving to something more advanced.

**Definition**: Modern [[macOS]] uses [[APFS]] (Apple File System) instead of legacy HFS+, featuring encryption, snapshots, and atomic operations for improved reliability.

---

### Journaling

**Analogy**: A journal is like a ship's log—if something goes wrong during a voyage, the captain can look back at what was recorded to figure out what happened and recover from it.

**Definition**: [[Journaling]] is a file system feature that logs changes before they're written permanently. If power fails mid-write, the system can replay the journal to prevent corruption. Most modern systems ([[NTFS]], [[ext4]], [[APFS]]) include journaling.

---

## Exam Tips

### Question Type 1: Cross-Platform Compatibility
- *"Which file system can be read and written on Windows, Mac, and Linux?"* → [[exFAT]] or [[FAT32]] (though FAT32 has size limitations)
- *"A user needs to transfer 8 GB files between Windows and Mac. Which file system?"* → [[exFAT]] (FAT32 cannot handle 8 GB files)
- **Trick**: The exam loves asking which system works "across all platforms"—remember that NTFS is read-only on older systems, but exFAT is truly universal for cross-platform use.

### Question Type 2: File System Features
- *"Which Windows file system includes encryption and compression?"* → [[NTFS]]
- *"What does NTFS provide that FAT32 does not?"* → [[File quotas]], [[EFS]], compression, ACLs
- **Trick**: Don't confuse NTFS features with Linux features—REFS is Windows-only and more advanced than NTFS.

### Question Type 3: Maximum File Sizes
- *"What's the maximum file size on FAT32?"* → 4 GB
- *"Can NTFS store a 15 GB video file?"* → Yes (NTFS supports up to 16 EB per file)
- **Trick**: This is a straightforward memorization question—FAT32 = 4 GB limit; everything modern = much higher.

### Question Type 4: Troubleshooting Scenarios
- *"A technician formats a USB drive using NTFS. Why might a Mac user have read-only access?"* → Older macOS versions don't write to NTFS; solution is exFAT.
- *"Why is FAT32 rarely used for modern installations?"* → File size and partition size limitations make it obsolete.
- **Trick**: Look for the "best practice" answer—modern systems should use NTFS on Windows or ext4 on Linux, not legacy FAT32.

---

## Common Mistakes

### Mistake 1: Confusing Partition with Format

**Wrong**: "I partitioned my drive, so it's ready to use."
**Right**: Partitioning creates the space; formatting applies the file system that actually allows data storage.
**Impact on Exam**: You'll see questions asking "what step comes after partitioning?"—answer is always formatting/applying a file system.

---

### Mistake 2: Thinking NTFS Works Everywhere

**Wrong**: "I'll just use NTFS for everything since Windows uses it."
**Right**: NTFS works best on Windows; older Mac and Linux systems may only read (not write) NTFS. For cross-platform USB drives, use exFAT.
**Impact on Exam**: The exam tests whether you know the limitations—a question might ask why a Mac can't write to an NTFS drive, expecting you to know older systems lack write support.

---

### Mistake 3: Forgetting FAT32 Size Limits

**Wrong**: "FAT32 can hold any file I want."
**Right**: FAT32 has a hard 4 GB file size limit and 2 TB partition limit.
**Impact on Exam**: Expect a scenario where someone tries to copy a 5 GB file to a FAT32 drive—you must identify the incompatibility.

---

### Mistake 4: Mixing Up File System Names

**Wrong**: Calling NTFS "NT File System" and REFS "Resilient File System"—sounds the same!
**Right**: NTFS = Windows default; REFS = next-generation Windows server file system (not commonly on consumer PCs).
**Impact on Exam**: You might see a question asking which system is "the upgrade to NTFS"—the answer is REFS, not NTFS.

---

### Mistake 5: Assuming All Linux Uses ext4

**Wrong**: "Linux only has one file system."
**Right**: While ext4 is the standard, other systems like Btrfs and XFS exist for specific use cases.
**Impact on Exam**: You won't be asked to compare ext4 vs. Btrfs on the A+ exam—stick with knowing ext4 is the Linux standard.

---

## Related Topics
- [[Partitioning]]
- [[Disk Management (Windows)]]
- [[File Encryption (EFS)]]
- [[File Quotas]]
- [[Journaling]]
- [[Operating Systems]]
- [[Data Recovery]]
- [[APFS]]
- [[ext4]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*