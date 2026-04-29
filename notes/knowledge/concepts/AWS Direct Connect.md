# AWS Direct Connect

## What it is
Think of it like building a private underground tunnel between your office and the AWS data center, bypassing the chaotic public internet highway entirely. AWS Direct Connect is a dedicated physical network connection that links an on-premises environment directly to AWS through a colocation facility, providing consistent bandwidth and latency without traversing the public internet.

## Why it matters
A financial institution processing real-time trading data cannot afford public internet jitter or the risk of BGP route hijacking exposing sensitive transactions. By using Direct Connect, the organization eliminates internet-facing attack surface for that data path — an attacker cannot intercept traffic via a man-in-the-middle on the public internet if the traffic never touches it. However, the physical colocation facility itself becomes a critical security boundary that requires strict physical access controls.

## Key facts
- Direct Connect does **not** encrypt traffic by default — organizations must layer IPsec VPN or MACsec over the connection for data-in-transit confidentiality
- Operates at speeds from **50 Mbps to 100 Gbps** via hosted or dedicated connections
- Traffic uses **private VIFs (Virtual Interfaces)** to reach VPCs, or **public VIFs** to reach AWS public services — a misconfigured public VIF could expose more AWS services than intended
- Satisfies **compliance requirements** (PCI-DSS, HIPAA) that mandate private, dedicated connectivity separate from public internet paths
- For redundancy and high availability, AWS recommends **two Direct Connect connections** at separate locations to avoid single points of failure

## Related concepts
[[BGP Route Hijacking]] [[IPsec VPN]] [[Network Segmentation]] [[Data in Transit Encryption]] [[Physical Security Controls]]