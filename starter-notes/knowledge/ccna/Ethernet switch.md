# Ethernet switch

## What it is
Like a postal sorting facility that reads each envelope's address and routes it only to the correct mailbox — not the entire street — an Ethernet switch is a Layer 2 network device that forwards frames based on MAC addresses to specific ports rather than broadcasting to all connected devices. It maintains a MAC address table (CAM table) to learn which devices live on which ports, enabling efficient, point-to-point communication within a LAN.

## Why it matters
In a **MAC flooding attack**, an attacker floods the switch with thousands of spoofed MAC addresses, exhausting the CAM table. Once full, the switch fails open and begins broadcasting all traffic to every port — effectively turning into a hub — allowing the attacker to sniff credentials and sensitive data passively. Defenders counter this with **port security**, which limits the number of MAC addresses permitted per port.

## Key facts
- Switches operate at **Layer 2 (Data Link)** of the OSI model; Layer 3 switches also perform routing functions
- The **CAM table** maps MAC addresses to physical ports; default aging time is typically 300 seconds
- **VLANs** are implemented on switches to segment traffic, isolating broadcast domains for security zoning (e.g., separating guest Wi-Fi from corporate traffic)
- **VLAN hopping** attacks exploit trunk port misconfigurations (switch spoofing or double-tagging) to jump between VLANs without authorization
- **Spanning Tree Protocol (STP)** prevents Layer 2 loops but can be abused — an attacker sending superior BPDUs can become root bridge and intercept traffic

## Related concepts
[[MAC Flooding]] [[VLAN Hopping]] [[Port Security]] [[ARP Spoofing]] [[Rapid Spanning Tree Protocol]]
