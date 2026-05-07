# LAN Architectures

## What it is

A LAN architecture is the blueprint — the same way a raid composition in *Helldivers 2* dictates whether you bring an anti-tank loadout, a crowd-clear loadout, or both, your network's physical and logical design dictates how traffic flows, how it scales, and where it breaks. You don't just throw switches at a wall and hope packets find each other.

At the smallest scale, you have **topologies** — the raw shape of how devices connect:

- **Star**: every device plugs into a central switch. Like a Discord server where every member talks through the same server, not directly to each other.
- **Full mesh**: everybody has a direct link to everybody else. Requires `N(N-1)/2` connections — 10 sites = 45 cables. Expensive and ugly fast.
- **Partial mesh**: a sensible compromise — important nodes get direct links, others go through a hop.

Stack those topologies into tiers and you get the **hierarchical campus LAN**, the Cisco-style three-layer cake (access → distribution → core), or its smaller sibling the two-tier "collapsed core." Data centers flip the script entirely with **spine-leaf**, designed for the way modern apps actually talk. And once you leave the building, you're in **WAN** territory — leased lines, MPLS, or VPN tunnels riding the public internet.

## Why it matters

Pick the wrong architecture and you're the squad in *Escape from Tarkov* who brought pistols to Labs — technically functional, immediately punished. A flat single-switch network works for a coffee shop. Try it on a 12-building campus and broadcast storms, STP convergence times, and a single failure domain will eat you alive.

The hierarchy exists because it lets you **isolate failures**, **scale predictably**, and **put the right feature at the right layer**. Security and access control belong near the user. Routing and redundancy belong in the middle. Raw bandwidth belongs at the spine. Mixing those up is how you end up with a $40,000 core switch doing port security for a printer.

WAN choices matter for a different reason: money. A leased line is $800–$4,000/month. An internet circuit with a VPN is $50–$300. The difference is whether you're paying for guarantees or paying for "probably fine."

## Key facts

### Campus topology basics
- **Star**: one central switch, all devices as spokes. Simple, single point of failure.
- **Full mesh**: `N(N-1)/2` links — 5 sites need 10 links, 10 sites need 45. Scales like a *Souls* boss's HP bar in NG+7.
- **Partial mesh**: only critical pairs get direct links. The pragmatic choice.
- **Campus LAN**: networking inside a defined geographic footprint — one building, one office park.

### Access layer (the front door)
Where users, phones, cameras, and servers physically plug in. Think of it as the lobby scanner in *Watch Dogs 2* — every device that wants in gets checked here.
- Implements **port security** (limits MAC addresses per port — stops someone unplugging a phone and hooking up a rogue switch)
- **DHCP snooping** — blocks rogue DHCP servers handing out fake gateways
- **Dynamic ARP Inspection (DAI)** — kills ARP spoofing attacks
- **PoE** — powers IP phones, APs, and cameras over the same Ethernet cable
- **VLAN segmentation** and **QoS marking** at the edge
- Connects up to distribution via **802.1Q trunk links**

### Distribution layer (the manager)
Aggregates a bunch of access switches and acts as the **Layer 2 / Layer 3 border** — packets stop being "switched by MAC" and start being "routed by IP" here.
- Built from **multilayer switches** (do both L2 and L3)
- Hosts the **STP root bridge** — you want the spanning tree's center of gravity here, not at some random access switch
- Runs **FHRP (usually HSRP)** so end devices have a redundant default gateway — like having a backup tank in *Marvel Rivals* the moment the main tank goes down
- Runs **routing protocols** (OSPF, EIGRP, etc.)
- Uses **SVIs** (Switch Virtual Interfaces) as the gateway IP for each VLAN
- Uses **routed ports** (configured with `no switchport`) for L3 links upstream
- Almost always **deployed in pairs** for redundancy

### Core layer (the highway)
- Aggregates traffic between multiple distribution blocks in big campuses
- Job is one thing: move packets fast. No fancy filtering, no policy.

