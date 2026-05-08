# SD-WAN

## What it is

In Pac-Man, the ghosts don't all take the same hallway to chase you — Blinky comes straight at you, Pinky cuts ahead, Inky flanks, Clyde wanders. They evaluate the maze and pick the path that fits their job. That's exactly what SD-WAN does — it looks at every available WAN link and sends each application down whichever path actually suits it, instead of forcing everything through one tunnel.

**SD-WAN** is a software-defined overlay architecture that abstracts WAN transport (MPLS, broadband, LTE, 5G) and centralizes control, policy, and application-aware path selection in a controller-driven fabric.

## Why it matters

Traditional WANs hairpin everything through HQ over expensive [[MPLS]] circuits, then break when one link degrades because routing protocols don't care about jitter or loss — only reachability. SD-WAN kills the hairpin, uses cheap internet alongside MPLS, and reroutes voice off a brownout link before the user finishes saying "can you hear me." On the **CCNA**, expect questions on the four-plane architecture and which device does what.

## Key facts

### The four planes (memorize this)

| Plane | Component | Job |
|---|---|---|
| **Orchestration** | [[vBond]] | Authenticates devices, NAT traversal, initial onboarding |
| **Management** | [[vManage]] | Single-pane GUI/API — config, monitoring, templates |
| **Control** | [[vSmart]] | Distributes routes, policies, crypto keys via [[OMP]] |
| **Data** | [[vEdge]] / [[cEdge]] | Forwards traffic, builds [[IPsec]] tunnels |

### Edge routers

- **vEdge** — original Viptela hardware/software, runs Viptela OS.
- **cEdge** — Cisco IOS-XE with SD-WAN image (ISR/ASR/Catalyst 8000). Same fabric role, different OS.

### Control protocol

[[OMP]] (Overlay Management Protocol) runs between [[vSmart]] and edges over [[DTLS]]/[[TLS]]. Think of it as [[BGP]] for the overlay — advertises prefixes, [[TLOC]]s (Transport Locators), and service routes.

### Dynamic path selection

Edges measure each tunnel continuously via **[[BFD]]** (default 1000 ms hello, 7x multiplier on vEdge). Metrics tracked:
- **Loss** (%)
- **Latency** (ms)
- **Jitter** (ms)

### Application-aware routing (AAR)

Define an **SLA class**, bind it to apps, let the fabric pick a tunnel that meets it.

```
policy
 sla-class VOICE_SLA
  loss 1
  latency 150
  jitter 30
 app-route-policy VOICE_AAR
  vpn-list CORPORATE
   sequence 10
    match
     app-list VOICE
    action
     sla-class VOICE_SLA preferred-color mpls
```

If MPLS violates the SLA, voice slides over to biz-internet automatically. No human required.

### Policy types

- **Centralized control policy** — applied on [[vSmart]], shapes route advertisements (topology: hub-spoke, full-mesh, regional).
- **Centralized data policy** — applied at edge, but configured centrally; matches traffic and steers it.
- **Localized policy** — QoS, ACLs, route maps pushed to a specific edge.

### Transport abstraction — TLOCs

A **[[TLOC]]** = `{system-IP, color, encapsulation}`. "Color" tags the transport (mpls, biz-internet, lte, public-internet). Policy references colors, not IPs — swap a circuit, policy doesn't change.

### Onboarding flow (ZTP)

1. Edge boots, contacts **[[vBond]]** (FQDN or IP).
2. vBond authenticates via certificate, returns vManage + vSmart info.
3. Edge builds DTLS to vManage → pulls config template.
4. Edge builds DTLS to vSmart → receives [[OMP]] routes and policy.
5. Edges build [[IPsec]] tunnels to each other across all colors.

### Cisco SD-WAN heritage

Cisco bought **Viptela** in 2017. The vEdge/vSmart/vBond/vManage stack *is* Viptela. Cisco then ported the data plane onto IOS-XE and called it **cEdge**. Both coexist in the same fabric.

## Related concepts

[[SDN]] · [[MPLS]] · [[OMP]] · [[TLOC]] · [[IPsec]] · [[BFD]] · [[DMVPN]] · [[QoS]] · [[Overlay-Network]] · [[Zero-Touch-Provisioning]]

---
*Source: VIRGIL knowledge base — 2026-05-07*