# Hybrid Cloud

## What it is
Think of it like a hospital that keeps patient records in a locked private vault on-site, but uses a public courier service for non-sensitive mail — each system serving a distinct purpose. A hybrid cloud combines private cloud infrastructure (on-premises or dedicated) with public cloud services (AWS, Azure, GCP), connected by technology that allows data and applications to move between them. The organization controls what lives where, balancing security requirements against cost and scalability.

## Why it matters
A financial institution might store regulated customer data (PII, transaction history) in a private on-premises environment to satisfy PCI-DSS compliance, while bursting workloads like fraud analytics into AWS during peak periods. An attacker who compromises the public-facing cloud workload can attempt **cloud-to-private lateral movement** through misconfigured VPN tunnels or shared API keys — the interconnection point becomes the critical attack surface. Defenders must enforce strict segmentation and monitor east-west traffic crossing the hybrid boundary.

## Key facts
- The **interconnection layer** (VPN, AWS Direct Connect, Azure ExpressRoute) is the highest-risk component — compromise here bridges public and private environments
- Hybrid cloud is explicitly tested on Security+ as one of four deployment models: **public, private, hybrid, community**
- **Data sovereignty** violations occur when data automatically replicates from private to public cloud without controls — a compliance failure, not just a security one
- **Shared responsibility model** still applies: the CSP secures the public cloud infrastructure; the customer secures data classification, access controls, and what moves where
- Shadow IT risk increases in hybrid environments — developers may move sensitive workloads to public cloud without security team awareness

## Related concepts
[[Cloud Security]] [[VPN (Virtual Private Network)]] [[Shared Responsibility Model]] [[Data Loss Prevention]] [[Network Segmentation]]