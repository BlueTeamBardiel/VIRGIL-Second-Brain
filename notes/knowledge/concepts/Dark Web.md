# Dark Web

## What it is
Think of the internet as an iceberg: the surface web is the visible tip, the deep web is the submerged bulk (login-gated content, databases), and the dark web is a hidden submarine docked *beneath* the iceberg — reachable only with special equipment. Technically, the dark web is a collection of overlay networks (primarily Tor hidden services with `.onion` domains) that require specific software, configurations, or authorization to access, deliberately obscuring user identity and server location through layered encryption and traffic routing.

## Why it matters
In 2021, threat intelligence analysts monitoring dark web forums discovered REvil ransomware operators auctioning stolen data from Kaseya's VSA supply chain attack, including negotiation tactics and victim lists. Defenders use dark web monitoring services (like Recorded Future or Flare) to detect when corporate credentials or sensitive data appear on criminal marketplaces — enabling incident response before widespread exploitation occurs.

## Key facts
- Tor (The Onion Router) anonymizes traffic by encrypting data in layers and routing it through at least three volunteer relay nodes before reaching its destination
- Dark web ≠ illegal by definition; journalists, dissidents, and law enforcement all operate legitimate `.onion` services (e.g., SecureDrop, Facebook's `.onion` site)
- Common dark web threats include credential markets (e.g., Genesis Market), ransomware-as-a-service (RaaS) portals, and zero-day exploit brokers
- Dark web monitoring is a recognized proactive threat intelligence technique tested on CySA+ — analysts look for leaked PII, credentials, and internal documents
- Exit nodes in Tor are unencrypted chokepoints; malicious exit node operators can perform man-in-the-middle attacks on unencrypted traffic (HTTP, not HTTPS)

## Related concepts
[[Tor Network]] [[Threat Intelligence]] [[OSINT]] [[Credential Stuffing]] [[Ransomware-as-a-Service]]