# IPv4 Address Space

## What it is

IPv4 addresses are like Steam account IDs from the early 2000s — a finite pool of unique numbers handed out one at a time, and the system was designed back when nobody thought we'd run out. Each IPv4 address is a 32-bit binary number, which gives you 2³² = 4,294,967,296 possible combinations. That sounds like a lot until you remember every phone, laptop, smart fridge, and security camera on Earth wants one.

Because reading `11000000.10101000.00000001.00000001` out loud is a war crime, we write IPv4 in **dotted-decimal notation**: four 8-bit chunks (octets) separated by dots, each ranging 0–255. So that binary becomes `192.168.1.1`. The full address space spans `0.0.0.0` to `255.255.255.255`.

Every IPv4 address is split into two parts — a **network portion** (which neighborhood you live in) and a **host portion** (which house on the street). The **subnet mask** is the line that decides where the split happens. Think of it like a Minecraft world border: same world if you're inside the same network bits, different dimension if you're not.

## Why it matters

The internet ran out of IPv4 addresses. Not "is running low" — past tense. **IANA handed out its last /8 blocks in February 2011.** Every device you own that touches the internet is sharing a public address with thousands of strangers thanks to NAT, which exists almost entirely as a workaround for this exhaustion.

This shapes basically every networking decision you'll ever make: why your home router has `192.168.1.1` instead of a real public IP, why port forwarding exists, why VPNs are weird, why CGNAT breaks Call of Duty party chat, why IPv6 keeps getting pushed. The address space isn't just trivia — it's the gravity well every modern network design orbits.

## Key facts

### Format and structure
- **32 bits, four octets, dotted-decimal**: `10.0.0.5` is just `00001010.00000000.00000000.00000101` in a friendlier outfit.
- **Total space**: 2³² ≈ 4.29 billion addresses. Earth has ~8 billion people. Math doesn't math.
- **Network vs host split**: subnet mask draws the line. `/24` means first 24 bits are network, last 8 are host — like calling dibs on the first three octets as your guild tag.

### Classful addressing (legacy, but still on every exam)
Old-school IPv4 hardcoded the network/host split based on the first octet:
- **Class A**: `/8` mask — huge networks, ~16.7M hosts each
- **Class B**: `/16` mask — medium networks, ~65K hosts each
- **Class C**: `/24` mask — small networks, 254 usable hosts

This was wasteful as hell — giving an entire Class A to an org that needed 10,000 addresses burned millions. **CIDR (Classless Inter-Domain Routing)** replaced it, letting you slice masks at any bit boundary like `/19` or `/27`. CIDR is the difference between buying groceries by the pound versus being forced to buy a whole pallet.

### Reserved ranges (do not assign these to your homelab uplink)
- **`10.0.0.0/8`** — RFC 1918 private. The big one. Most corporate networks live here.
- **`172.16.0.0/12`** — RFC 1918 private. The forgotten middle child. Docker loves this range.
- **`192.168.0.0/16`** — RFC 1918 private. Every home router on Earth.
- **`127.0.0.0/8`** — Loopback. `127.0.0.1` is "me, myself, and I." Packets here never leave the host.
- **`169.254.0.0/16`** — APIPA / link-local. Your OS assigns one of these when DHCP ghosts it. If you see `169.254.x.x`, something is broken — it's the Windows equivalent of "no signal."
- **`0.0.0.0/8`** — Unspecified. `0.0.0.0` means "any address" or "I don't have one yet." Servers bind here to listen on all interfaces.
- **`255.255.255.255`** — Limited broadcast. Shouts to every device on the local segment, like @everyone in a Discord server but for packets.

### RFC 1918 and why your home IP is fake
Private ranges are **non-routable on the public internet** — backbone routers drop them on sight. That's why your laptop's `192.168.1.42` needs **NAT** (Network Address Translation) to talk to YouTube. Your router rewrites the source address to its public IP, remembers the swap, and translates replies back. IPv4 exhaustion is the entire reason NAT became universal — without the address shortage, every device would have its own public address and NAT would be a footnote.

### Exhaustion timeline
- **February 2011**: IANA allocated its last five /8 blocks to the Regional Internet Registries. Game over at the top level.
- RIRs (ARIN, RIPE, APNIC, etc.) ran out at different times after that, with APNIC first in 2011 and ARIN in 2015.
- A secondary market for IPv4 blocks now exists — addresses trade for $40–60+ each. Yes, people speculate on IP addresses like Pokémon cards.

## Related concepts
[[Subnetting and CIDR]]
[[NAT and PAT]]
[[RFC 1918 Private Addressing]]
[[IPv6 Address Space]]
[[DHCP and APIPA]]
[[Loopback Interfaces]]
[[Broadcast Domains]]
[[Classful vs Classless Routing]]