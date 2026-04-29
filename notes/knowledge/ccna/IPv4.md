# IPv4

## What it is
Think of IPv4 like a postal system where every house gets a unique street address — except the world ran out of addresses decades ago and we've been creatively subdividing ever since. IPv4 is the fourth version of the Internet Protocol, using 32-bit addresses (written as four octets, e.g., 192.168.1.1) to uniquely identify devices on a network. It defines how packets are addressed, routed, and delivered across interconnected networks.

## Why it matters
IPv4's lack of built-in authentication makes it trivially vulnerable to IP spoofing — an attacker forges the source IP in packet headers to impersonate a trusted host or obscure their origin. This is the backbone of amplification DDoS attacks, where an attacker sends DNS or NTP requests with a spoofed victim IP, causing massive reflected traffic to flood the target. Ingress filtering (BCP38) at network edges is the primary defense, dropping packets with illegitimate source addresses.

## Key facts
- IPv4 uses **32-bit addresses**, supporting ~4.3 billion unique addresses (2³²), now exhausted — hence NAT and IPv6 adoption
- The header includes a **TTL (Time to Live)** field; attackers manipulate TTL values in traceroute evasion and firewall bypass techniques
- **Private address ranges** (RFC 1918): 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 — these should never appear as source IPs on the public internet
- IPv4 has **no native encryption or authentication** — IPSec was retrofitted as an optional extension
- **CIDR notation** (e.g., /24 = 255 hosts) replaced classful addressing; misconfigured subnet masks are a common source of unintended network exposure

## Related concepts
[[IP Spoofing]] [[NAT]] [[IPSec]] [[DDoS Amplification]] [[Subnetting]]