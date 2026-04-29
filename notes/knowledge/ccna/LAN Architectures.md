# LAN Architectures
## Understanding how networks are physically and logically organized—the blueprint behind every functioning network

---

## Why This Chapter Matters

You can memorize every protocol and command, but without understanding how networks are *structured*, you'll struggle to design, configure, and troubleshoot real systems. This chapter teaches you the recurring patterns that appear in enterprise networks, data centers, and small offices. The CCNA exam explicitly tests your ability to describe and distinguish between two-tier, three-tier, and spine-leaf architectures—not just what they are, but *why* they're designed that way.

---

## Section 1: Common Topologies – Star and Mesh

### Star Topology (Hub-and-Spoke)
**Simple explanation:** Imagine a wheel. All devices connect to one central device, like spokes to a hub.

**Why it matters:** This is the dominant topology in LANs. A switch is the hub, and end hosts are the spokes. It's easy to manage, scales reasonably well, and is cost-effective because you don't need to run cables between every device.

**In practice:**
- All traffic flows through the central switch
- Single point of failure risk (mitigated by redundancy at higher layers)
- Most common physical topology you'll encounter in enterprise networks

---

### Full Mesh Topology
**Simple explanation:** Every device has a direct connection to every other device. Think of a network where you can reach any destination without going through an intermediary.

**Key characteristics:**
- Maximum redundancy—multiple paths exist to reach any destination
- Very high cost (cable, ports, licensing)
- Used in critical WAN links and data center fabrics, not typical access layers

**Formula for connections:**
| Number of Devices | Connections Required |
|---|---|
| 3 | 3 |
| 6 | 15 |
| 10 | 45 |

Formula: **N(N-1)/2** where N = number of devices

---

### Partial Mesh Topology
**Simple explanation:** Some devices are directly connected, but not all. It's the practical middle ground.

**Real-world context:**
- Access switches connect to distribution switches (but not to each other)
- Distribution switches connect to core switches (but typically not to each other in a two-tier design)
- Most campus LANs are actually partial mesh at the distribution layer

---

## Section 2: Campus LAN Architectures

### What is a Campus LAN?
A **campus LAN** is a local network designed to serve users within a defined geographic area—a building, office park, or university campus. It's "local" in scope but can be quite large in device count.

### The Three-Layer Hierarchical Model

Cisco designed a **modular, hierarchical** approach with three layers, each with distinct responsibilities:

#### Access Layer
**Purpose:** Point of connection for end devices

**Devices that connect here:**
- PCs, laptops, tablets
- IP phones
- Wireless access points (as clients)
- Security cameras
- Servers
- Printers

