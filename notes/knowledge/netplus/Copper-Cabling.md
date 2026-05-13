# Copper Cabling

## What it is

In **Factorio**, you don't start the game with logistic bots. You start with yellow belts, inserters, and copper wire stringing power between wooden poles. Those poles have a range — 7.5 tiles for small, 30 for big. Run a belt too far past its power source and the inserters at the end starve. Run copper power lines past their wire reach and the lamp at the end stays dark. You learn the limits fast, because the factory doesn't lie. *Copper has a reach. Past the reach, nothing works.*

That's exactly what copper network cabling is — the yellow belt of the network. Cheap, reliable, everywhere, and **distance-limited to 100 meters** for Ethernet over twisted pair. Run it farther and the signal degrades into noise.

Technically: copper cabling carries electrical signals between network endpoints across either **twisted-pair** ([[Ethernet]] over Cat5e/6/6a/7/8), **coaxial** (legacy networking, modern cable internet, RF), or **twinaxial** ([[Direct Attach Copper (DAC)]] for short-haul data center links). It dominates the access layer — every wall jack, every desk, every IP phone, every WAP backhaul — because it's cheap, terminable in the field with a $20 crimper, and powers devices over the same wires via [[PoE]].

## Why it matters

Copper is the cabling you will physically touch every day in IT. Fiber gets the glamour shots in marketing decks — copper gets pulled through ceilings at 11pm by techs in dusty polos. Knowing the categories, the connectors, the distance limits, and the plenum rules is the difference between a clean install and a fire marshal violation.

For N10-009, **Objective 1.5** asks you to compare and contrast transmission media. CompTIA tests cable categories, connectors (RJ45, RJ11, F-type, BNC), plenum vs. non-plenum, and the 100m rule until your eyes bleed. Expect at least two questions on category-to-speed mapping and at least one on connector-to-application.

## Key facts

### Twisted-pair categories — the table to memorize

| Category | Max Speed | Max Bandwidth | Max Distance | Shielding | Notes |
|----------|-----------|---------------|--------------|-----------|-------|
| **Cat3** | 10 Mbps | 16 MHz | 100m | UTP | Obsolete for data; still used for phone lines |
| **Cat5** | 100 Mbps | 100 MHz | 100m | UTP | Obsolete — replaced by 5e |
| **Cat5e** | 1 Gbps | 100 MHz | 100m | UTP | Minimum for modern gigabit |
| **Cat6** | 1 Gbps (10 Gbps to 55m) | 250 MHz | 100m / 55m for 10G | UTP or STP | Most common new install |
| **Cat6a** | 10 Gbps | 500 MHz | 100m | STP usually | True 10G to full distance |
| **Cat7** | 10 Gbps | 600 MHz | 100m | S/FTP | Uses GG45 or TERA, not RJ45 — rare in N. America |
| **Cat8** | 25/40 Gbps | 2000 MHz | **30m** | S/FTP | Data center top-of-rack only |

**The 100-meter rule** is the holy number. It applies to the entire channel: patch cable + horizontal run + patch cable. Not just the cable in the wall. Lose track of this and you'll spend an afternoon wondering why the AP at the end of a 95m run plus two 5m patches is dropping packets.

> **CompTIA exam trap:** Cat6 supports 10 Gbps **only to 55 meters**, not the full 100m. Cat6a is what you spec when you need 10 Gbps to the full 100m. If the question gives you "10GBASE-T to 100 meters," the answer is Cat6a or better — not Cat6.

### Shielding shorthand

- **UTP** — Unshielded Twisted Pair. Cheap, flexible, most common
- **STP** — Shielded Twisted Pair. Foil/braid around the whole bundle. Use near EMI sources (motors, fluorescent ballasts, elevator shafts)
- **F/UTP** — Foil shield around all four pairs, pairs themselves unshielded
- **S/FTP** — Braided shield over individually foil-shielded pairs. Cat7/Cat8 territory

Shielded cable requires shielded connectors and a properly bonded ground at the patch panel. Half-installed shielding is worse than UTP because it acts as an antenna.

### 802.3 Ethernet standards over copper

| Standard | Speed | Cable Minimum | Distance |
|----------|-------|---------------|----------|
| 10BASE-T | 10 Mbps | Cat3 | 100m |
| 100BASE-TX | 100 Mbps | Cat5 | 100m |
| 1000BASE-T | 1 Gbps | Cat5e | 100m |
| 2.5GBASE-T | 2.5 Gbps | Cat5e | 100m |
| 5GBASE-T | 5 Gbps | Cat6 | 100m |
| 10GBASE-T | 10 Gbps | Cat6a | 100m (Cat6: 55m) |
| 40GBASE-T | 40 Gbps | Cat8 | 30m |

[[802.3]] is the IEEE standard family for wired Ethernet. Memorize the cable-to-standard pairing — CompTIA will hand you a speed and ask the minimum cable.

### Connector types — what plugs into what

- **RJ45** — 8-position 8-conductor (8P8C). The Ethernet connector. Every twisted-pair data jack on Earth.
- **RJ11** — 6P2C or 6P4C. Smaller. **Phone lines and DSL**, not data. CompTIA loves the RJ11 vs RJ45 mix-up.
- **F-type** — Screw-on coaxial connector. Cable modems, TV. Threaded barrel.
- **BNC** — Bayonet Neill–Concelman. Twist-and-lock coaxial. Legacy 10BASE2/10BASE5 Ethernet, modern use is video (CCTV, broadcast, oscilloscope probes).

