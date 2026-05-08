# HSRP Hot Standby Router Protocol

## What it is

In Forza, when your lead car blows an engine mid-race, the chase car you've been drafting takes the line and finishes the lap — same livery, same number, the crowd never notices. That's exactly what HSRP does — two routers share one identity so that when the active one dies, the standby keeps forwarding traffic without the hosts ever knowing.

**HSRP** is a Cisco-proprietary [[First Hop Redundancy Protocol]] (FHRP) that lets two or more routers present a single **virtual IP** and **virtual MAC** as the default gateway, with one router actively forwarding and another standing by to take over on failure.

## Why it matters

Without an FHRP, your default gateway is a single point of failure: the router dies, every host on the subnet loses its way out of the LAN until ARP caches expire and someone reconfigures. HSRP collapses that outage from minutes to seconds. On the CCNA, expect to identify the active router by **highest priority** (or highest IP as tiebreaker), recognize the **virtual MAC format**, and know why **preemption is off by default** (it isn't — and that surprises people).

## Key facts

### Roles

| Role | Function |
|------|----------|
| **Active** | Forwards traffic sent to the virtual IP/MAC |
| **Standby** | Monitors active via hellos, takes over on failure |
| **Listen / Speak / Init** | Transitional states during election |

Election: **highest [[HSRP priority]] wins** (default 100, range 0–255). Tiebreaker: **highest interface IP**.

### Virtual IP and Virtual MAC

- **Virtual IP**: configured manually, must be in the subnet, must NOT be a real interface IP on either router.
- **Virtual MAC (HSRPv1)**: `0000.0C07.ACXX` where `XX` is the **group number in hex**.
  - Group 1 → `0000.0C07.AC01`
  - Group 10 → `0000.0C07.AC0A`
- **Virtual MAC (HSRPv2)**: `0000.0C9F.FXXX` where `XXX` is the group in hex.

### HSRPv1 vs HSRPv2

| Feature | HSRPv1 | HSRPv2 |
|---|---|---|
| Group range | 0–255 | 0–4095 |
| Multicast address | **224.0.0.2** | **224.0.0.102** |
| UDP port | 1985 | 1985 |
| Virtual MAC | `0000.0C07.ACXX` | `0000.0C9F.FXXX` |
| IPv6 support | No | Yes |
| Millisecond timers | Limited | Yes |

### Timers

- **Hello**: default **3 seconds** — how often the active sends keepalives.
- **Hold**: default **10 seconds** — if no hello received within this, standby takes over.
- Tunable down to milliseconds in v2 for faster convergence.

### Preemption

**Off by default.** Without it, a recovered higher-priority router will sit as standby until the current active fails. With it, the higher-priority router reclaims the active role immediately on return.

```
interface GigabitEthernet0/1
 ip address 10.1.1.2 255.255.255.0
 standby version 2
 standby 1 ip 10.1.1.1
 standby 1 priority 110
 standby 1 preempt
 standby 1 timers 1 3
 standby 1 authentication md5 key-string CISCO123
 standby 1 track 1 decrement 20
```

### Verification

```
show standby
show standby brief
```

Look for state (`Active`/`Standby`), virtual IP, virtual MAC, priority, and preemption flag.

### Object tracking

[[Object Tracking]] lets HSRP decrement priority when an upstream interface or route fails — so the router stops being active when it can no longer reach the rest of the network. Without it, you become an active gateway to nowhere.

## Related concepts

[[VRRP]] · [[GLBP]] · [[First Hop Redundancy Protocol]] · [[Default Gateway]] · [[ARP]] · [[Object Tracking]] · [[Spanning Tree Protocol]] · [[Gateway Load Balancing]]

---
*Source: VIRGIL knowledge base — 2026-05-07*