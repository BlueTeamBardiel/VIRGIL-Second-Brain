# subnets

## What it is
Think of a large office building divided into locked wings — HR can't wander into Engineering without a keycard, even though they share the same building. A subnet (subnetwork) is a logically segmented portion of a larger IP network, defined by a subnet mask that determines which bits of an IP address identify the network versus the host. All devices within a subnet communicate directly; traffic crossing subnet boundaries must pass through a router.

## Why it matters
During a ransomware outbreak, proper subnetting is the difference between one infected workstation and a company-wide catastrophe. If the finance VLAN and the manufacturing floor are on separate subnets with firewall rules between them, lateral movement is choked at the boundary — the attacker can't pivot from a compromised laptop to a SCADA controller without traversing a controlled chokepoint where detection and blocking occur.

## Key facts
- A subnet mask like **255.255.255.0 (/24)** gives 254 usable host addresses; the first address is the network ID and the last is the broadcast address.
- **CIDR notation** (e.g., 192.168.1.0/24) compactly expresses both the network address and the mask in one value — Security+ expects you to calculate usable hosts: 2^(32−prefix) − 2.
- Subnetting supports the **principle of least privilege** at the network layer by restricting which systems can reach each other by default.
- **Private IP ranges** (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) are non-routable on the public internet and typically subdivided internally using subnets.
- A **/30 subnet** (4 addresses, 2 usable) is the standard choice for point-to-point router links, minimizing wasted address space.

## Related concepts
[[network segmentation]] [[VLANs]] [[firewall rules]] [[CIDR]] [[lateral movement]]