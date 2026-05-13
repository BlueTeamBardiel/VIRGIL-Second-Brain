# Copper Connectors

## What it is

In **Rainbow Six Siege**, Thermite's exothermic charge only works on reinforced walls. Hibana's X-Kairos pellets only stick to certain surfaces. Thatcher's EMP only kills electronics. Every gadget has a specific socket it's built for, and bringing the wrong tool to the wrong wall means you're standing in the hallway watching the round timer run out. That's exactly what copper connectors are — physical interfaces engineered for one cable type, one signal type, one job, and they refuse to do anyone else's.

In Network+ terms, a **copper connector** is the terminated end of a copper transmission medium — twisted pair, coaxial, or twinaxial — that mates with a specific port on a NIC, switch, patch panel, modem, or transceiver. Each connector type is tied to a cable construction, an impedance, and a protocol family. RJ45 doesn't fit an F-type jack. BNC doesn't fit a cable modem. You learn the shapes, you learn the pairings, you stop blowing rounds.

This note maps to [[Network Plus N10-009 Objective 1.5]] — transmission media and transceivers.

## Why it matters

Cabling is layer 1. Layer 1 is where 60% of "the internet is down" tickets actually live. A user kicks the cable under the desk, the RJ45 tab snaps off, the link light dies, and three people upstairs file tickets. You won't fix it by SSHing into a router. You fix it by knowing which connector belongs where and having a crimper in your bag.

On the exam, CompTIA will hand you a scenario — *"a technician needs to connect a cable modem to the coax drop"* — and expect you to pick the right connector from a list that includes three wrong answers designed to sound plausible. They will also test connector-to-cable pairing (BNC on coax, not on twisted pair), connector-to-use-case pairing (RJ11 for analog phone, RJ45 for Ethernet), and the niche stuff like twinaxial and DAC that lives in datacenters.

This is the kind of objective where rote memorization actually pays. There's no clever reasoning to get you from "F-type" to "screw-on coax connector for cable TV and cable modem drops." You either know it or you guess.

## Key facts

### RJ45 — the one you already know

**RJ45** (Registered Jack 45, technically 8P8C — eight position, eight conductor) is the standard connector for [[Ethernet]] over twisted pair. Every [[Cat5e]], [[Cat6]], [[Cat6a]], [[Cat7]], and [[Cat8]] cable in a normal building terminates in RJ45. Plugs into NICs, switches, routers, patch panels, wall jacks.

- **Pinout standards:** [[T568A]] and [[T568B]]. Same cable both ends = straight-through. Different ends = crossover (rarely needed now, modern switches do [[Auto-MDIX]]).
- **Distance limit:** 100 meters end-to-end for Ethernet over copper. This is a hard physical limit, not a guideline.
- **Speed depends on cable category**, not the connector itself — RJ45 on Cat5e gets you 1 Gbps; RJ45 on Cat6a gets you 10 Gbps over the full 100m.

### RJ11 — the phone jack that won't die

**RJ11** is the smaller cousin — typically 6P2C or 6P4C (six position, two or four conductor). It carries [[POTS]] (plain old telephone service), analog phone lines, and the WAN side of legacy [[DSL]] modems.

- Looks like a baby RJ45. Will physically fit into an RJ45 port and accomplish nothing.
- Two-pair cabling, not four-pair.
- If a user is plugging a phone cable into their Ethernet port and wondering why there's no internet, this is your culprit.

> **CompTIA exam trap:** RJ11 vs RJ45 is the classic "they look similar in the photo" question. RJ45 has 8 pins, RJ11 has 4 or 6. RJ11 is for **phone and DSL WAN**; RJ45 is for **Ethernet LAN**. If the scenario mentions a fax machine or analog handset, the answer is RJ11.

### F-type — coax for the cable guy

**F-type** is the screw-on threaded connector for [[coaxial cable]] — specifically [[RG-6]] and [[RG-59]]. This is the connector on the back of your cable modem, your cable TV box, and the wall plate where the ISP's coax drop terminates.

- 75-ohm impedance — matches RG-6/RG-59.
- Hand-tightened threaded barrel. No tools needed for the connection itself, though crimping or compressing the connector onto the cable does require a tool.
- Carries [[DOCSIS]] traffic for cable internet, broadcast TV, and satellite receivers.

### BNC — coax for the lab and the legacy rack

**Bayonet Neill–Concelman (BNC)** is the twist-and-lock coax connector. Push, quarter-turn, locked. Used for:

- Legacy [[10BASE-2]] Thinnet Ethernet (extinct in production, alive on the exam)
- Video equipment, broadcast SDI, CCTV
- Test equipment, oscilloscopes, RF lab work
- Some [[T1]] / [[E1]] / [[DS3]] WAN circuits in carrier environments

Two impedances exist: **50-ohm** (for data, RF, T-carrier) and **75-ohm** (for video). Mixing them causes signal reflection and packet loss. *I learned this the hard way wiring a video patchbay with 50-ohm BNC barrels — picture looked fine until it didn't, and "didn't" took two hours to diagnose.*

> **CompTIA exam trap:** F-type and BNC both terminate coax. **F-type = screw-on threads, cable internet / TV.** **BNC = bayonet twist-lock, legacy Ethernet, video, T1.** If the scenario says "cable modem," it's F-type. If it says "Thinnet" or "T1 circuit," it's BNC.

