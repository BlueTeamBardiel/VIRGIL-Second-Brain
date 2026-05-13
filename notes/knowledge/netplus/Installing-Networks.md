# Installing Networks

## What it is

In **Need for Speed: Underground 2**, before you ever hit the streets you sit in the garage. Engine, turbo, tires, NOS, ECU — every part has a slot, a weight, a power draw, a heat profile. Stack a stage 3 turbo on a stock fuel pump and the car runs lean and grenades the block on the highway. Bolt a wide body on stock suspension and it understeers into a wall. The garage isn't glamorous, but every race is won or lost there.

That's exactly what physical network installation is — the garage build before the network serves a packet. Power, cooling, rack space, cable routing, environmental controls. Get it wrong here and no amount of clever configuration saves you at 2am when the AC dies.

Technically: **physical installation** covers the facilities-layer decisions that determine whether the network survives — the **MDF** and **IDF** rooms, **rack** layout, **PDU** and **UPS** power feeds, **patch panels** and **fiber distribution panels**, and the environmental controls (temperature, humidity, fire suppression, physical security) that keep silicon alive. N10-009 Objective 2.4.

## Why it matters

The job interview question for any new network tech: *"Walk me through what's in your MDF."* If you can't answer, you don't get the job. Physical installation is the first thing an auditor checks, the first thing insurance asks about after a fire, and the first thing that fails on a hot July afternoon.

On the exam, expect direct questions on **MDF vs IDF**, **rack U sizing**, **UPS vs PDU**, **port-side exhaust direction**, and the **environmental ranges** (temperature 64–80°F / 18–27°C, humidity 40–60% RH). CompTIA also loves the trick: *"Where do you install the fiber backbone termination?"* — the fiber distribution panel in the MDF, not a generic patch panel.

In the field, this separates the tech who escalates to facilities when the room hits 95°F from the tech who reboots switches until they die.

## Key facts

### MDF and IDF — the spine and the branches

The **Main Distribution Frame (MDF)** is the central network room for the building. It houses the core switch, the router or firewall connecting to the ISP, the demarcation point where the carrier circuit lands, and the backbone terminations for every floor or wing.

The **Intermediate Distribution Frame (IDF)** is the wiring closet on each floor or zone. It houses the access-layer switches that cubicles, conference rooms, and APs plug into. Copper runs from the IDF out to the work area; fiber or copper backbone runs back to the MDF.

| Room | Role | What lives there | How many |
|---|---|---|---|
| **MDF** | Building core | Core switch, edge router, firewall, ISP demarc, fiber distribution panel, server gear | One per building |
| **IDF** | Floor/zone access | Access switches, copper patch panels, UPS, PoE budget for local APs | One per floor or per ~100m cable radius |

The 100m rule drives IDF placement. Cat6/6a horizontal runs max out at **100 meters** end-to-end. Drop an IDF wherever you need to reach a workstation within that limit.

*The MDF is the heart. The IDFs are the capillaries. You don't put the heart on the third floor.*

### Racks — the chassis

Network gear lives in **19-inch racks** measured in **U** (rack units), where **1U = 1.75 inches**:

- **42U** — full-height data center rack
- **24U / 27U** — half-height, common in IDF closets
- **12U / 9U** — wall-mount, small office or branch
- **2-post vs 4-post** — 2-post for patch panels and switches, 4-post for servers (heavy and deep)

**Rack planning:** count your gear, add 30% for growth, leave 1U gaps between heat-generating devices, reserve space at the top for cable management. Switch = 1U. Patch panel = 1U or 2U. UPS = 2U–4U. A 1U server weighs more than a switch — put it low.

### Power — the fuel system

**UPS (Uninterruptible Power Supply)** — battery backup. Rides out blips, gives you 5–30 minutes to shut down gracefully. Also conditions power: surge protection, voltage regulation. Every MDF and IDF needs one sized to its load.

**PDU (Power Distribution Unit)** — the rack-mounted power strip on steroids. Takes high-amperage feeds from the room and distributes them to outlets in the rack. Smart PDUs report per-outlet draw and remotely power-cycle frozen devices.

**Power load** — the math. Every device has a watt rating. Add them up, add 20–30% headroom, size your UPS and PDU to that number. A 24-port PoE+ switch with all ports lit can pull 800W just for PoE budget, plus 150W for the switch itself. Plan worst case.

**Voltage** — North American racks take **120V** for low-draw gear and **208V** or **240V** for high-draw gear. Most of the rest of the world is **230V**.

> **CompTIA exam trap:** A UPS is not a generator. UPS = battery, minutes of runtime. Generator = fuel, hours of runtime. The exam will offer "UPS" as the answer to "how do we survive a 4-hour outage" — wrong. UPS bridges to generator OR bridges to shutdown.

