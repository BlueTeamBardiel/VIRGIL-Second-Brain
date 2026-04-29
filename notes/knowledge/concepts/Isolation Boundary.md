# Isolation Boundary

## What it is
Like a fireproof door in a hospital that prevents a blaze in one wing from consuming the entire building, an isolation boundary is a deliberate enforcement point that prevents compromise or activity in one security domain from spreading into another. Technically, it is a logical or physical demarcation enforced by hardware, software, or policy that restricts communication, resource sharing, and privilege escalation between two distinct security zones.

## Why it matters
In the 2017 NotPetya attack, the malware devastated organizations precisely because internal isolation boundaries were absent — once inside the network, the worm moved laterally without friction, encrypting systems across entire enterprises in hours. A properly enforced isolation boundary between IT and OT networks, or between business units, would have contained the blast radius significantly.

## Key facts
- Isolation boundaries are a foundational principle behind **network segmentation**, **sandboxing**, **containerization**, and **hypervisor separation** — all enforce different flavors of the same idea
- A **hypervisor** creates an isolation boundary between guest VMs; a **breakout exploit** (e.g., VM escape) is specifically an attack that defeats this boundary
- **Zero Trust Architecture** treats every boundary crossing as untrusted, requiring re-authentication and re-authorization rather than assuming internal trust
- Isolation boundaries are evaluated in terms of **strength** (how hard they are to cross) and **completeness** (whether all data flows are covered — covert channels exploit gaps)
- **Air gaps** represent the most extreme isolation boundary, severing all electronic connections; however, attacks like Stuxnet demonstrated that even air gaps can be defeated via physical media (USB)

## Related concepts
[[Network Segmentation]] [[Sandbox Execution]] [[Defense in Depth]] [[Zero Trust Architecture]] [[VM Escape]]