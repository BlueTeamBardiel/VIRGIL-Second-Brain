---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 074
source: rewritten
---

# Backups
**Your safety net against catastrophic data loss—understanding backup strategy is fundamental to organizational resilience.**

---

## Overview
Data loss happens. Whether through hardware failure, ransomware, or human error, organizations face situations where their primary data becomes inaccessible. [[Backups]] are your insurance policy—independent copies of critical information that allow you to restore operations quickly and completely. For Security+, backups represent a core pillar of [[business continuity]] and [[disaster recovery]], making them essential to any comprehensive security posture.

---

## Key Concepts

### Backup Strategy
**Analogy**: Think of backup strategy like insurance planning—you don't just buy a policy; you decide deductibles, coverage amounts, and where to store documents. Similarly, you can't just "do backups." You must intentionally architect them.

**Definition**: A comprehensive [[backup strategy]] encompasses all decisions about protecting your data: volume, frequency, technology, location, and restoration procedures.

| Decision Factor | Impact | Example |
|---|---|---|
| **Data Volume** | Storage requirements, cost, time | 500 GB vs. 50 TB |
| **Backup Frequency** | [[RPO]] (Recovery Point Objective), data loss window | Daily vs. hourly |
| **Media Type** | Speed, portability, lifespan | Tape, SSD, cloud |
| **Storage Location** | Accessibility, security risk | On-site, off-site, cloud |
| **Restoration Method** | [[RTO]] (Recovery Time Objective) | Automated failover vs. manual restore |

---

### Full Backup
**Analogy**: Like photocopying your entire filing cabinet—every single document, every page. Slow and storage-heavy, but you have everything.

**Definition**: A [[full backup]] captures every single file and folder in the designated system at a specific point in time, creating a complete snapshot requiring maximum storage space but enabling fastest restoration.

---

### Incremental Backup
**Analogy**: After the full photocopy, you only photocopy documents changed since yesterday. Much faster and cheaper, but you need yesterday's copies too.

**Definition**: An [[incremental backup]] copies only data that has changed since the last backup of any kind (full or incremental), creating a chain where each backup depends on all previous ones.

| Aspect | Full Backup | Incremental Backup |
|---|---|---|
| **Storage Used** | Highest | Lowest |
| **Backup Time** | Slowest | Fastest |
| **Restoration Time** | Fastest (single file) | Slowest (requires chain) |
| **Restore Complexity** | Simple | Complex—need all increments |

---

### Differential Backup
**Analogy**: You photocopy only what changed since the original full copy—no chain dependencies, but growing copies over time.

**Definition**: A [[differential backup]] captures all data modified since the last full backup only, creating independent backups that grow larger as time passes but require only two restore sources (full + latest differential).

| Aspect | Incremental | Differential |
|---|---|---|
| **Chain Dependency** | Yes—requires all prior increments | No—only needs full + latest |
| **Storage Over Time** | Stays small | Grows exponentially |
| **Restore Speed** | Slowest | Moderate |
| **Management Complexity** | Higher | Lower |

---

### Onsite vs. Offsite Backup Storage
**Analogy**: Keeping your backup hard drive in the same office is like storing your house deed in your house—convenient but lost in the same fire. Offsite is like a bank vault.

**Definition**: [[Onsite backups]] store recovery media in the same physical location as production systems, while [[offsite backups]] separate data to geographically distant locations, protecting against facility-level disasters.

| Storage Location | Advantages | Disadvantages |
|---|---|---|
| **Onsite** | Fast access, quick restoration | Vulnerable to same disaster (fire, flood) |
| **Offsite** | Protection from facility loss | Slower access, transport delays, cost |
| **Cloud** | Geographic redundancy built-in | Vendor dependency, bandwidth limits |

---

### Backup Media Types
**Analogy**: Choosing between tape, hard drives, and cloud is like choosing between a filing cabinet, a portable safe, or a bank vault—different trade-offs.

**Definition**: [[Backup media]] refers to the physical or logical storage destination holding your backup data, each with distinct characteristics around durability, speed, and cost.

| Media Type | Speed | Capacity | Cost | Lifespan | Best For |
|---|---|---|---|---|---|
| **Magnetic Tape** | Slow | Very high | Low | 10-30 years | Long-term archival |
| **Hard Drives** | Fast | High | Moderate | 5-10 years | Frequent restores |
| **SSDs** | Very fast | Moderate | High | 5-10 years | Performance-critical |
| **Cloud Storage** | Variable | Unlimited | Per-GB model | N/A | Scalability, disaster recovery |

---

### Backup Frequency & Scheduling
**Analogy**: Backing up once a year is like having fire insurance but never updating your home value—by year-end, you've lost an entire year of possessions.

**Definition**: [[Backup scheduling]] determines how often and when backups execute, directly controlling your [[RPO]]—the maximum acceptable data loss between backups.

**Key Relationship**: 
- Daily backups = 1-day maximum data loss
- Hourly backups = 1-hour maximum data loss
- Real-time replication = Near-zero data loss

---

