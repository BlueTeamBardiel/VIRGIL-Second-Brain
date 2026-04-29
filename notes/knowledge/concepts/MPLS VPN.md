# MPLS VPN

## What it is
Think of MPLS VPN like a postal system that sorts packages by colored labels rather than reading the full address on every envelope — packets get a "label" at entry and are forwarded at lightning speed through a private highway built on shared infrastructure. Technically, Multi-Protocol Label Switching VPN is a network tunneling technique where ISPs use label-switched paths to create logically isolated, private wide-area networks for enterprise customers over a shared backbone, without traditional IP-level encryption.

## Why it matters
A common misconception is that MPLS VPNs are inherently "secure" because traffic is logically separated — but logical separation is not encryption. An attacker who compromises a provider edge (PE) router can potentially read or inject traffic between customer sites because MPLS itself provides no confidentiality; this is why enterprises layering sensitive data over MPLS should add IPsec on top, treating the MPLS cloud like any untrusted network.

## Key facts
- MPLS VPNs provide **traffic isolation via VRF (Virtual Routing and Forwarding)** tables, not encryption — confidentiality must be added separately with IPsec or TLS
- Two main types: **Layer 2 MPLS VPN** (VPLS — customer sees Ethernet) and **Layer 3 MPLS VPN** (customer sees IP routing), with different attack surfaces
- MPLS operates between Layer 2 and Layer 3 (sometimes called "Layer 2.5") using a **32-bit label** pushed onto packets at the ingress PE router
- A misconfigured VRF can cause **route leakage**, accidentally exposing one customer's traffic to another — a critical provider-side misconfiguration risk
- Unlike Internet VPNs, MPLS VPNs are **not encrypted by default**, making them vulnerable to insider threats at the carrier level (supply chain risk)

## Related concepts
[[IPsec]] [[VRF Route Leakage]] [[Network Segmentation]]