# OSI model

## What it is
Think of it like a postal system: your letter (data) gets stuffed into an envelope, then a box, then loaded onto a truck — each layer adding its own wrapper without caring what's inside. The OSI (Open Systems Interconnection) model is a 7-layer conceptual framework that standardizes how network communication functions are divided and sequenced, from physical electrical signals up to user-facing applications. It was developed by ISO in 1984 as a universal reference, not a protocol itself, but a blueprint for understanding protocols.

## Why it matters
When a SOC analyst investigates a DDoS attack, they diagnose *which layer* is being targeted: a volumetric flood hammering Layer 3 (Network) looks completely different from a Slowloris attack strangling Layer 7 (Application) by holding HTTP connections open. Matching the attack layer to the correct mitigation — rate limiting vs. WAF rules vs. BGP blackholing — is impossible without OSI as a shared vocabulary.

## Key facts
- **Layer 7 (Application)** — HTTP, DNS, SMTP; where most modern attacks (SQLi, XSS) live
- **Layer 4 (Transport)** — TCP/UDP; firewalls and port-based rules operate here; SYN floods target this layer
- **Layer 3 (Network)** — IP addressing and routing; ACLs and routers work here
- **Layer 2 (Data Link)** — MAC addresses; ARP poisoning and VLAN hopping exploit this layer
- **Layer 1 (Physical)** — Actual cables and signals; wiretapping and signal jamming are Layer 1 attacks
- Security controls map to layers: IDS/IPS = Layer 3–7, switches = Layer 2, encryption (TLS) = Layer 5–6

## Related concepts
[[TCP/IP model]] [[Firewall]] [[Network segmentation]] [[ARP poisoning]] [[DDoS attack]]