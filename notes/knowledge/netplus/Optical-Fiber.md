# Optical Fiber

## What it is

In **The Witcher 3**, Geralt's medallion vibrates when magic is near — not because it's magic itself, but because it's a passive resonator that responds to chaos in the air. Light travels down a fiber optic cable the same way: the glass doesn't generate anything, it just guides photons by exploiting **total internal reflection** off the boundary between the dense core and the less-dense cladding. Pulse goes in one end, bounces along the walls like a signal in a Place of Power, comes out the other end. No copper. No electrons. No EMI. Just light.

In plain English: fiber optic cable transmits data as pulses of laser or LED light through a hair-thin strand of ultra-pure glass. The glass has two layers — a **core** where the light actually travels, and a **cladding** with a slightly different refractive index that keeps the light bouncing inward instead of leaking out. A protective buffer and jacket wrap the strand so it survives being pulled through conduit.

Technical N10-009 definition: optical fiber is a guided transmission medium using glass or plastic strands to carry modulated light signals. It comes in two operational modes — **single-mode (SMF)** with a ~9 micron core for long-haul laser transmission, and **multimode (MMF)** with a 50 or 62.5 micron core for short-haul LED or VCSEL transmission. Terminations use connectors (LC, SC, ST, MPO) mated to transceivers (SFP, SFP+, QSFP) that plug into switches, routers, and NICs.

## Why it matters

Fiber is how the internet actually works. Every transatlantic cable, every ISP backbone, every data center spine — fiber. Copper hits a wall at 100 meters for Ethernet and gets eaten alive by electromagnetic interference. Fiber runs kilometers without a repeater, immune to EMI, immune to crosstalk, and impossible to tap without detection because bending it leaks light the monitoring system can see.

For Net+ specifically, **Objective 1.5** wants you to compare and contrast transmission media. That means you must know which fiber type goes how far, which connector mates with which transceiver, and why you'd pick MPO over LC for a 40 Gigabit uplink. CompTIA will give you a scenario — "10 km run between two campus buildings at 10 Gbps" — and expect you to instantly say *single-mode, LC connectors, SFP+ with a long-reach optic*. Get the mode wrong and the link literally doesn't come up.

Career-wise: if you can't terminate, test, and troubleshoot fiber, you cap out at SOHO and small business work. Data centers run on fiber. ISPs run on fiber. Anyone touching enterprise-grade networking needs to read a fiber loss budget and use an OTDR. *This is the line between cable monkey and network engineer.*

## Key facts

### Single-mode vs. multimode

| Property | Single-mode (SMF) | Multimode (MMF) |
|---|---|---|
| Core diameter | ~9 µm | 50 µm or 62.5 µm |
| Light source | Laser | LED or VCSEL |
| Jacket color (standard) | Yellow | Orange (OM1/OM2), Aqua (OM3/OM4), Lime (OM5) |
| Typical distance | 10 km – 80+ km | 300 m – 550 m at 10G; less at higher speeds |
| Cost per cable | Cheap | Slightly more expensive |
| Cost per transceiver | Expensive (laser optics) | Cheap (LED/VCSEL optics) |
| Use case | WAN, campus backbone, ISP | Data center, in-building |

Multimode grades matter:

- **OM1** — 62.5 µm, orange, legacy, 1G short reach only
- **OM2** — 50 µm, orange, 1G longer reach
- **OM3** — 50 µm, aqua, laser-optimized, 10G to 300m
- **OM4** — 50 µm, aqua, 10G to 400m, 40/100G short reach
- **OM5** — 50 µm, lime, wideband multimode for SWDM

> **CompTIA exam trap:** Single-mode is cheaper *cable* but more expensive *optics*. Multimode is the opposite. If a question asks about total deployment cost over a short run with lots of links, multimode wins. Over a long run, single-mode is the only option and the optics cost is irrelevant because there's no alternative.

### Connector types

Memorize these. CompTIA will show you a picture or describe the latch mechanism and you must name it.

| Connector | Form | Mnemonic |
|---|---|---|
| **LC** (Local Connector) | Small, square, plastic latch, usually duplex | "Little Connector" — half the size of SC |
| **SC** (Subscriber Connector) | Square, push-pull, larger than LC | "Square Connector" or "Stick and Click" |
| **ST** (Straight Tip) | Round, bayonet twist-lock | "Stick and Twist" |
| **MPO/MTP** (Multi-fiber Push On) | Wide rectangular ribbon, 12 or 24 fibers in one connector | Used for 40G/100G parallel optics |

LC dominates modern data centers because density matters — you can fit twice as many LC ports on a switch faceplate as SC. ST is legacy, mostly seen in old building risers. MPO is mandatory for 40GBASE-SR4 and 100GBASE-SR10 because those standards use multiple parallel lanes of fiber simultaneously.

### Transceiver form factors

The transceiver is the swappable module that converts electrical signals from the switch ASIC into light pulses on the fiber. Pull it out, swap it for a different reach or speed, plug it back in. No need to replace the switch.

| Form factor | Speed | Common use |
|---|---|---|
| **SFP** (Small Form-factor Pluggable) | 1 Gbps | Gigabit fiber and copper |
| **SFP+** | 10 Gbps | 10G data center uplinks |
| **SFP28** | 25 Gbps | Modern ToR-to-server |
| **QSFP+** (Quad SFP) | 40 Gbps | 4× 10G lanes |
| **QSFP28** | 100 Gbps | 4× 25G lanes |
| **QSFP-DD** | 400 Gbps | 8× 50G lanes |

