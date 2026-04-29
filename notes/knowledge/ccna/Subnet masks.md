# Subnet masks

## What it is
Think of a subnet mask like a stencil laid over an IP address — it reveals which part of the address is the "neighborhood" (network) and which part is the "house number" (host). Precisely, a subnet mask is a 32-bit value used alongside an IP address to divide it into network and host portions, determining which devices can communicate directly without routing. Written as dotted-decimal (e.g., 255.255.255.0) or CIDR notation (e.g., /24), it controls the boundaries of a broadcast domain.

## Why it matters
During network reconnaissance, attackers use subnet mask information to calculate the full range of live hosts to scan — a /24 subnet tells them there are up to 254 potential targets in that segment. Defenders use subnetting strategically to implement network segmentation, isolating sensitive systems (like a cardholder data environment) so that a compromised host in one subnet cannot directly reach critical assets in another, limiting lateral movement.

## Key facts
- A /24 mask (255.255.255.0) yields 254 usable hosts; a /16 yields 65,534 — knowing this math is essential for Security+ subnetting questions
- The subnet mask is ANDed with an IP address to determine the network address; this is how routers make forwarding decisions
- CIDR (Classless Inter-Domain Routing) replaced classful addressing (Class A/B/C) and allows flexible, efficient address allocation
- A /32 mask identifies a single host; a /0 represents all IP addresses — both appear in firewall ACL rules
- Misconfigured subnet masks can cause hosts to bypass the default gateway, sending traffic intended for remote networks directly to the local segment, creating routing failures or security blind spots

## Related concepts
[[Network Segmentation]] [[CIDR Notation]] [[VLANs]] [[Default Gateway]] [[Access Control Lists]]