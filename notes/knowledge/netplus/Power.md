# Power

## What it is

In **Gran Turismo**, you can have the McLaren F1 GTR tuned to perfection, slicks warmed up, racing line memorized — and you'll still DNF at Le Mans if you run out of fuel on lap 23. The car doesn't care how fast it *can* go. It cares whether there's energy in the tank right now. Pit stop strategy isn't a nice-to-have; it's the difference between a podium and walking back to the garage.

That's exactly what power is to a network — *the fuel strategy*. Every switch, router, AP, and server is a race car. Cut the fuel for half a second and the engine dies. Cut it for two seconds and you've lost the race, the lap, and possibly the gearbox.

**Technical definition (N10-009 Objective 2.4):** Power planning for network installations covers the electrical and environmental factors that keep network equipment running — incoming voltage, distribution within the rack, conditioning against sags and spikes, battery backup during outages, total load calculations, and the physical conditions (heat, humidity, fire) that determine whether equipment lives or dies. No power, no network. No clean power, no reliable network.

## Why it matters

Power is the silent killer of small business networks. The MDF is in a converted broom closet, the UPS battery hasn't been tested since 2019, the PDU is daisy-chained off a surge strip from Staples, and the AC vent is blowing into the *back* of the rack instead of the front. Everything works fine — until the building has a brownout at 3pm on a Tuesday and the office goes dark for the rest of the day.

CompTIA tests this domain because the people who fail at Network+ work are almost never failing at subnetting. They're failing because they didn't check that the new 48-port PoE switch needed a dedicated 20A circuit and the existing 15A circuit now trips every time someone microwaves lunch.

The junior who notices the IDF closet is hitting 85°F and files a ticket gets promoted. The one who shrugs and lets the switch thermal-throttle for six months gets blamed when it dies. *Power and environment are the boring parts of the job that separate the techs who last from the ones who don't.*

## Key facts

### MDF vs IDF — where the gear lives

The **Main Distribution Frame (MDF)** is the central network room. ISP demarcation lands here. Core routers, core switches, main firewall, fiber from outside. One per building.

The **Intermediate Distribution Frame (IDF)** is the satellite closet on each floor or wing. Access switches live here. Workstation runs terminate on the IDF's [[patch panel]]. The IDF backhauls to the MDF over fiber.

| Feature | MDF | IDF |
|---|---|---|
| Location | Central, often basement | Per floor/wing |
| Equipment | Core switches, routers, firewall, ISP demarc | Access switches, patch panels |
| Cabling out | Fiber backbone to IDFs, WAN to ISP | Copper runs (≤100m) to user drops |
| Count | One per building | Multiple per building |

The MDF needs serious power and cooling because *all the heavy gear* lives there. IDFs need enough power for a couple of PoE switches plus headroom. Both need UPSes. Neither should share a circuit with the breakroom fridge.

### Rack size, layout, and airflow

Racks are measured in **U** (rack units). 1U = 1.75 inches. Standard full-height = **42U**. Wall-mount IDF racks are often 12U or 18U.

**Port-side exhaust vs port-side intake** is the trap CompTIA loves. Switches don't all blow the same direction. Some pull cool air from the port side (front) and exhaust out the back. Others (especially data-center top-of-rack switches) reverse it. Mix these in one rack without thinking and you get a switch inhaling its neighbor's hot exhaust — everything thermal-throttles.

Standard rule: **cold aisle in front, hot aisle in back.** Intakes face the cold aisle. Exhausts dump into the hot aisle, pulled up to the CRAC unit.

> **CompTIA exam trap:** Port-side intake vs port-side exhaust is not the same as "front-to-back airflow." A port-side-exhaust switch *blows out the port side* — in a normal cold-aisle/hot-aisle layout you'd be cooking your own cables. They're testing whether you can match equipment airflow direction to rack orientation, not whether you can recite "cold aisle / hot aisle."

### Power load, voltage, and circuits

**Voltage in North America:** standard outlets = 120V. Larger gear often uses 208V or 240V for efficiency. Outside NA: 230V is the global default.

Example load calc for a small IDF:
- 48-port PoE+ switch @ ~370W full load
- Backup switch @ 100W
- UPS overhead/headroom = ~150W
- **Total: ~620W**

At 120V, that's ~5.2A. A 15A circuit handles it. A 20A gives room for a second PoE switch. PoE-heavy closets bite people — a 48-port switch with every port pulling PoE++ for cameras can hit 1200W+ alone.

**Rule of thumb:** never load a circuit above 80% of its rating continuously. 15A → 12A working max. 20A → 16A working max.

### PDU — Power Distribution Unit

The **PDU** is the strip of outlets in the rack.

