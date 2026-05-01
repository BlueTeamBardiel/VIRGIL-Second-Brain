# Rapid Spanning Tree Protocol
**Why this matters:** RSTP reduces network convergence time from 50+ seconds (STP) to just a few seconds, making it essential for modern networks that can't tolerate extended outages.

## Overview

[[Rapid Spanning Tree Protocol]] (RSTP) is an evolution of the original [[Rapid Spanning Tree Protocol]] (STP) that solves a critical problem: when a link fails in a redundant network, the original STP takes far too long to detect the failure and converge on a new topology. RSTP reduces convergence time dramatically through faster failure detection and more aggressive topology recalculation.

**Simple analogy:** If STP is a postal worker who takes hours to notice a road is closed, RSTP is one with a radio who gets instant notifications and reroutes immediately.

---

## Core Difference: STP vs RSTP

### Why STP Is Slow

[[Rapid Spanning Tree Protocol]] uses timer-based failure detection. A port must wait for:
1. **Forward Delay** (default 15 seconds) × 2 = 30 seconds minimum
2. Plus **Max Age** timeout = another 20 seconds
3. **Total potential convergence:** 50+ seconds

This happens because STP has no way to actively confirm a link is down—it just waits for timers to expire.

### Why RSTP Is Fast

[[RSTP]] uses **active failure detection** and **rapid re-election**. When a topology change occurs, RSTP devices exchange [[BPDU]] (Bridge Protocol Data Unit) messages and agree on a new tree within seconds (typically 1-3 seconds).

---

## Key Concepts with Detail

### Port States: The Critical Difference

| Feature | [[RSTP]] | [[RSTP]] |
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


<!-- merged from: Spanning Tree Protocol.md -->

# Spanning Tree Protocol

**Tagline:** Understanding how STP prevents Layer 2 loops while maintaining redundancy is critical for switch configuration and network reliability.

---

## Why STP Matters

Layer 2 switching has a fundamental problem: **redundancy creates loops**. Unlike [[IPv4]] routers that use the [[TTL]] field to prevent infinite packet circulation, Ethernet frames have no such protection. When broadcast, unknown unicast, and multicast ([[BUM Traffic]]) frames flood through switches with multiple paths between devices, they loop indefinitely—causing **broadcast storms** and **MAC address flapping** that can disable an entire LAN in seconds.

STP solves this by selectively blocking redundant ports, creating a loop-free logical topology while keeping backup paths available for failover. This is foundational to CCNA exam topic 2.5 (Rapid PVST+) and appears on every network technician certification.

---

## Core Problem: Layer 2 Loops



### Why Loops Occur

Think of it like a rumor spreading through a group of people standing in a circle. If person A tells persons B and C simultaneously, and they each tell the others, the same message bounces around indefinitely. In a switched network:

1. **Switch floods BUM traffic** to all ports except the source
2. **Multiple physical paths exist** between switches (desired for redundancy)
3. **Flooded frames return on different ports**, causing switches to relearn MAC addresses constantly
4. **Loop persists** because Ethernet frames have no loop-prevention field

**Detail:** Unlike IP packets (which die when TTL reaches 0), Ethernet frames recirculate because:
- The Ethernet header has no TTL equivalent
- Switches forward broadcast frames out all ports
- Each switch sees the same frame arriving from different directions and re-floods it

### Consequences of Layer 2 Loops

| Problem | Impact |
|---------|--------|
| **Broadcast Storm** | Looping frames consume CPU and bandwidth; network becomes unusable within seconds |
| **MAC Address Flapping** | Same MAC learned on multiple ports; switch can't deliver unicast frames to correct port |
| **Resource Exhaustion** | End hosts receive duplicate frames repeatedly; their NICs overwhelmed |

---

## How STP Works: The Fundamental Mechanism



### Simple Explanation

STP works like a traffic manager preventing cars from circling a block infinitely: it **blocks one link in every loop**, leaving exactly one active path between any two switches.

### Detailed Operation

STP creates a **loop-free logical topology** by:

1. **Selecting a Root Bridge** — One switch becomes the reference point
2. **Calculating shortest paths** — From all other switches to the Root Bridge
3. **Blocking redundant ports** — Ports not on the shortest path are moved to BLOCKING state
4. **Maintaining standby paths** — Blocked ports reactivate if active links fail

