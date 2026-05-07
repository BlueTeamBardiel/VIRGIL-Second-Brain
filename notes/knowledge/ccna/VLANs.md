# VLANs

## What it is

A Discord server with separate channels for #general, #raids, and #mod-only — everyone's connected to the same server, but you only hear the channels you're allowed in. A VLAN (Virtual LAN) does the same thing to a physical switch: it carves one piece of hardware into multiple logically isolated broadcast domains, so devices on VLAN 10 can't see broadcasts from VLAN 20 even if they're plugged into the same switch.

Technically, a VLAN tags Ethernet frames so switches know which "channel" each frame belongs to. The standard that defines this tagging is **IEEE 802.1Q**, which inserts a 4-byte tag into the Ethernet header containing a 12-bit VLAN ID. That 12-bit field is why you get up to 4,094 usable VLANs (IDs 0 and 4095 are reserved, and ID 1 is the default/reserved-ish one most vendors won't let you delete).

## Why it matters

Without VLANs, every device on a switch shares one giant broadcast domain — like every player in Among Us being forced into one emergency meeting at all times. ARP storms, chatty IoT devices, and a guest laptop would all yell into the same room as your servers.

VLANs let you slice that single physical infrastructure into security and performance zones without buying more switches. The finance team, the printers, the guest Wi-Fi, and the security cameras can all live on the same switch hardware while remaining as isolated as separate buildings — *until* you deliberately let them talk via a Layer 3 device.

The catch: VLANs are segmentation, not security. They stop accidental leakage and limit broadcast scope, but a VLAN boundary is not a firewall. Treat them like the locked doors between rooms in a Resident Evil mansion — they keep the zombies in their lanes, but the doors themselves don't inspect what walks through once you unlock them.

## Key facts

### The basics
- **VLAN definition**: a logical segmentation of one physical network into multiple isolated Layer 2 broadcast domains.
- **802.1Q**: IEEE standard for VLAN tagging on Ethernet frames. The tag rides inside the frame header so trunk links can carry many VLANs at once — like a Helldivers 2 dropship hauling multiple squads with mission patches so command knows who belongs where.
- **VLAN ID field**: 12 bits → **4,094 usable VLANs** (IDs **1 and 4095 are reserved**; ID 0 means "priority tag, no VLAN").
- **Broadcast domain containment**: a broadcast on VLAN 10 stays on VLAN 10. This is the headline performance benefit.

### Inter-VLAN routing
- VLANs **do not route traffic between themselves**. By design, VLAN 10 and VLAN 20 are strangers.
- To pass traffic between VLANs you need a **Layer 3 device** — either a **router** (router-on-a-stick with subinterfaces) or a **Layer 3 switch** with SVIs (Switched Virtual Interfaces).
- Think of it like fast travel in Elden Ring: each VLAN is its own region, and the L3 device is the Site of Grace network that lets you jump between them — and ideally inspects you on the way.

### VLAN hopping (the attack)
- **VLAN hopping** lets an attacker send traffic into a VLAN they shouldn't be on. Two main flavors:
  - **Switch spoofing**: attacker pretends to be a switch and negotiates a trunk via DTP, then receives all VLANs.
  - **Double-tagging**: attacker stacks two 802.1Q tags. The first switch strips the outer (native VLAN) tag and forwards the frame on the trunk; the next switch reads the inner tag and delivers the frame to the target VLAN. It's a one-way Watch Dogs-style packet smuggle — replies don't come back, but a single malicious payload is often all you need.
- **DTP (Dynamic Trunking Protocol)** is the Cisco protocol that auto-negotiates whether a port becomes a trunk. Convenient, also the on-ramp for switch spoofing.

### Hardening
- **Set the native VLAN to an unused ID** on trunk links — kills the double-tagging trick because the attacker's outer tag no longer matches the trunk's native VLAN, so the first switch won't strip it.
- **Disable DTP** on access ports (`switchport nonegotiate`) and explicitly configure trunks. Don't let port roles auto-negotiate; assign them like you'd assign roles in a ranked Marvel Rivals match — manually, with intent.
- **Don't put any user data in the native VLAN.** It's the unmarked cargo, and unmarked cargo is exactly what attackers exploit.

### Defense-in-depth companions
- **Port security**: limits which (and how many) MAC addresses can appear on an access port. Stops a rogue switch or laptop from being plugged into a wall jack and impersonating five devices at once.
- **Private VLANs (PVLANs)**: subdivide a VLAN into **isolated** and **community** secondary VLANs so hosts in the *same* VLAN can't talk to each other — only to a promoted "promiscuous" port (usually the gateway). Useful for hotel-style or DMZ segments where every host should reach the router but not its neighbors.
- **VLANs are not a firewall substitute**. Between sensitive segments (DMZ ↔ internal, user ↔ server, OT ↔ IT), you still want a stateful firewall doing actual policy enforcement and inspection. A VLAN says *which lane*; a firewall says *what's allowed in the lane*.

## Related concepts
- [[802.1Q tagging]]
- [[Trunk ports and access ports]]
- [[DTP - Dynamic Trunking Protocol]]
- [[Native VLAN]]
- [[VLAN hopping]]
- [[Inter-VLAN routing]]
- [[Router-on-a-stick]]
- [[Layer 3 switch / SVI]]
- [[Private VLANs (PVLAN)]]
- [[Port security]]
- [[Broadcast domain vs collision domain]]
- [[Network segmentation]]
- [[Stateful firewall]]