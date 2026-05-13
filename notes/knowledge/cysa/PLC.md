# PLC — Programmable Logic Controller

## What it is

In **Tetris**, the stack rises one piece at a time and you cannot pause to think — the I-piece drops on a fixed cadence, the well fills, and if you mis-place a single block early in the game you carry that hole for the next twenty pieces. You don't get to stop the world to fix it. The board keeps feeding you tetrominoes whether you're ready or not. That's exactly what a **PLC** does on a factory floor — it ticks on a fixed scan cycle, reads inputs, executes ladder logic, writes outputs, forever, and you cannot pause it to patch it without stopping the line.

In plain English: a PLC is the small ruggedized industrial computer that runs the physical world. It opens valves, spins motors, fires actuators, reads sensors. It lives in factories, water plants, power substations, pipelines, refineries, and HVAC closets.

Technically: a **Programmable Logic Controller** is a real-time embedded controller running deterministic scan-cycle logic (commonly ladder logic, function block, or structured text per IEC 61131-3) over industrial protocols like Modbus, DNP3, EtherNet/IP, PROFINET, and S7. It is the workhorse of [[OT]] / [[ICS]] / [[SCADA]] environments. On the CySA+ exam, PLCs are the canonical example of a **proprietary, legacy system** that breaks every assumption your IT vulnerability management program makes.

## Why it matters

CS0-003 Objective 4.1 wants you to explain the inhibitors to remediation. PLCs are the inhibitors. They are the reason a critical CVE sits unpatched for three years, and the reason the answer on the exam is almost never "patch immediately."

Real-world stakes: Stuxnet rewrote PLC logic on Siemens S7-300s controlling centrifuges. The 2021 Oldsmar water plant attack rode in over remote access to a HMI that talked to the chemical-dosing PLC. Colonial Pipeline shut down the OT side preemptively because they couldn't be sure the IT compromise hadn't crossed. The pattern is the same: when a PLC is compromised, the loss isn't data — it's physical damage, environmental release, or human casualty.

Exam relevance: the PLC is the worked example for **proprietary systems**, **legacy systems**, **business process interruption**, **compensating controls**, and **MOU/SLA constraints** in vulnerability management reporting.

## Key facts

### What makes a PLC a vulnerability-management nightmare

| Property | Why it breaks IT-style patching |
|---|---|
| **Proprietary firmware** | Vendor (Siemens, Rockwell, Schneider, ABB, Mitsubishi) owns the update. No third-party patching. |
| **Long lifecycle** | 15–30 year service life. Vendors EOL'd the firmware before your SOC analyst was born. |
| **Deterministic scan time** | Every microsecond matters. Patches can change timing and brick the process. |
| **No reboot window** | The process runs 24/7. Stopping it costs $100k/hour or contaminates a batch. |
| **Safety certifications** | SIL-rated systems lose certification if firmware changes without re-validation. |
| **Vendor support contracts** | Patching without vendor approval voids warranty and support. |
| **Flat OT networks** | Often no authentication on protocols. Modbus has no auth at all. |
| **Air-gap mythology** | "It's air-gapped" — it isn't. It's connected via the engineering workstation, the historian, or a forgotten cellular modem. |

### Inhibitors to remediation — the PLC checklist

CompTIA tests this directly. When a vulnerability scan flags a PLC, every one of these can block remediation:

- **Proprietary systems** — only the OEM can issue firmware. You wait for them.
- **Legacy systems** — the PLC runs a CPU from 2003. There is no patch and never will be.
- **Business process interruption** — patching requires line shutdown. Plant manager says no.
- **Degrading functionality** — newer firmware may drop support for the protocol your HMI speaks.
- **Organizational governance** — change advisory board meets monthly. OT change board meets quarterly.
- **MOU** — a memorandum of understanding with the integrator says only they touch the controller.
- **SLA** — the uptime SLA with the downstream customer doesn't allow a maintenance window for 11 weeks.
- **Configuration management** — the as-built documentation is wrong. Nobody knows what's actually loaded.

### Compensating controls — what you do instead of patching

Because you usually cannot patch, the answer in OT is almost always **compensating controls**. This is the CySA+ exam's favorite move.

- **Network segmentation** — Purdue Model levels 0–5. PLC sits at Level 1, isolated from corporate IT by a DMZ (Level 3.5) with a data diode or unidirectional gateway.
- **Allow-list firewalls** — only the engineering workstation MAC/IP can talk to the PLC on the engineering port. Modbus from anywhere else is dropped.
- **Protocol-aware IDS** — products that parse Modbus/DNP3/S7 and alert on writes when the baseline is read-only.
- **Jump hosts with MFA** — no direct access to the OT network. You RDP to a hardened host, then SSH onward, every keystroke logged.
- **Physical key switches** — the PLC has a RUN/PROGRAM/REMOTE key. In RUN mode, logic cannot be modified. The key lives in the plant manager's drawer.
- **Asset inventory + passive scanning** — active Nessus scans against a PLC can crash it. Use passive tools (Claroty, Dragos, Nozomi) that watch traffic rather than probing.

