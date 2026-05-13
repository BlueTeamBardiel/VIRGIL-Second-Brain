# CIS — Center for Internet Security

## What it is

In **Sekiro**, before you fight Genichiro on the rooftop you go to the Sculptor's Idol and check your Skill Tree, your Prosthetic Tools, your gourd charges, your Sugars. Not because you're guessing — because the game *tells you* exactly what configuration survives the next encounter. Posture, vitality, deflect timing, Mikiri counter unlocked. There's a known-good loadout for each boss. Skip the prep, eat the deathblow.

That's exactly what **CIS Benchmarks** are — a known-good loadout for every system you defend, written by people who already died to the boss.

**Plain English:** The Center for Internet Security is a nonprofit that publishes the most widely used hardening guides on the planet. They tell you, line by line, how to configure a Windows Server 2022 box, an Ubuntu 22.04 host, an AWS account, a Cisco IOS device, or a Kubernetes cluster so it isn't soft. They also publish the **CIS Controls** — 18 prioritized security controls that map to NIST CSF, ISO 27001, PCI DSS, and HIPAA.

**Technical:** CIS publishes two flagship products relevant to CS0-003:
- **CIS Benchmarks** — configuration baselines for ~100+ technologies, consensus-developed, freely downloadable as PDFs and machine-readable in vendor scanners.
- **CIS Controls v8** — 18 controls, 153 safeguards, organized into Implementation Groups (IG1, IG2, IG3) by organizational maturity.

Both are referenced directly in CompTIA Objective 2.1 under **industry frameworks** and **security baseline scanning**.

## Why it matters

CIS Benchmarks are what your **vulnerability scanner** compares your endpoints against when you run a **compliance scan** instead of a CVE scan. Nessus, Tenable, Qualys, Rapid7, OpenSCAP — all of them ship CIS Benchmark policies as scan templates. When the auditor asks "what's your hardening standard?" the legally defensible answer is "CIS Level 1, exceptions documented." When the breach happens and counsel asks "did you follow industry best practice?" CIS is the answer that doesn't get you sued.

For CS0-003 you need to know CIS as **the baseline** in **security baseline scanning** — the thing your scanner measures drift against. You also need to know it sits alongside **[[ISO 27000 series]]**, **[[PCI DSS]]**, **[[OWASP]]**, and **NIST** as the **industry frameworks** the exam loves to test.

*The Sec+ candidate memorizes that CIS exists. The CySA+ candidate runs the scan, reads the 800-line CSV, and argues with the Windows team about which 40 findings actually matter.*

## Key facts

### CIS Benchmarks — structure

Every benchmark is organized the same way:

| Element | What it is |
|---|---|
| **Scored vs Not Scored** | Scored findings affect your compliance percentage. Not Scored are recommendations. |
| **Level 1 (L1)** | Baseline hardening. Minimal functional impact. Run this everywhere. |
| **Level 2 (L2)** | Defense-in-depth. May break legitimate functionality. Run on high-sensitivity systems. |
| **Profile** | Server vs Workstation, Domain Controller vs Member Server, etc. The same OS has multiple profiles. |
| **Rationale** | Why the setting matters. Read this before you argue with the sysadmin. |
| **Audit / Remediation** | Exact commands to check and to fix. |

The benchmark for Windows Server 2022 is ~1,000 pages. Nobody reads it cover to cover. You import it into your scanner and you read the findings.

### CIS Controls v8 — Implementation Groups

| IG | Target organization | Safeguards |
|---|---|---|
| **IG1** | Small/medium, limited security staff, basic hygiene | 56 safeguards |
| **IG2** | Mid-size, dedicated security function, regulatory exposure | +74 = 130 safeguards |
| **IG3** | Mature, advanced threats, regulated industry | +23 = 153 safeguards |

IG1 is "essential cyber hygiene." If a small org can't do IG1, ransomware is coming.

### Where CIS sits among the frameworks

| Framework | What it does | CS0-003 angle |
|---|---|---|
| **[[CIS Controls]]** | Prioritized, actionable controls | Tactical implementation |
| **[[NIST CSF]]** | Identify-Protect-Detect-Respond-Recover | Risk management framing |
| **[[ISO 27000 series]]** | International ISMS standard (27001 = certifiable) | Governance, certification |
| **[[PCI DSS]]** | Card data security | Mandatory for card processors |
| **[[OWASP Top 10]]** | Web app vulnerability categories | AppSec, dynamic scanning |

CompTIA tests these together. Know which is **prescriptive** (CIS, PCI DSS — "do this"), which is **descriptive** (NIST CSF, ISO 27001 — "have a program that does this"), and which is **categorical** (OWASP — "watch for these classes").

### How CIS plugs into vulnerability scanning

Objective 2.1 wants you to know the **scan methods** and **special considerations**. CIS is the *content* the scan compares against in compliance mode:

- **Security baseline scanning** — scanner pulls the CIS policy, runs against the host, reports drift. Output: "Account lockout threshold = 0, expected 5 or fewer."
- **Credentialed scanning** — required for CIS compliance scans. You can't read registry keys, GPO settings, sudoers files, or audit policies without local creds. Uncredentialed scanning sees what an attacker on the network sees; **credentialed** sees what's actually configured.
- **Agent vs agentless** — agents (CrowdStrike, Tenable Nessus Agent, Qualys Cloud Agent) check the CIS baseline continuously. Agentless scans run on a schedule from a scanner appliance over the network.
- **Internal vs external** — CIS baseline scans are almost always **internal** (you need creds and host access). External scans look for exposure, not configuration.

