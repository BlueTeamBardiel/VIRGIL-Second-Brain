# Redundancy

## What it is
Like a commercial airliner with three hydraulic systems so that losing one doesn't end the flight, redundancy means duplicating critical components so a single failure doesn't bring down the whole system. Precisely: redundancy is the practice of providing backup systems, data copies, or network paths that automatically take over when a primary element fails, maintaining availability without human intervention.

## Why it matters
In 2021, a misconfigured BGP route change at Facebook took down all their services for roughly six hours — in part because the engineers who needed to fix it remotely couldn't reach the systems, and physical access controls created a single point of failure in the recovery process. Proper redundancy — geographically distributed control planes, out-of-band management networks — would have preserved a recovery path even after the primary infrastructure collapsed.

## Key facts
- **RAID** (Redundant Array of Independent Disks) is storage redundancy: RAID 1 mirrors data, RAID 5 uses parity across three or more drives — know which levels tolerate how many disk failures.
- **High Availability (HA)** clusters use redundancy to achieve defined uptime targets (e.g., "five nines" = 99.999% uptime ≈ 5 minutes downtime/year).
- **Geographic redundancy** (hot/warm/cold sites) protects against site-level disasters; a **hot site** is fully operational and mirrors production in near-real time.
- Redundancy directly addresses the **Availability** pillar of the CIA triad and is a core component of Business Continuity Planning (BCP).
- **Power redundancy** via dual PSUs, UPS units, and generator backup is a physical-layer control tested on Security+ under facilities security.

## Related concepts
[[High Availability]] [[Fault Tolerance]] [[RAID]] [[Business Continuity Planning]] [[Single Point of Failure]]