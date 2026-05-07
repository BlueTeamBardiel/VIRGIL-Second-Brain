# IPv6 Addressing

## What it is

IPv4 ran out of addresses the same way Fortnite skins run out of unique names — every good one is taken, and the registry is just shuffling leftovers. With only 2^32 addresses (~4.3 billion), IPv4 simply couldn't keep up with phones, laptops, smart fridges, and every IoT lightbulb wanting its own slot.

IPv6 is the fix: a 128-bit address space, which is 2^128 addresses. That's roughly 340 undecillion. Enough to assign an address to every grain of sand on Earth and still have inventory left over for the sequel planet.

An IPv6 address is written as **eight groups of four hexadecimal digits, separated by colons**:

```
2001:0db8:0000:0000:0000:ff00:0042:8329
```

Each hex digit = 4 bits. Hex runs 0–9 then A–F (because once you hit 10 in binary nibble-land, you need single-character symbols for 10–15). Eight groups × 16 bits = 128 bits total.

Two shorthand rules keep you sane:
- **Drop leading zeros** in any group: `0042` → `42`
- **Collapse one run of all-zero groups** into `::` (only once per address, otherwise it's ambiguous)

So that monster above becomes: `2001:db8::ff00:42:8329`.

## Why it matters

Every Regional Internet Registry has already hit the IPv4 wall — APNIC in 2011, ARIN in 2015, RIPE NCC in 2019, LACNIC and AFRINIC in 2020. There is no more IPv4 to hand out at the source. NAT and CGNAT are duct tape; IPv6 is the actual replacement floor.

For anyone touching networks, IPv6 isn't a "future thing." It's running on your phone right now, dual-stacked next to IPv4, and your home ISP probably handed you a /64 without telling you. Mobile carriers in particular are IPv6-first — IPv4 is the legacy fallback, like still owning a disc copy of a game you bought on Steam.

It also fundamentally changes how the protocol behaves: no broadcast, no router-side fragmentation, simpler header, mandatory multicast for housekeeping. If you're troubleshooting and expecting IPv4 reflexes, you'll get burned.

## Key facts

### Address space and notation
- **IPv4**: 2^32 addresses, 32-bit. **IPv6**: 2^128 addresses, 128-bit.
- Eight 16-bit groups, colon-separated, hex.
- Leading zeros in a group can be dropped.
- One run of consecutive all-zero groups can become `::` — once per address.
- CIDR uses slash notation just like IPv4: `2001:db8::/32`.

### Global Unicast Addresses (GUA) — the public internet ones
Think of these as the IPv6 version of a public IPv4 — globally routable, your device's actual address on the open net.
- Begin with `2000::/3` (binary prefix `001`).
- Typical structure: **/48 global routing prefix** (what your ISP gives an org) + **16-bit subnet ID** (your internal subnetting playground, 65,536 subnets) + **64-bit interface ID** (the host portion).
- That /64 host portion is non-negotiable for SLAAC to work.

### Link-Local Addresses — the LAN-only walkie-talkie
Like proximity voice chat in Among Us — only works in the current room, never leaves the lobby.
- Begin with `fe80::/10`.
- Auto-generated on every IPv6 interface, no config required.
- **Never routed.** Link-local scope only — used for neighbor discovery, router advertisements, OSPFv3 adjacencies.

### Unique Local Addresses (ULA) — the private RFC1918 equivalent
The IPv6 cousin of `10.0.0.0/8` — fine inside your org, dead on arrival on the public internet.
- Begin with `fc00::/7`.
- Not routed on the public internet, but routable inside an organization.

### Multicast — the new broadcast
IPv6 killed broadcast entirely. Instead of yelling at every device on the segment, you subscribe to a channel — like only the players in your Discord voice channel hearing you, not the whole server.
- Begin with `ff00::/8`.
- The second hex digit encodes **scope** (link-local, site-local, global, etc.).
- `ff02::1` — all nodes on the link (closest thing to "broadcast").
- `ff02::2` — all routers on the link.
- `ff02::1:ff00:0/104` — solicited-node multicast, used by Neighbor Discovery (the ARP replacement) so only the target NIC processes the request.

### Anycast
- Syntactically identical to a unicast address — you can't tell them apart by looking.
- Multiple devices share it; traffic goes to the topologically nearest one. Like queueing for a Helldivers 2 match and getting routed to whichever server has the lowest ping.

### IPv6 vs IPv4 header differences
- IPv6 header is **40 bytes fixed**. IPv4 is **20–60 bytes variable**.
- IPv6 source/dest are 128 bits each; IPv4 are 32 bits.
- **No checksum** in IPv6 — L2 and L4 already handle integrity, so the network layer stopped double-paying.
- **Hop Limit** replaces TTL (same job, honest name — it was never measuring time).
- **Fragmentation only at the source host**, never at routers. Routers just drop and send "Packet Too Big" — Path MTU Discovery is mandatory now.
- **Traffic Class** + **Flow Label** fields support QoS and per-flow handling.

### Address generation
- **EUI-64**: builds the 64-bit interface ID from the MAC address by stuffing `fffe` into the middle and flipping the universal/local bit. Deterministic but privacy-leaky.
- **SLAAC (Stateless Address Auto-Configuration)**: device hears a Router Advertisement, learns the /64 prefix, generates its own interface ID (EUI-64 or random), and self-assigns. No DHCP server required — like joining a Minecraft LAN game and getting auto-slotted in.

### Cisco IOS commands
- `ipv6 unicast-routing` — global config, turns on IPv6 routing on the box. Without this, the router forwards exactly nothing over IPv6.
- `ipv6 address 2001:db8::1/64` — assigns a static address to an interface.
- `ipv6 address fe80::1 link-local` — manually pin a link-local address (otherwise it's auto-derived).
- `ipv6 address autoconfig` — interface uses SLAAC to grab its own address from RAs.

## Related concepts
[[Neighbor Discovery Protocol (NDP)]]
[[SLAAC and DHCPv6]]
[[EUI-64]]
[[ICMPv6]]
[[Path MTU Discovery]]
[[Dual Stack and IPv6 Transition Mechanisms]]
[[IPv4 Exhaustion and CGNAT]]
[[OSPFv3]]
[[Router Advertisements]]