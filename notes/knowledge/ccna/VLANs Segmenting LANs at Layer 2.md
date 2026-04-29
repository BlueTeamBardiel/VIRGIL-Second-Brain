# VLANs: Segmenting LANs at Layer 2
**Why this matters:** VLANs enable logical network segmentation at Layer 2 (data link), allowing you to divide a single physical switch into multiple broadcast domains for security and performance—essential for modern enterprise networks.

---

## 12.1 Why We Need VLANs

### Understanding the Problem: Layer 2 Broadcast Domain Challenge

**Simple Analogy First:** Imagine a single large office where everyone can hear everyone else talk (broadcast domain). Even if you organize people into departments (subnets at Layer 3), the physics of the building means shouts still reach all departments. VLANs are like installing soundproof walls—same physical building, but separate acoustic spaces.

**The Technical Reality:**
- [[Layer 3]] segmentation with [[subnets]] divides networks logically, but switches operate at [[Layer 2]] and are **broadcast domain unaware**
- When a host sends a broadcast frame (destination MAC: `ffff.ffff.ffff`), the switch floods it out all ports except the ingress port
- This affects all hosts connected to the switch, regardless of which subnet they're in
- Security and performance suffer: sensitive traffic can be sniffed, and broadcast storms create congestion

### Layer 3 Segmentation Alone Is Insufficient

With subnetting (e.g., Engineering on 172.16.1.0/26, HR on 172.16.1.64/26, Sales on 172.16.1.128/26):
- Unicast traffic between departments routes through a [[router]] (controllable)
- **But broadcast/unknown unicast frames still flood across the entire switch fabric**
- All departments remain in one broadcast domain
- No Layer 2 containment of traffic

### Layer 2 Segmentation Solution: VLANs

**Definition:** Virtual LANs (VLANs) divide a single physical [[switch]] into multiple virtual switches, creating multiple isolated [[broadcast domains]].

**Key Benefit:**
- Hosts in VLAN 10 will NOT receive broadcast frames from VLAN 20
- Each VLAN is a separate broadcast domain
- Inter-VLAN routing still requires a router or [[multilayer switch]]
- Enables security policies (access control lists) at Layer 3 boundaries

---

## 12.2 VLAN Fundamentals

### What VLANs Actually Do

A single switch can be logically divided by assigning ports to specific VLANs:

| Port | VLAN Assignment | Broadcast Domain |
|------|-----------------|------------------|
| G0/1, G0/2, G0/3 | VLAN 10 (Engineering) | BD10 |
| G1/1, G1/2, G1/3 | VLAN 20 (HR) | BD20 |
| G2/1, G2/2, G2/3 | VLAN 30 (Sales) | BD30 |

**Result:** SW1 acts like three separate switches—one per VLAN—even though it's one physical device.

### VLAN Naming Conventions

| VLAN ID | Range Type | Purpose |
|---------|-----------|---------|
| 1 | Default VLAN | Native VLAN; created by default on all switches |
| 2–1001 | Normal Range | Standard enterprise VLANs (stored in flash memory) |
| 1002–1005 | Reserved | For FDDI/Token Ring (legacy; generally avoid) |
| 1006–4094 | Extended Range | Used in very large networks (stored in running-config only) |

**Exam Focus:** Normal range (2–1001) is most commonly tested.

### Access Ports vs. Trunk Ports

**Access Ports:** Connect end devices (hosts)
- Assigned to exactly ONE VLAN
- Frames sent out access ports have NO VLAN tag (no 802.1Q header)
- When frame arrives on access port, switch tags it internally with the port's VLAN ID

**Trunk Ports:** Connect switches together (or switch to router/[[multilayer switch]])
- Carry traffic for MULTIPLE VLANs simultaneously
- Frames leaving trunk ports ARE tagged with a VLAN ID (using [[802.1Q]] standard)
- Allows the receiving device to know which VLAN the frame belongs to

---

## 12.3 VLAN Tagging with 802.1Q

### How 802.1Q Works

[[802.1Q]] is the IEEE standard for VLAN tagging (Cisco proprietary [[ISL]] also exists but is legacy).

**Frame Structure Addition:**
When a frame travels on a trunk port, a 4-byte tag is inserted between the source MAC and EtherType fields:

```
Original Frame: [Dest MAC][Source MAC][EtherType][Payload][FCS]
Tagged Frame:   [Dest MAC][Source MAC][TPID(2)][Priority(3)|CFI(1)|VLAN ID(12)][EtherType][Payload][FCS]
```

| Field | Bits | Purpose |
|-------|------|---------|
| TPID | 16 | Tag Protocol ID = 0x8100 (identifies 802.1Q) |
| Priority (CoS) | 3 | Class of Service; QoS priority (0–7) |
| CFI | 1 | Canonical Format Indicator (almost always 0) |
| VLAN ID | 12 | Actual VLAN number (0–4095 possible; 1–4094 usable) |

**Key Point:** Access ports strip tags before sending to hosts; hosts never see 802.1Q headers.

### Native VLAN on Trunk Ports

**Definition:** The one VLAN on a trunk port that is NOT tagged.

