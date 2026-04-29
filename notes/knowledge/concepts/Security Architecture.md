# Security Architecture

## What it is
Like a city planner who zones residential areas away from industrial zones, adds checkpoints at bridges, and designs one-way streets before a single building goes up — security architecture is the deliberate structural design of an organization's security controls *before* systems are built. It defines how people, processes, and technology interact to protect assets, using frameworks like SABSA, TOGAF, or NIST to guide decisions at every layer.

## Why it matters
In 2013, Target's breach exposed 40 million credit cards partly because their network had no segmentation — a third-party HVAC vendor's credentials provided a direct path to point-of-sale systems. A proper security architecture with network segmentation and least-privilege access would have contained the attacker's lateral movement and likely prevented the breach entirely.

## Key facts
- **Defense in Depth** is a core architectural principle: layer multiple independent controls so that failure of one doesn't mean total compromise
- **Zero Trust Architecture (ZTA)** assumes no implicit trust based on network location — every access request is authenticated, authorized, and continuously validated (NIST SP 800-207)
- Security architecture operates across three planes: **Management, Control, and Data** — attacks on the control plane (e.g., BGP hijacking) are especially dangerous because they affect routing decisions for everything below
- **Secure by Design** means baking security into requirements and design phases; retrofitting security after deployment costs 30x more and is consistently less effective
- Architecture frameworks distinguish between **policy** (what must be done), **design** (how it's structured), and **implementation** (what specific tools enforce it) — exam questions often test whether candidates can separate these layers

## Related concepts
[[Defense in Depth]] [[Zero Trust]] [[Network Segmentation]] [[Least Privilege]] [[NIST Cybersecurity Framework]]