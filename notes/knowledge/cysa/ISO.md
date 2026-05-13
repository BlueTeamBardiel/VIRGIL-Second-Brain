# ISO — International Organization for Standardization

## What it is

In **Resident Evil**, the Spencer Mansion isn't just a building — it's a system that follows rules. Every locked door uses a specific key (Armor, Sword, Helmet, Shield). Every typewriter saves the same way. Every ink ribbon weighs the same in your inventory. The Umbrella Corporation engineered the place so any researcher dropped into Arklay could navigate the protocols without re-learning them — same door types, same lock conventions, same save-room layout from one wing to the next. That standardization is the only reason Jill and Chris can survive: they don't have to figure out a new key system in every room. They just need the right key for the documented lock.

That's exactly what **ISO** does for security. The **International Organization for Standardization** publishes the global rulebooks so a SOC analyst in Frankfurt and a CISO in São Paulo can both say "we're aligned to **ISO/IEC 27001**" and mean the same controls, the same audit evidence, the same vocabulary.

Technical definition: ISO is a non-governmental international standards body headquartered in Geneva. For CySA+, the relevant family is the **ISO/IEC 27000 series** — the information security management standards. It defines how an organization runs an **Information Security Management System (ISMS)** as a documented, auditable, continuously improving program.

## Why it matters

Vulnerability management doesn't happen in a vacuum. The reason you scan on a schedule, the reason you prioritize one CVE over another, the reason the change board makes you wait — most of that is driven by a framework somebody signed a contract to follow. ISO 27001 is the one auditors show up with when the customer demands it in the MSA.

Exam relevance: **Objective 2.1** calls out "industry frameworks" and "regulatory requirements" as inputs to vulnerability scanning scope, frequency, and prioritization. CompTIA expects you to recognize ISO 27001 alongside [[PCI DSS]], [[CIS Benchmarks]], [[OWASP]], and [[NIST CSF]] — and to know which one applies in which scenario.

Career relevance: if you work at any enterprise that sells to other enterprises, ISO 27001 certification is on the sales team's must-have list. When the SOC suddenly has to produce evidence of "documented vulnerability management process with review cadence" — that's the auditor asking for an ISO 27001 Annex A.12.6.1 artifact. You will be the one pulling it.

## Key facts

### The ISO/IEC 27000 series — what's actually in it

| Standard | What it is | Why a SOC analyst cares |
|---|---|---|
| **ISO/IEC 27000** | Overview & vocabulary | Defines the terms used by every other doc in the family |
| **ISO/IEC 27001** | ISMS requirements (certifiable) | The one you get audited against — Annex A lists 93 controls in the 2022 revision |
| **ISO/IEC 27002** | Code of practice for controls | How to actually implement the 27001 Annex A controls |
| **ISO/IEC 27005** | Information security risk management | The risk methodology that feeds vuln prioritization |
| **ISO/IEC 27017** | Cloud-specific controls | Extends 27002 for cloud workloads |
| **ISO/IEC 27018** | PII in public clouds | Privacy controls when the cloud holds customer data |
| **ISO/IEC 27035** | Incident response | Phases that map cleanly to NIST SP 800-61 |
| **ISO/IEC 27037** | Digital evidence handling | Acquisition, chain of custody for forensics |
| **ISO/IEC 27701** | Privacy ISMS extension | Bolts onto 27001 for GDPR alignment |

The one CompTIA cares about most is **27001**. If a question says "the organization is ISO certified," they mean 27001.

### What "ISO 27001 certified" actually means

It is not a checklist of technical controls. It's a certification that the organization runs a documented, risk-driven, continuously-reviewed ISMS. An external accredited auditor (Stage 1 documentation review, Stage 2 implementation audit) confirms the program exists and operates. Surveillance audits annually; full re-cert every three years.

The ISMS has to cover:

- **Scope statement** — which parts of the business are in scope
- **Risk assessment methodology** — how you identify, evaluate, treat risk
- **Statement of Applicability (SoA)** — which Annex A controls apply and why, which don't and why not
- **Risk treatment plan** — what you're mitigating, transferring, avoiding, accepting
- **Continual improvement** — Plan-Do-Check-Act (PDCA) cycle

If the SoA says "A.12.6.1 — management of technical vulnerabilities — applicable," then your vulnerability scanning program is fair game for the auditor. They'll want to see scan schedules, asset inventories, remediation SLAs, exception tracking.

### How ISO drives vulnerability management decisions

This is the CySA+ angle. The framework is not abstract — it dictates real scan-program parameters:

- **Asset discovery scope** — ISO 27001 A.5.9 requires an asset inventory. No inventory, no scan scope. [[Asset discovery]] feeds the ISMS.
- **Scan scheduling** — A.12.6.1 expects "timely" identification of technical vulnerabilities. "Timely" is defined by your risk methodology, not the standard. Monthly authenticated scans on production, weekly on internet-facing, quarterly on isolated OT — typical postures.
- **[[Credentialed vs non-credentialed scanning]]** — credentialed gives the depth the auditor wants to see. Uncredentialed alone usually fails to demonstrate "adequate" coverage.
- **Internal vs external scanning** — both required. External proves perimeter posture; internal proves you'd catch a foothold.
- **Risk-based prioritization** — A.5.7 (threat intelligence) feeds into how you rank CVEs. Pure [[CVSS]] without context is not ISO-aligned.
- **Segmentation evidence** — A.8.22 (segregation of networks). If you claim segmentation as a compensating control, the auditor wants scan results that prove the boundary holds.
- **Exception management** — every vulnerability you didn't fix needs documented business justification, compensating control, and review date. The auditor lives in the exception register.

