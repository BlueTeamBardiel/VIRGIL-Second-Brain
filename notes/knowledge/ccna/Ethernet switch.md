# Ethernet Switch

## What it is

A switch is the bouncer at a Discord server with a precise guest list. When a frame shows up at the door, the switch checks the destination MAC address against its list, and sends the frame *only* to the specific port where that MAC lives — not to everyone in the building. A hub, by contrast, is the drunk uncle who yells everything at every guest in every room.

Technically, an Ethernet switch operates at **Layer 2 (Data Link)** of the OSI model. It forwards Ethernet frames based on destination MAC addresses, learning which MAC sits behind which physical port and storing that mapping in a **CAM table** (Content Addressable Memory, also called the MAC address table). When a frame arrives, the switch looks up the destination MAC, finds the matching port, and forwards the frame out that port only. Unknown destinations get flooded out every port except the one the frame came in on — that's how it learns.

A **Layer 3 switch** is the same beast wearing a router hat: it does Layer 2 switching at line rate but also performs IP routing between VLANs or subnets, usually in hardware (ASICs) rather than software.

## Why it matters

Switches are the load-bearing walls of every LAN. The fast multiplayer lobby in Call of Duty, the Plex stream from your homelab, the Zoom call that doesn't stutter — all of that depends on switches forwarding frames intelligently instead of broadcasting like a town crier.

But "intelligent forwarding" is also the attack surface. Every assumption a switch makes — *this MAC lives on this port, this trunk link is trustworthy, this BPDU is honest* — is something an attacker can lie about. A switch with default settings is roughly as secure as an Among Us lobby with no emergency meetings: trust is implicit, and one impostor ruins the round.

## Key facts

### Core operation
- **Layer 2 forwarding**: switches read the Ethernet header's destination MAC and forward to the matching port. Source MACs get learned and stored in the CAM table.
- **CAM table aging**: entries time out after **300 seconds (5 minutes)** by default. If a MAC goes silent that long, the switch forgets it — like Tinder unmatching after inactivity.
- **Unknown unicast flooding**: if the destination MAC isn't in the table, the switch floods the frame out every port in that VLAN. Normal behavior, but exploitable.
- **Layer 3 switches**: add routing between subnets/VLANs, typically using hardware ASICs so it's nearly as fast as switching.

### MAC flooding (CAM table overflow)
- An attacker (think `macof` from dsniff) sprays the switch with thousands of frames carrying random spoofed source MACs. The CAM table fills up.
- Once full, the switch can't learn new entries and **floods all unknown traffic out every port** — effectively turning your fancy switch into that drunk-uncle hub. The attacker now sniffs traffic that wasn't meant for them.
- It's the network equivalent of overwhelming a Helldivers 2 reinforcement budget by burning every respawn — once the table's exhausted, the system fails open.

### Port security
- A mitigation that caps how many MAC addresses a single port will accept. Set a port to allow 1 MAC, and the second spoofed MAC trips a violation.
- Violation actions: `shutdown` (port goes err-disabled), `restrict` (drop and log), or `protect` (drop silently).
- Like a Cyberpunk 2077 apartment with a biometric lock — only the registered tenant gets in, and a forced entry attempt slams the door.

### VLANs
- VLANs (Virtual LANs) chop one physical switch into multiple isolated broadcast domains. Sales VLAN can't see Engineering VLAN's broadcasts, even on the same hardware.
- Each VLAN is its own broadcast domain — same effect as physically separate switches, without the cable spaghetti.
- **Trunk ports** carry multiple VLANs between switches, tagging frames with 802.1Q headers so the other side knows which VLAN each frame belongs to.

### VLAN hopping
- **Switch spoofing**: the attacker's machine pretends to be a switch by speaking DTP (Dynamic Trunking Protocol). If the access port is left in default `dynamic auto` or `dynamic desirable`, it negotiates a trunk with the attacker — who now sees every VLAN. Fix: hardcode `switchport mode access` and disable DTP.
- **Double tagging**: the attacker stuffs *two* 802.1Q tags into the frame. The first switch strips the outer tag (matching the native VLAN), forwards across the trunk, and the second switch reads the inner tag and delivers the frame into a VLAN the attacker shouldn't reach. One-way only, but devastating for things like injecting traffic into a management VLAN. Fix: don't use the native VLAN for any real traffic, or tag the native VLAN explicitly.

### Spanning Tree Protocol (STP)
- STP prevents Layer 2 loops. Without it, a redundant link between two switches creates a broadcast storm that melts the network in seconds — frames loop forever because Ethernet has no TTL.
- Switches elect a **root bridge** (lowest bridge ID wins) and block redundant paths back to it. Think of it as picking the host of an Among Us lobby — everyone agrees on one authority and routes through them.
- **STP attack — superior BPDU injection**: an attacker sends Bridge Protocol Data Units claiming a lower (better) priority than the current root. The network re-elects the attacker's machine as root bridge, and traffic patterns shift to flow through (or near) the attacker. Fix: **BPDU Guard** on access ports — any BPDU received on a user-facing port shuts the port down immediately. **Root Guard** on uplinks prevents downstream devices from becoming root.

## Related concepts
- [[VLAN]]
- [[802.1Q tagging]]
- [[Spanning Tree Protocol]]
- [[BPDU Guard and Root Guard]]
- [[DTP (Dynamic Trunking Protocol)]]
- [[Port security]]
- [[ARP spoofing]]
- [[MAC address]]
- [[Layer 3 switch vs router]]
- [[Broadcast domain vs collision domain]]