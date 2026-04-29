# Exfiltration Over Alternative Protocol

## What it is
Like a smuggler hiding contraband in a produce truck instead of a cargo ship — using channels nobody is watching — attackers move stolen data through protocols that aren't the "normal" ones security tools monitor. Precisely: Exfiltration Over Alternative Protocol (MITRE ATT&CK T1048) involves sending data out of a network using protocols like DNS, ICMP, FTP, or SMTP rather than standard HTTP/HTTPS channels that defenders typically inspect.

## Why it matters
During the APT32 (OceanLotus) campaigns, attackers tunneled stolen data inside DNS query strings — encoding sensitive files as subdomains like `c2VjcmV0ZGF0YQ==.attacker.com` — because most firewalls allow outbound DNS without deep inspection. This technique bypassed perimeter controls for months before behavioral analytics flagged the abnormal DNS query volume and size.

## Key facts
- **DNS tunneling** is the most common variant; tools like `iodine` and `dnscat2` encode arbitrary data inside DNS TXT or A record queries
- MITRE ATT&CK sub-techniques include T1048.001 (asymmetric encrypted protocol), T1048.002 (symmetric encrypted protocol), and T1048.003 (unencrypted/obfuscated)
- ICMP exfiltration hides data in the payload field of echo requests — ping packets aren't just for latency checks
- Detection relies on **protocol anomaly analysis**: unusually large DNS queries, high query frequency, or non-standard payload sizes in ICMP are red flags
- Defense-in-depth controls include DNS sinkholing, egress filtering rules that whitelist only required protocols, and UEBA tools monitoring outbound traffic baselines

## Related concepts
[[DNS Tunneling]] [[Data Exfiltration]] [[Command and Control]] [[Network Traffic Analysis]] [[ICMP Covert Channel]]