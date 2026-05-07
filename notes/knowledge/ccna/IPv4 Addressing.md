# IPv4 Addressing

## What it is

Every package delivered to your door has a shipping label: where it came from, where it's going, how heavy it is, and a tracking number. Strip that label off and the package is just a mystery box that nobody can route. The IPv4 header is that shipping label — a 20-byte chunk of metadata stapled to the front of every packet so routers know what to do with it.

IPv4 itself is the Layer 3 protocol defined in RFC 791. An IPv4 address is a 32-bit number, written as four octets in dotted decimal (like `192.168.1.42`), where each octet ranges 0–255. That gives you 2³² total possible addresses — 4,294,967,296 of them, which sounded like a lot in 1981 and is wildly insufficient now.

The header itself sits between the Layer 2 frame header and the Layer 4 segment data. It has 14 fields, a minimum size of 20 bytes, and can stretch up to 60 bytes if optional fields are used.

## Why it matters

IPv4 is the routing layer of basically the entire internet you've ever touched. Every Discord message, every Warzone match, every TikTok scroll — they all ride inside IPv4 packets (or IPv6, but IPv4 still dominates). Understanding the header is how you understand what routers actually *see* when they make forwarding decisions.

It also matters for troubleshooting. When `traceroute` maps a network path, it's exploiting the TTL field. When a packet gets fragmented and reassembled, it's the Identification, Flags, and Fragment Offset fields doing the work. When QoS prioritizes your Zoom call over someone's torrent, it's reading DSCP bits. The header isn't trivia — it's the control surface.

## Key facts

### The address itself
- **32 bits, 4 octets of 8 bits each** — written dotted decimal, e.g., `10.0.0.5`.
- **Range:** `0.0.0.0` to `255.255.255.255`, total 4,294,967,296 addresses.
- **Source and Destination Address fields** in the header are each 32 bits.
- Routers forward based on the Destination Address. Source and Destination don't change in transit — *except* when NAT rewrites them, which is what your home router does every time you load a webpage.

### Header layout cheat sheet
The header is like a character sheet in an RPG — fixed slots, each one telling the engine something specific.

- **Version (4 bits):** which IP version this is. `0b0100` = IPv4, `0b0110` = IPv6. Routers check this first to know which ruleset to apply.
- **IHL — Internet Header Length (4 bits):** how long the header is, measured in 4-byte words. Multiply IHL × 4 to get header size in bytes. Minimum value 5 (20 bytes), maximum 15 (60 bytes). Like a stat block telling you how many pages of rules to read before getting to the action.
- **DSCP (6 bits) + ECN (2 bits) = 8 bits of QoS:** DSCP marks priority class (think VIP queue at a club), ECN signals network congestion without dropping packets.
- **Total Length (16 bits):** size of the entire packet (header + payload) in bytes. Range 0–65,535.
- **Identification (16 bits):** unique ID assigned to the packet, used to glue fragments back together — like the puzzle-piece number on the back of jigsaw pieces from the same box.
- **Flags (3 bits):**
  - Bit 0: reserved, always 0.
  - Bit 1: **DF (Don't Fragment)** — "do not split this packet, drop it instead."
  - Bit 2: **MF (More Fragments)** — "more pieces are coming, don't reassemble yet."
- **Fragment Offset (13 bits):** where this fragment fits in the original packet, measured in 8-byte units.
- **TTL — Time To Live (8 bits):** decremented by 1 at every router hop. Hits 0, packet dies. Like the durability bar on a Breath of the Wild weapon — every hop chips at it, and when it breaks, the packet is gone.
  - Linux/Unix default: **64**
  - Windows default: **128**
  - Cisco routers originate at **255**
  - `traceroute` weaponizes this — it sends packets with TTL=1, then TTL=2, etc., and listens for the ICMP "time exceeded" replies to map every hop along the way. Speedrunning the network topology, basically.
- **Protocol (8 bits):** what's riding inside the payload. The "class selector" for the next layer.
  - ICMP = **1**
  - IGMP = **2**
  - TCP = **6**
  - GRE = **47**
  - UDP = **17**
  - EIGRP = **88**
  - OSPF = **89**
- **Header Checksum (16 bits):** error detection over the **header only** — not the payload. Because TTL changes every hop, the checksum has to be recalculated at every router. Payload integrity is TCP's and UDP's problem (their own checksums handle that).
- **Source Address (32 bits)** and **Destination Address (32 bits):** the from/to of the shipping label.

### Where the header lives
- Sits between the Layer 2 frame header (Ethernet, etc.) and the Layer 4 segment data (TCP/UDP).
- The frame is the armored truck; the IPv4 header is the shipping manifest taped to the box inside.

## Related concepts
- [[IPv4 Subnetting and CIDR]]
- [[IPv6 Addressing]]
- [[NAT and PAT]]
- [[ICMP and traceroute]]
- [[TCP vs UDP]]
- [[MTU and Fragmentation]]
- [[QoS and DSCP Marking]]
- [[Routing Fundamentals]]
- [[ARP and Layer 2/Layer 3 Interaction]]