# RIPv1

## What it is
Imagine a mail carrier who shouts your home address and forwarding instructions to everyone on the street, with no ID check required — that's RIPv1. Routing Information Protocol version 1 is a distance-vector routing protocol that broadcasts routing table updates every 30 seconds to all devices on the network segment, using hop count (max 15) as its sole metric.

## Why it matters
RIPv1's complete lack of authentication makes it trivially exploitable through **route poisoning attacks**: an attacker on the local segment can inject fraudulent routing updates, redirecting traffic through a malicious host for interception or black-holing. This was demonstrated in legacy enterprise environments where an insider could silently perform man-in-the-middle attacks against internal subnets simply by broadcasting crafted RIP packets — no special privileges required.

## Key facts
- **No authentication whatsoever** — any device can inject routing updates; this is the defining security weakness distinguishing it from RIPv2
- **Broadcasts** updates to 255.255.255.255 every 30 seconds, meaning all hosts on the segment receive routing data (not just routers)
- **Classful routing only** — does not include subnet mask information in updates, making it incompatible with CIDR and modern subnetting schemes
- **Maximum hop count of 15** — destinations beyond 15 hops are considered unreachable; hop count 16 signals infinity (route poison)
- **Vulnerable to routing loops**, mitigated weakly by split horizon and holddown timers, but these are bypassable under attack conditions

## Related concepts
[[RIPv2]] [[Route Poisoning]] [[Man-in-the-Middle Attack]] [[Distance-Vector Routing]] [[Network Sniffing]]