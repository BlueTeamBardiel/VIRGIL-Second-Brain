# subnet mask

## What it is
Think of a subnet mask like a zip code on a mailing address — it tells the postal system which part of the address identifies the neighborhood versus the specific house. Precisely, a subnet mask is a 32-bit number applied via bitwise AND to an IP address to separate the **network portion** from the **host portion**, determining which devices can communicate directly without a router. For example, a mask of `255.255.255.0` (`/24`) means the first 24 bits identify the network and the last 8 bits identify individual hosts.

## Why it matters
Network segmentation — a core defense strategy — relies entirely on subnet masks to isolate sensitive systems like PCs in a payment network from general corporate traffic. An attacker who compromises one host on a `/24` network can sweep all 254 possible host addresses locally without touching a router, making improper subnet sizing a direct amplifier of lateral movement risk. Defenders use tighter masks (e.g., `/28`, giving only 14 hosts) to shrink blast radius.

## Key facts
- A `/24` mask = `255.255.255.0` = 256 addresses, 254 usable (network and broadcast addresses are reserved)
- CIDR notation expresses subnet masks as prefix length (e.g., `/16` = `255.255.0.0`)
- Hosts on different subnets **must** pass through a router (Layer 3 device) to communicate
- Variable Length Subnet Masking (VLSM) allows different-sized subnets within the same network, reducing wasted IPs
- Default subnet masks: Class A = `/8`, Class B = `/16`, Class C = `/24` — still tested on Security+ despite classful networking being largely obsolete

## Related concepts
[[network segmentation]] [[CIDR notation]] [[VLAN]] [[routing]] [[firewall rules]]