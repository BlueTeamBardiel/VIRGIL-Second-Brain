# Maltego Evidence

## What it is
Like pinning clippings and string to a detective's corkboard, Maltego Evidence is the visual collection of linked data artifacts—entities and their relationships—gathered during an OSINT investigation. Precisely, it refers to the graph-based output within Maltego where discovered nodes (IPs, domains, emails, people, organizations) and their interconnections are recorded, annotated, and preserved as investigative evidence.

## Why it matters
During a threat intelligence investigation, an analyst discovers a phishing domain and runs Maltego transforms to pivot from that domain to associated IP addresses, registrant emails, and related malware hashes. The resulting evidence graph visually demonstrates infrastructure overlap between two separate campaigns, allowing the analyst to attribute them to the same threat actor—evidence that can be exported and presented to incident response teams or law enforcement.

## Key facts
- Maltego Evidence is stored as a **graph file (.mtgx)** that preserves all entities, relationships, and transform results for documentation and sharing
- **Transforms** (automated queries against data sources like Shodan, VirusTotal, or WHOIS) generate the evidence nodes; each result is traceable back to its source
- Evidence graphs support **pivoting**—using one confirmed artifact (e.g., an email) to discover related infrastructure—a core CySA+ reconnaissance analysis technique
- Maltego is classified as an **OSINT and active reconnaissance tool** on Security+ exam objectives; understanding its output is key for threat hunting and digital forensics
- Evidence gathered must be handled carefully for **chain of custody**; Maltego graphs alone are rarely court-admissible without supplementary documentation of collection methodology

## Related concepts
[[OSINT]] [[Link Analysis]] [[Threat Intelligence]] [[Digital Forensics]] [[Network Reconnaissance]]