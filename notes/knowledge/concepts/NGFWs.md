# NGFWs

## What it is
Think of a traditional firewall as a nightclub bouncer who only checks what neighborhood you're from (IP/port) — an NGFW is the bouncer who also reads your ID, checks the guest list, and searches your bag. A Next-Generation Firewall combines traditional stateful packet filtering with deep packet inspection (DPI), application-layer awareness, intrusion prevention, and identity-based controls — all in a single integrated platform.

## Why it matters
In the 2020 SolarWinds breach, attackers used legitimate-looking HTTPS traffic over port 443 to exfiltrate data — a traditional firewall would have waved it through without question. An NGFW with SSL/TLS inspection and application-awareness could have identified anomalous beaconing behavior to unusual external hosts and triggered an IPS block, potentially catching the C2 communication before data left the network.

## Key facts
- **Application Awareness**: NGFWs identify traffic by application (e.g., Tor, BitTorrent, Slack) regardless of port, using Layer 7 inspection — not just port 80/443 assumptions
- **Integrated IPS**: Unlike traditional firewalls requiring a separate IDS/IPS appliance, NGFWs embed signature-based and behavioral intrusion prevention inline
- **SSL/TLS Inspection**: NGFWs can decrypt, inspect, and re-encrypt HTTPS traffic — critical since ~90% of modern malware uses encrypted channels
- **Identity-Based Policies**: Rules can be tied to Active Directory users/groups, not just IP addresses (e.g., "block social media for HR department")
- **Unified Threat Management (UTM)**: NGFWs overlap with UTM devices; the key distinction is that UTMs are typically designed for SMBs while NGFWs target enterprise performance and scalability

## Related concepts
[[Stateful Packet Inspection]] [[Intrusion Prevention System]] [[Deep Packet Inspection]] [[Unified Threat Management]] [[Zero Trust Architecture]]