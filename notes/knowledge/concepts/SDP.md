# SDP

## What it is
Imagine a speakeasy where the door doesn't even exist until you whisper the right password — only then does a door materialize for you alone. Software-Defined Perimeter (SDP) works the same way: infrastructure resources are completely hidden from the network until a user authenticates, at which point a private, encrypted tunnel is dynamically created just for them. It replaces the traditional "castle-and-moat" model with a "dark cloud" where attackers can't attack what they can't see.

## Why it matters
In the 2021 Pulse Connect Secure VPN breaches, attackers exploited exposed VPN appliances simply because those appliances were reachable and fingerprint-able from the internet. An SDP architecture would have prevented this — the VPN gateway itself would have been invisible to unauthenticated scanners, eliminating the attack surface before credentials were ever involved.

## Key facts
- SDP uses a **"authenticate first, connect second"** model (also called Black Cloud or Dark Network), contrasting sharply with VPNs that expose endpoints pre-auth
- Three core components: **SDP Controller** (policy engine), **Initiating Host (IH)** (client), and **Accepting Host (AH)** (the protected resource)
- Uses **Single Packet Authorization (SPA)** — a single cryptographically signed UDP packet proves identity before any TCP connection is allowed
- SDP is a foundational technology for implementing **Zero Trust Network Access (ZTNA)**, enforcing least-privilege connectivity per session
- Defined and promoted by the **Cloud Security Alliance (CSA)** in their SDP specification; increasingly referenced in NIST's Zero Trust Architecture (SP 800-207)

## Related concepts
[[Zero Trust Architecture]] [[VPN]] [[Network Segmentation]] [[Microsegmentation]] [[Identity and Access Management]]