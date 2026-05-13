# Network Topologies

## What it is

In **Pac-Man**, the maze isn't random. Every intersection connects to specific neighbors. The four ghosts — Blinky, Pinky, Inky, Clyde — leave the ghost house through one chokepoint, scatter to their assigned corners, and return through predictable corridors. The tunnel on the left wraps to the right. The power pellets sit at the four corners because the maze designer knew where Pac-Man would need escape routes. **That maze is a topology** — a deliberate physical and logical arrangement of paths between nodes. Change the maze, change the game.

That's exactly what a network topology does. It defines which devices connect to which, how traffic flows between them, and where the bottlenecks and single points of failure live. Pick the wrong topology and your packets are like Pac-Man trapped in a corner with three ghosts converging.

**Technical definition:** A network topology is the arrangement of nodes (switches, routers, servers, endpoints) and the links between them. **Physical topology** is the cabling. **Logical topology** is how data actually flows — which can differ from the physical layout. CompTIA N10-009 Objective 1.6 wants you to compare topologies (star, mesh, point-to-point, hybrid), architectures (three-tier, collapsed core, spine-leaf), and traffic flow patterns (north-south, east-west).

## Why it matters

Topology decisions outlive the people who make them. The cabling you run today is the cabling someone else troubleshoots in 2034. A bad topology choice — every branch office hairpinned through one central firewall, no redundant uplinks, a single distribution switch with no failover — is the kind of thing that takes down a hospital at 3am because one fan died in one chassis.

For Net+ exam purposes, Objective 1.6 is heavily diagram-driven. CompTIA will show you a network drawing and ask which architecture it represents, or describe a traffic pattern and ask whether it's north-south or east-west. You need to recognize the shapes on sight.

For your career: when you walk into a new job and the senior engineer says "we're collapsed core with a spine-leaf datacenter and the campus is three-tier," you need to know what that sentence means before you've finished your coffee.

## Key facts

### Physical topologies

**Point-to-point** — two nodes, one link between them. Simplest possible topology. A site-to-site VPN tunnel between two offices is logically point-to-point even though it crosses the internet. A direct fiber run between two buildings is physically point-to-point. No switching decisions, no contention.

**Star / hub-and-spoke** — every endpoint connects to one central device. The central device is a [[Switch]] (modern) or a [[Hub]] (ancient and deprecated). This is what every office network on Earth looks like at the access layer. Cheap, easy to troubleshoot, but the central device is a single point of failure — kill the switch, kill the floor.

**Mesh** — every node connects to every other node, or to many others. **Full mesh** = every node connects to every other node. **Partial mesh** = some redundant links but not all-to-all. Math: full mesh of N nodes needs N(N-1)/2 links. Six nodes = 15 links. Twenty nodes = 190 links. *Full mesh scales like a screaming child — fine until it isn't.* Used at the WAN core where redundancy justifies the cost, and in wireless mesh (every AP backhauls to multiple neighbors).

**Hybrid** — any real network. The access layer is star. The distribution layer is partial mesh. The WAN uplinks are point-to-point. Production networks are always hybrids because no single topology is good at everything.

### Topology comparison table

| Topology | Cost | Fault tolerance | Scalability | Where you see it |
|---|---|---|---|---|
| Point-to-point | Low | None | Doesn't scale | Site-to-site VPN, direct fiber runs |
| Star/hub-and-spoke | Low | Single point of failure at center | Good (add ports) | Every office access layer |
| Full mesh | Very high | Excellent | Terrible (N²) | WAN cores, critical backbones |
| Partial mesh | Medium | Good | Good | Distribution layer, datacenter spine |
| Hybrid | Varies | Varies by segment | Excellent | Every real production network |

### The three-tier hierarchical model

The classic enterprise campus design. Three layers, each with a specific job:

- **Core layer** — the backbone. Fast, dumb, redundant. The core's only job is to move packets between distribution blocks as fast as physically possible. No ACLs, no policy, no filtering — that work happens elsewhere. Think of the core as the highway: no stoplights, just speed.
- **Distribution layer** — the policy enforcement layer. ACLs, [[VLAN]] routing, [[QoS]] marking, redundancy via [[Spanning Tree Protocol]] or routing protocols. Distribution aggregates traffic from many access switches and hands it to the core. Distribution is where the smart decisions happen.
- **Access layer** — where endpoints plug in. User workstations, printers, [[PoE]] phones, wireless APs. Cheap switches with lots of ports. The access layer's job is to get traffic from the endpoint to distribution, mark it appropriately, and not be a security disaster.

The three-tier model came from Cisco in the 1990s for campus networks with thousands of users. It scales beautifully because each layer has a single responsibility.

### Collapsed core

Smaller networks don't need three layers. A **collapsed core** merges the core and distribution layers into one set of devices. You still have access switches at the edge, but the core/distribution device handles both the backbone job and the policy job.

