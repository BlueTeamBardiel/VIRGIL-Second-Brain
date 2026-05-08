# GLBP Gateway Load Balancing Protocol

## What it is

In DayZ, you and three other survivors form a squad and agree that whenever a fresh spawn radios for help on the coast, *one* of you answers the call — but the rescue itself gets handed off in rotation so no single player burns through all their loot runs to Cherno. That's exactly what GLBP does — one router answers every "where's the gateway?" request, but the actual packet-pushing work gets distributed across the whole group.

**GLBP** (Gateway Load Balancing Protocol) is a Cisco-proprietary [[FHRP]] that provides both gateway redundancy *and* active load balancing across up to four routers per group, using a single virtual IP but multiple virtual MACs.

## Why it matters

[[HSRP]] and [[VRRP]] elect one active forwarder and let the standby routers sit idle, burning rack space and licensing on hardware that only matters when something dies. GLBP actually uses every router in the group simultaneously, which is the only FHRP that load-balances without requiring you to manually split hosts across multiple [[VLAN]]s or virtual IPs. **Exam angle:** know that GLBP is Cisco-only, uses UDP 3222, multicasts to 224.0.0.102, and that the AVG is the *single* point that hands out MAC addresses — even though forwarding is distributed.

## Key facts

### Roles

- **AVG** ([[Active Virtual Gateway]]) — the elected boss. Responds to all [[ARP]] requests for the virtual IP, and hands out one of up to four virtual MACs in rotation. Only one AVG per group. Highest priority wins (default 100); tiebreaker is highest IP.
- **AVF** ([[Active Virtual Forwarder]]) — does the actual packet forwarding for one assigned virtual MAC. Up to four AVFs per group. Each non-AVG router becomes an AVF; the AVG is also an AVF.
- **Standby Virtual Gateway (SVG)** — second-highest priority router, ready to take over AVG duties.
- **Secondary Virtual Forwarder** — backs up an AVF if its primary dies.

### Load-balancing methods

| Method | Behavior |
|---|---|
| **Round-robin** (default) | AVG hands out vMACs in rotation to each ARP requester. Even distribution. |
| **Weighted** | Each router assigned a weight; AVG distributes proportionally. Useful when routers have unequal capacity. |
| **Host-dependent** | A given host always gets the same vMAC. Required when stateful services (firewalls, NAT) need session persistence. |

### Virtual MAC format

`0007.b400.XXYY` — where `XX` is the GLBP group number and `YY` is the forwarder number (01–04).

### Timers (defaults)

- **Hello:** 3 seconds
- **Hold:** 10 seconds
- **Redirect:** 600 seconds (how long the AVG keeps directing new ARPs to a failed AVF's vMAC before reassigning)
- **Timeout:** 14400 seconds (4 hours — when the failed vMAC is permanently flushed)

### Configuration

```
interface GigabitEthernet0/1
 ip address 10.1.1.2 255.255.255.0
 glbp 1 ip 10.1.1.1
 glbp 1 priority 150
 glbp 1 preempt
 glbp 1 load-balancing host-dependent
 glbp 1 weighting 100 lower 80 upper 95
 glbp 1 authentication md5 key-string CCNA2026
```

### Verification

```
show glbp
show glbp brief
```

### Why it's different from HSRP/VRRP

| | HSRP | VRRP | GLBP |
|---|---|---|---|
| Origin | Cisco | IETF (RFC 5798) | Cisco |
| Active routers | 1 | 1 (master) | Up to 4 (AVFs) |
| Virtual MACs | 1 | 1 | Up to 4 |
| Load balancing | No (without manual VLAN tricks) | No | **Yes, native** |
| Multicast addr | 224.0.0.2 (v1) / 224.0.0.102 (v2) | 224.0.0.18 | 224.0.0.102 |
| Transport | UDP 1985 | IP proto 112 | UDP 3222 |

## Related concepts

[[HSRP]] · [[VRRP]] · [[FHRP]] · [[ARP]] · [[Default Gateway]] · [[Object Tracking]] · [[Spanning Tree Protocol]]

---
*Source: VIRGIL knowledge base — 2026-05-07*