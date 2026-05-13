# Scan Types

## What it is

In **Bioshock**, when you point the Research Camera at a Splicer, you don't just shoot it — you study it. Each photograph builds a dossier: weaknesses, damage modifiers, behavioral patterns. A Thuggish Splicer photographed enough times reveals exactly where to hit it with the wrench, what plasmid melts it fastest, what it's resistant to. But you have to stand there long enough to take the shot, and standing still in Rapture gets you killed. The camera trades exposure time for intelligence depth.

That's exactly what vulnerability scan types do — every scan is a tradeoff between how deep you see and how much noise (or risk) you make taking the picture.

A **vulnerability scan** is an automated probe against a host, network, or application that compares observed state against a database of known weaknesses (CVEs, misconfigurations, missing patches, weak crypto). The "type" of scan is the *posture* you take while probing: how much access you have, whether you announce yourself, what you're allowed to touch, and when you're allowed to touch it. CySA+ Objective 2.1 wants you to pick the right posture for the target, the regulatory context, and the operational tolerance of the business.

## Why it matters

The wrong scan type produces one of two failures, both career-staining. Scan too shallow, and you certify a host "clean" while it has fifteen unpatched local privilege escalations sitting in user space — the auditor finds them six months later. Scan too aggressive, and you knock the SCADA controller offline, the plant stops, and the COO learns your name in a way you do not want.

CompTIA tests this on Objective 2.1 specifically: given a scenario (PCI DSS environment, OT segment, external attack surface, agent-deployed fleet), pick the scan posture that matches.

## Key facts

### Credentialed vs. non-credentialed

| Dimension | **Credentialed** | **Non-credentialed** |
|---|---|---|
| Access | Authenticated (SSH, WinRM, SMB, API token) | No auth — anonymous probe |
| Depth | Deep — registry, installed patches, local users, config files | Shallow — open ports, banners, exposed services |
| False positives | Low | High (banner-grabbing lies) |
| Perspective | Insider / trusted | External attacker, pre-auth |
| Risk to host | Lower (controlled queries) | Higher (probe-driven crashes) |
| Use case | Patch compliance, [[CIS Benchmarks]] audit, hardening checks | Attack surface mapping, perimeter validation |

> **CompTIA exam trap:** When the question asks "which scan provides the most accurate/deepest insight?" the answer is **credentialed**. When it asks "which scan simulates an external attacker?" the answer is **non-credentialed**. Both are correct in their own context. Read the scenario.

### Agent vs. agentless

- **Agent-based** — a lightweight binary lives on the endpoint, scans locally, reports back. Survives the host being off-network (laptops, road warriors). No credential management overhead. Catches transient state. Cost: agent footprint, version drift, deployment friction.
- **Agentless** — scanner reaches across the network using creds. No software to install. Cost: needs network reachability, needs cred vault, misses anything offline at scan time.

Modern reality: hybrid. Agents on workstations and cloud workloads, agentless sweeps for the network gear and the printers nobody can install software on.

### Active vs. passive

- **Active** — the scanner sends packets. SYN scans, version probes, exploit checks. Loud, fast, accurate. Will be logged by every IDS in the path.
- **Passive** — the scanner listens to traffic mirrored from a SPAN port or TAP. Builds an asset inventory and finds vulns without touching the targets. Won't trip IDS. Won't crash an ICS PLC.

*Passive scanning is the only safe option on production OT/ICS networks. Active scanning a SCADA HMI is how you make CNN.*

### Internal vs. external

- **Internal** — scanner sits inside the trust boundary. Sees what an insider or post-breach attacker sees. Required by [[PCI DSS]] quarterly for the CDE.
- **External** — scanner sits on the public internet, scans your perimeter. Sees what the attacker sees pre-foothold. [[PCI DSS]] requires this quarterly via an **ASV** (Approved Scanning Vendor) — and on any significant change.

### Static vs. dynamic (application scanning)

This is the application security pair, not network scanning. CompTIA bundles it under scan types because the same logic applies.

- **SAST — Static Application Security Testing** — scan source code or compiled binary without running it. Finds insecure functions, hardcoded creds, taint paths. Runs early in CI/CD. White-box.
- **DAST — Dynamic Application Security Testing** — scan the running application by sending HTTP requests. Finds [[XSS]], [[SQL Injection]], auth bypass, [[SSRF]]. Black-box. Maps to [[OWASP Top 10]] testing.
- **IAST** — instrumentation inside the running app. Hybrid.
- **Fuzzing** — feed malformed, random, or boundary-case input and watch for crashes, memory corruption, unhandled exceptions. Finds the unknown-unknowns SAST and DAST miss. Mandatory for any C/C++ codebase that parses untrusted input.

### Map scans and asset discovery

You can't protect what you can't see. **Asset discovery** is the prerequisite for every other scan.

- **Map scan / discovery scan** — `nmap -sn` style sweep. Pings the subnet, lists what's alive. No vuln checks.
- **Device fingerprinting** — OS detection (`nmap -O`), service version detection (`-sV`), TLS fingerprinting (JA3/JA4). Tells you *what* the box is so the vuln database knows which CVEs to check.
- **Reverse engineering** of unknown firmware or proprietary protocols sometimes feeds the fingerprint database for OT gear where vendors don't publish specs.

