# EtherChannel
**Combine multiple physical links into a single logical link to maximize bandwidth while preventing Layer 2 loops**

---

## Why This Matters for CCNA

EtherChannel solves a critical networking problem: [[Spanning Tree Protocol|STP]] blocks redundant links to prevent Layer 2 loops, leaving extra bandwidth unused. EtherChannel allows multiple physical ports to work together as one logical unit, keeping all links active while STP still prevents loops at the logical level. This is **CCNA exam topic 2.4** and appears in both configuration and troubleshooting questions.

---

## Core Concept: The Bottleneck Problem

**Simple version:** Imagine a highway with one active lane between two cities. You add three more lanes, but traffic still backs up because a traffic controller (STP) keeps those extra lanes closed to prevent crashes. EtherChannel tells the controller: "These four lanes are really one highway—open them all."

**Detailed version:** In Figure 16.1, two switches connected by four 1 Gbps links should have 4 Gbps of capacity between them. However, [[Spanning Tree Protocol|STP]] blocks all redundant links to avoid Layer 2 loops, leaving only a single active link. This wastes bandwidth despite having multiple physical connections. [[EtherChannel]] solves this by telling STP: "Treat these four ports as one logical port (Po1)." Now all four links can forward traffic simultaneously without creating loops, because STP sees them as a single entity.

### How EtherChannel Prevents Loops

