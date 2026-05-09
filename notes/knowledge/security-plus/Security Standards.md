# Security Standards

## What it is

In Mario, you don't get to decide that the flagpole is now in the middle of the level, or that fire flowers should grant seven lives instead of one. Nintendo wrote the rules; every level designer, every player, every speedrunner operates inside that fixed ruleset. **Security standards** work the same way — they're the published rulebook that tells every organization how the game is played, so nobody invents their own broken version of "secure."

A **security standard** is a formally published, often mandatory specification that defines required controls, processes, or technical configurations an organization must implement to achieve a defined security or compliance outcome.

## Why it matters

Without standards, "we're secure" means whatever the loudest person in the room decided that morning. Standards turn security from opinion into measurable, auditable practice — and failing to meet a regulatory standard like **PCI DSS** or **HIPAA** triggers fines, contract loss, and breach liability. On SY0-701 Objective 5.1, you need to recognize the difference between a **regulation** (law), a **standard** (specification), a **policy** (internal rule), and a **procedure** (the steps). CompTIA's favorite trap: making you pick "standard" when the answer is "policy," or pairing **PCI DSS** with healthcare data instead of payment cards.

## Key facts

### Standards vs. the rest of the governance stack

| Layer | What it is | Example |
|---|---|---|
| [[Regulation]] | Law from a government | HIPAA, GDPR, SOX |
| [[Standard]] | Required specification, often industry-driven | PCI DSS, ISO 27001 |
| [[Framework]] | Optional structured approach | NIST CSF, COBIT |
| [[Policy]] | Internal "what we will do" | Acceptable Use Policy |
| [[Procedure]] | Internal "how we do it" step by step | Password reset runbook |
| [[Guideline]] | Recommended, non-mandatory | Hardening recommendations |

### Major standards on the SY0-701 radar

- **[[PCI DSS]]** — Payment Card Industry Data Security Standard. Twelve requirements covering cardholder data protection. Mandated by card brands (Visa, Mastercard), not government. Current version: PCI DSS 4.0.
- **[[ISO 27001]]** — International standard for an **Information Security Management System (ISMS)**. Certifiable. Sister standards: **ISO 27002** (controls catalog), **ISO 27701** (privacy extension), **ISO 31000** (risk management).
- **[[NIST SP 800-53]]** — U.S. federal control catalog. Required for federal agencies under **[[FISMA]]**.
- **[[NIST SP 800-171]]** — Controls for protecting **Controlled Unclassified Information (CUI)** in non-federal systems. Foundation of **[[CMMC]]** for defense contractors.
- **[[NIST Cybersecurity Framework]] (CSF)** — Identify, Protect, Detect, Respond, Recover, plus Govern in CSF 2.0. Voluntary framework, not strictly a "standard."
- **[[FIPS 140-3]]** — Federal validation standard for cryptographic modules. If a vendor sells crypto to the U.S. government, the module must be FIPS-validated.
- **[[Common Criteria]] (ISO/IEC 15408)** — International standard for evaluating security properties of IT products. Uses **Evaluation Assurance Levels (EAL1–EAL7)**.

### Regulatory standards that act like laws

| Standard | Domain | Triggered by |
|---|---|---|
| [[HIPAA]] | U.S. healthcare data (PHI) | Handling protected health information |
| [[GDPR]] | EU resident personal data | Processing data of EU subjects |
| [[SOX]] | U.S. public company financial reporting | Being publicly traded |
| [[GLBA]] | U.S. financial institutions | Handling consumer financial data |
| [[CCPA]]/[[CPRA]] | California resident data | Doing business with Californians |

### How standards get enforced

- **[[Audit]]** — internal or external review against the standard's controls.
- **[[Attestation]]** — formal statement (often from a third party like a **QSA** for PCI DSS) that controls are in place.
- **[[Certification]]** — issued by an accredited body (ISO 27001 cert, FedRAMP authorization).
- **[[Continuous monitoring]]** — ongoing compliance verification rather than annual snapshots.

### Exam traps to memorize

- **PCI DSS** is **not** a law. It's a contractual obligation enforced by card brands.
- **NIST CSF** is a **framework**, not a standard, even though people use the words interchangeably.
- **HIPAA** covers **PHI** — health data. Not financial. Not generic PII.
- A **policy** is internal; a **standard** is usually external or organization-wide mandatory specification.
- **ISO 27001** is the certifiable management-system standard; **ISO 27002** is the control catalog you implement to satisfy it.

## Related concepts

[[Governance]] · [[Compliance]] · [[Regulation]] · [[Framework]] · [[Policy]] · [[Procedure]] · [[Guideline]] · [[PCI DSS]] · [[ISO 27001]] · [[NIST SP 800-53]] · [[NIST SP 800-171]] · [[NIST Cybersecurity Framework]] · [[FIPS 140-3]] · [[HIPAA]] · [[GDPR]] · [[SOX]] · [[CMMC]] · [[Audit]] · [[Attestation]]

---
*Source: VIRGIL knowledge base — 2026-05-08*