# SASE

## What it is
Think of SASE like a TSA checkpoint that travels *with* the traveler instead of sitting fixed at the airport — security and network access follow the user wherever they go. Secure Access Service Edge (SASE) is a cloud-delivered architecture that converges wide-area networking (SD-WAN) with security services like CASB, FWaaS, ZTNA, and SWG into a single unified platform. Rather than backhauling traffic to a central data center for inspection, security enforcement happens at the cloud edge, closest to the user.

## Why it matters
A remote employee at a coffee shop connecting to a SaaS application like Salesforce would traditionally tunnel all traffic back to corporate HQ for firewall inspection — slow, expensive, and a single choke point. With SASE, the security stack travels to the nearest cloud PoP (Point of Presence), enforcing Zero Trust policies and scanning for data exfiltration *before* the traffic ever reaches the SaaS app. This model would have contained a 2020-style VPN vulnerability exploit, where attackers used unpatched VPN concentrators as the single entry point into corporate networks.

## Key facts
- SASE was defined by Gartner in 2019 and combines **network-as-a-service** with **security-as-a-service** into one cloud model
- Core components: **SD-WAN, ZTNA, CASB, SWG (Secure Web Gateway), FWaaS (Firewall as a Service)**
- SASE enforces **identity-centric** access — security policies follow the user/device, not the network perimeter
- Reduces attack surface by eliminating hub-and-spoke VPN architectures that create lateral movement opportunities
- SSE (Security Service Edge) is a subset of SASE — security components only, without the SD-WAN networking layer

## Related concepts
[[Zero Trust Network Access]] [[Cloud Access Security Broker]] [[SD-WAN]] [[Secure Web Gateway]] [[Software-Defined Perimeter]]