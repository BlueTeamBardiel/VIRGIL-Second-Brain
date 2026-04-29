# Redundant Infrastructure

## What it is
Like a commercial airplane with two engines where either one alone can land the plane safely, redundant infrastructure duplicates critical systems so that if one component fails — whether from attack, hardware fault, or disaster — operations continue without interruption. Formally, it is the deployment of backup hardware, network paths, power systems, and data copies that can assume full functionality when primary components go offline.

## Why it matters
During the 2016 Dyn DNS DDoS attack, websites like Twitter and GitHub went dark for hours because Dyn was a single point of failure for their DNS resolution. Organizations that had configured secondary DNS providers across geographically distributed infrastructure remained reachable while competitors vanished — redundancy functioned as an active defense, not just a reliability measure.

## Key facts
- **RPO and RTO drive redundancy design**: Recovery Point Objective defines acceptable data loss; Recovery Time Objective defines acceptable downtime — both directly determine how much redundancy is required.
- **Geographic diversity** is essential; redundant servers in the same building sharing one power feed are still a single point of failure.
- **Active-active vs. active-passive**: Active-active runs all nodes simultaneously sharing load; active-passive keeps backups on standby — active-active offers better RTO but higher cost.
- **RAID is not backup**: RAID provides storage redundancy against drive failure but cannot protect against ransomware, accidental deletion, or site-level disasters.
- Redundant infrastructure is a core pillar of the **Availability** leg of the CIA Triad and is frequently tested on Security+ under business continuity and disaster recovery domains.

## Related concepts
[[High Availability]] [[Failover Clustering]] [[Disaster Recovery]] [[Business Continuity Planning]] [[Single Point of Failure]]