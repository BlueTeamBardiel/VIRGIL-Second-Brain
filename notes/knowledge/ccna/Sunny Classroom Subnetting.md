# Sunny Classroom Subnetting

## What it is
Imagine a school where every classroom gets its own hallway, a locked door, and a dedicated set of desks — students can't wander into other classrooms uninvited. Subnetting works the same way: it divides a single IP network into smaller, logically isolated segments called subnets, each defined by a subnet mask that determines which bits identify the network versus individual hosts. CIDR notation (e.g., 192.168.1.0/24) expresses this boundary precisely, where the prefix length tells you how many bits are "locked" to the network portion.

## Why it matters
In 2013, Target's breach spread from a compromised HVAC vendor because the vendor's network had direct access to the payment card environment — a flat network with no subnetting. Proper subnetting with access controls between subnets would have contained the attacker's lateral movement, preventing the theft of 40 million credit card records. Subnetting is therefore a foundational network segmentation control in every defense-in-depth architecture.

## Key facts
- A /24 subnet provides 256 total addresses, 254 usable (first = network address, last = broadcast address)
- Subnet mask 255.255.255.0 equals /24; 255.255.255.128 equals /25, halving the host space
- Subnetting reduces broadcast domains, limiting the blast radius of ARP floods and certain reconnaissance scans
- VLSM (Variable Length Subnet Masking) allows different-sized subnets within the same network, optimizing IP address space
- Security+ expects you to calculate usable hosts: 2^(host bits) − 2 (e.g., /26 → 2^6 − 2 = 62 hosts)

## Related concepts
[[Network Segmentation]] [[VLANs]] [[Defense in Depth]] [[Access Control Lists]] [[Zero Trust Architecture]]