# Network Architectures

## What it is

In **Portal**, every test chamber is laid out the same way: you enter through one door, solve the puzzle, and the elevator at the back drops you down to the next chamber. GLaDOS routes you. The chambers themselves connect to maintenance corridors behind the walls — the ones you sneak through after the cake reveal. The test chambers are the **access layer** where Chell does the work. The elevators between them are the **distribution layer**. The Enrichment Center's central infrastructure — the incinerator, the AI core, the master control — that's the **core**. And when you fire a portal from one wall to another and walk through, you've created a **point-to-point** link that bypasses the entire hierarchy. That's a network architecture in two paragraphs: structured paths for normal traffic, and the shortcuts engineers build when the normal paths aren't enough.

Plain English: a network architecture is the shape of how devices connect to each other and how traffic moves between them. It's the floor plan of the building, not the building itself.

Technical: a **network architecture** describes the logical and physical organization of network devices, the layers between endpoints and the data center or internet edge, and the traffic patterns that emerge from that organization. N10-009 Objective 1.6 expects you to compare topologies (mesh, star, point-to-point, hybrid), architectures (three-tier, collapsed core, spine-and-leaf), and traffic flow patterns (north-south, east-west).

## Why it matters

Architecture decisions made on day one outlive the engineer who made them. A three-tier network designed for 200 users in 2010 is still running in 2026 with 800 users bolted on, and every troubleshooting call lives or dies on whether you can read the topology. On the job, "which switch is this user behind" is a question you answer by knowing the architecture. On the exam, CompTIA tests this by giving you a scenario — a data center with heavy server-to-server traffic, a small office with one closet, a campus with three buildings — and asking which architecture fits. Wrong architecture answer = wrong design = wrong scenario answer.

This objective also frames everything downstream: [[VLANs]], [[Routing]], [[STP]], and [[QoS]] all behave differently depending on whether you're on a three-tier campus or a spine-and-leaf data center fabric.

## Key facts

### Topologies — the physical/logical shape

A **topology** is how nodes connect. CompTIA cares about these:

| Topology | Shape | Used where | Failure behavior |
|---|---|---|---|
| **Star / hub-and-spoke** | Every node connects to one central device | Almost every modern LAN; SOHO Wi-Fi | Central device dies → entire network dies |
| **Mesh (full)** | Every node connects to every other node | WAN backbones, critical links | Massive redundancy, expensive (n(n-1)/2 links) |
| **Mesh (partial)** | Critical nodes interconnected; others single-homed | Most real WANs, SD-WAN overlays | Redundant where it matters, cheaper |
| **Point-to-point** | Two endpoints, one dedicated link | WAN circuits, microwave links, fiber between buildings | Link fails, both sides isolated |
| **Hybrid** | Mix of the above | Every real network past a certain size | Depends on which segment fails |

Star is the default LAN topology. The "hub" in hub-and-spoke is usually a switch (LAN) or a headquarters site (WAN). Don't confuse it with a Layer 1 [[hub]] — that's a device, this is a shape.

**Mesh** comes in two flavors. **Full mesh** scales terribly — 10 nodes need 45 links, 20 nodes need 190. **Partial mesh** is what real networks do: critical sites get redundant links, branch offices get one link and a backup VPN.

**Point-to-point** is exactly what it sounds like — two endpoints, dedicated link, no shared medium. A leased line between two offices. A microwave dish on the roof aimed at another roof. A patch cable between two switches. Simple, predictable, no contention.

### The three-tier hierarchical model

The classic campus network design. Three layers, each with a specific job:

**Access layer** — where endpoints plug in. Workstations, printers, APs, IP phones. Lots of ports, low cost per port, [[PoE]], features like port security and 802.1X. This is the [[edge switch]] in the wiring closet.

**Distribution layer** (sometimes called aggregation) — sits between access and core. Does the heavy lifting: [[inter-VLAN routing]], [[ACLs]], policy enforcement, [[STP]] root bridge placement. Aggregates the access switches in a building or floor. This is where the network gets opinions about traffic.

**Core layer** — high-speed backbone. One job: move packets fast. No ACLs, no policy, no inspection. Redundant, low-latency, high-throughput. Connects distribution blocks to each other and to the data center / WAN edge.

> **CompTIA exam trap:** The core layer does NOT do packet filtering, ACLs, or policy. Those belong at distribution. CompTIA will offer "configure ACLs at the core for performance" as a wrong answer. The core's job is speed. Filtering at the core slows the entire network.

The model maps to physical reality: access = wiring closets on each floor, distribution = building MDF, core = campus data center.

### Collapsed core

In smaller networks, the distribution and core layers get merged into a single layer. This is called **collapsed core** (or two-tier). You have an access layer and a combined distribution/core layer that does both jobs.

