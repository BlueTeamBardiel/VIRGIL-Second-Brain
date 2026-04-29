# Data Center

## What it is
Think of a data center like a fortified library that never closes — thousands of servers are the books, the cooling systems are the climate control, and the physical security is the vault door. Precisely defined, a data center is a dedicated physical facility housing networked computing infrastructure (servers, storage, networking equipment) that provides centralized data processing, storage, and distribution services for an organization.

## Why it matters
In 2023, a misconfigured firewall rule in a colocation data center allowed lateral movement between tenant environments, exposing one company's database to a co-located competitor's compromised VM. This illustrates why multi-tenant data centers require strict network segmentation and why physical + logical security controls must operate together — a single gap in either layer can cascade into a full breach.

## Key facts
- **Tier classifications (I–IV)** define availability: Tier IV guarantees 99.995% uptime with fully fault-tolerant systems and is the benchmark for critical infrastructure security discussions.
- **Physical controls** include mantrap/airlock entries, biometric access, CCTV, and motion sensors — all testable Security+ domains under facility security.
- **Environmental controls** (HVAC, fire suppression via clean agent systems like FM-200, UPS, and generators) are security concerns because availability is a CIA Triad pillar.
- **Colocation (colo)** means multiple organizations share physical space; each is responsible for securing their own equipment while the facility manages physical perimeter security.
- **Hot/cold aisle containment** is a cooling strategy, but also affects physical access planning and unauthorized device insertion risks.

## Related concepts
[[Physical Security Controls]] [[Network Segmentation]] [[Availability (CIA Triad)]] [[Virtualization Security]] [[Business Continuity Planning]]