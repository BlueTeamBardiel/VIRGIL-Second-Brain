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


<!-- merged from: WAN Architectures.md -->

# WAN Architectures

**Tagline:** Connect geographically dispersed LANs into unified enterprise networks using dedicated and shared WAN technologies.

## 16.1 WAN Concepts



### Simple Explanation: What Is a WAN?

Think of a LAN as a family dinner table (everyone in one room). A WAN is like a family reunion spread across multiple cities—you need special communication methods to keep everyone connected. A WAN extends networks across large geographic areas, connecting multiple LANs (offices, retail stores, data centers) so they function as one unified network.

### Technical Definition

A **WAN** (Wide Area Network) extends over large geographic distances (cities, countries, continents) and connects geographically dispersed LANs. Unlike LANs that use shared Ethernet media within a building, WANs rely on service provider infrastructure and dedicated connections. The enterprise (customer) owns the LANs but contracts with a service provider for WAN connectivity.

**Key Purpose:** Enable users in one LAN to access applications, files, and services hosted in other LANs separated by distance.

---

## 16.1.1 Leased Lines



### Simple Explanation

A leased line is like renting a private highway between two cities exclusively for your company's trucks. No other company's vehicles use it; your traffic has the entire road. The tradeoff: highways are expensive, and if you need to connect many cities, you need many leased lines.

### Technical Details

A **leased line** is a dedicated physical connection between two sites that:
- Provides **fixed, reserved bandwidth** (not shared with other customers)
- Offers **true privacy** (dedicated circuit, no other traffic)
- Maintains **consistent performance** (no congestion from neighbors)
- Typically uses **serial connections** (not Ethernet, though modern leased lines may be Ethernet-based)

### Leased Line Standards by Region

| North America | Speed | Europe/Others | Speed |
|---|---|---|---|
| **T1** | 1.544 Mbps | **E1** | 2.048 Mbps |
| **T2** | 6.312 Mbps | **E2** | 8.448 Mbps |
| **T3** | 44.736 Mbps | **E3** | 34.368 Mbps |
| **T4** | 274.176 Mbps | **E4** | 139.264 Mbps |
| **T5** | 400.352 Mbps | **E5** | 565.148 Mbps |

### Leased Line Topology Trade-offs

**Hub-and-Spoke Topology (Figure 16.2 pattern):**
- Central data center connects to 4 branch offices
- Requires **4 leased lines**
- Cost: ~$800–$4,000/month per line = manageable budget
- Common in enterprise deployments

**Full Mesh Topology:**
- Every site connects to every other site
- For 5 sites: requires **10 leased lines** (formula: n(n-1)/2)
- Cost: 2.5x more expensive than hub-and-spoke
- **Usually cost-prohibitive** despite better redundancy

### Advantages & Disadvantages

| Advantage | Disadvantage |
|---|---|
| Dedicated, private connection | High recurring cost ($800–$4,000+/month) |
| Consistent, predictable bandwidth | Lower bandwidth options (legacy T1 = 1.5 Mbps) |
| No contention with other traffic | Mesh topologies become prohibitively expensive |
| Excellent for mission-critical traffic | Less common in modern networks; being replaced by Ethernet |

**Current Status:** Considered legacy technology in many regions; largely replaced by [[Ethernet]]-based dedicated connections. Still found globally, particularly in older deployments.

---

## 16.1.2 Multiprotocol Label Switching (MPLS)



### Simple Explanation

Instead of routers reading full destination addresses on every packet (like reading a complete address on a letter), [[MPLS]] uses a short "label" or shipping sticker. A router at the entry point (PE router) reads the destination once, adds a label, and other routers just check the label and forward—much faster. Multiple customers can share the same highway (MPLS network) because their packets have different labels.

### Technical Details

**[[MPLS]]** (Multiprotocol Label Switching) is a Layer 2.5 forwarding mechanism where routers use **labels** (not destination IP addresses) to route packets.

**How it differs from traditional routing:**

| Traditional IP Routing | MPLS |
|---|---|
| Every router reads destination IP | PE router reads destination IP once, adds label |
| Routing table lookup at each hop | Fixed-length label lookup at each hop |
| Variable packet processing | Consistent, deterministic forwarding |
| Suited for IP networks | Can encapsulate any protocol (hence "Multiprotocol") |

### MPLS Packet Structure

```
[Ethernet Header] [MPLS Label] [IP Packet] [Ethernet Trailer]
     Layer 2         Layer 2.5      Layer 3        Layer 2
```

The **MPLS label** sits between Layer 2 and Layer 3 headers, which is why MPLS is called a **Layer 2.5 protocol**. The label is a fixed-length field that routers can examine and act upon with minimal processing overhead.

### MPLS Network Components & Roles

MPLS networks involve three types of routers, each with different responsibilities:

#### **CE Router (Customer Edge)**
- Located at the customer's premises
- Connects the customer's LAN to the service provider's MPLS network
- **Does NOT participate in MPLS**—sends/receives regular IP packets
- Typically under customer control

#### **PE Router (Provider Edge)**
- Located at the edge of the service provider's MPLS network
- Connects to customer networks (CE routers)
- **Assigns labels** to customer packets entering the MPLS cloud
- **Removes labels** from packets exiting the MPLS cloud
- Maintains label mappings for each customer

