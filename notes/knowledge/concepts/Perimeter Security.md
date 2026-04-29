# Perimeter Security

## What it is
Think of a medieval castle: the moat, drawbridge, and outer walls exist to stop attackers before they ever reach the throne room. Perimeter security is the layered set of controls — firewalls, DMZs, IDS/IPS, and access control barriers — deployed at the boundary between a trusted internal network and untrusted external networks. The goal is to detect, filter, and block threats at the edge rather than fighting them inside your own walls.

## Why it matters
In the 2013 Target breach, attackers entered through a third-party HVAC vendor's credentials, bypassing the outer perimeter via a trusted VPN connection. Once inside, there was insufficient internal segmentation to stop lateral movement — illustrating both the value of perimeter controls and their single-point-of-failure risk when over-relied upon. This attack directly accelerated the industry shift toward Zero Trust, where the perimeter is treated as already compromised.

## Key facts
- A **DMZ (demilitarized zone)** places public-facing servers (web, email, DNS) in a buffer zone between two firewalls, so a compromised server cannot directly reach the internal LAN
- **Stateful firewalls** track active connections and block unsolicited inbound traffic; **stateless packet filters** evaluate each packet independently and are easier to bypass
- **IDS** (Intrusion Detection System) passively monitors and alerts; **IPS** (Intrusion Prevention System) sits inline and can actively block traffic
- Perimeter security follows a **default-deny** philosophy: everything not explicitly permitted is blocked
- Perimeter-only defense is increasingly insufficient — modern threats like **insider attacks**, encrypted C2 traffic, and cloud workloads operate inside or bypass the traditional perimeter entirely

## Related concepts
[[Firewall]] [[DMZ]] [[Zero Trust Architecture]] [[Intrusion Detection System]] [[Network Segmentation]]