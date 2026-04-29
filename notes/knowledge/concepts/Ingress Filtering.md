# Ingress Filtering

## What it is
Like a bouncer checking IDs at the door — if your ticket says you're from the VIP lounge but you're trying to enter through the back alley, you're not getting in. Ingress filtering is a network security practice where routers and firewalls inspect incoming packets and drop any that claim a source IP address that couldn't legitimately arrive on that interface. It enforces the basic rule: *if that address isn't reachable through this port, the packet is lying.*

## Why it matters
IP spoofing is the engine behind volumetric DDoS amplification attacks — an attacker spoofs a victim's IP address, sends small DNS or NTP requests to open resolvers, and the massive responses flood the victim. If ISPs and network operators universally applied ingress filtering at their borders (as specified in BCP 38), the attacker's forged packets would be dropped before they ever reach the amplifier, making this entire attack class nearly impossible to execute.

## Key facts
- Defined in **RFC 2827 / BCP 38** ("Network Ingress Filtering: Defeating Denial of Service Attacks which employ IP Source Address Spoofing")
- Implemented via **Unicast Reverse Path Forwarding (uRPF)** on Cisco and similar routers — the router checks if the source IP is reachable via the interface the packet arrived on
- Two uRPF modes: **strict mode** (source must be reachable via *that exact* interface) vs. **loose mode** (source must exist somewhere in the routing table)
- Ingress filtering is a *network-layer* control; it does not inspect payload content — it is not a firewall or IDS replacement
- Adoption remains incomplete globally, which is why IP spoofing-based attacks (Smurf, DNS amplification, NTP amplification) remain viable threats

## Related concepts
[[BCP 38]] [[IP Spoofing]] [[DDoS Amplification Attacks]] [[Unicast Reverse Path Forwarding]] [[Egress Filtering]]