# BUM Traffic

## What it is
Like a postal worker who doesn't know which apartment a tenant lives in and shoves a flyer under *every* door in the building, BUM traffic describes frames that must be sent to all endpoints because the network doesn't know the precise destination. BUM stands for **Broadcast, Unknown unicast, and Multicast** — the three categories of traffic that cannot be forwarded to a single known destination in Layer 2 and VXLAN overlay networks. These frames are flooded across the fabric to all tunnel endpoints or segment members.

## Why it matters
In large-scale data center environments using VXLAN overlays, excessive BUM traffic is a vector for amplification and reconnaissance. An attacker inside a tenant segment can generate high volumes of ARP broadcasts or unknown unicast floods, saturating underlay bandwidth across all VTEP (VXLAN Tunnel Endpoint) nodes — effectively a low-cost internal DoS. Defenders mitigate this using ingress replication control, multicast underlay designs, or BGP EVPN, which suppresses ARP flooding by distributing MAC/IP bindings via the control plane.

## Key facts
- BUM = **Broadcast** (e.g., ARP requests), **Unknown unicast** (destination MAC not in forwarding table), **Multicast** (one-to-many group traffic)
- In VXLAN networks, BUM traffic is handled via **head-end replication** (ingress replication) or **underlay multicast groups**
- BGP EVPN is the primary control-plane solution that *eliminates* most BUM flooding by distributing MAC/IP information proactively
- Excessive BUM traffic is a sign of a **MAC table exhaustion attack** (CAM overflow), where an attacker floods the network with spoofed MACs, forcing unknown unicast flooding
- Reducing BUM traffic is a core design goal in **Zero Trust network segmentation** and multi-tenant cloud fabrics

## Related concepts
[[VXLAN]] [[CAM Table Overflow Attack]] [[BGP EVPN]] [[ARP Spoofing]] [[Network Segmentation]]