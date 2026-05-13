# Network Transceivers

## What it is

In **Death Stranding**, Sam Porter Bridges can't transmit anything until he plugs a region into the Chiral Network. Lake Knot City has its terminal, Mountain Knot has its terminal, and the Q-pid is the only thing that translates Sam's intent into a signal the network understands. Without the terminal — without the right interface at each endpoint — the cargo doesn't move and the call doesn't connect.

That's exactly what a transceiver does. It's the endpoint translator that turns electrical signals from a switch port into something a cable — copper, fiber, or air — can carry, and translates incoming signals back. **Transceiver** = transmitter + receiver, one module that does both.

Technically: a transceiver is a hardware module that handles physical-layer (OSI Layer 1) signal conversion between a networking device (switch, router, NIC, SAN controller) and the transmission medium. **Form factor** defines the physical shape and electrical interface to the host. **Connector type** defines what plugs into the transceiver. **Media** is what travels between transceivers — copper, glass, or radio waves.

Three things have to match for a link to come up: the transceiver on each end, the cable between them, and the protocol speed both sides negotiate. Get one wrong, no link light.

## Why it matters

Transceivers are where datacenter projects die. You order a switch, you order fiber, and you forget the SFPs — now you have a $40,000 switch with empty cages. Or worse, you order the wrong wavelength SFPs and the link won't come up and you spend a day with an OTDR before realizing the optics are mismatched.

For Net+ N10-009 Objective 1.5, CompTIA wants you to identify form factors (SFP, SFP+, QSFP, QSFP+, QSFP28), connector types (LC, SC, ST, MPO, RJ45, BNC, F-type), media (single-mode fiber, multimode fiber, twinax, coax, twisted pair), and speeds (1G, 10G, 25G, 40G, 100G, 400G). Expect scenarios — "you need 40Gbps between two switches three meters apart in the same rack" — and you pick the module and cable. Answer: QSFP+ with a DAC. Not fiber.

## Key facts

### Form factors — the module shape

| Form factor | Max speed | Typical use |
|---|---|---|
| **SFP** | 1 Gbps | Gigabit Ethernet, 1G/2G/4G Fibre Channel |
| **SFP+** | 10 Gbps | 10GbE, 8G/16G FC |
| **SFP28** | 25 Gbps | 25GbE |
| **QSFP** | 4 Gbps | Legacy 4×1G |
| **QSFP+** | 40 Gbps | 40GbE (4×10G lanes) |
| **QSFP28** | 100 Gbps | 100GbE (4×25G lanes) |
| **QSFP-DD** | 400 Gbps | 400GbE (8 lanes) |
| **GBIC** | 1 Gbps | Legacy, larger than SFP, deprecated |

The "Q" in QSFP stands for **quad** — four parallel lanes inside one module. A QSFP+ at 40G is four 10G channels bonded; a QSFP28 at 100G is four 25G. You can break out a QSFP into four SFPs with a fanout cable, which is how datacenters cable top-of-rack switches efficiently.

*GBIC and SFP look similar in pictures — SFP is half the width. CompTIA may test the size difference, not just the speed.*

### Connector types — what plugs into the transceiver

| Connector | Media | Notes |
|---|---|---|
| **LC** (Local Connector) | Fiber (SM or MM) | Small, latching, the dominant fiber connector today. Duplex pair = TX + RX. |
| **SC** (Subscriber Connector) | Fiber (SM or MM) | Square, push-pull, "stick and click." Older but still common in telco. |
| **ST** (Straight Tip) | Fiber (mostly MM) | Bayonet twist-lock, "stick and twist." Legacy. |
| **MPO/MTP** | Fiber ribbon | 12 or 24 fibers in one connector. Used for 40G/100G/400G QSFP optics. |
| **RJ45** | Cat5e/6/6a/8 copper | 8P8C, the Ethernet jack everyone knows. |
| **RJ11** | Cat3 / phone | 6P2C or 6P4C. Phones, DSL, fax. **Not Ethernet.** |
| **F-type** | Coaxial (RG-6) | Screw-on, used for cable internet and TV. |
| **BNC** | Coaxial (RG-58, RG-59) | Twist-lock, legacy 10BASE-2 Ethernet, broadcast video. |

> **CompTIA exam trap:** RJ45 vs RJ11. RJ45 is wider (8 pins vs 6) and carries Ethernet. An RJ11 phone cable physically fits loosely into an RJ45 jack and goes nowhere. CompTIA will hand you a scenario about a user plugging their phone cable into a network jack — the answer is wrong connector, not bad cable.

> **CompTIA exam trap:** SC is the **square** one ("Square = SC"). ST is the **straight tip** (bayonet, twist). LC is the **little** one (half the size of SC, the modern default). Memorize the three on sight.

### Single-mode vs. multimode fiber

| Feature | Single-mode (SMF) | Multimode (MMF) |
|---|---|---|
| Core diameter | 8–10 microns | 50 or 62.5 microns |
| Light source | Laser | LED or VCSEL |
| Distance | Up to 40 km+ (SR/LR/ER variants) | Up to ~400m at 10G (OM3/OM4) |
| Cost | Higher (optics expensive) | Lower (optics cheaper) |
| Jacket color (TIA) | Yellow | Orange (OM1/OM2), aqua (OM3/OM4), erika violet (OM5) |
| Use case | Long-haul, ISP, building-to-building | Inside datacenter, intra-building |

