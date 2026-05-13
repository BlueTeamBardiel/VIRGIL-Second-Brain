# PCI DSS — Payment Card Industry Data Security Standard

## What it is

In **Counter-Strike**, the bombsite is not the whole map. The Ts only win by planting on A or B, and the CT economy, utility, and rotations all orbit those two squares of concrete. Everything outside the sites still matters — mid control, spawn picks, info plays — but the *win condition* lives in a tightly defined zone. Smart CT teams stack utility on the chokes into site, not on catwalk graffiti.

That's PCI DSS. The **cardholder data environment (CDE)** is the bombsite. Everything that stores, processes, or transmits **primary account numbers (PAN)** lives inside it, and the standard pours controls into that zone first. The rest of the corporate network matters, but the auditors are checking who can rotate into A site.

**Plain English:** PCI DSS is the contractual rulebook merchants and processors must follow to accept Visa, Mastercard, Amex, Discover, JCB. It's not a law — it's a contract enforced by the card brands and acquiring banks. Break it, get fined, lose your ability to take cards.

**Technical:** PCI DSS is a **prescriptive control framework** maintained by the **PCI Security Standards Council**. Current version is **PCI DSS v4.0** (mandatory March 2025, with some requirements deferred to **v4.0.1** in 2024). It defines **12 core requirements** across six control objectives, applied to any system component in the CDE — the systems that store, process, or transmit cardholder data, plus anything connected to them that isn't properly [[network segmentation|segmented]] away.

## Why it matters

PCI DSS is the most common regulatory driver on a CySA+ exam scenario. When the question says *"the organization processes credit card transactions"*, your scan scope, scan frequency, and reporting obligations are about to be dictated by PCI. It's the one [[industry framework]] every analyst in retail, hospitality, healthcare, SaaS, or e-commerce will hit.

It also shows up in the real career path. Your first vuln management job at a mid-size retailer means you're running [[Nessus]] or [[Qualys]] against the CDE quarterly, generating ASV reports, and arguing with the change board about a Windows 2012 POS controller that "can't be patched until Q4." PCI is where vulnerability management stops being theoretical.

**Exam relevance:** CS0-003 Objective 2.1 lists PCI DSS explicitly under regulatory requirements driving scan methodology. Expect questions on scan frequency, ASV scans, scoping, and segmentation testing.

## Key facts

### The 12 requirements (know the shape, not the verbatim text)

PCI DSS v4.0 keeps the 12-requirement structure. Group them mentally:

| Objective | Requirements | What it covers |
|---|---|---|
| Build & maintain secure network | 1, 2 | Firewalls, default passwords |
| Protect cardholder data | 3, 4 | Storage encryption, transmission encryption |
| Vulnerability management | 5, 6 | Anti-malware, secure development, **patching** |
| Strong access control | 7, 8, 9 | Least privilege, unique IDs/MFA, physical access |
| Monitor & test networks | 10, 11 | **Logging, vuln scans, pen tests** |
| Information security policy | 12 | Governance, risk assessment, incident response |

For CySA+, **Requirements 6, 10, and 11 are the ones you live in.** Vulnerability management, logging, scanning, pen testing.

### Scanning requirements — the part CySA+ tests

