---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 019
source: rewritten
---

# Network Architectures
**The three-tiered model organizes enterprise networks into hierarchical layers for scalability, redundancy, and efficient resource access.**

---

## Overview
Large organizations typically adopt a layered approach to network design rather than a flat structure. This hierarchical model separates concerns into distinct tiers that each serve specific functions. Understanding this architecture is critical for Network+ because it appears frequently in exam questions about enterprise design, troubleshooting connectivity issues, and optimizing network performance.

---

## Key Concepts

### Three-Tiered Architecture
**Analogy**: Think of a city's infrastructure—homes connect via local streets (access layer), which feed into highways (distribution layer), which converge at the downtown center (core layer) where major institutions and resources live.

**Definition**: A hierarchical [[network topology]] consisting of three layers that separate user access from critical resources, with each layer optimizing for its specific purpose while maintaining redundancy and controlled traffic flow.

| Layer | Primary Function | Hardware | Proximity to Users |
|-------|------------------|----------|-------------------|
| **Core** | Central resource hub & backbone | High-speed routers, switches | Data center only |
| **Distribution** | Aggregation & redundancy | Mid-tier switches | Building/campus level |
| **Access** | User connection points | Edge switches | Same room/floor |

---

### Core Layer
**Analogy**: The heart of the network—where all vital organs (servers, databases, applications) are located and protected.

**Definition**: The innermost tier containing centralized [[servers]], [[databases]], critical [[applications]], and the network backbone. This layer prioritizes speed and reliability through redundant [[fiber optic]] connections and high-performance equipment.

- Houses enterprise-critical resources
- Uses [[load balancing]] and [[failover]] mechanisms
- Typically confined to the data center
- Implements [[network redundancy]] patterns

---

### Distribution Layer
**Analogy**: The postal sorting facility—mail arrives from thousands of sources and gets intelligently routed to the correct final destination.

**Definition**: The middle tier that aggregates traffic from multiple [[access layer]] switches and intelligently distributes it toward [[core layer]] resources. Acts as the gateway between user areas and critical infrastructure.

- Composed of aggregation [[switches]]
- Provides [[VLAN]] routing and [[access control lists]] (ACLs)
- Creates redundancy through multiple uplinks to core
- Often implements [[spanning tree protocol]] (STP) to prevent loops
- May handle [[QoS]] policies

---

### Access Layer
**Analogy**: The front door of each department—where individual employees physically plug in their devices to reach the larger organization.

**Definition**: The outermost tier where end-user [[devices]] directly connect to the network. These switches are geographically distributed and placed near users for convenient access.

```
[User Device] → [Access Switch] → [Distribution Switch] → [Core]
  (Same floor)    (Building)        (Campus)            (Data Center)
```

- Located on user floors or in work areas
- Uses standard [[Ethernet]] connections ([[PoE]] for [[VoIP]] phones and [[wireless access points]])
- Implements [[port security]] and [[802.1X]] authentication
- Lower processing demands than distribution/core

---

## Exam Tips

### Question Type 1: Layer Identification
- *"A user on the third floor cannot reach the database server in the data center. The access layer switch shows the port as active. Where should you investigate next?"* → Distribution layer—the connection point between access and core.
- **Trick**: Don't assume the problem is at the access layer just because that's where the user connects. Think in terms of the complete path.

### Question Type 2: Redundancy Placement
- *"Where should redundant uplinks be implemented in a three-tiered network?"* → Distribution-to-core connections primarily, with some redundancy in distribution itself.
- **Trick**: Access layer switches don't typically need redundant uplinks to every distribution switch—that's cost-prohibitive and unnecessary.

### Question Type 3: Technology Matching
- *"Which of these is most commonly found at the core layer: managed switches, unmanaged switches, or wireless access points?"* → Managed switches (with routing capabilities).
- **Trick**: Don't confuse access layer devices (like WAPs) with core layer devices.

---

## Common Mistakes

### Mistake 1: Assuming All Switches Are the Same
**Wrong**: "A switch is a switch—they all do the same thing."
**Right**: Core switches are high-performance routing switches; distribution switches handle VLAN routing and redundancy; access switches prioritize user connectivity and port security.
**Impact on Exam**: You'll encounter questions asking which layer handles specific functions. Confusing them leads to wrong answers about where to configure ACLs, [[QoS]], or [[port security]].

### Mistake 2: Misunderstanding "Distribution" Purpose
**Wrong**: "The distribution layer is just one more switch between users and the server."
**Right**: Distribution actively aggregates multiple access switches, provides intelligent routing decisions, implements policies, and ensures redundancy to the core.
**Impact on Exam**: Questions about network bottlenecks or optimal design often hinge on understanding that distribution is an intelligent aggregation point, not just a pass-through.

### Mistake 3: Placing Redundancy Incorrectly
**Wrong**: "Every access switch needs redundant uplinks to maintain reliability."
**Right**: Redundancy is most critical at distribution-to-core links; access-to-distribution can be single uplinks in smaller environments.
**Impact on Exam**: Design questions will test whether you understand cost-benefit trade-offs. Overkill redundancy at access layer is wasteful; missing it at core is dangerous.

### Mistake 4: Forgetting the Physical Geography Aspect
**Wrong**: Treating the three tiers as purely logical rather than physical.
**Right**: Access layer = user's building/floor; distribution layer = campus-wide or building-to-building; core = centralized data center.
**Impact on Exam**: Latency and distance-related questions assume you understand that tiers are geographically distributed, which affects both design and troubleshooting.

---

## Related Topics
- [[Hierarchical Network Design]]
- [[Redundancy and Failover]]
- [[VLAN Design and Routing]]
- [[Spanning Tree Protocol (STP)]]
- [[Access Control Lists (ACLs)]]
- [[Quality of Service (QoS)]]
- [[Port Security]]
- [[Network Segmentation]]
- [[Load Balancing]]

---

*Source: Rewritten from Professor Messer CompTIA Network+ N10-009 Lecture Series | [[Network+]]*