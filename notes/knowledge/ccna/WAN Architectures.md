# WAN Architectures
**Tagline:** Connect geographically dispersed LANs into unified enterprise networks using dedicated and shared WAN technologies.

## Why This Chapter Matters

WANs are the backbone of enterprise networking. While LANs connect devices within a building, WANs connect entire offices, data centers, and retail locations across cities and countries. The CCNA expects you to understand how to choose between technologies (leased lines vs. MPLS), secure remote connections with [[VPN]]s, and recognize which topology works best for different scenarios. This chapter bridges the gap between local connectivity and global enterprise infrastructure.

---

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