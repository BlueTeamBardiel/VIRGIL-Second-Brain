# Database Clustering

## What it is
Think of database clustering like a team of waiters sharing the same menu — if one drops their tray, the others keep serving. Precisely, database clustering links multiple database server instances to work as a single logical unit, sharing workload and providing redundancy so that if one node fails, others seamlessly absorb its traffic. This architecture underpins high-availability systems where downtime is unacceptable.

## Why it matters
During a ransomware attack targeting a hospital's primary database server, a properly configured cluster automatically fails over to a replica node within seconds, keeping patient records accessible while the incident is contained. Conversely, attackers who understand cluster topology can target the shared storage layer or replication traffic — a single poisoned write propagates to every node simultaneously, making recovery harder than with isolated servers. This is why securing inter-node replication channels with mutual TLS is a critical defensive control.

## Key facts
- **High Availability (HA)** is the primary security benefit — clusters reduce single points of failure, directly supporting the **Availability** pillar of the CIA triad
- Cluster replication traffic is a high-value attack surface; unencrypted replication channels can expose full database contents to man-in-the-middle interception
- **Split-brain scenarios** occur when cluster nodes lose communication and each believes it is the primary — this can cause data inconsistency and is exploitable to cause data corruption
- Active-passive clusters maintain one hot standby; active-active clusters distribute load across all nodes — both configurations appear in Business Continuity Planning (BCP) exam questions
- Clustering does NOT replace backups — a malicious DELETE propagates to all nodes instantly, making point-in-time recovery essential alongside clustering

## Related concepts
[[High Availability]] [[Failover]] [[Database Replication]] [[Business Continuity Planning]] [[Defense in Depth]]