# Wide Area Network

## What it is
Think of a WAN like the interstate highway system connecting cities — your local street (LAN) gets you around the neighborhood, but the highway connects Denver to Dallas. A Wide Area Network is a telecommunications network spanning large geographic areas, connecting multiple LANs across cities, countries, or continents, typically using leased lines, MPLS, or public internet infrastructure.

## Why it matters
In 2015, attackers targeting Ukrainian power grid operators exploited WAN connections between corporate offices and industrial control systems — lateral movement across the WAN allowed them to reach SCADA systems and cut power to 230,000 customers. Defenders must treat WAN links as untrusted boundaries, enforcing encryption (IPSec/VPN tunnels) and strict access controls at every WAN-facing edge device.

## Key facts
- WANs typically use technologies like **MPLS, SD-WAN, leased T1/T3 lines, or encrypted VPN tunnels** over public internet
- The **internet itself is the world's largest WAN** — a critical distinction when scoping network security boundaries
- **SD-WAN** introduces software-defined control over WAN routing, expanding attack surface through centralized controllers that become high-value targets
- WAN links are a primary location for **man-in-the-middle attacks** — traffic traversing public carriers should always be encrypted at Layer 3 (IPSec) or above
- For Security+: WANs operate at **OSI Layers 1–3**, and WAN security controls typically include **firewalls at the perimeter, DMZs, and dedicated WAN optimization appliances**

## Related concepts
[[VPN]] [[MPLS]] [[SD-WAN]] [[Network Segmentation]] [[Man-in-the-Middle Attack]]