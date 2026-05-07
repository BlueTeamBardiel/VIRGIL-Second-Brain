# VLANs for Dummies

## What it is
Imagine one physical office building where the Finance team, HR, and Engineering all sit in different rooms with locked doors between them — same building, completely separate conversations. A VLAN (Virtual Local Area Network) does exactly that on a network switch: it logically segments one physical network into multiple isolated broadcast domains, enforced in software rather than by buying separate hardware.

## Why it matters
Without VLANs, a compromised workstation on the guest Wi-Fi can broadcast ARP requests that reach sensitive servers on the corporate network. By placing guest users in VLAN 10 and servers in VLAN 20, lateral movement requires the attacker to first escape their segment — typically by exploiting a **VLAN hopping** attack using double-tagging 802.1Q frames to trick a misconfigured trunk port into forwarding traffic to a restricted VLAN.

## Key facts
- **802.1Q** is the IEEE standard that tags Ethernet frames with a 12-bit VLAN ID, supporting up to **4,094 unique VLANs** (IDs 1 and 4095 are reserved)
- **VLAN hopping** exploits the native VLAN on trunk ports; mitigation is setting the native VLAN to an unused ID and disabling DTP (Dynamic Trunking Protocol)
- Inter-VLAN routing requires a **Layer 3 device** (router or Layer 3 switch) — VLANs themselves do *not* route traffic between segments
- **Port security** and **Private VLANs (PVLANs)** extend segmentation further, isolating even hosts within the same VLAN
- VLANs are a **defense-in-depth** control; they limit broadcast domains but are NOT a substitute for firewalls between sensitive segments

## Related concepts
[[Network Segmentation]] [[802.1Q Tagging]] [[VLAN Hopping]] [[Trunk Ports]] [[Defense in Depth]]