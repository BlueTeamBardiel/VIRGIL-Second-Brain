# T1572 Protocol Tunneling

## What it is
Like smuggling contraband inside a diplomatic pouch that border agents won't inspect, protocol tunneling hides malicious traffic inside a trusted, allowed protocol. Attackers encapsulate one protocol inside another — typically wrapping C2 communications inside DNS queries, ICMP packets, or HTTPS — to blend with legitimate traffic and bypass firewall rules.

## Why it matters
During the DNScat2 campaigns observed against enterprise networks, attackers encoded command-and-control instructions inside DNS TXT record queries. Because most firewalls permit outbound DNS on port 53, the C2 traffic passed freely while security teams saw only what appeared to be routine name resolution activity — the attack persisted for weeks undetected.

## Key facts
- **DNS tunneling** is the most common variant: data is Base64-encoded into subdomains (e.g., `aGVsbG8=.attacker.com`), making each query a covert data channel
- Legitimate tools like **iodine**, **dnscat2**, and **Chisel** are frequently weaponized for tunneling, making them dual-use indicators
- Detection relies on **anomaly-based analysis**: unusually long DNS query strings, high query frequency to a single domain, or abnormal data volume in ICMP payloads are key tells
- Protocol tunneling enables **C2 persistence and data exfiltration** simultaneously — a single tunnel can carry commands in and stolen data out
- Defenders counter it with **Deep Packet Inspection (DPI)**, DNS RPZ (Response Policy Zones), and monitoring for protocol specification violations (e.g., ICMP packets larger than 64 bytes)

## Related concepts
[[T1071 Application Layer Protocol]] [[T1048 Exfiltration Over Alternative Protocol]] [[DNS Sinkholes]] [[Deep Packet Inspection]] [[T1095 Non-Application Layer Protocol]]