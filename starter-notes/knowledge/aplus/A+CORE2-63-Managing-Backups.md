---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 63
source: rewritten
---

# Managing Backups
**A solid backup strategy is your safety net when hardware fails, files vanish, or systems crash.**

---

## Overview

Data loss happens faster than you'd think—corrupted files, accidental deletions, hardware failures. Without a [[Backup Strategy]], you're one hard drive failure away from losing everything. The A+ exam expects you to understand not just *why* backups matter, but *how* to design a backup plan that fits different organizational needs and risk tolerances.

---

## Key Concepts

### Full Backup

**Analogy**: Think of a full backup like photographing your entire house, room by room, furniture by furniture—every detail captured in one massive album. You never have to wonder where anything is; it's all there.

**Definition**: A [[Full Backup]] copies *every single file* on a system to backup media in a single operation—OS, applications, user data, settings, everything. If catastrophic data loss occurs, one restore from the full backup returns the system to complete functionality.

**Characteristics**:
- Takes the longest to execute (can be hours on large systems)
- Requires substantial storage space
- Most reliable for complete system recovery
- Heaviest load on network/backup hardware

### Incremental Backup

**Analogy**: After that full house photo session, you only photograph new furniture or changed rooms since your last photo—much faster, less overwhelming, but you need all the albums together to see the full picture.

**Definition**: An [[Incremental Backup]] captures only files *changed since the previous backup* (full or incremental). Each incremental is a small, fast snapshot of changes.

**Key Detail**: Restoration requires the full backup *plus all incrementals* in sequence. Missing one incremental breaks the chain.

### Differential Backup

**Analogy**: Same house photo scenario—but this time you photograph *everything that changed since the original full album*, every time. You're always comparing backward to that main reference point.

**Definition**: A [[Differential Backup]] captures all files changed since the *last full backup*, not since the last backup of any kind. Each differential is cumulative and independent.

**Key Detail**: Restoration needs only the last full backup *plus the most recent differential*—faster than incremental recovery.

### Backup Comparison Table

| Feature | Full | Incremental | Differential |
|---------|------|-------------|--------------|
| **Speed** | Slowest | Fastest | Medium |
| **Storage per run** | Largest | Smallest | Medium |
| **Restore complexity** | Single restore | Multiple restores (chain) | Two restores (full + latest) |
| **Restore time** | Medium | Slowest | Fastest |
| **Use case** | Weekly anchor | Daily rapid backups | Daily w/ balance |

### Backup Media Types

**Analogy**: Backup media is like choosing where to store your photo albums—under your bed (local), at your parent's house (offsite), in a safety deposit box (cloud), or printed in a book (offline).

**Definition**: [[Backup Media]] is the physical or virtual storage destination holding backup data. Choices impact recovery speed, cost, and accessibility.

**Common Media**:

| Media | Pros | Cons | Best For |
|-------|------|------|----------|
| **External HDD/SSD** | Fast, affordable, portable | Susceptible to physical damage, theft | Local rapid backups |
| **Tape Drive** | High capacity, archival lifespan (20+ years) | Slow, requires special hardware | Enterprise cold storage |
| **Network Storage (NAS)** | Accessible over network, redundancy options | Network dependency, upfront cost | Small office backups |
| **Cloud/Offsite** | Geographically distributed, no hardware maintenance | Bandwidth limits, subscription costs, privacy concerns | Disaster recovery, compliance |
| **Optical Media (DVD/BD)** | Offline, archival potential | Slow, limited capacity, degradation risk | Legal holds, regulatory archives |

### Backup Frequency Strategy

**Analogy**: You brush your teeth daily, but get a professional cleaning twice yearly. Backup frequency depends on how much data loss you can tolerate in a worst-case scenario.

**Definition**: [[Backup Frequency]] is the schedule determining when backups execute. Higher frequency = less data at risk but more resource consumption.

**Recovery Point Objective (RPO)**:
- RPO = maximum acceptable data loss (in time)
- If RPO is 4 hours, backups must run at least every 4 hours
- Determines frequency and strategy choice

**Common Schedules**:
```
Scenario 1: Small office, low criticality
- Full backup: Sunday night (weekly)
- Incremental: Mon-Sat 6 PM (daily)

Scenario 2: Enterprise, high criticality  
- Full backup: Saturday night (weekly)
- Differential: Mon-Fri 9 PM (daily)
- Incremental: Mon-Fri 12 PM, 3 PM, 6 PM (three times daily)

Scenario 3: Mission-critical with RPO < 1 hour
- Continuous data protection (CDP) / real-time replication
```

### 3-2-1 Backup Rule

**Definition**: Industry best practice stating: maintain **3** copies of data, on **2** different media types, with **1** copy **offsite**.

