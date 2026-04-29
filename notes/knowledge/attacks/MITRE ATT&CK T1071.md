# MITRE ATT&CK T1071

## What it is
Like a spy using a crowded train station to pass messages — hiding covert communication inside normal foot traffic — T1071 describes adversaries using standard application-layer protocols (HTTP, HTTPS, DNS, SMTP) to blend command-and-control (C2) traffic into legitimate network activity. The attacker's malware essentially speaks the same "language" as normal business traffic, making detection purely by port or protocol nearly impossible.

## Why it matters
During the SolarWinds SUNBURST attack, malware communicated with C2 servers using HTTP/HTTPS requests disguised as legitimate Orion product telemetry — a textbook T1071.001 (Web Protocols) implementation. Defenders who relied solely on firewall rules blocking unknown ports missed it entirely; only behavioral analysis of DNS query patterns and HTTP beaconing intervals eventually surfaced the intrusion.

## Key facts
- **T1071 has four sub-techniques**: .001 Web Protocols (HTTP/HTTPS), .002 File Transfer Protocols (FTP/SMB), .003 Mail Protocols (SMTP/IMAP), .004 DNS
- **DNS C2 (T1071.004)** is especially stealthy — data is encoded in DNS query subdomains (e.g., `aGVsbG8=.evil.com`), often bypassing proxies that only inspect HTTP
- Detection relies on **behavioral anomalies**: unusual beacon intervals, abnormal data volumes, non-standard User-Agent strings, or high-frequency DNS queries to rare domains
- **HTTPS (T1071.001)** is the most commonly abused sub-technique because encrypted traffic prevents deep packet inspection without SSL/TLS interception
- Mitigation includes **network traffic analysis (NTA)** tools, DNS sinkholes, and TLS inspection proxies — not simple port blocking

## Related concepts
[[Command and Control (TA0011)]] [[DNS Tunneling]] [[Network Traffic Analysis]] [[SSL/TLS Inspection]] [[Beaconing Detection]]