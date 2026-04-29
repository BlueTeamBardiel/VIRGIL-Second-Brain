# II. System & Network Architecture

## What it is
Like the blueprints of a building that determine where the walls, doors, and vaults are placed, system and network architecture defines how components are arranged, connected, and secured before a single user logs in. It is the deliberate design of hardware, software, and communication pathways that establishes the foundational security posture of an environment. Architecture decisions made early — segmentation, trust boundaries, data flows — echo through every vulnerability and defense that follows.

## Why it matters
In 2020, the SolarWinds attack succeeded partly because the compromised Orion platform was architecturally trusted with broad network access and outbound communication rights. A well-designed architecture practicing least-privilege network segmentation and restricting management plane traffic would have contained the blast radius significantly. Architecture is not just documentation — it is a primary control.

## Key facts
- **Defense-in-depth** requires layering controls across the architecture: perimeter, network, host, application, and data layers — no single layer is sufficient
- **Network segmentation** using VLANs, subnets, or microsegmentation limits lateral movement; a flat network is an attacker's playground
- **Zero Trust Architecture (ZTA)** eliminates implicit trust based on network location — every request is authenticated, authorized, and continuously validated
- **The OSI model** provides the reference framework for locating where attacks and controls operate (e.g., ARP spoofing = Layer 2; TLS = Layer 4-7)
- **Air-gapping** is the most extreme segmentation control, physically isolating systems from untrusted networks — used in ICS/SCADA and classified environments

## Related concepts
[[Defense in Depth]] [[Zero Trust Architecture]] [[Network Segmentation]] [[OSI Model]] [[Least Privilege]]