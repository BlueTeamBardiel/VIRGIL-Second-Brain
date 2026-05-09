# Audits and Assessments

## What it is

In Valorant, after a ranked match Riot's Vanguard anti-cheat replays your client behavior, a tournament admin reviews the demo for stat anomalies, and your team holds a VOD review to find why you kept losing B-site retakes. Three different reviewers, three different scopes, all asking "did the rules hold?" That's exactly what audits and assessments do — they verify whether your security controls actually work instead of just existing on paper.

**Audits** are formal, evidence-based examinations against a defined standard; **assessments** are broader evaluations of risk, posture, or capability that may be advisory rather than pass/fail.

## Why it matters

Without audits, controls drift. A firewall rule added "temporarily" in 2019 is still allowing 0.0.0.0/0 to RDP, your privileged accounts haven't been reviewed since the last admin quit, and the encryption you swore was AES-256 turned out to be DES on a legacy database. Audits surface this rot before an attacker does, and assessments quantify how bad it would be if they did.

**Exam angle (Objective 5.5):** CompTIA wants you to distinguish **internal vs. external**, **regulatory vs. independent third-party**, and the four assessment types: **penetration testing**, **vulnerability assessment**, **attestation**, and the **examinations** sub-types (audit committee, self-assessments). The classic trap: confusing a **penetration test** (active exploitation) with a **vulnerability scan** (passive identification), or thinking **attestation** means the auditor did the work — it doesn't, it means management formally claims the controls work and the auditor signs off on that claim.

## Key facts

### Audits vs. Assessments

| Attribute | [[Audit]] | [[Assessment]] |
|---|---|---|
| Purpose | Verify compliance | Identify risk/gaps |
| Output | Pass/fail, findings | Recommendations, ratings |
| Standard | Fixed (PCI, SOC 2, ISO) | Often flexible |
| Tone | Adversarial-ish | Advisory |
| Frequency | Scheduled (annual) | Continuous or ad-hoc |

### Internal audits

- **[[Internal audit]]**: performed by the organization's own audit function, reporting to the **[[audit committee]]** of the board — never to the CISO or CFO directly, to preserve independence.
- **[[Compliance]] self-assessments**: business units evaluate their own controls against frameworks like [[NIST CSF]] or [[CIS Controls]].
- **Cheap, frequent, and politically compromised** — the auditor still wants to keep their job.

### External audits

- **[[Independent third-party audit]]**: outside firm, no skin in the game, produces reports clients trust.
- **[[Regulatory audit]]**: mandated by law or contract — [[PCI DSS]] (card data), [[HIPAA]] (health), [[SOX]] (financial reporting), [[GDPR]] (EU personal data).
- **Common report types**: [[SOC 2 Type II]] (controls operating effectively over 6–12 months), [[ISO 27001]] certification, [[FedRAMP]] authorization.

### Attestation

- **[[Attestation]]**: management's formal written claim that controls exist and operate as described, validated by an auditor.
- The auditor doesn't *do* the security — they verify management isn't lying.
- Used heavily in **SOC 2** and **SOX 404** reporting.

### Penetration testing

| Type | Tester knowledge | Simulates |
|---|---|---|
| **[[Known environment]]** (white-box) | Full | Insider / co-developer |
| **[[Partially known environment]]** (gray-box) | Limited | Authenticated user |
| **[[Unknown environment]]** (black-box) | None | External attacker |

- **[[Rules of engagement]]** define scope, hours, targets, and what's off-limits — without them, a pentester is just a felon with a laptop.
- Phases: **reconnaissance → scanning → exploitation → post-exploitation → reporting**.
- Active exploitation distinguishes it from a vulnerability scan.

### Vulnerability assessment

- **[[Vulnerability scan]]**: automated identification of known CVEs via tools like [[Nessus]], [[Qualys]], [[OpenVAS]].
- **Credentialed vs. non-credentialed**: credentialed scans see installed patches; non-credentialed see what an attacker sees.
- **Output**: [[CVSS]] scores, prioritized remediation list. No exploitation.

### Examinations and reviews

- **[[Code review]]**: static or peer review of source.
- **[[Configuration review]]**: baseline comparison, often via [[SCAP]].
- **[[Log review]]**: retrospective hunt through SIEM data.

### CompTIA traps to watch

1. **Audit ≠ assessment** — audits verify compliance; assessments evaluate risk.
2. **Attestation is a claim, not a test** — management asserts, auditor validates.
3. **Pentest ≠ vuln scan** — exploitation vs. identification.
4. **Internal audit reports to the board**, not executive management.

## Related concepts

[[Risk Management]] · [[Penetration Testing]] · [[Vulnerability Management]] · [[SOC 2]] · [[PCI DSS]] · [[Compliance Reporting]] · [[Rules of Engagement]] · [[CVSS]] · [[Audit Committee]] · [[Third-Party Risk]]

---
*Source: VIRGIL knowledge base — 2026-05-08*