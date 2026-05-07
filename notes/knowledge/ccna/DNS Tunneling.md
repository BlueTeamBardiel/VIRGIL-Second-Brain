# DNS Tunneling

## What it is
Imagine smuggling contraband inside diplomatic mail pouches — packages that guards wave through without inspection. DNS tunneling works the same way: attackers encode arbitrary data (commands, stolen files, C2 traffic) inside DNS query and response packets, exploiting the fact that DNS is almost universally allowed through firewalls. Precisely, it's a covert channel technique that abuses the DNS protocol to exfiltrate data or maintain command-and-control communications by embedding payloads in subdomains and TXT/CNAME records.

## Why it matters
During the 2019 APT34 (OilRig) campaigns, attackers used a tool called DNSExfil to slowly siphon sensitive data out of air-gapped-adjacent networks by encoding files as Base64 strings in DNS subdomain queries (e.g., `aGVsbG8...chunk42.attacker.com`). Because DNS traffic rarely triggers egress alerts, the exfiltration persisted for months before detection — a classic example of living off allowed protocols.

## Key facts
- DNS queries are typically allowed outbound on **UDP port 53** (and TCP 53 for large responses), making them ideal for bypassing perimeter controls
- Attackers register a domain they control and run a **rogue authoritative DNS server** to receive and decode the tunneled data
- Indicators include abnormally **long subdomain strings**, **high query frequency** to a single domain, and use of **TXT/NULL record types** for responses
- Tools like **Iodine**, **DNScat2**, and **dnsexfiltrator** automate tunnel creation and are well-known in red team toolkits
- Detection relies on **DNS anomaly analysis** — baselining query length, entropy of subdomains, and requests-per-domain thresholds in SIEM tools

## Related concepts
[[Covert Channels]] [[Command and Control (C2)]] [[Data Exfiltration]] [[DNS Security Extensions (DNSSEC)]] [[Network Traffic Analysis]]