# OSINT

## What it is
Think of OSINT like being a detective who never leaves the library — everything you need to build a profile on a target already exists in public records, social media, job postings, and DNS registries. Open Source Intelligence (OSINT) is the systematic collection and analysis of publicly available information to support reconnaissance, threat intelligence, or investigations. No hacking required; the target often hands you the keys.

## Why it matters
Before launching a spear-phishing campaign, an attacker uses tools like Maltego and theHarvester to scrape employee names, email formats, and LinkedIn roles from a company's public footprint — building a believable pretext in under an hour. Defenders use the same techniques proactively (a practice called "red teaming your own exposure") to discover what an adversary would find before they do. This discipline is foundational to threat intelligence feeds and attack surface management programs.

## Key facts
- **Shodan** is an OSINT search engine that indexes internet-facing devices, revealing exposed IPs, open ports, and default credentials — all without touching a target system.
- **Google Dorking** (advanced search operators like `filetype:pdf site:target.com`) can surface sensitive documents unintentionally indexed by search engines.
- OSINT sources include WHOIS records, Certificate Transparency logs, Pastebin dumps, job postings, and social media — collectively called **passive reconnaissance**.
- Unlike active reconnaissance, OSINT generates **no direct network traffic** to the target, making it nearly invisible to IDS/IPS systems.
- The **OSINT Framework** (osintframework.com) and **Recon-ng** are commonly tested tools for Security+/CySA+ scenarios involving threat actor profiling and pre-attack intelligence gathering.

## Related concepts
[[Reconnaissance]] [[Threat Intelligence]] [[Social Engineering]] [[Attack Surface Management]] [[Spear Phishing]]