QSFP is physically larger than SFP because it carries four parallel lanes. You cannot plug SFP into a QSFP cage or vice versa.

### DAC and twinaxial — the copper exception

**Direct Attach Copper (DAC)** cables are SFP+/QSFP+ on both ends with a fixed **twinaxial copper** cable between them. They look like fiber jumpers but they're copper inside. Used for short data center runs (typically under 7 meters, 10m max for passive) between top-of-rack switch and server.

Why DAC instead of fiber? Cheaper, lower power, lower latency. Why not for longer runs? Copper signal degradation at 10G+ kills you past 10 meters.

*This is the trap — DAC isn't fiber, even though it lives in fiber-shaped connectors.*

### 802.3 Ethernet over fiber — speed and distance

| Standard | Speed | Media | Max distance |
|---|---|---|---|
| 1000BASE-SX | 1 Gbps | MMF | 550 m (OM3) |
| 1000BASE-LX | 1 Gbps | SMF | 5–10 km |
| 10GBASE-SR | 10 Gbps | MMF | 300–400 m (OM3/OM4) |
| 10GBASE-LR | 10 Gbps | SMF | 10 km |
| 10GBASE-ER | 10 Gbps | SMF | 40 km |
| 40GBASE-SR4 | 40 Gbps | MMF (MPO) | 100–150 m |
| 40GBASE-LR4 | 40 Gbps | SMF | 10 km |
| 100GBASE-SR10 | 100 Gbps | MMF (MPO) | 100 m |
| 100GBASE-LR4 | 100 Gbps | SMF | 10 km |

Letter code: **S** = Short (multimode), **L** = Long (single-mode), **E** = Extended (single-mode, longest).

### Fibre Channel (FC) — the storage cousin

**Fibre Channel** is a separate protocol from Ethernet, used in [[Storage Area Network|SANs]] to connect servers to storage arrays. Runs over the same fiber media and uses LC connectors, but speaks FC, not IP. Speeds: 8, 16, 32, 64, 128 Gbps. **FCoE** (Fibre Channel over Ethernet) encapsulates FC inside Ethernet frames for converged data center fabrics.

Note the spelling — CompTIA uses "Fibre" (British) for the protocol and "fiber" (American) for the physical media. Same word, different context.

### Plenum vs. non-plenum

**Plenum-rated** fiber cable uses a fire-retardant jacket (typically FEP or low-smoke PVC alternatives) safe to run through air-handling spaces — the plenum above drop ceilings where HVAC pulls return air. Non-plenum (PVC) jackets release toxic smoke when burned and are illegal in plenum spaces by NFPA code.

> **CompTIA exam trap:** Plenum vs. non-plenum is about the *jacket*, not the *fiber inside*. The glass doesn't care. You can have plenum-rated SMF and non-plenum SMF — identical optical performance, different fire behavior. If a question mentions running cable above a drop ceiling, the answer involves plenum.

### CompTIA exam traps

> **CompTIA exam trap:** You cannot mix SMF and MMF on the same link, and you cannot use an MMF transceiver with SMF cable (or vice versa) — the optics expect a specific core diameter. The link will either not come up or will work intermittently with massive errors. CompTIA loves "intermittent connectivity" scenarios where the answer is "wrong fiber mode."

> **CompTIA exam trap:** Bend radius matters. Fiber has a minimum bend radius — typically 10× the cable diameter for installed cable. Bend it tighter and you cause **macrobends** that leak light and increase loss. CompTIA may describe a cable "zip-tied tightly around a conduit" as the cause of intermittent issues.

> **CompTIA exam trap:** Dirty connectors are the #1 cause of fiber problems in the field. A speck of dust on a ferrule scatters more light than a kilometer of clean fiber attenuates. Always clean and inspect before mating. The right answer to "intermittent fiber link, no obvious damage" is usually *clean the connectors*.

## Helpdesk reality

- User says: "The internet is down in the new conference room." Tech checks: link light on the patch panel, link light on the switch, both ends of the fiber jumper, then swaps the jumper. 80% of the time it's the jumper or a dirty LC connector.
- User says: "It worked this morning." Ask what changed. Did facilities run new cable through the ceiling? Did someone reorganize the MDF? Fiber doesn't degrade overnight — *someone touched it.*
- Never promise a fiber repair in under an hour. If the actual glass is broken (not just a connector), you need a splice kit or a fusion splicer and someone who knows how to use one. That's a vendor call, not a help desk fix.
- If you've ruled out the patch jumper, the transceiver, and the connector cleanliness on the client side, it's a network team ticket. They have the OTDR and the loss budget for the run.
- The link light is your first and best friend. No light = layer 1. Don't troubleshoot layer 3 until layer 1 is green on both ends.

## Related concepts

[[Copper Cabling]] · [[Ethernet Standards]] · [[Transceivers and Form Factors]] · [[Plenum and Riser Cable]] · [[Connector Types]] · [[Storage Area Network]] · [[Fibre Channel]] · [[Data Center Topology]] · [[Cable Testing and OTDR]] · [[Direct Attach Copper]]

*Source: VIRGIL knowledge base — 2026-05-11*