### Two-tier vs three-tier
- **Two-tier (collapsed core)**: distribution and core merged. Good for **<500–1000 users**, single building.
- **Three-tier**: access + distribution + core. For **multi-building campuses**. Buys you scalability, modularity, and performance.
- Three-tier is built around **north-south traffic** — users inside talking to servers/WAN outside.

### Spine-leaf (the data center answer)
Modern data center apps generate massive **east-west traffic** — server-to-server, microservices chattering at each other like the proximity comms in *Among Us* but constant. Three-tier hierarchies bottleneck on this because traffic between two leaves has to climb up and back down.
- Every **leaf** connects to every **spine**. No leaf-to-leaf or spine-to-spine.
- **Predictable latency**: always exactly 2 hops (leaf → spine → leaf)
- **No oversubscription** if sized right
- Uses **ECMP (Equal-Cost Multipath)** to load-balance across all spine uplinks — like having multiple matchmaking servers and getting routed to whichever has capacity
- Adding capacity = add another spine. Adding ports = add another leaf.

### SOHO networks
- Single combo box does **router + switch + wireless AP + DHCP + NAT + firewall**. Your home ISP box. Cheap, fine for under ~10 users.

### WAN basics
- Connects geographically separate LANs
- Enterprise **owns the LAN** but **rents the WAN** from a service provider

### Leased lines
A dedicated physical circuit between two sites — like having a private lane on the highway nobody else can merge into.
- **Reserved bandwidth**, no sharing, consistent latency
- **T1** = 1.544 Mbps (North America), **E1** = 2.048 Mbps (Europe)
- **T3** = 44.736 Mbps, **E3** = 34.368 Mbps
- Hub-and-spoke with 4 branches = **4 leased lines**; full mesh of 5 sites = **10 leased lines**
- **Legacy** — being replaced by Ethernet-based dedicated services
- Expensive: **$800–$4,000/month** per circuit

### MPLS
A **Layer 2.5** forwarding scheme — sits between the Ethernet header and the IP packet. Instead of routers re-reading the destination IP at every hop, they slap a **label** on the packet and forward based on that. Like the wristband at a festival — security scanned your ID once at the gate, after that the wristband is enough at every checkpoint.
- **Packet structure**: Ethernet header | MPLS label | IP packet | Ethernet trailer
- **CE router (Customer Edge)**: yours, sits at your site, **doesn't speak MPLS**
- **PE router (Provider Edge)**: at the ISP edge, **adds labels** going in, **strips them** going out
- **P router (Provider)**: deep in the ISP cloud, only looks at the **label**, never the IP
- Lets one provider serve many customers on shared infrastructure with traffic kept separate via labels = **VPNs**
- **L2VPN**: emulates raw Ethernet between sites — runs any Layer 3 protocol over it
- **L3VPN**: provider routes for you; each customer gets their own routing table

### Internet WAN + VPN
The budget option — same idea as streaming a game over GeForce Now instead of buying the hardware.
- **$50–$300/month** vs leased line pricing
- Shared infrastructure, **unpredictable latency**, best-effort, no SLA guarantees
- **VPN** wraps it in encryption + authentication so it's safe over the public internet
- Used for branch-to-HQ and remote-worker-to-HQ

### IPsec VPN specifics
- **Phase 1 (IKE/ISAKMP)**: negotiates security parameters, establishes keys for the management channel
- **Phase 2**: negotiates the actual encryption + integrity for the user data traffic
- **AES-256** for encryption
- **SHA-256** for integrity hashing
- **Diffie-Hellman Group 14** for key generation
- **IKE SA lifetime**: typically **86400 seconds** (24 hours) — like a session token that forces a re-handshake daily

## Related concepts
[[Spanning Tree Protocol]] · [[HSRP and FHRP]] · [[VLANs and 802.1Q Trunking]] · [[OSPF]] · [[DHCP Snooping and Dynamic ARP Inspection]] · [[Port Security]] · [[Multilayer Switching and SVIs]] · [[MPLS L3VPN]] · [[IPsec Site-to-Site VPN]] · [[ECMP Load Balancing]] · [[NAT and PAT]] · [[QoS Marking]]