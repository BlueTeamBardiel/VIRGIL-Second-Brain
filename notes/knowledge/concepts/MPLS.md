# MPLS

## What it is
Think of MPLS like a highway system with pre-printed boarding passes — instead of reading a full destination address at every toll booth, routers just glance at a short label and forward the packet instantly along a predetermined path. Multiprotocol Label Switching (MPLS) is a high-performance routing technique that directs data using short path labels rather than long network addresses, creating efficient, predetermined forwarding paths through a network. It operates between Layer 2 and Layer 3, earning it the informal designation "Layer 2.5."

## Why it matters
Enterprises commonly use MPLS to connect branch offices via a carrier's private backbone, assuming the isolation provides inherent security — but MPLS is not encrypted by default. An attacker who compromises a provider edge (PE) router or performs a label spoofing attack can intercept or redirect traffic flowing across the MPLS cloud, exposing sensitive business data. This makes defense-in-depth essential: traffic traversing MPLS WANs should still be encrypted with IPsec or TLS regardless of the perceived network isolation.

## Key facts
- MPLS uses **Label Switch Routers (LSRs)** that forward packets based on a 20-bit label rather than performing IP lookups at each hop
- The **Label Distribution Protocol (LDP)** or RSVP-TE is used to distribute and manage labels between routers
- MPLS is **not inherently encrypted** — confidentiality must be added separately via IPsec tunnels or MACsec
- **Label spoofing** and **traffic injection** are known attack vectors if an attacker gains access to the provider's network
- MPLS VPNs (RFC 4364) create logical separation between customer traffic but rely entirely on **provider trust**, not cryptographic isolation

## Related concepts
[[VPN]] [[IPsec]] [[BGP]] [[Network Segmentation]] [[Traffic Analysis]]