**Requirement 11.3 (internal vulnerability scans):**
- **Quarterly** internal scans, plus after any significant change
- **Authenticated / [[credentialed scan|credentialed]]** scans required under v4.0 (this is new — v3.2.1 didn't strictly require it)
- All "high-risk" vulnerabilities must be remediated and rescanned to verify

**Requirement 11.3.2 (external vulnerability scans):**
- **Quarterly** external scans by an **Approved Scanning Vendor (ASV)** — a PCI SSC–certified third party
- Plus after any significant change
- Must achieve a **passing scan** — no vulnerabilities of CVSS 4.0 or higher remaining (with some exceptions for specific findings)
- Cannot be done by your internal team alone for the external attestation

**Requirement 11.4 (penetration testing):**
- **Annually**, plus after significant change
- Both **internal and external** pen tests
- **Segmentation testing** annually for merchants, **every 6 months** for service providers — to prove the CDE is actually isolated from the rest of the corporate net

### Scan methodology mapping to PCI

| CS0-003 concept | PCI application |
|---|---|
| [[Internal vs external scanning]] | Both required quarterly; external must be ASV |
| [[Credentialed vs non-credentialed]] | v4.0 mandates authenticated internal scans |
| [[Active vs passive scanning]] | Active scans required; passive supplements but doesn't satisfy 11.3 |
| [[Agent vs agentless]] | Either acceptable if scope is verifiable |
| [[Asset discovery]] | Required to define CDE scope — you can't protect what you can't enumerate |
| [[Map scans]] / [[device fingerprinting]] | Used to validate segmentation and CDE boundaries |
| [[Scheduling]] | Quarterly minimum; many shops run monthly to catch drift early |
| Static vs dynamic | [[SAST]]/[[DAST]] required under Req 6.2 for custom apps |
| [[Fuzzing]] | Recommended under secure SDLC (Req 6); not explicitly mandated |
| [[OWASP]] Top 10 | Req 6.2.4 — web apps must address common coding vulnerabilities; OWASP is the reference |
| [[CIS Benchmarks]] | Acceptable source for "industry-accepted hardening standards" under Req 2.2 |
| [[ISO 27000]] series | Compatible framework; not a substitute, but reduces audit overlap |

### Scope — the CDE and segmentation

**The CDE includes:**
- Systems storing, processing, or transmitting PAN, cardholder name, expiration date, service code
- Systems on the same network segment as the above
- Systems that can connect into the CDE (jump hosts, admin workstations, AD domain controllers if they authenticate CDE systems)

**Segmentation is how you shrink scope.** If you can prove that the corporate LAN cannot reach the CDE — via firewall rules, VLANs, ACLs, micro-segmentation — those corporate systems fall out of PCI scope. This is the single biggest cost-saver in a PCI program. A flat network means every workstation in HR is in scope.

> **CompTIA exam trap:** A "PCI-compliant cloud provider" does not make your environment compliant. Compliance is **shared responsibility**. Your AWS account isn't PCI-compliant just because AWS holds an AOC — you're still responsible for the controls on your workloads, IAM, and data. CompTIA will phrase this as "the organization moved its CDE to a PCI-certified cloud — is it compliant?" The answer is no, not automatically.

### Special considerations — when PCI gets weird

- **[[Operational technology]] (OT) / [[Industrial control systems|ICS]] / [[SCADA]]:** Rare in pure PCI scope, but retail environments often have OT-adjacent kit (HVAC, building management) that became the [[pivot point]] in the 2013 Target breach. PCI DSS Req 1 specifically calls out network segmentation between CDE and "untrusted" networks — your HVAC vendor's remote access is untrusted.
- **Critical infrastructure:** If the CDE overlaps with regulated critical infrastructure (utilities accepting card payments), expect [[NERC CIP]] or sector regulations to layer on top.
- **Legacy POS / payment terminals:** Cannot always be patched. Compensating controls (segmentation, application whitelisting, enhanced logging) are PCI-acceptable if documented in a **Compensating Control Worksheet (CCW)**.
- **P2PE (point-to-point encryption) and tokenization:** Reduce scope dramatically. If the merchant never sees plaintext PAN, most of requirements 3 and 4 fall away.

### Validation levels

| Merchant level | Annual transactions | Validation |
|---|---|---|
| Level 1 | >6M | Onsite assessment by **QSA**, ROC (Report on Compliance) |
| Level 2 | 1M–6M | SAQ + sometimes QSA |
| Level 3 | 20K–1M e-commerce | SAQ + ASV scans |
| Level 4 | <20K e-commerce / <1M total | SAQ + ASV scans |

**SAQ** = Self-Assessment Questionnaire. **QSA** = Qualified Security Assessor. **ASV** = Approved Scanning Vendor. **ROC** = full audit report. **AOC** = Attestation of Compliance, the signed summary.

### CompTIA exam traps

> **Trap 1 — frequency.** PCI scans are **quarterly**, not monthly or annually. Pen tests are **annual**. Segmentation testing is **annual for merchants, semi-annual for service providers**. CompTIA loves swapping these.

> **Trap 2 — passing scan.** A passing ASV scan means **no CVSS 4.0+ findings** (with carve-outs). It does *not* mean "no vulnerabilities." The exam will offer "zero vulnerabilities" as a distractor.

> **Trap 3 — PCI is not a law.** It's a contract. Fines come from the card brands and acquirer, not a regulator. GDPR is law, HIPAA is law, PCI is contract. Easy point if you remember it.

> **Trap 4 — credentialed scans under v4.0.** If the question stem mentions PCI v4.0 and asks what kind of internal scan, the answer is **authenticated/credentialed**. v3.2.1 didn't require it; v4.0 does.

## SOC reality

- **The ASV scan email arrives quarterly** and someone in your team gets to argue with the scanning vendor about whether `TLS_RSA_WITH_AES_128_CBC_SHA` on a load balancer is a real finding or a compensating-control situation. It's always a real finding. Fix it.
- **The first question after any incident touching payments is "was PAN exposed?"** If yes, your IR clock starts ticking on card-brand notification (typically immediate, with detailed reporting within days), and your QSA gets a phone call. Forensic firm must be a **PFI** (PCI Forensic Investigator) — your usual IR retainer may not qualify.
- **Scope-creep is the silent killer.** A developer spins up a new microservice that touches PAN, doesn't tell anyone, and now an unsegmented EKS cluster is in your CDE. Asset discovery scans exist to catch this before the QSA does. *I've watched a clean ROC turn into a 90-day remediation sprint because someone added a "quick" analytics pipeline that mirrored card data.*
- **The CISO will ask: "are we PCI compliant right now?"** Correct answer is never yes or no — it's "we hold a current AOC dated [X], and our continuous controls monitoring shows [Y]." Compliance is a point-in-time attestation; security is the continuous state.
- **L1 → L2 handoff for PCI-tagged alerts** should be faster than normal. CDE assets get priority queue. If your SIEM doesn't tag CDE assets distinctly, fix that before you fix anything else.

## Related concepts

[[Vulnerability scanning]] · [[Credentialed vs non-credentialed]] · [[Internal vs external scanning]] · [[Active vs passive scanning]] · [[Asset discovery]] · [[Network segmentation]] · [[CIS Benchmarks]] · [[OWASP Top 10]] · [[ISO 27000]] · [[GDPR]] · [[HIPAA]] · [[SOX]] · [[Compensating controls]] · [[ASV]] · [[Cardholder data environment]] · [[Penetration testing]] · [[CVSS]] · [[SAST]] · [[DAST]]

*Source: VIRGIL knowledge base — 2026-05-11*