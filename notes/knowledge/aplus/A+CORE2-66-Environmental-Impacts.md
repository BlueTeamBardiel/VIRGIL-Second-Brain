# Environmental Impacts

## What it is

You built your rig in a finished basement. Cold concrete floor, dry winter air, the carpet zaps you every time you walk to the fridge. You shuffle back, reach into the case to reseat a RAM stick, and *snap* — you just dumped a few thousand volts of static into a DIMM that's now a paperweight. Or it's August, the AC died, your office hits 92°F, and your CPU thermal-throttles to potato speeds mid-raid. Or the power blinks during a thunderstorm and the desktop you didn't put on a UPS comes back up with a corrupted boot sector.

That's environmental impact. The room your gear lives in is part of the system. Temperature, humidity, power quality, dust, and the chemicals on the MSDS sheet for your toner — all of it affects whether your machine lives a long life or dies on a Tuesday.

In plain English: computers are bodies. Bodies need stable temperature, stable humidity, clean power, and someone who knows what to do when the toner spills or the battery swells. Ignore the environment and the body gets sick.

Technically: **environmental controls** are the policies, equipment, and procedures that protect IT assets from physical and electrical hazards — power irregularities, thermal stress, humidity extremes, particulate contamination, and improper disposal of hazardous materials. CompTIA tests this under 220-1202 Objective 4.5.

## Why it matters

Power conditioning, MSDS, disposal procedures, and temperature/humidity awareness are all explicit 4.5 bullets. Beyond the exam, this is the unglamorous knowledge that separates techs who keep their fleet alive from techs who keep replacing it. The senior admin who insists every rack has dual UPS feeds and the room stays at 68°F isn't paranoid — they've watched what happens when those rules get bent.

You will, at some point, get the ticket that reads "server room is hot." How fast you act depends on whether you understand why that matters before you read this note.

## In your build, in the enterprise

**Beat 1 — Technical depth.** Power problems come in three flavors. A **surge** is a brief voltage spike — lightning, AC compressor kicking on, grid ugliness. Surges fry power supplies and anything downstream. A **brownout** is voltage sag — lights dim, PSU struggles to deliver clean rails, components reset. A **blackout** is total power loss — machine drops mid-write and the filesystem may not survive.

Defense in layers: a **surge suppressor** (joule-rated power strip) absorbs spikes but does nothing for sag or loss. A **UPS** has a battery that bridges short outages and conditions voltage during brownouts — line-interactive UPSes use an autotransformer to correct sag without draining the battery; online/double-conversion UPSes run everything through the inverter so output is always clean. UPS runtime is minutes, not hours — the job is graceful shutdown.

ASHRAE recommends data center inlet air at 18–27°C (64–80°F). Humidity sweet spot is 40–60% RH — below 30% static discharge becomes a real threat, above 60% you risk condensation and corrosion.

**Beat 2 — Your gaming rig in a finished basement.**

**The power side:** $1,200 build plugged into a $15 power strip from the hardware store. *That's a surge suppressor at best, and only until its joules are spent — which you'll never know because there's no indicator.* Add a 1500VA line-interactive UPS. Now a brownout doesn't reset your raid, and a blackout gives you 8 minutes to save and shut down clean.

**The thermal side:** Tower sits on carpet, against the wall, intake fans 2 inches from a baseboard. Case temps climb 10°C above where they should be. Move it to a hard surface with breathing room. *Airflow is breathing — block the nose and the brain overheats.*

**The dust side:** Six months in, the front intake filter looks like a dryer lint trap. Take it outside, blast it with compressed air — short bursts, hold the fans still with a finger so they don't spin up and back-EMF into the motherboard header. *Never use a household vacuum inside a case. The plastic nozzle generates static, and static kills silicon.*

**The static side:** Winter, low humidity, carpet. Touch the case chassis before any component. Better: anti-static wrist strap clipped to bare metal. *The zap you don't feel is still 500 volts. The zap you do feel is 3,000+.*

**Beat 3 — Bridge to the enterprise.** Same questions, scaled up and unforgiving.

Power at home: one UPS, one feed, one PSU. Power in the enterprise: dual PSUs in every server, fed from A and B circuits, each circuit on a separate UPS, both UPSes backed by a generator with automatic transfer switch. Service entrance surge protector. Rack PDUs with their own surge suppression. *Every layer assumes the layer before it will eventually fail.*

Cooling at home: case fans and maybe an AIO. Cooling in the enterprise: dedicated CRAC units, hot-aisle/cold-aisle layout so exhaust doesn't recirculate into intakes, raised floors for cold air delivery, N+1 redundancy so one unit can fail without the room cooking. Sensors page on-call staff at 3 AM when the room drifts.

Disposal at home: you toss the old PSU in the trash and hope. Disposal in the enterprise: every battery, toner cartridge, and decommissioned drive has a chain-of-custody log, an MSDS reference, and a certified e-waste vendor with destruction certificates.

