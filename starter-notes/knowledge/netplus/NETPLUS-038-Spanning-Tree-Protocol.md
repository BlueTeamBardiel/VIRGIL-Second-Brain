---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 038
source: rewritten
---

# Spanning Tree Protocol
**An automated mechanism that detects and eliminates redundant paths in switched networks to prevent broadcast storms.**

---

## Overview
When [[switch|switches]] connect through multiple [[Ethernet]] cables, you risk creating circular data paths where [[frame|frames]] circulate endlessly, consuming bandwidth until the network collapses. Unlike [[IP]] which has a [[TTL]] counter to prevent this, [[MAC address|MAC-level]] traffic has no built-in protection against loops. Spanning Tree Protocol (STP), defined in [[IEEE 802.1d]], automatically identifies these dangerous paths and disables them—keeping your network stable without manual intervention.

---

## Key Concepts

### Network Loops
**Analogy**: Imagine a letter being photocopied and re-photocopied in a room with two exit doors. If someone keeps putting copies back in, eventually the room overflows with paper. That's what happens when [[Ethernet frame|Ethernet frames]] loop endlessly between switches.

**Definition**: A [[network loop]] occurs when multiple [[switch|switches]] create redundant paths, allowing [[frame|frames]] to travel in circles. Since [[MAC address|MAC-level]] protocols lack a [[hop count]] mechanism (unlike [[IP]] with [[TTL]]), frames multiply exponentially, overwhelming switch memory and causing a [[broadcast storm]].

**Related**: [[Layer 2]], [[broadcast domain]], [[switch fabric]]

### Spanning Tree Protocol (STP)
**Analogy**: Think of STP as a fire marshal inspecting a building. It identifies all exits (redundant paths), then locks some of them while keeping at least one open for emergencies. If the main route gets blocked, it unlocks a backup.

**Definition**: [[Spanning Tree Protocol|STP]] is an [[IEEE 802.1d]] standard that runs on [[switch|switches]] to detect potential [[network loop|loops]] and automatically place redundant links into a standby state. It ensures a single active path between any two points while maintaining failover capability.

**Key Features**:
- Runs automatically on most modern switches
- Operates at [[Layer 2]] (data link)
- Prevents [[broadcast storm|broadcast storms]] without human intervention
- Allows [[redundancy|redundancy]] without the cost of loops

| Aspect | With STP | Without STP |
|--------|----------|------------|
| Multiple paths allowed | Yes (one active, others blocked) | Yes (all active = loops) |
| Frame duplication | Prevented | Runs rampant |
| Network stability | Stable | Collapses within seconds |
| Manual intervention needed | No | Yes (unplug cables) |

### Port States
**Analogy**: A port's state is like a gate in a fence—it can be locked (blocking), partially open (learning), or fully operational (forwarding).

**Definition**: STP assigns each [[switch port]] a state that determines whether it forwards traffic:

| Port State | Traffic Forwarding | BPDU Processing | Purpose |
|------------|-------------------|-----------------|---------|
| [[Blocking]] | No | Yes | Prevents loops by shutting down redundant paths |
| [[Listening]] | No | Yes | Prepares to forward; checking for topology changes |
| [[Learning]] | No | Yes | Builds [[MAC address table]]; prepares for forwarding |
| [[Forwarding]] | Yes | Yes | Actively sends and receives data frames |
| [[Disabled]] | No | No | Manually shut down by administrator |

**Related**: [[port state transition]], [[BPDU]]

### Bridge Protocol Data Unit (BPDU)
**Analogy**: Imagine switches sending postcards to each other saying "I'm here, I'm this powerful, here's my ID." These are BPDUs—the gossip network uses to organize itself.

**Definition**: A [[BPDU|Bridge Protocol Data Unit]] is a special [[frame|frame]] that [[switch|switches]] send every 2 seconds to announce their presence, priority, and [[MAC address]]. STP uses BPDUs to elect a [[root bridge]] and determine which ports to block.

```
BPDU contents:
- Bridge ID (priority + MAC address)
- Root Bridge ID
- Cost to Root Bridge
- Port ID
- Message Age
- Maximum Age
- Hello Time
- Forward Delay
```

**Related**: [[Hello BPDU]], [[Configuration BPDU]], [[Topology Change Notification]]

### Root Bridge
**Analogy**: The root bridge is like a town's town hall—all navigation decisions radiate from it. Choose the smallest town (lowest priority), and everyone knows where to reference.

**Definition**: The [[root bridge]] is the central reference point in a [[spanning tree]]. It's elected by comparing [[Bridge ID|Bridge IDs]]; the switch with the **lowest priority** (default 32768) becomes root. All other switches calculate the shortest path back to it.

**Election process**:
1. All switches start by claiming to be the root (sending BPDUs with self as root)
2. Switches compare incoming BPDU root IDs with their own
3. If received BPDU has lower Bridge ID, that becomes the new root
4. Lowest Bridge ID wins root election
5. Root bridge stops accepting BPDUs about other roots

**Related**: [[Bridge ID]], [[priority value]], [[cost to root]]

### Path Cost
**Analogy**: Imagine maps showing distance in miles. STP maps show distance in "link costs"—prefer the shorter path to the root.

