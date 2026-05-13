# Scan Configuration & Sensitivity

## What it is

In **Need for Speed: Most Wanted**, you can tune a car two ways before a race. There's the **Quick Tune** — push the slider toward "top speed" or "handling" and go. Then there's the **Custom Tune** where you actually crack the engine open: tire pressure, brake bias, downforce, gear ratios per cog, suspension stiffness. Same car, same track, completely different lap. Crank everything to maximum aggression for Rosewood and you'll lose the back end on the first wet corner and eat a wall. Tune it soft for a drag run and the AI walks away from you on the straight.

That's exactly what scan configuration is — same scanner, same target network, completely different result depending on how you tune the knobs.

**Plain English:** A vulnerability scanner has dozens of dials — how loud it is on the wire, whether it logs in, what plugins it runs, when it runs, what it's allowed to touch. Configure it wrong and you either miss real vulns or knock production over. Configure it right and you get usable findings without a ticket from the network team at 9:02am asking why printing is down.

**Technical:** Scan configuration is the set of parameters governing scope (what's scanned), depth (how thoroughly), method (credentialed/agent/passive/active), timing (when, how fast), and sensitivity (how aggressive the probes are). Sensitivity specifically controls timeout values, exploit attempt behavior, concurrent connections, and packet rate — the load the scan imposes on target systems.

## Why it matters

Scanning is the single most common way analysts cause self-inflicted outages. The scan engine doesn't care that the SCADA HMI was built in 2004 and crashes when you send it a malformed SNMP probe — it sends the probe anyway. Bad configuration is how you discover that the legacy ERP server fails over when nmap hits port 445.

Compliance lives here too. **PCI DSS** requires quarterly internal and external scans (external via an Approved Scanning Vendor). **HIPAA** expects regular vulnerability assessment. **ISO 27001** A.12.6.1 requires technical vulnerability management. Configure your scans wrong and the evidence the auditor asks for doesn't exist.

Exam relevance: **Objective 2.1** — credentialed vs. non-credentialed, active vs. passive, agent vs. agentless, internal vs. external, static vs. dynamic, sensitivity levels, scheduling, segmentation, regulatory requirements, OT/ICS/SCADA considerations. High-density objective.

## Key facts

### Sensitivity levels — the throttle

| Knob | Low sensitivity | High sensitivity |
|---|---|---|
| Timeouts | Long (patient) | Short (more retries) |
| Concurrent hosts | Few | Many |
| Plugins enabled | Safe checks only | Includes intrusive/DoS checks |
| Exploit attempts | Disabled | Enabled (will try the exploit) |
| Packet rate | Slow | Fast |
| Outage risk | Low | High |
| Detection rate | Misses edge cases | Better coverage |

The slider is a trade. **Production gets safe profiles. Lab gets the full beans.** *Every shop I've worked in learned this rule by breaking it once.*

> **CompTIA exam trap:** A "safe" scan is not the same as a "credentialed" scan. Safe = sensitivity profile (no intrusive checks). Credentialed = authentication method (logs in). You can run a credentialed scan with high sensitivity, or an unauthenticated scan with low sensitivity. The question will mix these to see if you conflate them.

### Credentialed vs. non-credentialed

- **Non-credentialed:** Pokes from outside. Sees what an external attacker sees pre-compromise. Misses anything that requires login — patch levels, local config, registry hardening.
- **Credentialed:** Logs in with a service account. Reads installed packages, registry, file versions, local users, sudoers. Far more accurate, far fewer false positives. **Default for internal scans.** If you're not credentialed, you're guessing from banner grabs.

Credentialed scans need a hardened, scoped service account. Don't give it Domain Admin. Don't reuse the password across sites. Vault it.

### Agent vs. agentless

- **Agentless:** Scanner reaches out across the network on a schedule. Works for always-on assets. Fails for laptops only on the VPN twice a week.
- **Agent-based:** Lightweight collector lives on the endpoint. Works for mobile assets, air-gapped subnets, DevOps fleets. The agent itself becomes attack surface.

Most mature shops run both. Agents for endpoints; agentless for network gear, hypervisors, and assets you can't install software on.

### Active vs. passive

- **Active:** Sends packets. Nmap, Nessus, Qualys, OpenVAS. Definitive, but loud and intrusive.
- **Passive:** Watches traffic. Nessus Network Monitor, Corelight, Zeek-based discovery. Never touches the asset. Excellent for fragile OT environments. Won't see what doesn't talk.

### Internal vs. external

- **External:** Scans your perimeter from the public internet. What attackers see before they get in. PCI DSS requires this quarterly from an ASV.
- **Internal:** Scans inside the firewall. What attackers see after they get in. Always more findings — and the findings that matter for lateral movement.

Run both. External-only is the classic mistake — your perimeter looks clean while the inside is a swamp.

### Static vs. dynamic (application scanning)

- **SAST (static):** Reads source code without running it. Catches insecure patterns, hardcoded secrets, dangerous functions. Early in SDLC. False positives are common.
- **DAST (dynamic):** Runs against the live app, fires HTTP requests, watches responses. Catches what actually happens at runtime — auth bypass, injection, broken access control. Maps to **OWASP** testing methodology.
- **IAST:** Hybrid. Instruments the running app, sees both code and behavior.
- **Fuzzing:** Throws malformed/random input at an interface to crash it. Finds memory corruption, input validation gaps, parser bugs.

### Asset discovery, map scans, fingerprinting

You can't scan what you don't know about.

- **Asset discovery:** ARP sweeps, ping sweeps, DHCP log ingestion, AD queries, NetFlow. The list of what's actually on your network — usually 15–30% larger than the inventory says.
- **Map scans:** Lightweight discovery (nmap `-sn`) to enumerate live hosts without port scanning. Fast, cheap, low-noise.
- **Device fingerprinting:** Identifying OS, version, and service from TCP/IP stack quirks, banner grabs, TLS fingerprints (JA3/JA4). Get this wrong and you waste time scanning a printer for Windows vulns.

### Scheduling

- **Production:** Off-hours. Throttled. Never during change-freeze or end-of-quarter close.
- **DMZ/external:** Continuous or daily — the perimeter changes fast.
- **OT/ICS:** Scheduled with operations explicitly, often during planned shutdowns only. *Never improvise this.*
- **DevOps pipelines:** Per-commit (SAST), per-build (SCA), per-deploy (DAST).

### Segmentation

If the network is flat, the scanner sees everything from one place — but so does the attacker. Segmented networks need either scanner appliances per segment or scanners trusted through the firewall on scan-specific ACLs. Document the scan paths — vantage point changes what's exploitable.

### Special considerations — OT, ICS, SCADA

This is the part you don't fuck around with.

- **OT:** Anything that runs the physical world — manufacturing lines, valves, turbines.
- **ICS:** The general category.
- **SCADA:** The HMI/PLC stack that watches and controls.

These systems were built when "TCP/IP security" meant air-gapping. They crash on malformed packets. They use unencrypted protocols (Modbus, DNP3) the scanner doesn't speak natively. They run on 10-year-old Windows you can't patch because the vendor will void support.

**Rules:**
- Passive by default. Active only with operations sign-off, during planned downtime.
- Never run exploit-enabled plugins. Ever.
- Coordinate with safety/engineering, not just IT.
- Standards: **NIST SP 800-82**, **IEC 62443**.

> **CompTIA exam trap:** If the scenario mentions ICS, SCADA, OT, plant floor, manufacturing, utility, or "patient monitor," the answer is almost certainly **passive scanning** or **agent-based on the engineering workstation, not the PLC**. Active credentialed scans against a PLC is a wrong-answer trap.

### Regulatory drivers and frameworks

| Driver | Scan requirement |
|---|---|
| **PCI DSS** | Quarterly internal + external (ASV); rescans after significant change |
| **HIPAA** | Regular vulnerability assessment ("reasonable" frequency) |
| **ISO 27001** A.12.6.1 | Technical vulnerability management process |
| **CIS Controls** v8 | Control 7 — Continuous Vulnerability Management |
| **CIS Benchmarks** | Configuration baseline scans (config compliance, not CVEs) |
| **NIST SP 800-53** | RA-5 control |
| **SOX** | Indirect — IT general controls over financial systems |

**CIS Benchmarks** are hardening guides (e.g., "CIS Microsoft Windows Server 2022 Benchmark"). You scan against them for configuration compliance, separate from CVE-based vuln scanning. Two different scans, two different reports, both needed.

> **CompTIA exam trap:** "Security baseline scanning" tests configuration drift against a known-good baseline (CIS Benchmark, DISA STIG). It is **not** the same as vulnerability scanning. Vuln scan = "do you have CVE-2024-X?" Baseline scan = "is the SMB signing GPO set correctly?"

### Performance and operations

Scans hit CPU on the target (credentialed especially), bandwidth on the path, and logs in your SIEM (every scan looks like an attack). Throttle the scanner, schedule windows, notify the SIEM team before a new scan source goes live — or spend the afternoon explaining why your own appliance generated 40,000 IDS alerts.

## SOC reality

- **The 9:02am ticket** — "Is something attacking us, the printer queue is down" — half the time it's your own scan hitting an HP JetDirect with an SNMP probe it can't handle. Confirm scanner source IP before you spin up IR.
- **L1 first move on a vuln-scan-related alert:** check the source IP against the known scanner inventory. Known scanner = suppress and log. Unknown = treat as recon.
- **What the CISO asks after an outage:** "Was the scan authorized, was the profile production-safe, did we have a change ticket, who approved." Have those four answers ready before you walk in.
- **Never promise leadership "we scanned everything"** — you scanned what the scanner could reach with the credentials it had during the window it ran. *The asset you didn't scan is the one that gets popped.*
- **Handoff:** L1 owns scan operations and triage. L2/vuln-mgmt owns scan policy, credential rotation, remediation tracking. IR owns scanner output when it correlates to an active incident.

## Related concepts

[[Vulnerability Scanning Tools]] · [[CVSS]] · [[Credentialed Scans]] · [[Asset Inventory]] · [[CIS Benchmarks]] · [[PCI DSS]] · [[SCADA Security]] · [[OWASP Testing Guide]] · [[SAST vs DAST]] · [[Fuzzing]] · [[Network Segmentation]] · [[Nmap]] · [[SIEM Tuning]] · [[Change Management]]

*Source: VIRGIL knowledge base — 2026-05-11*