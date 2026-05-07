# Subnet Mask

## What it is

A subnet mask is the bouncer's guest list at a private party. When your laptop wants to send a packet, it checks: "Is this destination on the list of people I can talk to directly, or do I need to hand it off to the router?" The subnet mask is what defines that list.

Technically, it's a 32-bit number that gets applied to an IP address using a bitwise AND operation. The result splits the address into two parts: the **network portion** (which neighborhood you live in) and the **host portion** (which house on the street is yours). Every device with the same network portion is a local neighbor — anything else is a stranger that requires a router to reach.

For example, with IP `192.168.1.50` and mask `255.255.255.0`, the AND operation reveals the network is `192.168.1.0` and the host is `.50`. Anything else starting with `192.168.1.` is a direct neighbor.

## Why it matters

This is the rule that decides whether your packet stays in your Discord server or gets routed to a different server entirely. Get the mask wrong and devices that should be chatting freely will instead bounce off a router that may not even know how to forward them — or worse, devices that should be isolated end up in the same broadcast domain, screaming at each other.

It's also how networks scale without burning IP addresses. Handing every department a `/24` (256 addresses) when they only have 6 devices is like reserving an entire raid lobby for a duo. **Variable Length Subnet Masking (VLSM)** lets you carve a big network into right-sized chunks — a `/30` for a point-to-point link, a `/28` for a small office, a `/24` for a busy floor — so address space isn't wasted.

And from a security and recon angle: a `/24` means an attacker (or your scanner) can sweep all 254 hosts locally without ever bothering a router. The mask literally defines the blast radius of a Layer 2 sweep.

## Key facts

### Notation and math
- **CIDR notation** expresses the mask as a prefix length — the count of consecutive `1` bits from the left. `/24` = 24 network bits, 8 host bits.
- `255.255.255.0` = `/24`. `255.255.0.0` = `/16`. `255.0.0.0` = `/8`. Same number, different outfit.
- Bitwise AND of IP and mask = network address. This is the math the OS does every time you send a packet, like the game checking your inventory before letting you craft.

### Host counting
- Total addresses in a subnet = 2^(host bits). Usable = total − 2.
- The two reserved addresses are the **network address** (all host bits 0) and the **broadcast address** (all host bits 1) — think of them as the lobby and the global chat channel; you can't assign them to a player.
- `/24` → 256 total, **254 usable**.
- `/28` → 16 total, **14 usable**. Common for tiny segments.
- `/16` → 65,536 total, 65,534 usable.

### Classful defaults (legacy but still tested)
- Class A default: `/8`
- Class B default: `/16`
- Class C default: `/24`
- Like default loadouts in Call of Duty — they exist, but nobody serious sticks with them. Modern networks use CIDR and ignore class boundaries entirely.

### Routing behavior
- Same subnet → devices talk directly via Layer 2 (MAC addresses, ARP). No router needed.
- Different subnet → traffic must go through a **Layer 3 device** (router or L3 switch). This is the loading screen between zones.
- A `/24` LAN means a port scanner can hit all 254 hosts without a single packet leaving the local segment — fast, quiet, and invisible to the router's logs.

### VLSM
- Lets you mix subnet sizes inside one parent network. A `10.0.0.0/16` can be split into a `/24` here, a `/28` there, a `/30` for a router link.
- The win: no wasted addresses. The cost: you have to actually plan, instead of handing out `/24`s like candy.

## Related concepts
- [[CIDR notation]]
- [[IPv4 addressing]]
- [[VLSM]]
- [[Broadcast domain]]
- [[ARP]]
- [[Default gateway]]
- [[Routing]]
- [[Classful vs classless addressing]]
- [[Network scanning]]