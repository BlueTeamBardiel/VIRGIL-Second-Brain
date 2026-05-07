# Ethernet LAN Switching

## What it is

A switch is the bouncer at a Discord voice channel — it knows exactly which port each member is sitting on, and when a message comes in addressed to "Beatrice," it doesn't shout into every channel. It walks the message straight to Beatrice's seat. Compare that to a hub, which is the guy who screams every message into every room and lets everyone sort it out.

Ethernet LAN switching is the Layer 2 (Data Link) mechanism that moves frames between devices on the same local network using **MAC addresses** as the delivery label. The switch builds a cheat sheet — the **MAC address table** (also called the CAM table) — by watching the source MAC of every frame that comes in, noting which port it arrived on, and remembering it. Next time a frame is destined for that MAC, the switch sends it out exactly one port.

No IP addresses involved. No routing. No TTL decrement. The switch is essentially a transparent traffic director that doesn't modify the frame at all — it just reads the envelope and decides which door it goes out.

## Why it matters

Without switching, every device on your LAN would be like every player in an Among Us lobby hearing every other player's private DMs simultaneously. Collisions everywhere, no privacy, no scale. Switching is what makes a 48-port office network not collapse into static the moment two people start a Zoom call.

It also matters because almost every "weird network problem" you'll ever debug — duplicate IPs, ARP poisoning attacks, ports getting flooded, mysterious unicast storms — lives at this layer. If you don't understand how a switch learns and forwards, you can't read what `show mac-address-table` is telling you, and you'll be guessing during incidents.

Security-wise, the trust model is naive: switches believe whatever source MAC shows up. That's the gap **ARP spoofing** drives a truck through.

## Key facts

### The Ethernet frame (in order on the wire)

Think of the frame like a Tarkov loot container — there's a fixed layout, and every byte has a slot.

- **Preamble** — 7 bytes. The "hey, wake up, packet incoming" knock at the door.
- **Start Frame Delimiter (SFD)** — 1 byte. The "okay, the real data starts NOW" cue.
- **Destination MAC** — 6 bytes. Who it's for.
- **Source MAC** — 6 bytes. Who sent it.
- **Type/Length** — 2 bytes. What's inside, or how big it is.
- **Payload** — 46 to 1500 bytes. The actual cargo.
- **FCS (Frame Check Sequence)** — 4 bytes. A 32-bit CRC checksum — the tamper seal.
- Preamble and SFD don't count toward the 64-byte minimum frame size. They're the doorbell, not the package.
- If the FCS doesn't match, the switch silently drops the frame. No error message, no apology — like Elden Ring's "YOU DIED" but without even the courtesy screen.

### Type/Length field values

The field is dual-purpose depending on the number:

- **≥ 0x0600** → it's a **Type** (what protocol is in the payload)
- **< 0x0600** → it's a **Length** (legacy 802.3 framing)
- `0x0800` = IPv4
- `0x0806` = ARP
- `0x86DD` = IPv6

### MAC addresses

A MAC is like a console's hardware serial number burned into the chip — globally unique, doesn't change because you moved apartments.

- **48 bits total**, written as six hex pairs separated by colons (e.g., `00:1A:2B:3C:4D:5E`).
- **First 3 octets (24 bits)** = **OUI** — the Organizationally Unique Identifier, identifies the manufacturer. Like the publisher logo on a game box.
- **Last 3 octets (24 bits)** = device-specific ID assigned by that vendor.
- **Flat, non-hierarchical, not routable.** A MAC tells you nothing about location. IPs are like postal addresses; MACs are like fingerprints.

### How the MAC address table works

The switch's notebook. Each entry holds:

- **MAC Address** | **Switch Port** | **VLAN** | **Age**
- Entries are **learned dynamically** by reading the **source MAC** of incoming frames — "oh, that MAC lives on port Gi0/4, noted."
- Default **aging timeout: 300 seconds** on Cisco. If a MAC stays silent that long, it gets evicted from the table like an inactive guildmate.
- Entries can also be **STATIC** (manually pinned) or **DYNAMIC** (learned).
- Older switches: ~8,000 entries. Modern: 100,000+.
- View it with `show mac-address-table`.

### Forwarding decisions

Three flavors, like loadout choices:

- **Known unicast** — destination MAC is in the table → forward out the one mapped port. Surgical.
- **Unknown unicast** — destination MAC is NOT in the table → **flood** out every port except the one it came in on. The switch is asking "anyone seen this guy?" by yelling into every room.
- **Broadcast** (`FF:FF:FF:FF:FF:FF`) — always flooded. Always.
- **Multicast** — flooded by default, but **IGMP snooping** can teach the switch to be selective.
- Frames on **trunk ports** get inspected for **802.1Q VLAN tags** to figure out which VLAN they belong to.

### What switches do NOT do

- Do not modify frames (transparent forwarding).
- Do not decrement TTL — that's a Layer 3 thing.
- Do not look at IP addresses (unless it's a multilayer/L3 switch wearing two hats).

### ARP — the IP↔MAC translator

Knowing someone's gamertag (IP) doesn't tell you which port their console is plugged into (MAC). ARP is the lookup.

- Layer 2 protocol that resolves an **IP address → MAC address** on the local subnet.
- **ARP Request** = broadcast (`FF:FF:FF:FF:FF:FF`) — "who has 10.0.0.50? Tell 10.0.0.10."
- **ARP Reply** = unicast — only the owner answers, directly.
- **ARP cache** lifetimes: ~**240 seconds on Windows**, ~**20 minutes on Linux**.
- ARP only works on the **local segment**. For anything off-subnet, the host ARPs for its **default gateway** instead and lets the router handle it.
- **ARP spoofing**: an attacker sends forged ARP replies claiming "I'm the gateway" — classic Watch Dogs 2 man-in-the-middle move. All traffic gets funneled through the attacker.
- **ARP floods** (real or malicious) can spike a switch's CPU if it's processing them in software.

### Ping — the "u up?" of networking

- Tests reachability and round-trip latency.
- Uses **ICMP** — specifically **Echo Request** and **Echo Reply**.
- Cisco IOS defaults: **5 packets**, **2-second timeout** each, **56-byte payload**.

## Related concepts

- [[MAC Address Table]]
- [[ARP (Address Resolution Protocol)]]
- [[VLANs and 802.1Q Trunking]]
- [[Spanning Tree Protocol (STP)]]
- [[ICMP and Ping]]
- [[ARP Spoofing and Dynamic ARP Inspection]]
- [[Multilayer Switching]]
- [[IGMP Snooping]]
- [[Ethernet Frame Format]]
- [[Collision Domains vs Broadcast Domains]]