> **CompTIA exam trap:** When a question describes a critical CVE on a PLC running a water-treatment process and asks for the BEST action, the answer is almost never "patch immediately." It's "implement compensating controls" — segmentation, monitoring, access restriction — until a vendor-approved patch can be applied during a scheduled maintenance window. Patching first is the IT answer. OT thinks differently.

### Risk scoring breaks on PLCs

CVSS treats a CVSS 9.8 the same whether it lives on a corporate web server or a PLC controlling a turbine. It is not the same.

- **Environmental score** matters more than base. A PLC behind three layers of segmentation with allow-list firewalling drops the modified-attack-vector dramatically.
- **Compensating controls reduce effective risk** even when the base CVSS doesn't change. Document this in the report.
- **Impact subscore (safety)** — newer CVSS 4.0 includes Safety (S) as a metric. Use it for OT. A vulnerability that can cause physical harm or environmental release ranks differently than one that leaks email.
- **Business risk vs technical risk** — a 7.5 on the PLC controlling the reactor cooling outranks a 9.8 on the marketing intern's laptop. Risk score in the report must reflect this, or executives will misallocate.

### What goes in the vulnerability report — PLC edition

CompTIA's 4.1 objective is about reporting. For a PLC finding, the report includes:

- **Affected hosts** — by tag (PLC-LINE3-DOSING-01), not just IP. IPs in OT change less, but the asset name is what the plant engineer recognizes.
- **Risk score** — CVSS base + environmental + compensating-control adjustment.
- **Mitigation** — segmentation, firewall rule, IDS signature, physical key. Not "patch."
- **Action plan** — vendor patch tracking, next maintenance window, interim controls owner.
- **Recurrence** — same CVE class hitting same vendor product line is a vendor problem; escalate procurement.
- **Trends** — quarter-over-quarter, are OT findings rising? Falling? What's the MTTRem in OT (it will be measured in months, not days, and that's normal).
- **KPIs / SLOs** — patch SLA for OT is typically 90–180 days or "next planned outage," not 30. Set the metric realistically or you'll fail it forever.
- **Top 10** — the OT Top 10 is its own list. Don't blend it with the IT Top 10 on the same dashboard or executives will fixate on the wrong fires.
- **Stakeholders** — plant manager, OT engineer, integrator, safety officer, OEM rep. Not just the CISO.
- **Compliance reports** — NERC CIP for power, NIS2 in EU, TSA Security Directives for pipelines, EPA for water. Each has its own format.

### Awareness, education, and training

Plant engineers are not SOC analysts and shouldn't be expected to be. The training program for OT vulnerability management covers:

- Recognizing phishing aimed at engineering staff (the spear-phish targets them, not finance).
- Why you do not plug your phone into the HMI USB port (Stuxnet's vector).
- The engineering workstation is a controlled asset. It does not browse the web.
- Removable media policy and sheep-dip scanning.
- Reporting unexpected PLC mode changes (REMOTE when it should be RUN) immediately.

### Changing business requirements

When the business adds a new line, brings in a remote-monitoring vendor, or moves to predictive maintenance, the OT attack surface expands. Vulnerability management has to track:

- New vendor remote access (the historian-as-a-service that needs outbound 443 to AWS).
- New IIoT sensors (every cheap LoRaWAN gateway is a new untrusted device).
- Cloud connectivity for analytics — what was air-gapped now isn't.

Each one is a delta. Each delta needs re-segmentation review and a new compensating-control assessment.

## SOC reality

- **The alert at 3am**: Modbus write from a workstation that has historically only issued reads. The IDS flags it. L1 sees "PLC-DOSING-03: unexpected function code 06 (write single register)." L1 does not block it — blocking a legitimate operator command stops the plant. L1 calls the on-call plant engineer first.
- **First action**: confirm with the engineering desk whether the write was authorized. If yes, tune the rule. If no, escalate immediately and isolate the engineering workstation, not the PLC.
- **What the CISO asks**: "Is the process still running safely? Have we contacted the plant manager? Is safety instrumented system (SIS) still independent and uncompromised?" The SIS is the safety net — if it's separate and healthy, you have time.
- **Never promise**: "We can patch this weekend." OT patching is a months-long coordination with the vendor, the integrator, the plant, and safety. Anyone who promises a weekend patch on a PLC has never patched a PLC.
- **Handoff**: L1 → OT-aware L2 → IR with OT specialist → plant manager → OEM / integrator → executive + legal (regulator notification clocks may have started). The OT specialist is rare. Identify yours before the incident.

*If you treat a PLC like a server, you will either fail to remediate or you will brick a process and end up on the news. Patch is the last lever, not the first.*

## Related concepts

[[ICS]] · [[SCADA]] · [[OT]] · [[Purdue Model]] · [[Modbus]] · [[DNP3]] · [[Compensating controls]] · [[Legacy systems]] · [[Proprietary systems]] · [[Inhibitors to remediation]] · [[MOU]] · [[SLA]] · [[CVSS]] · [[Vulnerability management]] · [[Network segmentation]] · [[Stuxnet]] · [[Safety instrumented system]] · [[NERC CIP]]

*Source: VIRGIL knowledge base — 2026-05-11*