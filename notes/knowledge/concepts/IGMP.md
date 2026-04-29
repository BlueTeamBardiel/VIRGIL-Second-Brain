# IGMP

## What it is
Think of IGMP as the sign-up sheet for a concert livestream — it lets devices tell the local router "I want to receive this multicast feed" without wasting bandwidth on everyone else. Internet Group Management Protocol (IGMP) is a network-layer protocol (Layer 3) used by IPv4 hosts to join and leave multicast groups, enabling routers to track which segments need multicast traffic. It operates between hosts and their directly connected routers, not end-to-end.

## Why it matters
Attackers exploit IGMP through **IGMP flooding**, a denial-of-service technique where forged IGMP join messages overwhelm switches lacking multicast snooping, forcing them to broadcast multicast traffic out every port and saturating the network. This was a practical concern in older LAN environments and is still relevant in unmanaged switch deployments. Defenders counter this by enabling **IGMP snooping** on managed switches, which constrains multicast traffic to only the ports with legitimate subscribers.

## Key facts
- IGMP operates at **Layer 3** and sits directly atop IPv4 (protocol number **2** in the IP header)
- Three major versions: IGMPv1 (basic join), IGMPv2 (adds explicit leave messages), IGMPv3 (source-specific multicast filtering)
- **IGMP snooping** is the primary defensive control — allows Layer 2 switches to inspect IGMP messages and limit multicast forwarding scope
- IGMP has **no built-in authentication**, making it trivially spoofable; source IP validation is not enforced
- IPv6 replaces IGMP entirely with **MLD (Multicast Listener Discovery)**, which runs over ICMPv6
- Multicast addresses in the **224.0.0.0/4** range are managed using IGMP

## Related concepts
[[Multicast Routing]] [[IGMP Snooping]] [[Denial of Service]] [[MLD (Multicast Listener Discovery)]] [[Network Flooding Attacks]]