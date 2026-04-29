# ISL

## What it is
Like a secret handshake between Cisco switches that lets them whisper "this traffic belongs to VLAN 10" without the other side forgetting — ISL (Inter-Switch Link) is Cisco's proprietary Layer 2 encapsulation protocol that wraps Ethernet frames with a 26-byte header and 4-byte trailer to carry VLAN tagging information across trunk links between switches.

## Why it matters
An attacker performing a VLAN hopping attack may exploit misconfigured trunk ports that still negotiate ISL or 802.1Q encapsulation via DTP (Dynamic Trunking Protocol). If a port auto-negotiates a trunk with an attacker's rogue device, the attacker can tag frames with a target VLAN ID and gain unauthorized access to traffic they should never see — effectively jumping across network segmentation boundaries.

## Key facts
- ISL is **Cisco proprietary** and has been largely replaced by the open standard **802.1Q (dot1q)**, which is vendor-neutral
- ISL **fully encapsulates** the original Ethernet frame (adding headers on both ends), whereas 802.1Q inserts a 4-byte tag *inside* the original frame header
- ISL supports up to **1,000 VLANs**, while 802.1Q supports up to **4,094 VLANs**
- Modern Cisco switches have **deprecated ISL** — many no longer support it at all, making 802.1Q the de facto standard for Security+/CySA+ exam purposes
- Trunk ports using ISL or 802.1Q must be **explicitly hardened** (disable DTP, set ports to "trunk" or "access" statically) to prevent VLAN hopping attacks

## Related concepts
[[802.1Q]] [[VLAN Hopping]] [[DTP (Dynamic Trunking Protocol)]] [[Network Segmentation]] [[Trunk Port Security]]