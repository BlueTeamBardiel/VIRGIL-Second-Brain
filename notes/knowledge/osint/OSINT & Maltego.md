# OSINT & Maltego

[[OSINT]] (Open Source Intelligence) is the practice of collecting and analyzing publicly available information for intelligence purposes. [[Maltego]] is a leading platform for automating OSINT investigations and data transformation.

## What is OSINT?

[[OSINT]] involves gathering intelligence from publicly accessible sources including:
- Social media platforms
- Public records and databases
- News archives
- Domain registration data
- Network information
- Company websites and documents

## Applications of OSINT

[[OSINT]] is used across multiple sectors:
- **Cyber Threat Intelligence**: Identifying threat actors and attack patterns
- **Law Enforcement**: Criminal investigations and suspect profiling
- **Government & Defense**: National security and threat assessment
- **Banking & Insurance**: Due diligence and fraud detection
- **Corporate Security**: Competitive intelligence and risk assessment

## Maltego Platform

[[Maltego]] provides tools for OSINT automation:
- **[[Maltego Graph]]**: Visualizes relationships between entities
- **[[Maltego Search]]**: Queries across data sources
- **[[Maltego Monitor]]**: Tracks changes in OSINT data
- **[[Maltego Evidence]]**: Manages investigation findings
- **[[Maltego Data]]**: Aggregates multiple data sources
- **[[Hunchly]]**: Browser extension for web‑based investigations

## What Is It? (Feynman Version)

Think of OSINT as a librarian who reads every newspaper, catalog, and public filing, then writes a report on how a particular person or company is connected to others. It’s not a secretive spy tool; it’s the process of turning freely available data into actionable relationships.

## Why Does It Exist?

Before OSINT, investigators had to rely on manual, time‑consuming searches and paid databases. A 2013 ransomware incident highlighted the cost: a single attacker used publicly posted credentials to breach dozens of companies. OSINT filled the gap by giving security teams a systematic way to gather that same public data—social media posts, WHOIS records, DNS leaks—without paying for black‑market services. It turns the open web into a searchable map of potential attack vectors.

## How It Works (Under The Hood)

1. **Data Collection**:  
   - **Web Crawlers**: Pull HTML, PDFs, and JSON from target domains.  
   - **APIs**: Query platforms like Twitter, Shodan, or public registries.  
   - **Scrapers**: Pull data from free databases such as FCC, SEC filings, or court dockets.

2. **Normalization**:  
   - Convert disparate data formats into a common schema: emails, phone numbers, IP addresses, and domain names are parsed into canonical forms.

3. **Entity Extraction**:  
   - Named‑entity recognition (NER) identifies people, organizations, and places.  
   - Regular expressions pull out credentials, phone numbers, and domain patterns.

4. **Relationship Mapping**:  
   - Algorithms cross‑reference entities: e.g., an email linked to a domain, a domain registered to a person, a Twitter handle linked to that person.  
   - Graph databases (Neo4j or similar) store nodes (entities) and edges (relationships).

5. **Visualization & Querying**:  
   - [[Maltego Graph]] renders the network, color‑coding entity types and edge weights.  
   - Transforms (small programs) apply filters or enrich data with additional sources.

6. **Monitoring & Evidence Management**:  
   - [[Maltego Monitor]] watches for changes in source data (e.g., new WHOIS entries).  
   - [[Maltego Evidence]] tags snapshots and notes for reporting.

## What Breaks When It Goes Wrong?

If the crawler misses a source, a key link goes unseen and the attacker slips through. If the normalization step misparses an email (treats “[at]” as a space), the graph will show false connections, leading analysts to chase phantom leads. A botched API rate limit can stall the entire investigation, costing hours or days. In worst cases, a false positive in the graph might implicate an innocent employee, leading to reputational harm or wrongful termination.

---

#osint #intelligence #maltego #investigation #threat-intelligence #data-analysis

_Ingested: 2026-04-15 20:45 | Source: https://www.maltego.com/blog/what-is-osint-and-how-is-it-used/_