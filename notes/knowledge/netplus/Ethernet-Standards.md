# Ethernet Standards

## What it is

In **Sekiro**, every Prosthetic Tool slot uses the same mechanical mount on Wolf's left arm, but the tool you screw into it — Loaded Shuriken, Flame Vent, Mist Raven, Sabimaru — changes what the arm does. The mount is standard. The capability isn't. Swap the tool, swap the function. Same wrist, different weapon.

That's exactly what Ethernet transceivers and connectors do. The switch port is the mount. The transceiver (SFP, QSFP, RJ45 jack) is the tool you slot in. The cable plugged into the transceiver determines whether you're throwing copper at 1 Gbps to a desk 50 meters away, or single-mode fiber at 100 Gbps to a data center 40 kilometers away.

In N10-009 terms: **Ethernet** is the IEEE **802.3** family of wired LAN standards. It defines how bits get framed, addressed (MAC), and pushed onto a physical medium — copper, fiber, or coax. **Wireless** LAN is the **802.11** family — same OSI L2 framing concept, different physical layer. The transceiver is the L1 component that converts the switch's electrical signals into whatever the medium needs: electrical pulses on copper, light pulses on fiber, modulated RF on wireless.

## Why it matters

Objective 1.5 is the one CompTIA uses to drown people. It's not conceptual — it's memorization. Connector types, cable speeds, distance limits, fiber modes, form factors. The exam writes scenarios like *"100 Gbps between two data center racks, 5 meters apart, cheapest option"* and expects you to answer **DAC cable** without flinching.

In the field, this is the layer you touch every day. Wrong transceiver, no link. Wrong fiber mode, no link. Bent fiber past its minimum bend radius, intermittent link that drives you insane for three days. *Layer 1 is where careers are made and weekends are lost.*

## Key facts

### 802.3 Ethernet standards — speeds and media

| Standard | Speed | Medium | Max distance |
|---|---|---|---|
| 10BASE-T | 10 Mbps | Cat3+ copper | 100 m |
| 100BASE-TX | 100 Mbps | Cat5+ copper | 100 m |
| 1000BASE-T | 1 Gbps | Cat5e+ copper | 100 m |
| 1000BASE-SX | 1 Gbps | Multimode fiber | 550 m |
| 1000BASE-LX | 1 Gbps | Single-mode fiber | 10 km |
| 10GBASE-T | 10 Gbps | Cat6a+ copper | 100 m (Cat6: 55 m) |
| 10GBASE-SR | 10 Gbps | Multimode fiber | 300–400 m |
| 10GBASE-LR | 10 Gbps | Single-mode fiber | 10 km |
| 40GBASE-SR4 | 40 Gbps | Multimode (MPO) | 100–150 m |
| 100GBASE-SR4 | 100 Gbps | Multimode (MPO) | 100 m |
| 100GBASE-LR4 | 100 Gbps | Single-mode | 10 km |

The pattern: **T = twisted pair copper, S = short-reach multimode fiber, L = long-reach single-mode fiber, R = serial encoding (10G+)**. The number before BASE is the speed in Mbps or Gbps.

### Copper cabling

**RJ45** is the eight-pin connector on every Ethernet patch cable you've ever held. Wired to **T568A** or **T568B** standard — both work for straight-through cables as long as both ends match.

**Cat ratings** determine speed and distance:

| Category | Max speed | Notes |
|---|---|---|
| Cat5 | 100 Mbps | Obsolete |
| Cat5e | 1 Gbps | Minimum acceptable today |
| Cat6 | 10 Gbps @ 55 m | 1 Gbps full 100 m |
| Cat6a | 10 Gbps @ 100 m | Shielded options for noisy environments |
| Cat7 | 10 Gbps | Proprietary, not IEEE-recognized; skip it |
| Cat8 | 25/40 Gbps @ 30 m | Data center top-of-rack only |

**100 meters** is the magic copper number for Ethernet. Past that, signal attenuation kills the link or kicks it down to a slower speed. *I have personally watched a 102-meter Cat6 run negotiate at 100 Mbps instead of 1 Gbps for six months before anyone questioned it.*

