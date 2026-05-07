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