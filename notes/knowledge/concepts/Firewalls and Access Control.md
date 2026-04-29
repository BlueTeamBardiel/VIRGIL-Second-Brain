# Firewalls and Access Control

## What it is
Think of a firewall like a bouncer at a club with a guest list — every packet trying to enter or leave must match the rules on the list, or it gets dropped at the door. Precisely, a firewall is a network security device (hardware or software) that inspects traffic and enforces access control policies based on rules tied to IP addresses, ports, protocols, and connection state.

## Why it matters
In 2016, the Bangladesh Bank heist saw attackers exploit weak network segmentation — a properly configured firewall blocking unauthorized SWIFT terminal communication to the internet could have interrupted the $81 million theft mid-execution. Firewalls enforcing egress filtering (not just ingress) are a critical layer that many organizations neglect, leaving data exfiltration paths wide open.

## Key facts
- **Stateful firewalls** track the full TCP connection state; **stateless (packet-filtering)** firewalls evaluate each packet in isolation — stateless is faster but easier to spoof
- **Next-Generation Firewalls (NGFW)** add Layer 7 application awareness, IPS, and deep packet inspection beyond traditional port/protocol rules
- **Implicit deny** is the foundational principle: anything not explicitly permitted is blocked by default
- **ACLs (Access Control Lists)** on routers are the lightweight cousin — they filter traffic but have no state awareness
- Firewalls are commonly deployed in **three-legged (DMZ) architecture**: one interface for internet, one for DMZ, one for internal LAN — isolating public-facing servers from internal resources

## Related concepts
[[Network Segmentation]] [[DMZ Architecture]] [[Intrusion Prevention Systems]] [[Access Control Lists]] [[Defense in Depth]]