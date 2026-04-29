# disaster recovery plan

## What it is
Think of it as the fire drill script for your entire IT infrastructure — everyone knows their role *before* the smoke alarm sounds. A Disaster Recovery Plan (DRP) is a documented, tested set of procedures that enables an organization to restore critical IT systems and data after a disruptive event, such as a ransomware attack, hardware failure, or natural disaster. It is a subset of the broader Business Continuity Plan (BCP), focused specifically on technical recovery rather than overall business operations.

## Why it matters
In 2021, Colonial Pipeline paid $4.4 million in ransom after attackers encrypted their systems — the absence of a tested DRP meant they couldn't confidently restore operations, making payment feel like the only option. A well-exercised DRP with validated backups and defined recovery objectives would have given decision-makers a clear alternative path: isolate, restore from clean backup, and resume operations without negotiating with criminals.

## Key facts
- **RTO (Recovery Time Objective):** Maximum acceptable time a system can be down before business impact becomes critical.
- **RPO (Recovery Point Objective):** Maximum acceptable amount of data loss measured in time — e.g., "we can tolerate losing 4 hours of transactions."
- A DRP must be **regularly tested** via tabletop exercises, simulations, or full failover tests — an untested DRP is treated as non-existent for audit purposes.
- **Order of restoration** matters: prioritize life-safety systems, then authentication infrastructure (Active Directory), then critical business applications.
- DRPs must document **alternate site strategies**: hot site (fully operational), warm site (partially configured), or cold site (space only, longest RTO).

## Related concepts
[[business continuity plan]] [[recovery time objective]] [[backup and recovery]] [[incident response plan]] [[mean time to recover]]