# theHarvester

## What it is
Like a combine harvester sweeping across a field and collecting everything left on the surface, theHarvester sweeps across public internet sources and collects exposed organizational data without ever touching the target directly. It is an open-source OSINT reconnaissance tool that aggregates email addresses, subdomains, hostnames, employee names, and IP addresses from public sources such as search engines, DNS servers, and certificate transparency logs.

## Why it matters
Before a spear-phishing campaign, an attacker runs theHarvester against a target company and collects 200 valid employee email addresses from LinkedIn, Google, and Bing in under ten minutes — no authentication, no alerts, no contact with the target's infrastructure. A defender running the same tool proactively discovers that internal project subdomain names and contractor emails are publicly indexed, enabling them to harden their exposure before an adversary capitalizes on it.

## Key facts
- theHarvester is pre-installed in Kali Linux and is commonly used during the **reconnaissance phase** of the penetration testing lifecycle (PTES/PTES framework)
- Data sources (called *modules*) include Google, Bing, Shodan, Hunter.io, VirusTotal, and certificate transparency logs — each queried via API or scraping
- It performs **passive reconnaissance** by default; no packets are sent to the target organization's own systems
- Output can include emails, subdomains, virtual hosts, open ports (via Shodan integration), and employee names
- On Security+/CySA+ exams, theHarvester is a textbook example of **OSINT tooling** used in threat intelligence and active reconnaissance discussions

## Related concepts
[[OSINT]] [[Passive Reconnaissance]] [[Maltego]] [[DNS Enumeration]] [[Spear Phishing]]