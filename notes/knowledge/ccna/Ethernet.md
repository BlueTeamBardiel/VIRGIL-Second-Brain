# Ethernet

## What it is

A LAN party in someone's basement: everyone's machines are plugged into the same switch, and traffic gets to the right rig because each network card has a unique sticker on it (the MAC address). That's Ethernet — the Layer 2 wired standard that moves data between devices on the same local network segment using MAC addresses as nametags.

When your computer wants to send data, it wraps the payload in an **Ethernet frame**: a structured envelope with the recipient's MAC, your MAC, a type code (so the receiver knows what's inside), the actual data, and a checksum at the end so corruption gets caught. The switch reads the destination MAC, checks its table, and shoves the frame out the right port. Done.

## Why it matters

Ethernet is the substrate. Every Wi-Fi access point, every data center spine switch, every gaming PC plugged in for sub-10ms ping — they all rely on Ethernet framing to actually move bits across copper or fiber. IP addresses are how the internet *thinks*; MAC addresses and Ethernet frames are how the wire *delivers*.

It also matters because Layer 2 is where a lot of attackers live. If someone owns the switch fabric, they don't need to crack your TLS — they just reroute your frames through their box and read everything you send in the clear. VLAN segmentation, port security, and trunk hardening exist because Ethernet, by default, trusts whoever is plugged in. Like an Among Us lobby with no emergency meetings: anyone can claim to be anyone.

## Key facts

### Frame structure
- **Header fields**: destination MAC (6 bytes), source MAC (6 bytes), EtherType (2 bytes — e.g., 0x0800 = IPv4, 0x0806 = ARP, 0x86DD = IPv6).
- **Payload**: 46 to 1500 bytes. Smaller payloads get padded — like CS2 forcing a minimum match length.
- **CRC / FCS**: 4-byte checksum at the tail. If the math doesn't match on arrival, the frame gets dropped. No retransmission at this layer; that's TCP's job upstairs.

### MTU and jumbo frames
- **Standard MTU**: 1500 bytes of payload. The default carry weight in your inventory.
- **Jumbo frames**: ~9000 bytes. Like a Helldivers 2 supply drop instead of a single stim — fewer trips, less per-packet overhead, better throughput on storage networks and backbone links. Both ends and every switch in between must support jumbo or the frame gets dropped or fragmented.

### Switches vs. hubs
- **Switch**: builds a MAC address table by watching source MACs on incoming frames, then forwards unicast frames only out the matching port. Targeted DM.
- **Hub**: dumb repeater. Every frame goes out every port. Like shouting in voice chat with no proximity setting — everyone hears everything. Mostly extinct, but still relevant in CTFs and old infrastructure.

### 802.1Q VLAN tagging
- A **4-byte tag** inserted between the source MAC and EtherType, carrying a 12-bit VLAN ID (so up to 4094 usable VLANs).
- Lets one physical switch host multiple logical networks. Like Discord servers running on the same app — same client, isolated channels, different permissions.
- **Trunk ports** carry tagged frames between switches; **access ports** carry untagged frames to end devices.

### Promiscuous mode
- A NIC setting that says "give me every frame you see, not just the ones addressed to me." 
- The Watch Dogs 2 NetHack vibe: your network card stops filtering and starts hoarding. Required for Wireshark to capture other devices' traffic — but on a switched network, you'll mostly see your own frames plus broadcasts unless you do something more aggressive (see below).

### ARP poisoning
- The attacker spams forged ARP replies telling Host A "I'm the gateway" and the gateway "I'm Host A."
- Both sides update their ARP cache and start sending frames to the attacker's MAC. Classic MITM on a switched LAN.
- Like a scammer in an MMO trade window swapping the item at the last second — the protocol trusted the last thing it heard.

### VLAN hopping
- **Switch spoofing**: the attacker's machine pretends to be a switch and negotiates a trunk link via DTP. Once trunked, every VLAN's traffic flows to them. Fix: disable DTP, hardcode access ports.
- **Double tagging**: attacker crafts a frame with two 802.1Q tags. The first switch strips the outer tag (native VLAN) and forwards the still-tagged frame over a trunk; the next switch reads the inner tag and delivers the frame into a VLAN the attacker shouldn't reach. One-way only, but devastating for reconnaissance and injection. Fix: never use VLAN 1 as native, tag all trunk traffic explicitly.

## Related concepts
[[MAC address]]
[[ARP and ARP poisoning]]
[[802.1Q VLAN tagging]]
[[DTP and trunk negotiation]]
[[Switch security and port security]]
[[Wireshark and packet capture]]
[[Spanning Tree Protocol]]
[[Layer 2 vs Layer 3]]