### Twinaxial and DAC — the datacenter shortcut

**Twinaxial cable** is two insulated copper conductors inside a single shielded jacket. Used almost exclusively in datacenters as **Direct Attach Copper ([[DAC]]) cables** — short-run pre-terminated cables that plug directly into [[SFP]], [[SFP+]], or [[QSFP]] ports on switches and servers.

- No transceiver electronics needed — the SFP-shaped housing on each end is passive (or active for longer runs).
- Common lengths: 1m, 3m, 5m, 7m. Distance limit roughly **7m for passive**, up to **15m for active** DAC.
- Speeds: 10 Gbps (SFP+), 25 Gbps (SFP28), 40 Gbps (QSFP+), 100 Gbps (QSFP28).
- Cheap and low-latency compared to fiber transceivers. Top-of-rack to server is almost always DAC.

DAC is technically a copper medium with a transceiver-form-factor connector, not a discrete connector type like RJ45. Exam questions love to put it next to fiber as a "which is cheaper for short-run 10G in a rack" answer. The answer is DAC.

### Connector-to-cable cheat sheet

| Connector | Cable type | Common use | Speed/standard |
|---|---|---|---|
| **RJ45** | Twisted pair (Cat5e–Cat8) | Ethernet LAN | 1 Gbps – 40 Gbps |
| **RJ11** | 2-pair twisted | Analog phone, DSL WAN | < 100 Mbps (DSL variable) |
| **F-type** | Coax (RG-6, RG-59) | Cable modem, TV | DOCSIS up to multi-Gbps |
| **BNC** | Coax (RG-58, RG-59) | Legacy Ethernet, video, T1 | 10 Mbps (Thinnet), varies |
| **DAC (SFP/QSFP housing)** | Twinaxial | Datacenter top-of-rack | 10 / 25 / 40 / 100 Gbps |

### Plenum vs non-plenum — the jacket matters

Not a connector concern, but the exam pairs it with this objective. **Plenum-rated cable** uses fire-resistant, low-smoke jacketing (often FEP) and is required for cable runs through air-handling spaces — drop ceilings, raised floors, anywhere HVAC air circulates. **Non-plenum (PVC)** is cheaper but produces toxic smoke when burned.

If the building inspector finds PVC cable in a plenum space, you're pulling it all out. *That's a six-figure mistake on a large install.* The connector on the end doesn't change, but the cable behind it absolutely does.

### Cable speeds — RJ45 over twisted pair

| Cable | Speed | Distance | Standard |
|---|---|---|---|
| Cat5e | 1 Gbps | 100m | 1000BASE-T |
| Cat6 | 1 Gbps full 100m; 10 Gbps at 55m | 100m / 55m | 10GBASE-T (limited) |
| Cat6a | 10 Gbps | 100m | 10GBASE-T |
| Cat7 | 10 Gbps | 100m | Shielded, GG45/TERA (rare) |
| Cat8 | 25/40 Gbps | 30m | Datacenter only |

> **CompTIA exam trap:** **Cat6 supports 10 Gbps only to 55 meters.** Cat6a is the cable you specify when you actually need 10G over a full 100m run. If a question asks for "10 Gbps Ethernet over copper at the maximum distance," the answer is Cat6a.

### CompTIA exam traps

> **Trap 1:** RJ45 is **8P8C**, not "RJ48" or "8P8" — CompTIA sometimes writes the technical designation as the distractor.

> **Trap 2:** Coax cable can use **F-type or BNC**. Don't assume coax = F-type just because that's what's on your home modem. T1 circuits in telco rooms use BNC on coax.

> **Trap 3:** DAC cables look like fiber transceivers but carry copper signals. They're listed under copper media on the objectives. If a question describes a "passive twinaxial cable with SFP+ ends," it's DAC, not fiber.

## Helpdesk reality

- User says: *"The internet jack in the wall isn't working."* You check: is the cable actually RJ45, or did they plug a phone cable (RJ11) into the Ethernet port? It physically fits. It physically does nothing.
- User says: *"My cable modem won't sync."* You check: is the F-type connector finger-tight on the back of the modem, and is the other end secure at the splitter or wall plate? Loose coax is the #1 cause of intermittent DOCSIS drops.
- User says: *"I bought a 100-foot Ethernet cable from Amazon and it's slow."* You check: cable category printed on the jacket. Cat5 (not 5e) caps at 100 Mbps. Cheap cables sometimes lie about their rating.
- Never promise *"I'll just swap the cable and it'll be fixed."* Sometimes the jack is bad. Sometimes the patch panel is bad. Sometimes the run was crushed by a desk chair for two years and the copper is fractured inside intact insulation.
- Escalation point: if you've replaced the patch cable, confirmed link light behavior at both ends, and run a cable tester on the structured run, and it still fails — it's a structured cabling ticket, not a help desk ticket. The cable contractor comes back out.

## Related concepts

[[Ethernet]] · [[Coaxial cable]] · [[Twisted pair cable]] · [[Fiber connectors]] · [[Transceivers SFP QSFP]] · [[Plenum cable]] · [[T568A vs T568B]] · [[Cable categories Cat5e Cat6 Cat6a]] · [[DOCSIS]] · [[Auto-MDIX]] · [[Network Plus N10-009 Objective 1.5]]

*Source: VIRGIL knowledge base — 2026-05-11*