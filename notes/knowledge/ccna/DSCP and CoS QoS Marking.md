# DSCP and CoS QoS Marking

## What it is

In **Zelda: Breath of the Wild**, when you hold up a weapon to Link's quick-select wheel, the game pauses everything else and routes that input first — your bomb throw doesn't get stuck behind your horse-whistle. That's exactly what QoS marking does — it stamps a label on each packet so routers know which traffic is the bomb throw and which is the horse whistle.

**DSCP** is a 6-bit priority value in the IP header; **CoS** is a 3-bit priority value in the 802.1Q VLAN tag.

## Why it matters

Without marking, your router treats a VoIP packet identically to someone's Windows update — both go in the same FIFO queue, and when the link congests, voice quality dies in audible, career-ending ways. Markings are the foundation every other QoS mechanism ([[queuing]], [[policing]], [[shaping]]) reads to make decisions. On the CCNA, expect questions on **EF=46**, the bit positions, and where each marking lives in the frame.

## Key facts

### DSCP — Differentiated Services Code Point

- **6 bits** in the [[IPv4]] **ToS byte** (also reused in [[IPv6]] Traffic Class)
- **Values 0–63**, occupying the high-order 6 bits of the [[DiffServ]] field
- The remaining 2 bits are [[ECN]] (Explicit Congestion Notification)
- Layer 3 — survives across [[router]] hops as long as nobody re-marks it
- Replaces the older 3-bit **IP Precedence** field (which lives in the same bits, hence backward compatibility via [[CS class|Class Selector]])

### Key DSCP values to memorize

| Name | Decimal | Use case |
|---|---|---|
| **Default (DF)** | 0 | Best effort — the peasant queue |
| **CS1–CS7** | 8,16,24,32,40,48,56 | Class Selector, mimics IP Precedence 1–7 |
| **AF11** | 10 | Low-drop, low-priority data |
| **AF21** | 18 | Low-drop, medium |
| **AF31** | 26 | Low-drop, high |
| **AF41** | 34 | Video conferencing |
| **AF43** | 38 | Same class, higher drop preference |
| **EF** | **46** | **Expedited Forwarding — voice (VoIP RTP)** |
| **CS6** | 48 | Network control ([[OSPF]], [[BGP]]) |
| **CS7** | 56 | Reserved |

### AF naming logic — AFxy

- **x** = class (1–4), higher = better priority
- **y** = drop precedence (1–3), higher = dropped first when congested
- Formula: `DSCP = 8x + 2y`. AF31 → 8(3) + 2(1) = 26. Now you can derive any AF value under exam pressure.

### CoS — Class of Service

- **3 bits** in the **802.1Q** VLAN tag's **PCP** ([[Priority Code Point]]) field
- **Values 0–7** — only 8 levels, vs. DSCP's 64
- **Layer 2 only** — lives in the [[Ethernet frame]] tag
- **Stripped at the L3 boundary**: the moment a [[router]] decapsulates the frame, CoS is gone. If the next-hop link is access (untagged) or a different L2 medium, your marking evaporates.
- Default voice CoS = **5**, signaling = **3**, video = **4**

### Trust boundaries

A **trust boundary** is the point in the network where you start believing the markings on incoming packets. Everything outside it is suspect — users will mark their Call of Duty traffic as EF if you let them.

- Place it as close to the source as possible — typically the [[access switch]] port
- Trust IP phones (they mark voice EF/CoS 5 themselves), don't trust the PC behind them
- Beyond the boundary: re-mark or zero-out incoming markings

### Cisco CLI

Older [[MLS QoS]] syntax (Catalyst):

```
Switch(config)# mls qos
Switch(config-if)# mls qos trust dscp
Switch(config-if)# mls qos trust cos
Switch(config-if)# mls qos trust device cisco-phone
```

Modern [[MQC]] (Modular QoS CLI) marking:

```
Router(config)# class-map match-all VOICE
Router(config-cmap)# match protocol rtp
Router(config)# policy-map MARK-INGRESS
Router(config-pmap)# class VOICE
Router(config-pmap-c)# set dscp ef
Router(config)# interface Gi0/1
Router(config-if)# service-policy input MARK-INGRESS
```

### Why mark at ingress

Marking is cheap once, expensive everywhere. Classify and mark at the **first trusted hop**, then every device downstream just reads the label and queues accordingly. Re-classifying deep packet contents at every hop wastes CPU and defeats the entire point of [[DiffServ]] (per-hop behavior).

### Gotchas

- DSCP-to-CoS mapping is **not** automatic across the L2/L3 boundary unless configured — defaults exist but they're crude
- CoS only exists on **trunk** links (access ports have no 802.1Q tag, hence no PCP)
- Default `mls qos` on older switches **rewrites all markings to 0** the moment you enable it globally — read the docs before flipping the switch in production

## Related concepts

[[DiffServ]] · [[QoS]] · [[802.1Q]] · [[Priority Code Point]] · [[ToS byte]] · [[ECN]] · [[Expedited Forwarding]] · [[Assured Forwarding]] · [[Class Selector]] · [[MLS QoS]] · [[MQC]] · [[Trust Boundary]] · [[Policing]] · [[Shaping]] · [[LLQ]] · [[VoIP]] · [[RTP]]

---
*Source: VIRGIL knowledge base*