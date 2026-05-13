# Safety Procedures

## What it is

The first time you build a PC, somebody older hands you a green wristband with an alligator clip and says "put this on, clip it to the case." You feel ridiculous. Then a year later you read a forum post about a guy who fried his new $400 GPU by sliding it out of the antistatic bag on a carpet in winter, and the wristband stops feeling ridiculous.

Safety procedures are the rules that keep two things alive: the hardware and you. Half of them protect silicon from static charge measured in thousands of volts that you literally cannot feel. The other half protect your body from things that can kill it — mains voltage, capacitor discharge, falling server chassis, fire, fumes, dust. The body-protection rules are why every datacenter has signage, training, and procedures that look like overkill until somebody skips them.

Technically: this objective covers ESD mitigation (straps, mats, bags, equipment grounding), electrical safety (disconnect power, lockout), personal safety (lifting, fire response, PPE), cable management, and compliance with the government regulations that mandate all of it — OSHA in the US, plus local fire and electrical codes.

## Why it matters

CompTIA objective **220-1202 4.4** is one of the most heavily-tested operational-procedures topics on Core 2 because employers will not hire a tech who'll hurt themselves or destroy company hardware on day one. The exam wants you to know which procedure applies to which scenario, in order, without hesitation.

Career reality: your first IT job will involve a safety briefing before you touch anything. Larger employers — hospitals, government contractors, datacenters — require signed acknowledgment that you understand lockout/tagout, lifting limits, fire suppression, and ESD procedure. Get this wrong on a ticket and you damage equipment. Get it wrong on yourself and OSHA gets involved. *Nobody recovers a career from "tech electrocuted in server room."*

## In your build, in the enterprise

**Beat 1 — Technical depth.** ESD is the silent killer. The human body can hold 3,000 volts without feeling it; you don't perceive a static shock until around 3,500V. Modern CMOS components fail at 100V or less. This is why every chip ships in a pink or silver antistatic bag — the silver bags are Faraday cages (metallized polyester), the pink ones are dissipative polyethylene. ESD wrist straps contain a 1MΩ resistor by design — that resistor is what makes them safe for *you*. It bleeds static slowly to ground instead of giving mains voltage a fast path through your heart if you accidentally contact a live circuit. ESD mats work the same way: dissipative surface, grounding lead to a known earth point. Equipment grounding means the chassis is bonded to building earth via the third pin of the power cable — that's what gives static somewhere to go when you touch the case.

**Beat 2 — Feynman example, gaming build.**

**The new GPU arrives.** You unbox it, slide it out of the silver bag onto the carpet, walk to the desk. *Congratulations — you may have just killed a $700 card and won't find out until it artifacts in Cyberpunk three weeks later.*

**The right move.** Strap on the wristband, clip it to the bare metal of the case (paint is an insulator — find a screw hole or unpainted standoff). Pull the GPU out of the bag *over* the case, not over the carpet. Set the bag aside — never set the card *on* the bag, the outside is conductive and the inside is dissipative, people get this backwards constantly. *The bag protects the chip in transit; the workspace protects it during install.*

**The PSU detail.** Unplug the power cable from the wall before you open the case. Some builders leave it plugged in "for grounding" — that worked on older PSUs with hard switches. Modern ATX PSUs keep the +5VSB rail live whenever the cable is connected. Touch the wrong header on a powered standby motherboard and you'll smoke a chipset. *Disconnect power means disconnect power.*

**The capacitor.** After unplugging, hold the power button for 10 seconds to drain residual charge from PSU and motherboard capacitors. Old CRT monitors and laser printer power supplies can hold lethal voltage for *weeks* after being unplugged — those are not user-serviceable, period.

**Beat 3 — Bridge to the enterprise.** Same physics, scaled up and regulated. The home builder's wrist strap clipped to a case becomes a datacenter ESD floor with continuous monitoring, conductive shoe straps, grounded workbenches at every staging area, and a logged ESD test station at the entrance. "Disconnect power" at home means pulling the wall plug; in a server rack with dual A/B power feeds, it means lockout/tagout — physically locking each PDU breaker in the off position with a tag bearing your name, so a coworker can't restore power while your hand is inside the chassis. Home fire safety is a smoke alarm and a Class C extinguisher near the rig. Datacenter fire safety is VESDA air-sampling smoke detection, clean-agent suppression (FM-200, Novec 1230, or inert gas — never water, never CO2 in occupied spaces if avoidable), and a documented evacuation route. Home lifting is "bend your knees with the case." Enterprise lifting is OSHA's 50-pound single-person limit, team lifts above that, server lift carts for 2U+ chassis, and a back injury report if you ignore it.

**Beat 4 — The point.** Same fundamental question at every scale: *what can hurt the hardware, and what can hurt the human, and what procedure makes both safe before I touch anything?* At home you self-enforce. In the enterprise, regulations enforce — and the regulations exist because somebody already died or destroyed millions in equipment learning the lesson the hard way. Get the discipline into your hands now, while it's just your own GPU on the line.

## Key facts

### ESD — electrostatic discharge

