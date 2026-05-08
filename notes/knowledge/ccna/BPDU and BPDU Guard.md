# BPDU and BPDU Guard

## What it is

In **Doom**, the automap constantly redraws itself as you explore — every room you enter pings the map, every corridor gets traced, and if two passages would create a loop back to a room you've already mapped, the game still knows the layout because it's tracking every connection. **BPDUs** are that same constant pinging on a switched network — the frames switches send each other every two seconds to map the topology, elect a root, and seal off any corridor that would loop back on itself.

A **Bridge Protocol Data Unit (BPDU)** is the Layer 2 multicast frame [[Spanning Tree Protocol]] uses to elect the [[Root Bridge]], compute path costs, and maintain a loop-free topology. **BPDU Guard** is a port-level safety mechanism that errdisables an access port the instant it receives any BPDU — the network equivalent of the BFG: one shot, the offending port is gone.

## Why it matters

Without [[STP]], a single mis-cabled switch creates a [[broadcast storm]] that melts the network in seconds — and yes, that has ended careers. BPDU Guard exists because end users plug rogue switches, home routers, and personal access points into wall jacks, and any of those can advertise a superior BPDU and steal the root bridge role — instantly rerouting traffic through a 100 Mbps consumer switch under someone's desk. On the CCNA, expect questions distinguishing **BPDU Guard** (hard disable on any BPDU) from **Root Guard** (soft block only on superior BPDUs).

## Key facts

### BPDU contents

A **Configuration BPDU** carries the fields STP needs to converge:

| Field | Purpose |
|---|---|
| **Root Bridge ID** | 8 bytes: 2-byte priority + 6-byte MAC of believed root |
| **Root Path Cost** | Cumulative cost to reach the root |
| **Sender Bridge ID** | Who sent this BPDU |
| **Port ID** | Sending port's ID |
| **Message Age / Max Age** | TTL-style counter; default Max Age **20s** |
| **Hello Time** | Default **2s** |
| **Forward Delay** | Default **15s** (per Listening, Learning state) |
| **Flags** | TC (Topology Change) and TCA bits |

BPDUs are sent to multicast MAC `01:80:C2:00:00:00` every **2 seconds** by default.

### BPDU types

- **Configuration BPDU** — sent by the root, relayed downstream
- **TCN BPDU** ([[Topology Change Notification]]) — sent upstream toward root when a port changes state

### PortFast + BPDU Guard

[[PortFast]] skips Listening/Learning and drops a port straight into Forwarding — useful for end-host ports, catastrophic if someone plugs in a switch. BPDU Guard is the seatbelt:

```
! Per-interface
interface GigabitEthernet0/1
 switchport mode access
 spanning-tree portfast
 spanning-tree bpduguard enable

! Globally for all PortFast-enabled ports
spanning-tree portfast default
spanning-tree portfast bpduguard default
```

If a BPDU arrives on a BPDU-Guard-protected port, the port goes to **errdisable** — link down, no traffic, full stop.

### Errdisable recovery

```
! View the carnage
show interfaces status err-disabled

! Manual recovery
interface Gi0/1
 shutdown
 no shutdown

! Automatic recovery
errdisable recovery cause bpduguard
errdisable recovery interval 300   ! seconds; default 300

! Verify
show errdisable recovery
```

### BPDU Guard vs Root Guard

| | **BPDU Guard** | **[[Root Guard]]** |
|---|---|---|
| Trigger | **Any** BPDU received | Only **superior** BPDU received |
| Action | Port → **errdisable** (hard) | Port → **root-inconsistent** / blocking (soft) |
| Recovery | Manual or errdisable-recovery timer | Automatic when superior BPDUs stop |
| Where used | **Access** ports (with PortFast) | **Trunk** ports toward other switches |
| Intent | "No switches allowed here." | "Switches OK, but you're not the root." |

```
! Root Guard is per-interface only
interface Gi0/24
 spanning-tree guard root
```

### Verification

```
show spanning-tree summary
show spanning-tree interface Gi0/1 detail
show spanning-tree inconsistentports
```

## Related concepts

[[Spanning Tree Protocol]] · [[Root Bridge]] · [[PortFast]] · [[Root Guard]] · [[BPDU Filter]] · [[Topology Change Notification]] · [[Errdisable]] · [[RSTP]] · [[Broadcast Storm]] · [[Bridge ID]]

---
*Source: VIRGIL knowledge base*