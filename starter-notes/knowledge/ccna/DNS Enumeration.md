# DNS enumeration

## What it is
Like reading every label on every filing cabinet in an office before breaking in, DNS enumeration is the process of systematically querying DNS infrastructure to map out an organization's domain names, IP addresses, mail servers, and subdomains. It is a reconnaissance technique used to build a comprehensive picture of a target's network topology before launching an attack.

## Why it matters
Before the 2011 HBGary Federal breach, attackers used DNS enumeration to discover exposed subdomains and mail server configurations that revealed internal naming conventions — information that directly informed their social engineering and exploitation strategy. Defenders use the same technique proactively (called DNS auditing) to find forgotten subdomains like `legacy.corp.com` that host unpatched, internet-facing systems.

## Key facts
- **Zone transfer (AXFR)** is the highest-value DNS enumeration technique — if a DNS server is misconfigured to allow transfers to any host, an attacker receives the entire zone file in one query using `dig AXFR @nameserver domain.com`
- Tools commonly used: `nslookup`, `dig`, `dnsenum`, `dnsrecon`, and `fierce` — the last two are frequently referenced in CySA+ scenarios
- **Subdomain brute-forcing** uses wordlists to guess valid subdomains (e.g., `mail.`, `vpn.`, `dev.`) when zone transfers are blocked
- **Reverse DNS lookups** (PTR records) can map IP ranges back to hostnames, revealing network structure even without forward-lookup access
- Mitigation: restrict zone transfers to authorized secondary DNS servers only, using ACLs in BIND (`allow-transfer { trusted_ip; };`)

## Related concepts
[[Zone Transfer Attack]] [[Reconnaissance]] [[OSINT]] [[DNSSEC]] [[Network Footprinting]]
