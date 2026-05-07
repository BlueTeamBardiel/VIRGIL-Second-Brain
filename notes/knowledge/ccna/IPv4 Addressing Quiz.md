# IPv4 Addressing

## What it is

An IPv4 address is the gamertag your device wears on a network — a unique label other machines use to find you, talk to you, and route packets to your door. Without one, you're invisible; with a duplicate, the network throws a tantrum.

Technically, an IPv4 address is a **32-bit number**, but nobody wants to read 32 ones and zeros, so it's written in **dotted-decimal notation**: four chunks (octets) separated by dots, like `192.168.1.42`. Each octet is 8 bits, which means each one can hold a value from **0 to 255** (that's the full range of an unsigned byte).

The address itself is split into two halves: a **network portion** (which neighborhood you live in) and a **host portion** (which specific house you are). The line dividing those halves isn't fixed — a **subnet mask** decides where it falls. Same address, different mask, different meaning.

## Why it matters

Every packet that crosses a network — your Discord voice chat, your Helldivers 2 matchmaking handshake, your Spotify stream — has a source IP and a destination IP stapled to it. Routers read those addresses to decide where to send things next. Get the addressing wrong and your traffic either dies in a black hole or gets misrouted to a stranger.

For security, IP addresses are also the first thing reconnaissance tools look at. Run **nmap** against a subnet and it'll sweep through every address probing for live hosts and open ports — the digital equivalent of a Watch Dogs 2 ctOS scan revealing every device on a city block. Knowing how addresses are structured tells you exactly what range an attacker (or you, defending) needs to enumerate.

## Key facts

### Address structure
- **32 bits total**, written as four decimal octets (`A.B.C.D`), each 0–255.
- Split into **network + host** portions, with the boundary set by the subnet mask.

### Legacy classful ranges
Before CIDR, the first octet decided the class — like character classes in an RPG locking you into a preset stat spread:
- **Class A**: first octet `1–126` (huge networks)
- **Class B**: first octet `128–191` (medium)
- **Class C**: first octet `192–223` (small)
- `127` is skipped on purpose — it belongs to loopback.

### Private ranges (RFC 1918)
These are the "LAN party only" address blocks. They work inside your home or office but are forbidden from showing up as source IPs on the public internet — ISPs drop them on sight, like trying to use a Minecraft LAN world IP to join a real server:
- **`10.0.0.0/8`**
- **`172.16.0.0/12`**
- **`192.168.0.0/16`**

If you ever see a packet on the public internet sourced from `10.x.x.x`, something is misconfigured or someone is spoofing.

### CIDR notation — the `/24` example
CIDR replaces the rigid class system with a slash that tells you exactly how many bits belong to the network. `/24` is the most common one you'll meet in home labs and small offices:
- **`/24` = subnet mask `255.255.255.0`**
- **256 total addresses** (0 through 255 in the last octet)
- **254 usable addresses** for hosts — because two are always reserved:
  - The first address is the network ID
  - The last address is the **broadcast address**, which is never assigned to a host. Sending to it is like `@everyone` in a Discord server — every device in the subnet receives the message.

### Special addresses
- **`127.0.0.1`** — the **loopback** address. It always points back to the device itself, the network equivalent of looking in a mirror. Useful for testing local services without touching a NIC.
- **`169.254.x.x`** — the **APIPA** range (Automatic Private IP Addressing). These are **link-local** addresses your OS assigns itself when it asked DHCP for an address and got ghosted. If your machine is sitting on a `169.254` address, your DHCP server is dead, your cable is unplugged, or your Wi-Fi authentication failed. It's the network's "I tried" sticker.

### Recon
- **nmap** is the go-to tool for sweeping IPv4 ranges to discover live hosts, open ports, and services. Defenders use it to audit; attackers use it to map. Same tool, different intent.

## Related concepts
[[Subnet Masks and CIDR]]
[[RFC 1918 Private Addressing]]
[[DHCP and APIPA]]
[[Broadcast vs Unicast vs Multicast]]
[[IPv6 Addressing]]
[[NAT and PAT]]
[[Loopback Interfaces]]
[[nmap and Network Reconnaissance]]
[[Classful vs Classless Routing]]