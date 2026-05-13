# Impact Categorization (FIPS 199)

## What it is

In **Breath of the Wild**, you don't fight every monster the same way. A red Bokoblin in Hyrule Field is a wooden-club nuisance — you swing once, loot the arrow, move on. A Lynel on Ploymus Mountain is a full kit check: best weapons, fairy in reserve, shield-parry timing rehearsed. Same world, same Link, completely different posture. You triaged the encounter the moment you saw what it was. That's exactly what **FIPS 199** does — it tells you which systems are Bokoblins and which are Lynels before you ever draw a sword.

In plain English: FIPS 199 is a federal standard that forces every information system to be rated **Low, Moderate, or High** across three security objectives — **Confidentiality, Integrity, Availability** — so that scan frequency, scan depth, patching urgency, and acceptable downtime aren't decided by gut feel.

Technical definition: **FIPS 199** (Federal Information Processing Standard 199, *Standards for Security Categorization of Federal Information and Information Systems*, NIST, Feb 2004) requires the system owner to assign an impact level — LOW, MODERATE, or HIGH — to each of the CIA triad objectives based on the worst-case adverse effect a loss of that objective would have on organizational operations, assets, or individuals. The system's overall categorization is the **high-water mark** across the three objectives. This rating then drives control selection under NIST SP 800-53 and scan/patch posture under NIST SP 800-40 and the org's [[Vulnerability Management Program]].

## Why it matters

FIPS 199 is the upstream decision that makes every downstream vulnerability management decision defensible. When the change board asks why the public web server gets scanned weekly and the cardholder database gets scanned daily with credentialed deep scans, the answer is the FIPS 199 categorization — not the analyst's opinion.

For CS0-003 Objective 2.1, FIPS 199 is the conceptual anchor under **sensitivity levels**, **regulatory requirements**, **scheduling**, and **special considerations**. CompTIA wants you to understand that scan strategy is driven by data classification, not by what's convenient. Mandatory for any federal system under FISMA. Heavily borrowed by state, local, and private sector orgs that need a defensible categorization framework — PCI DSS, HIPAA, and SOX all map cleanly onto FIPS 199 thinking even when they don't name it.

The career relevance: every vulnerability management analyst eventually argues with an asset owner about scan windows. The analyst with a FIPS 199 categorization wins. The analyst without one loses to whoever yells loudest.

## Key facts

### The three security objectives

| Objective | What loss means | Real-world example |
|---|---|---|
| **Confidentiality** | Unauthorized disclosure of information | PII leak, source code dump, credential exposure |
| **Integrity** | Unauthorized modification or destruction of information | Tampered financial records, altered medical dosing data |
| **Availability** | Disruption of access to or use of information | Ransomware lockout, DDoS against payment portal |

You rate each one independently. A public website might be LOW confidentiality (it's all public anyway), LOW integrity (defaced is recoverable), but MODERATE availability (the marketing team will be in your office if it's down). The system itself takes the **high-water mark**: MODERATE.

### The three impact levels

| Level | Adverse effect | Translation |
|---|---|---|
| **LOW** | Limited adverse effect — minor damage, minor harm, minor financial loss | The Bokoblin. Inconvenient. |
| **MODERATE** | Serious adverse effect — significant damage, significant harm, significant financial loss | The Hinox. Real fight, real risk. |
| **HIGH** | Severe or catastrophic adverse effect — major damage, loss of life, mission failure | The Lynel. Bring everything you have. |

The FIPS 199 formula, written out:

```
SC information_system = {
  (confidentiality, IMPACT),
  (integrity, IMPACT),
  (availability, IMPACT)
}
```

Where IMPACT ∈ {LOW, MODERATE, HIGH}. The overall system categorization equals the highest of the three.

### How categorization drives scan strategy

| Categorization | Scan frequency | Scan depth | Patch SLA | Acceptable downtime |
|---|---|---|---|---|
| **LOW** | Monthly or quarterly | [[Uncredentialed Scanning]] often acceptable | 30–90 days for criticals | Flexible — weekend windows |
| **MODERATE** | Weekly | [[Credentialed Scanning]], authenticated checks | 14–30 days for criticals | Defined maintenance windows |
| **HIGH** | Daily or continuous, often with [[Agent-Based Scanning]] | Credentialed + [[Configuration Compliance Scanning]] against CIS benchmarks | 24–72 hours for criticals, often emergency change | Near-zero — requires HA failover or blue/green |

This is the exam-relevant linkage. CompTIA can ask "you have a HIGH-impact system, which scan approach is appropriate?" — the answer is the one with credentialed depth, agent-based persistence, and high frequency.

### The high-water mark rule

A system's overall categorization is the **highest impact rating across the three objectives**. You do not average. You do not compromise. If integrity is HIGH and the other two are LOW, the system is HIGH.

Why: in security, the chain breaks at the weakest link, and the impact of a breach is dominated by the worst-case axis. A medical records system with LOW availability but HIGH integrity is still HIGH — because corrupted dosing data can kill a patient even if the system never goes down.

### Regulatory and framework alignment

FIPS 199 is the federal mandatory layer, but the categorization mindset shows up across regulatory frameworks:

