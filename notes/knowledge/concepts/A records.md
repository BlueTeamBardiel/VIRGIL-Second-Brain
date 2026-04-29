# A records

## What it is
Think of A records as the phonebook of the internet—they translate a human-readable domain name into an IP address so your browser knows where to actually go. Formally, an A record is a DNS record that maps a fully qualified domain name (FQDN) to a 32-bit IPv4 address (e.g., `example.com` → `93.184.216.34`).

## Why it matters
Attackers exploit A records through DNS hijacking: if they compromise your DNS provider or intercept requests, they can redirect your A record to a malicious IP address, stealing credentials or distributing malware to your users. Defenders must monitor A record changes (especially via DNSSEC validation) and implement strict access controls on DNS management accounts, since A record poisoning requires zero technical sophistication but massive impact.

## Key facts
- A records only handle IPv4 addresses; AAAA records handle IPv6
- A records exist in the DNS zone file and propagate via recursive resolution
- TTL (Time To Live) determines caching duration—lower TTLs mean faster updates but more DNS queries
- Wildcard A records (`*.example.com`) match any subdomain not explicitly defined
- A record changes can take hours to propagate globally due to DNS caching at multiple levels

## Related concepts
[[DNS spoofing]] [[DNSSEC]] [[DNS enumeration]] [[Zone transfer attacks]] [[TTL manipulation]]