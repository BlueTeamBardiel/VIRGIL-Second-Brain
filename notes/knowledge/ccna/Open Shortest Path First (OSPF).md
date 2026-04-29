# Open Shortest Path First (OSPF)
**Interior Gateway Protocol for dynamic routing based on link-state algorithms—essential for CCNA because it's one of two main IGPs and appears heavily on both the written exam and lab practicum.**

---

## Overview: What OSPF Is and Why It Matters

### Simple Explanation
Think of [[OSPF]] like a group of neighbors sharing detailed maps of their streets. Each neighbor (router) describes what they can see from their own location, shares that information with everyone else, and together they all build an identical, complete map of the neighborhood. Then each router uses that complete map to decide the best route to send traffic.

In contrast, [[RIP]] is like a game of telephone—each router only knows what the neighbor directly next to it says, which is slower and less reliable.

### The Detail Layer
[[OSPF]] is a **link-state Interior Gateway Protocol (IGP)** that uses Dijkstra's shortest path first algorithm. Unlike distance-vector protocols such as [[RIP]], OSPF routers don't exchange routing tables; they exchange detailed information about network topology (links and their costs). Each router builds its own **Link State Database (LSDB)**, computes the shortest path tree with itself as root, and populates its routing table from that tree.

Key architectural differences from [[RIP]]:
- **No hop-count limit**: OSPF supports networks up to 65,535 hops (unlimited in practice); RIP maxes at 15
- **Metric**: OSPF uses cost (based on bandwidth); RIP uses hop count
- **Convergence**: OSPF converges faster because it recalculates only affected routes
- **Bandwidth overhead**: OSPF uses more bandwidth for initial LSDB exchange but less for steady-state updates
- **CPU overhead**: OSPF uses more CPU for Dijkstra calculations

---

## OSPF Fundamentals

### How OSPF Works: The Three-Step Process

**1. Neighbor Discovery**
Routers send multicast [[Hello]] packets (224.0.0.5:UDP/89) on directly connected segments. When two routers hear each other's Hello packets, they become **neighbors**. Hello packets must match:
- Area ID
- Network mask
- Hello interval (default 10s on broadcast, 30s on NBMA)
- Dead interval (default 40s on broadcast, 120s on NBMA)
- Authentication password (if configured)

**2. LSDB Synchronization**
Once neighbors form an **adjacency** (full bidirectional state), they exchange their entire LSDB through **Link State Advertisements (LSAs)**. This happens once; subsequent updates are event-driven (triggered by topology changes).

**3. SPF Calculation**
Each router runs Dijkstra's algorithm independently on the LSDB to build its SPF tree. Only after SPF calculation completes does the router update its routing table. This is why OSPF routers can temporarily disagree on routes—they're all calculating independently.

### OSPF Areas

OSPF networks are divided into **areas** to reduce the size of each LSDB and limit the scope of LSA flooding. Areas are identified by a 32-bit number (written in dotted-decimal: 0.0.0.0 to 255.255.255.255, though typically 0–4294967295).

- **Backbone Area (Area 0)**: All other areas must connect to Area 0. Inter-area routes are learned through Area 0.
- **Standard Area**: Normal area that floods LSAs only within its boundary
- **Stub Area**: Doesn't receive LSAs for external routes (Type 5); uses a default route to the ABR
- **Totally Stubby Area** (Cisco extension): Doesn't receive inter-area or external route LSAs; uses default route only
- **NSSA** (Not-So-Stubby Area): Can import external routes via Type 7 LSAs (converted to Type 5 by ASBR)

| Area Type | Receives Type 1–4 LSAs | Receives Type 5 LSAs | Receives Type 3 LSAs | Use Case |
|-----------|------------------------|----------------------|----------------------|----------|
| Backbone | Yes | Yes | Yes | Core network |
| Standard | Yes | Yes | Yes | Standard deployment |
| Stub | Yes | No | Yes | Remote locations, single exit |
| Totally Stubby | Yes | No | No | Remote branch, single exit |
| NSSA | Yes | No (Type 7) | Yes | Remote site needing external routes |

### Router Types

| Role | Definition | Example |
|------|-----------|---------|
| **Internal Router** | All interfaces in same area | Branch router in Area 1 only |
| **ABR** (Area Border Router) | Connects to multiple areas (including Area 0) | Router with interfaces in Area 0 and Area 1 |
| **ASBR** (Autonomous System BR) | Connects OSPF to another routing domain | Router running OSPF + BGP, or redistributing from RIP |
| **Backbone Router** | At least one interface in Area 0 | Any router touching the backbone |

---

## OSPF Packet Types and LSA Types

### OSPF Packet Types

| Type | Name | Purpose | Multicast Address |
|------|------|---------|-------------------|
| 1 | Hello | Neighbor discovery, keepalive | 224.0.0.5 |
| 2 | Database Description (DBD) | Summarize LSDB contents during sync | Unicast |
| 3 | Link State Request (LSR) | Ask for missing or stale LSAs | Unicast |
| 4 | Link State Update (LSU) | Deliver LSAs | 224.0.0.5 (flooding) |
| 5 | Link State Acknowledgment (LSAck) | Confirm receipt of LSUs | Unicast/Multicast |

All OSPF packets use **IP protocol 89** (not UDP or TCP).

### LSA Types (Critical for CCNA)

