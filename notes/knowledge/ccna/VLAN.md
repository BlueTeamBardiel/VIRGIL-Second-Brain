# VLAN

## What it is

A Discord server with separate channels for separate friend groups — everyone's connected to the same server (the switch), but the people in #raid-team can't see what's happening in #book-club. That's a VLAN.

A **Virtual LAN** logically slices one physical switch into multiple isolated broadcast domains. Plug eight devices into the same 24-port switch, assign ports 1–4 to VLAN 10 and ports 5–8 to VLAN 20, and the two groups behave as if they were on entirely separate switches. Broadcasts stay in their lane. ARP requests don't cross over. They share copper but not conversations.

If a device on VLAN 10 wants to talk to a device on VLAN 20, the traffic has to leave the Layer 2 world entirely and go through a router or Layer 3 switch — like how players in two separate Among Us lobbies can't chat unless someone bridges them through an external Discord call.

## Why it matters

Running a flat network is like playing Escape from Tarkov with friendly fire on and no team identification — every device sees every broadcast, and one compromised host can sniff or attack anything else in the same domain. VLANs enforce **least privilege at Layer 2**: the finance machines never see the IoT cameras, the guest Wi-Fi never sees the servers, and the printer in the lobby can't ARP-spoof your domain controller because they're not in the same broadcast domain to begin with.

This also kills broadcast storms before they spread. A misbehaving NIC spamming the network only floods its own VLAN, not the whole building.

The catch: VLANs give you **logical separation, not encryption**. Frames inside a VLAN are still plaintext Ethernet. If an attacker gets onto your VLAN, the segmentation didn't help them stay out — it just made it harder to get there. VLANs are walls, not vaults.

## Key facts

### The standard
- **IEEE 802.1Q** is the standard that defines VLAN tagging on Ethernet — think of it as the rulebook every switch vendor agreed to follow so Cisco and Aruba gear can actually talk to each other.
- 802.1Q inserts a **4-byte tag** into the Ethernet frame containing a **12-bit VLAN ID**.
- That 12-bit field gives you VLAN IDs **1–4094** (0 and 4095 are reserved). Plenty for most networks, painful for massive cloud providers — which is why VXLAN exists.

### Trunks and native VLAN
- An **access port** belongs to one VLAN and carries untagged frames — like a single-player lobby.
- A **trunk port** carries multiple VLANs between switches, tagging each frame with its VLAN ID so the other switch knows where it belongs. It's the multiplayer matchmaking server routing players to the right lobby.
- The **native VLAN** on a trunk is the one VLAN whose frames are sent **untagged** — a legacy quirk for backwards compatibility with non-802.1Q devices.
- **Best practice**: set the native VLAN to an unused ID and never leave it as the default VLAN 1. Leaving native VLAN at 1 is the network equivalent of leaving the default password on your router.

### VLAN hopping attacks
- **Switch spoofing**: the attacker's machine pretends to be a switch and negotiates a trunk link, gaining access to every VLAN that trunk carries. It's like running a modded client in Rainbow Six Siege that convinces the server you're an admin — suddenly you see every team's comms. Mitigation: disable DTP and hard-code ports as access only.
- **Double tagging**: the attacker stacks two 802.1Q tags on a frame. The first switch strips the outer tag (because it matches the native VLAN) and forwards the frame with the inner tag still attached, landing it in a VLAN the attacker shouldn't reach. This is exactly why the native VLAN should be an unused ID — if no access port lives on the native VLAN, the outer tag trick has nowhere to start.

### Inter-VLAN routing
- Crossing VLANs requires a **Layer 3 device** — a router on a stick, or more commonly a **multilayer (Layer 3) switch** with Switched Virtual Interfaces.
- Without that L3 hop, VLAN 10 and VLAN 20 are as isolated as two PlayStation accounts in different regions — same hardware family, no direct crossplay.

### What VLANs don't do
- **No encryption.** A tagged frame is still readable to anyone on that VLAN. If you need confidentiality, layer MACsec or IPsec on top.
- **No authentication of hosts.** Anyone who plugs into an access port joins that VLAN. Pair with 802.1X if you care who's at the other end of the cable.

## Related concepts

[[802.1Q]] · [[Trunking and DTP]] · [[VLAN Hopping]] · [[Native VLAN]] · [[Inter-VLAN Routing]] · [[Layer 3 Switch]] · [[802.1X Port Authentication]] · [[MACsec]] · [[Broadcast Domain]] · [[Private VLANs]] · [[VXLAN]] · [[Network Segmentation]]