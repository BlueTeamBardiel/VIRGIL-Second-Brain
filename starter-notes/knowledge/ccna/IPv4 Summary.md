# IPv4 Summary

## What it is
Like a postal system where every house gets a unique street address so mail can be routed correctly, IPv4 assigns a 32-bit numerical label to every device on a network so packets know where to go and where they came from. It is the fourth version of the Internet Protocol, operating at Layer 3 of the OSI model, providing logical addressing and best-effort packet delivery without guaranteed reliability.

## Why it matters
IP spoofing attacks exploit IPv4's lack of built-in source address verification — an attacker crafts packets with a forged source IP to bypass IP-based access controls, conduct DDoS amplification attacks, or disguise their origin during reconnaissance. Defenders counter this with ingress/egress filtering (BCP38) at network borders to drop packets with impossible source addresses, making address verification a fundamental firewall and router configuration concern.

## Key facts
- IPv4 addresses are **32 bits**, written in dotted-decimal notation (e.g., 192.168.1.1), yielding ~4.3 billion unique addresses
- Address space is divided into classes (A, B, C, D, E) and private ranges (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) defined by RFC 1918 — private IPs are non-routable on the public internet
- IPv4 has **no built-in authentication or encryption** — IPSec was retrofitted as an optional addition, whereas IPv6 was designed with it natively
- **CIDR (Classless Inter-Domain Routing)** replaced classful addressing, using subnet masks (e.g., /24) to define network boundaries — critical for firewall rule writing
- Exhaustion of IPv4 addresses drove adoption of **NAT**, which hides multiple internal hosts behind one public IP, obscuring internal network topology from external attackers

## Related concepts
[[Subnetting]] [[NAT]] [[IP Spoofing]] [[CIDR]] [[IPv6]]
