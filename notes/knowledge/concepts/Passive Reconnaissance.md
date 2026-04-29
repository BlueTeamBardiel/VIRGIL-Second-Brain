# Passive reconnaissance

## What it is
Like a detective reading old newspapers and public records before ever stepping foot near a suspect's house, passive reconnaissance is intelligence gathering that never directly touches the target. It involves collecting information about a target system, organization, or individual using only publicly available sources — no packets sent, no connections made, no trace left on the target's logs.

## Why it matters
Before the 2011 RSA SecurID breach, attackers conducted extensive passive reconnaissance using LinkedIn to identify RSA employees by job title and role, then crafted highly targeted spear-phishing emails. That targeting intelligence — gathered entirely without touching RSA's network — made the subsequent attack dramatically more effective. Defenders counter this by auditing their own public footprint through tools like Maltego or simple Google dorking before attackers do.

## Key facts
- **OSINT (Open Source Intelligence)** is the formal discipline underpinning passive recon; sources include WHOIS records, DNS lookups via third-party tools, job postings, social media, Shodan, and certificate transparency logs
- **No direct interaction with the target** is the defining characteristic — using Shodan to find a company's exposed devices counts as passive; running your own Nmap scan does not
- **Google dorking** (using advanced search operators like `site:`, `filetype:`, `intitle:`) is a classic passive recon technique testable on Security+
- **Footprinting** is the broader phase of reconnaissance that includes both passive and active methods; passive recon is the stealthier subset
- Tools commonly associated with passive recon: **theHarvester**, **Maltego**, **Recon-ng**, **WHOIS**, and **Shodan**
- Passive recon produces no IDS/IPS alerts because it never contacts the target's infrastructure directly

## Related concepts
[[Active Reconnaissance]] [[OSINT]] [[Footprinting]] [[Google Dorking]] [[Threat Intelligence]]