# Dynamic Routing
**Tagline:** Understanding how routers automatically share network information to build routing tables and adapt to network changes—essential for scalable, resilient networks.

---

## Overview

[[Dynamic routing]] is the process by which routers automatically exchange network topology information with each other and build their routing tables without manual administrator intervention. This contrasts sharply with [[static routing]], where an administrator manually configures each route. Routers accomplish this through **[[Routing Protocol]]**—standardized protocols that define how routers communicate and share routing information.

**Simple analogy:** Static routing is like giving someone a single hardcoded set of directions. Dynamic routing is like having a group of people constantly updating each other on traffic conditions and rerouting based on what's happening right now.

---

## 17.1 Dynamic Routing vs. Static Routing

### Fundamental Differences

| Aspect | [[Static Routing]] | [[Dynamic Routing]] |
|--------|-------------------|-------------------|
| **Configuration** | Manual, per-route | Automatic via routing protocol |
| **Scalability** | Poor; impractical for large networks | Excellent; handles complex topologies |
| **Adaptability** | None; cannot respond to failures | Automatic; converges to alternate paths |
| **Overhead** | Minimal CPU/bandwidth | Significant; continuous updates |
| **Best Use** | Small networks, stub networks | Enterprise networks, redundancy needed |
| **Convergence Time** | N/A (static) | Seconds to minutes depending on protocol |

### Key Definition: [[Routing Protocol]]

A routing protocol is a set of rules and mechanisms that enable routers to:
1. Share information about reachable networks (called **advertisement**)
2. Learn about networks from neighboring routers
3. Calculate optimal paths to destinations
4. Adapt when network topology changes

---

## 17.1.1 Adaptability: The Critical Advantage

### How Static Routing Fails Under Failure

When a link fails in a static routing environment:
- The router detecting the failure removes affected routes from its routing table
- **Other routers remain unaware** of the failure
- Those unaware routers continue forwarding packets to now-invalid next-hop addresses
- Packets destined for the failed segment are dropped silently

