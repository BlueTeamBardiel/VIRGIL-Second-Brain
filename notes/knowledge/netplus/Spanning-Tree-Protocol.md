# Spanning Tree Protocol

## What it is

In **Red Dead Redemption 2**, the rail network connecting Saint Denis, Rhodes, Valentine, and Blackwater isn't a loop — it's a tree. If the engineers had laid down a second track that looped Saint Denis back to itself through Rhodes, every train hitting that junction would have two valid paths. Without a signaling system to lock one path closed, you'd get two locomotives arriving at the same switch from opposite directions, screaming horns, and Arthur Morgan watching a derailment with a cigarette. The railroad solves this by designating one main line and physically closing the redundant spur unless the main fails.

That's exactly what **Spanning Tree Protocol** does — it takes a switched network with redundant physical links and logically shuts down the loops, leaving exactly one active path between any two switches, while keeping the backup links ready to wake up if the primary dies.

**Technical definition:** STP (IEEE 802.1D, with the modern version being **Rapid Spanning Tree Protocol — RSTP, 802.1w**) is a Layer 2 protocol that prevents bridge loops in Ethernet networks by exchanging **BPDUs** (Bridge Protocol Data Units) between switches, electing a **root bridge**, calculating the lowest-cost path from every switch to that root, and placing redundant ports into a **blocking** state.

## Why it matters

A Layer 2 loop without STP is a network-ending event. Broadcast frames have no TTL — unlike IP packets at Layer 3, an Ethernet frame circling a loop will circle forever, multiplying every time it hits a switch with multiple paths. Within seconds you get a **broadcast storm**: CPU at 100% on every switch, MAC address tables thrashing, the entire VLAN dark. Pull-the-cable-and-pray dark.

I have watched a junior tech patch a "spare" cable between two access switches to "clean up the rack." Eight hundred users lost the network in about four seconds. STP was disabled on those ports. *A loop is not a theoretical risk. It's a Tuesday afternoon mistake away.*

**Exam relevance (N10-009 Objective 2.2):** STP shows up alongside [[VLANs]], [[802.1Q tagging]], [[link aggregation]], and interface configuration. CompTIA expects you to know port states, what BPDUs do, why you'd use RSTP over legacy STP, and the relationship between STP and features like [[PortFast]] and [[BPDU Guard]].

## Key facts

### The election — root bridge

Every STP domain picks one **root bridge**. All path calculations are "shortest path to root." The election is decided by **Bridge ID**, which is:

`Bridge Priority (2 bytes) + MAC address (6 bytes)`

Lowest Bridge ID wins. Default priority is **32768**. If every switch has the default, the oldest switch (lowest MAC) wins by accident — which is almost never the switch you want as root. *The core switch should be root. Set its priority manually to 4096 or 0. Don't let MAC-address lottery pick your network's spine.*

### Port states (legacy 802.1D)

| State | Forwards data? | Learns MACs? | Listens to BPDUs? |
|---|---|---|---|
| **Disabled** | No | No | No |
| **Blocking** | No | No | Yes |
| **Listening** | No | No | Yes |
| **Learning** | No | Yes | Yes |
| **Forwarding** | Yes | Yes | Yes |

Convergence from blocking to forwarding takes **30–50 seconds** in classic STP. That's why a workstation plugging in could sit at "Acquiring network address" for nearly a minute before DHCP even got a chance.

### Port states (RSTP 802.1w)

RSTP collapses the states to **Discarding, Learning, Forwarding** and converges in **under 2 seconds** in most topologies. RSTP is what every modern switch runs by default. Legacy 802.1D is exam trivia and museum equipment.

### Port roles

- **Root port** — the port on a non-root switch with the lowest cost path to the root bridge. Forwards.
- **Designated port** — the forwarding port on a segment, one per segment, including all ports on the root bridge.
- **Non-designated / Alternate / Backup** — blocked, standby.

### Path cost

STP picks the best path by **cumulative cost to root**. Lower-bandwidth links have higher cost:

| Link speed | Cost (legacy) | Cost (RSTP/IEEE) |
|---|---|---|
| 10 Mbps | 100 | 2,000,000 |
| 100 Mbps | 19 | 200,000 |
| 1 Gbps | 4 | 20,000 |
| 10 Gbps | 2 | 2,000 |
| 100 Gbps | — | 200 |

### BPDUs

Switches exchange **BPDUs** every 2 seconds (hello timer) on every port. The BPDU carries the sending switch's Bridge ID, root Bridge ID, root path cost, and port ID. This is how the topology stays consistent and how a switch knows a neighbor died — three missed BPDUs and the port reconverges.

### PortFast and BPDU Guard

**PortFast** skips the listening/learning delay on access ports. Set it on every port where an end device (PC, printer, AP, phone) lives. Never set it on a switch-to-switch link.

**BPDU Guard** is the safety net. If a PortFast-enabled port ever receives a BPDU — meaning someone plugged a switch into a port that was supposed to be an end device — the port is shut down immediately. *PortFast without BPDU Guard is a loaded gun with the safety off.*

### STP variants you should recognize

