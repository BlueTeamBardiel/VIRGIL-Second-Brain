# OSINT Tools and Techniques

## What it is
Like a detective piecing together a suspect's life from discarded receipts, old yearbooks, and public court records — OSINT (Open Source Intelligence) is the systematic collection and analysis of publicly available information to build actionable intelligence about a target. Sources include social media, DNS records, WHOIS data, job postings, government filings, and cached web pages — all legally accessible without touching a single private system.

## Why it matters
Before launching a spear-phishing campaign, a threat actor will use tools like Maltego to map an organization's employee structure from LinkedIn, then cross-reference email formats using Hunter.io, and finally check for leaked credentials on Have I Been Pwned. Defenders use the same techniques proactively — running recon against their own organization to discover what attackers can see before they do.

## Key facts
- **Shodan** is the primary OSINT tool for discovering internet-exposed devices and services; it indexes banners from open ports and is directly testable on Security+/CySA+
- **theHarvester** automates collection of emails, subdomains, and IP addresses from public sources — commonly used in the reconnaissance phase of penetration tests
- **WHOIS and passive DNS** lookups reveal domain ownership history, registrar data, and historical IP associations without generating any traffic to the target
- **Google Dorking** uses advanced search operators (e.g., `site:`, `filetype:`, `intitle:`) to surface sensitive files, login pages, or misconfigured directories indexed by search engines
- OSINT fits within the **Reconnaissance** phase of the Cyber Kill Chain and the **Information Gathering** phase of the PTES (Penetration Testing Execution Standard)

## Related concepts
[[Reconnaissance Techniques]] [[Spear Phishing]] [[Cyber Kill Chain]] [[Passive vs Active Reconnaissance]] [[Threat Intelligence]]