**Example scenario:** R1 has a static route to 192.168.30.0/24 via R2. If the R2–R3 link fails:
- R2 removes its route to 192.168.30.0/24 (can't reach next hop)
- R1 keeps its route to 192.168.30.0/24 via R2 (unaware of failure)
- R1 sends traffic to R2; R2 drops it because it has no valid route

**Key principle:** A router removes a route from its routing table if it cannot reach the next-hop IP address. This applies equally to static and dynamic routes.

### How Dynamic Routing Adapts

When the same link fails in a dynamic routing environment:
1. Routers detect the failure within seconds
2. Routing protocol messages propagate the topology change
3. All routers recalculate routes using alternate paths
4. Routing tables are automatically updated throughout the network
5. Traffic flows via new paths without administrator intervention

**Key benefit:** **Network convergence**—the process of all routers reaching a consistent view of the network. Convergence time depends on the routing protocol (typically 10 seconds to a few minutes).

**Simple analogy:** Static routing is like a printed map that never updates. Dynamic routing is like having a live traffic app that everyone is using—the moment something changes, everyone automatically knows about it.

---

## 17.1.2 Scalability: Why Dynamic Routing Wins

### The Static Routing Scaling Problem

In a network with 100+ routers, an administrator would need to manually configure:
- 100+ routes on each router (one per destination network)
- Every possible alternate path
- Manual updates every time the network topology changes

This becomes:
- **Administratively impossible** (too many configurations)
- **Error-prone** (typos and omissions)
- **Unmaintainable** (changes cascade everywhere)

### Dynamic Routing Scales Elegantly

Routers automatically:
- Share information about networks they're directly connected to
- Learn about distant networks from neighbors
- Propagate that information throughout the network
- Require only **one command per routing protocol** activation

A network of 1000 routers can be managed with minimal configuration overhead.

---

## 17.2 Types of Dynamic Routing Protocols

Routing protocols fall into two main categories based on their scope:

### [[Interior Gateway Protocols (IGP)]]

Used to exchange routing information within an autonomous system (AS)—a network under single administrative control.

**Distance Vector Protocols:**
- [[RIPv1]], [[RIPv2]] – Legacy; rarely used today
- [[EIGRP]] (Enhanced Interior Gateway Routing Protocol) – Cisco proprietary; excellent scalability and fast convergence
- Basic concept: "Tell your neighbors about the routes you know, and the distance to reach them"

**Link State Protocols:**
- [[OSPFv2]], [[OSPFv3]] – Open standard; works on any vendor's equipment
- [[IS-IS]] – Less common in enterprise; used by ISPs
- Basic concept: "Share detailed topology information with all routers; each calculates its own best paths"

### [[Exterior Gateway Protocols (EGP)]]

Used to exchange routing information between autonomous systems (inter-AS).

- [[BGP]] (Border Gateway Protocol) – The only EGP in use today; runs the entire internet

| Feature | Distance Vector | Link State |
|---------|-----------------|-----------|
| **Information Shared** | Routes and distances | Complete topology map |
| **Knowledge** | Neighbors only | Entire network |
| **Calculation** | Simple (Bellman-Ford) | Complex (Dijkstra's algorithm) |
| **Convergence** | Slower; prone to loops | Faster; inherently loop-free |
| **Overhead** | Lower bandwidth | Higher bandwidth |
| **Examples (IGP)** | RIPv2, EIGRP | OSPFv2, IS-IS |

**Key analogy for Distance Vector:** Asking a friend "How far is Paris?" They say "30 units away." You believe them without checking a map.

**Key analogy for Link State:** Getting a complete street map and calculating your own route to Paris by examining all roads.

---

## 17.3 How Routers Decide Which Routes Enter the Routing Table

### 17.3.1 Administrative Distance ([[AD]])

When a router learns about the same destination network from multiple sources, it uses **Administrative Distance** to choose which route to trust.

**AD is a trustworthiness metric (0–255):**
- **0** = Completely trusted (directly connected networks)
- **Lower number** = Higher trust
- **255** = Never use (unreachable)

| Route Source | Default AD |
|--------------|-----------|
| Directly connected | 0 |
| Static route | 1 |
| EIGRP | 90 |
| OSPF | 110 |
| RIPv2 | 120 |
| BGP (external) | 20 |
| Unknown/unreachable | 255 |

**Decision process:** A router prefers routes learned from sources with lower AD numbers. If two routes to the same destination have different sources:
- Route via EIGRP (AD 90) is preferred over route via OSPF (AD 110)
- Route via OSPF (AD 110) is preferred over route via RIPv2 (AD 120)

**Example:** If a router learns about 10.0.0.0/8 from both EIGRP (AD 90) and OSPF (AD 110), it uses the EIGRP route and ignores the OSPF route.

### 17.3.2 Metric: Breaking Ties When AD is Equal

If multiple routes have the **same AD**, the router uses **metric** to select the best path.

Metric definition varies by protocol:

| Protocol | Metric | Calculation |
|----------|--------|-------------|
| [[RIPv2]] | Hop count | Number of routers to destination |
| [[EIGRP]] | Composite | Bandwidth + delay (+ load, reliability) |
| [[OSPF]] | Cost | 100,000 / interface bandwidth |
| [[BGP]] | Multiple | AS path length (primary), local preference, etc. |

**Example OSPF cost calculation:**
- 100 Mbps Ethernet: 100,000 / 100,000,000 = 1
- 10 Mbps line: 100,000 / 10,000,000 = 10 (worse)
- 1 Gbps interface: 100,000 / 1,000,000,000 = 0.1 (better)

Lower metric = better path.

**Real scenario:** Two OSPF routes to 10.0.0.0/8:
- Route A: via R2 with cost 10 ✓ **Selected**
- Route B: via R3 with cost 20

Route A wins because it has lower metric.

### 17.3.3 Longest Prefix Match ([[LPM]])

When a packet arrives, the router matches it against routing table entries. If multiple entries match, the router uses the **longest matching prefix**.

| Destination IP | Route in Table | Prefix Length | Match? |
|---|---|---|---|
| 10.50.2.100 | 10.50.2.0/24 | /24 | ✓ Yes |
| 10.50.2.100 | 10.50.0.0/16 | /16 | ✓ Yes (less specific) |
| 10.50.2.100 | 10.0.0.0/8 | /8 | ✓ Yes (even less specific) |

**Decision:** Use the /24 route (longest/most specific).

| Destination | Best Match | Why |
|---|---|---|
| 192.168.1.50 | 192.168.1.0/24 | /24 is longer than /8 |
| 172.16.5.200 | 172.16.0.0/16 | Only one match |
| 10.100.0.1 | 10.0.0.0/8 | Least specific match (only option) |

**Critical:** LPM applies to **forwarding decisions**, not to route selection for the routing table. LPM ensures packets reach the most specific (most likely correct) destination.

---

## 17.4 Configuring Dynamic Routing: The network Command

### Activating a Routing Protocol

To participate in dynamic routing, a router must:
1. Enable a routing protocol (e.g., OSPF, EIGRP)
2. Tell the protocol which **interfaces and networks** to advertise
3. Specify which **neighbors** to talk to (for some protocols)

The [[network command]] is the primary tool for step 2.

### OSPF Configuration Using network Command

```
Router(config)# router ospf <process-id>
Router(config-router)# network <network-address> <wildcard-mask> area <area-id>
```

**Example:**
```
Router(config)# router ospf 1
Router(config-router)# network 192.168.1.0 0.0.0.255 area 0
Router(config-router)# network 10.0.0.0 0.0.0.255 area 0
```

**What this does:**
- Enables OSPF process 1 on the router
- Activates OSPF on any interface in the 192.168.1.0/24 range
- Activates OSPF on any interface in the 10.0.0.0/24 range
- Places both in OSPF area 0 (backbone area)

### EIGRP Configuration Using network Command

```
Router(config)# router eigrp <AS-number>
Router(config-router)# network <network-address> [<wildcard-mask>]
```

**Example:**
```
Router(config)# router eigrp 100
Router(config-router)# network 192.168.1.0 0.0.0.255
Router(config-router)# network 10.0.0.0 0.0.0.255
```

**Wildcard Mask vs. Subnet Mask:**

| Subnet Mask | Wildcard Mask | Purpose |
|---|---|---|

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 17 | [[CCNA]]*
