# VRRP Virtual Router Redundancy Protocol

## What it is

In Persona, when your protagonist gets knocked out, it's game over — but if any other party member falls, Joker keeps fighting and the battle continues seamlessly. That's exactly what VRRP does — if the active router dies, a backup instantly takes its place using the same virtual IP, and hosts never notice their default gateway changed.

**VRRP** (Virtual Router Redundancy Protocol) is an [[IETF]] open-standard [[FHRP]] defined in [[RFC 5798]] that allows multiple routers to share a virtual IP address, with one elected **Master** forwarding traffic and others standing by as **Backup**.

## Why it matters

A default gateway is a single point of failure. Without redundancy, one dead router means an entire subnet loses external connectivity until a human notices and fixes it. VRRP solves this in sub-second timeframes without reconfiguring a single host. On the CCNA, expect to compare it directly to [[HSRP]] — Cisco loves asking which protocol is open standard, which uses which multicast address, and what the default priority is.

## Key facts

### Roles

- **Master** — forwards traffic for the [[Virtual IP]]; sends [[VRRP Advertisements]] every 1 second by default.
- **Backup** — listens for advertisements; if 3× advertisement interval passes silently (~3 seconds), highest-priority backup takes over.
- **Owner** — a router whose real interface IP equals the virtual IP. The owner is automatically Master with priority **255** (cannot be configured manually). Most deployments skip this and use a separate virtual IP.

### Critical numbers

| Parameter | Value |
|---|---|
| Default priority | **100** |
| Owner priority | **255** (reserved) |
| Priority range | 1–254 (configurable) |
| Multicast address | **224.0.0.18** |
| IP protocol number | **112** |
| Virtual MAC | **0000.5E00.01XX** (XX = VRRP group ID in hex) |
| Default advertisement timer | 1 second |
| Default master down interval | ~3 seconds |
| Preemption | **Enabled by default** (opposite of HSRP) |

### VRRP vs HSRP

| Feature | [[VRRP]] | [[HSRP]] |
|---|---|---|
| Standard | IETF (open) | Cisco proprietary |
| Groups | 0–255 | 0–255 (v1), 0–4095 (v2) |
| Multicast | 224.0.0.18 | 224.0.0.2 (v1), 224.0.0.102 (v2) |
| Virtual MAC | 0000.5E00.01XX | 0000.0C07.ACXX |
| Active router term | Master | Active |
| Default priority | 100 | 100 |
| Preemption default | **On** | **Off** |
| Can use real IP as VIP | Yes (owner) | No |

### Configuration (IOS — VRRPv2)

```
interface GigabitEthernet0/1
 ip address 10.1.1.2 255.255.255.0
 vrrp 1 ip 10.1.1.1
 vrrp 1 priority 110
 vrrp 1 preempt
 vrrp 1 authentication md5 key-string CISCO
```

### Verification

```
show vrrp
show vrrp brief
show vrrp interface GigabitEthernet0/1
```

### Versions

- **VRRPv2** — IPv4 only ([[RFC 3768]], updated by [[RFC 5798]]).
- **VRRPv3** — supports IPv4 and IPv6, sub-second timers in milliseconds.

## Related concepts

[[HSRP]] · [[GLBP]] · [[FHRP]] · [[Default Gateway]] · [[Multicast]] · [[Gratuitous ARP]] · [[Virtual MAC]] · [[RFC 5798]]

---
*Source: VIRGIL knowledge base — 2026-05-07*