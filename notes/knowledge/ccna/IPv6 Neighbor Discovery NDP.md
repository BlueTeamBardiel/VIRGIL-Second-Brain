# IPv6 Neighbor Discovery NDP

## What it is

In Grand Theft Auto V, when you whistle for your personal vehicle, the game pings the world to find where it parked, confirms it's actually yours, and routes Franklin to it — and if someone else tries to claim "Tornado Custom" on the same block, the game refuses the duplicate. That's exactly what NDP does — it's the protocol IPv6 hosts use to find each other on a link, locate routers, and verify nobody else is squatting on their address.

**Neighbor Discovery Protocol (NDP)** is an [[ICMPv6]]-based suite (RFC 4861/4862) that replaces [[ARP]], [[ICMP Router Discovery]], and [[ICMP Redirect]] from IPv4, plus adds address autoconfiguration and duplicate detection.

## Why it matters

Without NDP, an IPv6 host cannot resolve a neighbor's MAC, find a default gateway, or safely assign itself an address. NDP failures manifest as hosts that "have an address" but can't reach anything — and because NDP rides on ICMPv6, blanket-blocking ICMPv6 at a firewall breaks IPv6 entirely. On the exam, expect questions on which message type does what, the role of solicited-node multicast, and how DAD works.

## Key facts

### The five message types

| Type | Number | Purpose | IPv4 Equivalent |
|------|--------|---------|-----------------|
| **Router Solicitation (RS)** | 133 | Host asks "any routers here?" | None (sort of) |
| **Router Advertisement (RA)** | 134 | Router announces prefix, MTU, gateway | ICMP Router Discovery |
| **Neighbor Solicitation (NS)** | 135 | "Who has this IPv6? What's your MAC?" | ARP Request |
| **Neighbor Advertisement (NA)** | 136 | "That's me, here's my MAC" | ARP Reply |
| **Redirect** | 137 | "Use this better next-hop instead" | ICMP Redirect |

All five are [[ICMPv6]] messages. RAs are sent unsolicited every ~200 seconds by default, or in response to an RS.

### Solicited-node multicast

Instead of broadcasting like ARP, NS messages target a **solicited-node multicast address** derived from the target's IPv6:

```
FF02::1:FF + last 24 bits of target address
```

Example: target `2001:db8::1234:5678:9abc` → solicited-node `FF02::1:FFcd:5678` *(wait, recompute: last 24 bits of `5678:9abc` = `78:9abc`)* → `FF02::1:FF78:9ABC`.

Every IPv6 interface joins its own solicited-node group. Result: only hosts whose address ends in those 24 bits process the NS. ARP, by contrast, hits every NIC on the segment.

### Duplicate Address Detection (DAD)

Before an interface uses any [[IPv6 unicast address]] (link-local or global), it sends an NS to its **own** prospective address with source `::` (unspecified). 

- If an NA comes back → address is taken, interface marks it **duplicate** and won't use it.
- If silence → address transitions from **tentative** to **preferred**.

Run on every address. Yes, even the link-local. Yes, even after reboot.

### Address resolution flow

1. Host A wants to reach B's IPv6, doesn't have its MAC.
2. A sends **NS** to B's solicited-node multicast, includes A's own MAC as Source Link-Layer Address option.
3. B responds with unicast **NA** containing its MAC as Target Link-Layer Address.
4. A caches the mapping in its **neighbor cache** (the IPv6 ARP table).

### SLAAC and RA flags

RAs carry flags governing [[SLAAC]]:

- **M flag (Managed)**: use [[DHCPv6]] for addressing.
- **O flag (Other)**: use DHCPv6 for other config (DNS, etc.) only.
- **A flag** (per-prefix): address autoconfig allowed from this prefix.
- **L flag** (per-prefix): prefix is on-link.

### Neighbor cache states

| State | Meaning |
|-------|---------|
| INCOMPLETE | NS sent, awaiting NA |
| REACHABLE | Confirmed reachable recently |
| STALE | Entry aged out, unverified |
| DELAY | Waiting before probing |
| PROBE | Active NS probing in progress |

### Useful Cisco commands

```
show ipv6 neighbors
show ipv6 interface [brief]
show ipv6 routers
debug ipv6 nd
clear ipv6 neighbors
```

### NDP vs ARP

| Feature | ARP (IPv4) | NDP (IPv6) |
|---------|-----------|------------|
| Layer | 2.5 — own EtherType 0x0806 | Layer 3 — ICMPv6 |
| Discovery method | Broadcast | Multicast (solicited-node) |
| Router discovery | Separate (DHCP/static) | Built-in via RA |
| Duplicate detection | Gratuitous ARP (optional) | DAD (mandatory) |
| Authentication | None | SEND (rarely deployed) |
| Redirects | ICMP Redirect (separate) | NDP Redirect (integrated) |

### Security note

NDP is as trustworthy as ARP — i.e., not at all. **NDP spoofing**, **rogue RA**, and **RA flooding** are real attacks. Mitigations: [[RA Guard]], [[IPv6 ND Inspection]], [[IPv6 Source Guard]], or the rarely-seen [[SEND]] (Secure Neighbor Discovery, RFC 3971).

## Related concepts

[[ICMPv6]] · [[SLAAC]] · [[DHCPv6]] · [[IPv6 Link-Local Address]] · [[Solicited-Node Multicast]] · [[ARP]] · [[RA Guard]] · [[Duplicate Address Detection]] · [[EUI-64]] · [[IPv6 Multicast Scopes]]

---
*Source: VIRGIL knowledge base — 2026-05-07*