The physical topology may be a full or partial mesh; STP's logical topology is always a **spanning tree** (mathematical term: a subgraph connecting all nodes with exactly one path between any two nodes, no loops).

**Figure Reference:** In a 3-switch ring topology with PC1 sending a broadcast:
- **Without STP:** Frame loops clockwise AND counterclockwise indefinitely
- **With STP:** One inter-switch link is blocked; frame travels one direction only

---

## STP Port States and Roles



### Port States (Operational States)

These describe what a port does with frames:

| State | Forwards Data | Processes BPDUs | Learns MAC | Duration | Purpose |
|-------|---------------|-----------------|-----------|----------|---------|
| **Blocking** | ❌ | ✓ | ❌ | Until topology change | Prevents loops; stays in blocked state indefinitely |
| **Listening** | ❌ | ✓ | ❌ | 15 sec (default) | Transition state; listening for BPDUs to ensure no loops |
| **Learning** | ❌ | ✓ | ✓ | 15 sec (default) | Transition state; building MAC table before forwarding |
| **Forwarding** | ✓ | ✓ | ✓ | Active | Normal operation; actively carrying traffic |
| **Disabled** | ❌ | ❌ | ❌ | Indefinite | Admin shutdown or port error |

**Port State Transitions:**
```
BLOCKING → LISTENING → LEARNING → FORWARDING
         (15 sec)    (15 sec)
```

Convergence from blocking to forwarding takes **30-50 seconds** by default (Listening + Learning + buffer time).

### Port Roles (Functional Roles)

Each port plays a specific role in the STP topology:

| Role | Election Basis | Behavior | Count per Bridge |
|------|---------------|---------:|--:|
| **Root Port** | Lowest cost path to Root Bridge | Forwards frames toward root | 1 per non-root bridge |
| **Designated Port** | Lowest cost from this switch toward root | Forwards toward leaves of tree | Multiple (1+ per segment) |
| **Non-Designated Port** | Loses to designated port on same segment | Blocked; prevents loops | Varies |

**Election Logic:**
- Every switch calculates the cost to reach the **Root Bridge**
- On each link segment, the **Designated Port** (lower cost) wins; the other port blocks
- The Root Bridge's ports are always **Designated Ports** (cost 0 from root)

---

## STP Bridge Protocol Data Units (BPDUs)



### What BPDUs Are

[[Bridge Protocol Data Units]] are STP messages sent by switches to:
- Elect the Root Bridge
- Calculate port costs and roles
- Detect topology changes
- Maintain the spanning tree

### BPDU Contents

Every BPDU contains:
- **Root Bridge ID** — BridgeID of the current root
- **Root Path Cost** — Total cost from sender to root
- **Sender Bridge ID** — ID of switch sending this BPDU
- **Sender Port ID** — Port from which BPDU is sent
- **Timer values** — Hello, Forward Delay, Max Age

### Default BPDU Transmission

| Parameter | Default Value |
|-----------|---------------|
| **Hello Time** | 2 seconds (interval between BPDUs) |
| **Forward Delay** | 15 seconds (listening + learning) |
| **Max Age** | 20 seconds (how long to believe a BPDU) |

**Important:** BPDUs are sent to MAC address `01:80:c2:00:00:00` at layer 2; they're never routed.

---

## Root Bridge Election



### Election Criteria (In Order)

| Priority | Criterion | Winner |
|----------|-----------|--------|
| 1 | **Lowest Bridge Priority** | Default 32768 on all Cisco switches |
| 2 | **Lowest MAC Address** | Tie-breaker; compares burned-in addresses |

**In Practice:** Since all switches default to priority 32768, the switch with the lowest MAC address becomes Root Bridge. To force a switch to be root, **reduce its priority** (e.g., `0`, `4096`, `8192`).

### Bridge ID Structure

```
[2-byte Priority] [6-byte MAC Address]
   32768          |  aabb.ccdd.eeff
```

Example: Default Bridge ID `8000.0000.1111.2222` means priority 32768, MAC 0000.1111.2222.

---

## Port Cost and Path Cost



### Port Cost (Interface Cost)

