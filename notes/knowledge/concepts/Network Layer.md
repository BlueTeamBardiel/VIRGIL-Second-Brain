# Network Layer

## What it is
Think of it as the postal sorting facility of the internet — it doesn't care what's *in* the package, only where it needs to *go*. The Network Layer (OSI Layer 3) is responsible for logical addressing and routing, determining the best path for packets to travel across interconnected networks. It operates on IP addresses rather than physical MAC addresses, enabling communication between devices on different networks.

## Why it matters
IP spoofing attacks operate entirely at the Network Layer — an attacker crafts packets with a forged source IP address to impersonate a trusted host or obscure their origin during a DDoS amplification attack. Defenders counter this with ingress/egress filtering (BCP38), which instructs routers to drop packets whose source addresses couldn't have legitimately originated from that network segment, effectively choking spoofed traffic at the routing level.

## Key facts
- **Layer 3 protocols**: IPv4, IPv6, ICMP, and routing protocols (OSPF, BGP) all live here
- **IP fragmentation attacks** (like the Teardrop attack) exploit how Layer 3 reassembles fragmented packets, causing buffer overflows in vulnerable systems
- **TTL (Time to Live)** is a Layer 3 field — OS fingerprinting uses default TTL values (Windows = 128, Linux = 64) to identify operating systems
- **ACLs on routers** are Layer 3 controls — they filter traffic based on source/destination IP, making them a critical perimeter defense tool
- **ICMP** operates at Layer 3; ICMP redirect attacks can manipulate routing tables to perform man-in-the-middle attacks

## Related concepts
[[IP Spoofing]] [[ICMP Attacks]] [[Access Control Lists]] [[BGP Hijacking]] [[OSI Model]]