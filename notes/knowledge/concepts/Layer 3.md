# Layer 3

## What it is
Think of Layer 3 as the postal system's sorting hubs — they don't care about the specific letter contents or the local mail carrier, they just figure out *which city* the package routes through next. Precisely, Layer 3 is the **Network Layer** of the OSI model, responsible for logical addressing (IP addresses) and routing packets across different networks. It determines the best path from source to destination across interconnected systems.

## Why it matters
IP spoofing attacks operate entirely at Layer 3 — an attacker forges the source IP address in a packet header to impersonate a trusted host or obscure their origin, enabling amplification DDoS attacks like DNS reflection. Defenders counter this with ingress/egress filtering (BCP38), which instructs border routers to drop packets whose source IPs don't match the expected network range — a purely Layer 3 defense.

## Key facts
- **Primary protocol:** IPv4 and IPv6 handle addressing; ICMP operates here (used in ping sweeps and traceroute recon)
- **Devices:** Routers operate at Layer 3; they make forwarding decisions based on IP headers, not MAC addresses
- **Routing protocols** like OSPF and BGP function at Layer 3 — BGP hijacking attacks exploit this by advertising false routes to redirect internet traffic
- **TTL (Time to Live)** is a Layer 3 field — attackers manipulate TTL values to evade IDS systems using fragmentation tricks
- **Layer 3 firewalls** filter traffic based on source/destination IP and protocol number — they are stateless unless explicitly stateful

## Related concepts
[[OSI Model]] [[IP Spoofing]] [[BGP Hijacking]] [[ICMP]] [[Ingress Filtering]]