```
Example 3-2-1 Implementation:
1. Original data (production system)
2. Backup copy A (external SSD at office)
3. Backup copy B (tape archive)
4. Backup copy C (cloud vault - OFFSITE)

Media types: Internal storage + USB + Cloud ✓
Offsite component: Cloud copy ✓
```

### Backup Software & Restoration

**Definition**: [[Backup Software]] orchestrates data capture, compression, deduplication, encryption, and restoration. Examples: Veeam, Acronis, Windows Backup, macOS Time Machine, rsync.

**Critical Features**:
- **Scheduling automation**: Runs on set timetables without user intervention
- **Compression**: Reduces data size (often 30-60% reduction)
- **Deduplication**: Eliminates duplicate data blocks across backups
- **Encryption**: Protects sensitive backup data at rest and in transit
- **Verification/Testing**: Confirms backups are valid (restoration tests)
- **Bare-metal recovery**: Restore entire OS/partitions from scratch

**Restoration Considerations**:
- Always test restores in non-production environments first
- Document restore procedures and RTO (Recovery Time Objective)
- Verify backup integrity regularly—a corrupt backup is worthless

---

## Exam Tips

### Question Type 1: Strategy Selection
- *"An accounting firm processes payroll daily and cannot afford more than 2 hours of data loss. Which backup strategy best fits their RPO?"* → **Incremental with frequent runs** (every 2 hours) or **differential daily + hourly incrementals**
- **Trick**: Watch for RPO language—"4 hours max loss" means backups must run *at least* every 4 hours. Don't confuse RPO with RTO.

### Question Type 2: Media Selection  
- *"A company needs archival storage for 7-year regulatory compliance with minimal costs. Which media is best?"* → **Tape drives** (lowest cost per TB for long-term, archival durability)
- **Trick**: Cloud sounds convenient but costs money annually. Tape is capital upfront but cheapest long-term for archival.

### Question Type 3: 3-2-1 Rule Application
- *"Which scenario violates the 3-2-1 rule?"*  
  A) Full backup on HDD + differential on SSD + cloud copy  
  B) Full backup on HDD + copy on external HDD + offsite HDD  ← **Answer: B** (only 1 media type)
- **Trick**: The exam tests whether you understand *why* 3-2-1 works—different media types protect against single-point-of-failure.

### Question Type 4: Restoration Scenarios
- *"A file server lost data on Tuesday morning. Backups ran: Full Sunday, Incremental Mon-Fri. Which backups restore the system?"* → **Sunday full + Monday + Tuesday incrementals** (must restore in sequence)
- **Trick**: Incremental chains break if one backup is missing or corrupted.

---

## Common Mistakes

### Mistake 1: Confusing Incremental and Differential
**Wrong**: "Differentials save more space because they only back up changes."  
**Right**: Differentials are *cumulative* (all changes since full), incrementals are *change-since-last-backup*. Incrementals save more space but require multiple restores.  
**Impact on Exam**: Questions test whether you understand restoration complexity—incremental is fastest to run, slowest to restore; differential is middle ground.

### Mistake 2: Forgetting the Offsite Component
**Wrong**: "We have 3 backup copies on site—we're protected."  
**Right**: If the building burns down/floods, all on-site backups are gone. At least one copy must live elsewhere (cloud, remote office, bank vault).  
**Impact on Exam**: 3-2-1 rule questions specifically test understanding that geographic distribution prevents correlated failure.

### Mistake 3: Assuming All Backups Are Equally Usable
**Wrong**: "We backup every night, so data loss is impossible."  
**Right**: A backup is only useful if (1) it actually completed, (2) it's not corrupted, (3) the software can restore it, (4) you have time to restore before business impact exceeds tolerance.  
**Impact on Exam**: The exam tests RPO/RTO awareness—a nightly backup doesn't help if your RPO is 2 hours or your RTO requires recovery in 30 minutes.

### Mistake 4: Ignoring Encryption in Transit
**Wrong**: "Backups are backed up—encryption isn't needed."  
**Right**: Backup data traveling over networks or stored on portable media needs encryption; a stolen backup drive = data breach.  
**Impact on Exam**: Expect questions on compliance (HIPAA, PCI-DSS require encrypted backups). Unencrypted backups = failed audit.

### Mistake 5: Never Testing Restoration
**Wrong**: "If the backup software says it succeeded, we're fine."  
**Right**: Software can create valid-looking backups of corrupted data. Actual restore tests in a test environment confirm usability.  
**Impact on Exam**: A+ tests disaster recovery mindset—the exam may describe a scenario where "backups ran successfully but restore failed"—you must identify testing as the solution.

---

## Related Topics
- [[Disaster Recovery Planning]]
- [[Recovery Point Objective (RPO)]]
- [[Recovery Time Objective (RTO)]]
- [[RAID and Redundancy]]
- [[Cloud Storage Solutions]]
- [[Encryption Standards]]
- [[Compliance and Data Protection Regulations]]
- [[Network Storage (NAS)]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*