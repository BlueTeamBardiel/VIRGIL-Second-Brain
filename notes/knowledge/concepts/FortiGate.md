# FortiGate

## What it is
Think of it as a Swiss Army knife bolted to your network's front door — one device that cuts, saws, and files all at once. FortiGate is Fortinet's line of Next-Generation Firewalls (NGFWs) that integrates traditional stateful packet inspection with deep packet inspection, IPS, application control, VPN, web filtering, and antivirus into a single unified appliance.

## Why it matters
In 2021, threat actors exploited CVE-2018-13379, a path traversal vulnerability in FortiGate SSL-VPN, to harvest plaintext VPN credentials from unpatched devices — a flaw so serious the FBI and CISA issued a joint advisory. Organizations running outdated FortiGate firmware exposed remote-access credentials that attackers later used to pivot laterally into critical infrastructure networks, demonstrating that even a security appliance becomes the attack surface if left unpatched.

## Key facts
- FortiGate uses **FortiOS** as its operating system; most critical CVEs target FortiOS directly, making version tracking essential
- Operates as an NGFW by combining **stateful inspection + application-layer awareness**, distinguishing it from legacy firewalls that only inspect headers
- Supports **Security Fabric** integration, allowing FortiGate to share threat intelligence with other Fortinet products (FortiSIEM, FortiEDR) in real time
- SSL-VPN and IPsec VPN are both natively supported, but SSL-VPN has historically been the more exploited attack vector (CVE-2018-13379, CVE-2022-42475)
- FortiGate can perform **TLS/SSL inspection** (decrypt, inspect, re-encrypt) — critical for catching malware hiding in encrypted traffic, but introduces PKI management complexity

## Related concepts
[[Next-Generation Firewall]] [[Deep Packet Inspection]] [[SSL-VPN]] [[CVE Management]] [[Network Segmentation]]