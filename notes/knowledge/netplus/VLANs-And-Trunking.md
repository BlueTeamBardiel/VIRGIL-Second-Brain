# VLANs And Trunking

## What it is

In **World of Warcraft**, you log into a realm — say, Area-52 — and you're sharing a physical server cluster with thousands of other players. But you can't see the Horde players in Orgrimmar from your Alliance character in Stormwind. You can't trade with them. You can't hear their /say chat. The hardware is the same. The faction is the partition. Blizzard drew a line through the world and said: *same realm, different broadcast domains*.

That's exactly what a **VLAN** does. Same switch, same physical infrastructure, but logically partitioned so traffic in one VLAN never sees traffic in another — unless a router (or a layer-3 switch) explicitly bridges them.

**Technical definition:** A **Virtual Local Area Network (VLAN)** is a layer-2 broadcast domain created logically on a switch, identified by a 12-bit VLAN ID (1–4094). Hosts in different VLANs cannot communicate without a layer-3 device performing inter-VLAN routing. **Trunking** is the mechanism for carrying multiple VLANs across a single switch-to-switch link, using **802.1Q** to tag each frame with its VLAN ID.

## Why it matters

VLANs are how every enterprise network on Earth separates voice from data, guests from employees, printers from finance, and IoT from anything important. Without VLANs, you'd need a separate physical switch for every broadcast domain. With them, one 48-port switch can host a dozen logical networks.

Exam-wise, this is **Objective 2.2** territory — switching technologies, the bread and butter of Net+. CompTIA will hit you on 802.1Q tagging, native VLAN behavior, voice VLAN configuration, SVI vs router-on-a-stick, and the subtle difference between an access port and a trunk port. Get sloppy here and you'll lose 4–6 questions.

Career-wise, the day you actually configure a trunk between two switches and watch tagged traffic flow correctly across it, you stop being a helpdesk tech and start being a network tech. This is the doorway.

## Key facts

### VLAN basics

- **VLAN ID range:** 1–4094 (12 bits, minus reserved 0 and 4095)
- **Default VLAN:** VLAN 1 on Cisco — everything lives here until you say otherwise. Best practice: don't use VLAN 1 for production. Attackers assume VLAN 1 is the native VLAN and target it.
- **VLAN database:** the switch's stored list of configured VLANs (`vlan.dat` on Cisco). Survives reboot. If you wipe `startup-config` but not `vlan.dat`, your VLANs come back from the dead.
- VLANs are a **layer 2** construct. They segment broadcast domains. To route between them, you need layer 3.

### Access ports vs trunk ports

| Port type | Carries | Tagging | Use case |
|---|---|---|---|
| **Access** | One VLAN | Untagged frames to the host | Endpoints — PCs, printers, APs |
| **Trunk** | Multiple VLANs | 802.1Q tagged (except native) | Switch-to-switch, switch-to-router, switch-to-hypervisor |

An access port strips the VLAN tag before delivering the frame to the host — the host has no idea VLANs exist. A trunk port preserves the tag so the next switch knows which VLAN the frame belongs to.

### 802.1Q tagging

**802.1Q** (dot1q) inserts a 4-byte tag into the Ethernet frame between the source MAC and the EtherType field. The tag contains:

- **TPID** (Tag Protocol Identifier): 0x8100 — marks the frame as tagged
- **PCP** (Priority Code Point): 3 bits for QoS (used by **CoS** — class of service)
- **DEI** (Drop Eligible Indicator): 1 bit
- **VID** (VLAN ID): 12 bits — the actual VLAN number

This tag adds 4 bytes to the frame. A standard Ethernet frame is 1518 bytes max; with the dot1q tag, it can hit 1522. If your MTU is set wrong end-to-end, tagged frames get dropped as "giants." More on MTU below.

### Native VLAN

The **native VLAN** is the one VLAN on a trunk whose traffic is sent **untagged**. By default it's VLAN 1. Both ends of the trunk must agree on the native VLAN — if switch A says native is VLAN 1 and switch B says native is VLAN 10, you get a **native VLAN mismatch** and CDP will scream at you (and traffic will leak between VLANs, which is bad).

Best practice: set the native VLAN to an unused, dead-end VLAN (e.g., 999) on both sides. This kills **VLAN hopping** attacks where an attacker double-tags a frame to escape their VLAN.

> **CompTIA exam trap:** The native VLAN is **untagged on the trunk**, but it's still a VLAN. If you don't explicitly configure a native VLAN, it defaults to VLAN 1. Mismatched native VLANs between two trunked switches cause traffic leakage and STP issues — CompTIA loves this scenario.

### Voice VLAN

A **voice VLAN** lets a single switch port carry two VLANs simultaneously without being a true trunk: one untagged (data, for the PC daisy-chained behind the phone) and one tagged (voice, for the IP phone itself). The phone learns its voice VLAN ID via **CDP** or **LLDP-MED** and tags its own traffic.

```
interface gi0/5
 switchport mode access
 switchport access vlan 10        ! data
 switchport voice vlan 20         ! voice
 mls qos trust cos
```

The port behaves like an access port for the PC and like a mini-trunk for the phone. This is everywhere in offices with VoIP — and it's a top-five exam topic.

### Switch Virtual Interface (SVI)

An **SVI** is a virtual layer-3 interface on a multilayer switch, one per VLAN, used as the **default gateway** for hosts in that VLAN.

```
interface vlan 10
 ip address 10.0.10.1 255.255.255.0
 no shutdown
```

This is how a layer-3 switch does **inter-VLAN routing** without needing an external router. The older method, **router-on-a-stick**, uses one physical router interface with subinterfaces for each VLAN over a trunk link — fine for small shops, painful at scale.

