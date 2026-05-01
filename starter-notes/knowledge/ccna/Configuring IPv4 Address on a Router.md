# Configuring IPv4 Address on a Router

## What it is
Like assigning a street address to a building so mail can find it, configuring an IPv4 address on a router interface gives that interface a specific 32-bit logical address so traffic can be routed to and from connected networks. Each active router interface requires an IP address and subnet mask that places it within the correct network segment. Without this configuration, the interface remains "administratively down" and cannot forward packets.

## Why it matters
During a network segmentation audit, a misconfigured router interface IP address — such as placing a router in the wrong subnet — can accidentally bridge a DMZ directly to an internal corporate network. An attacker on the DMZ could then reach internal hosts that should be isolated, bypassing firewall rules entirely. Correct interface IP assignment is foundational to enforcing network segmentation controls.

## Key facts
- Router interfaces are **shutdown by default** on Cisco devices; both an IP address *and* the `no shutdown` command are required to activate them
- Each interface connecting two networks must have an IP address in the **same subnet as the hosts** it serves — typically the first or last usable address by convention
- A single physical interface can host **secondary IP addresses**, supporting multiple subnets (useful but a common misconfiguration source)
- IPv4 addresses are configured at **Layer 3**; the interface also needs Layer 1/2 to be up for full connectivity ("line protocol up")
- Subnet mask errors (e.g., /24 vs /25) create **split-brain routing** where hosts believe they're on the same network but the router disagrees, causing silent packet drops

## Related concepts
[[Subnetting and CIDR Notation]] [[Network Segmentation]] [[Default Gateway Configuration]]
