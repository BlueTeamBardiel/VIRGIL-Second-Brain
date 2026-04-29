# Rapid Spanning Tree Protocol
**Why this matters:** RSTP reduces network convergence time from 50+ seconds (STP) to just a few seconds, making it essential for modern networks that can't tolerate extended outages.

## Overview

[[Rapid Spanning Tree Protocol]] (RSTP) is an evolution of the original [[Spanning Tree Protocol]] (STP) that solves a critical problem: when a link fails in a redundant network, the original STP takes far too long to detect the failure and converge on a new topology. RSTP reduces convergence time dramatically through faster failure detection and more aggressive topology recalculation.

**Simple analogy:** If STP is a postal worker who takes hours to notice a road is closed, RSTP is one with a radio who gets instant notifications and reroutes immediately.

---

## Core Difference: STP vs RSTP

### Why STP Is Slow

[[Spanning Tree Protocol]] uses timer-based failure detection. A port must wait for:
1. **Forward Delay** (default 15 seconds) × 2 = 30 seconds minimum
2. Plus **Max Age** timeout = another 20 seconds
3. **Total potential convergence:** 50+ seconds

This happens because STP has no way to actively confirm a link is down—it just waits for timers to expire.

### Why RSTP Is Fast

[[RSTP]] uses **active failure detection** and **rapid re-election**. When a topology change occurs, RSTP devices exchange [[BPDU]] (Bridge Protocol Data Unit) messages and agree on a new tree within seconds (typically 1-3 seconds).

---

## Key Concepts with Detail

### Port States: The Critical Difference

| Feature | [[STP]] | [[RSTP]] |
|---------|---------|----------|
| **Number of states** | 5 | 3 |
| | Disabled, Blocking, Listening, Learning, Forwarding | Discarding, Learning, Forwarding |
| **Convergence time** | 30-50+ seconds | 1-3 seconds |
| **Failure detection** | Timer-based (passive) | Proposal/agreement handshake (active) |
| **Port roles** | Root, Designated, Blocked | Root, Designated, Alternate, Backup |

**Deep dive:** RSTP collapses STP's 5 states into 3 because it doesn't need the intermediate Listening and Blocking states. A port either discards frames (Discarding), learns MAC addresses (Learning), or forwards (Forwarding).

### Port Roles in RSTP

RSTP introduces new port roles beyond STP's three:

| Role | Purpose | Behavior |
|------|---------|----------|
| **Root port** | Shortest path to root bridge | Forwards frames |
| **Designated port** | Best port on segment toward root | Forwards frames |
| **Alternate port** | *NEW:* Backup to root port (standby) | Discarding, ready to activate |
| **Backup port** | *NEW:* Backup to designated port | Discarding, rarely used |

The Alternate and Backup port roles are game-changers. Instead of waiting for timers to expire, these ports are **pre-calculated and ready to activate** the moment the primary path fails.

**Analogy:** STP is like having one route and hoping it works; RSTP is like knowing your alternate route before you even start driving.

---

## RSTP Proposal/Agreement Mechanism

This is how RSTP achieves rapid convergence:

### The Handshake (Simplified)

1. **Proposal:** A switch detects a topology change and sends a special BPDU to neighbors saying "I think this port should be designated"
2. **Sync:** The neighbor acknowledges and blocks other ports temporarily (prevents loops)
3. **Agreement:** After verifying the proposal doesn't create a loop, the neighbor agrees
4. **Activation:** The port moves to Forwarding within milliseconds

This entire handshake happens in seconds, not minutes.

### Link Types and RSTP Speed

RSTP differentiates link types to optimize convergence:

| Link Type | Topology | Convergence Speed |
|-----------|----------|-------------------|
| **Point-to-Point** | Direct switch-to-switch link (full-duplex) | Fastest (sub-second) |
| **Shared** | Hub or collision domain | Slower, acts like STP |
| **Edge** | End-device port (via PortFast) | Immediate (no convergence needed) |

**Critical detail:** Point-to-point links enable the proposal/agreement handshake. If RSTP detects half-duplex operation, it **downgrades to STP behavior** automatically—this is a common pitfall.

---

## RSTP Port Costs (IEEE 802.1D-2004)

RSTP updated the cost values from original STP:

| Bandwidth | STP Cost | RSTP Cost |
|-----------|----------|-----------|
| 10 Mbps | 100 | 2,000,000 |
| 100 Mbps | 19 | 200,000 |
| 1 Gbps | 4 | 20,000 |
| 10 Gbps | N/A | 2,000 |
| 100 Gbps | N/A | 200 |

RSTP costs are much larger to accommodate higher-speed links that didn't exist when STP was designed. Use the formula: **Cost = 20,000,000,000 ÷ bandwidth in bps**

---

## RSTP Topology Change Handling

### Original STP Behavior
When a topology change is detected, STP:
- Floods topology change notification (TCN) BPDU to root
- Root acknowledges and initiates re-election
- All switches flush MAC address tables
- Entire process takes 30+ seconds

