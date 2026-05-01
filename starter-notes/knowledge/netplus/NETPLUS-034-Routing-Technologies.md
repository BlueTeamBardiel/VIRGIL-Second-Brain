---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 034
source: rewritten
---

# Routing Technologies
**Routers use lookup tables to intelligently forward packets toward their destinations across interconnected networks.**

---

## Overview
A [[router]]'s fundamental responsibility is to inspect arriving data packets, determine where they're headed, and forward them out the correct [[interface]]. This decision-making process forms the backbone of how data moves across [[networks]]. For Network+ candidates, understanding how routers consult their internal lookup mechanisms is critical—it's the foundation for troubleshooting connectivity problems and understanding modern network architecture.

---

## Key Concepts

### Routing Table
**Analogy**: Think of a routing table like a postal worker's delivery map—it shows every known destination and which direction to send mail for that destination.

**Definition**: A [[routing table]] is a data structure maintained by [[routers]], [[servers]], [[workstations]], and other networked devices that maps [[IP addresses]] (or ranges of addresses) to the [[interface]] or next-hop address where traffic bound for that destination should be sent.

Every network device maintains its own routing table:
- [[Workstations]] have routing tables
- [[Servers]] maintain routing tables  
- [[Routers]] maintain routing tables
- All modern [[operating systems]] include routing tables

**Key Point**: When troubleshooting any routing problem, you always begin and end by examining the routing table's contents.

---

### Route Selection & Tiebreaking
**Analogy**: Imagine multiple highways connecting two cities—when there are equal routes, you need a consistent rule (like "always prefer the faster highway") to pick one every time.

**Definition**: A [[router]] may discover multiple valid paths to reach the same destination. When multiple routes exist with equal [[administrative distance]] or [[metric]], the router requires a tiebreaker mechanism to select a single best route.

Common tiebreaking methods include:
- [[Administrative Distance]] (AD) — trusts some routing sources more than others
- [[Metric]] — prefers routes with lower costs
- [[Hop count]], [[bandwidth]], [[delay]], and other [[OSPF]] path costs
- Router vendor-specific algorithms when all else is equal

---

### Dynamic Routing Protocols
**Analogy**: Instead of manually writing out every address on a map, routers can "talk" to each other and automatically share what destinations they know about.

**Definition**: [[Dynamic routing protocols]] enable routers to automatically discover and update their routing tables by exchanging topology information with neighboring routers.

| Protocol | Type | Metric | Use Case |
|----------|------|--------|----------|
| [[RIP v2]] | [[Distance-vector]] | [[Hop count]] | Legacy small networks |
| [[OSPF]] | [[Link-state]] | Cost/bandwidth | Enterprise, scalable |
| [[EIGRP]] | [[Advanced distance-vector]] | Multiple factors | Cisco environments |
| [[BGP]] | [[Path-vector]] | AS path | Internet backbone |

**Built Routes vs. Advertised Routes**:
- Directly connected networks are automatically installed into the routing table
- Remote networks are learned via [[dynamic routing protocols]] like [[RIP]], [[OSPF]], or [[EIGRP]]

---

### Routing Table Structure (Cisco Example)
**Anatomy of a Routing Table Entry**:

```
Destination Network | Administrative Distance / Metric | Next-Hop Address | Interface
10.1.0.0/24        | O  110/30                         | 192.168.1.1      | Gi0/1
172.16.0.0/16      | R  120/2                          | 192.168.1.2      | Gi0/2
```

**Field Meanings**:
- **Destination Network**: The target IP range (what destination does this route handle?)
- **Protocol/AD/Metric**: The source protocol and cost (how trustworthy? how expensive?)
- **Next-Hop**: The immediate router to forward this traffic toward
- **Interface**: The physical or logical port to send packets out of

---

## Exam Tips

### Question Type 1: Identifying Routing Table Entries
- *"A router receives a packet destined for 192.168.50.100. Its routing table shows a route for 192.168.50.0/24. Will the router forward this packet?"* → **Yes**—the /24 [[CIDR notation]] covers this host.
- **Trick**: Confusing subnet masks with actual host addresses; always verify the network range includes the destination IP.

### Question Type 2: Administrative Distance & Metric
- *"A router learns about network 10.0.0.0/8 via both RIP (AD 120) and OSPF (AD 110). Which route is installed?"* → **OSPF**—lower AD is preferred regardless of metric.
- **Trick**: Forgetting that [[administrative distance]] is checked *before* [[metric]]; they're not weighed together.

### Question Type 3: Dynamic Protocol Behavior
- *"Which routing protocol automatically discovers topology changes without manual configuration?"* → [[OSPF]], [[EIGRP]], [[RIP]] (any dynamic protocol).
- **Trick**: Mixing up [[static routing]] (manually entered) with [[dynamic routing]] (automatically learned).

---

## Common Mistakes

### Mistake 1: Confusing Metric with Administrative Distance
**Wrong**: "RIP has a higher metric, so it's less trustworthy than OSPF."
**Right**: [[Administrative distance]] determines trustworthiness first (lower = more trusted). [[Metric]] only breaks ties between routes *from the same protocol source*.
**Impact on Exam**: You'll misread questions about route selection; you need to check AD before looking at metrics.

### Mistake 2: Assuming All Devices Need Dynamic Routing
**Wrong**: "Every device must run RIP or OSPF to communicate."
**Right**: Only [[routers]] need dynamic routing protocols. [[Workstations]] and [[servers]] rely on a default route or static routing to send traffic to their gateway.
**Impact on Exam**: Questions about end-device routing behavior will trip you up if you expect every device to run dynamic protocols.

### Mistake 3: Forgetting That Routing Tables Are Consulted *Per-Packet*
**Wrong**: "The router remembers where it sent the last packet and keeps sending there."
**Right**: Each packet is independently looked up in the routing table; the router makes a fresh decision for every packet.
**Impact on Exam**: Misunderstanding load-balancing questions or why a router might send traffic down different paths for different destinations.

### Mistake 4: Assuming the Routing Table Guarantees Delivery
**Wrong**: "If the packet is in the routing table, it will definitely reach the destination."
**Right**: The routing table only guarantees the *next hop*—that neighboring router must also know how to forward the packet further. No end-to-end guarantee exists.
**Impact on Exam**: You'll miss questions about incomplete routing information or asymmetric routes causing one-way communication failures.

---

## Related Topics
- [[Static Routes]]
- [[Default Routes]]
- [[OSPF]] (Open Shortest Path First)
- [[RIP]] (Routing Information Protocol)
- [[EIGRP]] (Enhanced Interior Gateway Routing Protocol)
- [[BGP]] (Border Gateway Protocol)
- [[Administrative Distance]]
- [[Metric]]
- [[Gateway of Last Resort]]
- [[Routing Loops]]
- [[Convergence]]
- [[Cisco IOS CLI]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*