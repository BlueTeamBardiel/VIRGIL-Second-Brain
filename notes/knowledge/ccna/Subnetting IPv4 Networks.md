# Subnetting IPv4 Networks

## What it is

A Discord server with one giant #general channel where every member screams at once is unusable. So you split it into #raids, #pvp, #trade, #memes — each channel its own conversation, mods control who joins which one. Subnetting does exactly this to an IPv4 network.

You take one big network like 192.168.1.0/24 and carve it into smaller logical networks called subnets. Each subnet is its own isolated broadcast domain — chatter in one doesn't leak into another. The mechanism is bit-level surgery: you "borrow" bits from the host portion of an address and promote them to network bits. The subnet mask is the label that tells every device which bits are network (the channel name) and which are host (the individual member).

Three landmark addresses define every subnet:
- **Network address** — all host bits set to 0. The subnet's name tag.
- **Broadcast address** — all host bits set to 1. The "@everyone" ping for that subnet only.
- **Usable hosts** — everything in between. The actual players.

Prefix length (`/24`, `/26`, `/30`) is shorthand for "this many bits are network." A /26 mask in dotted decimal is 255.255.255.192.

## Why it matters

An MMO with no zone instancing — every player's spell effects, chat, and footsteps broadcast to all 50,000 players simultaneously — would melt servers. Zones contain the noise. Subnets do the same for broadcast frames: ARP requests, DHCP discovers, and other "hey, anyone?" traffic stay inside their subnet instead of pestering every device on the LAN.

Beyond performance, subnetting is a security boundary. Putting Engineering in one subnet and Finance in another means traffic between them must pass through a router (and its ACLs). It also lets you allocate addresses precisely — a point-to-point link between two routers needs 2 IPs, not 254, and VLSM lets you give it exactly that. Hierarchical addressing also keeps routing tables small and summarizable, which scales.

For the CCNA, subnetting is roughly 15–20% of the exam and shows up in nearly every other topic too.

## Key facts

### The math
- **Subnets created** = 2^(bits borrowed)
- **Hosts per subnet** = 2^(remaining host bits) − 2 (subtracting network and broadcast)
- **Block size in an octet** = 2^(8 − borrowed bits) — this is the increment between subnet network addresses
- A /24 has 8 host bits to play with, /16 has 16, /8 has 24. More host bits = more room to subnet.

### Borrowing bits in the 4th octet (from a /24)
Like choosing loadout slots in Escape from Tarkov — every bit you borrow for "network" is one less bit available for "host":
- Borrow 1 bit → /25 → block size 128 → 2 subnets of 128 addresses
- Borrow 2 bits → /26 → block size 64 → 4 subnets of 64
- Borrow 3 bits → /27 → block size 32 → 8 subnets of 32
- Borrow 4 bits → /28 → block size 16 → 16 subnets of 16

### Common subnet sizes (memorize these like ability cooldowns)
- **/30** — 4 total, 2 usable. The standard for router-to-router point-to-point links.
- **/28** — 16 total, 14 usable. Small office segment.
- **/27** — 32 total, 30 usable. Medium segment.
- **/26** — 64 total, 62 usable. Larger segment. Mask: 255.255.255.192.

### FLSM vs VLSM
**FLSM (Fixed-Length Subnet Masking)** is buying every teammate the same shoe size regardless of their feet — every subnet uses the identical mask. Simple, but if one segment needs 200 hosts and another needs 2, you waste enormous space.

**VLSM (Variable-Length Subnet Masking)** is custom-tailoring each subnet to its actual need. Mixed mask sizes inside the same parent network. The rule: **start with the largest requirement first**, then subdivide remaining space for smaller ones. Otherwise you fragment the address pool and box yourself out. VLSM is the standard for modern networks; FLSM survives mostly in textbooks and labs.

### Useful Cisco CLI
- `ip address 10.0.0.1 255.255.255.0` — assigns IP and mask to an interface (interface config mode)
- `show ip interface brief` — quick status of every interface and its IP
- `show ip route` — routing table with prefix lengths visible
- `ping <ip>` — confirms Layer 3 reachability between subnets
- `traceroute <ip>` — shows the router hops along the way, useful when ping fails and you need to find where it dies

## Related concepts
[[IPv4 Addressing]]
[[Subnet Mask and Prefix Length]]
[[VLSM]]
[[CIDR]]
[[Broadcast Domain]]
[[Default Gateway]]
[[Routing Table]]
[[ARP]]
[[VLANs]]
[[Route Summarization]]