- **[[FISMA]]** — mandates FIPS 199 categorization for federal systems
- **[[NIST SP 800-60]]** — provides guidance on mapping specific information types to impact levels
- **[[NIST SP 800-53]]** — control baseline selection (LOW/MODERATE/HIGH baselines) is driven by FIPS 199 categorization
- **[[PCI DSS]]** — cardholder data environments effectively map to HIGH confidentiality regardless of what you call them; required quarterly external scans by ASV and internal scans after significant change
- **[[HIPAA]]** — ePHI systems are at minimum MODERATE confidentiality, often HIGH integrity
- **[[ISO 27001]]** — uses asset valuation and risk assessment that parallels FIPS 199 categorization
- **[[CIS Controls]]** — Implementation Groups (IG1/IG2/IG3) loosely parallel LOW/MODERATE/HIGH posture
- **OT/[[ICS-SCADA Security]]** — availability is almost always HIGH (a stopped pipeline pump is a safety event); integrity is HIGH (a tampered setpoint can blow up a refinery); confidentiality is often LOW. This inverts the IT default and is a known CompTIA scenario.

### Special considerations

> **CompTIA exam trap:** OT/ICS/SCADA environments invert the usual CIA priority. In IT, confidentiality often dominates. In OT, **availability and integrity are the HIGH ratings** — a power plant doesn't care if the turbine RPM is leaked, it cares that the setpoint isn't altered and the controller doesn't crash. CompTIA tests this directly. Active scanning that's routine in IT can crash legacy PLCs in OT.

> **CompTIA exam trap:** The high-water mark is not the average. If you see C=LOW, I=LOW, A=HIGH, the system is HIGH — not MODERATE. CompTIA will offer "MODERATE" as the trap answer.

> **CompTIA exam trap:** FIPS 199 is **categorization**, not **risk assessment**. Categorization is about impact if something bad happens. Risk assessment adds likelihood. Don't confuse FIPS 199 (impact only) with NIST SP 800-30 (risk = likelihood × impact).

### Categorization examples

| System | C | I | A | Overall | Rationale |
|---|---|---|---|---|---|
| Public marketing website | LOW | LOW | MODERATE | **MODERATE** | Public data, but downtime hurts brand |
| Internal HR portal with SSN | HIGH | MODERATE | LOW | **HIGH** | PII drives C; record tampering is serious; can tolerate downtime |
| Cardholder database (PCI) | HIGH | HIGH | MODERATE | **HIGH** | Card data breach is catastrophic, tampering is catastrophic |
| SCADA controller, water treatment | LOW | HIGH | HIGH | **HIGH** | Setpoints leaking is fine; setpoints altered or service down is a public safety event |
| Dev/test sandbox with synthetic data | LOW | LOW | LOW | **LOW** | No production data, no production dependency |

### Categorization drives more than scans

The categorization isn't just a scan scheduler. It also drives:

- **Backup frequency and RPO/RTO targets** — HIGH availability systems get tighter RPO
- **Logging retention and SIEM ingestion tier** — HIGH systems usually feed [[SIEM]] continuously with longer retention
- **[[Access Control]] rigor** — MFA mandatory, privileged access management, just-in-time elevation
- **Change management approval levels** — HIGH systems require senior approval, often a CAB
- **Incident response priority** — alerts from HIGH systems jump the queue
- **Encryption requirements** — at rest, in transit, sometimes in use
- **Network [[Segmentation]]** — HIGH systems usually live in their own VLAN/enclave with strict ingress/egress

## SOC reality

- The vulnerability management dashboard sorts by **asset criticality**, which is the FIPS 199 categorization wearing a different shirt. A CVSS 9.8 on a LOW-rated dev sandbox loses to a CVSS 7.2 on a HIGH-rated cardholder database every time. CVSS is the vulnerability rating, FIPS 199 is the asset rating — *the actual remediation priority is the product of both, not either one alone.*
- When the CISO walks over and asks "what's our exposure on this CVE?", the first SQL you run filters the asset inventory by FIPS 199 HIGH. You answer the high-water-mark question first, then drill down. Anything else wastes the CISO's first ninety seconds.
- The L1 analyst's first triage move on a fresh alert is to check the asset's categorization tag in the CMDB. HIGH means page the on-call. MODERATE means open a ticket and watch. LOW means it's probably going in the backlog and that's defensible. *The categorization tag is the difference between waking someone up at 3am and not.*
- Never promise leadership that a system's categorization is "right" — categorizations drift. The marketing website that was LOW two years ago is now hosting customer login flows and processing payment intents. Re-categorization is a quarterly hygiene task, not a one-time exercise. *I have watched a "LOW" system turn into the incident of the quarter because nobody re-rated it after a feature launch.*
- The handoff: asset owner sets categorization, security team validates, GRC documents, vulnerability management consumes. When categorization is wrong, the failure is upstream — push the conversation back to asset ownership, don't absorb it in the SOC.

## Related concepts

[[CVSS]] · [[Vulnerability Management Program]] · [[Credentialed Scanning]] · [[Uncredentialed Scanning]] · [[Agent-Based Scanning]] · [[Configuration Compliance Scanning]] · [[Asset Inventory]] · [[FISMA]] · [[NIST SP 800-53]] · [[NIST SP 800-60]] · [[PCI DSS]] · [[HIPAA]] · [[ISO 27001]] · [[CIS Controls]] · [[ICS-SCADA Security]] · [[Segmentation]] · [[Risk Assessment]] · [[Data Classification]]

*Source: VIRGIL knowledge base — 2026-05-11*