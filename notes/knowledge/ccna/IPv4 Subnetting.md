# IPv4 Subnetting

## What it is

A guild in an MMO with 254 members all dumped into one general chat is chaos — nobody can find anything, every ping spams everyone. So you split it into raid-team channels, PvP channels, crafting channels. Same guild, smaller rooms, traffic stays where it belongs.

That's subnetting. You take a block of IPv4 addresses and slice it into smaller, separately-addressed neighborhoods. The tool that does the slicing is the **subnet mask** — a 32-bit value that tells a device which part of an IP address identifies the *network* (the room) and which part identifies the *host* (the player in the room).

The mask is just a row of 1-bits followed by 0-bits. The 1-bits mark network. The 0-bits mark host. **CIDR notation** (`/24`, `/25`, `/30`) is shorthand for "how many 1-bits are in the mask." A `/24` means 24 network bits, 8 host bits, written longhand as `255.255.255.0`.

## Why it matters

Without subnetting, every device on a network shares one giant broadcast domain — like every player in Helldivers 2 hearing every other squad's voice chat across the entire galaxy. Performance tanks, security collapses, and you can't separate the printers from the production servers.

Subnetting lets you carve a single allocation into isolated zones, control routing between them, apply different ACLs per zone, and not waste addresses on links that only need two IPs. It's the difference between one open-world lobby and properly instanced dungeons.

## Key facts

### The math

- **Usable hosts = 2ⁿ − 2**, where *n* is the number of host bits. The minus 2 is non-negotiable: every subnet burns its first and last address.
- **First address = network ID.** It's the subnet's nameplate, not assignable to a device. Like the lobby code for a Among Us game — it identifies the room, it isn't a player.
- **Last address = broadcast address.** Send a packet here and every host in the subnet receives it. It's the "@everyone" ping of the subnet.

### Common prefix lengths

- **/24 → `255.255.255.0`** — 256 total addresses, **254 usable**. The default home-network-sized block. 8 host bits, so 2⁸ − 2 = 254.
- **/25 → `255.255.255.128`** — splits a /24 cleanly into two halves of 128 addresses each, **126 usable per half**. Useful when you want two separate VLANs from one /24 allocation.
- **/30 → `255.255.255.252`** — 4 total addresses, **2 usable**. The standard mask for **point-to-point router links**, where only two interfaces ever need an IP. Anything bigger is wasted addresses; in a world where IPv4 is rationed, a /30 on a transit link is just hygiene.

### Private address space (RFC 1918)

These three ranges are the "LAN-only" addresses — public internet routers will drop them on sight, like trying to use your Steam friends list to log into someone else's account. They exist so every home and office on Earth doesn't fight over global IPs.

- **`10.0.0.0/8`** — the giant one. ~16.7 million addresses. Beloved by enterprises and cloud VPCs.
- **`172.16.0.0/12`** — the awkward middle child. Covers `172.16.0.0` through `172.31.255.255`.
- **`192.168.0.0/16`** — the home-router classic. Your `192.168.1.1` admin page lives here.

### Quick reference: where the split happens

A `/25` of `10.0.0.0/24` produces:
- `10.0.0.0/25` → network ID `10.0.0.0`, broadcast `10.0.0.127`, usable `10.0.0.1`–`10.0.0.126`
- `10.0.0.128/25` → network ID `10.0.0.128`, broadcast `10.0.0.255`, usable `10.0.0.129`–`10.0.0.254`

The boundary always lands on a power of 2 — you can't subnet on arbitrary numbers any more than you can equip half a weapon slot in Elden Ring.

## Related concepts

[[CIDR notation]]
[[VLSM (Variable Length Subnet Masking)]]
[[Broadcast domain]]
[[NAT (Network Address Translation)]]
[[RFC 1918]]
[[IPv6 addressing]]
[[Routing tables]]
[[VLAN]]