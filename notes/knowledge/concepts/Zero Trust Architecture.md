# Zero Trust Architecture

## What it is
Think of it like a casino floor: even employees with badges get watched constantly, can only access specific areas, and must re-verify at every door — trust is never assumed, only earned moment by moment. Zero Trust Architecture (ZTA) is a security model built on the principle "never trust, always verify," where no user, device, or network segment is granted implicit trust regardless of whether they're inside or outside the corporate perimeter. Every access request is authenticated, authorized, and continuously validated before resources are granted.

## Why it matters
The 2020 SolarWinds breach demonstrated exactly why perimeter-based trust fails: once attackers gained a foothold inside the network, lateral movement was relatively easy because internal traffic was implicitly trusted. Had Zero Trust controls been in place — microsegmentation, continuous verification, least-privilege access — the blast radius would have been dramatically contained even after initial compromise. ZTA is now a U.S. federal mandate under CISA's Zero Trust Maturity Model following this and similar incidents.

## Key facts
- **Five pillars of CISA's ZTA model:** Identity, Devices, Networks, Applications/Workloads, and Data
- **Core principle:** Least-privilege access — users and systems receive only the minimum permissions required, validated per-session
- **Microsegmentation** divides the network into isolated zones so that a breach in one segment cannot freely spread laterally
- **Policy Enforcement Point (PEP)** and **Policy Decision Point (PDP)** are the architectural components that intercept and evaluate every access request in NIST SP 800-207
- Zero Trust does **not** mean passwordless or VPN-free — it's a strategy, not a single product or protocol

## Related concepts
[[Microsegmentation]] [[Least Privilege]] [[Multi-Factor Authentication]] [[Identity and Access Management]] [[NIST SP 800-207]]