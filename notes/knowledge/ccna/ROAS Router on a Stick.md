# ROAS Router on a Stick

## What it is

In Metroid, Samus arrives on Zebes with one ship and one entrance, then uses the Morph Ball, Bombs, and Missiles through that same suit to access fundamentally different areas — Brinstar, Norfair, Tourian. One body, multiple capabilities, switched by upgrade. That's exactly what **Router on a Stick** does — one physical router link carries traffic for many VLANs by tagging each frame with a different "upgrade."

**Router on a Stick (ROAS)** is inter-VLAN routing performed by a router with a single trunk link to a switch, using **subinterfaces** — each configured with `encapsulation dot1q <vlan-id>` and an IP address — to route between VLANs.

## Why it matters

Hosts in different VLANs cannot talk without a Layer 3 hop. Without ROAS (or an L3 switch), your VLAN segmentation becomes VLAN isolation — accounting can't reach the file server, voice can't reach the call manager, the help desk learns your name. ROAS is how you preserve broadcast domain separation while still permitting controlled communication between subnets, and it's the cheap way to do it when you only own a Layer 2 switch.

**Exam angle:** CCNA loves to test the trunk encapsulation command, the native VLAN gotcha, and ROAS-vs-SVI tradeoffs.

## Key facts

### The topology

- **Switch side:** one port configured as an [[802.1Q]] trunk to the router.
- **Router side:** one physical interface, brought up with no IP, then carved into [[subinterfaces]] — one per VLAN.
- **One IP subnet per VLAN.** The subinterface IP is the **default gateway** for hosts in that VLAN.

### Switch trunk config

```
interface GigabitEthernet0/1
 switchport trunk encapsulation dot1q
 switchport mode trunk
 switchport trunk allowed vlan 10,20,99
```

(`switchport trunk encapsulation dot1q` only appears on switches that also support ISL — like the 3560. Pure dot1q switches skip it.)

### Router subinterface config

```
interface GigabitEthernet0/0
 no shutdown
!
interface GigabitEthernet0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.1 255.255.255.0
!
interface GigabitEthernet0/0.20
 encapsulation dot1Q 20
 ip address 192.168.20.1 255.255.255.0
!
interface GigabitEthernet0/0.99
 encapsulation dot1Q 99 native
 ip address 192.168.99.1 255.255.255.0
```

- The **subinterface number** (e.g., `.10`) is locally significant — convention is to match the VLAN ID, but the `encapsulation dot1Q` value is what actually matters.
- The physical interface itself must be `no shutdown`. Subinterfaces inherit the L1 state.
- For the **native VLAN**, append the `native` keyword — or, alternatively, put the IP directly on the physical interface (untagged). Mismatched native VLAN = silent black hole.

### Verification

```
show ip route connected
show vlans                 ! shows subinterface-to-VLAN mapping
show interfaces trunk      ! on the switch
```

### ROAS vs Layer 3 Switching with SVIs

| Factor | **ROAS** | **L3 Switch + SVIs** |
|---|---|---|
| Hardware | Cheap router + L2 switch | L3-capable switch (more $$) |
| Forwarding | Software (CPU) on most routers | ASIC, line-rate |
| Bottleneck | The single trunk link + router CPU | Switch backplane (rarely an issue) |
| Config object | `interface G0/0.10` + `encapsulation dot1Q 10` | `interface Vlan10` |
| Scale | Small offices, branch sites | Campus, data center, anywhere serious |
| Latency | Higher | Lower |

### When to use each

- **ROAS:** small site, low inter-VLAN traffic, budget constraints, or you already have a router with a free port and an L2 switch. Lab environments. The CCNA exam.
- **[[SVI]] (Switched Virtual Interface):** anywhere with real traffic volume, more than ~3 VLANs, or where you don't want the trunk to become a chokepoint. Enable with `ip routing` globally and `interface vlan <id>` per VLAN.

### Common failures

- Forgot `no shutdown` on the physical interface — every subinterface stays down.
- Native VLAN mismatch between switch trunk and router — that VLAN's traffic vanishes.
- `switchport trunk allowed vlan` doesn't include a VLAN you configured a subinterface for.
- Hosts pointed at the wrong gateway IP. Always the gateway. It's always DNS, except when it's the gateway.

## Related concepts

[[802.1Q]] · [[VLAN]] · [[Trunk Port]] · [[Native VLAN]] · [[SVI]] · [[Layer 3 Switch]] · [[Inter-VLAN Routing]] · [[Default Gateway]] · [[Subinterface]]

---
*Source: VIRGIL knowledge base — 2026-05-07*