**Default Behavior:**
- Frames belonging to the native VLAN travel the trunk untagged
- Traditionally, native VLAN = VLAN 1 (but this can be changed)
- Receiving device assumes untagged frames belong to the native VLAN

**Why This Exists:** Legacy device support and historical standards.

**Best Practice (Security):** Change native VLAN to an unused VLAN number (not VLAN 1, not a data VLAN) to prevent accidental VLAN hopping attacks.

---

## 12.4 Configuring VLANs and Ports

### Creating VLANs

```
Switch# configure terminal
Switch(config)# vlan 10
Switch(config-vlan)# name Engineering
Switch(config-vlan)# exit

Switch(config)# vlan 20
Switch(config-vlan)# name HR
Switch(config-vlan)# exit

Switch(config)# vlan 30
Switch(config-vlan)# name Sales
Switch(config-vlan)# exit
```

**Verification:**
```
Switch# show vlan brief
Switch# show vlan id 10
Switch# show vlan name Engineering
```

### Assigning Access Ports to VLANs

```
Switch(config)# interface range G0/1 - 3
Switch(config-if-range)# switchport mode access
Switch(config-if-range)# switchport access vlan 10
Switch(config-if-range)# exit
```

**One at a time:**
```
Switch(config)# interface G0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 10
```

**Verification:**
```
Switch# show interfaces G0/1 switchport
Switch# show vlan brief
```

### Configuring Trunk Ports

```
Switch(config)# interface G1/0
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk encapsulation dot1q
Switch(config-if)# exit
```

**Note:** On modern Cisco switches, `switchport trunk encapsulation dot1q` may be automatic; older switches may require explicit specification (alternatives: `isl`, `negotiate`).

**Allow Specific VLANs on Trunk (Optional—Advanced):**
```
Switch(config-if)# switchport trunk allowed vlan 10,20,30
```

**Change Native VLAN (Security Best Practice):**
```
Switch(config-if)# switchport trunk native vlan 999
```

**Verification:**
```
Switch# show interfaces G1/0 switchport
Switch# show interfaces trunk
```

**Example Output Interpretation:**
```
Port        Mode        Encapsulation    Status    Native vlan
G1/0        on          802.1q          trunking  999

Port        Vlans allowed on trunk
G1/0        1-4094
```

---

## 12.5 Inter-VLAN Routing

### The Problem: VLANs Are Isolated by Default

Hosts in VLAN 10 CANNOT communicate with hosts in VLAN 20 without a Layer 3 device:
- Switch ports don't route; they only forward frames
- VLANs create separate broadcast domains AND separate networks
- Need [[router]] or [[multilayer switch]] to route between VLANs

### Solution 1: Router-on-a-Stick (ROAS)

**Architecture:** Single router interface carries traffic for all VLANs via sub-interfaces.

**Router Configuration:**
```
Router(config)# interface G0/0.10
Router(config-subif)# encapsulation dot1q 10
Router(config-subif)# ip address 172.16.10.1 255.255.255.0
Router(config-subif)# exit

Router(config)# interface G0/0.20
Router(config-subif)# encapsulation dot1q 20
Router(config-subif)# ip address 172.16.20.1 255.255.255.0
Router(config-subif)# exit

Router(config)# interface G0/0.30
Router(config-subif)# encapsulation dot1q 30
Router(config-subif)# ip address 172.16.30.1 255.255.255.0
Router(config-subif)# exit

Router(config)# interface G0/0
Router(config-if)# no shutdown
Router(config-if)# exit
```

**Switch Side (same as before):**
```
Switch(config)# interface G1/0
Switch(config-if)# switchport mode trunk
Switch(config-if)# switchport trunk encapsulation dot1q
```

**How It Works:**
1. VLAN 10 frame arrives on trunk → router receives on G0/0.10 sub-interface
2. Router examines IP header, looks up routing table
3. Router sends frame out G0/0.20 sub-interface (VLAN 20) or another interface
4. Switch receives frame on trunk, strips tag, forwards to destination

**Limitations:**
- Single physical link becomes bottleneck
- All inter-VLAN traffic must traverse one connection
- CPU-intensive for router (per-packet routing)

### Solution 2: Multilayer Switch (Preferred)

[[Multilayer switch]] (Layer 3 switch) has both switching and routing capabilities built-in.

**Configuration (Catalyst 3560 or similar):**
```
Switch(config)# ip routing
Switch(config)# vlan 10
Switch(config-vlan)# name Engineering
Switch(config-vlan)# exit

Switch(config)# vlan 20
Switch(config-vlan)# name HR
Switch(config-vlan)# exit

Switch(config)# interface vlan 10
Switch(config-if)# ip address 172.16.10.1 255.255.255.0
Switch(config-if)# exit

Switch(config)# interface vlan 20
Switch(config-if)# ip address 172.16.20.1 255.255.255.0
Switch(config-if)# exit

Switch(config)# interface G0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 10
Switch(config-if)# exit
```

**Key Difference from Router-on-a-Stick:**
- Virtual interfaces (`vlan 10`, `vlan 20`) act as default gateways for each VLAN
- No sub-interfaces needed
- Routing happens in hardware (ASIC), not CPU
- Much faster and more scalable

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 12 | [[CCNA]]*