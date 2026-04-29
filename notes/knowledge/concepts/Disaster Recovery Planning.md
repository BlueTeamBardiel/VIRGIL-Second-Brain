# Disaster Recovery Planning

## What it is
Think of it as a fire drill for your entire IT infrastructure — practiced before the smoke appears, not during the blaze. Disaster Recovery Planning (DRP) is the documented, tested process for restoring IT systems, applications, and data to operational status after a disruptive event such as ransomware, natural disaster, or hardware failure. It is a subset of Business Continuity Planning (BCP), focused specifically on technology recovery rather than broad organizational survival.

## Why it matters
In 2021, Colonial Pipeline paid $4.4 million in ransom after a ransomware attack halted fuel distribution across the U.S. East Coast. A well-exercised DRP with tested offline backups and defined Recovery Time Objectives (RTOs) could have restored operations without capitulating to attackers — the absence of one turned a technical incident into a national infrastructure crisis.

## Key facts
- **RTO (Recovery Time Objective):** Maximum acceptable downtime before business impact becomes critical — e.g., "systems must be restored within 4 hours."
- **RPO (Recovery Point Objective):** Maximum acceptable data loss measured in time — e.g., "we can tolerate losing no more than 1 hour of transactions."
- **DRP vs. BCP:** DRP is IT-focused recovery; BCP is the broader organizational continuity strategy that *contains* the DRP.
- **Testing types matter:** Tabletop exercises (discussion-based), parallel testing (running backup systems alongside live), and full cutover tests (live failover) are all distinct — and Security+ expects you to know the difference.
- **Backup strategies follow the 3-2-1 rule:** 3 copies of data, on 2 different media types, with 1 stored offsite (increasingly, 1 copy air-gapped or immutable).

## Related concepts
[[Business Continuity Planning]] [[Backup and Recovery Strategies]] [[Incident Response Planning]]