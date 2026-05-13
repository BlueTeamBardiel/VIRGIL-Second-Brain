# SCADA — Supervisory Control and Data Acquisition

## What it is

In **Portal**, GLaDOS runs the Aperture Science Enrichment Center from a central control room. She watches every test chamber through cameras, opens and closes the moving platforms, fires the turrets, drops the companion cube into the incinerator on command, and reads the chamber sensors that tell her whether Chell is still alive. The test chambers are old, half of them are duct-taped together, and the whole facility is one decent EMP from going dark. But GLaDOS keeps running because the chambers were built to be operated, not patched. Reboot a test chamber to install updates and the test subject dies mid-portal.

That's exactly what **SCADA** is — a central brain watching and steering physical machinery that was designed for uptime, not for security.

**SCADA** (Supervisory Control and Data Acquisition) is the class of industrial control system that monitors and controls geographically distributed physical processes — power grids, water treatment, oil pipelines, manufacturing lines, building HVAC. It's a subset of **OT (Operational Technology)** and overlaps with the broader category **ICS (Industrial Control Systems)**. The architecture is roughly: field devices (sensors, actuators, valves) → PLCs/RTUs (programmable logic controllers / remote terminal units) → HMI (human-machine interface, the operator's screen) → SCADA server / historian (the central database and control logic). Protocols are old and mostly unauthenticated: Modbus, DNP3, S7, Profinet, IEC 60870-5-104.

For a CySA+ analyst, SCADA is the asset class where your vulnerability scanner can knock the plant offline if you point it at the wrong subnet. That's the whole exam point.

## Why it matters

Critical infrastructure runs on SCADA. Power, water, fuel, food, manufacturing — every one of them has PLCs in a cabinet somewhere running firmware from 2011 that can't be patched without a 6-week change window and a forklift.

CompTIA tests SCADA under **Objective 2.1** because it is the textbook example of **special considerations** for vulnerability scanning. The right answer on the exam is almost never "run a credentialed Nessus scan against the PLCs." The right answer is some combination of passive scanning, network segmentation, scan windows aligned to maintenance, and accepting that you cannot treat OT like IT.

Real-world stakes: Stuxnet (Iranian centrifuges), Ukraine power grid 2015/2016, Colonial Pipeline 2021 (IT ransomware that forced OT shutdown), Oldsmar water treatment 2021 (TeamViewer on the HMI, attacker tried to raise sodium hydroxide levels). When SCADA breaks, people die or cities go dark. That's the threat model.

## Key facts

### SCADA vs ICS vs OT — name discipline

CompTIA uses these loosely, but the relationships matter.

| Term | Scope |
|---|---|
| **OT (Operational Technology)** | The umbrella. All hardware/software that monitors or controls physical processes. |
| **ICS (Industrial Control Systems)** | Subset of OT. Includes SCADA, DCS (Distributed Control Systems), PLCs. |
| **SCADA** | Subset of ICS. Geographically distributed monitoring and control with a central supervisory layer. |
| **DCS** | Subset of ICS. Localized control — one plant, one process. SCADA is wide-area; DCS is plant-floor. |
| **PLC / RTU** | The field controller itself. The brick in the cabinet. |
| **HMI** | The operator's screen. Usually a Windows box that hasn't been rebooted in 400 days. |

### The Purdue Model — why [[Network Segmentation]] is everything in OT

SCADA networks are conceptually layered. CompTIA expects you to know segmentation exists; the Purdue Model is the canonical reference.

| Level | What lives there |
|---|---|
| **Level 0** | Physical process — valves, motors, sensors |
| **Level 1** | Basic control — PLCs, RTUs |
| **Level 2** | Supervisory — HMIs, SCADA servers |
| **Level 3** | Operations — historians, MES, engineering workstations |
| **Level 3.5** | **IT/OT DMZ** — the firewall layer. This is where scans terminate. |
| **Levels 4–5** | Enterprise IT — corporate network, internet |

The IT/OT DMZ at Level 3.5 is the segmentation boundary. A vulnerability scanner sits in IT. A SCADA PLC sits at Level 1. You do not scan across the DMZ without explicit authorization, a maintenance window, and a phone call to the plant manager.

### Why active scanning kills SCADA

A standard [[Vulnerability Scanning|active credentialed scan]] does things that are routine on a Windows server and lethal on a PLC:

- Sends malformed packets to fingerprint services. Modbus PLCs from 2008 fault on malformed Modbus.
- Opens many concurrent TCP sessions. PLCs have hard session limits (sometimes 4).
- Probes every port. The PLC's engineering port responds by halting the program.
- Triggers authentication. The PLC has no authentication. It just falls over.

There is a public list of PLCs that have been bricked by Nessus default scans. *I learned this the hard way: "it's just a discovery scan" is the phrase the plant manager will quote back to you in the after-action.*

### Scanning options for SCADA

This is the meat of Objective 2.1 for this topic.

| Approach | Use in OT? | Why |
|---|---|---|
| **Active scanning** (Nessus, Qualys, OpenVAS) | Rarely, only during maintenance windows | Can crash PLCs. Sessions exhaust. |
| **[[Passive Scanning]]** (Claroty, Nozomi, Dragos, Tenable.ot) | **Yes — default for OT** | Listens to mirror port / SPAN traffic. Identifies devices, firmware, vulnerabilities without touching them. |
| **[[Credentialed Scanning]]** | Sometimes on Level 2/3 Windows hosts | Never on PLCs themselves. |
| **[[Agent-based Scanning]]** | Only on engineering workstations | PLCs cannot run agents. |
| **[[Device Fingerprinting]]** via passive | Yes | Vendor, model, firmware version pulled from protocol banners. |
| **Map scans / Nmap** | Only with `-sn` (no port scan) or against allow-listed hosts | A default `nmap -sV` against a Modbus device can fault it. |

