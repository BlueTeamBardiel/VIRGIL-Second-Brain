---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 041
source: rewritten
---

# Network Types
**Understanding the structural architectures that define how wireless devices connect and share data across different topologies.**

---

## Overview
Wireless networks can be organized in fundamentally different ways depending on infrastructure, device roles, and coverage requirements. For the Network+ exam, you need to distinguish between these topologies because they affect [[troubleshooting]], [[scalability]], and [[security]] implementations. Each topology makes different trade-offs between complexity, reliability, and range.

---

## Key Concepts

### Wireless Mesh Networks
**Analogy**: Imagine a neighborhood where each house has a radio, and every radio can relay messages from other houses. If your house's radio breaks, the message just takes a different route through your neighbors.

**Definition**: A [[wireless mesh network]] is an architecture where multiple [[access points]] maintain bidirectional communication with each other across a localized coverage area, creating an interconnected grid. Client [[devices]] connect to any single access point within range and gain access to the entire mesh infrastructure through that entry point.

**Key Characteristics**:
| Feature | Mesh Networks |
|---------|---------------|
| Access Point Role | Peer-to-peer relay capability |
| Coverage Expansion | Add APs; automatically join mesh |
| Failure Tolerance | High (self-healing) |
| Configuration | Set on the [[access point]] itself |
| Ideal Environment | Large homes, offices, warehouses |

**Configuration Note**: When you add new [[access points]] to an existing mesh, they detect and join the same mesh configuration automatically without manual intervention.

---

### Ad Hoc Wireless Networks
**Analogy**: Think of a group of students in a classroom passing notes directly to each other without needing a teacher (access point) as an intermediary.

**Definition**: An [[ad hoc network]] (also called IBSS or Independent Basic Service Set) is a decentralized [[wireless]] topology where [[devices]] communicate directly with each other using [[802.11]] radio functionality without requiring an [[access point]] to coordinate traffic.

**Key Characteristics**:
| Feature | Ad Hoc Networks |
|---------|-----------------|
| Infrastructure Required | None (decentralized) |
| Device-to-Device | Direct communication |
| Scalability | Limited (typically 2-10 devices) |
| Self-Healing | Automatic route recalculation |
| Use Case | Temporary peer connections |

**Self-Healing Behavior**: When a device leaves the network, remaining devices automatically recalculate paths to maintain [[connectivity]] without manual reconfiguration.

---

### Infrastructure Mode (Standard [[BSS]] Networks)
**Analogy**: A traditional office phone system where all calls route through the central switchboard rather than people calling each other directly.

**Definition**: The standard [[wireless]] topology where all client devices connect exclusively to a central [[access point]], which handles all routing and traffic forwarding between clients and the wired [[network]].

**Comparison**:

| Topology | Central Authority | Device Relay | Scalability | Latency |
|----------|-------------------|--------------|-------------|---------|
| Infrastructure/[[BSS]] | Yes ([[AP]]) | No | Medium | Low |
| [[Ad Hoc]]/[[IBSS]] | No | Yes | Low | Variable |
| [[Mesh]] | Distributed | Yes | High | Medium |

---

## Exam Tips

### Question Type 1: Topology Identification
- *"A user reports that when one wireless access point fails, other access points automatically reroute traffic. Which topology is in use?"* → [[Mesh networking]]
  - **Trick**: Candidates often confuse this with [[redundancy]]. Mesh is about peer relay capability, not just backup APs.

- *"Two laptops need to share files in a conference room with no access point available. What mode should they use?"* → [[Ad hoc]] mode ([[IBSS]])
  - **Trick**: Students forget that [[802.11]] devices can operate without infrastructure mode.

### Question Type 2: Configuration Scenarios
- *"You're deploying 50 access points across a large facility. Which topology allows new APs to automatically join coverage?"* → [[Wireless mesh]]
  - **Trick**: This requires mesh-capable APs; standard infrastructure doesn't auto-join.

### Question Type 3: Troubleshooting
- *"An ad hoc network drops connectivity whenever one device is powered off. Why?"* → No automatic rerouting; that device was the only relay.
  - **Trick**: Ad hoc networks lack the intelligence of mesh self-healing.

---

## Common Mistakes

### Mistake 1: Confusing Mesh with Redundant Infrastructure
**Wrong**: "We have 3 access points on the same SSID, so we have a mesh network."
**Right**: A mesh requires the APs themselves to relay traffic peer-to-peer; multiple APs on the same [[SSID]] in infrastructure mode just provides coverage overlap and [[handoff]] capability.
**Impact on Exam**: You might select "mesh" when the question describes standard [[AP]] redundancy. Mesh is specifically about AP-to-AP relay.

### Mistake 2: Assuming Ad Hoc Networks Self-Heal
**Wrong**: "Ad hoc networks automatically reroute around failed devices like mesh networks."
**Right**: Ad hoc networks use simple direct [[802.11]] links; they lack the mesh routing protocols that enable self-healing. Device loss = broken connections.
**Impact on Exam**: Questions testing topology resilience often use ad hoc as the wrong answer when asking about self-healing capability.

### Mistake 3: Equating Topology with [[Authentication]]
**Wrong**: "Ad hoc networks are less secure because they lack a central [[access point]]."
**Right**: Security depends on [[encryption]] (WPA2/WPA3), not topology. You can have secure ad hoc networks and insecure mesh networks.
**Impact on Exam**: Don't let topology questions become security questions. They're orthogonal concerns.

### Mistake 4: Forgetting [[802.11]] is Required for All
**Wrong**: "Ad hoc networks use a different wireless standard than infrastructure."
**Right**: Ad hoc, mesh, and infrastructure all use the same [[802.11a/b/g/n/ac/ax]] standards; the difference is how devices organize (with or without [[AP]] mediation).
**Impact on Exam**: Standard selection ([[802.11n]] vs. [[802.11ac]]) is separate from topology selection (infrastructure vs. ad hoc vs. mesh).

---

## Related Topics
- [[802.11 Standards]] (the physical/MAC layer protocols underlying all topologies)
- [[Wireless Access Points]] (hardware used in infrastructure and mesh modes)
- [[IBSS]] (Independent Basic Service Set — formal name for ad hoc)
- [[BSS]] (Basic Service Set — formal name for infrastructure mode)
- [[ESSID and SSID]] (how multiple APs advertise the same network)
- [[Roaming and Handoff]] (how clients move between APs)
- [[Wireless Security Modes]] (orthogonal to topology choice)
- [[Network Redundancy]] (different from mesh self-healing)

---

*Source: Rewritten from CompTIA Network+ N10-009 lecture material | [[Network+]] Certification | [[Wireless Networking]]*