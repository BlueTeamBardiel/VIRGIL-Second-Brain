# DNS Attacks

## What it is

In Mass Effect, the Normandy's galaxy map lets you punch in a destination and the ship calculates the mass relay jump. Imagine if Cerberus quietly rewrote the map's coordinates so that selecting "Citadel" silently routed you to a Collector ambush — same name on the screen, completely different destination. That's exactly what DNS attacks do — they corrupt the lookup that translates a name you trust into the address you actually reach.

**DNS attacks** are techniques that manipulate the Domain Name System resolution process to redirect traffic, harvest credentials, or deny service by poisoning, spoofing, or hijacking name-to-IP translations.

## Why it matters

DNS is the trust layer the entire internet quietly leans on, and it was designed in 1983 with effectively zero authentication. A successful DNS attack lets an adversary phish users who typed the URL correctly, intercept TLS handshakes (especially if cert validation is sloppy), exfiltrate data through query tunneling, or take a domain offline entirely. For SY0-701 Objective 2.4, expect to identify **DNS poisoning**, **domain hijacking**, and **URL redirection** by symptom. CompTIA's favorite trap: confusing **DNS poisoning** (corrupting a resolver's cache) with **domain hijacking** (taking over the registrar account). They are not the same attack and the defenses differ.

## Key facts

### Attack types

| Attack | Mechanism | Where it happens |
|---|---|---|
| **[[DNS Poisoning]]** / **[[Cache Poisoning]]** | Inject forged records into a resolver's cache | Recursive resolver |
| **[[DNS Spoofing]]** | Forge response packets to a query in flight | Network path |
| **[[Domain Hijacking]]** | Steal registrar credentials, change NS records | Registrar account |
| **[[DNS Tunneling]]** | Encode data inside DNS queries/responses | Egress traffic |
| **[[URL Redirection]]** | Alter records or hosts file to send traffic elsewhere | Resolver or endpoint |
| **[[Typosquatting]]** | Register lookalike domains (rnicrosoft.com) | Public registration |
| **[[DNS Amplification]]** | Spoof victim IP, query large records, flood victim | Open resolvers |

### How DNS poisoning works

1. Attacker triggers a recursive lookup for a target domain
2. Race the legitimate authoritative server with a forged response
3. If the **transaction ID** and **source port** match, resolver caches the lie
4. Every downstream client gets the poisoned answer until **TTL** expires

The classic enabler: **[[Kaminsky Attack]]** (2008) exploited predictable transaction IDs and limited port randomization.

### Defenses

- **[[DNSSEC]]** — cryptographically signs DNS records using **RRSIG**, **DNSKEY**, **DS** records; resolvers validate signatures up the chain to the root. Stops poisoning and spoofing. Does **not** encrypt queries.
- **[[DNS over HTTPS]] (DoH)** — port **443**, encrypts queries, hides them from network inspection
- **[[DNS over TLS]] (DoT)** — port **853**, encrypts queries, easier to monitor than DoH
- **[[Registrar Lock]]** / **Registry Lock** — prevents unauthorized NS or transfer changes; defense against domain hijacking
- **[[Multi-Factor Authentication]]** on the registrar account — the actual fix when "domain hijacking" is the question
- **Source port randomization** + **0x20 encoding** — raise the bar for blind spoofing
- **[[Split-Horizon DNS]]** — internal vs. external views, reduces info leakage
- **Egress filtering and DNS query logging** — catches **[[DNS Tunneling]]** by query volume, length, and entropy

### Ports to memorize

| Service | Port | Protocol |
|---|---|---|
| DNS query/response | **53** | UDP (TCP for >512 bytes, AXFR) |
| DoT | **853** | TCP |
| DoH | **443** | TCP/HTTPS |

### Exam tells

- "Users typing the correct URL land on a malicious site, network-wide" → **DNS poisoning**
- "Attacker changed the NS records at the registrar" → **domain hijacking**
- "Beaconing C2 traffic hidden in TXT record queries" → **DNS tunneling**
- "Mitigation that signs records" → **DNSSEC** (not DoH/DoT — those encrypt, they don't authenticate the data)

## Related concepts

[[DNSSEC]] · [[DNS over HTTPS]] · [[DNS over TLS]] · [[Domain Hijacking]] · [[Typosquatting]] · [[DNS Tunneling]] · [[Pharming]] · [[On-Path Attack]] · [[DDoS]] · [[Amplification Attack]] · [[Recursive Resolver]] · [[TTL]]

---
*Source: VIRGIL knowledge base — 2026-05-08*