When to collapse: small to mid-size buildings, single-site organizations, anywhere the cost and complexity of a separate core layer isn't justified. If you only have two or three distribution blocks, a dedicated core is overkill — those distribution switches can talk to each other directly.

*The three-tier model is a textbook ideal. Most real campuses I've worked on were collapsed core with a few oversized distribution switches doing core duty on the side.*

### Spine-and-leaf — the data center answer

The three-tier model was built for client-server traffic — users at desks talking to servers in a data center. That's **north-south** traffic. But modern data centers have a different problem: virtualized workloads, microservices, storage replication, and VM migrations generate massive **east-west** traffic — server-to-server within the data center. Three-tier handles east-west badly because every server-to-server hop has to climb up to distribution (or core) and back down.

**Spine-and-leaf** fixes this. Two layers:

- **Leaf switches** — every server, storage array, and edge device connects here. Equivalent of access.
- **Spine switches** — every leaf connects to every spine. No leaf-to-leaf, no spine-to-spine.

Result: any server is exactly **two hops** from any other server (leaf → spine → leaf). Deterministic latency. Predictable bandwidth. Add capacity by adding more spines (more bandwidth) or more leaves (more ports).

Spine-and-leaf uses [[ECMP]] (equal-cost multipath) to load-balance across all spine links simultaneously — no [[STP]] blocking links the way it does in a three-tier campus. Every link is active. This is why modern data centers run [[Layer 3]] all the way to the leaf instead of relying on Layer 2 spanning tree.

| Three-tier | Spine-and-leaf |
|---|---|
| Optimized for north-south | Optimized for east-west |
| STP blocks redundant paths | ECMP uses all paths |
| Variable hop count | Deterministic 2 hops |
| Campus / enterprise LAN | Data center fabric |
| Cisco classic | Modern cloud/DC standard |

### Traffic flows — north-south vs east-west

The compass metaphor describes packet direction in the data center diagram:

- **North-south** — traffic between the data center and the outside world (clients, internet, branch offices). A user opens a web app, the request goes north to the firewall, south to the web server. Up and down the diagram.
- **East-west** — traffic within the data center. Web server talks to app server talks to database. VM migrates between hosts. Storage replicates between arrays. Sideways across the diagram.

Modern workloads are 70–80% east-west. That ratio is why spine-and-leaf exists. Three-tier was designed when east-west was a rounding error.

> **CompTIA exam trap:** If the scenario mentions "server-to-server," "VM migration," "microservices," or "storage replication," it's east-west and the answer is spine-and-leaf. If it mentions "client accessing a web app" or "branch office to HQ," it's north-south and three-tier or collapsed core is the answer.

### Hybrid architectures

Real networks are almost never pure. A real enterprise looks like:

- Campus LAN: three-tier or collapsed core, star topology at access
- Data center: spine-and-leaf
- WAN: partial mesh with point-to-point circuits to critical sites and VPN/SD-WAN to branches
- Cloud: leaf-equivalents in AWS/Azure VPCs, connected via point-to-point [[Direct Connect]] or [[ExpressRoute]]

"Hybrid" on the exam usually means "combines two or more topologies/architectures." Don't overthink it. If a scenario describes a network that doesn't fit one pure model, it's hybrid.

## Helpdesk reality

- User says "the wifi is slow." You check the [[access layer]] switch the AP is plugged into. 80% of the time it's an uplink saturation problem at distribution, not Wi-Fi. *Never blame the layer the user mentioned first.*
- User says "I can't reach the file server." Same building? That's east-west, your campus distribution layer is involved. Different building? North-south through the core. Knowing which one tells you which switch to look at.
- New site coming online and someone asks "do we need a core?" — count the distribution blocks. Two or three? Collapsed core. Six or more? Dedicated core. *Architecture decisions are a cost-benefit question, not a religion.*
- Never promise a user "the new network will be faster." Architecture changes affect latency and convergence time, not necessarily throughput at their desk. Their gigabit link is still gigabit.
- If you've confirmed L1 (cable), L2 (switch port, VLAN), and L3 (IP, gateway) on the client side and the problem persists, escalate to network engineering with the topology in mind — "user is on access switch FLR2-SW-03, distribution is DIST-B, problem is east-west to server in DC fabric." That ticket gets resolved in an hour. "Internet is broken" gets resolved in a day.

## Related concepts

[[VLANs]] · [[Inter-VLAN routing]] · [[STP]] · [[ECMP]] · [[Routing]] · [[OSI Model]] · [[SDN]] · [[SD-WAN]] · [[PoE]] · [[QoS]] · [[Data Center Design]] · [[WAN Topologies]]

*Source: VIRGIL knowledge base — 2026-05-11*