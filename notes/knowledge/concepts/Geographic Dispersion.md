# Geographic Dispersion

## What it is
Like a chess grandmaster who never keeps all their pieces on one side of the board, geographic dispersion means spreading critical systems, data, and infrastructure across physically separate locations. Precisely: it is the practice of distributing redundant IT resources across different geographic regions so that a single localized disaster — flood, power outage, attack — cannot simultaneously destroy all copies.

## Why it matters
In 2012, Hurricane Sandy knocked out power to data centers along the U.S. Eastern Seaboard, taking down major websites whose operators had consolidated infrastructure in a single region. Organizations with geographically dispersed backups in the Midwest or West Coast remained operational within minutes, while single-site organizations faced days of downtime — demonstrating that physical separation is a direct business continuity multiplier.

## Key facts
- Geographic dispersion is a core component of **Business Continuity Planning (BCP)** and **Disaster Recovery (DR)** strategy, directly supporting RTO and RPO objectives
- NIST SP 800-34 recommends that alternate processing sites be far enough apart to avoid sharing the same regional disaster risk (typically 100+ miles separation)
- Three site tiers exist: **hot site** (fully operational, near-instant failover), **warm site** (partially configured, hours to activate), **cold site** (empty infrastructure, days to activate)
- Geographic dispersion addresses **availability** — the "A" in the CIA triad — protecting against natural disasters, regional power failures, and physical attacks
- Cloud providers use **Availability Zones (AZs)** and **Regions** to implement geographic dispersion; deploying across multiple AZs is considered minimum best practice for high-availability workloads

## Related concepts
[[Business Continuity Planning]] [[Disaster Recovery]] [[High Availability]] [[Redundancy]] [[Data Replication]]