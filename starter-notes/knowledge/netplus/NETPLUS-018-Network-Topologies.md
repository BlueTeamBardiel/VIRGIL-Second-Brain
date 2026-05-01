---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 018
source: rewritten
---

# Network Topologies
**Physical and logical arrangements determine how devices communicate and recover from failures.**

---

## Overview
Network topology describes the geometric arrangement and interconnection patterns that devices use within a network infrastructure. Understanding topology options is critical for the Network+ exam because it directly impacts [[network design]], [[redundancy]], [[scalability]], and troubleshooting approaches during both planning and operational phases.

---

## Key Concepts

### Star Topology (Hub-and-Spoke)
**Analogy**: Imagine a wagon wheel where the hub sits in the center and all spokes connect outward to the rim—every wagon section must route through the center to reach another section.

**Definition**: A [[network topology]] where all [[end devices]] connect through a single central [[switching]] device, forcing all [[data transmission]] to pass through that core point.

| Aspect | Detail |
|--------|--------|
| **Central Device** | [[Ethernet switch]], [[router]], or hub |
| **Device Communication** | All traffic flows through center |
| **Failure Impact** | Center failure isolates entire network |
| **Most Common** | Used in modern enterprise [[LAN]] environments |

**Advantages**:
- Easy to add/remove devices
- Centralized [[network monitoring]]
- Simplified [[troubleshooting]] from one point
- Predictable [[bandwidth]] allocation

**Disadvantages**:
- Single point of failure at center
- Higher [[latency]] than direct connections
- Center device becomes [[bottleneck]]

---

### Mesh Topology
**Analogy**: Think of a fishing net where every knot connects to multiple neighboring knots—if one knot breaks, alternate paths still exist to reach your destination.

**Definition**: A [[network topology]] where each [[node]] maintains multiple [[network connections]] to other nodes, creating redundant paths for [[data]] to travel between any two points.

| Type | Description | Use Case |
|------|-------------|----------|
| **Full Mesh** | Every device connects to every other device | High-availability core networks |
| **Partial Mesh** | Devices connect to multiple (but not all) other devices | WAN backbone connections |

**Advantages**:
- High [[redundancy]] and [[fault tolerance]]
- No single point of failure
- Multiple simultaneous data paths
- Self-healing via alternate routes

**Disadvantages**:
- Extremely expensive (more cables/connections)
- Complex [[network configuration]]
- Higher equipment costs
- Overkill for small deployments

**Where It Matters**: [[WAN]] links, critical [[data center]] interconnects, and [[MPLS]] networks often use partial mesh designs.

---

## Exam Tips

### Question Type 1: Topology Selection
- *"A healthcare facility requires zero downtime for patient records. Which topology ensures traffic survives a single link failure?"* → [[Mesh topology]] (partial mesh acceptable)
- **Trick**: "Star topology" seems simple but offers no redundancy—center device failure = complete outage

### Question Type 2: Failure Scenarios
- *"In a star topology, what happens when the central switch fails?"* → All device-to-device communication halts; only that central device is the problem point
- **Trick**: Don't assume end devices fail—the test is asking about the topology's weakness (the center)

### Question Type 3: Scaling & Cost
- *"An organization needs to connect 50 branch offices with complete redundancy between any two offices. Which topology is least practical?"* → Full [[mesh topology]] (would require 50×49÷2 = 1,225 connections)
- **Trick**: Recognize when "perfect redundancy" is economically unfeasible; partial mesh is the real-world answer

---

## Common Mistakes

### Mistake 1: Confusing Star with Mesh Redundancy
**Wrong**: "Star topology provides redundancy because it has a central device."
**Right**: Star topology creates a **dependency** on one central device; if that device fails, the entire network isolates. Redundancy comes from having **multiple paths**, which mesh provides.
**Impact on Exam**: You'll misidentify which topology survives failures—critical for scenario questions.

### Mistake 2: Assuming Mesh = Always Full Mesh
**Wrong**: "Mesh topology means every device connects to every other device."
**Right**: Most real deployments use **partial mesh** where key devices (like [[routers]]) have multiple connections, but not every device is fully redundant.
**Impact on Exam**: When a question says "mesh," confirm if it's asking about full or partial—the cost/complexity answer changes dramatically.

### Mistake 3: Missing Scalability Trade-offs
**Wrong**: "Mesh is better than star, so always use mesh."
**Right**: Star is scalable and cost-effective for most [[LAN]]s; mesh is only justified where downtime is unacceptable AND budget allows.
**Impact on Exam**: Answer selection depends on scenario constraints (budget, availability requirements, location count). Don't default to the "fancier" topology.

---

## Related Topics
- [[Switching]] (implements star topology in practice)
- [[Network Redundancy]] (why mesh matters)
- [[WAN Design]] (where mesh is deployed)
- [[Single Point of Failure]]
- [[Fault Tolerance]]
- [[Network Scalability]]
- [[MPLS]] (uses mesh concepts)
- [[Data Center Networking]]

---

*Source: Rewritten from Professor Messer CompTIA Network+ N10-009 | [[Network+]]*