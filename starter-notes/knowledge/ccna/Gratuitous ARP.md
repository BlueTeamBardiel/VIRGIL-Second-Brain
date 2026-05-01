# Gratuitous ARP

## What it is
Imagine someone walking into a crowded office and loudly announcing "Hey everyone — my desk is now at seat 42, update your contacts!" even though nobody asked. A Gratuitous ARP (GARP) is an unsolicited ARP reply a device broadcasts onto the network, announcing its own IP-to-MAC mapping without any prior ARP request. It's used legitimately for cache updates after IP changes or NIC replacements, but it's also the core mechanism behind ARP poisoning attacks.

## Why it matters
An attacker on a local network segment can flood the network with crafted Gratuitous ARPs, falsely claiming their MAC address corresponds to the gateway's IP (e.g., 192.168.1.1). Every host that receives it blindly updates its ARP cache, redirecting all traffic through the attacker's machine — a classic Man-in-the-Middle (MitM) setup enabling credential harvesting or traffic manipulation without any authentication required.

## Key facts
- GARPs are **broadcast packets** (destination MAC: FF:FF:FF:FF:FF:FF) sent by a host about its own IP address — no request precedes them
- Most operating systems **accept and cache** unsolicited GARP replies by default, with no verification mechanism in standard ARP (RFC 826)
- **Dynamic ARP Inspection (DAI)** on managed switches mitigates GARP-based attacks by validating ARP packets against a trusted DHCP snooping binding table
- Tools like **Arpspoof (dsniff suite)** and **Ettercap** weaponize GARPs for ARP poisoning on local segments
- GARPs are also used **legitimately** in high-availability clustering (e.g., VRRP/HSRP failover) to announce a new active node's MAC address rapidly

## Related concepts
[[ARP Poisoning]] [[Dynamic ARP Inspection]] [[Man-in-the-Middle Attack]]
