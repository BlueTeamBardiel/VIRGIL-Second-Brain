# ICS — Industrial Control Systems

## What it is

In **World of Warcraft**, the Ulduar raid has a boss called Mimiron — a goblin engineer who built four giant industrial machines bolted together into one fight. Phase one is a tank with treads. Phase two is a flying gunship. Phase three is a leviathan head with a death ray. Phase four is all three fused into one mech. The mechanics matter here: if you wipe and want to skip the encounter, you can't. There's a hard-mode lever called the "Big Red Button" that, if you pull it, you commit to the entire fight from start to finish with no resets. And — this is the part that maps — if you so much as tap Mimiron wrong during the fight, the whole machine reacts in ways that can kill the raid in seconds. No room for "let's try a scan and see what happens."

That's exactly what **Industrial Control Systems** are in the real world — purpose-built machinery running purpose-built protocols, where the wrong probe doesn't return an error, it stops a turbine, opens a floodgate, or shuts down a hospital generator.

**Technical definition:** ICS is the umbrella category for computer systems that monitor and control physical processes — manufacturing lines, power grids, water treatment, pipelines, building HVAC, rail signaling. **SCADA** (Supervisory Control and Data Acquisition) is the ICS sub-architecture for geographically distributed processes — a control room in Houston watching pumping stations across three states. **OT** (Operational Technology) is the broader term for any hardware/software directly monitoring or controlling physical devices. CySA+ treats ICS, SCADA, and OT as the same exam family: scan them wrong and you break something physical.

## Why it matters

CompTIA objective **CS0-003 2.1** explicitly calls out "special considerations" for vulnerability scanning, and ICS/SCADA/OT is the headline example. The exam will hand you a scenario — "a vulnerability scanner is configured to scan the corporate network including the production floor PLCs" — and the right answer is never "run the scan." The right answer is some variant of *don't scan it actively, segment it, use passive discovery, or get explicit change-board approval with the OT engineers in the room.*

Career-wise, OT security is one of the fastest-growing blue-team specializations. Critical infrastructure executive orders (US EO 14028, CIRCIA reporting requirements, EU NIS2) have pushed every utility, manufacturer, and hospital into mandatory ICS security programs. If you can pass CySA+ and talk credibly about Purdue Model segmentation, you have a career ladder.

The stakes are physical. A misconfigured Nessus scan against a Modbus PLC in 2006 killed a nuclear plant's recirculation pump for hours. Stuxnet (2010) destroyed centrifuges by manipulating Siemens S7 PLCs. Colonial Pipeline (2021) wasn't even an OT breach — the OT got shut down because IT got ransomware and the company couldn't bill — and it still triggered fuel panic across the eastern US.

## Key facts

### What lives in the ICS/OT zoo

| Component | What it does | Why it's fragile |
|---|---|---|
| **PLC** (Programmable Logic Controller) | Reads sensors, drives actuators (open valve, spin motor) | Tiny CPU, no auth on legacy models, crashes on malformed packets |
| **RTU** (Remote Terminal Unit) | PLC's geographically remote cousin, talks back to SCADA over WAN | Same fragility, plus exposed over radio/cellular |
| **HMI** (Human Machine Interface) | The Windows box the operator uses to watch the plant | Often Windows 7 or XP, can't be patched, runs the vendor's proprietary software |
| **Historian** | Database logging every sensor reading forever | Bridge between IT and OT — common pivot point |
| **DCS** (Distributed Control System) | Like SCADA but contained to one site (refinery, chem plant) | Same protocols, same fragility |
| **Safety Instrumented System (SIS)** | The "physical safety" layer (emergency shutdown). Triconex, etc. | Triton/Trisis malware targeted exactly this in 2017 |

### The protocols nobody patched in 30 years

- **Modbus** (TCP/502, RTU/serial) — no auth, no encryption, designed in 1979
- **DNP3** (TCP/20000) — power utility favorite, has secure variant nobody deploys
- **OPC / OPC-UA** — Windows DCOM mess, UA is the modern auth-capable version
- **EtherNet/IP** (TCP/44818, UDP/2222) — Rockwell/Allen-Bradley
- **S7comm** (TCP/102) — Siemens, what Stuxnet abused
- **BACnet** (UDP/47808) — building automation (HVAC, badge readers)

A normal Nmap SYN scan or [[Nessus]] credentialed scan can crash any of these. Modbus stacks have been seen to lock up from a single malformed function code.

### Scanning special considerations — the CySA+ money slide

This is the section CompTIA tests directly. When the scenario involves ICS/SCADA/OT, the answer is almost always one of these:

- **Passive vs. active scanning** — for OT, default to **passive**. Tools like Claroty, Dragos, Nozomi sit on a SPAN port and fingerprint devices from traffic without ever sending a packet. This is the most-correct exam answer when the question is "how do you assess vulnerabilities on a SCADA segment without disrupting operations?"
- **Internal vs. external scanning** — OT should never be externally scannable. If your external scan can reach a PLC, that's the vulnerability finding, full stop.
- **Credentialed vs. non-credentialed** — credentialed scans against OT require vendor-supplied service accounts; many vendors void warranties if you run unauthorized scans. Non-credentialed active scans are the dangerous ones — they crash devices by accident.
- **Agent vs. agentless** — agents on a PLC are usually impossible (no OS in the traditional sense). Agentless passive is the OT norm.
- **Scheduling** — never during a production run. Schedule against the maintenance window — and even then, **only with OT engineering in the room.**
- **Segmentation** — the [[Purdue Model]] (Levels 0–5) is the exam answer for OT network architecture. Level 0 = physical process, Level 3.5 = the DMZ between IT and OT, Levels 4–5 = corporate IT. Scanners live in Level 4. They reach down through a controlled jump host or not at all.
- **Sensitivity levels** — OT assets are typically tagged "Critical" or "Crown Jewel" in [[CMDB]] and get hand-built scan policies (no aggressive checks, no fuzzing, no brute-force auth attempts).
- **Asset discovery / device fingerprinting** — passive fingerprinting via traffic capture; tools identify a PLC's vendor and firmware version from protocol behavior, not from probing.