### 3-2-1 Backup Rule
**Analogy**: Don't keep all your eggs in one basket, and don't keep all baskets in one warehouse.

**Definition**: The [[3-2-1 rule]] is a best-practice framework requiring **3 copies of data**, on **2 different media types**, with **1 copy stored offsite**.

**Example Configuration**:
- Copy 1: Production system (primary)
- Copy 2: Daily full backup on local hard drive
- Copy 3: Daily incremental to cloud storage (offsite)

---

### Recovery Point Objective (RPO)
**Analogy**: RPO is like asking "how much diary entry can I afford to lose?" If you back up daily, you lose at most one day's entries.

**Definition**: [[RPO]] measures the maximum tolerable data loss measured in time—the interval between backups. It directly dictates backup frequency.

**Example**: 
- RPO = 4 hours → backups required every 4 hours
- RPO = 24 hours → daily backups sufficient

---

### Recovery Time Objective (RTO)
**Analogy**: RTO is how long you can afford to be without your data. Can you wait 8 hours for restoration, or only 15 minutes?

**Definition**: [[RTO]] specifies the maximum acceptable downtime to restore a system to operational status. It influences whether you choose full backups (fast restore) or incremental (slower restore).

**Connection to Backup Type**:
- Tight RTO (1 hour) → Full backups + onsite storage
- Loose RTO (8 hours) → Incremental backups acceptable

---

## Exam Tips

### Question Type 1: Backup Type Selection
- *"Your organization requires restoring lost files within 2 hours. You currently perform full backups daily and incrementals every 6 hours. On Tuesday at 2 PM, data is lost. How many restore operations are needed?"* → 2 operations (Monday full + Tuesday incremental at 12 PM)
- **Trick**: Candidates forget that incremental chains require all prior backups—don't count just the latest one.

### Question Type 2: Storage Location Strategy
- *"A company wants geographic protection from facility disasters while maintaining fast local access. Which backup strategy best meets both goals?"* → Hybrid: onsite backups for speed + cloud backups for geographic redundancy
- **Trick**: Choosing "cloud only" sacrifices restore speed; choosing "onsite only" fails disaster protection.

### Question Type 3: RPO/RTO Matching
- *"Critical database RPO is 1 hour. Current schedule performs full backups daily with incrementals at 6-hour intervals. What must change?"* → Increase backup frequency to hourly incremental backups
- **Trick**: Candidates confuse RTO (time to restore) with RPO (data loss tolerance)—they require different solutions.

### Question Type 4: Media Selection
- *"An organization archives historical financial records required for 7-year regulatory retention. What backup media minimizes cost while meeting durability?"* → Magnetic tape
- **Trick**: Students pick cloud or hard drives, forgetting tape's decades-long lifespan and bulk-storage economics.

---

## Common Mistakes

### Mistake 1: Confusing Full/Incremental/Differential
**Wrong**: "Incremental backups are better than full backups because they're faster."
**Right**: Incremental backups are faster to *create* but slower to *restore* due to chain dependencies. Full backups restore fastest but consume most storage.
**Impact on Exam**: You'll misidentify appropriate backup types for different RPO/RTO requirements, failing scenario-based questions.

---

### Mistake 2: Ignoring Offsite Requirements
**Wrong**: "Storing backups in the server room with production systems is acceptable."
**Right**: Onsite-only backups fail protection against facility-level disasters (fire, flood, theft). Offsite storage is mandatory for [[business continuity]].
**Impact on Exam**: You'll select incomplete disaster recovery strategies, missing security principles.

---

### Mistake 3: Treating RPO & RTO Interchangeably
**Wrong**: "We need RTO of 4 hours, so backup every 4 hours."
**Right**: RPO (data loss window) and RTO (restoration time) are separate constraints. A 4-hour RPO requires hourly backups; a 4-hour RTO describes how fast you can restore—different solutions.
**Impact on Exam**: You'll propose mismatched backup schedules that don't actually meet stated recovery requirements.

---

### Mistake 4: Neglecting Restore Testing
**Wrong**: "Once we create backups, we're protected."
**Right**: Untested backups often fail during actual restoration due to corruption, format incompatibility, or software obsolescence. Regular [[restore drills]] validate backup integrity.
**Impact on Exam**: Scenario questions ask what happens when restoration fails—you need to know that testing prevents this.

---

### Mistake 5: Underestimating Cloud Complexity
**Wrong**: "Cloud backups eliminate all backup problems."
**Right**: Cloud introduces new concerns: vendor lock-in, bandwidth limitations, data residency regulations, and restore speed constraints that local media doesn't have.
**Impact on Exam**: You'll oversimplify cloud backup scenarios, missing regulatory or performance edge cases.

---

## Related Topics
- [[Business Continuity Planning]]
- [[Disaster Recovery]]
- [[Recovery Point Objective (RPO)]]
- [[Recovery Time Objective (RTO)]]
- [[Data Protection]]
- [[Ransomware Mitigation]]
- [[Storage Media]]
- [[Cloud Security]]
- [[Restore Procedures]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*