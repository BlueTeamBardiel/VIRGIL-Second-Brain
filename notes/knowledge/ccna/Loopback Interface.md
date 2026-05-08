# Loopback Interface

## What it is

In Gran Turismo, your garage exists no matter what happens on the track — you can wreck every car in a 24-hour endurance race, but the garage itself never goes away. It's the address the game always knows how to find, regardless of which vehicle you're currently driving or which one just exploded into a wall at Spa. That's exactly what a loopback interface is: a virtual interface that stays up as long as the router has power, regardless of what cables get yanked or what neighbors die.

A **loopback interface** is a software-only logical interface on a router that has no physical hardware, remains in `up/up` state whenever the device is operational, and is used as a stable source/destination IP for control-plane and management-plane traffic.

## Why it matters

Physical interfaces flap. Cables get unplugged, transceivers fail, the intern trips over something at 3 AM. If you tied your [[OSPF]] [[Router ID]], your [[BGP]] peering source, or your [[SSH]] management address to a physical interface, every flap would tear down adjacencies, reset sessions, and page you out of bed. Loopbacks exist so the brain of the router has an address that doesn't depend on any single piece of copper or glass continuing to work. On the CCNA, expect questions on loopback as Router ID selection and on configuring/advertising loopbacks in OSPF.

## Key facts

### Configuration

```
Router(config)# interface loopback 0
Router(config-if)# ip address 10.0.0.1 255.255.255.255
Router(config-if)# no shutdown    ! not strictly required; up by default
```

Range is `loopback 0` through `loopback 2147483647`. You typically use **`/32`** (a host route) because the interface represents a single endpoint, not a subnet — wasting addresses on a virtual interface is a sin.

### State behavior

| Condition | Physical interface | Loopback |
|---|---|---|
| Cable unplugged | down/down | up/up (no cable exists) |
| `shutdown` issued | admin down | admin down |
| Neighbor router dies | up/up | up/up |
| Router powered off | down | down (router is gone) |

The loopback is up the moment it's created. There is nothing to "go wrong" physically.

### Router ID selection (OSPF and BGP)

Both [[OSPF]] and [[BGP]] choose a 32-bit [[Router ID]] using this order:

1. Manually configured `router-id A.B.C.D` (preferred — always do this in production)
2. Highest IP on any **up** loopback interface
3. Highest IP on any **up** physical interface

Loopbacks beat physical interfaces in step 2/3 because they don't flap. A flapping Router ID is a catastrophe — adjacencies reset, the [[LSDB]] churns, and the network reconverges for no good reason.

### Advertising loopbacks into OSPF

```
Router(config)# router ospf 1
Router(config-router)# network 10.0.0.1 0.0.0.0 area 0
```

By default OSPF advertises a loopback as a **`/32` host route** regardless of the configured mask. To advertise the actual configured subnet:

```
Router(config-if)# ip ospf network point-to-point
```

This is a classic CCNA gotcha.

### Management plane uses

- **[[SSH]] destination**: `ssh -l admin 10.0.0.1` works as long as *any* path to the router exists.
- **[[SNMP]] / [[Syslog]] / [[NetFlow]] / [[TACACS+]] / [[RADIUS]] source**: pin them to loopback so logs and AAA requests come from a consistent IP:
  ```
  Router(config)# ip ssh source-interface Loopback0
  Router(config)# logging source-interface Loopback0
  Router(config)# snmp-server trap-source Loopback0
  ```
- **[[BGP]] peering**: `neighbor 10.0.0.2 update-source Loopback0` for iBGP redundancy across multiple physical paths. Requires `ebgp-multihop` for eBGP since loopbacks are more than one hop away.

### Loopback vs physical interface

| Property | Loopback | Physical (e.g. Gi0/1) |
|---|---|---|
| Hardware required | No | Yes |
| Can flap | No | Yes |
| Default state | up/up on creation | down until cabled & no shut |
| Typical mask | /32 | per subnet design |
| Good for Router ID | Yes | No |
| Good for end-user traffic | No | Yes |

### Note on the 127.0.0.0/8 host loopback

The IP standard reserves `127.0.0.0/8` for host loopback (your laptop's `localhost`). Cisco router loopback **interfaces** are unrelated — they use whatever address you assign, typically from your internal management range like `10.0.0.0/24`.

## Related concepts

[[OSPF]] · [[BGP]] · [[Router ID]] · [[SSH]] · [[Management Plane]] · [[Control Plane]] · [[LSDB]] · [[/32 Host Route]] · [[ip ospf network point-to-point]] · [[update-source]]

---
*Source: VIRGIL knowledge base*