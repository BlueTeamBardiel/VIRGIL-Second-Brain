# Network Types

## What it is

In **Grand Theft Auto Online**, when you load into Los Santos, your session has 30 players. You don't connect to all 29 of them directly — that would melt your console. One player is the **session host**, and most traffic flows through them. When the host rage-quits, the lobby freezes for ten seconds while the game migrates host duties to someone else. That brief freeze is your session restructuring its topology in real time. The host was the **core**; the rest of you were the **access** layer; and the moment the core died, every packet had nowhere to go.

That's exactly what network topology and architecture decisions do — they define which devices are the heart of the network, which are the capillaries, and what happens to traffic when something fails.

In N10-009 terms, a **network topology** is the physical or logical arrangement of devices and links. A **network architecture** is the design philosophy — how layers of devices stack to handle scale, redundancy, and failure. CompTIA tests both together because you can't pick a topology without understanding what architecture it supports.

## Why it matters

Architecture decisions get made once and lived with for a decade. Pick wrong and you're patching it forever. Pick right and the network scales quietly while you sleep.

On the exam, Objective 1.6 wants you to compare and contrast topologies (star, mesh, point-to-point, hybrid), architectures (three-tier hierarchical, collapsed core, spine-and-leaf), and traffic flows (north-south, east-west). CompTIA loves to give you a scenario — "a data center needs to handle heavy server-to-server replication" — and ask which architecture fits. The right answer depends on the **traffic flow pattern**, not the device count.

In the real world, this is the difference between a network that survives a switch failure and one that takes the company offline because somebody designed everything to depend on a single distribution switch with no redundant uplink.

## Key facts

### Topologies (the physical/logical shapes)

**Star / hub-and-spoke** — every endpoint connects to one central device. The central device is a switch (modern) or a hub (museum piece). If the center dies, everything dies. If a spoke dies, only that spoke dies. This is what your home network is. This is what 95% of office LANs are.

**Mesh** — every device connects to multiple other devices. **Full mesh** means every node connects to every other node — n(n-1)/2 links, which is brutal math past about 6 nodes. **Partial mesh** means critical nodes have multiple paths, but not every node does. Mesh wins on redundancy and loses on cost.

**Point-to-point** — exactly two endpoints connected by one link. A leased line between two offices. A wireless bridge between two buildings. Simple, predictable, no contention.

**Hybrid** — anything that mixes topologies, which in practice is every real network. Your office is a star at the access layer, partial mesh at the core, with point-to-point WAN links to other sites. Hybrid isn't a cop-out answer — it's reality.

### The three-tier hierarchical model

This is the classic enterprise design Cisco taught the world. Three layers, each with one job:

| Layer | Job | Devices | Traffic pattern |
|---|---|---|---|
| **Core** | Move packets fast between distribution switches. No filtering, no policy. Just blast bits. | High-throughput L3 switches, redundant | Backbone — never the slow link |
| **Distribution** | Policy, routing between VLANs, ACLs, QoS marking. The brains. | L3 switches with route processing | Aggregation point |
| **Access** | Connect end devices — PCs, phones, APs, printers | L2 switches, lots of ports, often PoE | User-facing |

The rule: **access talks to distribution, distribution talks to core, core talks to other distribution.** Access never talks directly to core. This keeps blast radius small and policy enforcement consistent.

The downside: three tiers means three sets of hardware to buy, power, cool, and maintain. For a 200-person office it's overkill.

### Collapsed core

When you can't justify three tiers, you **collapse the core and distribution into one layer**. Result: two tiers — access and a combined core/distribution. Same logical functions, fewer boxes. This is what most mid-size offices actually run.

You lose some scalability and some failure isolation. You save serious money. For a single-building deployment under a few thousand endpoints, collapsed core is the right call.

> **CompTIA exam trap:** Collapsed core is NOT the same as "no core." It means the core and distribution functions live on the same physical devices. The functions still exist — routing, policy, aggregation — they're just not on separate hardware. If the question says "small enterprise reduces hardware costs by combining layers," that's collapsed core, not "removed the core."

### Spine and leaf

This is the modern data center design and the answer to a problem the three-tier model handles badly: **east-west traffic**.