**Definition**: [[Cost to root|Path cost]] is a value assigned to each [[switch port]] link based on bandwidth. Lower cost = faster link = better path to [[root bridge]]. STP uses cumulative costs to determine which ports block.

| Link Speed | Cost |
|------------|------|
| 10 Mbps | 100 |
| 100 Mbps | 19 |
| 1 Gbps | 4 |
| 10 Gbps | 2 |

**Related**: [[root port]], [[designated port]]

### Root Port
**Analogy**: If the root bridge is the town hall, the root port is the main road leading toward it—every non-root switch has exactly one.

**Definition**: The [[root port]] is the single [[switch port]] on each non-root switch that has the **lowest cost path back to the root bridge**. This port forwards traffic destined for the root and is always in [[forwarding|forwarding state]].

**Related**: [[designated port]], [[non-designated port]], [[blocked port]]

### Designated Port
**Analogy**: On a segment between two switches, one port is the "gatekeeper"—it forwards traffic; the other blocks it.

**Definition**: A [[designated port]] is the port on a [[network segment]] with the **lowest cost to the root bridge**. It's permitted to forward traffic on that segment. Every segment has exactly one designated port; the opposite end is [[blocked|blocked]].

**Related**: [[root port]], [[alternate port]]

---

## Exam Tips

### Question Type 1: Identifying Loop Prevention
- *"A network administrator connects a backup cable between two switches for redundancy. Users report a broadcast storm. What protocol automatically prevents this?"* → **Spanning Tree Protocol (802.1d)**
- **Trick**: Don't confuse with [[VLAN|VLANs]] or [[RSTP]] (that's faster STP). The question tests whether you know STP prevents loops automatically.

### Question Type 2: Port State Sequence
- *"In what order do ports transition when STP initializes?"* → **Blocking → Listening → Learning → Forwarding**
- **Trick**: Common wrong answer: "Blocking → Forwarding" (skips learning phases). Each phase serves a purpose—you can't skip to forwarding immediately.

### Question Type 3: Root Bridge Election
- *"Two switches: Switch A (Priority 24576, MAC ending in :0A) and Switch B (Priority 32768, MAC ending in :0B). Which becomes root?"* → **Switch A** (lower priority wins, regardless of MAC)
- **Trick**: Students assume MAC address matters first. Priority is the **first** tiebreaker—MAC is only used if priorities are identical.

### Question Type 4: Port Roles
- *"Which port on a non-root switch has the lowest cost to the root bridge?"* → **Root Port**
- **Trick**: Don't confuse with [[designated port]]. Root port is always on the **non-root switch**; designated port is on any switch.

---

## Common Mistakes

### Mistake 1: Assuming All Redundant Paths Are Active
**Wrong**: "We'll plug in backup cables between all switches for full redundancy—more cables = more capacity."
**Right**: STP activates only ONE path per link segment. Redundant cables exist but sit in [[blocked|blocked state]] until needed. The "extra" cables don't increase bandwidth—they wait for failover.
**Impact on Exam**: Questions asking "how many paths are active?" expect you to subtract blocked ports. If you see a mesh topology with 3 switches (6 possible links), only 2 are active (a tree has N-1 edges for N nodes).

### Mistake 2: Confusing Port States with Packet Loss
**Wrong**: "A port in [[learning|learning state]] is broken because it's not forwarding."
**Right**: [[Learning|Learning state]] means the switch is actively building its [[MAC address table]] but not forwarding user data yet. This is temporary (typically 15 seconds) and is the correct behavior.
**Impact on Exam**: A scenario describing "ports slowly transitioning to forwarding" isn't a problem—it's STP working correctly. Identify it as [[normal STP convergence]], not a network failure.

### Mistake 3: Mixing Up BPDU Direction
**Wrong**: "The root bridge receives BPDUs from other switches to learn the network."
**Right**: The **root bridge sends BPDUs** (announcing itself); other switches receive and relay them downstream toward edge ports. BPDUs flow **away from** the root, not toward it.
**Impact on Exam**: Questions about "why a switch became root" should answer "it received the lowest Bridge ID in a BPDU" OR "it sent BPDUs and wasn't contradicted." Understand the message flow to eliminate wrong answers.

### Mistake 4: Forgetting STP Runs Continuously
**Wrong**: "We set up spanning tree once during installation, so we're done."
**Right**: STP sends [[hello BPDU|hello BPDUs]] every 2 seconds and recalculates if it detects topology changes (link down, new switch added). It's an ongoing process, not a one-time setup.
**Impact on Exam**: Scenarios like "a cable was unplugged and users lost connectivity for 30 seconds" → expect STP to detect the change, recompute, and restore paths. If it takes longer than [[max age]] (20 seconds), expect network disruption. This tests understanding of [[convergence time]].

---

## Related Topics
- [[IEEE 802.1d]]
- [[RSTP]] (Rapid Spanning Tree Protocol - faster version)
- [[MSTP]] (Multiple Spanning Tree Protocol - for VLANs)
- [[switch]], [[bridge]]
- [[Layer 2 switching]]
- [[broadcast storm]]
- [[network redundancy]]
- [[BPDU]]
- [[failover]]
- [[MAC address table]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*