**Beat 4 — The point.** Same fundamental question across both contexts: *what fails this system, and what layer of defense catches each failure?* At home, one UPS and a clean room is enough. In a data center, every layer has redundancy because the cost of downtime exceeds the cost of three more layers. When you walk into any server room, look for the layers. If you only see one, that's the failure mode waiting to happen.

## Key facts

### Power problems and defenses

| Problem | What happens | Defense |
|---|---|---|
| **Surge / spike** | Voltage briefly exceeds normal — lightning, transformer switching, large motor starting | Surge suppressor (joule-rated), whole-building surge protection, UPS |
| **Brownout / sag** | Voltage drops below normal — grid stress, undersized circuit | Line-interactive or online UPS with AVR |
| **Blackout** | Total power loss | UPS for graceful shutdown, generator for sustained runtime |
| **EMI / line noise** | Electrical interference on the AC line | Online/double-conversion UPS, isolation transformer |

### Surge suppressor vs UPS

- **Surge suppressor**: passive, diverts spikes via MOVs that degrade with each hit and eventually fail silently. Joule rating is lifetime energy budget. **No battery, no brownout protection, no blackout protection.**
- **UPS topologies**: **standby** (cheapest, switches to battery on event), **line-interactive** (AVR corrects voltage without battery, most common for desktops/small servers), **online/double-conversion** (always running through inverter, cleanest output, used for critical equipment).

> **CompTIA exam trap:** A surge suppressor does NOT protect against brownouts or blackouts — only voltage spikes above normal. Only a UPS protects against undervoltage and total power loss. CompTIA loves this distinction.

### Temperature and humidity

- **Ideal range**: 18–27°C (64–80°F) inlet air, 40–60% RH
- **Too hot**: thermal throttling, accelerated aging, capacitor degradation
- **Too dry (<30% RH)**: static electricity risk skyrockets — ESD damage
- **Too humid (>60% RH)**: condensation, corrosion, mold

### Location and dust

- Keep equipment off carpet — generates static, traps dust
- Maintain 4–6 inches clearance around vents
- Avoid sunlight, heat sources, water sources (pipes overhead)
- Racks: hot-aisle/cold-aisle orientation, blanking panels in empty slots
- No paper, cardboard, or food in server rooms — fiber shedding, pest attraction
- **Compressed air**: correct tool. Short bursts, hold fans stationary. Never household vacuum — plastic nozzle generates static that fries components without ever touching them.

### MSDS — Material Safety Data Sheet

Now formally called **SDS (Safety Data Sheet)** under GHS, but CompTIA still uses MSDS terminology. The document tells you what chemicals are in a product (toner, solvents, batteries, thermal paste), health hazards, first-aid, spill cleanup, disposal requirements, and PPE needed. OSHA requires every workplace storing hazardous materials to keep SDS sheets accessible. *Read it before the spill, not during.*

### Proper disposal

| Item | Hazard | Disposal |
|---|---|---|
| **Lithium-ion batteries** | Fire, toxic if punctured/swollen | Certified e-waste recycler or manufacturer take-back. Tape terminals before transport. |
| **Lead-acid batteries** (large UPS) | Lead poisoning, sulfuric acid | Certified hazmat recycler, usually with core charge |
| **Toner cartridges** | Fine particulates, some carcinogenic | Manufacturer take-back. Never regular vacuum — fine particles pass through filters. Toner-rated HEPA or damp cloth. |
| **CRT monitors** | Leaded glass | Certified e-waste only |
| **Hard drives / SSDs** | Data exposure | Sanitize first (overwrite, crypto-erase, or physical destruction), then recycle |
| **Generic e-waste** | Heavy metals, flame retardants | Certified e-waste recycler with destruction certificate for asset tracking |

> **CompTIA exam trap:** Disposal questions usually have one "throw it in the trash" answer (always wrong) and one "follow local regulations and use a certified recycler" answer (always right). Default to the recycler answer.

## Helpdesk reality

- **"My computer keeps randomly rebooting during storms."** → No UPS, probably no surge protection. Sell them a line-interactive UPS. Don't promise it'll survive a direct lightning strike — nothing will.
- **"The server room feels warm."** → Don't dismiss it. Check temp/humidity readings, verify CRAC units running, check for blocked airflow, escalate to facilities if out of spec. A warm room is the early warning. A hot room is the outage.
- **"There's toner spilled on the carpet."** → No regular vacuum. Cold water on a cloth (hot water sets it), or a toner-rated HEPA vacuum. Pull the SDS before touching with bare hands.
- **"My laptop battery is swollen."** → Stop using it immediately. Don't puncture, don't charge. Bag it and route to e-waste. Swollen lithium is a fire hazard, full stop.
- **"Can I throw this old UPS in the dumpster?"** → No. The lead-acid or lithium battery inside is hazardous waste. Route through the company's e-waste process.

## Related concepts

[[Safety Procedures]] · [[ESD]] · [[Power Supply Units]] · [[UPS and Battery Backup]] · [[Data Destruction and Disposal]] · [[Printer Maintenance]] · [[Server Room Layout]] · [[Change Management]]

*Source: VIRGIL knowledge base — 2026-05-11*