- **Spine switches** — the backbone. Every leaf connects to every spine.
- **Leaf switches** — the access layer for servers. Every leaf connects to every spine.

No leaf connects to another leaf directly. No spine connects to another spine. It's a partial mesh — specifically, a **bipartite full mesh** between the two layers.

The magic: **any server is exactly two hops from any other server.** Leaf → spine → leaf. Predictable, low latency, easy to scale (add a spine, every leaf gets more bandwidth; add a leaf, every spine gets another endpoint group).

Spine-and-leaf is what AWS, Azure, and every modern data center looks like under the hood. The three-tier model assumes traffic mostly leaves the building. Spine-and-leaf assumes traffic mostly stays inside, going server-to-server. Pick the architecture that matches the flow.

### Traffic flows — north-south vs east-west

This is the concept CompTIA actually wants you to internalize, because architecture choice flows from it.

**North-south** traffic: between the data center and the outside world. User-to-server. Client-to-internet. Up and down the stack diagram. Three-tier networks handle north-south traffic well because the design assumes packets flow up through aggregation toward the WAN edge.

**East-west** traffic: between servers inside the data center. Server-to-server. Database-to-application. Microservice-to-microservice. Backup replication. Modern workloads — virtualization, containers, distributed databases — generate massive east-west traffic.

If your traffic is 80% north-south, three-tier is fine. If it's 80% east-west, three-tier becomes a bottleneck because every server-to-server conversation has to climb up to distribution, possibly to core, then back down. Spine-and-leaf solves this by making east-west the **default fast path**.

> **CompTIA exam trap:** "Heavy server-to-server replication" or "microservices architecture" or "virtualized data center" in the scenario = east-west = **spine-and-leaf**. "Branch office users accessing internet services" = north-south = three-tier or collapsed core. Read the traffic description, not the device count.

### Quick comparison

| Architecture | Best for | Failure domain | Cost |
|---|---|---|---|
| **Three-tier** | Large campus, predominantly north-south | Distribution block | High |
| **Collapsed core** | Mid-size single building | Whole core/dist | Medium |
| **Spine-and-leaf** | Data center, heavy east-west | Single leaf | High but scales linearly |
| **Full mesh** | Tiny critical-redundancy WAN | Almost none | Brutal past 6 nodes |
| **Star** | SOHO, access layer | Center kills all | Low |
| **Point-to-point** | Two-site WAN, wireless bridge | The one link | Low to medium |

### The living-system view

Three-tier is a body with arms (access), torso (distribution), and a heart (core). Collapsed core fuses the heart and torso. Spine-and-leaf is more like a coral reef — lots of small redundant connections, no single thing the system depends on. *When the design matches the traffic, the network breathes. When it doesn't, you spend your career firefighting choke points.*

## Helpdesk reality

- User says: "The internet is slow today." First check is whether it's slow for everyone or just them. If it's everyone in one VLAN, you've got a distribution-layer problem. If it's everyone in the building, you've got a core or WAN problem. Architecture tells you where to look.
- User says: "The file server is slow." If your data center is three-tier and the file server lives in a different VLAN than the user, every packet is making three hops up and three back down. *East-west traffic on north-south architecture is how networks get blamed for application problems.*
- Never promise an architecture redesign as a fix for a single user's bad day. Architecture changes are quarterly projects, not Tuesday tickets.
- The escalation point: if you've ruled out the user's switch port, cable, and IP config, and the problem is "everyone on floor 3 is slow," it's a distribution-switch ticket for the network team.
- The hardest lesson: most "the network is slow" tickets are actually application or DNS problems. Architecture is rarely the villain on a Tuesday. It's the villain on a Friday at 4:55pm when a core switch fails and there was no redundancy.

## Related concepts

[[OSI Model]] · [[Switches]] · [[Routers]] · [[VLAN]] · [[Routing Protocols]] · [[Spanning Tree Protocol]] · [[Data Center Architecture]] · [[Software-Defined Networking]] · [[High Availability]] · [[Network Topologies]] · [[WAN Technologies]] · [[QoS]]

*Source: VIRGIL knowledge base — 2026-05-11*