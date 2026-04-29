# Cisco Catalyst 3850

## What it is
Think of it as the air traffic controller of a corporate floor — it doesn't just move packets, it inspects, prioritizes, and enforces rules on every plane before it taxis. The Cisco Catalyst 3850 is a stackable Layer 2/3 enterprise access switch that combines wired and wireless LAN control into a single platform, capable of acting as a Wireless LAN Controller (WLC) for up to 50 access points natively. It supports full StackWise-480 technology, allowing multiple switches to operate as a single logical unit with up to 480 Gbps of stack bandwidth.

## Why it matters
In a real-world penetration test, an attacker who gains access to a misconfigured 3850's management interface via default credentials or unpatched IOS XE firmware can pivot laterally across every VLAN the switch trunks — effectively owning network segmentation. Defenders rely on the 3850's integrated 802.1X port authentication and DHCP snooping features to prevent rogue devices from ever getting a foothold on the wire.

## Key facts
- Runs **Cisco IOS XE**, which has had critical CVEs (e.g., CVE-2018-0171, "Smart Install" exploit) enabling unauthenticated remote code execution
- Supports **DHCP snooping**, **Dynamic ARP Inspection (DAI)**, and **IP Source Guard** — the core triad of Layer 2 attack mitigation
- **802.1X** with MAB (MAC Authentication Bypass) fallback is a standard deployment pattern for NAC enforcement
- Default VLAN 1 should always be pruned from trunks — a classic hardening misconfiguration finding on 3850 deployments
- Supports **MACsec (802.1AE)** for hop-by-hop Layer 2 encryption between switches and endpoints

## Related concepts
[[802.1X Network Access Control]] [[VLAN Hopping]] [[Dynamic ARP Inspection]] [[MACsec]] [[Smart Install Exploitation]]