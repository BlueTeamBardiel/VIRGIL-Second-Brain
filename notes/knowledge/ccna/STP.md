# STP

## What it is
Like a building's fire suppression system that automatically reroutes sprinklers when a pipe bursts, STP (Spanning Tree Protocol) automatically reconfigures network paths to eliminate loops when switches are added or fail. It is a Layer 2 protocol (IEEE 802.1D) that prevents broadcast storms by calculating a loop-free logical topology, electing a root bridge and blocking redundant ports.

## Why it matters
Attackers exploit STP through **STP manipulation attacks**: by connecting a rogue switch and sending crafted Bridge Protocol Data Units (BPDUs) with a superior priority value, an attacker can trigger a root bridge election and win it — forcing all traffic to flow through their device for man-in-the-middle interception. This attack is silent, requires only physical or logical Layer 2 access, and can redirect an entire VLAN's traffic with minimal tooling.

## Key facts
- **Root bridge election** is based on the lowest Bridge ID (priority + MAC); attackers set priority to 0 to win
- **BPDU Guard** is the primary defense — it disables a port immediately if any BPDU is received on an access port (PortFast-enabled ports)
- **Root Guard** prevents a port from becoming a root port, protecting existing root bridge placement
- STP convergence creates a **30–50 second outage** during topology changes (Rapid STP / 802.1w reduces this to ~1 second)
- **PortFast** should only be enabled on end-device ports; enabling it on trunk ports creates loop risk

## Related concepts
[[VLAN Hopping]] [[MAC Flooding]] [[Network Segmentation]] [[802.1Q Trunking]] [[Defense in Depth]]