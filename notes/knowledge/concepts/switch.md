# switch

## What it is
Like a smart postal sorting facility that reads the destination address on every envelope and delivers it only to the correct mailbox — a network switch forwards frames based on MAC addresses, creating dedicated communication channels between devices rather than broadcasting traffic everywhere. It operates at Layer 2 (Data Link) of the OSI model, maintaining a MAC address table to make intelligent forwarding decisions.

## Why it matters
Switches were once considered a security upgrade over hubs because traffic is isolated per port, making passive eavesdropping harder. However, an attacker can flood a switch with fake MAC addresses (MAC flooding), overwhelming the MAC table and forcing the switch to fail open — behaving like a hub and broadcasting all traffic, enabling a Wireshark capture to grab credentials in cleartext.

## Key facts
- Switches operate at **Layer 2** (Data Link); Layer 3 switches add routing capability at the Network layer
- **MAC flooding** attacks exploit the finite size of the CAM/MAC address table — mitigated by **port security** (limiting MAC addresses per port)
- **VLAN hopping** (via switch spoofing or double tagging) allows an attacker to send traffic across VLAN boundaries that should be segregated
- **Spanning Tree Protocol (STP)** attacks can let an attacker become the root bridge, redirecting traffic through a malicious device — mitigated by **BPDU Guard**
- Port security features include: sticky MAC learning, violation modes (shutdown, restrict, protect), and 802.1X port-based authentication

## Related concepts
[[MAC Flooding]] [[VLAN]] [[Port Security]] [[Spanning Tree Protocol]] [[802.1X]]