# Maltego Data

## What it is
Think of Maltego data like a spider's web where every vibration reveals a new connection — it's the structured collection of entities and relationships (people, domains, IPs, organizations) that Maltego maps visually during OSINT investigations. Specifically, Maltego data refers to the nodes (entities) and edges (relationships) populating a Maltego graph, sourced from public databases, APIs, and transforms. Each entity type has defined properties that feed automated queries called transforms.

## Why it matters
During a red team engagement, an analyst might start with only a company domain and use Maltego transforms to pivot through DNS records, WHOIS data, and social media to surface employee email patterns and subdomains — all before touching a single company asset. This passive reconnaissance capability means defenders can run the same workflow to discover their own exposed attack surface before adversaries do.

## Key facts
- **Entities** are the core data objects: Person, Domain, IP Address, Organization, Email Address, Phone Number — each queryable via transforms
- **Transforms** are automated API calls that take one entity as input and return related entities as output (e.g., Domain → MX Records)
- **Maltego Community Edition** is free but rate-limited; paid tiers connect to premium data sources like Shodan, VirusTotal, and HaveIBeenPwned
- Maltego data is passive OSINT — no direct interaction with target systems, making it valuable for **pre-attack reconnaissance phases** (MITRE ATT&CK: Reconnaissance TA0043)
- Graph data can be exported as `.mtgx` files, preserving the full entity-relationship structure for reporting and collaboration

## Related concepts
[[OSINT]] [[Reconnaissance]] [[Link Analysis]] [[DNS Enumeration]] [[Threat Intelligence]]