# Mitre ATT&CK T1190

## What it is
Like a burglar who doesn't pick the lock but instead walks through a door that was never properly installed, T1190 (Exploit Public-Facing Application) describes attackers targeting vulnerabilities in internet-exposed services — web apps, VPNs, load balancers, or databases — to gain their initial foothold without needing credentials.

## Why it matters
In 2021, attackers exploited CVE-2021-26855 (ProxyLogon) in Microsoft Exchange servers worldwide, using a server-side request forgery flaw to bypass authentication and then chain additional bugs to achieve remote code execution — all before most organizations had applied the patch. Defenders who had edge device logging and a web application firewall (WAF) with virtual patching were able to detect and block exploitation attempts before compromise.

## Key facts
- T1190 is classified under the **Initial Access** tactic (TA0001) in the MITRE ATT&CK framework
- Common targets include web applications, VPN appliances (Pulse Secure, Fortinet), and database interfaces exposed to the internet
- Exploitation often chains with **T1505.003 (Web Shell)** — attackers drop a web shell immediately after gaining access to maintain persistence
- Detection relies on web application firewall (WAF) logs, IDS signatures, and anomalous HTTP request patterns (e.g., unusual User-Agents, encoded payloads)
- Mitigation priorities: patch management, attack surface reduction (disabling unnecessary services), and network segmentation to limit blast radius after exploitation
- CWEs commonly involved include **CWE-89** (SQL Injection), **CWE-78** (OS Command Injection), and **CWE-287** (Improper Authentication)

## Related concepts
[[SQL Injection]] [[Web Application Firewall]] [[CVE and Vulnerability Management]] [[Web Shell]] [[Initial Access Tactics]]