**Plenum vs. non-plenum**: Plenum-rated cable (CMP) uses fire-resistant jacket material — FEP instead of PVC — and goes in air-handling spaces (above drop ceilings, under raised floors where HVAC return air flows). Non-plenum (CMR, riser-rated, or general-purpose CMG) is cheaper and goes everywhere else. Burning PVC produces hydrogen chloride gas. Plenum spaces feed every room in the building. Fire code is not optional.

> **CompTIA exam trap:** If the question mentions air handling, return air, drop ceilings, or HVAC ducts — the answer is **plenum**. Never the cheaper option. The exam is testing whether you know the fire code applies, not which is cheaper.

**RJ11** is the smaller four/six-pin connector — telephone lines and DSL, not Ethernet. CompTIA will offer it as a wrong answer when the right answer is RJ45.

### Coaxial cable

**Coaxial** carries a single conductor wrapped in insulation, shielding, and jacket. Used for cable internet, cable TV, and legacy 10BASE-2/10BASE-5 Ethernet (long dead).

- **RG-6**: Modern cable internet, satellite TV. Thicker shielding, better for high-frequency.
- **RG-59**: Older CCTV and short-run video. Don't use for broadband.

**Connector types on coax:**
- **F-type** — the screw-on connector on the back of your cable modem and TV. Cable internet, OTA antenna, satellite TV.
- **BNC (Bayonet Neill–Concelman)** — twist-and-lock. Legacy 10BASE-2 Ethernet, CCTV, some lab equipment, broadcast video.

> **CompTIA exam trap:** F-type screws on. BNC twists and locks with a quarter-turn bayonet. The exam will ask which connector is which. Cable modem = F-type. Old security camera = BNC.

### Twinaxial and DAC

**Twinaxial cable** has two inner conductors instead of one. **Direct Attach Copper (DAC)** is a twinaxial assembly with SFP+/QSFP+ transceivers permanently fused to both ends. You don't terminate it. You don't choose the transceiver. It comes as one piece.

DAC is the answer to *"connect two switches in the same rack at 10/25/40/100 Gbps cheaply."* Distance limit is short — typically **7 meters for passive DAC, up to ~15 m for active DAC.** Inside a rack or between adjacent racks, DAC beats fiber on cost and latency.

*If the question says "two switches, same rack, 3 meters apart, 25 Gbps" — the answer is DAC. Always.*

### Fiber optic cable

Fiber sends light pulses down a glass core. Immune to EMI, longer distances than copper, higher speeds.

**Single-mode (SMF):**
- Core ~9 microns
- Yellow jacket (industry convention)
- Long-distance: 10 km, 40 km, 80 km+
- Laser light source
- More expensive transceivers, cheaper cable

**Multimode (MMF):**
- Core 50 or 62.5 microns
- Aqua jacket (OM3/OM4/OM5) or orange (OM1/OM2)
- Short-distance: 300 m to ~2 km depending on OM rating and speed
- LED or VCSEL light source
- Cheaper transceivers

| OM grade | Color | 10G distance | 40/100G distance |
|---|---|---|---|
| OM1 | Orange | 33 m | not supported |
| OM2 | Orange | 82 m | not supported |
| OM3 | Aqua | 300 m | 100 m |
| OM4 | Aqua | 400 m | 150 m |
| OM5 | Lime green | 400 m | 150 m+ (wideband) |

> **CompTIA exam trap:** Distance question. **Building-to-building across campus, 5 km** = single-mode. **Inside one data center, between rows** = multimode. The cheap answer (multimode) is wrong past ~400 m. The expensive answer (single-mode) is wrong inside a single rack.

### Fiber connectors

