# Why Organizations Scan (Drivers)

## What it is

In **Half-Life**, before the resonance cascade, Black Mesa runs its safety protocols on paper. Gordon walks through the test chamber, the techs check the readouts, the announcer reminds everyone about the safety wash stations. Nobody actually *looks* at the anti-mass spectrometer's calibration. The sample is impure, the systems are red-lined, and no one is doing the boring inspection that would catch it. Then the crystal goes into the beam and Black Mesa eats an inter-dimensional invasion. The retrospective writes itself: the warning signs were there, the instruments were there, nobody was running the scan.

That's exactly what vulnerability scanning drivers are — the institutional forcing functions that make sure somebody actually runs the spectrometer check before the crystal goes in.

**Technical definition (CS0-003):** Vulnerability scanning drivers are the external mandates and internal business requirements that compel an organization to discover, enumerate, and assess weaknesses across its asset inventory on a defined cadence. Drivers determine **scope** (what gets scanned), **frequency** (how often), **depth** (credentialed vs. non-credentialed), and **evidence retention** (what auditors will demand to see). No driver, no program. No program, no Black Mesa incident report — just an actual Black Mesa incident.

## Why it matters

CySA+ Objective 2.1 expects you to know not just *how* to scan but *why* — because the why determines every other decision. PCI DSS dictates quarterly external scans by an [[Approved Scanning Vendor]]; HIPAA expects risk-based assessments; FISMA wants categorization first; the board wants a single number on a slide. Each driver pulls scope and frequency in a different direction, and the analyst who can't articulate the driver behind a scan can't defend the scan when it breaks production.

Career-wise: the L1 analyst runs the scans. The L2 tunes them. The vulnerability management lead **defends them to the business**, which means knowing exactly which regulation, contract, or internal policy forces the scan to exist. When the change board says "we don't want you scanning the cardholder segment this Tuesday," you need to be able to say "PCI DSS Requirement 11.3.1 says we scan quarterly and after any significant change, and we're past due." That's the job.

## Key facts

### External drivers — the regulators don't care if you break things

| Driver | Who it covers | What it forces |
|---|---|---|
| **PCI DSS** | Anyone who stores, processes, or transmits cardholder data | Quarterly internal + external scans; external scans by an ASV; rescans after significant change; clean scan required |
| **HIPAA Security Rule** | Covered entities and business associates handling PHI | Risk analysis (45 CFR 164.308); no fixed cadence, but "regular" is the expectation |
| **FISMA / FedRAMP** | Federal agencies and their cloud providers | Continuous monitoring under [[NIST SP 800-137]]; categorization per [[FIPS 199]] (low/moderate/high) drives scan depth |
| **GLBA** | Financial institutions | Safeguards Rule mandates regular vulnerability assessments |
| **SOX** | Public companies (financial controls) | IT general controls audits — scans become evidence for ITGC |
| **GDPR / state privacy laws** | Anyone touching EU resident data (or CA, etc.) | "Appropriate technical measures" — scanning is implicit |
| **CIRCIA** | US critical infrastructure | Drives incident reporting timelines, which in turn drives the scanning program that catches incidents early |

> **CompTIA exam trap:** PCI DSS external scans must be performed by an **Approved Scanning Vendor (ASV)** — you cannot run the external scan yourself and call it compliant. Internal scans you run. External scans the ASV runs. CompTIA loves this distinction.

### Industry frameworks — voluntary but treated as mandatory

- **[[ISO 27001]] / 27002** — vulnerability management is control A.12.6.1 in the older numbering. ISO-certified shops scan because the auditor will ask.
- **[[NIST CSF]]** — Identify and Protect functions both expect vulnerability discovery. Detect expects continuous monitoring.
- **[[CIS Controls]] v8** — Control 7 (Continuous Vulnerability Management) is explicit. CIS also publishes the **CIS Benchmarks**, which are configuration baselines that scanners use to check hardening compliance. ([[Security baseline scanning]] is checking your hosts against CIS or DISA STIG baselines — different from CVE scanning, often conflated.)
- **[[OWASP]]** — drives the *web application* side. OWASP Top 10 and ASVS define what a web app scan should cover; this is where [[DAST]], [[SAST]], and [[fuzzing]] live.

### Internal drivers — the part nobody audits but everybody needs

- **Corporate risk appetite** — the board signs off on how much residual risk is acceptable. Scanning produces the number that gets compared to the appetite.
- **Security policy** — your own policy says "scan monthly." If you don't, you're out of compliance with yourself, and that's the first finding in any third-party assessment.
- **Business continuity / DR** — scans of the DR site are the only way to know your failover environment isn't six months behind on patches.
- **Mergers and acquisitions** — due diligence scans before signing. You inherit the target company's tech debt; you want to price it in.
- **Insurance** — cyber insurance carriers now require attestation of a vulnerability management program. No program, no policy, no payout.
- **Executive risk visibility** — the CISO needs the slide. The slide needs the number. The number needs the scan.

### Special considerations — where drivers meet reality

Not every asset behaves like a Windows file server. Drivers exist, but how you satisfy them depends on what you're pointing the scanner at.

