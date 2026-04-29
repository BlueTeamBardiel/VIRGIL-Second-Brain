# Disaster Recovery

## What it is
Like a hospital's emergency generator that kicks on the moment the power grid fails, Disaster Recovery (DR) is the pre-planned process of restoring IT systems, data, and operations after a disruptive event. It is the technical and procedural subset of Business Continuity Planning (BCP) focused specifically on getting systems back online after incidents like ransomware attacks, hardware failures, or natural disasters.

## Why it matters
In 2021, Colonial Pipeline paid a $4.4 million ransom partly because their DR plan was insufficient to restore operations quickly enough to avoid fuel shortages across the Eastern U.S. A well-tested DR plan with clean, offline backups would have allowed restoration without paying the attackers, making backup integrity and recovery time objectives existential business concerns, not just IT checkbox items.

## Key facts
- **RTO (Recovery Time Objective)** — the maximum acceptable downtime before restoration must occur; e.g., "systems must be back online within 4 hours"
- **RPO (Recovery Point Objective)** — the maximum acceptable data loss measured in time; e.g., "we can tolerate losing no more than 1 hour of transactions"
- **DR site types**: Hot site (fully operational, immediate failover), Warm site (partially configured, hours to activate), Cold site (empty facility, days to activate)
- **Backup rule 3-2-1**: 3 copies of data, on 2 different media types, with 1 copy stored offsite or offline — critical for ransomware resilience
- DR plans must be **tested regularly** via tabletop exercises, simulation drills, or full failover tests — an untested DR plan is not a DR plan

## Related concepts
[[Business Continuity Planning]] [[Backup Strategies]] [[Incident Response]] [[Fault Tolerance]]