**Services provided at access layer:**
- [[QoS]] marking (applied early in packet's journey per chapter 10)
- [[Port Security]] - limits MAC addresses per port
- [[DHCP Snooping]] - prevents rogue DHCP servers
- [[Dynamic ARP Inspection (DAI)]] - prevents ARP spoofing
- [[Power over Ethernet (PoE)]] - supplies power to IP phones, APs, cameras
- VLAN implementation - segregates traffic

**Analogy:** The access layer is the "front door" of your network. You secure it first, mark important traffic immediately, and handle user connectivity here.

---

#### Distribution Layer
**Purpose:** Aggregates access layer connections and serves as the border between Layer 2 and Layer 3

**Primary responsibilities:**
- Collects traffic from multiple access switches
- Enforces policies and performs QoS
- Hosts [[Spanning Tree Protocol (STP)]] root bridge (typically)
- Implements [[First Hop Redundancy Protocol (FHRP)]]—usually [[HSRP]]
- Runs routing protocols ([[OSPF]], [[BGP]])
- Connects to WAN and internet
- Houses multilayer switches (support both L2 and L3)

**Why two distribution switches?**
- Redundancy is non-negotiable in enterprise networks
- If one goes down, traffic routes through the other
- No single point of failure

**Layer 2–Layer 3 Border:**
```
Distribution switches have BOTH:

Layer 2 features:
  - Trunk links (802.1Q) to access switches
  - STP to prevent loops
  - VLAN interfaces

Layer 3 features:
  - SVIs (Switch Virtual Interfaces) with IP addresses
  - Routed ports (configured: no switchport)
  - HSRP for first-hop redundancy
  - Routing protocols (OSPF)
```

**Analogy:** The distribution layer is like an airport hub. Multiple access routes feed into it, and from there, traffic is routed to WAN/internet destinations or other distribution blocks.

---

#### Core Layer
**Purpose:** Aggregates traffic between distribution layers in *large* campus LANs

**When is it needed?**
- Small sites: None (two-tier is sufficient)
- Medium sites: Possibly none
- Large multi-building campuses: Yes, almost always

**Why separate it out?**
- Provides high-speed backbone between distribution layers
- Reduces the number of hops
- Allows scaling without overloading distribution switches
- Can be physically separated (different buildings)

---

## Section 3: Two-Tier (Collapsed Core) Architecture

### Definition
Also called **collapsed core**: the core layer is *absent*, combined with the distribution layer into a single layer. Only access and distribution layers exist.

### When Used
- Small to medium sites
- Single building or tightly co-located buildings
- Budget constraints
- Fewer than 500–1000 users

### Topology Diagram
```
End Hosts (PCs, phones, cameras, servers)
        |
    [Access Layer Switches]  (security, QoS, PoE)
        |
    [Distribution Switches]  (L2-L3 border, HSRP, routing)
        |
    WAN / Internet / Other services
```

### Key Configuration Points at Distribution Layer

| Layer | Protocol/Feature | Purpose |
|-------|------------------|---------|
| L2 | 802.1Q Trunks | Connect to access switches |
| L2 | STP | Prevent loops |
| L3 | SVIs | Provide gateway for each VLAN |
| L3 | HSRP | Redundant default gateway |
| L3 | OSPF/BGP | Advertise routes to WAN |

---

## Section 4: Three-Tier Architecture

### Definition
Full hierarchical model with **access**, **distribution**, AND **core** layers. Each layer has explicit responsibilities.

### When Used
- Large campuses (multiple buildings)
- High growth potential
- Enterprise environments
- High availability requirements

### Topology Diagram
```
Building A          Building B          Building C
Access Layer        Access Layer        Access Layer
     |                   |                   |
Distribution        Distribution        Distribution
     |                   |                   |
     +-----[Core Layer]-----+
          (aggregation point)
```

### Advantages of Three-Tier
- **Scalability:** Add new buildings by adding access+distribution blocks
- **Performance:** Core layer can use high-speed links (10G, 40G, 100G)
- **Modularity:** Each block is independent
- **Flexibility:** Can reorganize without redesigning entire network

### Disadvantages
- Higher cost (more switches, cables, licensing)
- More complex to configure and troubleshoot
- May be overkill for small deployments

---

## Section 5: Spine-Leaf Architecture (Data Center Networks)

### What Problem Does It Solve?
Traditional three-tier architectures have a critical bottleneck: the core layer. All traffic between distribution blocks must pass through the core. In modern data centers with massive east-west traffic (server-to-server), this becomes a problem.

### Spine-Leaf Design
**Simple explanation:** Instead of a pyramid (access → distribution → core), use a two-level fabric where every leaf connects to every spine. It's a partial mesh.

### Key Characteristics
- **No oversubscription:** Every server has equal access to bandwidth
- **Predictable latency:** All paths are exactly 2 hops (leaf → spine → leaf)
- **Scalability:** Add more spines if you need more capacity; add more leaves for more servers
- **ECMP (Equal-Cost Multipath):** Traffic is load-balanced across multiple spine links

### Spine-Leaf vs. Three-Tier

| Aspect | Three-Tier Campus | Spine-Leaf Data Center |
|--------|-------------------|------------------------|
| **Traffic pattern** | North-south (to WAN) | East-west (server-to-server) |
| **Bottleneck** | Core layer | None (full mesh) |
| **Scalability** | Hierarchical (slow) | Fabric-based (fast) |
| **Latency** | Variable | Predictable (2 hops) |
| **Use case** | Enterprise LAN | Data center, cloud |

### Why "Spine-Leaf"?
- **Leaf switches:** Connect to servers/workloads (like leaves on branches)
- **Spine switches:** Interconnect all leaf switches (like the spine of a tree)

---

## Section 6: Small Office/Home Office (SOHO) Networks

### Characteristics
- **Single device:** One combination router/switch/wireless AP
- **Minimal configuration:** DHCP on by default
- **Simple topology:** Star topology with the router as hub
- **Automatic:** Minimal manual setup needed

### Typical SOHO Device
```
Single device with:
  - Ethernet ports (switch)
  - WiFi (AP)
  - WAN port (router)
  - DHCP server
  - NAT
  - Basic firewall
```

### Contrast with Enterprise
| Aspect | SOHO | Campus LAN |
|--------|------|-----------|
| **Devices** | 1 | Dozens to hundreds |
| **VLANs** | None or minimal | Many |
| **Redundancy** | None | Critical |
| **Management** | None | Extensive |
| **Security** | Basic NAT | Multiple layers |
| **Cost** | <$200 | $100K+ |

---

## Lab Relevance

### Essential Cisco IOS Commands

#### Viewing topology and interfaces
```
show ip interface brief
show interfaces trunk
show spanning-tree
show ip route
```

#### Configuring a multilayer switch at distribution layer
```
! Enable Layer 3 routing
ip routing

! Create VLAN and SVI
vlan 10
  name Users
exit
interface vlan 10
  ip address 192.168.10.1 255.255.255.0
  no shutdown
exit

! Convert physical port to routed port
interface gigabitethernet 0/0/1
  no switchport
  ip address 10.0.0.1 255.255.255.0
  no shutdown
exit

! Configure HSRP for first-hop redundancy
interface vlan 10
  standby 10 ip 192.168.10.254
  standby 10 priority 110
  standby 10 preempt
exit

! Enable routing protocol
router ospf 1
  network 10.0.0.0 0.0.0.255 area 0
  network 192.168.10.0 0.0.0.255 area 0
exit
```

#### Trunk configuration (access to distribution)
```
interface range gi0/0/1-48
  switchport mode trunk
  switchport trunk allowed vlan all
  no shutdown
exit
```

#### Access layer security
```
! Port Security
interface gi0/0/5
  switchport port-security
  switchport port-security maximum 2
  switchport port-security violation restrict
exit

! DHCP Snooping
ip dhcp snooping
ip dhcp snooping vlan 10,20,30
interface gi0/0/1
  ip dhcp snooping trust
exit

! Dynamic ARP Inspection
ip arp inspection vlan 10,20,30
interface gi0/0/1
  ip arp inspection trust
exit

! PoE configuration
interface gi0/0/3
  power inline auto
exit
```

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 15 | [[CCNA]]*