#### **P Router (Provider)**
- Internal router within the service provider's MPLS network
- Does NOT connect directly to customer networks
- Only forwards labeled packets based on the MPLS label
- Minimizes processing—never inspects IP headers

### MPLS Diagram: Multi-customer Scenario

```
Customer A Site 1          Service Provider MPLS          Customer A Site 2
      CE ─────────────────── PE ─── P ─── PE ──────────────── CE
      
Customer B Site 1                                          Customer B Site 2
      CE ─────────────────── PE ─── P ─── PE ──────────────── CE
```

### Key Advantages of MPLS

1. **Shared Infrastructure:** Multiple customers use the same service provider backbone
2. **Traffic Segregation:** Labels isolate each customer's traffic into virtual private networks (VPNs)
3. **Efficient Forwarding:** P routers don't need to examine full IP headers; label-switching is faster
4. **Quality of Service (QoS):** Labels can be assigned based on traffic class (voice, video, data)
5. **Supports Multiple Network Types:** Can carry IPv4, IPv6, or other protocols

### MPLS VPN Types

#### **L2VPN (Layer 2 VPN)**
- Emulates Layer 2 connectivity (Ethernet)
- Service provider provides virtual Ethernet segment
- Customers can send any Layer 3 protocol (IP, IPX, etc.)
- Use case: Connecting Ethernet LANs transparently

#### **L3VPN (Layer 3 VPN)**
- Service provider provides Layer 3 (IP) routing
- Each customer gets their own VPN routing table
- More scalable for large-scale deployments
- Use case: Full enterprise network integration

---

## 16.2 Internet as WAN Infrastructure



### Simple Explanation

Before MPLS and leased lines, enterprises had one option for connecting remote sites: the public internet. Today, the internet is still used, especially by smaller organizations. The internet is cheap (broadband costs $50–$300/month) but unpredictable—your download speed depends on who else is using it. To make the internet secure, enterprises wrap traffic in encryption using [[VPN]]s.

### Internet-Based WAN Connections

The public [[Internet]] is increasingly used for WAN connectivity because:
- **Low cost:** Broadband is far cheaper than leased lines ($50–$300/month vs. $800–$4,000/month)
- **High availability:** Multiple providers available in most locations (redundancy)
- **Sufficient bandwidth:** Modern broadband offers 100 Mbps–1 Gbps+
- **Widespread access:** Available almost everywhere

**Disadvantages:**
- Shared infrastructure (congestion possible)
- Unpredictable latency and jitter
- Public network (security risk without encryption)
- ISP doesn't guarantee performance (best-effort service)

---

## 16.3 Virtual Private Networks (VPNs)



### Simple Explanation

A VPN is like sending a letter inside a locked box on a public mail carrier. The box travels through the public mail system (internet) where anyone can see the box, but only you and the recipient have keys to unlock it. The mail carrier doesn't know what's inside—they just deliver the locked box.

### Technical Definition

A **[[VPN]]** (Virtual Private Network) is a secure, encrypted tunnel over a public network (typically the internet) that:
- **Encrypts** all data traveling through it
- **Authenticates** endpoints to ensure only authorized devices connect
- Creates the illusion of a **private, dedicated network** despite using shared internet infrastructure
- Allows remote offices, branch sites, and even individual users to securely connect to enterprise networks

### Why VPNs Matter for CCNA

The CCNA exam explicitly covers **[[IPsec]] remote access and site-to-site VPNs** (exam topic 5.5). This is critical because:
1. Internet-based WANs require encryption—otherwise traffic is visible to ISPs and attackers
2. VPNs are the standard way to secure internet-based WAN connections
3. Two main VPN architectures exist: site-to-site (office-to-office) and remote access (individual user to office)

---

## Lab Relevance: Cisco IOS Commands



### VPN Configuration Commands (Site-to-Site IPsec)

#### **IPsec Phase 1 (ISAKMP/IKE) Configuration**
```
Router(config)# crypto isakmp policy 10
Router(config-isakmp)# encryption aes 256
Router(config-isakmp)# hash sha256
Router(config-isakmp)# authentication pre-share
Router(config-isakmp)# group 14
Router(config-isakmp)# lifetime 86400

Router(config)# crypto isakmp key Cisco123! address 203.0.113.2
```

**What these do:**
- `crypto isakmp policy` — Define IKE Phase 1 negotiation parameters
- `encryption aes 256` — Use AES-256 for key exchange encryption
- `hash sha256` — Use SHA-256 for integrity checking
- `authentication pre-share` — Use pre-shared keys (not certificates)
- `group 14` — Use Diffie-Hellman Group 14 for key generation
- `lifetime 86400` — Set IKE SA lifetime to 24 hours (86400 seconds)
- `crypto isakmp key` — Define the pre-shared key and peer IP address

#### **IPsec Phase 2 (IPsec) Configuration**
```
Router(config)# crypto ipsec transform-set TRANSFORM_SET_1 esp-aes 256 esp-sha256-hmac
Router(config-crypto-trans)# mode tunnel

Router(config)# crypto map CRYPTO_MAP_1 10 ipsec-isakmp
Router(config-crypto-map)# set peer 203.0.113.2
Router(config-crypto-map)# set transform-set TRANSFORM_SET_1

---
*Source: Acing the CCNA Exam, Volume 2, Chapter 16 | [[CCNA]]*
