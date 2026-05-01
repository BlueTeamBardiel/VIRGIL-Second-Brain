# VLAN

## What it is
Think of a single physical office building where HR, Finance, and Engineering all share the same hallways — but each department has invisible soundproof walls that prevent them from overhearing each other. A VLAN (Virtual Local Area Network) does exactly that: it logically segments a physical network switch into isolated broadcast domains, so devices on VLAN 10 cannot directly communicate with devices on VLAN 20 without traffic passing through a router or Layer 3 switch.

## Why it matters
In 2003, the Slammer worm spread catastrophically because flat networks allowed a single infected machine to reach every other host instantly. VLANs are a primary defense: by isolating IoT devices, guest Wi-Fi, or POS terminals into their own VLANs, a compromised device cannot directly pivot to the corporate core. However, misconfigured trunk ports can enable **VLAN hopping** — an attacker sends double-tagged 802.1Q frames to escape their native VLAN and reach otherwise isolated segments.

## Key facts
- VLANs are defined by the **IEEE 802.1Q** standard, which tags Ethernet frames with a 12-bit VLAN ID (supporting VLANs 1–4094)
- **VLAN hopping** attacks exploit switch spoofing (convincing a switch you're a trunk peer) or double tagging (nesting 802.1Q tags to hop the native VLAN)
- The **native VLAN** on a trunk port sends traffic untagged; best practice is to set native VLAN to an unused ID (not VLAN 1) to prevent double-tag attacks
- Inter-VLAN routing requires a Layer 3 device (router or multilayer switch); VLANs alone do **not** provide encryption — just logical separation
- VLANs support the **principle of least privilege** at the network layer and are foundational to network segmentation and zero trust architectures

## Related concepts
[[Network Segmentation]] [[802.1Q Tagging]] [[Trunk Port]] [[Switch Spoofing]] [[Zero Trust Architecture]]


<!-- merged from: VLANs.md -->

# VLANs




<!-- merged from: LAN.md -->

# LAN




<!-- merged from: VXLAN.md -->

# VXLAN




<!-- merged from: WLAN.md -->

# WLAN


