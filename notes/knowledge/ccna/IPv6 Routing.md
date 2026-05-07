# IPv6 Routing

## What it is

IPv6 routing is the same game with a different netcode. The core loop — look at the destination, check the routing table, forward to the next hop — is identical to IPv4. What changed is how devices *find each other on the wire*, because IPv6 quietly deleted broadcast from the rulebook.

In IPv4, ARP is basically yelling "WHO HAS 192.168.1.10?" into a Discord voice channel where everyone is forced to listen. Annoying, but it works. IPv6 said no — broadcast doesn't exist. Instead, every IPv6 host subscribes to a very specific multicast group derived from its own address, like only getting pinged in Discord when someone uses your exact `@username` instead of `@everyone`. The protocol that handles all of this neighbor-finding is **NDP (Neighbor Discovery Protocol)**, and it runs on ICMPv6.

## Why it matters

If you treat IPv6 like "IPv4 with longer addresses," you'll get blindsided the first time you try to troubleshoot why two hosts can't talk. The neighbor table isn't an ARP table. The "broadcast storm" you were trained to fear doesn't exist the same way. Address autoconfiguration happens through router advertisements you've never had to think about in IPv4.

It's the difference between picking up Elden Ring after playing Dark Souls 3 — most muscle memory carries over, but the new mechanics (jumping, stance breaks, spirit ashes) will get you killed if you ignore them. NDP, multicast scoping, and DAD are those new mechanics.

## Key facts

### The fundamentals
- IPv6 routing logic mirrors IPv4: longest-prefix match, next-hop lookup, forward. The routing table holds **Connected**, **Local**, and **Static** entries.
- For CCNA, only **static routing** is in scope. **OSPFv3** (the IPv6 version) exists but is out of scope. **OSPFv2 only routes IPv4** — there is no "just enable IPv6" toggle, they're separate protocols.
- IPv6 has **no broadcast**. By design. It was cut like a removed character in a fighting game roster.

### NDP — the ARP replacement
- **NDP (Neighbor Discovery Protocol)** does what ARP did, plus more, all over ICMPv6.
- IPv6 devices store Layer 3 → Layer 2 mappings in the **IPv6 neighbor table** (the spiritual successor to the ARP table).
- Four key ICMPv6 message types — think of them as the four buttons on a fight stick:
  - **Type 133 — Router Solicitation (RS):** "Are there any routers here?"
  - **Type 134 — Router Advertisement (RA):** "Yeah, I'm a router, here's the prefix."
  - **Type 135 — Neighbor Solicitation (NS):** "Who has this IPv6 address?"
  - **Type 136 — Neighbor Advertisement (NA):** "That's me, here's my MAC."

### Multicast instead of broadcast
- Instead of yelling at everyone, IPv6 yells at a *very specific* multicast group that the target is guaranteed to be listening on.
- **Solicited-node multicast address** formula: `ff02::1:ff` + the **last 6 hex digits** of the target's unicast address. Like a Discord role auto-assigned based on the last 6 characters of your username — only people with matching tails get the ping.
- **`ff02`** prefix = link-local scope. The packet never leaves the local segment.
- Two well-known groups every IPv6 device cares about:
  - **`ff02::1`** — all IPv6 nodes on the link (every IPv6 host joins).
  - **`ff02::2`** — all IPv6 routers on the link (only routers join).

### How neighbor resolution actually plays out
- Host A wants Host B's MAC. It sends an **NS (type 135)** to Host B's solicited-node multicast address. Only hosts whose address ends in those 6 hex digits even process it — everyone else's NIC drops it at the filter.
- Host B replies with an **NA (type 136)** as a **unicast** straight back to Host A. No multicast on the reply — it's a private DM, not a group chat.
- Hosts send **RS to `ff02::2`** (hey routers, anyone home?).
- Routers send **RA to `ff02::1`** (yo everyone, I'm your gateway, here's the prefix and other config).
- Routers send RA **periodically every 200 seconds** by default, even if no one asked. It's the keep-alive heartbeat — like a server browser refreshing the lobby list.

### Duplicate Address Detection (DAD)
- Before an IPv6 address goes live, the host runs **DAD** to make sure no one else on the link already claimed it. Like checking if your gamertag is taken before the account is created.
- During DAD, the address is marked **tentative** — it exists on the interface but can't actually send or receive normal traffic yet.
- DAD works by sending an **NS** for the address it *wants to use*, with the **source IP set to `::`** (the unspecified address). The logic: "I can't claim this address as my source until I prove no one else has it."
- If no NA comes back in the waiting period, the address transitions from tentative to **valid** and is good to use.
- If someone *does* respond — collision, address rejected, the host won't use it.

## Related concepts
- [[IPv6 Addressing]]
- [[ICMPv6]]
- [[SLAAC (Stateless Address Autoconfiguration)]]
- [[IPv6 Static Routes]]
- [[Link-Local Addresses]]
- [[Multicast Scopes]]
- [[ARP (IPv4 counterpart)]]
- [[OSPFv3]]
- [[EUI-64]]