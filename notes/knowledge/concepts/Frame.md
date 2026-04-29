# Frame

## What it is
Like an envelope that wraps a letter for delivery through a specific postal system, a frame is a Protocol Data Unit (PDU) at Layer 2 (Data Link Layer) of the OSI model that encapsulates a packet for transmission across a local network segment. It contains source and destination MAC addresses, a payload (the Layer 3 packet), and a Frame Check Sequence (FCS) for error detection.

## Why it matters
In a MAC flooding attack, an attacker floods a switch with thousands of frames containing spoofed source MAC addresses, exhausting the switch's CAM table. Once full, the switch degrades into hub-like behavior — broadcasting all frames to every port — allowing the attacker to capture traffic not intended for their machine, effectively executing passive sniffing on a switched network.

## Key facts
- A standard Ethernet frame has a maximum size of **1518 bytes** (1500 bytes payload + 18 bytes header/trailer); exceeding this produces a "jumbo frame" or is flagged as a potential attack vector
- The **Frame Check Sequence (FCS)** uses CRC-32 for error detection — but provides no integrity *protection* (it detects corruption, not tampering)
- **VLAN tagging (802.1Q)** adds a 4-byte tag inside the frame header, enabling VLAN hopping attacks via double-tagging
- Frames operate at **Layer 2** and are stripped/rebuilt at every router hop (routers operate at Layer 3, so they discard frames)
- **Rogue frames** with crafted 802.1X EAP data can be used to exploit misconfigured network access control systems during authentication bypass attacks

## Related concepts
[[MAC Address]] [[VLAN Hopping]] [[CAM Table Overflow]] [[OSI Model]] [[ARP Spoofing]]