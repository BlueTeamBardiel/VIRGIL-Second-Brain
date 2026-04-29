# V. Reconnaissance and Intelligence Gathering

## What it is
Like a jewel thief who spends weeks photographing guard rotations, delivery schedules, and camera blind spots before touching a single lock — reconnaissance is the systematic collection of information about a target before any active attack begins. It encompasses both passive techniques (observing without interacting) and active techniques (probing systems directly), and represents the first phase of virtually every structured attack methodology, including the Cyber Kill Chain and MITRE ATT&CK framework.

## Why it matters
Before the 2013 Target breach, attackers first compromised a third-party HVAC vendor by researching publicly available contractor relationships — classic passive reconnaissance that revealed a trusted network entry point. Defenders who monitor for reconnaissance activity (unusual DNS queries, port scans, LinkedIn scraping patterns) can detect intrusions weeks before damage occurs.

## Key facts
- **Passive recon** uses OSINT sources — WHOIS, Shodan, LinkedIn, Google dorking — without touching target systems, leaving no logs on the victim's infrastructure
- **Active recon** includes port scanning (Nmap), banner grabbing, and tracerouting, which *do* generate target-side log entries and may trigger IDS alerts
- **DNS enumeration** (zone transfers, subdomain brute-forcing) is a critical active recon technique that can expose internal network architecture
- **Footprinting** is the broader term for mapping an organization's digital footprint; **fingerprinting** specifically identifies OS/software versions on discovered hosts
- Google dorks (e.g., `filetype:pdf site:target.com`) are a Security+ testable passive recon method requiring zero special tools

## Related concepts
[[OSINT]] [[Cyber Kill Chain]] [[Active vs Passive Scanning]] [[DNS Enumeration]] [[Threat Intelligence]]