| Type | What it does | When to use |
|---|---|---|
| **Basic PDU** | Dumb outlet strip | Small IDF, low budget |
| **Metered PDU** | Shows total amp draw on a display | When you need to verify load |
| **Switched PDU** | Per-outlet remote power control via web/SNMP | Remote sites — power-cycle a frozen switch without driving there |

A switched PDU pays for itself the first time you remotely power-cycle a hung router at 11pm instead of dispatching a tech. *Get the switched PDU. Trust me.*

### UPS — Uninterruptible Power Supply

The **UPS** is your pit stop fuel reserve. When utility power drops, the UPS battery carries the load for a few minutes — long enough to ride out the blip or shut down gracefully.

| Type | Behavior | Use case |
|---|---|---|
| **Standby (offline)** | Idle until power fails, then switches to battery. ~4-8ms transfer. | Workstations, home labs. |
| **Line-interactive** | Conditions voltage continuously, switches to battery on outage. | Most network closets. The sweet spot. |
| **Online (double-conversion)** | Always running off battery, which is always being charged. Zero transfer time. | MDF, servers, anything that hates power interruptions. |

UPS runtime is not the goal. **Graceful shutdown is the goal.** A 10-minute UPS lets servers power down cleanly and lets the network stay up long enough for the generator to spin up.

> **CompTIA exam trap:** A UPS is not a generator. UPS = minutes. Generator = hours/days. Exam questions will offer "UPS" as the answer for a 6-hour outage scenario — wrong. You need both: UPS bridges the gap until generator starts.

### Environmental factors

**Temperature:** ASHRAE recommends 64–81°F (18–27°C) for intake air. Above 85°F, switches throttle and lifespans collapse. *If you sweat in the closet, the switches are suffering.*

**Humidity:** 40–60% relative humidity. Too low (<30%) = static electricity, ESD damage. Too high (>60%) = condensation, corrosion, failures you'll never diagnose.

**Fire suppression:** sprinklers in a network room are a war crime against your own equipment. Use **clean agent suppression** — FM-200, Novec 1230, or inert gas (Inergen). If code requires sprinklers, use **pre-action** sprinklers that require two triggers (smoke + heat) before water flows.

**Lockable:** the MDF and every IDF must be **lockable** with controlled access. Card reader beats a key. Logged access beats card reader. *Anyone who can plug into your switch can be on your VLAN.*

### Patch panel and fiber distribution panel

The **patch panel** is the static termination point for cable runs from the walls. Cat6 runs from the desk jack to the back of the patch panel. A short patch cord goes from the front to the switch port. You *never re-terminate the long cable run* — only the cheap, replaceable patch cord.

The **fiber distribution panel** is the same idea for fiber: incoming strands terminate on the back, LC/SC couplers on the front, short fiber patch cords to the switch. Fiber is fragile — bend radius matters. These panels include service loops so you can pull slack without breaking glass.

Both should be labeled. Every. Port. The closet with unlabeled patch panels is the closet where troubleshooting takes 4 hours instead of 15 minutes.

### More CompTIA exam traps

> **CompTIA exam trap:** MDF vs IDF — the MDF is where the *ISP demarc* lands. The IDF is where *user drops* terminate. If the question mentions ISP, fiber from outside, or core router → MDF. If it mentions a floor, wing, or workstation cabling → IDF.

> **CompTIA exam trap:** PDU vs UPS — the PDU *distributes* power. The UPS *backs up* power with batteries. A switched PDU still goes dark when utility power fails unless it's plugged into a UPS. Wrong answer chain: "switched PDU provides battery backup." It doesn't.

## Helpdesk reality

- **"The whole floor is down."** First check: did the IDF lose power? Walk to the closet. Listen. If the UPS is beeping and switches are dark, you know. If everything's lit, it's upstream.
- **"It only goes down on hot afternoons."** Thermal throttling. The IDF hits 90°F by 3pm and the switch is browning out. Open a facilities ticket for AC before you blame the switch.
- **"The UPS keeps beeping."** Don't silence and walk away. Either the battery is end-of-life (most die at 3-5 years) or the load exceeds the UPS rating.
- **Never promise** "the network will stay up during the storm." You don't know how long the outage will be, if the generator will start, or if the UPS battery is healthy. Promise *graceful shutdown*, not uptime.
- **Escalation point:** if power, cooling, or fire suppression is involved, it's a facilities ticket — not a network ticket. Network team advises, facilities owns building infrastructure.

## Related concepts

[[MDF]] · [[IDF]] · [[Patch panel]] · [[Fiber distribution panel]] · [[Rack units]] · [[PoE]] · [[Cooling and HVAC]] · [[Cable management]] · [[Physical security]] · [[Documentation]]

*Source: VIRGIL knowledge base — 2026-05-11*