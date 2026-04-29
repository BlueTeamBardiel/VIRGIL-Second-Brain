# Cisco SD-Access

## What it is
Think of it like a shopping mall with a smart wristband system — your wristband determines exactly which stores you can enter, and that policy follows you whether you're on the ground floor or the rooftop. Cisco Software-Defined Access (SD-Access) is a network architecture built on Cisco DNA Center that uses identity-based segmentation to enforce consistent access policies across wired and wireless campus networks. It automates the creation of virtual network overlays using VXLAN tunnels and tags traffic with Scalable Group Tags (SGTs) to control east-west movement without relying on traditional IP-based ACLs.

## Why it matters
In a ransomware lateral movement scenario, an attacker who compromises one endpoint traditionally pivots freely across a flat network. SD-Access counters this by assigning every device and user an SGT at authentication time — even if the attacker owns a valid credential, their SGT restricts which segments they can reach, containing the blast radius before the payload spreads to critical servers.

## Key facts
- **Scalable Group Tags (SGTs)** are 16-bit labels assigned via Cisco ISE during 802.1X authentication, enforcing micro-segmentation without complex VLAN restructuring
- **Cisco DNA Center** serves as the centralized controller and policy orchestration platform — the "brain" of the SD-Access fabric
- **VXLAN** (Virtual Extensible LAN) is the tunneling protocol used to carry overlay traffic across the physical underlay network
- **Cisco ISE (Identity Services Engine)** integrates directly to provide AAA services, device profiling, and SGT assignment
- SD-Access enforces **zero-trust principles** at the network layer by defaulting to deny-all between groups unless explicit policy permits traffic

## Related concepts
[[Software-Defined Networking (SDN)]] [[Cisco Identity Services Engine (ISE)]] [[Zero Trust Architecture]] [[Network Segmentation]] [[802.1X Authentication]]