### ISO vs the other frameworks CompTIA tests

| Framework | Origin | Posture | When it applies |
|---|---|---|---|
| **ISO/IEC 27001** | International, voluntary, certifiable | Risk-based ISMS | B2B trust, global ops, customer contract requirement |
| **[[NIST CSF]]** | US, voluntary, non-certifiable | Function-based (Identify/Protect/Detect/Respond/Recover) | US federal alignment, broad maturity model |
| **[[NIST SP 800-53]]** | US, mandatory for federal | Control catalog | FISMA, federal systems |
| **[[PCI DSS]]** | Industry (card brands), contractual | Prescriptive | Any entity touching cardholder data |
| **[[CIS Benchmarks]]** | Non-profit, voluntary | Configuration hardening | Endpoint/server baseline configs |
| **[[OWASP]]** | Open community | Web app testing methodology | AppSec, [[dynamic application security testing]] |
| **HIPAA** | US law | Healthcare PHI | Covered entities and business associates |
| **GDPR** | EU law | Personal data | Any processing of EU resident data |

ISO 27001 is the umbrella ISMS. The others slot underneath it as control implementations.

### Special considerations — OT, ICS, SCADA

ISO has a separate family for industrial environments: **IEC 62443** (sometimes co-branded ISO/IEC). For [[OT]], [[ICS]], and [[SCADA]] systems, vulnerability scanning under ISO/IEC 62443 has explicit guardrails — active scans against a PLC can brick it. The standard expects passive discovery, asset fingerprinting via SPAN ports, and change-controlled credentialed checks during scheduled maintenance windows only.

If a CompTIA scenario describes a power plant or water treatment facility — that's a 62443 question wearing an ISO costume. Don't recommend an aggressive Nessus scan against the historian server.

### CompTIA exam traps

> **CompTIA exam trap:** ISO 27001 vs ISO 27002 — they sound interchangeable, they aren't. **27001 is the requirements standard you get certified against. 27002 is the implementation guidance for the controls.** You are not "ISO 27002 certified" — that's not a thing.

> **CompTIA exam trap:** "ISO 27000" as an answer choice. The 27000 document itself is just the vocabulary glossary. If the question asks which standard covers the ISMS requirements, the answer is **27001**, not 27000.

> **CompTIA exam trap:** ISO 27001 is voluntary; PCI DSS is contractual; HIPAA is law. CompTIA will give you a scenario where a hospital takes credit cards and ask which framework drives the scan schedule. The answer is "all of them, but the most prescriptive wins on overlap" — and PCI DSS is the most prescriptive on scan cadence (quarterly ASV scans, mandatory).

> **CompTIA exam trap:** ISO standards are jurisdiction-agnostic. GDPR is EU law. A question that pairs "ISO 27001" with "regulatory requirement" is mixing concepts — ISO is a framework, not a regulation. If the answer says "ISO 27001 is required by law," it's wrong.

## SOC reality

- The first time you'll hear the word "ISO" in the SOC is when the GRC team emails asking for "evidence of vulnerability scan coverage for the audit window." They want screenshots of scan policies, asset coverage percentages, and a remediation timeline report. You will be the one running the export.
- Pre-audit, expect a tabletop where the auditor asks the SOC lead to walk through a hypothetical incident from detection to closure. They're checking that your [[incident response]] runbook aligns with ISO 27035 phases. Have the runbook open in another tab.
- The CISO will ask: "Can we say we follow ISO 27001?" — there's a difference between *aligned to*, *implementing*, and *certified*. Only the last one means an external auditor signed off. Never let leadership claim certification you don't have. That's how you end up in the news.
- When a P1 vuln gets pushed past SLA by the change board, the exception goes into the ISMS exception register with business justification, compensating control, and a review date. If you're the analyst, document it the day it slips — not the week of the audit.
- The handoff: SOC owns detection and initial triage. Vulnerability management team owns the scan program. GRC owns the audit evidence. ISO compliance is the glue — when it breaks, it's because one of those three didn't talk to the others. *The audit doesn't fail because the controls failed — it fails because nobody documented that the controls worked.*

## Related concepts

[[ISMS]] · [[NIST CSF]] · [[NIST SP 800-53]] · [[PCI DSS]] · [[CIS Benchmarks]] · [[OWASP]] · [[Asset discovery]] · [[Credentialed vs non-credentialed scanning]] · [[CVSS]] · [[Risk management]] · [[Statement of Applicability]] · [[OT]] · [[ICS]] · [[SCADA]] · [[IEC 62443]] · [[Incident response]] · [[Regulatory requirements]] · [[Segmentation]] · [[Vulnerability scanning]]

*Source: VIRGIL knowledge base — 2026-05-11*