Cost is assigned to each port based on link speed. Frames prefer lower-cost paths.

| Link Speed | STP Cost (802.1D-1998) | Modern Cost (802.1D-2004) |
|------------|----------------------:|------------------------:|
| 10 Mbps | 100 | 2,000,000 |
| 100 Mbps | 19 | 200,000 |
| 1 Gbps | 4 | 20,000 |
| 10 Gbps | 2 | 2,000 |

**Root Path Cost:** Sum of all port costs from a switch to the Root Bridge.

**Example:** If a switch is 3 hops away from root via Gigabit links:
```
Root Path Cost = 4 + 4 + 4 = 12
```

**Key Point:** STP prefers **shorter paths** (fewer hops or faster links) because they have lower cumulative cost.

---

## Designated Port Election on a Segment

When two ports connect to the same segment, one becomes **Designated Port** (forwards), the other **Non-Designated Port** (blocks). The decision process:

1. **Lower Root Path Cost** — Port closer to root wins
2. **Tie:** **Lower Sender Bridge ID** — The switch closer to root wins
3. **Tie:** **Lower Sender Port ID** — The specific port on that switch wins

**Example Scenario:**
- SW1 (Root Path Cost 0, priority 32768, MAC 1111): G0/0 on shared segment
- SW2 (Root Path Cost 4, priority 32768, MAC 2222): G0/0 on shared segment

**Result:** SW1's G0/0 is Designated Port (cost 0 < 4); SW2's G0/0 is Non-Designated Port (blocked).

---

## Convergence: How Fast Does STP React?



### Convergence Time (Standard 802.1D STP)

**Default behavior:** 30-50 seconds from topology change to fully forwarding

| Phase | Duration | What Happens |
|-------|----------|---|
| **Listening** | 15 sec | Port waits to see if it should block; no MAC learning |
| **Learning** | 15 sec | Port builds MAC address table; still no frame forwarding |
| **Forwarding** | Immediate | Port becomes active |
| **Total** | ~30 sec | User experiences outage during this period |

**Why so long?** The timers prevent temporary link flaps from destabilizing the tree. If a port bounced up and down, STP would repeatedly reconverge.

### Problem: Convergence Time is Unacceptable

30 seconds is an eternity for modern applications:
- VoIP calls drop
- TCP sessions timeout
- SAN devices lose connectivity

**Solution to follow:** [[Rapid Spanning Tree Protocol]] (RSTP / 802.1w) converges in **milliseconds**.

---

## PortFast: Accelerating Edge Port Convergence



### What PortFast Does

**PortFast skips Listening and Learning states for ports connected to end devices**, moving directly to Forwarding.

**Simple Explanation:** PortFast is a shortcut that says, "This port connects to a PC/printer, not another switch—let it forward immediately without waiting 30 seconds."

### Why PortFast is Safe

- **Loops impossible:** Only switches generate loops; end devices don't repeat BPDUs
- **No MAC flapping risk:** No loops means MAC addresses don't flap
- **Still receives STP protection:** Port still processes BPDUs and will block if a loop is detected

### PortFast Configuration

```ios
! Enable PortFast on a single interface
interface GigabitEthernet 0/1
  spanning-tree portfast

! Enable PortFast globally for all access ports
spanning-tree portfast default

! Verify PortFast status
show spanning-tree interface GigabitEthernet 0/1 portfast
```

**Output Example:**
```
PortFast : enabled
```

### BPDU Guard (Protection Against Misconfiguration)

If a user plugs a switch into a PortFast port, disaster could happen. **BPDU Guard shuts down the port if a BPDU is received.**

```ios
! Enable BPDU Guard on a port
interface GigabitEthernet 0/1
  spanning-tree bpduguard enable

! Enable BPDU Guard for all PortFast ports globally
spanning-tree portfast bpduguard default

! Port will enter errdisabled state; recover with:
shutdown
no shutdown
```

---

## STP Topology Change Handling



### What Triggers a Topology Change?

- Link failure (switch port goes down)
- New switch added to network
- Port moves to Forwarding state (except Root Bridge ports)

### How STP Reacts to Changes

1. **Bridge detects

---
*Source: Acing the CCNA Exam, Volume 1, Chapter 14 | [[CCNA]]*
