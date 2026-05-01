# subnetting

## What it is
Think of a large office building where each floor has its own locked stairwell — tenants on Floor 3 can't wander into Floor 7's space without passing through a checkpoint. Subnetting is the practice of dividing a single IP network into smaller, logically isolated segments called subnets, each defined by a subnet mask that determines which bits of an IP address identify the network versus the host. This is done using CIDR notation (e.g., 192.168.1.0/24), where the prefix length specifies how many bits belong to the network portion.

## Why it matters
During a network intrusion, an attacker who compromises a workstation on a flat, unsubnetted network can freely scan and pivot to critical servers, domain controllers, and IoT devices without restriction. Proper subnetting combined with ACLs and firewall rules creates **containment zones** — a compromised machine in the /24 guest subnet cannot directly reach the /24 server subnet, forcing lateral movement through a chokepoint where defenders can detect and block it. This is the architectural backbone of network segmentation strategy.

## Key facts
- A **/24** subnet provides 256 addresses (254 usable hosts); a **/25** splits it in half, giving 128 addresses per subnet (126 usable each)
- The **subnet mask** defines network vs. host bits: 255.255.255.0 = /24; 255.255.255.128 = /25
- **VLSM (Variable Length Subnet Masking)** allows different-sized subnets within the same network, enabling efficient IP space allocation
- Subnetting supports **Zero Trust** architecture by enforcing least-privilege network access between zones
- Security+ exam frequently tests CIDR calculations: /32 = single host; /0 = all IP addresses (default route)

## Related concepts
[[network segmentation]] [[VLAN]] [[access control lists]] [[CIDR notation]] [[DMZ]]