| Type | Name | Generated By | Scope | Contains |
|------|------|--------------|-------|----------|
| 1 | Router LSA | Every router | Intra-area | Links and neighbors within area |
| 2 | Network LSA | DR on multi-access segment | Intra-area | All routers on segment; pseudo-node |
| 3 | Network Summary LSA | ABR | Inter-area | Routes from other areas; cost updated |
| 4 | ASBR Summary LSA | ABR | Inter-area | Path to ASBR; cost to reach it |
| 5 | External LSA | ASBR | Entire OSPF domain | Routes redistributed from outside OSPF |
| 7 | NSSA External LSA | ASBR in NSSA | Within NSSA | External route in NSSA; converted to Type 5 at ABR |

**Flooding rule**: Type 1 and 2 LSAs flood only within their area. Type 3, 4, 5 flood across area boundaries. Type 7 floods within NSSA only.

---

## OSPF Timers and Neighbor States

### Key Timers

| Timer | Default (Broadcast) | Default (NBMA) | Purpose |
|-------|---------------------|-----------------|---------|
| Hello Interval | 10 seconds | 30 seconds | Frequency of Hello packets |
| Dead Interval | 40 seconds (4× Hello) | 120 seconds (4× Hello) | Time before declaring neighbor dead |
| SPF Delay | 5 seconds | — | Delay before first SPF calculation |
| SPF Holdtime | 10 seconds | — | Minimum interval between back-to-back SPF runs |
| LSA Retransmit | 5 seconds | — | Time before retransmitting unacked LSA |

**Critical**: Hello and Dead intervals must match between neighbors, or they will **not form adjacency**.

### Neighbor States (in order)

1. **Down**: No Hello packets received
2. **Attempt**: (NBMA only) Unicast Hello sent; waiting for response
3. **Init**: Hello received but bidirectional communication not yet confirmed
4. **Two-Way**: Both routers have seen each other (bidirectional confirmed)
   - **DR/BDR election happens here**
5. **ExStart**: Master/slave negotiation for DBD sequence numbers
6. **Exchange**: DBD packets exchanged; routers discover missing LSAs
7. **Loading**: LSR and LSU packets sent; routers synchronize LSDB
8. **Full**: LSDB fully synchronized; adjacency complete; routes installed

Only routers in **Full** state exchange routing information.

---

## Designated Router (DR) and Backup DR (BDR)

### Why DR/BDR Election?

On multi-access segments (Ethernet, Frame Relay), every router would normally form adjacencies with every other router (**full mesh**). With N routers, that's N×(N−1)/2 adjacencies. For 5 routers: 10 adjacencies. DR/BDR reduces this:
- Each router forms adjacency with DR and BDR only
- Non-DR, non-BDR routers form **two-way** state with each other but **not full adjacency**
- Only DR/BDR relay LSAs from one neighbor to another (flooding)

This reduces LSA overhead and SPF calculations.

### DR Election

1. **Priority wins**: Router with highest priority (0–255) becomes DR; 2nd highest becomes BDR
2. **Tie-breaker**: If priorities match, highest Router ID wins
3. **Router ID**: Highest IP address on loopback interface, or on active interface (if no loopback)
4. **Once elected, sticky**: A new router with higher priority **will not** preempt the current DR until the DR is reset

**Default priority**: 1 (range 0–255; 0 = never DR/BDR)

### Point-to-Point Links

OSPF recognizes point-to-point links (serial, PPP, etc.) and **skips DR/BDR election**. All routers on point-to-point links form full adjacencies with each other.

---

## OSPF Metric Calculation

### Cost Formula

```
Cost = Reference Bandwidth / Interface Bandwidth
```

**Default reference bandwidth**: 100 Mbps (Cisco standard)

| Link Type | Bandwidth | Calculated Cost |
|-----------|-----------|-----------------|
| FastEthernet (100 Mbps) | 100,000 kbps | 1 |
| Gigabit Ethernet (1000 Mbps) | 1,000,000 kbps | 1 |
| Serial T1 (1.544 Mbps) | 1,544 kbps | 64 |
| Serial 56k | 56 kbps | 1,785 |
| Loopback | ∞ (no cost, unreachable) | 0 |

**Problem**: GigE gets same cost as FastEthernet. Solution: Increase reference bandwidth.

### Path Cost

Total cost = sum of all interface costs along path. OSPF always selects path with **lowest total cost**.

---

## Lab Relevance: Essential Cisco IOS Commands

### Enable OSPF and Configure Process

```
Router(config)# router ospf <process-id>
```
- `process-id`: Local significance only (1–65535); different routers can use different process IDs
- Example: `router ospf 1`

### Define Network and Area

```
Router(config-router)# network <network> <wildcard-mask> area <area-id>
```
- **Wildcard mask** is inverse of subnet mask (255.255.255.0 → 0.0.0.255)
- Enables OSPF on interfaces matching this network
- Example: `network 10.0.0.0 0.0.0.255 area 0`

### Set Router ID (Manual)

```
Router(config-router)# router-id <ip-address>
```
- Overrides automatic selection
- Takes effect on process restart or `clear ip ospf process`
- Example: `router-id 1.1.1.1`

### Adjust Interface Metrics

```
Router(config-if)# ip ospf cost <cost>
```
- Manually override calculated cost
- Example: `ip ospf cost 50`

### Adjust Reference Bandwidth

```

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 18 | [[CCNA]]*