# OT — Operational Technology

## What it is

In **Madden**, you don't audible into a hurry-up snap on 3rd and goal when the kicker is already on the field warming up for a 52-yard field goal. You touch the kicker, you touch the snap count, you touch *anything* during that pre-snap window and the play clock burns down to a delay-of-game penalty. The kicking unit is its own self-contained system — different personnel, different timing window, different cost of a screwup. You don't run base-defense audibles against it.

That's exactly what OT is to a SOC analyst — **a separate world running on its own timing, its own protocols, its own consequences for being touched the wrong way, and you do not scan it like you scan the corporate LAN.**

**Operational Technology (OT)** is the hardware and software that monitors and controls physical processes — turbines, valves, conveyors, pumps, robot arms, breakers, dosing pumps at the water plant. It overlaps heavily with **[[ICS]]** (Industrial Control Systems) and **[[SCADA]]** (Supervisory Control and Data Acquisition). IT moves bits. OT moves atoms. When IT goes down, email is slow. When OT goes down, the boiler doesn't get its setpoint, the centrifuge spins past its limit, or the wastewater plant dumps untreated effluent into the river.

For vulnerability scanning — Objective 2.1 — OT is the canonical "special consideration." Standard scanning practices that are routine on the corporate subnet can crash a 1997 PLC running ladder logic that was last touched by an engineer who retired in 2014.

## Why it matters

OT is **critical infrastructure**. Power, water, gas, manufacturing, transportation, pharmaceuticals — all OT-dependent. The Colonial Pipeline ransomware in 2021 was technically an IT-side billing system compromise, but the *operational decision* to shut down the pipeline pulled fuel off the East Coast for a week. Stuxnet, Triton/Trisis, Industroyer, the Oldsmar water plant intrusion — these are not theoretical. Adversaries target OT specifically because the blast radius is physical.

Regulatorily: **NERC CIP** (electric), **TSA pipeline directives**, **EPA water sector guidance**, **IEC 62443** (the industrial-control security standard), and **[[NIST SP 800-82]]** all govern OT cyber. CISA treats OT as its top priority sector. CySA+ Objective 2.1 expects you to know that **scanning OT is not scanning IT** — different tools, different cadence, different blast radius if you get it wrong.

Exam-wise: when CompTIA gives you a scenario with the words "manufacturing floor," "PLC," "SCADA," "HMI," "water treatment," "power grid," or "legacy industrial" — the correct answer is almost never "run a credentialed Nessus scan during business hours." It's almost always **passive scanning, network segmentation, or a maintenance-window-only approach**.

## Key facts

### The OT vs. IT split

| Dimension | IT | OT |
|---|---|---|
| Priority | CIA — Confidentiality first | **AIC — Availability first**, then integrity, then confidentiality |
| Lifespan | 3–5 years | 15–30+ years |
| Patching | Monthly cycle, reboot freely | Patched during planned outages, sometimes years apart |
| Protocols | TCP/IP, HTTPS, SMB | Modbus, DNP3, PROFINET, EtherNet/IP, OPC, S7 |
| Downtime cost | Annoyance to revenue loss | Safety incident, regulatory violation, physical damage |
| Scan tolerance | High — built for it | Low — a poorly-crafted SYN scan can crash a PLC |

The flip from CIA to **AIC** is the headline. An OT engineer will accept a known vulnerability sitting unpatched for a year if patching it requires shutting down a process that costs $400k/hour to restart. That's not negligence — it's the actual risk math.

### Scanning OT — the special considerations

This is the Objective 2.1 meat. CompTIA wants you to recognize that the standard scanning playbook breaks here.

**Passive vs. active scanning** — In OT you default to **[[passive scanning]]**. Tools like Claroty, Dragos, Nozomi, and Tenable.ot sit on a SPAN/mirror port and listen. They fingerprint devices by watching Modbus and DNP3 traffic go by. They never send a packet to a PLC. Active scanning is reserved for IT-side OT assets (the engineering workstation, the historian) or done during a scheduled maintenance window with engineering sign-off.

**Device fingerprinting** — Passive fingerprinting reads protocol banners (Modbus function codes, vendor-specific identifiers in PROFINET) to identify make, model, firmware. You do not nmap a PLC. A poorly-formed packet to a Siemens S7-300 can fault the CPU.

**Credentialed vs. non-credentialed** — Credentialed scans against IT systems are gold-standard. Against OT, "credentialed" usually doesn't even exist — the PLC has no concept of a Windows domain account. The HMI workstation might, and that's where you point credentialed scans.

**Internal vs. external** — OT should be **fully internal**, sitting behind the **[[Purdue Model]]** layers. If your external scan can see a PLC, that is itself the finding — write it up, contain it, and have a hard conversation with whoever published it.

**Agent vs. agentless** — Agents on PLCs: don't exist. Agents on HMIs/engineering workstations: maybe, if the vendor supports it. Most OT vulnerability management is **agentless and passive**.

**Scheduling** — Any active scanning happens during a **planned maintenance window**, with the OT engineer in the room, with a rollback plan, with the process at a safe state. You do not surprise a turbine.

