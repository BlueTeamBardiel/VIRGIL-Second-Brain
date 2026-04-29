# VXLAN

## What it is
Think of VXLAN like stuffing a letter inside another envelope — your original Layer 2 Ethernet frame gets sealed inside a UDP packet so it can travel across a Layer 3 IP network as if it were on the same local segment. Formally, Virtual Extensible LAN (VXLAN) is a network virtualization protocol (RFC 7348) that encapsulates Layer 2 frames within Layer 4 UDP datagrams (port 4789), extending virtual Layer 2 networks across physical Layer 3 infrastructure. It supports up to 16 million logical network segments using a 24-bit VXLAN Network Identifier (VNI), compared to VLAN's paltry 4,094.

## Why it matters
In cloud and data center environments, attackers who compromise a hypervisor or container host may attempt VXLAN tunnel injection — crafting malicious UDP packets destined for port 4789 to inject frames into a target tenant's virtual network segment, effectively bypassing traditional Layer 3 segmentation controls. Because VXLAN traffic is often implicitly trusted within a data center fabric and lacks built-in encryption or authentication, a misconfigured deployment can allow lateral movement across tenant boundaries that defenders assume are isolated.

## Key facts
- VXLAN uses **UDP port 4789** for encapsulation; traffic must be explicitly permitted or monitored at perimeter devices
- The **VTEP (VXLAN Tunnel Endpoint)** is the device that encapsulates/decapsulates traffic — a primary attack target in virtualized environments
- VXLAN provides **no native encryption or authentication** — pairing with IPsec or MACsec is required for confidentiality
- The **24-bit VNI** enables ~16.7 million unique segments, making it essential for multi-tenant cloud segmentation
- VXLAN traffic appears as plain UDP to traditional firewalls, making **deep packet inspection** necessary to detect tunnel abuse

## Related concepts
[[Network Segmentation]] [[Tunneling Protocols]] [[Software-Defined Networking]] [[Lateral Movement]] [[IPsec]]