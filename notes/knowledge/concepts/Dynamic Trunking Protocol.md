# Dynamic Trunking Protocol

## What it is
Like a bouncer who automatically upgrades any guest claiming VIP status without checking their ID, DTP is a Cisco proprietary protocol that automatically negotiates trunk links between switches. It allows switch ports to dynamically determine whether to operate as an access port (carrying one VLAN) or a trunk port (carrying multiple VLANs) without manual administrator configuration.

## Why it matters
An attacker with physical or logical access to a network port can send crafted DTP frames to negotiate a trunk link with a switch, a technique called VLAN hopping. Once the rogue device establishes a trunk, it receives traffic from all VLANs on that switch — turning a limited guest network connection into visibility across the entire corporate network without ever breaking encryption.

## Key facts
- DTP operates in several modes: **Auto**, **Desirable**, **Trunk**, **Access**, and **Nonegotiate** — leaving a port in Auto or Desirable makes it vulnerable to trunk negotiation attacks
- The attack vector is called a **switch spoofing attack**, a form of VLAN hopping requiring no special credentials
- **Mitigation**: Disable DTP on all non-trunk ports with `switchport nonegotiate` and explicitly set access ports with `switchport mode access`
- DTP frames use **multicast MAC address 01:00:0C:CC:CC:CC** (same prefix as CDP/VTP), making them identifiable in packet captures
- VLAN hopping via DTP is listed in security frameworks as a Layer 2 attack — **not** mitigated by firewalls operating at Layer 3 and above

## Related concepts
[[VLAN Hopping]] [[802.1Q Trunking]] [[Network Segmentation]] [[Switch Spoofing Attack]] [[VTP (VLAN Trunking Protocol)]]