# FHRP

## What it is
Like a team of surgeons where one steps in seamlessly if the lead surgeon collapses mid-operation, FHRP (First Hop Redundancy Protocol) lets multiple routers share a single virtual IP/MAC address so that if the active gateway fails, a standby router instantly takes over. Protocols like HSRP (Cisco), VRRP (open standard), and GLBP implement this concept to eliminate single points of failure at the network gateway.

## Why it matters
Attackers can abuse FHRP by injecting fraudulent HSRP or VRRP hello messages with a higher priority value, forcing themselves to become the active gateway — a man-in-the-middle position where all subnet traffic flows through the attacker's device before being forwarded normally. This attack is silent and devastating because users experience no connectivity disruption while credentials and session tokens are silently captured. Defending against it requires enabling HSRP/VRRP MD5 authentication and monitoring for unexpected priority changes.

## Key facts
- **HSRP** uses UDP port 1985 and multicast address 224.0.0.2; unauthenticated by default, making it trivially hijackable
- **VRRP** uses IP protocol 112 and multicast 224.0.0.18; also vulnerable to spoofing without authentication configured
- An attacker claiming active gateway status via FHRP hijacking achieves **Layer 3 MitM** without ARP poisoning
- FHRP authentication (MD5 keyed hashing) is a critical hardening control — plain-text authentication exists but provides minimal real protection
- **GLBP** adds load balancing across multiple active routers simultaneously, increasing the attack surface compared to active/standby models

## Related concepts
[[ARP Spoofing]] [[Man-in-the-Middle Attack]] [[Default Gateway Redundancy]] [[Network Segmentation]] [[Layer 2 Security]]