*If asset discovery is broken, your vulnerability program is fiction. The unmanaged Raspberry Pi under someone's desk is the breach.*

### Special considerations

This is the CySA+ checklist CompTIA loves to drill on.

| Consideration | What it means |
|---|---|
| **Scheduling** | When the scan runs. Don't credentialed-scan the ERP during month-end close. |
| **Performance** | Throttle packet rate, parallel host count. A scanner running flat-out can saturate a WAN link. |
| **Sensitivity levels** | How aggressive the checks are. Safe checks only? Or include checks that might crash the target? |
| **Segmentation** | Scanner must reach the target. Firewalls, [[VLAN]]s, and NAT all break scans silently — partial results look like clean results. |
| **Regulatory requirements** | [[PCI DSS]] (quarterly internal+external, ASV for external), [[HIPAA]] (risk analysis cadence), [[ISO 27001]] (continuous improvement), [[SOX]] (financial systems). |

### Operational technology — the no-go zone

**OT, ICS, SCADA** environments — power plants, water treatment, manufacturing floors, hospital HVAC, building management. The rules invert.

- An active scan packet that a server shrugs off can crash a 1990s PLC.
- Availability dominates CIA. A 30-second outage in IT is a ticket; in OT it's a regulatory incident.
- **Use passive scanning.** Tools like Claroty, Nozomi, Dragos tap the network and reconstruct asset inventory and vuln state without sending a single packet to the controller.
- Schedule any active touch during planned maintenance windows only, with engineering sign-off in writing.

> **CompTIA exam trap:** On any scenario mentioning **SCADA, ICS, PLC, OT, critical infrastructure, or "manufacturing floor"** — the answer is **passive scanning** or **scan during scheduled maintenance window**. Never "credentialed active scan." Even if credentialed active scan is technically deeper, it's operationally suicidal.

### Industry frameworks and baselines

- **[[CIS Benchmarks]]** — prescriptive hardening configs per OS, per app. Scanners compare current state to benchmark and report drift. This is **security baseline scanning**.
- **[[OWASP]]** — web app testing methodology. ZAP and Burp map to OWASP Top 10.
- **[[ISO 27001]] / 27002** — controls framework. Scanning is one input to the Annex A controls.
- **[[NIST]] SP 800-53 / 800-115** — federal baseline; 800-115 specifically covers technical security testing including scan methodology.
- **[[PCI DSS]]** — quarterly internal + external scans, external by ASV, rescan after significant change, all highs (CVSS ≥ 7) must be remediated and rescanned clean.

### CompTIA exam traps

> **CompTIA exam trap — "deepest insight":** Credentialed beats non-credentialed every time on depth. Don't overthink it. The trap is when they describe an *external attack surface assessment* and you reflex-answer "credentialed" — read whether the scenario is depth or perspective.

> **CompTIA exam trap — PCI DSS scan cadence:** Quarterly internal AND external. External must be by an ASV. After any significant change. Rescan until clean. CompTIA will offer "annual" as bait. Annual is wrong.

> **CompTIA exam trap — agent vs. agentless tradeoff:** Agents win when endpoints leave the network. Agentless wins when you can't deploy software (network gear, IoT, printers, OT). The question usually telegraphs which one — look for "remote workforce," "laptops," "off-network" → agent; "cannot install software," "printers," "network appliances" → agentless.

> **CompTIA exam trap — static vs. dynamic:** SAST = source code, no execution, early in SDLC. DAST = running app, black-box, late in SDLC. Fuzzing is its own thing — input mutation, finds crash bugs. Don't conflate them.

## SOC reality

- The 3am page from the scanner isn't "vuln found" — it's "scan failed to complete on 4,200 hosts." Someone's segmentation changed, or a cred rotated, or the scanner's license expired. That's the ticket you actually work.
- L1 question on every new CVE that drops in the news: "are we exposed, and what's the patch SLA?" You answer it by querying the last credentialed scan results, not by launching a new scan. The scan data is the inventory; the response is the lookup.
- The CISO asks one question after every incident involving an unpatched host: **"why didn't the scanner catch it?"** Real answers, in order of frequency: the host wasn't in scope, the scan ran non-credentialed, the cred had expired silently, the host was off-network during the scan window, the agent had stopped checking in 90 days ago. Know which one before you walk into the room.
- Never tell leadership "we scanned it and it's clean." Tell them "the last credentialed scan on [date] showed no findings above [threshold]." Scan results are point-in-time. Treating them as continuous truth is how you get blindsided.
- The fight with the change board is not technical. It's "we need a maintenance window to scan the OT segment passively for the first time ever." Bring the engineering lead. Bring the passive-only tooling. Bring the regulatory citation. Don't bring nmap.

## Related concepts

[[Vulnerability Management Lifecycle]] · [[CVSS]] · [[CIS Benchmarks]] · [[PCI DSS]] · [[OWASP Top 10]] · [[SAST]] · [[DAST]] · [[Fuzzing]] · [[Asset Discovery]] · [[Device Fingerprinting]] · [[OT and ICS Security]] · [[SCADA]] · [[Network Segmentation]] · [[Patch Management]] · [[ASV — Approved Scanning Vendor]] · [[NIST SP 800-115]]

*Source: VIRGIL knowledge base — 2026-05-11*