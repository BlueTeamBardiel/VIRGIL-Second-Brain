# bridge MRP

## What it is
Like a traffic cop at a busy intersection who designates one officer as the authority to prevent gridlock, MRP (Multiple Registration Protocol) on bridges lets switches coordinate which device "owns" a given MAC or VLAN registration — eliminating duplicate announcements. Precisely, Bridge MRP is an IEEE 802.1ak protocol that allows network bridges to dynamically register and deregister attributes (like VLANs or multicast group memberships) across a bridged LAN, replacing the older GVRP protocol.

## Why it matters
An attacker with physical or logical access to a trunk port can craft malicious MRP PDUs (Protocol Data Units) to spoof VLAN registrations, effectively injecting themselves into VLANs they should never see — a form of VLAN hopping without requiring double-tagging. Defenders counter this by applying strict port-based access controls, disabling MRP on untrusted edge ports, and monitoring for unexpected VLAN registration changes in switch logs.

## Key facts
- MRP is defined in **IEEE 802.1ak** and replaces GVRP (GARP VLAN Registration Protocol) and GMRP
- It uses three applications: **MVRP** (VLAN registration), **MMRP** (multicast registration), and MRP itself as the underlying state-machine engine
- MRP operates through **join, leave, and leaveAll** messages — attackers spoofing "join" messages can register unauthorized VLANs
- Disabling **MVRP on access ports** (ports facing end users) is a hardening baseline to prevent unauthorized VLAN propagation
- MRP PDUs use the **Nearest Bridge group MAC address (01:80:C2:00:00:21)** and are not forwarded beyond the local bridge — limiting but not eliminating risk

## Related concepts
[[VLAN Hopping]] [[Spanning Tree Protocol]] [[802.1Q Trunk Security]]