### RSTP Behavior
When a topology change is detected:
- The affected port immediately begins forwarding (if it's Alternate port becoming Root)
- Only MAC addresses associated with that port are aged out (faster recovery)
- Surrounding switches converge independently without waiting for root acknowledgment
- Process completes in 1-3 seconds

**Why this matters for CCNA:** RSTP doesn't flood the entire network with change notifications. It's **localized convergence**—changes ripple through the topology naturally as devices exchange BPDUs.

---

## RSTP Enhanced Features

### Root Guard

**Purpose:** Prevent a switch from becoming the root bridge through misconfiguration or attack.

**Mechanism:** If a Root Guard-enabled port receives a BPDU claiming superior root priority, that port is moved to **Root Inconsistent state** and stops forwarding.

**Use case:** Configure on ports connected to access layer switches or edge devices that should never be root.

```
Switch(config-if)# spanning-tree guard root
```

### Loop Guard

**Purpose:** Prevent loops caused by unidirectional link failures (one direction of a link fails, other direction still works).

**Mechanism:** If a designated or root port stops receiving BPDUs from the upstream bridge, Loop Guard moves that port to Inconsistent state.

**Critical distinction from Root Guard:** Loop Guard protects against asymmetric link failures; Root Guard protects against root bridge hijacking.

**Use case:** Enable on all non-designated ports on switches with fiber links prone to uni-directional failures.

```
Switch(config-if)# spanning-tree guard loop
```

### BPDU Filter

**Purpose:** Stop a port from sending or receiving [[BPDU]] messages.

**Two modes:**
- **Global `spanning-tree portfast bpdu-filter default`:** Only filters on ports where PortFast is enabled
- **Per-interface:** Unconditionally disables BPDU processing (dangerous)

**Warning:** BPDU Filter with incorrect configuration can create bridging loops. Use conservatively.

```
Switch(config-if)# spanning-tree bpdufilter enable
```

---

## RSTP BPDUs and Messages

### BPDU Format
RSTP uses the same BPDU format as STP but reinterprets some flags:

| Flag Bits | RSTP Meaning |
|-----------|--------------|
| Topology Change (TC) | Indicates a topology change occurred |
| Proposal | "I propose this port should forward" |
| Port Role (2 bits) | Encodes port role: Root(1), Alternate(2), Designated(3) |
| Learning | Port is in Learning state |
| Forwarding | Port is in Forwarding state |
| Agreement | "I agree with your proposal" |

### BPDU Timers
RSTP dramatically simplified timers:

| Timer | Default | Purpose |
|-------|---------|---------|
| Hello | 2 seconds | BPDUs sent every 2 seconds |
| Forward Delay | 15 seconds | (Kept for backwards compatibility with STP) |
| Max Age | 20 seconds | BPDU expiration timer |

The **Hello timer is the most important**—a missed Hello triggers failure detection.

---

## Backward Compatibility: RSTP and STP Coexistence

### When RSTP Encounters STP

If an RSTP switch receives a **legacy STP BPDU** (different format), it automatically downgrades that port to **STP mode**. This port will now use STP timers and convergence behavior, slowing the entire affected branch.

### Identifying the Problem

Look for these symptoms in a mixed environment:
- Some switches converge quickly (RSTP peers)
- Others take 50+ seconds
- RSTP ports adjacent to STP ports behave like STP

**Exam tip:** Questions about mixed STP/RSTP networks test whether you understand that the slowest protocol wins.

---

## Lab Relevance

### Essential Cisco IOS Commands

#### Enabling RSTP

```
Switch(config)# spanning-tree mode rapid-pvst
```
**Note:** `pvst+` is STP; `rapid-pvst` is RSTP. This is the most fundamental command for this chapter.

#### Verifying RSTP Status

```
Switch# show spanning-tree
Switch# show spanning-tree brief
Switch# show spanning-tree vlan 10
Switch# show spanning-tree interface fa0/1 detail
```

**What to look for in output:**
- "Rapid PVST+" in header confirms RSTP is running
- Port roles listed as Root, Designated, Alternate, Backup
- Port states as Discarding, Learning, Forwarding
- No mention of "Blocking" or "Listening" states

#### Configuring Port Costs

```
Switch(config-if)# spanning-tree cost 20000
```
Or for specific VLAN:
```
Switch(config-if)# spanning-tree vlan 10 cost 20000
```

#### Configuring Port Priority

```
Switch(config-if)# spanning-tree port-priority 128
Switch(config-if)# spanning-tree vlan 10 port-priority 96
```
Lower priority = higher preference for designated/root port

#### Setting Root Bridge

```
Switch(config)# spanning-tree vlan 10 root primary
Switch(config)# spanning-tree vlan 10 root secondary
```

#### Enabling PortFast (Critical for RSTP)

```
Switch(config-if)# spanning-tree portfast
```
Or globally for all access ports:
```
Switch(config)# spanning-tree portfast default
```

#### BPDU Guard with PortFast

```
Switch(config-if)# spanning-tree bpduguard enable
Switch(config)# spanning-tree portfast bpduguard default
```

When BPDU Guard detects an unexpected BPDU on a PortFast port, it disables that interface (err-disabled state).

#### Enabling Root Guard

```
Switch(config-if)# spanning-tree guard root
```

#### Enabling Loop Guard

```
Switch(config-if)# spanning-tree guard loop
```

#### Configuring BPDU Filter

```
Switch(config-if)# spanning-tree bpdufilter enable
Switch(config)# spanning-tree portfast bpdufilter default
```

#### Recovery from Err-Disabled State

```
Switch(config)# errdisable recovery cause bpduguard
Switch(config)# errdisable recovery interval 30
```

#### Checking Spanning Tree Statistics

```
Switch# show spanning-tree statistics
Switch# show spanning-tree statistics interface fa0/1
```

---

## Exam

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 15 | [[CCNA]]*