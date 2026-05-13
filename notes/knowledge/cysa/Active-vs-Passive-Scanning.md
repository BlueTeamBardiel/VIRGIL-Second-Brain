# Active vs Passive Scanning

## What it is

In **The Legend of Zelda: Breath of the Wild**, Link has two ways to learn about a Bokoblin camp on the horizon. He can climb a tower, pull out the Sheikah Slate, and *scan* — passive observation, zero footprint, the camp never knows he's there. Or he can shoot a bomb arrow at the watchtower and see what comes screaming out — active probing, maximum information, and now every Bokoblin in a 200-meter radius is sprinting at him with a spiked club. Same target, two intelligence-gathering strategies, completely different risk profiles.

That's exactly what active vs passive scanning is in vulnerability management. Same network, same hosts, two ways to enumerate them — and the wrong choice on the wrong segment will get something killed.

**Active scanning** sends crafted packets at targets and analyzes the responses. Think Nmap SYN scans, Nessus credentialed scans, Qualys agent-pings, OpenVAS service probes. The scanner *talks* to the target.

**Passive scanning** sits on a SPAN port, network tap, or NetFlow collector and listens to traffic that's already happening. Think Zeek, Suricata in IDS mode, Tenable Nessus Network Monitor, Greynoise. The scanner *eavesdrops*.

Per CompTIA Objective 2.1, you're expected to know when to deploy each, what each one misses, and which environments will physically break if you pick wrong.

## Why it matters

Pick active scanning on a hospital network with legacy infusion pumps and you have just sent SYN packets at devices whose TCP stacks were written in 2003 and will hard-fault on an unexpected RST. Pick passive on an air-gapped lab segment with no traffic and you'll generate a beautiful report that says "no assets found" while sitting on top of forty unpatched hosts.

This is **CS0-003 Objective 2.1** — vulnerability scanning methods and concepts — and CompTIA tests the *judgment* layer, not just the definitions. They want you to know that the SCADA engineer who hears "active scan" reaches for the door.

## Key facts

### Active scanning — what it does

The scanner originates traffic. It crafts probes — TCP SYNs, UDP packets, ICMP echoes, HTTP GETs, SNMP queries, SMB negotiations — fires them at targets, parses responses, and builds a picture of what's running where.

| Capability | Active scanning |
|---|---|
| Asset discovery | Yes, even for silent hosts |
| Service version detection | Strong (banner grabs, fingerprinting) |
| Vulnerability identification | Strong (CVE-to-version mapping) |
| Network impact | Measurable — bandwidth, sessions, target CPU |
| Risk to fragile hosts | Real — can crash legacy/OT/ICS systems |
| Stealth | Loud — IDS will see it, target logs it |

**Active scan types you must know:**

- **[[Map scan]]** — basic topology and host discovery (Nmap `-sn`, ping sweep). "What's alive on this /24?"
- **Port scan** — TCP/UDP service enumeration. SYN scan, connect scan, UDP scan.
- **[[Device fingerprinting]]** — OS detection, service version detection, banner grabbing. Nmap `-O -sV`.
- **Vulnerability scan** — matches service versions against CVE database. Nessus, Qualys, OpenVAS.
- **[[Fuzzing]]** — throws malformed input at services to find crash conditions. Active by nature, often destructive.
- **[[Credentialed scan]]** — scanner authenticates to the target and reads installed packages, registry, patch level directly. Deeper than uncredentialed but still active.

### Passive scanning — what it does

The scanner never sends a packet to the target. It watches existing traffic — DHCP requests, ARP broadcasts, TLS handshakes, HTTP User-Agents, SMB advertisements — and infers what's on the wire from what those packets reveal.

| Capability | Passive scanning |
|---|---|
| Asset discovery | Only for hosts that talk |
| Service version detection | Limited (whatever leaks in headers/banners) |
| Vulnerability identification | Weak — inference only |
| Network impact | Zero — pure observation |
| Risk to fragile hosts | None |
| Stealth | Invisible to targets |

**Passive techniques:**

- Sniffing SPAN/mirror ports or network taps
- NetFlow / IPFIX / sFlow analysis
- DHCP and ARP table monitoring
- DNS request logging
- TLS JA3/JA3S fingerprinting
- Reading existing log sources (proxy, firewall, EDR telemetry)

> **CompTIA exam trap:** Passive scanning is *not* the same as "less invasive active scanning." Passive sends zero packets at the target. If the question says "the scanner uses lightweight TCP probes to minimize impact," that's still active — just polite active. Passive means the scanner is observing traffic that would exist with or without it.

### Where each one wins

**Active is right when:**

- You need a complete asset inventory and silent hosts must be found
- You need version-accurate vulnerability data for patch prioritization
- The environment is robust IT — Windows servers, modern Linux, standard enterprise gear
- You need [[CIS Benchmarks]] or [[Security Baseline Scanning]] compliance evidence (credentialed active scan is the only way to read config state)
- [[PCI DSS]] requires it — Requirement 11.3 mandates internal and external active vulnerability scans quarterly, plus after significant change

**Passive is right when:**

- The environment is [[Operational Technology]] / [[ICS]] / [[SCADA]] — see below
- You need continuous discovery without scan windows
- You can't get change-board approval to actively scan production
- You're doing [[threat hunting]] and want to identify unknown assets without alerting the adversary that you're looking
- You need to discover BYOD or shadow IT that would never accept a credentialed scan