### Scan considerations CIS interacts with

| Consideration | CIS-specific note |
|---|---|
| **Scheduling** | Compliance scans are heavy. Off-hours for production. Continuous via agent for cloud. |
| **Performance** | Credentialed scans hit CPU and disk I/O. Test on a non-prod host first. |
| **Sensitivity levels** | L1 everywhere; L2 only on high-sensitivity assets after testing. |
| **Segmentation** | Scanner needs reachability into every segment. Plan firewall rules and dedicated scanner VLANs. |
| **Regulatory requirements** | PCI DSS req. 2.2 mandates a documented hardening standard. CIS satisfies it. |

### CIS and special considerations (the ones CompTIA loves)

> **CompTIA exam trap:** CIS Benchmarks exist for **[[ICS]]/[[SCADA]]** and **[[Operational Technology|OT]]** environments — but you do **not** run a standard credentialed CIS scan against a PLC or HMI. ICS protocols (Modbus, DNP3) can crash from a port scan. Use **passive scanning** (e.g., span port sniffing with Claroty, Nozomi, Dragos) and apply CIS guidance manually. The CompTIA answer to "scan the ICS network for compliance" is *passive, not active*.

> **CompTIA exam trap:** **CIS is a framework, not a regulation.** Following CIS does not satisfy PCI DSS, HIPAA, or GDPR by itself — it *maps to* their requirements. The exam will offer "CIS compliance = PCI compliance" as a distractor. Wrong. CIS is *how*; PCI/HIPAA/GDPR are *what*.

> **CompTIA exam trap:** **Scored ≠ critical.** A Scored finding affects your compliance percentage but isn't necessarily high severity. Don't confuse CIS scoring with CVSS. CIS scoring = "does this count toward the compliance number." CVSS = "how bad is this vulnerability."

### CIS Controls v8 — the 18, fast

1. Inventory of Enterprise Assets · 2. Inventory of Software Assets · 3. Data Protection · 4. Secure Configuration of Assets · 5. Account Management · 6. Access Control Management · 7. Continuous Vulnerability Management · 8. Audit Log Management · 9. Email and Browser Protections · 10. Malware Defenses · 11. Data Recovery · 12. Network Infrastructure Management · 13. Network Monitoring and Defense · 14. Security Awareness Training · 15. Service Provider Management · 16. Application Software Security · 17. Incident Response Management · 18. Penetration Testing.

You don't need to memorize all 18 for the exam. You do need to know **Control 7 = continuous vulnerability management** and **Control 4 = secure configuration** — these are the controls that connect directly to Objective 2.1.

### CIS-CAT — the tool

**CIS-CAT Pro** is CIS's own assessment tool. Reads the benchmark, scans a host, outputs HTML/CSV/XML. Most enterprises use Tenable or Qualys with imported CIS policies instead, but the exam may mention CIS-CAT as the reference implementation.

### What CIS doesn't do

- Doesn't scan for CVEs. That's your vulnerability scanner doing CVE matching against installed software versions.
- Doesn't do **fuzzing** or **dynamic application testing**. That's the OWASP/dynamic-scanning lane.
- Doesn't do **reverse engineering** of malware. Different discipline entirely.
- Doesn't do **device fingerprinting** or **map scans**. That's Nmap, that's discovery, that's the layer below baseline scanning.

The flow is: **asset discovery → device fingerprinting → vulnerability scan (CVE) + compliance scan (CIS) → remediation.** CIS lives in the compliance scan box.

## SOC reality

- The compliance dashboard shows your Windows server fleet at **73% CIS L1 compliance**. The CISO wants 95%. The Windows team says "you're going to break printing again." You spend the next sprint negotiating exceptions, not fixing findings.
- Top recurring CIS finding in every enterprise: **"Audit Process Creation" not enabled** — meaning no Sysmon-equivalent process logs in the Windows event log. The SOC needs this to investigate; the endpoint team forgets to GPO it. You'll fight this fight more than once.
- When an auditor walks in and asks for your hardening standard, the right answer is "CIS Benchmark Level 1 for [OS], documented exceptions in [GRC tool]." If the answer is "we have a wiki page from 2019," you are about to have a bad week.
- For OT/ICS environments: **never** run an active CIS scan against production. The IR call after you brick a PLC during a vuln scan is career-defining in the wrong direction. Passive only. Manual review against the CIS ICS guidance.
- The L1 analyst doesn't usually touch CIS work — this is **vulnerability management** team turf. But L2/L3 and IR get pulled in when a benchmark finding correlates to a real incident (e.g., "PowerShell logging was disabled per CIS finding 18.9.100.1, that's why we have no telemetry for the lateral movement"). Then it becomes everyone's problem.

## Related concepts

[[Vulnerability scanning]] · [[Credentialed vs non-credentialed scanning]] · [[Agent vs agentless scanning]] · [[Security baseline scanning]] · [[ISO 27000 series]] · [[NIST CSF]] · [[PCI DSS]] · [[OWASP Top 10]] · [[SCADA]] · [[ICS]] · [[Operational Technology]] · [[Passive vs active scanning]] · [[Asset discovery]] · [[Device fingerprinting]] · [[Nessus]] · [[OpenSCAP]] · [[Hardening]] · [[GPO]] · [[Continuous vulnerability management]]

*Source: VIRGIL knowledge base — 2026-05-11*