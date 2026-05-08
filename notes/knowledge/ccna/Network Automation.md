# Network Automation

## What it is

In Persona 5, fusing every Persona one-by-one in the Velvet Room when you're trying to build a maxed-out compendium is suffering — but the Itemize and mass-fusion shortcuts let Igor do the grunt work while you focus on heists. Network automation is the same idea: software doing the repetitive clicking for you — pushing configs, provisioning new devices, enforcing policies, watching for problems, and fixing them — without a human SSHing into each box at 2 AM.

The bigger shift behind automation is **Software-Defined Networking (SDN)**. Traditional switches and routers are like every Phantom Thief in a Persona 5 fight picking their own targets independently — each device runs its own brain, each turn its own decision. SDN is Baton Pass run from the top: a central controller calls every shot, and the devices become dumb muscle that forwards packets based on what the controller dictates.

To pull this apart cleanly, networking is split into three planes:

- **Data Plane** — the actual packet-pushers. Forwards frames based on MAC tables and routing tables.
- **Control Plane** — the strategist. Builds those tables by running routing protocols, ARP, spanning tree.
- **Management Plane** — the admin console. How humans (or automation tools) configure and monitor the gear.

## Why it matters

Manually configuring a network at scale is the same energy as trying to gear up 50 Tarkov raids with no flea market — technically possible, soul-crushing, and you will misclick. Automation slashes **OpEx** (operational expenses: salaries, time, mistakes) because one engineer can now manage what used to take ten. Note: it does **not** reduce **CapEx** — you still have to buy the switches. Software doesn't conjure hardware.

It also enables consistency. When Beatrice pushes a VLAN change through a controller, all 400 switches get the exact same config. No one switch ends up with a typo'd ACL that breaks production three weeks later when nobody remembers who touched it.

## Key facts

### The Three Planes

- **Data Plane** — pure reflexes, like landing a Counter-Strike 2 headshot. Operates at **microsecond latency** because every nanosecond of forwarding delay stacks up. Just looks at the MAC/routing table and ships the packet.
- **Control Plane** — the coach drawing up plays. Runs **OSPF, BGP, EIGRP**, builds **ARP tables**, computes **spanning tree topology**. Operates at **second-scale** convergence — slower because it's thinking, not just reacting.
- **Management Plane** — the dev console. Uses **SSH, Telnet, SNMP, Syslog, NTP, TFTP, FTP**. **No strict latency requirements** — nobody dies if your syslog message takes 400ms to arrive.

### SDN Architecture

- **SDN controller** is the central brain. Think of it as the raid leader in an MMO — issues instructions, everyone else executes.
- **North-Bound APIs (NBI)** — face up toward apps and admins. Like the API your mobile banking app uses to talk to the bank's backend. Typically **REST-based with JSON or XML** payloads.
- **South-Bound APIs (SBI)** — face down toward the actual switches and routers. Use **OpenFlow, NETCONF, and YANG** to push configs and pull state.

### Underlay, Overlay, Fabric

- **Underlay** — the physical wires, switches, and routers actually carrying electrons. Runs boring reliable stuff like **OSPF and BGP**. This is the literal map terrain in GTA.
- **Overlay** — a virtual network drawn on top of the underlay using tunnels. Like fast-travel routes in Elden Ring — they don't exist physically, but they connect points across the real map. Uses **VXLAN** and **GRE** encapsulation.
- **Fabric** — when the controller manages overlay AND underlay together as one programmable system. Both layers move in lockstep instead of being managed separately.

### Cisco DNA Center

- Cisco's platform for **intent-based networking** — you describe *what* you want ("guest devices can't reach finance servers") and it figures out *how* to translate that into VLANs, ACLs, and policies.
- Provides **real-time health monitoring, topology visualization, and anomaly detection** — basically the minimap, kill feed, and threat radar for your network.
- Licensing tiers: **Essentials, Advantage, Premier** — cheaper tier, fewer abilities, like the difference between a base operator and a fully-kitted one in Rainbow Six Siege.

## Related concepts

[[Software-Defined Networking]]
[[REST APIs]]
[[NETCONF and YANG]]
[[OpenFlow]]
[[VXLAN]]
[[Intent-Based Networking]]
[[Cisco DNA Center]]
[[Spanning Tree Protocol]]
[[OSPF]]
[[BGP]]
[[Configuration Management Tools (Ansible, Puppet, Chef)]]