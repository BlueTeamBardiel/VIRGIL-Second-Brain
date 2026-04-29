# Network switching

## What it is
Like a postal sorting facility that reads the destination address on each envelope and routes it only to the correct mailbox rather than stuffing every box on the street, a network switch forwards frames based on MAC addresses to specific ports rather than broadcasting to everyone. Switches operate at Layer 2 (Data Link) of the OSI model, maintaining a MAC address table (CAM table) to map hardware addresses to physical ports.

## Why it matters
In a **MAC flooding attack**, an adversary bombards a switch with thousands of fake MAC addresses, overflowing the CAM table. Once full, the switch fails open and begins broadcasting all traffic to every port — effectively turning into a hub — allowing the attacker to sniff credentials and session tokens with a tool like Ettercap or Wireshark.

## Key facts
- Switches build their CAM table dynamically by learning the source MAC of incoming frames; this learning process is what MAC flooding exploits
- **VLAN segmentation** divides a physical switch into isolated broadcast domains, containing lateral movement even if one segment is compromised
- **Port security** limits the number of MAC addresses allowed per port (or pins specific MACs), directly mitigating MAC flooding and rogue device insertion
- **802.1Q VLAN tagging** can be abused via **VLAN hopping** (double-tagging or switch spoofing) to send traffic into a VLAN the attacker shouldn't reach
- Spanning Tree Protocol (STP) prevents Layer 2 loops but can be attacked via rogue BPDUs to force a topology change and redirect traffic

## Related concepts
[[MAC Address Spoofing]] [[VLAN Hopping]] [[ARP Poisoning]] [[Port Security]] [[Spanning Tree Protocol]]