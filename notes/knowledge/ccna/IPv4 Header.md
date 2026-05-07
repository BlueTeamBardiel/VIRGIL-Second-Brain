# IPv4 Header

## What it is

Every IPv4 packet wears a shipping label stapled to the front — that label is the IPv4 header. It's 20 to 60 bytes of metadata that tells every router along the path who sent the packet, where it's going, what's inside, and how long it's allowed to keep traveling before getting tossed.

Think of the loot crates in Helldivers 2 getting called down from orbit. Each pod has stenciled markings: drop coordinates, contents, what stratagem called it. Strip those off and the pod is just a metal box with no instructions. The IPv4 header is that stenciling — without it, a packet is meaningless bytes. Routers read this label at every hop and decide what to do next.

The header is variable length: a baseline 20 bytes, but it can stretch to 60 if optional fields are tacked on. The **IHL (Internet Header Length)** field tells the receiver how long the header actually is, measured in 32-bit words (so IHL=5 means 20 bytes, IHL=15 means 60 bytes — the maximum).

## Why it matters

The header is where the entire internet's routing logic lives. Every forwarding decision, every TTL decrement, every "this packet is for TCP, hand it up the stack" — all of it reads off these fields.

It's also where a lot of attacks live. The header was designed in 1981 with zero authentication. The Source Address field is whatever the sender wrote down — like writing a fake return address on a package and dropping it in a mailbox. Nobody checks. This is the foundation of IP spoofing and reflection-based DDoS, where attackers forge the source IP so that responses from innocent servers get blasted at the actual victim. Memcached and DNS amplification attacks have generated terabit-per-second floods using exactly this trick.

Fragmentation fields are another classic attack surface. Crafting packets with overlapping or malformed Fragment Offset values has historically crashed kernels, bypassed firewalls, and confused IDS engines (teardrop, ping of death, fragment overlap evasion).

## Key facts

### Size and structure
- **20–60 bytes**, prepended to every IPv4 packet. 20 is the floor (no options), 60 is the ceiling.
- **IHL** specifies header size in 32-bit words. Like a Tarkov stash grid measured in cells, not pixels — multiply by 4 to get bytes.
- Minimum IHL value is 5 (20 bytes), maximum is 15 (60 bytes).

### TTL (Time to Live)
- An 8-bit countdown. Each router that forwards the packet decrements TTL by 1.
- When TTL hits 0, the packet gets dropped on the spot — like a Helldivers reinforcement timer running out mid-deployment.
- The router that drops it sends back an **ICMP Time Exceeded** message to the source. This is exactly how `traceroute` works: send packets with TTL=1, 2, 3... and collect the ICMP replies to map every hop.

### Protocol field
- 8 bits identifying what's encapsulated inside (the transport layer payload). It's the "what genre is this game" tag for the packet.
- **TCP = 6**
- **UDP = 17**
- **ICMP = 1**
- The receiving host uses this to know which kernel handler gets the payload.

### Addresses
- **Source Address**: 32 bits. Whoever sent it (allegedly).
- **Destination Address**: 32 bits. Where it's going.
- Neither is cryptographically verified. The source field is honor-system — and honor systems on the internet end exactly how you'd expect. This is the entire mechanic behind spoofed-source DDoS amplification.

### Flags and fragmentation
- **DF (Don't Fragment) bit**: tells routers "don't chop this packet up — if it doesn't fit, drop it and tell me." Used in **Path MTU Discovery**, where the sender probes for the largest packet size the path can carry by setting DF and listening for ICMP "Fragmentation Needed" replies.
- **MF (More Fragments) bit**: set on every fragment except the last, so the receiver knows when reassembly is complete.
- **Fragment Offset**: tells the receiver where this fragment's payload belongs in the reassembled packet — like puzzle piece coordinates.
- Malformed offsets are an attack vector. Overlapping fragments, gaps, or absurd offsets have been used to crash stacks and slip past inspection (teardrop, fragment overlap evasion).

### Routing role
- Routers read the header at every hop — destination IP for the forwarding lookup, TTL for loop prevention, DSCP/ToS bits for QoS treatment.
- The header is rewritten in part at every hop (TTL decrements, header checksum recomputed). The body is supposed to stay untouched — NAT being the famous exception that meddles with addresses anyway.

## Related concepts
- [[IPv6 header]]
- [[ICMP]]
- [[Path MTU Discovery]]
- [[Traceroute]]
- [[IP spoofing]]
- [[DDoS amplification]]
- [[TCP]]
- [[UDP]]
- [[NAT]]
- [[MTU and fragmentation]]
- [[TTL and hop limits]]