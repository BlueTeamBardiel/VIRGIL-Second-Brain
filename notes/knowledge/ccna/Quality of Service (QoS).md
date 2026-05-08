# Quality of Service (QoS)

## What it is

In Valorant, your callout of "two on A site" needs to land in your teammate's ear *now*, not after Riot's voice server finishes shipping someone else's match replay. That's exactly what QoS does — it tells the network "voice and game packets go first, everything else waits." It doesn't make your connection faster; it just decides whose packet gets to cross the wire when the wire is full.

More precisely: QoS is a set of mechanisms on switches and routers that **classify** traffic, **mark** it with a priority tag, and then **queue, drop, or smooth** it during congestion. The whole point is that real-time traffic (voice, video, game packets) cannot tolerate delay or jitter, while bulk traffic (Steam downloads, backups, email) can wait 200ms and nobody dies — or, in Valorant terms, nobody eats a Jett dash to the face because their "he's behind you" callout arrived a second late.

A common deployment scenario: a VoIP phone sits on a desk, and a PC plugs into the back of that phone. Both share one cable run to the switch, but the phone's voice packets need VIP treatment while the PC's Spotify stream can ride coach. QoS plus VLAN tagging is what makes that coexistence work.

## Why it matters

Bandwidth is finite, and congestion is when reality slaps your network. Without QoS, a single user torrenting Linux ISOs can make every Zoom call in the building sound like a Cyberpunk 2077 glitched NPC. With QoS, the network enforces a pecking order — voice frames jump the queue, gaming traffic gets low-latency lanes, and the bulk transfer fills whatever's left.

QoS also matters because **VoIP phones changed how access ports work**. A single switch port now carries two logically separate conversations (voice + data), powers the phone over the same copper, and has to keep the voice frames from getting trampled by the PC's traffic. Every piece below — PoE, voice VLANs, DSCP, queuing — exists to make that one cable work reliably.

## Key facts

### VoIP phones and the access port

- A VoIP phone is a tiny purpose-built computer that turns your voice into IP packets and shoves them onto Ethernet — same as any other host, just with a handset.
- Inside the phone is a **3-port mini-switch**: one port faces the upstream switch, one faces the PC daisy-chained behind the phone, and one feeds the phone's own CPU. The phone is essentially a pass-through hub with a brain.
- The access port on the upstream switch supports **dual VLAN membership**: a **data VLAN** (untagged, for the PC) and a **voice VLAN** (tagged with 802.1Q, for the phone). Same wire, two VLANs, distinguished by whether the frame carries a VLAN tag — like a co-op game where Player 1 uses controller and Player 2 uses keyboard on the same screen.

### Power over Ethernet (PoE)

- PoE delivers electricity and data on the same twisted pair by using **different frequency ranges** — power is low-frequency DC-ish, data is high-frequency. They don't interfere, similar to how Wi-Fi 2.4 GHz and 5 GHz coexist on one router.
- **PSE (Power Sourcing Equipment)** = the switch (or injector) supplying juice. **PD (Powered Device)** = the phone, AP, or camera drinking it.
- The PoE handshake walks through four stages: **Detection → Classification → Startup → Normal operation**. Detection checks if there's actually a PD on the other end (don't fry a regular PC), Classification negotiates how much power it needs, Startup ramps up, then Normal flows steady-state.
- Power classes (budget the PSE reserves per port):
  - **Class 1**: 3.84 W — sensors, basic gear
  - **Class 2**: 6.49 W — entry-level phones
  - **Class 3**: 15.4 W — standard PoE, most IP phones and APs
  - **Class 4**: 30 W — PoE+, pan-tilt-zoom cameras, higher-end APs
  - **Class 5**: 45 W — PoE++, multi-radio APs, video bars

### Classification and marking

- **Classification** is the bouncer checking IDs. It inspects source/destination IP, port number, protocol, DSCP marking, or VLAN ID to decide what bucket a packet belongs in.
- **ToS field** — the legacy 8-bit field in the IPv4 header (range 0–255). Old-school priority marking, mostly superseded.
- **DSCP** (Differentiated Services Code Point) — uses the **upper 6 bits** of that ToS byte, giving values **0–63**. This is the modern Layer 3 marking. Think of it as the loot rarity tag on a packet — common, rare, epic, legendary.
  - **DSCP 0** = Best Effort (the default, peasant-tier)
  - **DSCP 46** = Expedited Forwarding (EF) — voice and video, the legendary tier
  - **DSCP 48** = CS6 — control plane traffic (routing protocols, the stuff that keeps the network itself alive)
- **CoS** (Class of Service) — Layer 2 marking, **3 bits inside the 802.1Q VLAN tag**, range **0–7**. CoS only exists on tagged frames, which is exactly why voice traffic is tagged — so it can carry a CoS value while the PC's untagged data can't.

### Queuing strategies

When packets pile up at an interface, the queuing discipline decides who gets serviced first. This is the matchmaking lobby of QoS.

- **FIFO** — First In, First Out. No priority, no fairness, just a single line. Whoever showed up first leaves first. Fine until someone's torrent fills the queue ahead of your voice packet.
- **Priority Queuing (PQ)** — strict hierarchy. The high-priority queue must be **completely empty** before the low-priority queue gets serviced. Great for voice, terrible for bulk traffic if voice never stops (starvation risk — the low queue can sit forever, like the support main who never gets healed back).
- **WFQ (Weighted Fair Queuing)** — each traffic class gets a **percentage of bandwidth**. Nobody starves; everyone gets a slice proportional to their weight.
- **CBWFQ (Class-Based WFQ)** — admin-defined version of WFQ. You explicitly create traffic classes (voice, video, scavenger, default) and assign each a bandwidth guarantee. Custom raid composition instead of auto-matchmaking.

### Policing vs. Shaping

Both control how much traffic a link will accept, but they handle "too much" very differently.

- **Policing** — hard cap. Traffic over the limit gets **dropped or remarked** to a lower priority. Applied on **ingress** (incoming traffic). It's the velvet rope at the club: over capacity? You're not getting in.
- **Shaping** — soft cap. Excess traffic gets **buffered** and released at the configured rate. Applied on **egress** (outgoing traffic). It's the queue system in Helldivers 2 when servers are full — you wait, you don't get rejected.
- Rule of thumb: policing punishes bursts, shaping smooths them. Use shaping when the other side will drop your packets if you exceed contracted rate (avoid the drop by self-regulating).

## Related concepts

- [[802.1Q VLAN Tagging]]
- [[Voice VLAN]]
- [[Power over Ethernet (PoE/PoE+/PoE++)]]
- [[DSCP and IP Precedence]]
- [[Class of Service (CoS)]]
- [[Congestion Management]]
- [[Traffic Shaping and Policing]]
- [[VoIP and SIP]]
- [[Access Ports vs Trunk Ports]]
- [[Jitter, Latency, and Packet Loss]]