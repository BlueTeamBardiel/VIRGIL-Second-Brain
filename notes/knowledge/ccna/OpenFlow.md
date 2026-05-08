# OpenFlow

## What it is

In Stardew Valley, you don't farm your crops by hand every morning — you set up sprinklers, place them on specific tiles, and water flows according to the pattern you laid down. The plants don't decide when to drink; you, sitting up at the farmhouse, decided that for them when you placed the infrastructure. That's exactly what OpenFlow does — a controller tells switches in advance how to handle every packet they'll see, and the switches just execute the rules.

**OpenFlow** is a southbound [[SDN]] protocol that lets a centralized controller program the forwarding tables of network switches directly, separating the [[control plane]] from the [[data plane]].

## Why it matters

Traditional switches each run their own routing brain — every device independently deciding where packets go via [[OSPF]], [[EIGRP]], [[STP]], and friends. OpenFlow rips the brain out and puts it in one place. When it works, you get programmable, vendor-neutral networks that respond to applications instead of dragging their feet through distributed convergence. When the controller dies and the switches lose their flow rules, your network forgets how to forward packets. For the CCNA, you need to recognize OpenFlow as the canonical southbound API example and understand the controller-switch relationship — Cisco's exam favors [[OpenDaylight]] and [[Cisco APIC]] context.

## Key facts

### Architecture

- **Controller** sits north; **switches** sit south. They communicate over **TCP port 6653** (older deployments used **6633**), typically wrapped in [[TLS]].
- The controller pushes **flow entries** into each switch's **flow table**. The switch matches incoming packets against entries and applies actions. No match? Packet either gets dropped or punted to the controller via a `PACKET_IN` message.

### Flow table entries

Each flow entry has three core components:

| Field | Purpose |
|-------|---------|
| **Match fields** | Headers to match: ingress port, MAC, IP, TCP/UDP ports, VLAN, MPLS label — up to 40+ fields in OF 1.3 |
| **Counters** | Stats: packets matched, bytes, duration |
| **Instructions/Actions** | What to do: forward to port, drop, modify header, push/pop VLAN, send to controller, goto-table |

### Match-action paradigm

The fundamental loop:

1. Packet arrives at switch ingress port.
2. Switch walks the flow table(s) looking for a matching entry (highest priority wins).
3. On match → execute action set (forward, modify, drop, etc.).
4. On miss → table-miss entry decides: drop, or `PACKET_IN` to controller.
5. Controller decides policy, installs a new flow entry via `FLOW_MOD`, switch caches it for future packets.

### OpenFlow vs traditional routing

| Trait | Traditional | OpenFlow |
|-------|-------------|----------|
| Control plane location | On every device | Centralized controller |
| Forwarding logic | Protocols ([[OSPF]], [[BGP]]) | Flow entries pushed by controller |
| Configuration | CLI per device | Programmatic, network-wide |
| Granularity | Destination-based routing | Per-flow, multi-field matching |
| Failure mode | Local convergence | Depends on controller mode (proactive vs reactive flows) |

### Versions worth knowing

- **OF 1.0** — single flow table, IPv4-centric. The reference implementation.
- **OF 1.3** — multiple flow tables, IPv6, meters, group tables. The de facto standard in production.

### Proactive vs reactive flows

- **Proactive**: controller pre-populates flow entries. Fast, predictable, but assumes you know traffic patterns.
- **Reactive**: first packet of an unknown flow triggers `PACKET_IN`; controller decides on the fly. Flexible, but adds latency and controller load.

## Related concepts

[[SDN]] · [[Southbound API]] · [[Northbound API]] · [[Cisco APIC]] · [[OpenDaylight]] · [[Control plane]] · [[Data plane]] · [[Network automation]] · [[NETCONF]] · [[RESTCONF]]

---
*Source: VIRGIL knowledge base — 2026-05-07*