### Frameworks that govern OT

| Framework | Scope | Why it shows up on the exam |
|---|---|---|
| **[[NIST SP 800-82]]** | Guide to ICS Security | The default US reference |
| **[[IEC 62443]]** | Industrial automation security | International standard, zones-and-conduits model |
| **[[NERC CIP]]** | Bulk electric system in North America | Mandatory, fines have teeth |
| **[[ISO/IEC 27000]] series** | General ISMS | Applies to OT if scoped in |
| **[[CIS]] benchmarks** | Host-level hardening | Limited OT coverage but real for HMIs |
| **[[PCI DSS]]** | Cardholder data | Touches OT only when payment systems bridge into building automation |

### CompTIA exam traps

> **CompTIA exam trap:** When a scenario says "active vulnerability scan against the SCADA network," the right answer is never "tune the scan" or "run it after hours." It's **passive scanning** or **explicitly do not scan / use compensating controls**. Active scans against ICS are the exam's classic wrong-answer trap.

> **CompTIA exam trap:** SCADA vs. ICS vs. OT terminology. ICS is the umbrella, SCADA is specifically the geographically-distributed supervisory architecture (think pipelines, grids), DCS is site-contained (think refinery), OT is everything physical-process-touching. If the question mentions "geographically dispersed sites with a central control room," the answer is SCADA, not generic ICS.

> **CompTIA exam trap:** [[Fuzzing]] is a development-time technique for finding input-handling bugs. It is **never** the right answer for live OT assessment — fuzzing a PLC will crash it. Fuzzing belongs in the vendor's lab or your isolated test bench, not on the production floor.

> **CompTIA exam trap:** [[Static]] vs. [[dynamic analysis]] in an ICS context — static (reading firmware/code without running it) is safe; dynamic (running and probing the live device) is dangerous. For OT, static + passive network analysis is the safe combination.

### Reverse engineering and OT

ICS firmware reverse engineering is its own discipline. Researchers pull firmware off a PLC, load it into Ghidra or IDA, and look for hard-coded credentials, weak crypto, and command injection. CompTIA doesn't expect you to do this — they expect you to know it exists and that it's how most CVEs against ICS gear get discovered. Vendor patches lag by months to years.

### Regulatory requirements that change scanning posture

- **NERC CIP-007** — requires vulnerability assessments on BES cyber systems, but explicitly permits passive methods
- **CIRCIA (US)** — covered entities must report substantial OT incidents within 72 hours
- **TSA Security Directives** — post-Colonial, pipelines have mandatory baseline assessment cadence
- **EU NIS2** — expanded scope to manufacturing, food, waste — all OT-heavy

## SOC reality

- The 3am alert that involves OT almost never comes from the OT network directly — it comes from the **IT/OT boundary**. A jump host in the Purdue Level 3.5 DMZ logs an outbound connection to a domain that just hit your threat intel feed. That's the alert. The actual PLC is silent.
- L1's first move is **never** "scan the OT subnet to confirm." It's "check whether the jump host's session is still active, pull NetFlow for anything crossing the IT/OT boundary, and page the OT engineering on-call." OT engineering is a separate phone tree from IT — know who they are before you need them.
- The CISO's first three questions: *Is the physical process safe right now? Is the SIS (safety system) intact? Did anything cross into Level 2 or below?* Containment options on OT are limited — you often can't just "isolate the host" because the host is controlling a turbine that takes six hours to spin down safely.
- Never promise leadership "we've contained the OT incident" until the OT engineers confirm the physical process is in a known-good state. Network containment ≠ process containment.
- Handoff path: L1 SOC → L2 → IR lead → **OT engineering** → plant manager → legal/regulatory (CIRCIA clock starts ticking immediately). Loop in physical safety officers early. *I learned this the hard way: I once paged an IR call without OT engineering on the bridge, and we spent 40 minutes arguing about whether to pull a network cable that would have triggered an automated emergency shutdown costing six figures.*

## Related concepts

[[SCADA]] · [[OT security]] · [[Purdue Model]] · [[Passive vs active scanning]] · [[Asset discovery]] · [[Device fingerprinting]] · [[NIST SP 800-82]] · [[IEC 62443]] · [[NERC CIP]] · [[CIS benchmarks]] · [[ISO 27000 series]] · [[PCI DSS]] · [[Fuzzing]] · [[Static analysis]] · [[Dynamic analysis]] · [[Reverse engineering]] · [[Credentialed scanning]] · [[Agent vs agentless]] · [[Network segmentation]] · [[Critical infrastructure]] · [[CIRCIA]]

*Source: VIRGIL knowledge base — 2026-05-11*