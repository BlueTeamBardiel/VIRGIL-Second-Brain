# South-Bound API

## What it is
Think of a restaurant manager who translates customer orders into specific kitchen instructions — the south-bound API is that manager, sitting between the network controller and the actual physical or virtual devices below it. In Software-Defined Networking (SDN), the south-bound API is the communication interface that allows the centralized control plane to program and manage the data plane (switches, routers, and other forwarding devices). Protocols like OpenFlow, NETCONF, and OVSDB are common south-bound API implementations.

## Why it matters
In an SDN environment, if an attacker compromises the south-bound API channel — particularly if it lacks mutual authentication — they can inject malicious flow rules directly into network switches, redirecting traffic through an attacker-controlled node for interception or manipulation. This effectively gives the attacker control-plane-level power without ever touching the SDN controller itself. Defenders must enforce TLS encryption and certificate-based authentication on all south-bound communications to prevent this.

## Key facts
- South-bound APIs sit **below** the SDN controller, communicating downward to network devices (contrast with north-bound APIs, which face applications and orchestration layers above)
- **OpenFlow** is the most widely recognized south-bound protocol, standardized by the Open Networking Foundation (ONF)
- **NETCONF** (RFC 6241) uses XML-based RPCs over SSH and is common in enterprise and carrier-grade SDN deployments
- A compromised south-bound channel can allow **flow table poisoning** — attackers inject rules to drop, duplicate, or reroute packets
- South-bound APIs are a **high-value lateral movement target** because controlling them equals controlling physical network behavior at scale

## Related concepts
[[Software-Defined Networking]] [[North-Bound API]] [[OpenFlow]] [[Control Plane]] [[Network Segmentation]]