| Tool | What it does | When to use |
|---|---|---|
| **ESD wrist strap** | 1MΩ resistor bleeds static to ground via clip on chassis or mat | Any time you handle internal components |
| **ESD mat** | Dissipative surface with grounding lead to earth point | Workbench staging, board-level work |
| **Antistatic bag (silver/metallized)** | Faraday cage — blocks static from reaching component | Storage and transport of components |
| **Antistatic bag (pink poly)** | Dissipative — prevents charge buildup but not a Faraday cage | Low-sensitivity parts, secondary packaging |
| **Heel straps / ESD shoes** | Bleeds body charge through conductive flooring | Datacenter / cleanroom floors |
| **Equipment grounding (3-prong, earth bond)** | Gives static and fault current a safe return path | Every chassis, every PDU, every rack |

> **CompTIA exam trap:** *"To prevent ESD when working on a desktop, which is best?"* The wrist strap clipped to the chassis is the right answer. **Self-grounding** (touching the metal case before working) is acceptable when no strap is available, but it's the fallback, not the standard. CompTIA wants the strap.

> **CompTIA exam trap:** Components go *in* antistatic bags for storage, not *on top of them*. The outside of a silver bag is conductive — laying a powered board on it can short traces.

### Electrical safety

- **Disconnect power before service.** Unplug from wall, hold power button 10 seconds to drain capacitors.
- **Never open** CRT monitors, laser printer high-voltage power supplies, microwave ovens (different context, same physics), or any PSU. Capacitors hold lethal charge.
- **Lockout/Tagout (LOTO)** — OSHA 1910.147. Physically lock a breaker or disconnect in the off position with a personal tag. Only the person who applied the lock removes it. Used for any service on equipment that could re-energize.
- **One hand rule** — when probing live circuits is unavoidable (rare for A+ work), keep one hand in your pocket. Prevents current crossing your chest through your heart.
- **GFCI outlets** in any wet or damp area. Server rooms with sprinklers or cooling leaks should have them at service receptacles.

### Personal safety

| Hazard | Procedure |
|---|---|
| **Lifting** | Bend knees, straight back, load close to body. OSHA single-person limit ~50 lbs. Team lift above that. Use server lift carts for rackmount installs. |
| **Fire** | Class **C** extinguisher for electrical fires (CO2 or clean agent, **never water on energized equipment**). Class **A** for paper/wood. Class **K** for kitchen grease. Know the location before you need it. |
| **Eye protection** | Safety goggles when cutting cable, crimping in awkward positions, working overhead in ceiling plenums, blowing out dust with compressed air. |
| **Respiratory** | Air filter mask (N95 minimum) when cleaning heavy dust accumulation, working in dirty plenums, handling toner cartridge spills. |
| **Trip hazards** | Cable management isn't cosmetic — loose cables in walkways cause falls and yank equipment off desks. |

### Cable management

- **Velcro over zip ties** for bundles you'll service again. Zip ties for permanent runs only.
- **Bend radius** — Cat6 bends no tighter than 4× cable diameter. Fiber bends no tighter than 10× diameter. Sharp bends kill signal integrity.
- **Separate power from data** — parallel runs of mains and Ethernet pick up induced noise. Cross at 90° where they must meet.
- **Label both ends.** Every cable. Always. Future-you will be grateful.
- **Floor cables** go under raised flooring or in cable trays — never run loose across walkways. Trip hazards and fire-code violations.

### Compliance with government regulations

- **OSHA** (Occupational Safety and Health Administration, US) — workplace safety, LOTO, lifting limits, PPE, hazard communication.
- **NEC** (National Electrical Code) — electrical installation standards. Plenum-rated cable (CMP) required in air-handling spaces.
- **EPA** — disposal of batteries, CRTs, toner, electronics. Hazardous waste rules.
- **Local fire codes** — extinguisher types and placement, suppression systems, egress paths.
- **MSDS / SDS** (Safety Data Sheets) — every chemical in the workplace must have an accessible SDS. Toner, isopropyl alcohol, cleaning solvents — all need sheets on file.

## Helpdesk reality

- *"Can I just touch the radiator before I open my PC?"* — Self-grounding is the fallback when a strap isn't available. Better than nothing, worse than a strap. Tell users to unplug first, touch bare metal of the case, and work on a hard non-carpeted surface.
- *"The server room is on fire, what do I do?"* — Evacuate. Pull the alarm. Don't fight an electrical fire with a water extinguisher. Don't go back for hardware. Hardware is replaceable.
- *"I dropped a screw inside the running server, can you grab it?"* — No. Power down properly, LOTO if it's production, then retrieve. Live chassis + metal screw = short and possibly arc flash.
- *"Why do I need goggles to crimp a cable?"* — Because cut copper strands flick toward your face at the exact angle your eye is at. One ER trip cures the skepticism.
- *"Can I lift this 2U server by myself?"* — Check the weight sticker. If it's over 50 lbs or awkwardly balanced, get a second person or a lift cart. Backs don't heal like wrists.

## Related concepts

[[A+CORE2-66-Environmental-Impacts]] · [[A+CORE2-67-Incident-Response]] · [[A+CORE2-68-Communication-Professionalism]] · [[A+CORE1-15-Power-Supplies]] · [[A+CORE1-58-Hardware-Troubleshooting-Methodology]] · [[A+CORE2-64-Change-Management]]

*Source: VIRGIL knowledge base — 2026-05-11*