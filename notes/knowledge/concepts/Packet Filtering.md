# Packet Filtering

## What it is
Like a bouncer checking IDs at the door — only looking at your jacket (source IP), your shoes (destination port), and whether you're on the list (protocol) — packet filtering examines network packets against a ruleset without caring what's *inside* the envelope. It is a stateless firewall technique that inspects packet headers (source/destination IP, port, protocol, flags) and permits or denies traffic based on predefined ACL rules, making no judgment about session context or payload content.

## Why it matters
In 2003, the SQL Slammer worm spread globally in under 10 minutes by hammering UDP port 1434. Organizations with packet filtering rules blocking inbound UDP/1434 at the perimeter were largely unaffected — a simple header-level rule stopped a world-scale incident. This illustrates both the power and the limit of packet filtering: it stops known-bad ports cold but can't detect malicious payloads on allowed ports.

## Key facts
- Operates at **Layer 3 (Network) and Layer 4 (Transport)** of the OSI model
- **Stateless** — each packet is evaluated independently; it has no memory of previous packets or connection state, making it vulnerable to IP spoofing and fragmentation attacks
- Rules are evaluated **top-down in order**; the first matching rule wins (implicit deny-all is a best-practice final rule)
- Cannot inspect **application-layer content** (HTTP payloads, DNS queries); that requires DPI or proxy firewalls
- Common implementation: **iptables** on Linux (`iptables -A INPUT -p tcp --dport 22 -j ACCEPT`), Cisco ACLs, and pfSense rules

## Related concepts
[[Stateful Inspection]] [[Access Control Lists]] [[Deep Packet Inspection]] [[Firewall Types]] [[Network Address Translation]]