- **LC (Local Connector)** — small form factor, push-pull latch, the modern default. Two fibers in one clip = duplex LC. The connector you see on every SFP today.
- **SC (Subscriber Connector)** — square, push-pull. Older, larger than LC. Still common in patch panels and ISP equipment.
- **ST (Straight Tip)** — round, bayonet twist-lock. Older multimode installations. Looks like a fiber BNC.
- **MPO/MTP (Multi-fiber Push On)** — ribbon connector carrying 8, 12, or 24 fibers in one plug. Required for 40G/100G parallel optics (40GBASE-SR4 uses 4 transmit + 4 receive fibers).

*Mnemonic: LC = Little Connector. SC = Square Connector. ST = Stick-and-Twist. MPO = Many fibers, Push On.*

### Transceiver form factors

The transceiver is the swappable optic that plugs into the switch port — Wolf's Prosthetic Tool slot.

| Form factor | Max speed | Typical use |
|---|---|---|
| **SFP** | 1 Gbps | Standard 1G fiber/copper uplinks |
| **SFP+** | 10 Gbps | 10G data center, server uplinks |
| **SFP28** | 25 Gbps | Modern server NICs |
| **QSFP+** | 40 Gbps | 4× 10G lanes, MPO fiber or DAC |
| **QSFP28** | 100 Gbps | 4× 25G lanes, data center spine |
| **QSFP-DD** | 400 Gbps | 8 lanes, hyperscale |

**SFP = Small Form-factor Pluggable.** **QSFP = Quad SFP** (four lanes in one cage). Transceivers are hot-swappable. Vendor lock-in is real — Cisco switches often reject third-party SFPs unless you toggle `service unsupported-transceiver`. Buy compatible optics from a reputable third party and you'll save 80% on optics with zero functional difference.

### Fibre Channel (FC)

Not to be confused with fiber optic Ethernet. **Fibre Channel** is a separate protocol for **Storage Area Networks (SAN)** — block-level storage traffic between servers and disk arrays. Runs at 8/16/32/64 Gbps over fiber (usually) with its own SFP+ optics. **FCoE** (Fibre Channel over Ethernet) tunnels FC frames over 10G+ Ethernet to consolidate SAN and LAN onto one fabric. Net+ wants you to recognize the name, not configure it.

### Wireless (802.11) and cellular

**802.11** wireless standards live in their own note, but for 1.5 know:

| Standard | Marketing name | Max speed | Band |
|---|---|---|---|
| 802.11n | Wi-Fi 4 | 600 Mbps | 2.4/5 GHz |
| 802.11ac | Wi-Fi 5 | ~3.5 Gbps | 5 GHz |
| 802.11ax | Wi-Fi 6/6E | ~9.6 Gbps | 2.4/5/6 GHz |
| 802.11be | Wi-Fi 7 | ~46 Gbps | 2.4/5/6 GHz |

**Cellular** (4G LTE, 5G) and **satellite** (Starlink, geostationary VSAT) are wireless WAN technologies — covered in WAN topics. For 1.5, just recognize them as wireless transmission media alongside Wi-Fi.

## Helpdesk reality

- *"My internet is slow."* → Check the link speed on the NIC first. A Cat5 cable in a Cat6 jack negotiating at 100 Mbps instead of 1 Gbps will feel slow forever.
- *"The cable looks fine."* → It doesn't. Get a cable tester. Visual inspection catches maybe 30% of bad terminations.
- *"Can we just run a longer cable?"* → Not past 100 meters of copper. After that, you need a switch in between, fiber, or a media converter. Don't promise 150-meter runs.
- *"Why is the fiber link flapping?"* → Dirty connector. Bent past minimum bend radius. Wrong mode (multimode transceiver on single-mode cable, or vice versa). In that order.
- *"The SFP we ordered doesn't work."* → Vendor compatibility. Check the switch's supported optics list. Then check it's the right mode (SR vs LR) for the cable.

## Related concepts

[[OSI Model]] · [[Cabling and Termination]] · [[802.11 Wireless Standards]] · [[Network Topologies]] · [[Transceivers and Form Factors]] · [[Fiber Optic Troubleshooting]] · [[Structured Cabling]] · [[PoE]]

*Source: VIRGIL knowledge base — 2026-05-11*