*Single-mode fiber is cheap. Single-mode optics are not. The glass costs the same as multimode by the meter — it's the lasers on each end that hurt the budget.*

SMF uses a tightly collimated laser down a narrow core so the signal stays coherent over long distances. MMF uses cheaper LEDs/VCSELs through a wider core, which causes **modal dispersion** — light bouncing at different angles arrives at slightly different times, limiting distance.

### Direct attach copper (DAC) and twinax

**DAC** is a passive copper cable with **transceivers permanently attached on both ends**. You buy a single SKU — "10G SFP+ DAC, 3m" — and it plugs into both switches. The cable inside is **twinaxial** (twinax) — two conductors with a shield, designed for high-frequency signaling.

When to use DAC:
- Short runs (≤7m passive, ≤15m active)
- Top-of-rack switch to server uplinks
- Cheaper and lower-latency than fiber optics for short runs
- No SFP needed separately — it's built in

*A DAC is the right answer almost every time the question says "two switches in the same rack" or "server to ToR switch."*

### Coaxial cable

Coax is a single copper conductor surrounded by insulation, a braided shield, and an outer jacket. Two flavors matter for Net+:

- **RG-6** with **F-type** connector: cable internet (DOCSIS), TV. The run from the street to your modem.
- **RG-58 / RG-59** with **BNC** connector: legacy 10BASE-2 Ethernet ("thinnet"), broadcast video, some industrial gear.

You will not run coax for new Ethernet. You will absolutely deal with it for the WAN handoff from a cable ISP.

### 802.3 and 802.11 — the standards behind the optics

**IEEE 802.3** is the Ethernet family — every wired transceiver speaks an 802.3 variant.

| Standard | Speed | Media | Distance |
|---|---|---|---|
| 1000BASE-T | 1 Gbps | Cat5e+ copper | 100m |
| 1000BASE-SX | 1 Gbps | MMF | 550m |
| 1000BASE-LX | 1 Gbps | SMF | 10 km |
| 10GBASE-T | 10 Gbps | Cat6a+ copper | 100m |
| 10GBASE-SR | 10 Gbps | MMF | 400m (OM4) |
| 10GBASE-LR | 10 Gbps | SMF | 10 km |
| 40GBASE-SR4 | 40 Gbps | MMF (MPO) | 150m |
| 100GBASE-LR4 | 100 Gbps | SMF | 10 km |

The suffix tells you the medium: **T** = twisted pair, **SR** = short-range MMF, **LR** = long-range SMF, **ER** = extended-range SMF.

**IEEE 802.11** is Wi-Fi. The transceiver is the radio in the AP and in your laptop. Same concept, no cable. See [[802.11 Wireless Standards]].

### Cellular and satellite

**Cellular** transceivers (LTE, 5G) are the radio modules in phones, IoT devices, and failover routers — see [[Cellular WAN]]. **Satellite** transceivers — dishes pointed at geostationary or LEO constellations (Starlink) — are also WAN endpoints. Geostationary latency is 500ms+; LEO is ~30ms.

### Fibre Channel (FC)

A separate protocol family from Ethernet, used for storage area networks (SANs). FC transceivers use the **same SFP/SFP+ form factors and LC connectors** as Ethernet, but they speak FC protocol at 2/4/8/16/32 Gbps. You cannot plug an Ethernet SFP into an FC switch and expect it to work — the host interface is the same shape, but the firmware on the optic identifies as one or the other.

### Plenum vs. non-plenum cable

Plenum-rated cable (CMP) uses fire-resistant jacketing (typically FEP) that doesn't release toxic smoke when burned. Required by code in **plenum spaces** — the air-return spaces above drop ceilings and below raised floors. Non-plenum (CMR, riser-rated, or PVC) is cheaper but illegal in plenum spaces.

> **CompTIA exam trap:** Plenum is about the **space**, not the cable. If the air handling system pulls return air through the ceiling, that ceiling is a plenum space, and every cable in it must be plenum-rated. Fire marshals will fail an inspection over this.

## Helpdesk reality

- User says "the network is down" — check the link light first. No light = layer 1. Reseat the SFP before you blame anything else.
- "I plugged in the new fiber and the link won't come up" — 80% of the time it's TX/RX swapped on a duplex LC pair. Swap one end. If that fails, wavelength mismatch (SR optic into an LR fiber run, or vice versa).
- Never promise a user that a 100m Cat6 run will hit 10Gbps if the cable was pulled around fluorescent ballasts and panel transformers. Crosstalk and EMI eat margin.
- If the SFP vendor doesn't match the switch vendor, some switches (Cisco especially) refuse to bring the link up. "Unsupported transceiver" — fix is `service unsupported-transceiver` or buy the vendor-branded optic.
- Escalation: if cable continuity is confirmed, transceiver type is correct, and the port is admin-up but still no link — network team ticket. Hand them the optic part numbers on both ends and the cable type.

## Related concepts

[[Copper Cabling]] · [[Fiber Optic Cabling]] · [[802.11 Wireless Standards]] · [[Ethernet Standards 802.3]] · [[Cellular WAN]] · [[Satellite WAN]] · [[OSI Model Layer 1]] · [[Switch Port Configuration]] · [[Structured Cabling]] · [[Fibre Channel SAN]]

*Source: VIRGIL knowledge base — 2026-05-11*