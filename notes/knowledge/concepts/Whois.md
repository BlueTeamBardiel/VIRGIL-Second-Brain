# Whois

## What it is
Like checking a property deed at the county clerk's office to find out who owns a building, Whois lets you query a public registry to find out who registered a domain name. It is a protocol and database system that stores registration data for domain names and IP address blocks, including owner contact details, registration dates, and nameserver information.

## Why it matters
Attackers use Whois during reconnaissance to harvest contact emails from domain registrations, which become targets for spear-phishing campaigns. Defenders and incident responders use reverse Whois lookups to pivot from a known malicious domain to an entire portfolio of domains registered under the same organization or email address, uncovering attacker infrastructure before it launches.

## Key facts
- **IANA and Regional Internet Registries (RIRs)** — such as ARIN (North America), RIPE NCC (Europe), and APNIC (Asia-Pacific) — maintain authoritative Whois data for IP blocks
- **GDPR significantly redacted Whois records** starting in 2018, replacing personal registrant data with privacy-masked entries, complicating threat intelligence work
- **RDAP (Registration Data Access Protocol)** is the modern, structured JSON-based replacement for the legacy Whois protocol, operating over HTTPS
- Whois queries run over **TCP port 43** by default; web-based lookups use HTTP/HTTPS wrappers around the same underlying data
- **Domain privacy/proxy services** (e.g., Domains By Proxy) substitute registrar contact info for the real owner's data, a tactic also used by malicious actors to hide C2 infrastructure

## Related concepts
[[DNS Enumeration]] [[Passive Reconnaissance]] [[OSINT]] [[DNS Records]] [[Threat Intelligence]]