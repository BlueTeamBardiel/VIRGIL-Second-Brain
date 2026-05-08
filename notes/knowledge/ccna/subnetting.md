# Subnetting

## What it is

In Destiny, your Guardian's stats run on a fixed pool — Mobility, Resilience, Recovery, Discipline, Intellect, Strength. Boost one tier, another suffers. The total budget never changes; only how you carve it up. Subnetting works the same way with an IP address: you have 32 bits to spend, and you decide how many go to identifying the *network* (the strike) versus the *host* (the Guardians running it).

A **subnet mask** is the rulebook that draws that line. It marks the leftmost bits as "network" and the rest as "host." `255.255.255.0` means the first 24 bits lock in which network you're on, and the last 8 bits identify individual machines inside it.

**CIDR notation** is just shorthand for that mask. Instead of writing `255.255.255.0`, you write `/24` — "the first 24 bits are network." It's the difference between linking a full raid guide versus dropping the LFG code. Same info, faster.

**VLSM (Variable Length Subnet Masking)** is what lets you carve a single network into different-sized chunks. Like the Director splitting the system into the sprawling EDZ patrol zone, a mid-sized strike playlist, and a tight 3v3 Trials arena — you don't allocate a whole planet to host a Crucible match.

## Why it matters

A flat network is Among Us with no walls — the moment one crewmate gets compromised, the impostor wanders freely through every room. Subnetting builds the walls. If your IoT gear sits on `10.0.50.0/24` and your workstations sit on `10.0.10.0/24`, a compromised smart bulb can't just pivot to your laptop without crossing a router (and ideally a firewall ruleset) first.

It's also how the internet stays sane. Without CIDR and variable-sized subnets, ISPs would either hand out massive blocks to tiny customers (wasting addresses) or cram everyone into a slum. Subnetting gives address space the flexibility of a Tears of the Kingdom Ultrahand build — snap pieces together at exactly the size you need.

## Key facts

### Masks and CIDR
- **Subnet mask** = which bits are network, which are host. Network bits on the left, host bits on the right.
- **CIDR notation** = `/n` where `n` is the count of network bits. Compact form of the mask.
- `255.255.255.0` ≡ `/24`
- `255.255.255.128` ≡ `/25`

### Subnet sizes (the ones you'll see constantly)
- **/24** → 256 total addresses, **254 usable** hosts. Two addresses are always reserved: the network address (all host bits 0) and the broadcast (all host bits 1). Like a 256-slot game lobby where slot 0 is "the lobby itself" and slot 255 is "shout to everyone" — neither is a real player.
- **/25** → 128 total, **126 usable**. You sliced the /24 in half — same two reserved addresses per half, so you "lose" two more compared to a single /24.
- **/32** → a single host. The whole address is network, zero host bits. Used for loopbacks, host routes, firewall rules targeting one specific machine. Like pinning a single player in a roster, not a team.
- **/0** → matches every IPv4 address. This is the **default route** — "if no more specific rule applies, send it here." The catch-all dumpster route your packets fall into when nothing else fits.

### VLSM
- Lets one parent network hold subnets of different prefix lengths. A `/24` can be split into a `/25` plus two `/26`s, for example.
- Useful when one segment needs 100 hosts and another needs 6 — give the big one a /25 and the small one a /29 instead of wastefully handing both a /24.

### Security angle
- Subnetting enables **segmentation**: separating workloads (servers, users, guest Wi-Fi, IoT, management) into distinct broadcast domains.
- **Containment**: if attacker code lands on a guest VLAN at `10.0.99.0/24`, lateral movement to `10.0.10.0/24` requires crossing a Layer 3 boundary where ACLs and firewalls live. Without subnetting, lateral movement is free roam.

## Related concepts
[[VLAN]] · [[CIDR]] · [[Default Route]] · [[Network Segmentation]] · [[Broadcast Domain]] · [[Supernetting]] · [[ACL]] · [[Private IP Address Ranges (RFC 1918)]] · [[Routing Table]] · [[IPv6 Prefixes]]