# Network Infrastructure

## What it is
Like the plumbing, electrical wiring, and load-bearing walls of a building, network infrastructure is the hidden skeleton that everything else depends on — damage it and the whole structure collapses. Precisely, it encompasses the physical and logical components — routers, switches, firewalls, cabling, protocols, and addressing schemes — that enable data to flow between systems. It is the foundational layer upon which all other services, applications, and security controls are built.

## Why it matters
In 2021, attackers compromised a water treatment facility in Oldsmar, Florida by exploiting remote access tools connected directly to operational network infrastructure with no segmentation between IT and OT systems. An attacker raised sodium hydroxide levels to dangerous concentrations before a vigilant operator caught it manually. Proper network segmentation — an infrastructure-level control — would have isolated the industrial control systems and blocked lateral movement entirely.

## Key facts
- **Routers** operate at Layer 3 (Network) and make forwarding decisions based on IP addresses; **switches** operate at Layer 2 (Data Link) using MAC addresses
- **DMZ (Demilitarized Zone)** is an infrastructure design pattern that places public-facing servers between two firewalls, limiting exposure of the internal network
- **VLAN (Virtual LAN)** logically segments a physical network, reducing broadcast domains and limiting lateral movement without requiring separate physical hardware
- **BGP (Border Gateway Protocol)** is the routing protocol of the internet; BGP hijacking — advertising false routes — can redirect global traffic through malicious autonomous systems
- Network infrastructure attacks often target **availability** (the A in CIA triad) through DDoS, making redundancy and failover design critical security considerations

## Related concepts
[[Network Segmentation]] [[Firewall]] [[Defense in Depth]] [[DMZ]] [[VLANs]]