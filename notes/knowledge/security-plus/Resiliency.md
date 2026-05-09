# Resiliency

## What it is

In DayZ, your camp burns down because a server restart desyncs your tent and a stranger with a hatchet finds the coordinates. The player who survives isn't the one with the best loot — it's the one who stashed three barrels across two map regions, kept a backup base, and assumed Chernarus would betray him by Tuesday. That's exactly what **resiliency** does — it's the assumption that your systems will fail, and the architecture that ensures they keep functioning anyway.

**Resiliency** is the ability of a system, service, or architecture to absorb disruption — failure, attack, disaster, or load — and continue operating at an acceptable level, recovering to full function within defined time and data loss thresholds.

## Why it matters

When resiliency fails, the business stops. Outages cost revenue, SLAs trigger penalties, and ransomware turns "inconvenience" into "extinction event" if backups are also encrypted. CompTIA SY0-701 Objective **3.4** explicitly lists *high availability*, *site considerations*, *platform diversity*, *multi-cloud systems*, *continuity of operations*, *capacity planning*, *testing*, *backups*, and *power* — and the trap they like to set is conflating **high availability** (uptime) with **fault tolerance** (surviving component failure) with **disaster recovery** (rebuilding after catastrophe). They're related; they are not synonyms.

## Key facts

### High availability building blocks

- **[[Load balancing]]** — distributes traffic across nodes; survives single-node death and smooths spikes.
- **[[Clustering]]** — multiple nodes act as one logical service; active-active or active-passive.
- **[[Redundancy]]** — duplicate components (NICs, PSUs, drives, links) so one failure doesn't end the show.
- **[[Fault tolerance]]** — system continues operating *during* component failure, not after recovery.

### Site considerations

| Site type | Cost | Recovery time | What's there |
|---|---|---|---|
| **[[Hot site]]** | Highest | Minutes | Fully provisioned, real-time data sync |
| **[[Warm site]]** | Medium | Hours to a day | Hardware ready, data is stale |
| **[[Cold site]]** | Lowest | Days to weeks | Empty room with power and a prayer |
| **[[Geographic dispersion]]** | Varies | — | Sites separated enough to survive regional disasters |

### Platform diversity & multi-cloud

- **[[Platform diversity]]** — avoid monoculture; if one vendor's zero-day drops, the other half of your stack still runs.
- **[[Multi-cloud systems]]** — workloads spread across AWS, Azure, GCP to survive a single provider's outage or pricing whim.

### Backups — the topic CompTIA loves

| Backup type | What it copies | Restore complexity |
|---|---|---|
| **Full** | Everything | One tape/snapshot |
| **Incremental** | Changes since last backup of any kind | Full + every incremental in order |
| **Differential** | Changes since last full | Full + latest differential |
| **Snapshot** | Point-in-time block/file state | Fast, often local |
| **Replication** | Continuous copy to another system | Near-zero RPO |

Key adjacent terms: **[[Onsite vs offsite backups]]**, **[[Encryption of backups]]**, **[[Air-gapped backups]]** (immune to ransomware lateral encryption), **[[Backup frequency]]**, and the **3-2-1 rule** (3 copies, 2 media types, 1 offsite).

### Recovery objectives

- **[[RTO]]** (Recovery Time Objective) — how long until service is back.
- **[[RPO]]** (Recovery Point Objective) — how much data loss is tolerable.
- **[[MTTR]]** (Mean Time To Repair) and **[[MTBF]]** (Mean Time Between Failures) — reliability math.

### Power

- **[[UPS]]** — battery, rides out brief outages and clean shutdowns.
- **[[Generator]]** — diesel or natural gas, takes over for sustained outages.
- **[[PDU]]** — managed power distribution; redundant feeds (A/B power) prevent single-circuit failure.
- **[[Dual power supplies]]** — server-level redundancy on separate circuits.

### Capacity planning

Plan for **people**, **technology**, and **infrastructure**. Under-provisioning collapses under load (a denial-of-service of your own making); over-provisioning bleeds money. Forecasts must account for growth, seasonality, and disaster surge.

### Testing — backups you haven't restored aren't backups

- **[[Tabletop exercise]]** — discussion-based walkthrough.
- **[[Simulation]]** — scripted scenario, no production impact.
- **[[Parallel processing]]** — recovery site runs alongside production.
- **[[Failover test]]** — actually flip to the secondary; the only test that proves anything.

### Continuity of operations (COOP)

Documented plan for how the business keeps running when primary systems are gone — manual procedures, alternate communications, designated successors. The **[[BCP]]** (Business Continuity Plan) is the strategic doc; the **[[DRP]]** (Disaster Recovery Plan) is the technical playbook.

## Related concepts

[[High availability]] · [[Fault tolerance]] · [[Disaster recovery]] · [[Business continuity]] · [[Load balancing]] · [[RAID]] · [[Backups]] · [[Air gap]] · [[RTO]] · [[RPO]] · [[Capacity planning]] · [[Geographic dispersion]] · [[Multi-cloud systems]] · [[UPS]]

---
*Source: VIRGIL knowledge base — 2026-05-08*