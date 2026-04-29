# LoadMaster

## What it is
Like a traffic cop standing at a busy intersection directing cars to whichever lane is shortest, LoadMaster is a hardware/virtual application delivery controller (ADC) made by Progress (formerly KEMP Technologies) that distributes incoming network traffic across multiple backend servers. It combines load balancing, SSL/TLS offloading, and web application firewall (WAF) capabilities in a single appliance.

## Why it matters
In 2024, a critical pre-authentication remote code execution vulnerability (CVE-2024-1212, CVSS 10.0) was discovered in LoadMaster that allowed unauthenticated attackers to execute arbitrary OS commands through the management interface by sending a crafted HTTP request. Because LoadMasters sit at the network perimeter handling all inbound traffic, a compromised unit gives attackers a privileged position to intercept, modify, or redirect traffic for every application behind it — a single point of catastrophic failure rather than protection.

## Key facts
- CVE-2024-1212 received a perfect CVSS score of 10.0, affecting LoadMaster versions before 7.2.60.1; exploitation required no credentials whatsoever
- LoadMaster performs **SSL/TLS termination**, meaning encrypted traffic is decrypted at the ADC before being forwarded — making it a high-value interception target
- The management interface should **never** be exposed to the public internet; network segmentation and ACLs are the primary mitigations
- LoadMaster's WAF functionality can block OWASP Top 10 attacks (SQLi, XSS), but if the ADC itself is compromised, WAF protections are meaningless
- Patch management for perimeter devices like LoadMaster is considered **Tier 1 priority** because exploitation typically occurs within days of public disclosure

## Related concepts
[[Application Delivery Controller]] [[SSL TLS Offloading]] [[Web Application Firewall]] [[CVE Scoring CVSS]] [[Network Segmentation]]