**Segmentation** — The **[[Purdue Model]]** divides OT into levels: Level 0 (physical process), Level 1 (PLCs/RTUs), Level 2 (SCADA/HMI), Level 3 (operations management), Level 3.5 (DMZ), Level 4 (corporate IT), Level 5 (enterprise). Each layer is firewalled from the next. A scan run at Level 4 should never see Level 1 unless the segmentation is broken — and if it is, that's the report.

**Sensitivity levels** — Some OT processes (safety instrumented systems, SIS) are so sensitive that even passive monitoring needs vendor approval. A SIS that misfires can vent toxic gas or fail open on a reactor.

### Frameworks that govern OT

- **IEC 62443** — the ISA/IEC industrial cyber standard. Defines security levels (SL1–SL4) and zones-and-conduits architecture.
- **NIST SP 800-82** — Guide to OT Security. The US government's playbook.
- **NERC CIP** — North American Electric Reliability Corporation, Critical Infrastructure Protection. Binding for bulk electric.
- **[[CIS]] Controls** — generic but applicable. CIS has an ICS companion guide.
- **[[ISO 27000]]** series — generic ISMS, less OT-specific but referenced in mature programs.
- **TSA Security Directives** — pipeline OT (post-Colonial).
- **[[PCI DSS]]** — not OT-specific, but if your manufacturing plant takes credit cards at the cafeteria, PCI scope can collide with OT scope. Keep them segmented.
- **[[OWASP]]** — IT-side; relevant for OT-adjacent web apps (HMI web interfaces, vendor portals).

### CompTIA exam traps

> **CompTIA exam trap:** "Run a credentialed vulnerability scan against the SCADA network to identify missing patches." Wrong. The correct answer involves passive monitoring, scheduling during a maintenance window, or coordinating with OT engineers. Active credentialed scanning against live ICS is the textbook example of *how to cause an unplanned outage*.

> **CompTIA exam trap:** CIA vs AIC. IT is **C-I-A**. OT is **A-I-C** — availability comes first because process uptime is the safety case. If a question stem mentions "manufacturing plant prioritizes…" the answer is availability.

> **CompTIA exam trap:** OT, ICS, SCADA — not synonyms. **OT** is the umbrella (all operational tech, including building automation and medical devices). **ICS** is the subset that controls industrial processes. **SCADA** is a type of ICS architecture — supervisory layer monitoring distributed RTUs/PLCs, often over WAN. A water utility monitoring 40 remote pump stations from one control room is SCADA. A single factory PLC controlling a robot arm is ICS but not SCADA.

> **CompTIA exam trap:** "Reverse engineering" and "fuzzing" appear in the 2.1 objective. These are **dynamic analysis** techniques. On OT firmware they are done in a **lab environment on a spare device** — never against production. CompTIA may put "fuzz the production PLC" as a distractor. It's wrong every time.

### Static vs. dynamic in OT context

- **Static analysis** — read the ladder logic, the firmware image, the configuration export, offline. Safe for production because you're not touching the device.
- **Dynamic analysis** — fuzzing, runtime testing, active probing. Lab-only against OT.

### Asset discovery in OT

Passive asset discovery is the only safe default. Tools watch protocol traffic and build an inventory: this is a Rockwell ControlLogix at 10.20.5.12, firmware v32.011, last seen 47 seconds ago. You did not send it a single packet. Compare this to IT asset discovery where an nmap sweep is unremarkable.

## SOC reality

- The OT alert at 3am is a **passive sensor** flagging "unauthorized engineering workstation connection to PLC at Substation 7." Your job is not to "isolate the PLC" — your job is to call the OT duty engineer first. They decide whether the connection is a midnight maintenance push by a contractor or an actual intrusion.
- L1 analysts rarely touch OT directly. The escalation path is **L1 → SOC lead → OT cyber team → plant control engineer → operations manager**. Skipping the plant engineer to "contain" a device can cause a process trip — your containment becomes the incident.
- The CISO question on an OT alert is: "Is the process still safe? Is the SIS independent and intact?" Not "did you isolate it?" Safety-first language wins in the OT war room.
- Never promise leadership "we patched it." OT patches are scheduled in outage windows weeks or months out. The truthful answer is *"compensating controls in place — segmentation enforced, monitoring increased, patch scheduled for the Q3 turnaround."*
- The handoff to legal/regulatory is fast for OT incidents. NERC CIP reportable events, EPA cyber incident reporting for water utilities, CIRCIA for critical infrastructure — *the clock on regulatory notification often starts before you've finished triage*. Know your sector's reporting window before the incident, not during.

## Related concepts

[[ICS]] · [[SCADA]] · [[Purdue Model]] · [[Passive scanning]] · [[Active scanning]] · [[Asset discovery]] · [[Device fingerprinting]] · [[Segmentation]] · [[NIST SP 800-82]] · [[IEC 62443]] · [[NERC CIP]] · [[CIRCIA]] · [[CIS]] · [[ISO 27000]] · [[PCI DSS]] · [[OWASP]] · [[Critical infrastructure]] · [[Fuzzing]] · [[Reverse engineering]] · [[Static analysis]] · [[Dynamic analysis]] · [[Maintenance window]] · [[Compensating controls]]

*Source: VIRGIL knowledge base — 2026-05-11*