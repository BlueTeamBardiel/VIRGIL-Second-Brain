# IP subnet

## What it is
Think of a city divided into postal districts — mail within the same district gets delivered locally, while mail to another district routes through a central hub. An IP subnet is a logically segmented portion of a larger IP network, defined by a subnet mask that determines which bits of an address identify the network versus the host. Subnetting allows a single IP block to be divided into smaller, isolated broadcast domains.

## Why it matters
Network segmentation via subnets is a foundational defense-in-depth control. In a ransomware incident, properly isolated subnets (e.g., separating OT/SCADA systems from corporate workstations) can stop lateral movement cold — the malware can't reach a neighboring subnet without traversing a router or firewall where ACLs can block it. Attackers who compromise one subnet must work significantly harder to pivot to a payment system or domain controller on a separate subnet.

## Key facts
- A **/24 subnet** (255.255.255.0) provides 256 addresses, with 254 usable hosts (first = network address, last = broadcast).
- CIDR notation expresses subnet masks as prefix lengths (e.g., /16 = 65,534 usable hosts).
- Subnets communicate via **Layer 3 routing** — traffic between subnets must pass through a router or Layer 3 switch, enabling firewall/ACL enforcement at boundaries.
- **VLSM (Variable Length Subnet Masking)** allows subnets of different sizes within the same network, optimizing IP address utilization.
- For Security+: subnetting supports the principle of **least privilege at the network layer** by limiting which hosts can communicate by default.

## Related concepts
[[Network Segmentation]] [[VLAN]] [[Access Control List]] [[CIDR]] [[Lateral Movement]]