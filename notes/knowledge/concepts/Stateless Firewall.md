# Stateless Firewall

## What it is
Like a nightclub bouncer who checks only your ID at the door — never remembering whether you already went inside — a stateless firewall inspects each packet in complete isolation, with no memory of prior packets or established connections. It filters traffic purely by matching packet header fields (source/destination IP, port, protocol) against a fixed ruleset, one packet at a time.

## Why it matters
An attacker can craft TCP packets with the ACK flag set, which stateless firewalls often pass through because the ruleset permits "established" traffic — yet no real handshake ever occurred. This ACK scanning technique allows adversaries to map internal firewall rules and reach services that should be unreachable, a weakness that stateful firewalls eliminate by tracking the full TCP handshake.

## Key facts
- Operates at **OSI Layer 3/4**, examining IP headers and port numbers but not connection state or payload
- Uses **Access Control Lists (ACLs)** — sequential rules evaluated top-down with an implicit deny-all at the end
- Cannot distinguish between a legitimate TCP response and a spoofed or out-of-sequence packet
- **Faster and less resource-intensive** than stateful firewalls, making them common in routers and high-throughput network edge devices
- Vulnerable to **IP spoofing, ACK floods, and fragmentation attacks** precisely because each packet is judged without context

## Related concepts
[[Stateful Firewall]] [[Access Control List]] [[Packet Filtering]] [[TCP Three-Way Handshake]] [[Network Address Translation]]