### Airflow — port-side exhaust vs intake

Modern switches let you choose airflow direction: **port-side exhaust** (air flows from back to port side) or **port-side intake** (port side to back).

Data centers use **hot aisle / cold aisle** layouts. Cold air rises through perforated tiles in the cold aisle. Hot exhaust dumps into the hot aisle. You want all gear oriented the same way so you don't recirculate hot exhaust as someone else's intake.

If switches face the cold aisle with their ports, you want **port-side intake**. If they face the hot aisle with their ports, you want **port-side exhaust**. Mixed orientation = thermal chaos = early hardware death.

*The rack that breathes the same direction lives. The rack that fights itself melts.*

### Cabling — patch panels and fiber distribution panels

**Patch panel** — the punch-down termination point for copper horizontal runs. Cable comes from the wall jack, lands on the back of the panel, and a short patch cord jumps from the front to the switch port. You never plug a horizontal run directly into a switch — patch panels exist so you can re-cable without disturbing the in-wall run.

**Fiber distribution panel** — same idea for fiber. Backbone fiber from another building, floor, or the ISP terminates in the fiber panel (LC, SC, or MTP connectors), and short patch fiber jumps to the switch's SFP. Fiber panels also house splice trays.

Cable management: vertical and horizontal managers, velcro (never zip ties — they crush conductors), labels at both ends of every cable. Untraceable cables turn outages into all-day adventures.

### Environmental — temperature, humidity, fire, locks

| Factor | Target range | Why it kills gear |
|---|---|---|
| **Temperature** | 64–80°F (18–27°C) | Silicon throttles above 85°F, fails above 100°F sustained |
| **Humidity** | 40–60% RH | Below 40% = static; above 60% = condensation, corrosion |
| **Fire suppression** | Clean agent (FM-200, Novec 1230, inert gas) | Water sprinklers destroy electronics; clean agents displace oxygen without wetting gear |
| **Physical security** | Lockable doors, badge readers, camera coverage | Physical access defeats every logical control |

Pre-action sprinklers (water held back until two triggers fire) are acceptable; wet-pipe sprinklers over a server rack are a resume-generating event. Every IDF gets a lock. Every MDF gets a lock plus access logging — *a network you can touch is a network you don't own.*

### CompTIA exam traps

> **CompTIA exam trap:** MDF vs IDF. The MDF is where the **ISP demarcation** lands and where backbone fiber terminates. The IDF is the **floor closet** for horizontal runs. If the question mentions "ISP," "demarc," "core," or "carrier" — MDF. If it mentions "floor," "closet," "100 meters," or "access switch" — IDF.

> **CompTIA exam trap:** Patch panel vs fiber distribution panel. Patch panel = copper, RJ45. Fiber distribution panel = fiber, LC/SC/MTP. If the question mentions fiber backbone, the answer is fiber distribution panel even if "patch panel" is also offered.

> **CompTIA exam trap:** Humidity is bidirectional. Too dry = static. Too humid = corrosion. The exam loves to offer "increase humidity" as a fix when the actual answer is "maintain 40–60% RH" — both extremes kill gear.

## Helpdesk reality

- User says: *"The internet is slow on the third floor."* You check the IDF. The closet is 92°F because someone propped the door open and the AC vent is blocked by a box of toner. Switch is thermal-throttling. Fix the airflow before you touch a config.
- User says: *"My computer keeps disconnecting."* You check the patch panel. The cable label is missing, the patch cord is a 25-foot bird-nest behind the rack, and one strand is kinked at a 90° bend. Replace the patch cord. Document it this time.
- Never promise: *"The new IDF will be ready next week."* Facilities, electrical, HVAC, and cabling contractors all have to coordinate. New closets take a month minimum.
- Escalation: power load math, UPS sizing, fire suppression spec, and HVAC capacity are facilities-and-electrical work, not network-tech work. You spec the gear and the load; they spec the room.
- The 2am call: when a UPS battery alarm goes off, the battery is dying — not the power. Replace UPS batteries every 3–5 years on a schedule. The UPS that "always worked" is the UPS that fails the night of the actual outage.

## Related concepts

[[Cabling Standards]] · [[Fiber Optic Cabling]] · [[Copper Cabling]] · [[Power over Ethernet (PoE)]] · [[Network Hardening]] · [[Physical Security]] · [[Change Management]] · [[Documentation]] · [[Disaster Recovery]] · [[High Availability]] · [[Three-Tier Architecture]]

*Source: VIRGIL knowledge base — 2026-05-11*