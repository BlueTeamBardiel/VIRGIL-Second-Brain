# Administrative Distance

## What it is

In Path of Exile, when you're picking a build guide and three streamers all tell you how to spec your character, you don't roll dice — you trust the one with the best track record. **Administrative Distance** is exactly that: when multiple [[routing protocols]] hand the router conflicting directions to the same destination, the router trusts the source with the best reputation.

Administrative Distance (AD) is a Cisco-defined trustworthiness rating from 0–255 that a router uses to choose between routes learned from different sources to the same destination prefix.

## Why it matters

When a router knows two ways to reach the same network — say, [[OSPF]] says "go left" and [[RIP]] says "go right" — only one route enters the [[routing table]]. Pick wrong and traffic blackholes, loops, or takes the scenic route through a saturated link. AD is also the mechanism behind [[floating static route]]s, the standard CCNA-favorite trick for backup paths. Expect the exam to give you a topology with three protocols and ask which route wins. Lower AD wins. Always.

## Key facts

### The trust hierarchy (memorize this table)

| Source | AD |
|---|---|
| [[Connected route]] | 0 |
| [[Static route]] | 1 |
| [[EIGRP]] summary route | 5 |
| [[BGP]] external (eBGP) | 20 |
| [[EIGRP]] internal | 90 |
| [[IGRP]] | 100 |
| [[OSPF]] | 110 |
| [[IS-IS]] | 115 |
| [[RIP]] | 120 |
| [[EIGRP]] external | 170 |
| [[BGP]] internal (iBGP) | 200 |
| **Unknown / unreachable** | **255** |

**AD 255 means "I refuse to use this route."** It never gets installed. This is not a typo — it's a veto.

### Lower is better

The router picks the **lowest AD**. A connected interface (AD 0) beats everything because the router can literally see the network out its own port. A static route (AD 1) beats every dynamic protocol because you, the human, presumably knew what you were doing when you typed it.

### Tiebreaking inside a protocol

AD only chooses between **different sources**. If two OSPF routes (both AD 110) reach the same prefix, AD doesn't decide — the protocol's own [[metric]] does:

- OSPF uses **cost** (based on bandwidth)
- EIGRP uses a **composite metric** (bandwidth + delay by default)
- RIP uses **hop count**

If metrics also tie, the router installs both and does [[Equal-Cost Multi-Path]] (ECMP) load balancing.

### Floating static routes

The exam loves this. A **floating static route** is a static route with its AD manually raised above a dynamic protocol's AD, so it sits dormant until the dynamic protocol fails.

```
ip route 10.0.0.0 255.0.0.0 192.0.2.1 130
```

That trailing `130` overrides the default AD of 1. With OSPF (AD 110) running, OSPF wins. If OSPF dies, the static "floats up" into the routing table as the backup. Pick a number higher than the protocol you're backing up.

### Useful CLI

```
show ip route
show ip route 10.1.1.0
show ip protocols
```

In `show ip route 10.1.1.0`, the AD and metric appear as `[110/2]` — that's `[AD/metric]`. Read it that way every time.

### Local quirks

- AD is **locally significant** — it's not advertised between routers. Each router decides for itself.
- You can change the AD of a protocol globally with `distance` under the routing process. Don't, unless you have a written reason and a backup career.

## Related concepts

[[Routing table]] · [[Static route]] · [[Floating static route]] · [[OSPF]] · [[EIGRP]] · [[RIP]] · [[Metric]] · [[Equal-Cost Multi-Path]] · [[Longest prefix match]] · [[Routing protocols]]

---
*Source: VIRGIL knowledge base*