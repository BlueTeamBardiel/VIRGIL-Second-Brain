# On-path Attacks

## What it is

In Witcher 3, when Geralt finds the dwarven merchant Hattori intercepted by Whoreson Junior's thugs in Novigrad — they sit between Hattori and his swordsmithing supplies, reading his correspondence, taking a cut, and Hattori never knows the goods were ever touched. That's exactly what an on-path attack does — the attacker silently positions themselves between two parties, relaying traffic while reading or modifying it, and neither endpoint realizes a third party is in the middle.

**On-path attack** (formerly *man-in-the-middle*): an attack in which the adversary intercepts and optionally alters communication between two hosts that believe they are connected directly to each other.

## Why it matters

Once an attacker is on-path, **confidentiality and integrity collapse simultaneously** — credentials, session tokens, financial data, and TLS handshakes are all readable or forgeable. This breaks PCI-DSS, HIPAA, and basically every compliance regime that mentions encryption-in-transit. Exam-wise, SY0-701 Objective 2.4 lists **on-path attack** explicitly under network attacks, and the trap CompTIA loves: distinguishing on-path from **replay** (replay reuses captured traffic later; on-path is real-time interception) and from **eavesdropping** (passive listening only — on-path implies active relay).

## Key facts

### Attack mechanics

On-path attackers must achieve two things: **traffic redirection** and **trust preservation**. Redirection forces traffic through the attacker; trust preservation prevents the victims from noticing.

### Common on-path techniques

| Technique | Layer | Mechanism |
|---|---|---|
| [[ARP poisoning]] | L2 | Forges ARP replies so victim sends frames to attacker's MAC |
| [[DNS poisoning]] / [[DNS spoofing]] | L7 | Returns malicious IP for legitimate hostname |
| [[Rogue access point]] / [[Evil twin]] | L2 wireless | Victim associates with attacker's AP |
| [[BGP hijacking]] | L3 inter-domain | Announces false routes for victim prefixes |
| [[SSL stripping]] | L7 | Downgrades HTTPS links to HTTP at the proxy |
| [[ICMP redirect]] | L3 | Tricks host into using attacker as gateway |
| [[DHCP spoofing]] | L2/L3 | Hands out attacker IP as default gateway |
| **On-path browser** | Application | Malware in the browser modifies traffic post-decryption |

### On-path browser (formerly man-in-the-browser)

A variant where malware (often a Trojan like Zeus or SpyEye, historically) sits inside the browser process. **TLS doesn't help** — the attacker reads and modifies data after decryption, before rendering. Common against banking sessions.

### Defenses

- **[[Mutual TLS]] (mTLS)** — both sides authenticate with certificates; attacker can't forge both ends.
- **[[HSTS]] (HTTP Strict Transport Security)** — browser refuses HTTP fallback, defeats SSL stripping.
- **[[Certificate pinning]]** — app rejects unexpected certificates even if signed by a trusted CA.
- **[[DNSSEC]]** — signed DNS responses defeat DNS poisoning.
- **[[Dynamic ARP Inspection]] (DAI)** + **[[DHCP snooping]]** — switch-level defenses against ARP/DHCP spoofing.
- **[[802.1X]]** with EAP-TLS — authenticates devices before they touch the LAN.
- **[[VPN]]** with strong cipher suites — encrypts the path even on hostile networks.
- **[[IPsec]] AH/ESP** — authenticates and/or encrypts at L3.

### Detection signals

- Unexpected certificate warnings (users trained to click through — the human failure)
- Duplicate MAC addresses or rapid ARP table churn
- TTL anomalies, latency spikes, or asymmetric routing
- Certificates signed by unexpected CAs

### Exam trap

CompTIA may describe a scenario where the attacker captures and **replays** an authentication token later — that's a **[[replay attack]]**, not on-path. On-path requires *real-time relay*. Conversely, if the question mentions an attacker "between" two parties altering traffic *as it flows*, that's on-path.

## Related concepts

[[ARP poisoning]] · [[DNS poisoning]] · [[Evil twin]] · [[SSL stripping]] · [[Replay attack]] · [[Mutual TLS]] · [[HSTS]] · [[DNSSEC]] · [[Certificate pinning]] · [[BGP hijacking]] · [[Session hijacking]]

---
*Source: VIRGIL knowledge base — 2026-05-08*