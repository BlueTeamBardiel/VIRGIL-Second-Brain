# Cables, Connectors, and Ports
*Why it matters: Physical layer understanding is foundational—you can't route packets if the cable is wrong or the connector doesn't fit.*

---

## Overview

This chapter covers the **physical infrastructure** that enables network communication. It bridges the gap between the theoretical [[OSI model]] and the actual hardware you'll touch in the lab and exam. Understanding copper vs. fiber, connector types, and port standards directly impacts your ability to troubleshoot real network problems.

---

## Key Concepts

### What Are Cables and Connectors?

**Simple explanation:** A network cable is like a water pipe—it carries data (water) from one device to another. The connector is the fitting that plugs into ports. Get either wrong, and nothing flows.

**Detailed view:** Network cables transmit electrical (copper) or light (fiber) signals that represent bits. The connector ensures proper contact and signal integrity. The port is the interface on the device that accepts the connector.

---

## Network Standards

Cisco and networking rely on **IEEE standards** to ensure interoperability. These aren't suggestions—they define electrical properties, physical dimensions, and performance specifications.

### Key Standard Organizations

| Organization | Role |
|---|---|
| [[IEEE]] (Institute of Electrical and Electronics Engineers) | Sets standards like 802.3 for Ethernet |
| [[TIA]]/[[EIA]] | Defines copper cabling standards (TIA/EIA-568) |
| Cisco | Implements standards in equipment |

---

## Copper UTP Connections

### The Anatomy of UTP Cable

**Simple explanation:** UTP (Unshielded Twisted Pair) looks like a telephone cord. Inside are four pairs of twisted wires. Twisted = better at rejecting interference.

**Technical detail:** 
- **UTP** = no metal shielding (vulnerable to electromagnetic interference, but cheaper and more flexible)
- **STP** = shielded (better for harsh environments, rarely used in modern LANs)
- Cable is twisted to cancel out electromagnetic noise from external sources and crosstalk between pairs

### IEEE 802.3 Standards (Copper)

| Standard | Speed | Max Distance | Cable Type | Common Name |
|---|---|---|---|---|
| [[802.3]] | 10 Mbps | 100m | UTP Cat 3/4 | 10BASE-T |
| [[802.3u]] | 100 Mbps | 100m | UTP Cat 5 | Fast Ethernet |
| [[802.3ab]] | 1 Gbps | 100m | UTP Cat 5e/6 | Gigabit Ethernet |
| [[802.3an]] | 10 Gbps | 55m (Cat 6A) | UTP Cat 6A | 10GBASE-T |

**Critical for exam:** Know that **100m is the limit for copper**. Beyond that, you need [[fiber-optic]] cables.

### Cable Categories

| Category | Speed | Frequency | When to Use |
|---|---|---|---|
| Cat 3 | 10 Mbps | 16 MHz | Obsolete (legacy phone systems) |
| Cat 4 | 16 Mbps | 20 MHz | Obsolete |
| Cat 5 | 100 Mbps | 100 MHz | Obsolete (early Fast Ethernet) |
| Cat 5e | 1 Gbps | 100 MHz | **Standard for Gigabit Ethernet** |
| Cat 6 | 1 Gbps | 250 MHz | Better future-proofing |
| Cat 6A | 10 Gbps | 500 MHz | High-speed/long-distance |
| Cat 7 | 10 Gbps | 600 MHz | Shielded; rarely used in North America |

---

### Straight-Through vs. Crossover Cables

This is a **frequent exam trap**. Understand when each is used.

#### Straight-Through Cable

**Pin assignment:** Both ends follow the **same color order**. Standard is TIA/EIA-568B:
1. Orange-white
2. Orange
3. Green-white
4. Blue
5. Blue-white
6. Green
7. Brown-white
8. Brown

**When to use:**
- Switch to router
- Switch to PC/server
- Router to PC
- Any **different device types** (DTE to DCE in old terminology)

#### Crossover Cable

**Pin assignment:** One end is 568A, the other is 568B.

568A order: White-green, green, white-orange, blue, white-blue, orange, white-brown, brown

**When to use:**
- Switch to switch
- Router to router
- PC to PC (if you need to connect two computers directly)
- **Device of the same type**

**Exam trick:** Modern devices use **MDI-X (auto-sensing)**, which automatically detects cable type and adjusts. Most modern switches detect crossover/straight-through automatically. But you'll still see legacy questions.

---

## Fiber-Optic Connections

### Why Fiber?

**Simple explanation:** Instead of electrical pulses (which can be disrupted), fiber sends pulses of light down a glass strand. Light isn't affected by electromagnetic interference.

**Advantages over copper:**
- Immune to [[EMI]]/[[RFI]] (electromagnetic/radio frequency interference)
- Much longer distances (kilometers vs. 100m)
- Higher bandwidth potential
- No electrical shock hazard

**Disadvantages:**
- More expensive
- Requires specialized connectors and training
- More fragile (can break if bent too sharply)
- Requires optical transceivers ([[QSFP]], [[QSFP]])

### The Anatomy of a Fiber-Optic Cable

| Component | Purpose |
|---|---|
| **Core** | Glass or plastic center where light travels (8-50 microns) |
| **Cladding** | Lower refractive index layer around core; reflects light back into core |
| **Coating/Buffer** | Plastic layer protecting against physical damage |
| **Strength members** | Aramid fibers (Kevlar) for tensile strength |
| **Outer jacket** | Colored PVC or LSZH (low-smoke, zero-halogen) |

