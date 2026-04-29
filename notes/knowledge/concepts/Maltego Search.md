# Maltego Search

## What it is
Think of Maltego like a detective's corkboard covered in photos and red string — except it automatically builds the connections for you. Maltego is an open-source intelligence (OSINT) and link-analysis tool that performs automated searches across public data sources (DNS records, WHOIS, social media, email headers) and visualizes relationships between entities like domains, IP addresses, people, and organizations.

## Why it matters
During a red team engagement, an analyst uses Maltego to map a target company's entire external attack surface: starting from one email domain, transforms automatically discover associated IP ranges, employee LinkedIn profiles, exposed subdomains, and third-party relationships — all without touching the target's systems. This passive reconnaissance phase informs targeted phishing campaigns and identifies weak perimeter entry points before active exploitation begins.

## Key facts
- Maltego uses **Transforms** — automated queries that convert one entity type into related entities (e.g., domain → IP addresses → hosting provider)
- Operates in two editions: **Maltego CE (Community Edition)** is free with limited transforms; **Maltego Pro** provides full commercial transform access
- Connects to the **Transform Hub**, which integrates third-party data sources including Shodan, VirusTotal, HaveIBeenPwned, and PassiveTotal
- Classified as a **passive reconnaissance tool** for OSINT gathering — it queries public data and third-party APIs, not the target directly
- Results are displayed as **graph-based link analysis**, making it useful for both offensive recon and defensive threat intelligence correlation

## Related concepts
[[OSINT]] [[Passive Reconnaissance]] [[Threat Intelligence]] [[Recon-ng]] [[Network Enumeration]]