**[[Operational technology]] (OT) / [[ICS]] / [[SCADA]]** — the PLC running a turbine doesn't have a TCP/IP stack that tolerates an Nmap SYN scan. Aggressive scanning has caused outages at water utilities and refineries. The driver (NERC CIP for the power grid, TSA pipeline directives, etc.) still applies, but the **method** shifts to [[passive scanning]] — listening to traffic rather than probing. *I learned this the hard way watching a vendor's "safe" credentialed scan brick a HMI workstation that hadn't been rebooted in four years.*

**Critical infrastructure** — sector-specific regulators (NERC, FERC, TSA, EPA) layer their own requirements on top of generic frameworks. The driver isn't just "scan" — it's "scan without taking down the grid."

**Cardholder data environments** — PCI DSS expects you to **segment** the CDE from the rest of the network and prove the segmentation works. Segmentation testing is its own scan type and its own driver. If your scope creeps, your audit cost explodes.

**Cloud workloads** — your cloud provider's acceptable-use policy is a driver. AWS used to require pre-authorization for pen tests; that's relaxed now, but heavy scanning across a cloud tenant can still get you rate-limited or flagged.

### How drivers shape scan design

| Decision | Driven by |
|---|---|
| **Frequency / [[scheduling]]** | Regulation (PCI quarterly), policy (monthly), or event-driven (after change) |
| **[[Internal vs. external scanning]]** | PCI requires both; FISMA emphasizes continuous internal |
| **[[Credentialed vs. non-credentialed]]** | Depth vs. realism — credentialed scans see what an attacker with creds would see; non-credentialed sees what the unauthenticated attacker sees from outside |
| **[[Agent vs. agentless]]** | Coverage of roaming endpoints, OT constraints, cloud workloads |
| **[[Active vs. passive scanning]]** | OT environments push you passive; everywhere else, active is default |
| **[[Static vs. dynamic]] code analysis** | OWASP/secure SDLC drivers — SAST during build, DAST against running app, fuzzing for inputs |
| **Sensitivity / performance throttling** | Business hours, change windows, asset fragility |
| **[[Asset discovery]] / map scans / [[device fingerprinting]]** | You can't scan what you don't know exists — discovery is the prerequisite driver |

### CompTIA exam traps

> **Trap 1:** PCI DSS says **quarterly** scans AND **after any significant change**. CompTIA will give you a scenario with a major firewall change and ask if you wait until next quarter. You don't.

> **Trap 2:** FISMA does not prescribe a scan frequency. It prescribes **continuous monitoring** tied to the system's FIPS 199 categorization. A "high" system gets monitored more aggressively than a "low" one. CompTIA may try to bait you with "FISMA requires monthly scans" — no, it requires a program proportional to risk.

> **Trap 3:** [[CIS benchmarks]] are **configuration baselines**, not CVE feeds. Scanning against CIS tells you if your hosts are hardened. Scanning against the [[NVD]] tells you if they're patched. Different question, different scan, same scanner — different policy file.

> **Trap 4:** Regulatory scans don't care about your change window. CompTIA loves the scenario where the analyst is told "don't scan, it'll break the app." The answer on the exam is almost always *get authorization to scan anyway, with compensating controls*, because the regulatory obligation outweighs the operational preference. In real life it's more political, but on the exam the regulator wins.

## SOC reality

- At 3am the scan finishes and Tenable / Qualys / Rapid7 dumps 4,000 findings into the queue. The L1's job isn't to fix them — it's to confirm the scan **ran in scope, completed without errors, and got authenticated against the targets it was supposed to**. Half the panic findings are because the credentialed scan fell back to unauthenticated and reported every host as "missing all patches."
- When the CISO walks over, the question is never "how many vulns?" It's *"are we PCI-clean for the quarterly attestation?"* Know the answer before they ask.
- Never tell leadership "we scanned everything." You scanned what was in the asset inventory. The asset inventory is wrong. *The first scan of any new environment finds 20% more hosts than the CMDB knew about — that gap is the actual risk.*
- The escalation path on a scan-induced outage is immediate: L1 stops the scan, L2 calls the asset owner, IR lead notifies the change manager, and somebody writes the incident report explaining why the scan window wasn't honored. Document the driver that authorized the scan. That's your shield.
- Compliance scans and security scans are not the same scan. A PCI ASV scan is a snapshot for the auditor. Your real continuous scanning program runs alongside it. *Don't let the compliance scan become the only scan — that's how Black Mesa runs the safety check on paper and forgets to look at the spectrometer.*

## Related concepts

[[Credentialed vs Non-credentialed Scanning]] · [[Active vs Passive Scanning]] · [[Agent vs Agentless Scanning]] · [[Internal vs External Scanning]] · [[Asset Discovery]] · [[Device Fingerprinting]] · [[CVSS]] · [[CVE]] · [[NVD]] · [[PCI DSS]] · [[HIPAA]] · [[FISMA]] · [[ISO 27001]] · [[NIST CSF]] · [[CIS Controls]] · [[CIS Benchmarks]] · [[OWASP Top 10]] · [[SAST]] · [[DAST]] · [[Fuzzing]] · [[Operational Technology]] · [[ICS]] · [[SCADA]] · [[Security Baseline Scanning]] · [[Segmentation Testing]] · [[Scan Scheduling]] · [[Approved Scanning Vendor]]

*Source: VIRGIL knowledge base — 2026-05-11*