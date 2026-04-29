# Quad9

## What it is
Think of Quad9 as a bouncer at a club who checks every guest's name against a known criminal database before letting them in — except the "club" is the internet and the "guests" are DNS queries. Quad9 is a free, privacy-focused public DNS resolver (9.9.9.9) operated by a nonprofit that blocks resolution of domains known to be malicious using threat intelligence feeds from over 20 partners, including IBM X-Force and Abuse.ch.

## Why it matters
In a spear-phishing campaign, an employee clicks a link that attempts to resolve a C2 domain registered two days ago. If that domain has already been flagged and shared with Quad9's threat intelligence partners, the DNS query simply returns no answer — the malware can't phone home, stopping lateral movement before it starts. This DNS-layer blocking is a low-cost, high-leverage defensive control that requires zero endpoint configuration changes.

## Key facts
- Uses IP address **9.9.9.9** (primary) and **149.112.112.112** (secondary); supports DNS-over-HTTPS (DoH) and DNS-over-TLS (DoT) for encrypted queries
- Blocks malicious domains at **query time** using real-time threat intelligence — no packet inspection required
- Quad9 **does not log** source IP addresses, distinguishing it from ISP resolvers that may monetize query data
- Operates as a **nonprofit** (based in Switzerland), reducing commercial incentive to sell user data — relevant for privacy compliance discussions
- Supports **DNSSEC validation**, helping protect against DNS spoofing and cache poisoning attacks
- Does **not filter** content categories (e.g., adult content) — pure security-focused blocking unlike OpenDNS Family Shield

## Related concepts
[[DNS Security (DNSSEC)]] [[DNS-over-HTTPS (DoH)]] [[Threat Intelligence Feeds]] [[DNS Sinkholes]] [[C2 Infrastructure]]