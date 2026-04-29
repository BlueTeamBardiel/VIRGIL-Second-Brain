# DTP

## What it is
Like a new employee who walks into the office and starts rearranging the org chart because nobody told them not to — DTP (Dynamic Trunking Protocol) is a Cisco proprietary protocol that automatically negotiates trunk links between switches, allowing VLANs to traverse multiple network segments without manual configuration.

## Why it matters
An attacker on an access port can send DTP negotiation frames to trick the switch into establishing a trunk link, a technique called a **VLAN hopping attack**. Once trunking is negotiated, the attacker gains access to traffic from all VLANs on that switch, effectively jumping out of their isolated network segment into areas they should never see.

## Key facts
- DTP operates in several modes: **Auto**, **Desirable**, **Trunk**, **Access**, and **Nonegotiate** — only `switchport nonegotiate` fully disables DTP negotiation
- VLAN hopping via DTP is possible when a port is left in **Auto** or **Desirable** mode (the defaults on many Cisco switches)
- The fix is to explicitly set user-facing ports to **access mode** (`switchport mode access`) and disable DTP negotiation entirely
- DTP frames use the **destination MAC address 01:00:0C:CC:CC:CC**, the same multicast group used by CDP and VTP
- Native VLAN mismatches can compound the risk — VLAN 1 is the default native VLAN and should be changed as a hardening practice

## Related concepts
[[VLAN Hopping]] [[802.1Q Trunking]] [[Network Segmentation]] [[Switch Security Hardening]]