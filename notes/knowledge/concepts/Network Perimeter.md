# Network Perimeter

## What it is
Like the walls and moat of a medieval castle, the network perimeter is the defended boundary separating an organization's internal, trusted network from the untrusted external internet. Precisely defined, it is the logical and physical boundary enforced by security controls — firewalls, DMZs, and access points — that governs what traffic enters and exits the organization. Everything inside is assumed trusted; everything outside is assumed hostile.

## Why it matters
In the 2013 Target breach, attackers pivoted from a third-party HVAC vendor's network connection directly into Target's internal systems — a textbook perimeter failure. The vendor had legitimate access through a gap in the perimeter, demonstrating that a perimeter-focused strategy collapses the moment a single trusted entry point is compromised. This is why modern security has shifted toward "assume breach" models like Zero Trust.

## Key facts
- The **DMZ (Demilitarized Zone)** is a network segment sitting between the external and internal network, hosting public-facing services (web servers, email) to limit exposure of the internal network.
- Traditional perimeter security relies heavily on **stateful firewalls**, which track connection state to allow return traffic while blocking unsolicited inbound packets.
- **Perimeter erosion** is a recognized phenomenon: cloud adoption, BYOD, and remote work have dissolved the clear inside/outside boundary.
- The **de-perimeterization** concept (coined by the Jericho Forum ~2004) predicted that perimeters would become unenforceable and pushed for identity-centric, data-centric security instead.
- Security+ expects you to know that **defense-in-depth** compensates for perimeter failures by adding internal controls (segmentation, endpoint protection, IDS/IPS) — never rely on the perimeter alone.

## Related concepts
[[Firewall]] [[DMZ]] [[Zero Trust Architecture]] [[Defense in Depth]] [[Network Segmentation]]