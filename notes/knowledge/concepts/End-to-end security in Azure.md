# End-to-end security in Azure

## What it is
Like an armored truck that stays locked from the bank vault to the delivery point — not just on the highway — end-to-end security in Azure means data and workloads are protected at every layer: identity, network, compute, storage, and application. It is a defense-in-depth strategy implemented across Azure services ensuring no single control point failure compromises the entire system.

## Why it matters
In the 2021 SolarWinds-style supply chain attacks, adversaries moved laterally through cloud environments because perimeter defenses were the only layer enforced. Azure's end-to-end model counters this by requiring that even authenticated, internal traffic passes through network segmentation (NSGs, Azure Firewall), identity verification (Conditional Access), and data-level encryption — so a compromised credential alone cannot reach sensitive storage.

## Key facts
- **Microsoft Defender for Cloud** provides unified end-to-end visibility with a Secure Score, mapping gaps across compute, network, data, and identity pillars
- **Azure Policy + Blueprints** enforce security baselines at deployment time, preventing misconfigured resources from ever entering the environment
- **Encryption in transit and at rest** is enforced by default: TLS 1.2+ for data in motion, Azure Storage Service Encryption (SSE) using AES-256 for data at rest
- **Zero Trust architecture** underpins the model — "verify explicitly, use least privilege, assume breach" — implemented via Azure AD Conditional Access and Privileged Identity Management (PIM)
- **Azure DDoS Protection Standard** operates at the network edge, while Web Application Firewall (WAF) operates at Layer 7, illustrating layered defense across different OSI layers

## Related concepts
[[Zero Trust Architecture]] [[Defense in Depth]] [[Microsoft Defender for Cloud]] [[Azure Active Directory Conditional Access]] [[Encryption at Rest]]