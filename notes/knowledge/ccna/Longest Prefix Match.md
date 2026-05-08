# Longest Prefix Match

## What it is

In Subnautica, when your Seamoth, your fins, and your fabricated swim charge all stack to determine your swim speed, the most specific upgrade module dictates the actual calculation. **Longest Prefix Match** works the same way for routes — when multiple routes in the table could deliver a packet, the router picks the most specific one and discards the rest.

The router selects the route in its [[routing table]] whose destination prefix matches the most leading bits of the packet's destination IP address.

## Why it matters

If your router picks the wrong route, packets walk off a cliff — wrong next-hop, blackhole, or worse, leaked out the internet-facing interface when they should've stayed internal. Longest prefix match overrides both [[Administrative Distance]] and [[routing metric]], which trips up every CCNA candidate at least once. On the exam, expect a routing table screenshot and a "which route is used for destination X?" question — get the prefix logic wrong and you lose the point regardless of how well you know OSPF.

## Key facts

### The rule

**Most specific prefix wins. Always.** Not lowest [[Administrative Distance]]. Not lowest metric. Not the protocol you like best. The longest prefix.

- `/32` is a single host — wins over everything
- `/24` beats `/16`
- `/16` beats `/8`
- `/0` (the [[default route]]) only wins when nothing else matches

[[Administrative Distance]] and metrics only break ties **between routes with the same prefix length**.

### Worked example

Routing table:

| Route | Next-hop | Protocol | AD/Metric |
|---|---|---|---|
| `0.0.0.0/0` | 203.0.113.1 | Static | 1/0 |
| `10.0.0.0/8` | 192.168.1.1 | [[EIGRP]] | 90/... |
| `10.1.0.0/16` | 192.168.2.1 | [[OSPF]] | 110/... |
| `10.1.1.0/24` | 192.168.3.1 | [[RIP]] | 120/... |
| `10.1.1.1/32` | 192.168.4.1 | Static | 1/0 |

Packet destinations:

- **10.1.1.1** → matches all five. Winner: `/32` via 192.168.4.1. RIP "loses" to a worse-AD static because /32 is longer than /24.
- **10.1.1.50** → matches `/24`, `/16`, `/8`, `/0`. Winner: `/24` via 192.168.3.1 ([[RIP]]). EIGRP's better AD is irrelevant.
- **10.2.5.5** → matches `/8` and `/0`. Winner: `/8` via 192.168.1.1.
- **8.8.8.8** → matches only `/0`. Winner: default route via 203.0.113.1.

### The default route

`0.0.0.0/0` matches every IPv4 address but with prefix length zero — **it's the route of last resort**. Configure it with:

```
ip route 0.0.0.0 0.0.0.0 203.0.113.1
```

Or learn it dynamically (OSPF `default-information originate`, EIGRP redistribution, etc.). Without a default route and no specific match, the router drops the packet and may send [[ICMP]] Destination Unreachable.

### Verification commands

```
show ip route
show ip route 10.1.1.1
show ip route longer-prefixes 10.1.0.0 255.255.0.0
```

`show ip route 10.1.1.1` is the killer command — it tells you exactly which route the router would use, no math required.

### Relationship to CIDR and classless routing

[[CIDR]] (Classless Inter-Domain Routing) is what makes longest prefix match meaningful. Pre-CIDR classful routing forced prefixes into rigid /8, /16, /24 buckets based on the first octet. [[Classless routing]] frees the prefix length from the address class, so `/19`, `/27`, `/30` all become legal — and the router needs longest prefix match to pick intelligently among overlapping supernets and subnets.

[[VLSM]] (Variable Length Subnet Masking) inside a single network only works because longest prefix match exists. Otherwise overlapping subnets would be ambiguous.

### Common gotchas

- A `/32` static route is a surgical override — useful for [[policy-based routing]] alternatives, dangerous if forgotten.
- Summary routes (e.g., `10.0.0.0/8`) get bypassed by more specific learned routes — this is by design and is how route leaking attacks work.
- The [[FIB]] (Forwarding Information Base) on hardware-accelerated platforms pre-computes longest prefix match into a TCAM lookup — same logic, just faster.

## Related concepts

[[Routing table]] · [[Administrative Distance]] · [[CIDR]] · [[VLSM]] · [[Default route]] · [[Subnet mask]] · [[Static route]] · [[FIB]] · [[Classful vs Classless routing]]

---
*Source: VIRGIL knowledge base*