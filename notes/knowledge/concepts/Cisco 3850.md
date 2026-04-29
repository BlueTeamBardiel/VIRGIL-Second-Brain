# Cisco 3850

## What it is
Think of it as a traffic cop standing at every intersection in a city simultaneously — the Cisco Catalyst 3850 is a stackable, enterprise-grade Layer 2/3 access and distribution switch that handles both wired switching and wireless LAN controller (WLC) functions in a single chassis. It runs Cisco IOS XE and supports full 802.11ac Wave 2 wireless integration natively. Up to nine units can be stacked together acting as a single logical switch.

## Why it matters
In a penetration test or incident response scenario, a misconfigured 3850 with default VLAN 1 active on all trunk ports becomes a pivot point — an attacker exploiting VLAN hopping via double-tagging can jump from a guest network segment directly into the corporate LAN. Defenders use the 3850's port security, Dynamic ARP Inspection (DAI), and IP Source Guard features specifically to prevent such lateral movement at the access layer.

## Key facts
- Supports **StackWise-480** technology, providing 480 Gbps of stack bandwidth across stacked units
- Runs **Cisco IOS XE**, which separates the control plane from the data plane — relevant for understanding software-defined security controls
- Native integration with **Cisco Identity Services Engine (ISE)** enables 802.1X port-based Network Access Control (NAC) directly on the switch
- **DHCP Snooping** is a critical hardening feature on this platform — it builds a binding table used by DAI and IP Source Guard to block rogue DHCP servers
- CVE-2018-0150 is a notable IOS XE vulnerability affecting Catalyst switches: a **hardcoded credential** in a default account enabled remote root access

## Related concepts
[[VLAN Hopping]] [[802.1X Network Access Control]] [[Dynamic ARP Inspection]] [[DHCP Snooping]] [[Network Segmentation]]