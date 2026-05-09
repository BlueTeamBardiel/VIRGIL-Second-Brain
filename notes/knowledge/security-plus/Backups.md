# Backups

## What it is

In *Ocarina of Time*, you save your file at the Temple of Time before walking into Ganon's castle, because you know one of you isn't walking back out. That's exactly what backups do — they're a known-good copy of your data you can restore to when the present timeline goes sideways.

A **backup** is a redundant copy of system data, configuration, or state, stored separately from the original, used to restore operations after loss, corruption, ransomware, or hardware failure.

## Why it matters

Without working backups, ransomware isn't an inconvenience — it's an extinction event. The 2021 Colonial Pipeline payout, the 2017 NotPetya wipeout of Maersk, and every small business that quietly disappears after a CryptoLocker hit share one cause: backups that were missing, untested, or encrypted along with everything else. SY0-701 Objective 3.4 specifically lists backups under resilience and recovery — expect questions on **frequency**, **encryption**, **replication vs. snapshots**, **on-site vs. off-site**, and the trap CompTIA loves: confusing **journaling** with **backup** or assuming **RAID** counts as a backup. It does not.

## Key facts

### Backup types

| Type | What it copies | Restore speed | Backup speed | Storage cost |
|---|---|---|---|---|
| **Full** | Everything | Fastest (1 set) | Slowest | Highest |
| **Incremental** | Changes since last backup of any kind | Slowest (full + every increment) | Fastest | Lowest |
| **Differential** | Changes since last full | Medium (full + 1 differential) | Medium | Medium |
| **Snapshot** | Point-in-time block/file state | Near-instant | Near-instant | Low (delta-based) |

### The 3-2-1 rule

- **3** copies of data
- **2** different media types
- **1** copy off-site (or **air-gapped**, immune to network-borne ransomware)

Some shops now teach **3-2-1-1-0**: add one **immutable** copy and zero verified errors after testing.

### Storage and location

- **[[On-site backup]]** — fast restore, vulnerable to fire, flood, and the same ransomware that hit production.
- **[[Off-site backup]]** — geographic separation; slower restore, survives site-level disasters.
- **[[Cloud backup]]** — provider-hosted (AWS S3, Azure Backup); shifts the storage problem, not the responsibility.
- **[[Air-gapped backup]]** — physically disconnected; the gold standard against ransomware.
- **[[Offline backup]]** — tape, removable drives; slow but unreachable from a compromised network.

### Critical properties

- **[[Encryption]]** — backups must be encrypted at rest (AES-256) and in transit (TLS). A stolen backup tape is a stolen database.
- **[[Immutability]]** — write-once, read-many (WORM) storage. Ransomware can't encrypt what it can't overwrite. Common in object lock features (S3 Object Lock, Azure immutable blobs).
- **[[Replication]]** — continuous or near-real-time copying to a secondary site. Note: replication faithfully copies corruption and ransomware too. Replication is **not** a backup.
- **[[Journaling]]** — filesystem-level transaction log; aids recovery from crashes, not from attackers.
- **[[Snapshot]]** — point-in-time reference; cheap and fast but typically lives on the same storage as the source.

### Recovery metrics (the ones CompTIA will ask about)

- **[[RPO]]** (Recovery Point Objective) — how much data you can afford to lose, measured in time. Drives backup **frequency**.
- **[[RTO]]** (Recovery Time Objective) — how long you can be down. Drives backup **architecture** (hot site, warm site, cold site).
- **[[MTTR]]** — mean time to repair/restore.
- **[[MTBF]]** — mean time between failures.

### Testing

An untested backup is a rumor. Standard practice:
- **Restore drills** on a non-production system, scheduled.
- **Integrity verification** via hashes/checksums.
- **Tabletop exercises** for the recovery process itself.

The CompTIA trap: a candidate sees "we back up nightly to a NAS in the same room" and is asked what's wrong. Answer: no off-site, no immutability, no testing implied, and the NAS shares fate with the servers.

### Related backup concepts

- **[[Backup frequency]]** — daily, hourly, continuous (CDP — Continuous Data Protection).
- **[[Retention policy]]** — how long copies are kept; balances cost, compliance, and legal hold.
- **[[Cold site]]** / **[[Warm site]]** / **[[Hot site]]** — recovery facility readiness tiers.

## Related concepts

[[Disaster recovery]] · [[Business continuity]] · [[Ransomware]] · [[RAID]] · [[High availability]] · [[Replication]] · [[Immutability]] · [[RPO]] · [[RTO]] · [[Air gap]] · [[Encryption at rest]]

---
*Source: VIRGIL knowledge base — 2026-05-08*