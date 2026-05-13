# Network Cables

## What it is

A run of Cat6 from a wall jack to a switch is the machine's voice and ears made physical — copper or glass that carries every packet between the network stack and the rest of the world. Pull on the wrong end at the patch panel and an entire floor goes silent.

Plain English: network cables are the wires that move data between computers, switches, routers, and the internet. Some are copper (twisted pair, coax), some are glass (fiber). The category, connector, and length determine how fast they go and how far.

Technical: physical-layer transmission media for Ethernet (IEEE 802.3) and related standards. Twisted-pair copper carries balanced differential signals to cancel electromagnetic interference; coax uses a single shielded conductor; fiber uses light pulses through a glass core. Each medium has defined category specs (Cat5e, Cat6, Cat6a, Cat7, Cat8), connector types (RJ45, F-type, LC, SC, ST), and distance/bandwidth limits set by the standard.

Wait — the objective bullet says "internet connection types" and "network types," not cables. Right. This note covers both, because the cable in your hand is determined by the connection type entering your building and the network type you're wiring. You can't talk about DSL without talking about the phone line. You can't talk about a SAN without talking about fiber channel. The cable is the artifact; the connection and network type are the context.

## Why it matters

A+ techs run cables. You will crimp RJ45s, terminate keystone jacks, fish Cat6 through drop ceilings, and trace dead runs with a tone generator at 4 PM on a Friday. The exam tests every connector type, every category spec, every connection variant — because in the field, picking the wrong cable kills the link before the user even reports the ticket. Objective 220-1201 2.7 covers internet connection types and network types; Objective 2.6 covers the cables and connectors themselves. They overlap constantly in real work, so we cover them together.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Twisted-pair copper categories define bandwidth and distance: Cat5e handles 1 Gbps to 100m, Cat6 handles 1 Gbps to 100m or 10 Gbps to 55m, Cat6a handles 10 Gbps to 100m, Cat8 handles 25/40 Gbps to 30m (data center patch use). Connectors are 8P8C, universally called RJ45. Coax for internet service uses RG-6 with F-type screw-on connectors. Fiber comes in two flavors: multimode (OM3/OM4, short range, cheaper transceivers, orange or aqua jacket) and single-mode (OS1/OS2, long range, yellow jacket, more expensive optics). Common fiber connectors: LC (small form factor, dominant today), SC (square, push-pull), ST (bayonet, legacy). Plenum-rated cable (CMP) is required in air-handling spaces — it costs more and burns without releasing toxic smoke. Riser-rated (CMR) is for vertical runs between floors. Don't substitute.

**Beat 2 — Feynman example via your home setup.** You're wiring your apartment for the homelab.

**The run from the ONT to your router:** Coax came into the wall from the ISP, terminated at a cable modem with an F-type connector. Or fiber came in, terminated at an ONT (optical network terminal) with an SC connector inside the box. The ISP owns up to that demarc; everything past it is yours. *Know where the demarc is — that's where finger-pointing starts on every outage call.*

**The run from your router to the switch in the closet:** Cat6 patch cable, 3 feet, pre-made, RJ45 on both ends. Don't crimp this yourself. Factory terminations are cleaner than anything you'll do with a $30 crimper. *Buy patch cables. Crimp only what you must.*

**The run from the closet to the gaming rig in the back bedroom:** 60 feet of Cat6 solid-core through the wall, terminated into keystone jacks at both ends, short patch cables on each side. Solid-core in walls, stranded for patch — solid is for fixed runs, stranded flexes without breaking. *Never run stranded inside a wall. It will fatigue and fail.*

**The run that matters:** the unlabeled cable. You'll do a clean install, feel proud, and six months later you'll be standing at the patch panel with a tone generator wondering which of these eleven blue cables goes to the printer. *Label every cable at both ends, the day you run it. Future-you is already begging.*

**Beat 3 — Bridge to the enterprise.** Same homelab question — what cable, where, why — scales to a corporate network closet and changes everything. The patch panel has 48 ports instead of 4. Runs are documented in a structured cabling diagram with cable IDs that match labels at both ends. Every horizontal run from the IDF to the workstation is certified with a Fluke tester after install — wire map, length, NEXT, return loss, pass/fail printed report filed with facilities. Backbone runs between floors are fiber, usually OM4 multimode for in-building, OS2 single-mode for between buildings on a campus. The data center uses Cat6a or fiber for top-of-rack-to-server, with structured overhead trays and color-coded jackets (blue for data, red for management, yellow for out-of-band). The internet handoff is a fiber pair from the ISP into a demarc extension, then into the edge router. There's a service contract on it. When it breaks, you call the carrier — you don't touch their fiber.

**Beat 4 — The point.** Same fundamental question every time: what's the medium, what's the distance, what's the bandwidth, what's the environment? Home or data center, the cable is chosen by answering those four. Get the question into your bones — you'll ask it for the rest of your career, and the answer will keep changing as standards advance.

## Key facts

### Internet connection types

