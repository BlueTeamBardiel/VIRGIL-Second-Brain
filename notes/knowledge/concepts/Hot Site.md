# Hot Site

## What it is
Think of a hot site like a stunt double standing just offstage in full costume, ready to step in the moment the lead actor collapses — no rehearsal needed. A hot site is a fully operational, redundant data center maintained by an organization that mirrors its primary site in real time, with live data replication, identical hardware, and running systems that can assume operations within minutes of a disaster.

## Why it matters
When a ransomware attack encrypts every system at a hospital's primary data center, a hot site means patient records and critical care systems fail over automatically — potentially within minutes — rather than days. Without it, clinical staff revert to paper processes, medication errors spike, and lives are at risk. The 2020 Universal Health Services ransomware attack forced dozens of U.S. hospitals offline for weeks precisely because recovery infrastructure wasn't sufficiently warm.

## Key facts
- **RTO (Recovery Time Objective)** for a hot site is measured in **minutes**, making it the most expensive but fastest recovery option.
- Hot sites maintain **real-time or near-real-time data synchronization**, meaning **RPO (Recovery Point Objective)** approaches zero — minimal data loss.
- Cost is the primary tradeoff: organizations essentially pay for **two full production environments** simultaneously.
- Contrast with a **warm site** (hardware ready, data partially current, hours to activate) and a **cold site** (empty space, days to weeks to spin up).
- Hot sites are commonly tested via **failover exercises** to verify seamless transition — an untested hot site is a liability, not an asset.

## Related concepts
[[Business Continuity Plan]] [[Disaster Recovery Plan]] [[Recovery Time Objective]] [[Warm Site]] [[Data Replication]]