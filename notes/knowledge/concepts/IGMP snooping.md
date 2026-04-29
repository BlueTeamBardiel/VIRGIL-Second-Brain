# IGMP snooping

## What it is
Think of it like a postal worker who reads the addresses on group mailing list subscriptions before delivering packages — instead of flooding every apartment, they only deliver to units that actually signed up. IGMP snooping is a Layer 2 switch feature that inspects IGMP (Internet Group Management Protocol) messages to build a table of which ports have hosts that want specific multicast traffic. Rather than flooding multicast frames to all ports like a broadcast, the switch delivers them only to interested ports.

## Why it matters
Without IGMP snooping enabled, a switch treats multicast traffic like a broadcast storm — every port receives every multicast stream. An attacker on a segmented network could exploit this to passively capture multicast-delivered data (OSPF routing updates, IPTV streams, financial ticker feeds) that should never reach their segment. Enabling IGMP snooping closes this unintended information exposure by containing multicast to legitimate subscribers only.

## Key facts
- IGMP snooping operates at **Layer 2** but inspects **Layer 3** IGMP messages — making it a cross-layer feature distinct from standard switching
- Without it, a single high-bandwidth multicast stream (e.g., video surveillance feeds) can consume bandwidth on every port, enabling a **denial-of-service condition** through multicast flooding
- It maintains a **multicast forwarding table** mapping multicast group addresses to specific switch ports
- IGMP snooping helps prevent **multicast-based reconnaissance** — attackers cannot silently receive OSPF Hello packets or other protocol multicast traffic they haven't legitimately joined
- It works alongside a **Querier** (typically the router) that sends periodic IGMP queries; if no querier exists, the switch can act as one

## Related concepts
[[IGMP]] [[Multicast security]] [[Network segmentation]] [[VLAN security]] [[Broadcast domain]]