- **STP (802.1D)** — original. One spanning tree for the whole bridged network. Slow.
- **RSTP (802.1w)** — rapid. Sub-second convergence. Default on modern gear.
- **PVST+ / Rapid PVST+** — Cisco proprietary. One spanning tree **per VLAN**. Allows load balancing because different VLANs can use different active paths.
- **MSTP (802.1s)** — Multiple Spanning Tree. Groups VLANs into instances. Scales better than per-VLAN STP when you have hundreds of VLANs.

### CompTIA exam traps

> **CompTIA exam trap:** STP does not prevent Layer 3 routing loops. STP is **Layer 2 only**. Routing loops are solved by TTL, split horizon, route poisoning, and routing protocol design — not STP.

> **CompTIA exam trap:** A "broadcast storm" is not stopped by a firewall, an [[ACL]], or [[QoS]]. It's a Layer 2 flood. Only STP (preventing the loop) or physically pulling the cable stops it.

> **CompTIA exam trap:** PortFast does **not** disable STP on a port. The port still listens for BPDUs. It just skips the wait states for forwarding. If a BPDU arrives, BPDU Guard (a separate feature) is what shuts the port down.

> **CompTIA exam trap:** Lowest **Bridge ID** wins root election — that's priority first, MAC second. CompTIA will write a question where two switches have different MACs but the same priority and ask which wins. Lower MAC wins the tiebreaker.

## How STP coexists with the rest of switching

STP doesn't live alone. It interacts with every other switching feature on Objective 2.2:

### VLANs and 802.1Q

[[VLANs]] segment a switch into separate broadcast domains. **802.1Q tagging** adds a 4-byte VLAN tag to frames on trunk links so multiple VLANs traverse one cable. With **PVST+**, each VLAN runs its own spanning tree, so VLAN 10 might use the left uplink while VLAN 20 uses the right — load balancing across redundant trunks instead of wasting half your capacity in blocking state.

### Native VLAN

The **native VLAN** on a trunk carries untagged traffic. Default is VLAN 1. CompTIA wants you to know: change the native VLAN to something unused (like VLAN 999) for security, and **the native VLAN must match on both ends of the trunk** or you get a "native VLAN mismatch" — STP will log it loudly because BPDUs ride the native VLAN.

### Voice VLAN

A **voice VLAN** is a special access-port config that tags voice traffic (from an IP phone) into one VLAN while the PC daisy-chained behind the phone gets the data VLAN untagged. STP runs normally on these ports — usually with PortFast + BPDU Guard, since phones and PCs are end devices.

### Link aggregation

**Link aggregation** (LACP, 802.3ad, or Cisco's PAgP/EtherChannel) bundles multiple physical links into one logical link. STP sees the bundle as a single port — so two 1 Gbps links bonded into a 2 Gbps LAG don't get one blocked by STP. *Without LAG, STP would block the second link and you'd be paying for capacity you can't use.*

### MTU, jumbo frames, speed, duplex

The **MTU** (default 1500 bytes) and **jumbo frames** (up to 9000 bytes) are payload size settings. They don't affect STP directly, but a **duplex mismatch** on a link absolutely will — half-duplex on one end, full-duplex on the other produces late collisions, dropped BPDUs, and STP reconvergence loops. Always set speed and duplex consistently. Auto-negotiate everywhere or hard-code both ends — never mix.

### SVI and VLAN database

A **Switch Virtual Interface (SVI)** is the Layer 3 interface for a VLAN — `interface vlan 10` with an IP address makes the switch routable for that VLAN. The **VLAN database** is where VLAN IDs and names live on the switch. STP runs on the VLANs defined here; if a VLAN doesn't exist in the database, no spanning tree runs for it.

## Helpdesk reality

- User says: *"The network went down for everyone on the third floor at 2:14 PM."* You check switch logs — STP topology change notifications flooding the log starting at 2:13:58. Someone plugged something in. Find the port that flapped.
- User says: *"My computer takes forever to get on the network when I plug in."* Classic missing PortFast. The port is sitting in listening → learning for 30 seconds before DHCP can even talk. Enable PortFast on access ports.
- User says: *"I plugged in this little switch from home to get more ports."* This is how loops happen. The home switch may not run STP, or may run it and start fighting for root with a priority of 32768 and a MAC older than yours. **BPDU Guard catches this. If BPDU Guard isn't on, you find out by losing the floor.**
- Never promise: *"STP will protect us from any loop."* STP protects against loops between switches that both speak STP. A dumb unmanaged switch in the mix, or a cable plugged into two ports on the same switch with STP misconfigured, can still bite you. **Defense in depth: STP + BPDU Guard + Loop Guard + physical port security.**
- Escalation point: if you've confirmed L1 (cables, link lights), checked port status for `err-disabled` (BPDU Guard tripped), and verified the user's VLAN assignment is correct, and the problem persists across the switch — escalate to the network team for STP topology review.

## Related concepts

[[VLANs]] · [[802.1Q tagging]] · [[Link aggregation (LACP)]] · [[Native VLAN]] · [[Voice VLAN]] · [[Switch Virtual Interface (SVI)]] · [[MTU and jumbo frames]] · [[Broadcast storm]] · [[BPDU Guard]] · [[PortFast]] · [[Duplex mismatch]] · [[Root bridge election]] · [[RSTP]]

*Source: VIRGIL knowledge base — 2026-05-11*