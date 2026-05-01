---
tags: [knowledge, ccna, chapter-13]
created: 2026-04-30
cert: CCNA
chapter: 13
source: rewritten
---

# 13. Spanning Tree Protocol
**A dynamic method for preserving network redundancy while preventing Layer 2 loops**

---

## Why STP Exists

### Flooding & Loop Problems

**Analogy**: Picture a town where every street has a billboard that automatically repeats any message it sees; if the town is arranged in a circle, the message will endlessly loop around, tiring everyone and clogging the roads.

**Flooding**: In Ethernet, broadcast, unknown unicast, and multicast frames are duplicated and sent out every port except the one that received them.  
[[Flooding]] and the absence of a hop counter mean a single loop causes frames to circulate indefinitely, saturating switch CPUs and making MAC tables unstable.

### The Need for a Loop‑Free Path

**Analogy**: Imagine a road network with multiple bypass roads. You want to keep all the roads available for emergency traffic but make sure everyday traffic never takes a circular route that would trap cars.

**Spanning Tree Protocol (STP)**: Provides a way for switches to elect a single root bridge and block unnecessary links so that there is exactly one forwarding path between any two devices.  
[[STP]] keeps backup links alive at the port level, allowing rapid fail‑over without creating loops.

---

## What STP Actually Does

### Root Bridge Election

**Analogy**: Think of a town hall meeting where each council member proposes a candidate; the member with the most votes (lowest priority number) becomes the mayor.

**Root Bridge**: The switch with the lowest Bridge ID (BID) is selected as the central point from which all other switches calculate their best paths.  
[[Root Bridge]].

| Attribute | Value | Effect |
|-----------|-------|--------|
| Bridge Priority | 32768 (default) | Lower numbers win |
| MAC Address | 48‑bit unique | Ties broken by lowest MAC |

### Path Cost Calculation

**Analogy**: Driving from home to work: the fastest route (highway) has a lower “cost” than a winding mountain road.

**Path Cost**: Inverse of link speed; the total cost from a switch to the root is the sum of all link costs on that path. The lower the cost, the more preferred the path.  

| Speed | Standard Cost |
|-------|---------------|
| 10 Mbps | 100 |
| 100 Mbps | 19 |
| 1 Gbps | 4 |
| 10 Gbps | 2 |

---

## Core STP Terminology

| Term | Explanation |
|------|-------------|
| **Bridge** | Synonym for a switch (legacy term). [[Bridge]] |
| **Segment** | A Layer 2 link between two devices. [[Segment]] |
| **Collision Domain** | One per switch port in modern Ethernet. [[Collision Domain]] |
| **Spanning Tree** | A loop‑free subset of the network’s physical topology. [[Spanning Tree]] |

---

## Bridge Protocol Data Units (BPDUs)

### What a BPDU Is

**Analogy**: Picture a postal service that sends out “status letters” to all post offices, telling them which route is the main one and who’s in charge.

**BPDU (Bridge Protocol Data Unit)**: A control frame that switches exchange to share topology info, elect the root, and determine port roles. These frames never carry user data. [[BPDU]].

### BPDU Destination MAC Addresses

| Vendor | Destination MAC |
|--------|-----------------|
| Cisco PVST+ | `0100.0ccc.cccd` |
| IEEE 802.1D (STP) | `0180.c200.0000` |

Routers do not forward BPDUs. [[Router]].

### BPDU Transmission Rules

| Situation | Sending Behavior |
|-----------|------------------|
| Switch booting | Sends BPDUs on all ports |
| After convergence | Only the root bridge originates BPDUs; others forward only on designated ports |
| Root or blocked ports | Receive BPDUs but do not forward |

---

## Bridge ID (BID) & Root Bridge Election

### BID Structure

**Analogy**: Think of a government ID card that contains both a rank number and a unique personal identifier; the combination determines authority.

**BID**: A 64‑bit value consisting of a 16‑bit priority and a 48‑bit MAC address. Lower values win during election.  
In PVST+, priority is split into a 4‑bit configurable priority and a 12‑bit VLAN ID.

---

## STP Algorithm Steps

### Step 1 – Root Bridge Election

The switch with the lowest BID becomes the root. Tie‑breakers: lowest priority, then lowest MAC.

### Step 2 – Root Port Selection

Applicable to non‑root switches: each picks one port that offers the best path to the root.

**Tie‑breakers**:  
1. Lowest root path cost  
2. Lowest sending BID  
3. Lowest sending port ID

### Step 3 – Designated Port Selection

For each segment, one port is chosen as designated. It forwards traffic; the others are non‑designated (blocked).

---

## STP Port Roles

| Role | Short Code | Function |
|------|------------|----------|
| Root Port (R) | R | Forwarding port closest to root |
| Designated Port (D) | D | Forwarding port on a segment |
| Non‑Designated (N) | N | Blocked, no forwarding |

Blocked ports still listen for BPDUs and may move to forwarding if the topology changes.

---

## STP Port States (802.1D)

| State | Description |
|-------|-------------|
| **Blocking** | No data forwarding; learns no MACs; receives BPDUs. |
| **Listening** | Transitional (15 s); exchanges BPDUs, no forwarding, no learning. |
| **Learning** | Transitional (15 s); learns MACs, no forwarding. |
| **Forwarding** | Stable; forwards frames, learns MACs, exchanges BPDUs. |
| **Disabled** | Admin shut down; no STP activity. |

---

## STP Timers

| Timer | Default | Purpose |
|-------|---------|---------|
| Hello | 2 s | Root sends BPDUs every 2 s. |
| Forward Delay | 15 s | Length of Listening and Learning. |
| Max Age | 20 s | Time a port waits after losing a BPDU before recalculating. |

All timers are set on the root bridge and applied network‑wide.

**Convergence Time**  
When a forwarding link fails:  
1. 20 s Max Age → detect loss  
2. 15 s Listening  
3. 15 s Learning  
4. Forwarding → ≈ 50 s total.  
This explains why classic STP can take up to a minute to recover. [[Convergence]].

---

## Exam Tips

### Question Type 1: Root Bridge Selection
- *"Which switch will become the root if two switches have identical priorities but different MAC addresses?"* → The switch with the lower MAC address wins.  
- **Trick**: Many students think priority alone decides; remember MAC ties break the election.

### Question Type 2: Path Cost Comparison
- *"If a 1 Gbps link and a 10 Mbps link connect a switch to the root, which link will STP prefer?"* → The 1 Gbps link (lower cost of 4 vs. 100).  
- **Trick**: Don’t confuse speed with cost; higher speed equals lower cost.

---

## Common Mistakes

### Mistake 1: Believing STP Eliminates Redundancy
**Wrong**: STP removes all backup links permanently.  
**Right**: STP blocks only redundant *paths* while keeping all links active for rapid fail‑over.  
**Impact on Exam**: Misunderstanding can lead to wrong answers about network design and troubleshooting.

### Mistake 2: Assuming All BPDUs Are Forwarded by Every Switch
**Wrong**: Every switch forwards every BPDU on all ports.  
**Right**: Only the root originates BPDUs; other switches forward only on designated ports; root/blocked ports never forward.  
**Impact on Exam**: Incorrect knowledge about BPDU flow can affect questions on topology changes.

---

## Related Topics
- [[VLAN]]
- [[Ethernet]]
- [[Layer 2 Switching]]

---

*Source: CCNA 200‑301 Study Notes | [[CCNA]]*