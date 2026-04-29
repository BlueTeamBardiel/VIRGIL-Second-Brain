# Link Layer Discovery Protocol

## What it is
Like neighbors sliding business cards under each other's doors to announce who they are and what services they offer, LLDP is a vendor-neutral Layer 2 protocol that lets network devices periodically broadcast their identity and capabilities to directly connected neighbors. Defined in IEEE 802.1AB, devices advertise information like hostname, port ID, VLAN membership, and system capabilities to adjacent devices only — frames never cross routers.

## Why it matters
During a penetration test or after an attacker gains physical or logical access to a network port, passively sniffing LLDP traffic can reveal a detailed topology map within minutes — switch model, firmware version, management IP, and VLAN structure — without sending a single packet. This reconnaissance is completely passive and generates no alerts, making it a dangerous information leakage vector in environments where LLDP is left enabled on user-facing ports.

## Key facts
- LLDP operates at Layer 2 only; advertisements are sent to the multicast MAC address `01:80:C2:00:00:0E` and are never forwarded by routers
- Default advertisement interval is **30 seconds**; TTL is typically 120 seconds
- Information is stored in **LLDP-MED (Media Endpoint Discovery)** extensions, which additionally support VoIP device discovery and PoE negotiation — expanding the attack surface
- LLDP should be **disabled on all access/edge ports** facing end users or untrusted devices; only trunk/uplink ports between infrastructure devices should use it
- Cisco's proprietary equivalent is **CDP (Cisco Discovery Protocol)** — both leak similar topology intelligence and carry the same risks

## Related concepts
[[CDP (Cisco Discovery Protocol)]] [[Network Reconnaissance]] [[VLAN Hopping]] [[Passive Sniffing]]