| Type | Medium | Typical speeds | Notes |
|---|---|---|---|
| **Fiber (FTTH/FTTP)** | Single-mode fiber to ONT | 500 Mbps – 10 Gbps symmetric | Best available; latency is excellent; expanding rapidly |
| **Cable** | Coax (RG-6) to cable modem | 100 Mbps – 2 Gbps down, asymmetric up | DOCSIS standard; shared neighborhood bandwidth |
| **DSL** | Twisted-pair phone line to DSL modem | 5 – 100 Mbps, distance-limited | Dying; requires copper phone infrastructure; ADSL asymmetric, VDSL faster |
| **Satellite** | Dish + LNB to modem | 25 – 250 Mbps | High latency on geostationary (HughesNet, Viasat); low latency on LEO (Starlink) |
| **Cellular (4G/5G)** | Radio to cell tower | 50 Mbps – 1 Gbps on 5G | Used for fixed wireless home internet, hotspots, failover |
| **WISP (Wireless ISP)** | Point-to-point fixed wireless | 25 – 500 Mbps | Rural areas; line-of-sight to tower required |

### Network types

| Type | Scope | Example |
|---|---|---|
| **PAN (Personal Area Network)** | A few meters around one person | Bluetooth headphones, AirDrop, smartwatch |
| **LAN (Local Area Network)** | A building or campus | Office Ethernet, home network |
| **WLAN (Wireless LAN)** | A building, wireless | Office Wi-Fi, home Wi-Fi |
| **MAN (Metropolitan Area Network)** | A city | City government fiber, university metro link |
| **WAN (Wide Area Network)** | Region, country, global | The internet itself; corporate MPLS between sites |
| **SAN (Storage Area Network)** | Data center storage fabric | Fibre Channel or iSCSI between servers and storage arrays |

### Cable categories — the high-yield table

| Category | Bandwidth | Max distance | Use case |
|---|---|---|---|
| **Cat5e** | 1 Gbps | 100 m | Legacy office runs, still everywhere |
| **Cat6** | 1 Gbps @ 100m, 10 Gbps @ 55m | 100 m / 55 m | Current default for new office installs |
| **Cat6a** | 10 Gbps | 100 m | New builds, future-proofed runs |
| **Cat7** | 10 Gbps, shielded | 100 m | Niche; uses GG45 connectors, rarely deployed |
| **Cat8** | 25/40 Gbps | 30 m | Data center top-of-rack patching only |

### Connectors you must recognize

- **RJ45 (8P8C)** — Ethernet on twisted pair
- **RJ11 (6P2C/6P4C)** — old phone, DSL line input
- **F-type** — coax, screw-on, cable modem and TV
- **LC** — small fiber, dominant in modern data centers
- **SC** — square push-pull fiber, common at ONTs
- **ST** — bayonet fiber, legacy

### CompTIA exam traps

> **Cat6 vs Cat6a distance:** Cat6 supports 10 Gbps only to **55 meters**, not 100. Cat6a supports 10 Gbps to the full 100 meters. CompTIA tests this exact distinction.

> **SAN vs NAS:** A **SAN** is a dedicated block-storage fabric (Fibre Channel or iSCSI), accessed by servers as if it were local disk. **NAS** is file-level storage over standard Ethernet (SMB/NFS). The exam will offer both — pick SAN when the question mentions block storage, low latency, or dedicated storage network.

> **Plenum vs riser:** **Plenum (CMP)** goes in air-handling spaces (above drop ceilings that return air to HVAC). **Riser (CMR)** goes vertically between floors. Plenum can substitute for riser; riser cannot substitute for plenum. Fire code violation if you get this wrong.

> **DSL vs Cable wiring:** DSL runs over the **phone line (RJ11)**. Cable runs over **coax (F-type)**. CompTIA loves swapping these in answer choices.

> **Single-mode vs multimode:** Single-mode = **long distance, yellow jacket, laser source, more expensive**. Multimode = **short distance, orange/aqua jacket, LED or VCSEL source, cheaper**. Don't mix transceivers across modes — the link won't come up.

## Helpdesk reality

- "The internet is down." → First question: is it the whole office or just you? Second question: any lights on the modem/router? You're triaging from layer 1 up before you touch anything.
- "I moved my desk and now the network doesn't work." → They unplugged the patch cable and either lost it or jammed it back into the wrong port. Walk them through reseating, then verify the link light. If no link light, the cable's bent past its bend radius or the keystone is loose.
- "I need a longer cable." → Ask the run length before you hand them anything. 100m is the absolute Ethernet limit on copper. If they need more, you're running fiber or adding a switch midway. Never promise "any length works."
- A user sends a photo of a wall jack with cables hanging out. Drop it into your company-approved AI assistant to confirm jack type and termination standard before you dispatch — but never paste customer-identifying photos into a non-approved tool.
- "Can I just use the cable from my old printer?" → Maybe. RJ11 phone cable looks like RJ45 to a panicking user. Verify the connector before you let them plug anything into a switch port.

## Related concepts

[[Cables and Connectors]] · [[TCP-IP and Networking Basics]] · [[Wireless Networking]] · [[SOHO Network Setup]] · [[Network Devices]] · [[ISP and WAN Technologies]]

*Source: VIRGIL knowledge base — 2026-05-10*