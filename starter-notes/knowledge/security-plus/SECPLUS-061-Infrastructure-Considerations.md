---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 061
source: rewritten
---

# Infrastructure Considerations
**Balancing system uptime with controlled access while planning for inevitable failures.**

---

## Overview
Infrastructure security demands more than just keeping systems running—it requires ensuring those systems remain accessible only to authorized users while maintaining the fastest possible recovery when problems occur. For Security+, understanding the tension between [[availability]], [[access control]], and [[disaster recovery]] is essential because exam questions frequently test your ability to design resilient systems that prioritize both performance and protection.

---

## Key Concepts

### Availability
**Analogy**: Think of a restaurant's hours of operation. Just like a restaurant being "open" means customers can walk in, [[availability]] in IT means authorized users can access resources when they need them. But a good restaurant also has a door that stays locked when it's closed—you don't want strangers walking in at 3 AM.

**Definition**: [[Availability]] is the characteristic of a system being operational and accessible to legitimate users whenever it's needed. In security contexts, this means resources must be functioning AND protected from unauthorized access simultaneously.

**Related terms**: [[Uptime]], [[High Availability (HA)]], [[Redundancy]]

| Concept | Focus | Security Angle |
|---------|-------|-----------------|
| IT Availability | System running 24/7 | How long is it accessible? |
| Security Availability | Authorized access only | Who can access it while it's up? |

Organizations measure availability using **uptime percentages**. Common targets include:
- **99.9%** (three nines) = ~8.7 hours downtime/year
- **99.99%** (four nines) = ~52 minutes downtime/year  
- **99.999%** (five nines) = ~5 minutes downtime/year

---

### Recovery Time Objective (RTO)
**Analogy**: Imagine a factory that catches fire. The [[RTO]] is how long management decides they can afford to be shut down before losing critical business. If they decide "we can lose 4 hours of production," that's their RTO.

**Definition**: [[RTO]] is the maximum acceptable length of time a system can remain offline after an outage before business impact becomes unacceptable. It's measured from when the failure occurs until full restoration.

**Key point**: RTO is a *business decision*, not a technical one.

---

### Recovery Point Objective (RPO)
**Analogy**: If you back up your phone every night at midnight, your [[RPO]] is 24 hours. If your phone crashes at 11:59 PM, you lose almost a full day of data.

**Definition**: [[RPO]] represents the maximum amount of data loss an organization can tolerate, measured as the time between backups or replication events. It defines how "fresh" your recovery data must be.

**Key point**: RPO determines backup frequency and replication strategy.

---

### Disaster Recovery (DR)
**Analogy**: Having a disaster recovery plan is like having a fire escape route—you hope never to use it, but you need to know exactly where it is and that it works before disaster strikes.

**Definition**: [[Disaster Recovery (DR)]] encompasses the processes, tools, and procedures needed to restore critical systems and data after a catastrophic failure. This includes identifying root causes and executing the appropriate fix.

**Recovery depends on root cause**:
- **Hardware failure** → Replace faulty equipment (may need hot-spare replacement)
- **Software bug** → Deploy patch or rollback to previous version
- **Redundant systems** → Failover to backup systems
- **Data corruption** → Restore from backup (limited by RPO)

---

### Mean Time to Recovery (MTTR)
**Analogy**: If your car breaks down, MTTR is the duration from when it stops running until the mechanic has it running again.

**Definition**: [[MTTR]] measures the average time required to restore a failed system to operational status, including diagnosis and repair time.

**Key consideration**: MTTR is difficult to predict because you must first identify the root cause before knowing how long repairs will take.

---

## Exam Tips

### Question Type 1: RTO vs. RPO Scenarios
- *"A financial services company experiences a database failure at 2 PM. Their RTO is 1 hour and RPO is 15 minutes. They restore from a backup taken at 1:00 PM. How much data was lost?"* → 1 hour of data (from 1:00 PM failure to 2:00 PM restoration window), but only 15 minutes is acceptable per RPO—this violates SLA.
- **Trick**: Students confuse RTO (time to restore) with RPO (data freshness). RTO = "how long can we be down?" RPO = "how fresh does our backup need to be?"

### Question Type 2: Root Cause and Recovery Method
- *"After an outage, you determine the cause was a failed hard drive in the primary database server. What is the fastest recovery method?"* → Failover to a hot-standby replica server (if available), then replace hardware.
- **Trick**: Don't assume backup restoration is fastest—redundant systems often recover faster than restoring from backups.

### Question Type 3: Availability Percentage Calculations
- *"What does 99.9% availability mean annually?"* → ~8 hours 45 minutes of acceptable downtime per year
- **Trick**: Memorize the "nines":
  - 99% = 3.65 days/year
  - 99.9% = 8.76 hours/year
  - 99.99% = 52.6 minutes/year
  - 99.999% = 5.26 minutes/year

---

## Common Mistakes

### Mistake 1: Confusing Availability with Uptime
**Wrong**: "Our system has 99.99% availability, so it's as secure as it is available."
**Right**: Availability measures *uptime only*. A system running 99.99% of the time is useless for security if an attacker has full access during those hours.
**Impact on Exam**: Security+ questions will test whether you understand that [[availability]] is a component of the [[CIA Triad]], not synonymous with it. You must balance uptime with [[confidentiality]] and [[integrity]].

### Mistake 2: Setting RTO Shorter Than Possible Recovery Time
**Wrong**: "Our RTO is 30 minutes, so we can recover from a hardware failure in 30 minutes."
**Right**: RTO should be set based on realistic recovery capabilities. If your fastest recovery method (failover) takes 5 minutes but hardware replacement takes 2 hours, your actual RTO is determined by which failure scenarios you're planning for.
**Impact on Exam**: Expect scenario questions asking whether an RTO goal is realistic given the infrastructure in place.

### Mistake 3: Assuming All Data Loss Violates SLA
**Wrong**: "Any data loss means we failed our recovery objective."
**Right**: RPO *defines acceptable data loss*. A 1-hour RPO means losing up to 1 hour of data is within acceptable parameters.
**Impact on Exam**: Questions will present outages where some data loss occurred and ask whether SLAs were met—the answer depends on comparing actual data loss to RPO, not whether loss occurred at all.

### Mistake 4: Treating RTO and MTTR as Interchangeable
**Wrong**: "Our MTTR is 2 hours, so our RTO must be 2 hours."
**Right**: [[MTTR]] is what *actually happens* (average repair time). [[RTO]] is what the *business needs* to happen. Your MTTR might be 4 hours, but your RTO requirement might be 1 hour—creating a gap you need to address with redundancy.
**Impact on Exam**: Security+ will test whether you can identify when MTTR exceeds RTO and recommend solutions (hot-standby systems, load balancing, etc.).

---

## Related Topics
- [[CIA Triad]] (Availability as core pillar)
- [[Redundancy and Failover]]
- [[Backup and Recovery Strategies]]
- [[Service Level Agreements (SLA)]]
- [[Business Continuity Planning (BCP)]]
- [[Maximum Tolerable Downtime (MTD)]]
- [[Incident Response]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*