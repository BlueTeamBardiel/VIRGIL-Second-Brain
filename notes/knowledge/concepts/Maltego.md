# Maltego

## What it is
Like a spider spinning a web between every person, domain, IP address, and email it can find, Maltego is a visual link-analysis and OSINT (Open Source Intelligence) tool that maps relationships between entities across public data sources. It transforms raw, scattered internet data into an interactive graph showing how targets connect to one another.

## Why it matters
During a red team engagement, an analyst uses Maltego to pivot from a single corporate email address — discovering linked domains, associated IP ranges, employee LinkedIn profiles, and exposed subdomains within minutes. This reconnaissance phase directly informs phishing campaign targets and attack surface mapping without touching a single company-owned system, making it legally low-risk but devastatingly informative.

## Key facts
- Maltego uses modular plugins called **Transforms** that query data sources (Shodan, VirusTotal, WHOIS, social networks) and return connected entities automatically
- It operates in two editions: **Maltego CE** (Community, free, limited transforms) and **Maltego Pro/Enterprise** (commercial, full data access)
- Core entity types include: **Person, Email Address, Domain, IP Address, Organization, Phone Number, and Website**
- Classified as a **passive reconnaissance** tool — it queries public APIs and databases, not the target directly, reducing detection risk
- Developed by **Paterva** (now Maltego Technologies) and is natively included in **Kali Linux**, making it a standard penetration testing toolkit component

## Related concepts
[[OSINT]] [[Reconnaissance]] [[Shodan]] [[Attack Surface Mapping]] [[Social Engineering]]