# IPv4 Subnetting

## What it is
Like dividing a large office building into locked floors where employees on floor 3 can't wander into floor 7 without going through a controlled checkpoint — subnetting carves a single IP address space into smaller, isolated logical networks. Precisely: subnetting uses a subnet mask to split an IPv4 address into a network portion and a host portion, enabling traffic segmentation within a larger address block.

## Why it matters
A compromised workstation on a flat (unsubnetted) network can freely communicate with every other host, including servers holding sensitive data — this is exactly how lateral movement works in ransomware campaigns. Subnetting enforces network segmentation so that a compromised machine in the guest VLAN cannot directly reach the finance subnet (192.168.10.0/24 vs 192.168.20.0/24), forcing attackers through routers and firewalls where detection controls live.

## Key facts
- A **/24** subnet mask (255.255.255.0) provides 254 usable hosts; the first address is network ID, the last is broadcast — both unusable
- CIDR notation counts the **1-bits** in the mask: /25 = 255.255.255.128, splitting a /24 into two equal halves of 126 usable hosts each
- The formula for usable hosts is **2ⁿ − 2**, where *n* = number of host bits
- Private address ranges (RFC 1918): **10.0.0.0/8**, **172.16.0.0/12**, **192.168.0.0/16** — these never route on the public internet
- A **/30** (4 addresses, 2 usable) is the standard for **point-to-point router links**, minimizing wasted address space

## Related concepts
[[Network Segmentation]] [[VLAN]] [[Access Control Lists]]