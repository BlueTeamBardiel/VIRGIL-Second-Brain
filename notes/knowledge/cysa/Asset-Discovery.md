# Asset Discovery

## What it is

In **Pokemon Red/Blue**, the Pokedex starts empty. Professor Oak hands you the device and says "go fill it." Every Pokemon you see gets a SEEN entry — silhouette, name, location. Every one you catch gets a CAUGHT entry — full stats, moveset, weight, type. You can't strategize a gym fight against Misty without knowing what's in your own party and what's in hers. The kid who skips Viridian Forest because Caterpie is "boring" walks into Brock with a Charmander and a Pidgey and learns about Rock-type resistance the hard way.

That's exactly what **asset discovery** does — find every device, service, and system on your network before you try to defend any of them. The corollary is the rule every SOC analyst learns by month three: **you cannot secure what you do not know exists.**

Technical definition for CS0-003: asset discovery is the systematic identification and enumeration of every host, service, application, and device within a defined scope, producing an authoritative inventory that feeds the [[CMDB]], scopes [[Vulnerability Scanning]], and anchors [[Risk Management]] decisions. It precedes scanning. Skip it and your scans are guesswork.

## Why it matters

CompTIA puts asset discovery at the top of Objective 2.1 for a reason. Every other vulnerability management activity downstream — scan scheduling, CVSS prioritization, patch deployment, [[Compliance Reporting]] — depends on an accurate asset inventory. Garbage inventory in, garbage program out.

Real-world stakes: the 2017 Equifax breach happened on a Struts server that wasn't on the patch list because it wasn't on the asset list. The 2020 SolarWinds blast radius was so hard to scope because organizations couldn't quickly answer "where is Orion deployed?" Shadow IT — the marketing intern's unsanctioned SaaS dashboard, the dev team's forgotten test VM with port 3389 open to the internet — is where attackers live now. They don't breach the hardened mail server. They breach the thing nobody remembers owning.

Exam-relevance: Domain 2.0 is 30% of CS0-003. Asset discovery, internal vs. external scanning, credentialed vs. non-credentialed, agent vs. agentless, and special-considerations questions (ICS/SCADA, PCI DSS scope) all sit in this objective. Expect at least three questions touching this material.

## Key facts

### What discovery actually finds

| Discovery output | What it means | Where it goes |
|---|---|---|
| **Live hosts** | IPs that respond to probes | Asset inventory, CMDB |
| **Open ports / services** | Listening daemons (SSH/22, RDP/3389, SMB/445) | Scan scoping, attack surface review |
| **OS fingerprint** | Win Server 2019, Ubuntu 22.04, Cisco IOS 15.x | Patch baselines, scanner profiles |
| **Shadow IT** | Unsanctioned devices, rogue APs, BYOD | Risk register, policy enforcement |
| **Rogue services** | Unauthorized listeners, miners, backdoors | IR ticket, hunt queue |

### Active vs. passive discovery

**Active scanning** sends packets and waits for replies. Nmap ping sweeps, SYN scans, version probes. Fast, accurate, noisy. Generates IDS alerts. Can knock over fragile devices — printers, legacy [[SCADA]] PLCs, medical equipment. Active is the trainer throwing a Pokeball: you know immediately whether something's there, but you might startle it.

**Passive scanning** watches traffic that's already flowing. NetFlow, IPFIX, span ports, ARP table sniffing, DHCP lease analysis. Zero packets injected. Won't break OT gear. Misses anything that's quiet on the wire. Passive is sitting in tall grass listening for rustles — you only see what walks past.

> **CompTIA exam trap:** active scanning is *not* always preferred. For [[ICS]]/[[SCADA]]/OT environments, **passive is mandatory** — an active SYN scan against a PLC can halt a production line. The "best" scan type is scenario-dependent. Read the stem for "manufacturing floor," "hospital," "utility" — that's the passive-discovery signal.

### Device fingerprinting

How a scanner figures out *what* a host is, not just *that* it exists:

- **TCP/IP stack fingerprinting** — TTL defaults, window sizes, TCP option ordering. Windows behaves differently than Linux at the packet level.
- **Banner grabbing** — service responses leak version strings (`SSH-2.0-OpenSSH_8.9p1 Ubuntu`).
- **Service version probes** — Nmap `-sV` sends crafted requests and matches replies against a signature DB.
- **OS detection** — Nmap `-O` combines stack fingerprinting with probe responses.

Fingerprinting feeds scanner accuracy. A scanner that doesn't know a host is Windows will run Linux CVE checks and produce false positives that waste your week.

### Credentialed vs. non-credentialed scans

| | Credentialed | Non-credentialed |
|---|---|---|
| **Access** | Scanner logs in with admin/root | External probe only |
| **Depth** | Reads registry, file versions, installed patches | Sees what an attacker on the wire sees |
| **Accuracy** | High — confirms patch state | Moderate — infers from banners |
| **Risk** | Credentials must be vaulted, rotated | Lower — no privileged account exposure |
| **Use case** | Internal vulnerability management | External attack surface assessment |

Credentialed wins for depth. Non-credentialed wins for adversary perspective. Mature programs run both.

### Agent vs. agentless

- **Agent-based** — software installed on the endpoint reports inventory and vulnerability state continuously. Works on roaming laptops, cloud instances, anything not always on the corporate LAN. Survives NAT, VPN, firewalls. Costs licensing and management overhead. Same architecture as [[EDR]].
- **Agentless** — scanner reaches out across the network on a schedule. No endpoint install. Misses devices that are offline during the scan window. Standard for network gear, printers, OT, anything that won't accept an agent.