> **CompTIA exam trap:** RJ11 has up to 6 positions but typically 2 or 4 conductors. RJ45 has 8 positions and 8 conductors. If a question shows a small connector on a phone line — RJ11. The keyword is usually "telephone" or "DSL modem to wall."

### Coaxial cable

Single copper conductor surrounded by insulator, braided shield, outer jacket. Two flavors you'll see:

- **RG-6** — Modern cable internet, satellite. Thicker, better shielded, F-type connector
- **RG-59** — Older, thinner, used for CCTV and analog video. Lower bandwidth

Coax is what your [[Cable Modem]] connects to. The ISP's [[DOCSIS]] signal rides this from the pole to your house.

### Twinaxial and Direct Attach Copper (DAC)

[[Direct Attach Copper (DAC)]] cables are factory-terminated **twinaxial** cables with [[SFP]]/SFP+/QSFP transceivers permanently molded onto the ends. Used inside data center racks for short runs between switches and servers — typically **1 to 7 meters, max 10m**.

DAC is cheaper than fiber + optical transceivers and has lower latency than copper Ethernet because there's no PHY encoding overhead. You'll see 10G, 25G, 40G, and 100G DAC in the wild. They come in **passive** (no electronics, shorter reach) and **active** (signal conditioning, longer reach) flavors.

*The data center top-of-rack switch is connected to its servers with DAC, not Cat6. Cheaper, faster, denser, and you never have to crimp anything.*

### Plenum vs. non-plenum (the fire code conversation)

A **plenum space** is the air-return space above a drop ceiling or under a raised floor. Air for the HVAC system flows through it. If a fire starts in a plenum and the cable jacket is regular PVC, the cable burns, releases hydrogen chloride and other toxic gases, and the HVAC distributes the poison through the whole building.

- **Plenum-rated (CMP)** — Low-smoke, low-toxicity jacket (FEP or similar). Required in plenum spaces by NFPA and most local fire codes
- **Riser-rated (CMR)** — For vertical runs between floors. Less strict than plenum
- **PVC / general purpose (CM, CMG)** — Cheapest. Office walls, conduit, non-plenum only

Plenum cable costs 2-3x non-plenum. Run non-plenum in a plenum space and you get to pull it all out and reinstall, on your own time, after the inspector tags it.

> **CompTIA exam trap:** The question won't say "above the ceiling." It'll say "air-handling space" or "HVAC return." Same thing. Answer: plenum-rated.

### Cable speeds vs. cable categories — the difference

**Speed** is what the equipment negotiates (10/100/1000/2500/5000/10000 Mbps). **Category** is the cable's capability ceiling. A Cat6a cable plugged into a 1 Gbps switch runs at 1 Gbps. The cable can do 10G — the switch can't. Always spec cable for the next generation, not the current one. *Pulling cable through walls is expensive. Replacing switches is cheap by comparison.*

### Termination — T568A vs T568B

Two wiring standards for RJ45 termination. They differ only in the position of green and orange pairs. **Pick one and stick with it across the whole site.** Mixing them on opposite ends of the same cable creates a [[Crossover Cable]] — useful in legacy gear, useless on modern auto-MDI-X switches but it'll confuse the hell out of the next tech.

T568B is more common in North American commercial installs. T568A is the federal/residential default. *It does not matter which you choose. It matters that you are consistent.*

## CompTIA troubleshooting reality

When a copper link won't come up, work the OSI model from the bottom:

1. **Link light off?** L1 problem. Check cable seating, swap the patch cable, check the port on the switch
2. **Link light on, no traffic?** Possible duplex mismatch, wrong VLAN, or bad termination. Run a [[Cable Tester]] for continuity and a [[TDR]] for length and faults
3. **Intermittent drops?** Often EMI (cable run next to fluorescent ballasts or elevator motors) or a near-end crosstalk problem from bad termination. Re-terminate or move the run
4. **Works at 100 Mbps, not 1 Gbps?** Gigabit needs all 4 pairs. One broken pair drops you to 100M. Tester will show the broken pair

## Helpdesk reality

- User says "the internet is down" — first thing you check is the link light on the NIC and on the switch port. If both green, it's not L1
- User says "it was working yesterday" — someone moved a desk and yanked the cable. Look under the desk
- Never promise a cable run completion time to the user. Cable pulls hit unexpected walls, blocked conduits, and locked IDF closets constantly
- If the cable was working and suddenly isn't, and nobody touched it, suspect a punchdown working loose at the patch panel — not the cable itself
- Escalation point: if you've reseated, swapped patches, and tested continuity and the link still won't come up, it's a cabling/infrastructure ticket, not a desktop ticket

## Related concepts

[[Ethernet]] · [[Fiber Cabling]] · [[802.3]] · [[PoE]] · [[Cable Tester]] · [[TDR]] · [[Direct Attach Copper (DAC)]] · [[SFP]] · [[Crossover Cable]] · [[Patch Panel]] · [[Structured Cabling]] · [[DOCSIS]] · [[Cable Modem]]

*Source: VIRGIL knowledge base — 2026-05-11*