*An SVI without `no shutdown` is a gateway that doesn't exist. Half the "VLAN can't reach the internet" tickets I've seen are an SVI in admin-down state.*

### MTU and jumbo frames

**MTU** (Maximum Transmission Unit) is the largest frame size a link will carry, default **1500 bytes** for Ethernet payload. **Jumbo frames** push this to **9000 bytes** (sometimes 9216), used in SAN, iSCSI, vMotion, and high-throughput backup networks to reduce CPU overhead per byte.

MTU rules:
- Must be consistent end-to-end. One switch in the path with MTU 1500 will fragment or drop jumbos.
- 802.1Q tagging adds 4 bytes — the switch needs to accept "baby giant" frames (1504 bytes) on trunk ports. Most modern switches handle this automatically.
- If you enable jumbo frames on a VLAN, every device in that broadcast domain — every NIC, every switch port — must agree.

> **CompTIA exam trap:** Jumbo frames are **opt-in, end-to-end**. Enabling them on two endpoints but not the switch in between gives you intermittent failures on large transfers and clean pings — because ICMP is small. Test with `ping -l 8972 -f` (Windows) or `ping -M do -s 8972` (Linux) to verify the full MTU works without fragmentation.

### Spanning Tree Protocol (STP)

**STP (802.1D)** prevents layer-2 loops by electing a **root bridge** and blocking redundant paths. Without it, a single misplugged cable between two switches creates a broadcast storm that takes down the network in seconds.

Key concepts:
- **Root bridge:** the switch with the lowest bridge ID (priority + MAC). Elect deliberately — don't let the oldest switch in the closet win.
- **Port states:** Blocking → Listening → Learning → Forwarding (classic STP, 30–50 sec convergence)
- **RSTP (802.1w):** Rapid STP — sub-second convergence. Use this.
- **PortFast:** on access ports, skip listening/learning and go straight to forwarding. Pair with **BPDU Guard** so a rogue switch plugged into the port gets shut down instead of becoming root.
- **MSTP (802.1s):** Multiple STP — one STP instance per group of VLANs, scales better than per-VLAN STP.

*If you've ever seen a network die at 9am because someone plugged a desk switch into two wall ports to "get more speed" — that's STP saving you, or failing to.*

### Link aggregation (LAG / port channel / EtherChannel)

**Link aggregation** bundles multiple physical links into one logical link for bandwidth and redundancy. Standard: **802.3ad** (LACP). Cisco's proprietary version: **PAgP**. Static (no negotiation) also exists but is fragile.

- Two 1 Gbps links bundled = 2 Gbps aggregate (load-balanced per-flow, not per-packet — a single TCP stream still maxes at 1 Gbps)
- All links in the bundle must have **matching speed, duplex, VLAN config, and trunk/access mode**
- If one link dies, the rest carry the load — no STP reconvergence needed

### Speed and duplex

- **Speed:** 10/100/1000/10000 Mbps. Auto-negotiation is the default. Hard-coding both ends is fine; hard-coding one end while the other auto-negotiates causes a **duplex mismatch**.
- **Duplex:** Half (one direction at a time, hub-era) vs Full (simultaneous send/receive). Modern Ethernet is always full duplex.
- **Duplex mismatch** symptoms: connection works for small pings, falls apart under load, late collisions, CRC errors, slow file transfers. Classic.

> **CompTIA exam trap:** Duplex mismatch = the link comes up, the link light is green, ping works fine — but throughput is garbage. The fix: set both ends to auto/auto OR both ends to the same hard-coded value. Never mix.

### Interface configuration cheat sheet

```
! Access port for a workstation
interface gi0/10
 switchport mode access
 switchport access vlan 10
 spanning-tree portfast
 spanning-tree bpduguard enable

! Trunk port to another switch
interface gi0/24
 switchport mode trunk
 switchport trunk encapsulation dot1q
 switchport trunk native vlan 999
 switchport trunk allowed vlan 10,20,30,99
```

`switchport trunk allowed vlan` is the allowlist — leave it default and every VLAN traverses the trunk. CompTIA-correct hygiene: allow only what's needed.

## Helpdesk reality

- User says: *"I plugged in but I can't get on the network."* First check: link light. Second check: is the port in the right VLAN? `show interface gi0/12 switchport` will tell you.
- User says: *"The phone works but my PC behind it doesn't."* The voice VLAN is fine; the data VLAN config on the port is wrong, or the PC NIC is doing something unexpected with tagged frames.
- User in finance says: *"I can ping my coworker but not the printer."* Different VLANs, no inter-VLAN routing for printer subnet, or an ACL on the SVI. Escalate to network team with the source IP, destination IP, and which VLAN each lives in.
- Never promise *"VLANs are isolated, you're safe."* VLAN hopping is real, native VLAN misconfigurations leak, and a misconfigured trunk allows everything. VLANs are segmentation, not security on their own.
- If you've confirmed the cable, the link light, the port VLAN, and the IP/gateway — and it still doesn't work — it's a network team ticket. Hand off with evidence, not vibes.

## Related concepts

[[OSI Model]] · [[Subnetting]] · [[Spanning Tree Protocol]] · [[802.1Q]] · [[Inter-VLAN Routing]] · [[Router On A Stick]] · [[Layer 3 Switch]] · [[Link Aggregation]] · [[VoIP]] · [[VLAN Hopping]] · [[CDP And LLDP]] · [[MTU And Jumbo Frames]] · [[Duplex Mismatch]]

*Source: VIRGIL knowledge base — 2026-05-11*