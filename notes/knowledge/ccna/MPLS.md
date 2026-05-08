# MPLS

## What it is

In **World of Warcraft**, when you take a flight path from Stormwind to Ironforge, you don't manually steer the gryphon at every fork in the sky — you click the destination once, and the gryphon follows a pre-tagged route the whole way there. That's exactly what **MPLS** does: instead of every router in the ISP core looking up the destination IP, the first router slaps a label on the packet and everyone downstream just reads the label and forwards along the predetermined path.

**Multiprotocol Label Switching (MPLS)** is a forwarding technique where routers make forwarding decisions based on a 20-bit label inserted between the L2 header and the L3 header (the "shim header"), rather than performing a full IP routing table lookup at every hop.

## Why it matters

ISPs run hundreds of thousands of routes in their core. Doing a longest-prefix-match IP lookup at every hop is expensive; reading a fixed 20-bit label is cheap and fast. More importantly, MPLS enables services that pure IP routing cannot — **MPLS VPNs** let one provider backbone carry traffic for thousands of customers with overlapping IP ranges, isolated from each other. When MPLS breaks, you get black-holed traffic, leaked VPN routes between customers (a small career-ending event), or sudden CPU spikes on P routers forced to fall back to IP lookups.

## Key facts

### The label and the shim header

The MPLS header is **32 bits total**, sitting between Layer 2 and Layer 3:

| Field | Size | Purpose |
|-------|------|---------|
| **Label** | 20 bits | The forwarding identifier (~1M values) |
| **TC (EXP)** | 3 bits | [[QoS]] traffic class |
| **S (Bottom of Stack)** | 1 bit | 1 = last label in the stack |
| **TTL** | 8 bits | Like IP TTL, for loop prevention |

Labels can be **stacked** — multiple labels on one packet. The bottom label often identifies a [[VPN]]; the top label identifies the [[LSP]] across the core.

### Router roles (memorize these — exam favorite)

| Role | Full name | Speaks MPLS? | Job |
|------|-----------|--------------|-----|
| **CE** | [[Customer Edge]] | **No** | Customer's own router. Just runs IP. Has no idea MPLS exists. |
| **PE** | [[Provider Edge]] | Yes | ISP edge router. **Pushes** label onto incoming packets, **pops** label on outgoing. Runs [[VRF]] tables. |
| **P** | [[Provider]] (core) | Yes | ISP core router. Only **swaps** labels. Never sees customer IPs. |

The CE router is blissfully ignorant. The P router is willfully ignorant. Only the PE knows what's actually going on.

### Label operations

- **PUSH** — PE adds a label to an incoming IP packet (ingress).
- **SWAP** — P router replaces the incoming label with an outgoing label per its [[LFIB]] (Label Forwarding Information Base).
- **POP** — Label removed. Often done one hop early via [[Penultimate Hop Popping]] (PHP) so the egress PE doesn't waste cycles doing both a label lookup and an IP lookup.

### LDP — how labels get distributed

[[LDP]] (Label Distribution Protocol) is how routers agree on which label means what.

- Runs on **TCP port 646** (and UDP 646 for hello discovery).
- Each router advertises its **local labels** for each prefix in its [[IGP]] table.
- Neighbors learn: "to reach 10.1.1.0/24 via router X, use label 17."
- The end-to-end path of label-switched hops is the **LSP** ([[Label Switched Path]]).

```
mpls ip                          ! enable MPLS on the router
interface GigabitEthernet0/0
 mpls ip                         ! enable LDP on this interface
mpls ldp router-id Loopback0 force
show mpls ldp neighbor
show mpls forwarding-table
```

### MPLS VPN — the actual reason ISPs deploy this

[[MPLS VPN]] uses [[VRF]] (Virtual Routing and Forwarding) on PE routers — separate routing tables per customer, so Customer A's 10.0.0.0/8 doesn't collide with Customer B's 10.0.0.0/8.

**L3VPN (Layer 3 VPN):**
- PE peers with CE using [[BGP]], [[OSPF]], or static routes.
- Customer routes carried across the provider core via [[MP-BGP]] (Multiprotocol BGP) with [[VPNv4]] addresses (route distinguisher + IPv4 prefix).
- Two labels: outer label for the LSP, inner label identifies the VRF/VPN.
- Customer sees the provider as one big router.

**L2VPN (Layer 2 VPN):**
- Provider transports raw L2 frames (Ethernet, frame relay) across the MPLS core.
- Customer sees the provider as a wire or a switch — runs their own routing end-to-end.
- Variants: [[VPWS]] (point-to-point pseudowire), [[VPLS]] (multipoint, emulates a LAN).

| Feature | L3VPN | L2VPN |
|---------|-------|-------|
| Provider sees | Customer IP routes | Just frames |
| Customer routing protocol | Peers with PE | End-to-end, ISP doesn't care |
| Provider role | Active L3 participant | Dumb pipe |
| Use case | Standard enterprise WAN | Customer wants full control |

### IP routing vs label switching

| | IP Routing | MPLS |
|---|---|---|
| Lookup | Longest-prefix match on dest IP | Exact match on 20-bit label |
| Per-hop cost | Higher | Lower |
| Path control | Follows IGP shortest path | Can engineer paths ([[MPLS-TE]]) |
| VPN support | Native? No. | Native via VRF + MP-BGP |

## Related concepts

[[LDP]] · [[LSP]] · [[VRF]] · [[MP-BGP]] · [[VPNv4]] · [[Customer Edge]] · [[Provider Edge]] · [[Penultimate Hop Popping]] · [[VPLS]] · [[VPWS]] · [[BGP]] · [[OSPF]] · [[QoS]] · [[MPLS-TE]]

---
*Source: VIRGIL knowledge base*