### Fiber Modes

| Mode | Description | Distance | Cost | Use Case |
|---|---|---|---|---|
| **Single-mode (SMF)** | One path for light; tiny core (8-10 μm) | 100+ km | Expensive | Long-distance (ISP backbone) |
| **Multimode (MMF)** | Multiple light paths; larger core (50-62.5 μm) | Up to 2 km | Cheaper | Campus/datacenter |

---

### Fiber Connector Types

| Connector | Appearance | Use | Notes |
|---|---|---|---|
| **SC** | Square, push-pull | Older networks | Simple, reliable |
| **LC** | Small, RJ45-like | Modern equipment | Industry standard for 10GbE+ |
| **ST** | Twist-lock (bayonet) | Legacy | Rarely seen now |
| **MPO** | Multiple fibers in one connector | High-speed data centers | 40GbE/100GbE |

**Exam focus:** You need to recognize connector types and know that **LC is standard for modern high-speed connections**.

---

### UTP vs. Fiber Comparison

| Feature | UTP | Fiber |
|---|---|---|
| Cost | Low | High |
| Maximum distance | 100m | 2km (MMF) / 100+ km (SMF) |
| EMI immunity | No (susceptible) | Yes (immune) |
| Ease of installation | Easy | Difficult |
| Connector types | RJ45 (simple) | Multiple types (specialized) |
| Bandwidth | Up to 10 Gbps (short distances) | 400+ Gbps potential |
| Troubleshooting | Easy | Requires specialized tools |
| Common use | LANs (access layer) | Inter-building, WAN, ISP |

---

## Ports and Interface Types

### Ethernet Ports

**Physical port** on network device where you plug in the cable. On Cisco switches and routers:
- **Gigabit Ethernet ports** (1 Gbps) – labeled **Gi0/0**, **Gi0/1**, etc.
- **Fast Ethernet ports** (100 Mbps) – labeled **Fa0/0**, **Fa0/1**, etc. (older equipment)
- **10 Gigabit ports** (10 Gbps) – labeled **Te0/0**, **Te0/1**, etc.

### Speed and Duplex Configuration

**Speed:** How fast data is transmitted (10, 100, 1000 Mbps, etc.)

**Duplex:** Whether the port can send and receive simultaneously.
- **Full-duplex** (modern standard) = simultaneous send/receive (no collisions)
- **Half-duplex** = take turns sending/receiving (old hubs; collisions possible)

**Modern best practice:** Let devices **autonegotiate** speed and duplex. Manual configuration should only be done to resolve specific mismatches (troubleshooting).

---

## Lab Relevance

### Essential Cisco IOS Commands for Interface Configuration

```ios
! Enter interface configuration mode
Router(config)# interface GigabitEthernet 0/0
Router(config-if)# interface Gi0/0
Router(config-if)# interface FastEthernet 0/0
Router(config-if)# interface Fa0/0

! Verify interface status and configuration
Router# show interfaces
Router# show interfaces GigabitEthernet 0/0
Router# show interfaces brief
Router# show ip interfaces brief

! Manually configure speed (if troubleshooting mismatches)
Router(config-if)# speed 1000
Router(config-if)# speed 100
Router(config-if)# speed 10

! Manually configure duplex
Router(config-if)# duplex full
Router(config-if)# duplex half

! Re-enable autonegotiation (best practice)
Router(config-if)# speed auto
Router(config-if)# duplex auto

! Configure interface description (always do this in labs)
Router(config-if)# description Link to Core Switch

! Enable or disable interface
Router(config-if)# no shutdown
Router(config-if)# shutdown

! Verify interface errors and statistics
Router# show interfaces GigabitEthernet 0/0
Router# show interfaces counters errors

! Check for duplex mismatches specifically
Router# show interfaces | include duplex
Router# show interfaces GigabitEthernet 0/0 | include duplex
```

### Common Lab Scenarios

**Scenario 1: Interface won't come up**
```ios
Router# show interfaces Gi0/0
GigabitEthernet0/0 is down, line protocol is down

! Check if interface is administratively shut down
Router# show run | include shutdown
! If "shutdown" appears, the interface is disabled:
Router(config)# interface Gi0/0
Router(config-if)# no shutdown
```

**Scenario 2: Duplex mismatch (packet corruption)**
```ios
! Verify duplex on both sides
Router# show interfaces Gi0/0 | include duplex
Duplex: Full, Speed: 1000Mbps

! If one side is half-duplex and the other full-duplex, you'll see
! CRC errors and collisions. Fix it:
Router(config-if)# duplex full
Router(config-if)# speed 1000
```

**Scenario 3: Verify physical connectivity**
```ios
Router# show interfaces Gi0/0
GigabitEthernet0/0 is up, line protocol is up
! "up" = cable is connected and link is established

Router# show cdp neighbors
! See directly connected devices (requires CDP enabled)

Router# show lldp neighbors
! Modern alternative to CDP
```

---

## Exam Tips

### What CCNA Tests on Cables and Connectors

**Domain coverage:** Primarily **Network Fundamentals** (Part 1 of exam)

### Common Exam Question Types

#### 1. Cable Type Identification
**Question type:** "You need to connect two switches in different buildings 500 meters apart. Which cable type would you use?"

**Trap answer:** Straight-through UTP cable (doesn't address distance limit)

**

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 3 | [[CCNA]]*
