# External Remote Services

## What it is
Think of it like leaving a spare key under the doormat for contractors — convenient, but anyone who knows to look can walk right in. External Remote Services refers to internet-facing services like VPNs, RDP, Citrix, SSH, and VDI solutions that allow legitimate remote access to internal networks, which adversaries exploit to gain initial access or persistence using stolen or brute-forced credentials.

## Why it matters
In the 2021 Kaseya VSA ransomware attack, threat actors exploited an internet-exposed Kaseya RMM server — an external remote service — to push malicious updates to thousands of downstream MSP clients, triggering REvil ransomware deployment at scale. Had the attack surface been reduced by restricting Kaseya server exposure to VPN-only access, the blast radius would have been dramatically smaller.

## Key facts
- Maps to **MITRE ATT&CK T1133** under the Initial Access and Persistence tactics
- Common targeted services include **RDP (port 3389), SSH (port 22), VPN gateways, Citrix, and Microsoft RD Web**
- Attackers frequently use **credential stuffing, password spraying, or purchased credentials** from dark web markets to authenticate
- Defenders should enforce **MFA on all external remote services** — credentials alone are insufficient protection
- **Shodan and Censys** are tools adversaries (and defenders) use to discover exposed remote services on the internet

## Related concepts
[[Brute Force Attacks]] [[Valid Accounts]] [[Multi-Factor Authentication]] [[VPN Security]] [[Attack Surface Management]]