### Internal vs. external scanning

- **Internal scan** — scanner inside the perimeter. Sees everything the firewall hides. Finds lateral movement opportunities, internal-only services, [[Segmentation]] gaps.
- **External scan** — scanner from the public internet. Sees what attackers see. Required quarterly by [[PCI DSS]] and must be performed by an **Approved Scanning Vendor (ASV)** for cardholder data environments.

Both are required for a mature program. CompTIA loves to ask which one a specific compliance regime mandates.

### Map scans

A **map scan** (often `nmap -sn`, formerly `-sP`) is host discovery only — no port scan. Send ICMP echo, ARP, TCP SYN to 443, and list what answers. It's the fastest way to ask "what's alive in 10.0.0.0/16?" and the foundation of every discovery sweep. Run a map scan first, then targeted port/version scans against the hosts that responded.

### Special considerations

CompTIA tests these scenarios specifically:

- **[[ICS]]/[[SCADA]]/OT** — passive only. Active probes have caused real outages. Schedule any necessary active work during maintenance windows with engineering present.
- **Critical infrastructure** — regulatory overlay (NERC CIP for power, TSA directives for pipelines). Discovery must be coordinated with operations.
- **Medical devices** — many are FDA-cleared at a specific firmware level. You cannot patch unilaterally. Discovery still applies; remediation is constrained.
- **Cloud assets** — ephemeral. A scan-once-a-week model misses containers that lived for 90 seconds. Use cloud-native asset APIs (AWS Config, Azure Resource Graph) alongside traditional discovery.
- **Cardholder data environment (CDE)** — [[PCI DSS]] requires quarterly internal scans, quarterly external ASV scans, and rescans after any significant change. Discovery defines CDE scope.

### Scheduling, performance, sensitivity

- **Scheduling** — discovery runs off-hours where possible, but cloud and roaming endpoints need continuous discovery to catch ephemeral assets. Production systems get scanned during change windows.
- **Performance** — bandwidth throttling, parallel host limits, scan timing templates (Nmap `-T0` paranoid to `-T5` insane). Slam a /16 with `-T5` during business hours and the helpdesk phones light up.
- **Sensitivity levels** — classify assets by data sensitivity (public, internal, confidential, restricted) and regulatory scope (PCI, HIPAA, SOX). Discovery output must include the tags, or downstream prioritization is blind.

### Frameworks that govern this work

- **[[CIS]] Controls** — Control 1 is *Inventory and Control of Enterprise Assets*. Control 2 is *Inventory and Control of Software Assets*. CIS puts asset discovery as the first two controls for a reason — nothing else matters if you skip it.
- **[[ISO/IEC 27001]]** — Annex A.5.9 requires an inventory of assets. ISO 27000 series is the international standard set.
- **[[NIST CSF]]** — Identify function (ID.AM) is asset management.
- **[[OWASP]]** — for web apps, asset discovery means enumerating subdomains, APIs, and shadow endpoints before any [[DAST]] or [[Fuzzing]] runs.

> **CompTIA exam trap:** CIS Control 1 vs. Control 2 — Control 1 is **enterprise assets** (hardware, devices), Control 2 is **software assets** (applications, libraries). CompTIA will pair the question with a stem like "tracking unauthorized installed applications" — that's Control 2, not Control 1.

> **CompTIA exam trap:** "Scan everything, every day" is the *wrong* answer. Scanning without asset context produces noise, breaks fragile systems, and burns scanner licenses. The right answer is risk-tiered, scope-aware scanning driven by an accurate inventory.

## SOC reality

- The first question the IR lead asks during an incident is "is this host in the CMDB?" If the answer is "I don't know, let me check three spreadsheets," the IR clock is already burning. Discovery feeds the muscle memory that makes triage fast.
- Shadow IT is found by diffing discovery output against the CMDB. Anything in discovery that isn't in CMDB is either a gap in inventory or unauthorized. Both are tickets.
- The 3am alert that matters: a new host with a new MAC address appears in a VLAN that's supposed to be static. Discovery delta alerting catches rogue devices, hypervisor sprawl, and attacker beachheads.
- The CISO's question after every breach disclosure in the news: "do we have any of *that* in our environment?" If discovery is healthy, you answer in 20 minutes. If it isn't, you answer in three days and the answer is "probably."
- The handoff: L1 confirms the unknown asset is real and not a scanner false positive. L2 attempts attribution — which team owns this, which change ticket spawned it. If neither L1 nor L2 can attribute within an hour, it escalates to threat hunt. Unowned production assets in 2026 are presumed hostile until proven otherwise.

*The Pokedex is empty when you start the game. So is your asset inventory on day one of a new SOC job. The difference between a trainer who beats the Elite Four and one who whites out at Brock is the same difference between a SOC that contains breaches in hours and one that finds out from the FBI six months later — and it starts with knowing exactly what's in your party.*

## Related concepts

[[Vulnerability Scanning]] · [[CMDB]] · [[Nmap]] · [[Shadow IT]] · [[PCI DSS]] · [[ICS]] · [[SCADA]] · [[Segmentation]] · [[CIS Controls]] · [[ISO/IEC 27001]] · [[NIST CSF]] · [[OWASP]] · [[Credentialed Scanning]] · [[Agent-Based Scanning]] · [[Attack Surface Management]] · [[Risk Management]]

*Source: VIRGIL knowledge base — 2026-05-11*