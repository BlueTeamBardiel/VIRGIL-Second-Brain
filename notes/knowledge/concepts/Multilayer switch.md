# multilayer switch

## What it is
Think of a post office that not only sorts mail by neighborhood (Layer 2) but also reads the full address to decide the fastest delivery route (Layer 3) — all without slowing down. A multilayer switch is a network device that performs both MAC-address-based switching at Layer 2 *and* IP-based routing at Layer 3 (and sometimes Layer 4+) in hardware using ASICs, combining the speed of a switch with the intelligence of a router.

## Why it matters
In a segmented enterprise network, a multilayer switch enforces inter-VLAN routing while applying Access Control Lists (ACLs) to block lateral movement between departments. An attacker who compromises a workstation in the HR VLAN and attempts to pivot to the finance VLAN will hit ACL rules enforced directly on the switch, stopping east-west traffic without the packet ever leaving the building to reach a dedicated router.

## Key facts
- Performs **inter-VLAN routing** natively, eliminating the need for a separate router-on-a-stick configuration
- Uses **hardware-based forwarding** (ASICs/CAM tables), making it significantly faster than software-based routing
- Can enforce **Layer 3/4 ACLs** to control traffic between VLANs, acting as a first line of segmentation defense
- Supports **Port Security, 802.1X**, and **DHCP snooping** — security controls commonly tested on Security+
- **VLAN hopping attacks** (double-tagging or switch spoofing) target the Layer 2 component; proper trunk hardening on multilayer switches mitigates this
- Operates on the principle of **"route once, switch many"** — the first packet is routed, subsequent packets are switched at wire speed

## Related concepts
[[VLAN]] [[inter-VLAN routing]] [[access control list]] [[network segmentation]] [[VLAN hopping]]