# Plane

## What it is
Think of a highway system with separate lanes for cargo trucks, emergency vehicles, and regular commuters — each lane exists on the same road but operates under different rules and access controls. In networking and security architecture, a "plane" refers to a distinct functional layer of a system that handles a specific category of operations, most commonly the **control plane** (routing decisions), **data plane** (actual packet forwarding), and **management plane** (administrative access).

## Why it matters
Attackers who compromise the management plane of a network device — say, via an exposed SSH interface with default credentials — gain the ability to reconfigure routing tables and firewall rules without ever touching the data plane traffic directly. This is why network hardening standards require strict separation and access control lists (ACLs) specifically protecting management plane interfaces, often restricting administrative access to dedicated out-of-band management networks.

## Key facts
- **Control plane**: Makes routing and switching decisions (e.g., OSPF, BGP protocol operation); if compromised, attackers can redirect traffic.
- **Data plane**: Forwards packets based on the control plane's decisions; operates at wire speed with minimal inspection.
- **Management plane**: Handles device administration (SSH, SNMP, web GUI); the highest-value target for attackers seeking persistent control.
- **Control Plane Policing (CoPP)** is a Cisco-specific hardening technique that rate-limits traffic destined for the control plane to prevent CPU exhaustion attacks.
- SDN (Software-Defined Networking) explicitly decouples the control and data planes, centralizing control in a software controller — creating a single high-value target if not properly secured.

## Related concepts
[[Software-Defined Networking]] [[Network Segmentation]] [[Management Plane Hardening]] [[Access Control Lists]]