### Special considerations — OT, ICS, SCADA, critical infrastructure

This is the section CompTIA loves. **Active scanning of [[OT]] / [[ICS]] / [[SCADA]] environments is presumed dangerous.** Legacy PLCs, RTUs, HMIs, and field controllers were built for deterministic Modbus/DNP3/Profinet traffic on isolated networks. An Nmap SYN scan against a Siemens S7 PLC can crash it. A credentialed Nessus scan against a nuclear control system is a career-ending event.

| Environment | Default approach |
|---|---|
| Corporate IT | Active, credentialed, scheduled |
| DMZ | Active, external + internal angle |
| OT/ICS/SCADA | Passive by default; active only with vendor approval and a maintenance window |
| Medical devices | Passive; active only with biomed sign-off |
| Cloud | Agent-based or API-based (vendor TOS often prohibits raw active scans) |

Frameworks like **[[ISO 27000]]** series, **[[NIST SP 800-82]]** (ICS security), and **[[CIS Benchmarks]]** all explicitly warn that active enumeration on OT requires special handling. Regulatory requirements — NERC CIP for power, HIPAA for healthcare, [[PCI DSS]] for cardholder data — each carry their own scan posture requirements.

### Other axes that show up alongside active/passive

CompTIA bundles several scanning dimensions in 2.1. Know each independently:

- **[[Internal vs External Scanning]]** — internal scans run from inside the perimeter (find what an attacker who got in would see); external scans run from the public internet (find what an attacker on Shodan sees). PCI DSS requires both.
- **[[Credentialed vs Non-credentialed Scanning|Credentialed vs Non-credentialed]]** — credentialed reads config state, finds missing patches, far fewer false positives. Non-credentialed sees only what's exposed to the network.
- **[[Agent vs Agentless Scanning|Agent vs Agentless]]** — agent runs on the endpoint, reports back, works for laptops that aren't on the corporate LAN. Agentless scans from the network, no install footprint.
- **[[Static vs Dynamic Analysis|Static vs Dynamic]]** — static (SAST) reads source code without executing; dynamic (DAST) probes a running application. DAST is essentially active scanning for web apps. See [[OWASP Testing Guide]].
- **Scheduling** — when scans run. Production active scans go in maintenance windows. Passive runs 24/7.
- **Sensitivity levels** — scanner aggressiveness tuning. "Safe checks only" vs "include dangerous plugins" — Nessus literally has this toggle.
- **Performance and segmentation** — scanning across VLANs requires routing; scanning behind a firewall requires ACLs or a scanner inside the segment. Network [[segmentation]] limits scan reach by design.

### What active misses, what passive misses

*Active scanning misses what isn't on right now.* A laptop that's docked at home during the Saturday-night scan window is invisible until Monday.

*Passive scanning misses what doesn't talk.* A jump box that sits idle until an admin RDPs in once a month will not appear in passive inventory until that month.

**The mature answer is both.** Passive for continuous coverage and OT safety. Active for depth and compliance evidence. The two feed the same asset inventory and CMDB.

> **CompTIA exam trap:** If the scenario describes a hospital, power plant, water utility, manufacturing floor, or any "we cannot have downtime" environment and asks which scan type to use first — the answer is passive. Even if active would give better data. CompTIA tests whether you know that *safety beats completeness in OT*.

> **CompTIA exam trap:** A "non-credentialed scan" is still an active scan. Don't confuse credentialed/non-credentialed (authentication) with active/passive (probing vs observing). Two orthogonal axes.

## SOC reality

- The L1 analyst opens the Tenable console Monday morning and sees the weekend scan timed out on 40% of the OT VLAN because the change board blocked credentialed access and half the targets stopped responding mid-scan. The ticket gets escalated to L2 with a note: "rescan needed, coordinate with plant engineering."
- The CISO asks: "Do we have an accurate asset inventory?" The honest answer is *only if active and passive both feed the CMDB and we reconcile them weekly.* One source alone is always wrong.
- The OT engineer's first question when you propose any scan is: "What ports, what rate, what's your rollback plan if a PLC faults?" If you can't answer in their terms, you don't scan. *I have watched a five-minute Nmap probe brick a $400k bottling line. The scan completed. The line didn't.*
- The IR lead during an active intrusion will ask whether scanners can be paused — because active scans during IR generate noise that masks real adversary activity in the SIEM. Pause active. Keep passive running; it might catch the adversary's lateral movement.
- Never tell leadership "the network is fully inventoried." Tell them "the network is inventoried as of the last successful scan cycle, with the following known gaps." The gap list is the actual deliverable.

## Related concepts

[[Vulnerability Management Lifecycle]] · [[Credentialed vs Non-credentialed Scanning]] · [[Agent vs Agentless Scanning]] · [[Internal vs External Scanning]] · [[Static vs Dynamic Analysis]] · [[CVSS]] · [[Device Fingerprinting]] · [[Map Scan]] · [[Fuzzing]] · [[CIS Benchmarks]] · [[PCI DSS]] · [[OWASP]] · [[OT]] · [[ICS]] · [[SCADA]] · [[NIST SP 800-82]] · [[Asset Inventory]] · [[Network Segmentation]] · [[SIEM]]

*Source: VIRGIL knowledge base — 2026-05-11*