When to collapse: small-to-medium businesses, single-building deployments, branch offices. When NOT to collapse: anywhere you'd melt the device by combining roles, or where you need the core completely free of policy overhead. *Collapsed core is the right answer 80% of the time outside of large enterprise and datacenter.*

### Spine-leaf (the datacenter answer)

Three-tier was built for traffic that goes **user → server → internet**. Modern datacenters don't work that way. A virtual machine talks to a database, the database hits a cache, the cache talks to storage, and storage replicates to a backup pool — all server-to-server, all inside the datacenter. Three-tier handles that poorly because traffic has to climb up to distribution and back down.

**Spine-leaf** is the answer. Two layers:

- **Leaf switches** connect to servers, storage, and edge devices
- **Spine switches** connect only to leaves — never to each other, never to endpoints

Every leaf connects to every spine. That means any server-to-server path is exactly two hops: leaf → spine → leaf. Predictable latency. Add capacity by adding more spines. Add ports by adding more leaves. No [[Spanning Tree Protocol]] required because the fabric uses [[ECMP]] (equal-cost multipath) routing instead.

> **CompTIA exam trap:** Three-tier vs spine-leaf is not a "newer is better" question. Three-tier is correct for **campus** networks where most traffic is north-south. Spine-leaf is correct for **datacenter** networks where most traffic is east-west. If the question describes user workstations in offices, it's three-tier. If it describes VMs, storage, and east-west traffic, it's spine-leaf.

### Traffic flow patterns

**North-south traffic** — traffic that crosses the network perimeter. User to internet, internet to web server, branch to HQ. Vertical movement on a network diagram, hence "north-south." This is what firewalls, [[NAT]], and [[Web Application Firewall]] gear inspect.

**East-west traffic** — traffic that stays inside the network. Server to server, VM to VM, container to container. Horizontal movement. East-west traffic is exploding because of microservices, virtualization, and storage replication. *A modern datacenter is 80% east-west and 20% north-south, which is exactly the opposite of what three-tier was designed for.*

East-west is also where lateral movement attacks happen. An attacker who phishes a workstation doesn't stay there — they pivot east-west to find the domain controller. This is why **microsegmentation** and zero-trust architectures focus on inspecting east-west, not just north-south.

### Architecture comparison table

| Architecture | Layers | Best for | Traffic pattern |
|---|---|---|---|
| Three-tier hierarchical | Core / Distribution / Access | Large campus, enterprise | North-south dominant |
| Collapsed core | Core+Distribution / Access | SMB, branch office, single building | Mixed, mostly north-south |
| Spine-leaf | Spine / Leaf | Datacenter, cloud fabric | East-west dominant |
| Point-to-point | None (just a link) | WAN, direct site links | Whatever crosses the link |

### CompTIA exam traps

> **CompTIA exam trap:** Don't confuse **physical** and **logical** topology. A wireless network is physically a star (everyone connects to the AP) but can be logically anything depending on the protocol. Token Ring was logically a ring but physically wired as a star through an MAU. CompTIA will phrase the question to test whether you know which one is being asked.

> **CompTIA exam trap:** Full mesh is rarely the right answer on the exam. The math doesn't work past about 6–8 nodes. If a question offers full mesh as an answer for a large network, it's almost certainly a distractor — partial mesh or spine-leaf is the real answer.

> **CompTIA exam trap:** The **core layer** does NOT do filtering, ACLs, or policy. If a question describes a device doing access control and calls it a "core" switch, that device is actually performing a distribution role, or you're looking at a collapsed-core deployment. CompTIA tests this exact confusion.

## Helpdesk reality

- User says: *"The internet is slow."* Right answer: ask if it's slow to one site or every site. Slow to one site = that site's problem or DNS. Slow to everything = local network or ISP. The topology determines where the bottleneck can be — in star/hub-and-spoke, the central switch is the suspect; in hybrid, you have more places to look.
- User says: *"I can reach the file server but not the printer, and they're in the same room."* Topology answer: they may be on different VLANs riding the same physical star. Logical ≠ physical. Check the VLAN assignment before you check the cables.
- Never promise: *"We have redundancy, this can't happen again."* Redundancy fails when the failover device was misconfigured two years ago and no one tested it. Mesh and spine-leaf give you path redundancy. They don't give you immunity.
- Escalation point: if you've confirmed the endpoint, cable, and access switch are healthy and the problem affects multiple users on multiple access switches, you're looking at distribution or core. That's a network team ticket, not a desktop ticket.
- The cable test, the link light, the `ping`, the `traceroute` — these tell you which layer of the topology to suspect. A traceroute that dies at hop 2 points at distribution. A traceroute that dies at the edge points at the WAN.

## Related concepts

[[Switch]] · [[Router]] · [[VLAN]] · [[Spanning Tree Protocol]] · [[ECMP]] · [[OSI Model]] · [[Subnetting]] · [[NAT]] · [[QoS]] · [[Site-to-Site VPN]] · [[Microsegmentation]] · [[SDN]]

*Source: VIRGIL knowledge base — 2026-05-11*