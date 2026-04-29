# redundant systems

## What it is
Like a commercial airplane with two engines — if one fails mid-flight, the other keeps you from falling out of the sky. Redundant systems are duplicate components (hardware, software, or data paths) designed to maintain availability when a primary component fails, whether due to attack, accident, or hardware fault.

## Why it matters
During a DDoS attack against a financial institution, attackers flooded the primary data center with traffic until it became unresponsive. Because the organization had configured redundant systems across geographically separated data centers with automatic failover, legitimate transactions continued routing through the secondary site with only seconds of disruption — turning a potential catastrophe into a minor incident.

## Key facts
- **RAID (Redundant Array of Independent Disks)** is a foundational redundancy technology; RAID-1 mirrors data across drives, RAID-5 uses parity striping — both protect against single-drive failure
- **High Availability (HA) clusters** use redundant nodes so that if one server fails, another takes over automatically, targeting near-zero downtime (often measured as "nines" — 99.999% uptime = ~5 minutes downtime/year)
- Redundancy supports the **Availability** pillar of the CIA triad and is a core control in both BCP (Business Continuity Planning) and DRP (Disaster Recovery Planning)
- **Single Points of Failure (SPOF)** are the enemy of redundancy — identifying and eliminating SPOFs is a primary goal of redundancy design
- **Geographic redundancy** (hot/warm/cold sites) protects against site-level disasters; a **hot site** is fully operational and can take over in minutes, while a **cold site** requires significant setup time

## Related concepts
[[high availability]] [[fault tolerance]] [[RAID]] [[disaster recovery]] [[single point of failure]]