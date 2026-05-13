# Selecting Scan Targets

## What it is

In **Rainbow Six Siege**, the defender's first 45 seconds are not about shooting anybody. You walk the site as a drone, you map every soft wall, every hatch, every line of sight from the windows on the second floor down into the bomb room. You don't reinforce *every* wall — you reinforce the ones that matter, in the order they matter, because Mute only has four jammers and Castle only has three barricades. Pick wrong and the breach team comes through the wall you didn't think to harden.

That's exactly what selecting scan targets does — you don't scan everything the same way at the same time with the same depth, because you don't have infinite scanner licenses, infinite maintenance windows, or infinite analyst hours to triage the output.

**Technical definition:** Scan target selection is the process of deciding *which* assets get scanned, *how often*, *how deep*, *from where*, and *with what credentials*, based on data sensitivity, exposure, business criticality, regulatory scope, and the operational risk of scanning itself. CS0-003 Objective 2.1 expects you to know the trade-offs across credentialed vs. non-credentialed, internal vs. external, agent vs. agentless, active vs. passive, and the special considerations for [[OT]]/[[ICS]]/[[SCADA]] environments where a scan can literally take down a plant.

## Why it matters

A vulnerability scanner is a force multiplier and a liability in the same box. Point it at production unannounced and you'll be writing the post-mortem about the SCADA controller that bricked itself responding to an SMB enumeration sweep. Point it only at the easy stuff and you'll miss the [[Tier 0]] domain controller with the unpatched Print Spooler.

The exam tests this in scenario form: "given a payroll system holding PII and exposed to the internet, which scan profile?" The real job tests it in budget meetings — you have 5,000 endpoints, two scanner appliances, and a CISO who wants weekly coverage. Something has to give. Target selection is where you decide what.

## Key facts

### The five inputs to target selection

| Input | What you're asking |
|---|---|
| **Data sensitivity** | What's on the box? PII, PHI, PCI, IP, classified? |
| **Exposure** | Internet-facing, DMZ, internal, air-gapped? |
| **Business criticality** | If this dies at 9am, who's on the call? |
| **Environment** | Production, staging, dev, test, lab? |
| **Regulatory scope** | Is it in PCI-DSS, HIPAA, SOX, GDPR scope? |

Stack-rank the asset on each axis, then pick a scan profile. Public-facing payroll system with PII gets weekly authenticated scans with conservative plugins, external attack-surface scans daily, and lives in the [[PCI DSS]] quarterly ASV scan scope if it touches card data. A dev box running someone's React tutorial gets a monthly unauthenticated sweep and nobody loses sleep.

### Credentialed vs. non-credentialed

**Credentialed (authenticated)** — scanner logs in with a service account, reads the registry, queries installed packages, sees actual patch levels. Depth is high, false-positive rate is low. This is what you want for compliance scans and for any internal asset you actually own.

**Non-credentialed (unauthenticated)** — scanner pokes the asset from outside, fingerprints services, infers versions from banners. Depth is shallow, false positives are higher, but it shows you what an attacker *without* credentials sees. This is your external attack-surface view.

> **CompTIA exam trap:** "Which scan finds the most vulnerabilities?" — credentialed, every time. "Which scan most accurately reflects what an external attacker sees?" — non-credentialed from outside the perimeter. Same word ("scan"), different question, different answer. Read the stem.

### Internal vs. external scanning

**External scans** run from outside your network — the public internet, an ASV's cloud, a cloud-hosted scanner. They see what the adversary sees. PCI-DSS requires quarterly external scans by an Approved Scanning Vendor (ASV) and after any significant change.

**Internal scans** run from inside the perimeter — different scanner, different network position, different findings. Internal scans catch the lateral-movement paths external scans never see: the open SMB share, the legacy SQL Server with sa/sa, the printer running Windows Embedded from 2009.

Run both. They answer different questions.

### Agent vs. agentless

**Agent-based** — a small client lives on the endpoint, reports posture continuously, works when the laptop is on a coffee-shop wifi in Lisbon. Great for roaming endpoints, mobile workforces, cloud workloads that scale up and down. Cost: another piece of software to deploy, patch, and troubleshoot.

**Agentless** — scanner reaches out over the network on a schedule. No endpoint footprint, but if the asset is off-network during the scan window, it's invisible. Good for servers, network gear, ICS where you legally cannot install third-party software.

### Active vs. passive

**Active scanning** sends traffic — probes ports, attempts logins, sends crafted packets. It generates load, it generates alerts, and in fragile environments it generates outages.

**Passive scanning** watches existing traffic — span port, network tap, NetFlow ingest. It can't find what doesn't talk, but it can't break what it doesn't touch. This is how you "scan" OT networks where active probing is forbidden.

### Static vs. dynamic (application context)

For application scanning specifically:

- **SAST (static)** — analyzes source code without running it. Finds insecure patterns, dangerous functions, hardcoded secrets. Runs in CI/CD, catches issues pre-production.
- **DAST (dynamic)** — fuzzes the running application, sends real HTTP requests, watches responses. Finds runtime issues SAST can't see — auth flaws, session handling, server misconfigurations. See [[OWASP]] Top 10 for what DAST targets.
- **Fuzzing** — feeds malformed, random, or boundary-case input to find crashes and parser bugs. Used in DAST and in [[reverse engineering]] workflows where you have a binary and no source.

### Special considerations — the assets that bite back

Some targets will hurt you if you scan them wrong:

| Asset class | The problem | The approach |
|---|---|---|
| **[[SCADA]] / [[ICS]] / [[OT]]** | Decade-old PLCs crash on unexpected packets. Active scans can halt a production line. | Passive only, or active during scheduled maintenance windows. Coordinate with plant ops. |
| **Critical infrastructure** | Same problem, higher stakes — power, water, hospitals. | Passive, segmented, regulatory-aware. NERC-CIP, IEC 62443 govern this. |
| **Medical devices** | FDA-regulated firmware. Patching is the vendor's job, not yours. | Inventory and segment. Don't fuzz an MRI. |
| **Embedded / IoT** | Tiny CPUs, fragile stacks. | Light-touch fingerprinting, network-side controls. |
| **Production DBs at peak** | Authenticated scans pulling registry/package data hit CPU. | Schedule for low-traffic windows. |

### Asset discovery and device fingerprinting

You cannot scan what you don't know exists. **Asset discovery** is the prerequisite — ARP sweeps, ping sweeps, DHCP log ingestion, AD queries, cloud API enumeration, NetFlow analysis. Output: an inventory.

**Map scans** (nmap `-sn` host discovery, or `-sV` for service/version) are the lightweight first pass — what's alive, what ports are open, what banners come back. **Device fingerprinting** goes deeper — OS detection (`nmap -O`), TCP/IP stack quirks, TLS fingerprints (JA3/JA4), HTTP headers. The output drives target selection: you can't pick the right scan profile for a host you've labeled "unknown."

Rogue and shadow assets are where breaches start. The dev who spun up an EC2 instance with their personal credit card. The forgotten staging server with prod data. Asset discovery finds these. Scanning them is the next step.

### Scheduling, performance, and sensitivity levels

**Scheduling** — production: off-hours. Dev: anytime. PCI scope: at least quarterly externally, monthly internally for most programs. Compliance scans hit on the regulator's calendar, not yours.

**Performance** — bandwidth caps on the scanner, max concurrent hosts, plugin selection. A full Nessus "all plugins" scan against 500 hosts will saturate a 1Gb uplink and page the network team.

**Sensitivity levels** — most scanners let you dial plugin aggressiveness. "Safe checks only" skips the plugins known to crash targets. For OT and legacy assets, always safe-checks. For internet-exposed assets in dev, gloves off.

### Frameworks and regulatory drivers

| Framework / standard | What it tells you about scanning |
|---|---|
| **[[PCI DSS]]** | Quarterly external ASV scans + internal scans; rescan after significant change. |
| **[[CIS Benchmarks]]** | Configuration baseline — what a hardened host looks like. Drives configuration/compliance scans. |
| **[[ISO 27001]] / 27002** | Requires vulnerability management process; doesn't dictate frequency. |
| **HIPAA Security Rule** | Risk-based; doesn't prescribe scan frequency but expects you to have one. |
| **NIST SP 800-53 (RA-5)** | Vulnerability scanning control — drives federal scan cadence. |
| **NERC-CIP** | Bulk electric system; very prescriptive about what you can and can't touch. |

**Security baseline scanning** is a related discipline — you're not asking "what CVEs are present" but "does this host match the [[CIS Benchmarks]] hardened configuration." Same scanner, different policy.

### Segmentation as a scanning concern

If the network is properly **segmented**, your scanner needs reach into every segment — or a scanner per segment. The cardholder-data environment ([[CDE]]) gets its own scanner inside the segment, because letting an external scanner into the CDE creates a new attack path and a PCI scope expansion. Same logic for OT — the IT scanner does not get to vacation in the OT VLAN.

> **CompTIA exam trap:** If you put one scanner outside all your segments and expect it to "just scan everything," you'll get incomplete results AND you'll have to poke firewall holes that defeat the segmentation. The answer is multiple scanners, scoped to segment.

## SOC reality

- The vulnerability management lead does not pick targets in a vacuum — they argue with the application owners, the DBAs, and the OT engineers. "Can I scan your PLC?" gets a "no, and if you do it anyway I'll have your badge." Target selection is a political process with a technical output.
- The 3am page is rarely "the scanner found something." It's "the scanner *broke* something." Knowing which assets are scan-fragile is how you don't become the analyst who took down the hospital's pharmacy system trying to confirm a CVE.
- The CISO asks: "What's our scan coverage?" The honest answer is a percentage, not a yes. *80% of known assets scanned monthly with credentials* is a real metric. "We scan everything" is a lie nobody senior believes.
- Never promise leadership the scan results are complete. Credentialed scans miss assets where the service account expired. Agent-based scans miss assets where the agent died. Passive scans miss assets that don't talk. *Coverage gaps are the rule, not the exception — name them in your report.*
- Handoff: scan findings flow from the VM team into ticketing, then to the asset owner, then back through verification. L1 analysts triage scan-derived alerts; L2 validates exploitability; the asset owner remediates; the VM team rescans to confirm. The loop only closes when the rescan is clean.

## Related concepts

[[Vulnerability Scanning]] · [[CVSS]] · [[Asset Inventory]] · [[CIS Benchmarks]] · [[PCI DSS]] · [[OT]] · [[ICS]] · [[SCADA]] · [[OWASP]] · [[SAST]] · [[DAST]] · [[Fuzzing]] · [[Credentialed Scanning]] · [[Agent-Based Scanning]] · [[Passive Scanning]] · [[Network Segmentation]] · [[Attack Surface Management]] · [[Compliance Scanning]]

*Source: VIRGIL knowledge base — 2026-05-11*