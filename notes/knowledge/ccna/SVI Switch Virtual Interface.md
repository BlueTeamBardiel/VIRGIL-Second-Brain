# SVI Switch Virtual Interface

## What it is

In Half-Life, the long tram ride at the start of Black Mesa passes through dozens of physical sectors — but you reach them all through the same logical tram system, not by walking the rails. An **SVI** does the same thing: it's a single logical doorway into a whole VLAN, no physical cable required.

A **Switch Virtual Interface (SVI)** is a Layer 3 logical interface on a multilayer switch bound to a VLAN ID, used to route traffic into and out of that VLAN.

## Why it matters

Without an SVI, every VLAN needs an external router-on-a-stick, and inter-VLAN traffic hairpins through a single physical link — slow, fragile, and a bottleneck waiting to crash. The SVI moves routing onto the switch ASIC, making it line-rate. On the CCNA exam, expect a question where the SVI is "configured" but the VLAN has no active access port, so the SVI stays **down/down** and nothing routes — a classic gotcha.

## Key facts

### Creation order matters

The [[VLAN]] must exist before the SVI will come up. Two ways to create it:

```
Switch(config)# vlan 10
Switch(config-vlan)# name USERS
Switch(config-vlan)# exit
```

Then build the SVI:

```
Switch(config)# interface vlan 10
Switch(config-if)# ip address 192.168.10.1 255.255.255.0
Switch(config-if)# no shutdown
```

### Enable routing globally

A [[Multilayer Switch]] does not route by default. Without this, the SVI is just a management interface:

```
Switch(config)# ip routing
```

For IPv6, the equivalent is `ipv6 unicast-routing`.

### SVI line state rules

An SVI is **up/up** only when **all** of the following are true:

| Requirement | Reason |
|---|---|
| The VLAN exists in the VLAN database | No VLAN, no interface |
| At least one access port in that VLAN is **up** | Or a trunk carrying that VLAN is up and the VLAN is allowed/active |
| `no shutdown` on the SVI itself | Default is administratively down |
| VLAN is not shut down (`no shutdown` in vlan config) | VLANs themselves can be shut |

This is the **autostate** behavior. Override it with `switchport autostate exclude` on a port if needed.

### Default gateway role

Hosts in the [[VLAN]] use the SVI's IP as their **default gateway**. Combined with [[HSRP]] / [[VRRP]] / [[GLBP]], multiple switches can share a virtual gateway IP for redundancy.

### Verification

```
Switch# show ip interface brief
Switch# show interface vlan 10
Switch# show vlan brief
Switch# show ip route connected
```

### SVI vs Routed Port

| Feature | SVI | Routed Port |
|---|---|---|
| Command | `interface vlan X` | `no switchport` on physical |
| Tied to | A VLAN | A single physical port |
| Use case | Inter-VLAN routing, gateway | Point-to-point L3 link |
| MAC address | One per SVI (from switch pool) | Per physical port |

## Related concepts

[[VLAN]] · [[Inter-VLAN Routing]] · [[Multilayer Switch]] · [[Router-on-a-Stick]] · [[Trunk Port]] · [[HSRP]] · [[Routed Port]] · [[Default Gateway]] · [[ip routing]]

---
*Source: VIRGIL knowledge base — 2026-05-07*