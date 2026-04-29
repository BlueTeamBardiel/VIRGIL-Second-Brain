# Remote Work

## What it is
Like employees working from a coffee shop instead of a locked office building — useful, but every table conversation can be overheard. Remote work in security terms means corporate resources are accessed from outside the traditional network perimeter, requiring compensating controls to maintain confidentiality, integrity, and availability when the physical security boundary no longer exists.

## Why it matters
During the 2020 pandemic surge, attackers exploited poorly configured VPNs and unpatched remote desktop protocol (RDP) endpoints to breach organizations whose staff suddenly worked from home. Ransomware groups like REvil specifically hunted for exposed RDP on port 3389, using credential stuffing to gain initial access — demonstrating that remote access infrastructure is a prime attack surface when deployed hastily without hardening.

## Key facts
- **VPN split tunneling** routes only corporate traffic through the encrypted tunnel — a misconfiguration can allow attackers on the same local network to pivot toward corporate resources
- **RDP (port 3389)** should never be exposed directly to the internet; Network Level Authentication (NLA) and MFA are minimum hardening requirements
- **Zero Trust Architecture** is the modern answer to remote work security — "never trust, always verify" replaces perimeter-based assumptions
- **Endpoint security posture** matters: personal/BYOD devices often lack EDR agents, full-disk encryption, or patch management — all exam-relevant risk factors
- **CASB (Cloud Access Security Broker)** enforces security policies between remote users and cloud services, providing visibility and DLP enforcement without requiring traffic through a corporate VPN

## Related concepts
[[VPN]] [[Zero Trust Architecture]] [[Multi-Factor Authentication]] [[RDP Security]] [[Endpoint Detection and Response]]