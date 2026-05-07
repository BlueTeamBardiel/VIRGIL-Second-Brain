# Network Switching

## What it is

A switch is the bouncer at a club who actually remembers faces. When a frame shows up at the door, the switch checks its guest list (the MAC address table), sees that "Beatrice's laptop" lives at port 7, and sends the frame straight there — not to everyone in the building. Compare that to a hub, which is the bouncer who just shouts every message into a megaphone and hopes the right person hears it.

Technically, a switch operates at **Layer 2 (Data Link)** of the OSI model. It forwards Ethernet frames based on destination MAC addresses, using a **CAM table** (Content Addressable Memory) that maps MAC addresses to physical ports. The switch builds this table dynamically: every time a frame arrives, it reads the *source* MAC and notes "ah, that address lives on this port." Next time someone sends a frame to that MAC, the switch knows exactly where to point.

If the destination is unknown, the switch floods the frame out every port except the one it came in on — same behavior as a hub, but only as a fallback. Once a reply comes back, the table learns and the flooding stops.

## Why it matters

Switching is the foundation of every LAN that isn't tiny. Without it, your office, your gaming LAN party, your homelab — all of it would be one screaming broadcast domain where every device hears every conversation. That's both a performance disaster and a security one.

But here's the catch: switches are *trusting*. They believe what frames tell them. That trust is exploitable in ways that turn the bouncer back into the megaphone guy. Knowing how switches behave normally is the only way to recognize when one's been tricked — and most of the L2 attacks below are quiet, pre-auth, and devastating because nobody's watching the basement of the OSI model.

## Key facts

### Core operation
- **Layer 2 device**: forwards based on MAC, not IP. It doesn't know or care about subnets.
- **CAM table** (also called the MAC address table): the cheat sheet of MAC → port mappings. Has finite memory — this matters in a second.
- **Dynamic learning**: source MACs of incoming frames build the table. No manual config needed for basic operation.
- **Unknown unicast flooding**: when the destination MAC isn't in the table, the switch broadcasts the frame out every port. Like calling out a Discord username when you don't know which server they're in.

### MAC flooding attack
- The attacker uses a tool like `macof` to fire thousands of frames per second with **randomized fake source MACs**. The CAM table fills up — think of it like a Pokémon PC box with no more space for new mons.
- Once full, the switch **fails open**: it can't learn any more, so legitimate traffic to unknown MACs gets flooded out every port.
- A failed-open switch is functionally a **hub**. The attacker on any port now sniffs traffic that was never meant for them. Wireshark eats well.
- Mitigation: **port security**.

### Port security
- Limits how many MAC addresses a single port will accept. Typical config: max 1 or 2 MACs per port.
- Can **pin** (statically bind) specific MACs to specific ports — like a reserved seat at a concert. Anyone else's MAC tries that port? Violation.
- Violation actions: shut the port down, drop the offending frames, or alert. Stops MAC flooding cold and blocks rogue devices someone plugged in under the desk.

### VLANs (Virtual LANs)
- A VLAN slices one physical switch into multiple **isolated broadcast domains**. Same hardware, separate neighborhoods. The dev VLAN can't see broadcasts from the finance VLAN even though they share the same switch chassis.
- **802.1Q** is the IEEE standard for VLAN tagging. It inserts a 4-byte tag into the Ethernet header containing a 12-bit VLAN ID (so 4094 usable VLANs). Tagged frames travel on **trunk ports** between switches; **access ports** carry untagged frames for end devices.

### VLAN hopping
- **Switch spoofing**: an attacker's machine pretends to be a switch by speaking DTP (Dynamic Trunking Protocol) and negotiating a trunk link. Suddenly their port carries every VLAN. Like convincing a club's staff door you work there.
- **Double tagging**: attacker stacks two 802.1Q tags. The first switch strips the outer tag (matching its native VLAN) and forwards the frame with the inner tag still attached, dumping the frame into a VLAN the attacker should never reach. One-way attack, but lethal for injection.
- Mitigation: disable DTP, set access ports explicitly, never use VLAN 1 as native, prune unused VLANs from trunks.

### Spanning Tree Protocol (STP)
- When you have multiple switches with redundant links, frames can loop forever (no TTL at Layer 2 — broadcasts just keep multiplying until the network melts). STP prevents this by electing a **root bridge** and blocking redundant paths until needed.
- Switches communicate via **BPDUs** (Bridge Protocol Data Units) to figure out the topology. The switch with the lowest bridge ID wins root.
- **STP attack**: an attacker sends crafted BPDUs claiming to be a better root bridge. The topology re-converges around the attacker's machine, and now legitimate traffic flows through the attacker's port — a Layer 2 MITM with no ARP poisoning required.
- Mitigation: **BPDU Guard** on access ports (any BPDU received = port shutdown), **Root Guard** on trunk ports (rejects superior BPDUs from unauthorized neighbors).

## Related concepts
- [[ARP and ARP spoofing]]
- [[VLAN hopping attacks]]
- [[802.1Q tagging]]
- [[Spanning Tree Protocol]]
- [[DTP and trunk negotiation]]
- [[Port security]]
- [[Broadcast domains vs collision domains]]
- [[802.1X port-based authentication]]
- [[DHCP snooping]]
- [[Dynamic ARP Inspection]]