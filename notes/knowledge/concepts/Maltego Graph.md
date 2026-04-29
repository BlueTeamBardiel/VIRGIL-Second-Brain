# Maltego Graph

## What it is
Think of it like a detective's conspiracy board — red strings connecting photos, names, and locations — except automated and built for digital infrastructure. Maltego Graph is the visual interface within the Maltego OSINT platform that maps relationships between entities (domains, IPs, email addresses, people, organizations) discovered through automated data-gathering scripts called **Transforms**. Each node represents an entity; each edge represents a discovered relationship between them.

## Why it matters
During a red team engagement, an analyst starts with only a target company's domain name. Running Maltego Transforms automatically pulls associated subdomains, IP blocks, employee email patterns, linked social media accounts, and hosting providers — the graph visually exposes the attack surface in minutes rather than days. Defenders use the same graph to discover shadow IT or forgotten assets before attackers do.

## Key facts
- **Transforms** are the engine: pre-built or custom API calls that query sources like Shodan, VirusTotal, WHOIS, and HaveIBeenPwned to populate graph nodes automatically.
- Maltego uses a **hub-and-spoke graph model** — a single seed entity (e.g., one email address) can expand exponentially, making pivot chains visually obvious.
- Available in **Community Edition (CE)** (free, limited Transform runs) and commercial versions; CE is rate-limited to prevent abuse.
- Maltego graphs can export to **GraphML or CSV**, allowing integration with threat intelligence platforms or reports.
- Relevant to the **Reconnaissance phase** of the cyber kill chain and directly supports **attack surface mapping** tested on CySA+.

## Related concepts
[[OSINT]] [[Passive Reconnaissance]] [[Attack Surface Analysis]] [[Shodan]] [[Cyber Kill Chain]]