When a broadcast frame enters an [[EtherChannel]]:
- The sending switch floods it out **one** physical port in the channel
- The receiving switch receives it on that port
- The receiving switch **does not flood it back** out other ports in the same channel (because they're logically the same interface)
- Result: No loop, all links active

---

## Key Benefits of EtherChannel

| Benefit | Explanation |
|---------|-------------|
| **Bandwidth aggregation** | Combine 4 × 1 Gbps links = 4 Gbps logical link |
| **Redundancy without STP overhead** | All links stay active; STP doesn't block redundant channels |
| **Load balancing** | Traffic distributed across member ports |
| **Simplified management** | Configure one logical interface instead of four physical ones |
| **Improved resilience** | Link failure only reduces bandwidth, doesn't require STP reconvergence |

---

## EtherChannel Architecture

### Port Channel Interfaces

Cisco calls the logical interface a **port channel** (abbreviated `Po`). Examples: `Po1`, `Po2`, `Po3`.

### Important Constraint: STP Still Required in Larger Networks

EtherChannel does **not** eliminate the need for [[Spanning Tree Protocol|STP]]. In a topology with multiple switches connected by EtherChannels, some EtherChannels may still be blocked by STP to prevent loops at the network level (see Figure 16.4). The difference: without EtherChannel, 10 physical links might have only 3 active; with EtherChannel, 6 of 10 links stay active because STP blocks at the logical channel level, not the physical port level.

### STP Behavior with EtherChannel

When showing STP output, **only port channel interfaces appear**—never the individual member ports:

```
SW1# show spanning-tree
Interface    Role Sts Cost    Prio.Nbr Type
Po1          Root FWD 3       128.65   P2p
Po2          Altn BLK 3       128.66   P2p
```

**Important:** Port channel STP cost is calculated from the **combined bandwidth** of member ports. Four 1 Gbps ports = 4 Gbps total, so the cost is lower than a single 1 Gbps port's cost of 4; the cost becomes 3 (STP cost formula: 40,000 Mbps ÷ 4,000 Mbps = 10, but port channels use a different calculation).

---

## EtherChannel Configuration Methods

### Overview Table

| Method | Protocol | Negotiation | Cisco-Proprietary | Configuration Style |
|--------|----------|-------------|-------------------|----------------------|
| **Dynamic** | [[LACP]] (Link Aggregation Control Protocol) | Yes, automatic | No (IEEE 802.3ad standard) | `channel-group # mode active/passive` |
| **Dynamic** | [[PAgP]] (Port Aggregation Protocol) | Yes, automatic | Yes (Cisco proprietary) | `channel-group # mode desirable/auto` |
| **Static** | None | No, manual | N/A | `channel-group # mode on` |

---

## Dynamic EtherChannel with LACP

[[LACP]] (Link Aggregation Control Protocol) is the **IEEE standard** protocol for negotiating EtherChannel formation.

### LACP Modes

- **`active`**: Switch actively sends LACP packets; will form EtherChannel with another `active` or `passive` port
- **`passive`**: Switch listens for LACP packets; will form EtherChannel **only if the other side is `active`**

### Key Rule: LACP Mode Combinations

| Local Mode | Remote Mode | Result |
|-----------|------------|--------|
| `active` | `active` | ✓ EtherChannel forms |
| `active` | `passive` | ✓ EtherChannel forms |
| `passive` | `passive` | ✗ No EtherChannel (neither initiates) |
| `passive` | Down/missing | ✗ No EtherChannel |

**Mnemonic:** "At least one `active` must be present for LACP to negotiate."

---

## Dynamic EtherChannel with PAgP

[[PAgP]] (Port Aggregation Protocol) is Cisco's **proprietary** predecessor to LACP.

### PAgP Modes

- **`desirable`**: Switch actively sends PAgP packets; will form EtherChannel with another `desirable` or `auto` port
- **`auto`**: Switch listens for PAgP packets; will form EtherChannel **only if the other side is `desirable`**

### Key Rule: PAgP Mode Combinations

| Local Mode | Remote Mode | Result |
|-----------|------------|--------|
| `desirable` | `desirable` | ✓ EtherChannel forms |
| `desirable` | `auto` | ✓ EtherChannel forms |
| `auto` | `auto` | ✗ No EtherChannel (neither initiates) |

**Mnemonic:** "At least one `desirable` must be present for PAgP to negotiate."

---

## Static EtherChannel

No protocol negotiation; ports are **forced** into EtherChannel mode.

### Configuration Style

```
interface range G0/0 - 3
 channel-group 1 mode on
```

### When to Use Static EtherChannel

- Connecting to non-Cisco devices (may not support LACP or PAgP)
- Connecting to older Cisco devices without dynamic protocol support
- When you want absolute certainty and manual control (rare in modern networks)

### Warning: Misconfiguration Risk

If one side is `on` and the other side is `active` or `desirable`, the channel will **not form**, and you may not receive clear error messages. Always verify with `show etherchannel summary`.

---

## Lab Relevance: Essential IOS Commands

### Configuration Commands

**Enable LACP on a port:**
```
interface G0/0
 channel-group 1 mode active
```

**Enable PAgP on a port (older):**
```
interface G0/0
 channel-group 1 mode desirable
```

**Force static EtherChannel:**
```
interface G0/0
 channel-group 1 mode on
```

**Configure multiple ports at once:**
```
interface range G0/0 - 3
 channel-group 1 mode active
```

**Configure port channel interface itself (IP address, description, etc.):**
```
interface Po1
 description EtherChannel to SW2
 switchport mode trunk
 ip address 10.1.1.1 255.255.255.0
```

### Verification Commands

**Show EtherChannel summary (most useful):**
```
SW1# show etherchannel summary
Flags:  D - down        P - bundled in port-channel
        I - stand-alone p - suspended
        H - Hot-standby (LACP only)
        R - Layer3      S - Suspended

Group  Port-channel  Protocol    Ports
------+-------------+-----------+-----------------------------------------------
1      Po1(SU)       LACP        Gi0/0(P)   Gi0/1(P)   Gi0/2(P)   Gi0/3(P)

Key: (SU) = Port-channel is Up
     (P) = Port bundled in port-channel
```

**Show detailed EtherChannel information:**
```
SW1# show etherchannel 1 detail
Group: 1
----------
Group state = L2
Ports: 4   Maxports = 8
Port-channels: 1 Max Port-channels = 16
Protocol:   LACP
Minimum links: 0

Members:
        EthCh  Status    EC #
 Gi0/0   allocated     Gi0/1(P)
 Gi0/1   allocated     Gi0/0(P)
 Gi0/2   allocated     Gi0/0(P)
 Gi0/3   allocated     Gi0/0(P)
```

**Show port channel interface status:**
```
SW1# show interface Po1
Port-channel1 is up, line protocol is up
  Hardware is EtherChannel, address is aabb.cc00.0100
  MTU 1500 bytes, BW 4000000 Kbit/sec
```

**Show individual member port status:**
```
SW1# show interface G0/0
GigabitEthernet0/0 is up, line protocol is up
  Hardware is Gigabit Ethernet, address is aabb.cc00.0001
  Encapsulation ARPA, loopback not set
```

**Verify load balancing configuration:**
```
SW1# show etherchannel load-balance
EtherChannel Load-Balancing Configuration:
        src-mac

EtherChannel Load-Balancing Addresses used per protocol:
Non-IP: Source MAC address
  IPv4: Source MAC address
  IPv6: Source MAC address
```

**Show protocol-specific details (LACP):**
```
SW1# show lacp 1 detail
```

---

## Load Balancing / Load Distribution

### The Problem It Solves

Once an EtherChannel is created, how does the switch decide which physical link to use for each frame?

### How It Works: Hash Algorithm

EtherChannel uses a **hash algorithm** to map each frame to a specific physical port. The switch takes certain fields from the frame header (source MAC, destination MAC, source IP, destination IP, etc.), performs a calculation, and the result determines which member port gets the frame.

### Key Principle: Per-Flow Load Balancing

- Load balancing is **per-flow**, not per-frame
- A single conversation (flow) between two hosts always uses the **same physical port** to avoid out-of-order delivery
- Different conversations can use different ports

### Load Balancing Methods (Platform Dependent)

| Method | What It Uses | When Active |
|--------|-------------|------------|
| `src-mac` | Source MAC address only | Default on many switches |
| `dst-mac` | Destination MAC address only | Less common |
| `src-dst-mac` | Both source and destination MACs | Common |
| `src-ip` | Source IP address only | Layer 3 EtherChannels |
| `dst-ip` | Destination IP address only | Layer 3 EtherChannels |
| `src-dst-ip` | Both source and destination IPs | Layer 3 EtherChannels |

**Check your switch's load-balancing method:**
```
SW1# show etherchannel load-balance
```

**Change load-balancing method:**
```
SW1# port-channel load-balance src-dst-ip
```

### Load Balancing Reality

Even with 4 links, load distribution is **not always

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 16 | [[CCNA]]*
