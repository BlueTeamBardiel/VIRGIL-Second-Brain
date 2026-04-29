# access port

## What it is
Like a hotel room door that only accepts one guest's keycard — an access port is a switch port configured to carry traffic for exactly one VLAN, stripping the VLAN tag before delivering frames to the end device. The connected host has no awareness it's on a VLAN at all; the switch handles all the tagging invisibly.

## Why it matters
An attacker who connects a rogue switch to an access port and sends 802.1Q double-tagged frames can attempt a **VLAN hopping** attack — the outer tag gets stripped by the access port's switch, but the inner tag fools an upstream trunk port into forwarding the frame to a different VLAN. Defenders mitigate this by ensuring access ports never use the native VLAN (VLAN 1 by default) and explicitly disabling trunking negotiation (DTP) on all access-facing ports.

## Key facts
- Access ports belong to **exactly one VLAN** and do not carry 802.1Q tags to end devices (PCs, printers, IP phones without voice VLAN config).
- Contrast with **trunk ports**, which carry multiple VLANs using 802.1Q tagging between switches.
- Cisco switches use `switchport mode access` and `switchport access vlan <id>` to configure an access port.
- **VLAN 1** is the default VLAN on most switches; best practice is to move all access ports off VLAN 1 and disable it where unused to reduce attack surface.
- Disabling **DTP (Dynamic Trunking Protocol)** with `switchport nonegotiate` on access ports prevents an attacker from negotiating a trunk link and escaping VLAN segmentation.

## Related concepts
[[VLAN]] [[trunk port]] [[VLAN hopping]] [[802.1Q]] [[network segmentation]]