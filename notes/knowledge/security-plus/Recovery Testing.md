# Recovery Testing

## What it is

In Battlefield, before a major operation drop you don't just *assume* the squad knows how to revive teammates with the defibrillator — you run a practice round on Conquest, watch someone get downed, and confirm the medic actually shocks them back up before the objective tickets bleed out. That's exactly what recovery testing does — it rehearses your backup and disaster recovery procedures *before* the real outage to confirm they actually work.

Recovery testing is the structured validation of backup integrity, restoration procedures, and disaster recovery plans to verify that systems, data, and operations can be restored within defined RTO and RPO targets.

## Why it matters

Untested backups are folklore. Organizations routinely discover during a real incident that their tapes are corrupt, their snapshots reference deleted volumes, their runbooks list employees who left in 2019, or the restore takes 40 hours when the RTO promised four. Ransomware response, regulatory audits (HIPAA, PCI-DSS, SOX), and business continuity all collapse without proven recovery.

**Exam angle:** SY0-701 Objective 3.4 explicitly lists *capacity planning, testing, and recovery testing* under resilience and recovery. CompTIA's favorite trap is conflating the test *types* — they will hand you a scenario ("the team gathered in a conference room and walked through the DR plan verbally") and expect you to label it correctly (tabletop, not simulation). Memorize the five testing types and what each one actually does.

## Key facts

### The five recovery test types (know these cold)

| Test Type | What happens | Disruption | Cost |
|---|---|---|---|
| **[[Tabletop Exercise]]** | Team verbally walks through the plan in a meeting | None | Lowest |
| **[[Walkthrough]]** | Step-by-step review of documented procedures, often with role assignments | None | Low |
| **[[Simulation]]** | Mock disaster scenario; teams respond as if real, but production untouched | Minimal | Medium |
| **[[Parallel Test]]** | Recovery systems brought up alongside production; both run; outputs compared | Low (production keeps running) | High |
| **[[Full Interruption Test]]** | Production is actually shut down and failed over to recovery site | Maximum | Highest |

CompTIA loves the **parallel vs. full interruption** distinction. Parallel = production stays up. Full interruption = production goes *down* on purpose. The latter is the most realistic and the most terrifying to executives.

### What recovery testing validates

- **[[Backup]] integrity** — the bits on the tape/snapshot are actually readable
- **[[Restoration]] procedures** — the runbook works as written
- **[[RTO]] (Recovery Time Objective)** — how fast you can restore
- **[[RPO]] (Recovery Point Objective)** — how much data loss is acceptable
- **[[MTTR]] (Mean Time To Restore)** — measured average recovery time
- **Personnel readiness** — staff know their roles
- **Dependencies** — DNS, AD, certificates, licensing servers come back in correct order

### Backup-specific testing

- **Restore test** — pull a file from backup and verify it opens
- **Bare-metal restore test** — rebuild a full system from scratch
- **[[Offsite Backup]] retrieval** — confirm you can actually get tapes back from Iron Mountain in time
- **[[Immutable Backup]] verification** — ensure ransomware-resistant copies exist and are recoverable

### Frequency expectations

- **Tabletop:** at least annually
- **Full DR test:** annually for most regulated industries
- **Backup restore sampling:** monthly or quarterly
- **After any major infrastructure change:** retest

### Common failure modes recovery testing exposes

- Backup jobs silently failing for months
- Encryption keys missing from the recovery environment
- Documentation referencing decommissioned servers
- Network segmentation blocking failover traffic
- Recovery site capacity insufficient for current production load ([[Capacity Planning]] gap)
- Runbook authors no longer employed

### Related plans recovery testing exercises

- **[[Disaster Recovery Plan]] (DRP)** — IT-focused restoration
- **[[Business Continuity Plan]] (BCP)** — keeping the business operating
- **[[Incident Response Plan]] (IRP)** — security event handling
- **[[Communications Plan]]** — who tells whom, when

## Related concepts

[[Disaster Recovery]] · [[Business Continuity]] · [[Backup]] · [[RTO]] · [[RPO]] · [[High Availability]] · [[Failover]] · [[Hot Site]] · [[Warm Site]] · [[Cold Site]] · [[Tabletop Exercise]] · [[Capacity Planning]] · [[Immutable Backup]]

---
*Source: VIRGIL knowledge base — 2026-05-08*