The passive tools (Claroty, Nozomi, Dragos) are purpose-built for OT. They parse Modbus, DNP3, S7, EtherNet/IP off the wire and build an inventory without sending a packet. That's the right answer on the exam when the scenario says "critical infrastructure" or "ICS."

### Asset discovery in OT

**[[Asset Discovery]]** in IT is `nmap` or AD sync. In OT, it's passive protocol parsing, manual cabinet walkdowns with a clipboard, and matching MAC addresses to vendor OUIs. The CySA+ scenario will mention an environment where the asset inventory is outdated — that's because nobody scanned the plant network for six years. Right answer: deploy passive monitoring at the IT/OT DMZ and at Level 2 SPAN ports.

### Frameworks and regulatory weight

| Framework | Relevance |
|---|---|
| **NIST SP 800-82** | The canonical guide to securing ICS. Memorize the name. |
| **IEC 62443** | International standard for industrial automation security. Defines security levels SL1–SL4. |
| **NERC CIP** | Mandatory for the North American bulk electric system. Fines are real. |
| **[[CIS Benchmarks]]** | Exist for some OT components (Windows HMIs) but not for PLCs. |
| **[[ISO 27000]] series** | General InfoSec. Less specific to OT. |
| **TSA Pipeline Security Directives** | Post-Colonial Pipeline. US oil/gas. |

### Special considerations — the CompTIA checklist

- **Scan windows** must align with maintenance outages. You don't scan a running plant.
- **Performance** impact on legacy protocols is severe. Throttle scans aggressively.
- **Sensitivity levels** in OT are higher than IT — a "low" CVSS scored vulnerability that crashes a turbine is operationally a P1.
- **Segmentation** is the compensating control when patching is impossible.
- **Regulatory requirements** (NERC CIP, IEC 62443) may *forbid* active scanning of certain assets.
- **Patching** is rare. Mean time to patch in OT is measured in months to years. Compensating controls (segmentation, monitoring, allow-listing) carry the weight.

### CompTIA exam traps

> **CompTIA exam trap:** When the scenario says "critical infrastructure," "manufacturing plant," "water utility," or names Modbus/DNP3/PLC — the answer is **passive scanning**, not credentialed Nessus. CompTIA wants to see that you know active scanning can disrupt operations.

> **CompTIA exam trap:** SCADA, ICS, and OT are not synonyms. OT is the umbrella, ICS is the subset, SCADA is a specific architecture within ICS. If the question describes a single plant with localized control, that's **DCS**, not SCADA. SCADA is geographically distributed (pipelines, grids, water districts).

> **CompTIA exam trap:** "Why can't we just patch the PLC?" — the right answer is not "we should patch it anyway." It's some combination of: vendor support contracts forbid third-party patches, the firmware can only be updated during a plant outage scheduled 6 months out, the device runs custom code that breaks on update, and **safety certifications** (SIL ratings) are invalidated by unauthorized firmware changes. CompTIA categorizes these under **inhibitors to remediation**.

> **CompTIA exam trap:** [[PCI DSS]] does not apply to SCADA unless the OT network handles cardholder data (rare — vending machines, fuel pumps). Don't pick PCI DSS as the regulatory answer for a power plant. NERC CIP or IEC 62443 is the right framework.

## SOC reality

- The first time you hear about SCADA in your SOC career is when the vulnerability management team asks for permission to scan the "plant network" and you have to be the one to say no until you've talked to the plant engineer. *I learned this the hard way: the scan ticket looked routine. It wasn't.*
- The alert that matters at 3am: **east-west traffic from corporate IT to the OT DMZ** on a non-standard port. Colonial Pipeline didn't ransomware the OT directly — they ransomwared IT and the company shut OT down voluntarily because they couldn't bill customers. Your IT/OT boundary is the first thing the IR lead asks about.
- The CISO question: "Is OT segmented from IT?" The honest answer is usually "mostly, but engineering workstations dual-home and there's a jump box nobody documented." Write that down before the audit.
- Never promise leadership that an OT environment is "patched." The right framing is "monitored, segmented, and risk-accepted with compensating controls."
- Escalation path for an OT incident is different: SOC L1 → SOC L2 → IR lead → **plant manager / OT engineer** → safety officer → legal. The plant manager has veto power on containment actions because pulling a cable can shut down a turbine and people downstream lose heat.

## Related concepts

[[ICS]] · [[OT (Operational Technology)]] · [[Passive Scanning]] · [[Network Segmentation]] · [[Asset Discovery]] · [[Device Fingerprinting]] · [[Credentialed Scanning]] · [[Vulnerability Scanning]] · [[Inhibitors to Remediation]] · [[Compensating Controls]] · [[NIST SP 800-82]] · [[Purdue Model]] · [[Critical Infrastructure]] · [[Modbus]] · [[Stuxnet]] · [[Colonial Pipeline]] · [[Risk Acceptance]]

*Source: VIRGIL knowledge base — 2026-05-11*