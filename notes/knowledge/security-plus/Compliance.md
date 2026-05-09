# Compliance

## What it is

In *The Witcher 3*, before Geralt can legally practice his trade in Novigrad, he has to obtain a **Witcher's License** from the Hierarch's officials — and even then, every contract on the notice board carries terms: agreed payment, proof of the kill (a head, a fang, a tongue), and a signed bill from the alderman. Skip the paperwork and you don't get paid; lie about the monster you killed and the alderman docks the reward. The mechanic isn't just bureaucracy — it's a verification loop. The contract states the rules, you perform the work, and a third party (the alderman, the guild, the Hierarch's seal) confirms you complied with the terms before coin changes hands.

That is exactly what compliance is in cybersecurity. In plain English: someone outside your company — a regulator, a customer, an industry body, a government — sets rules for how you must protect data and systems, you do the work to meet those rules, and then an auditor or attestor verifies you actually did it. If you skip the work or fake the proof, you don't just lose the "reward" — you face fines, lawsuits, lost contracts, and sometimes criminal liability.

**Technical definition:** Compliance is the ongoing process of conforming to externally imposed laws, regulations, contractual obligations, or industry standards governing the confidentiality, integrity, and availability of information, supported by documentation, monitoring, reporting, and independent attestation.

Compliance is **not** the same as [[security]]. Security is about reducing risk; compliance is about proving — often to a third party with the power to punish you — that you've reduced it in the specific ways they require.

## Why it matters

A compliance failure is the rare security event where the **attacker is your own regulator**. Equifax paid roughly $700 million after their 2017 breach, much of it driven by violations of the [[FTC Act]] and state laws. British Airways was initially fined £183 million under [[GDPR]] (later reduced to £20M). Anthem paid $16 million to HHS for [[HIPAA]] violations. None of those numbers came from the hackers — they came from compliance regimes.

For Security+ exam purposes, Objective 5.4 ("Summarize elements of effective security compliance") shows up as scenario questions where you must:

- Identify which **regulation** applies to a given data type or industry
- Distinguish **internal** vs. **external** compliance drivers
- Recognize **consequences** of non-compliance (fines, sanctions, reputation, loss of license, contractual default)
- Understand **attestation, acknowledgment, and reporting** as compliance mechanisms
- Pick the right party (DPO, CISO, auditor) for the right responsibility

> **Why CompTIA tests this:** Most analysts won't write the privacy policy, but they *will* be told by GRC "we need evidence that this control runs every 30 days." If you don't understand why, you'll treat it as busywork and document it badly. Compliance evidence is what stands between the company and a nine-figure fine.

## Key facts

### Compliance Reporting: Internal vs. External

CompTIA explicitly splits compliance reporting into two flavors. Memorize the distinction.

| Type | Audience | Examples | Cadence |
|------|----------|----------|---------|
| **Internal** | Executives, board, audit committee, risk committee | Quarterly control health, policy exception reports, KPI/KRI dashboards | Continuous / monthly / quarterly |
| **External** | Regulators, customers, partners, auditors, the public | [[SOC 2]] reports, PCI [[ROC]]/[[SAQ]], breach notifications, [[10-K]] cybersecurity disclosures | Annual, on-demand, or breach-triggered |

> **Exam trap:** A "[[SOC 2]] Type II report given to a customer's procurement team" is **external** reporting, even though the customer isn't a regulator. External = anyone outside the organization.

### Consequences of Non-Compliance

Five categories — CompTIA loves multi-select questions here.

1. **Fines** — Direct monetary penalties. [[GDPR]] caps at €20M or 4% of global annual turnover, whichever is higher. [[HIPAA]] tiers run from $137 to $2.1M per violation per year.
2. **Sanctions** — Loss of authority to operate. A hospital can lose [[CMS]] reimbursement; a defense contractor can lose [[CMMC]] certification and thus DoD contracts.
3. **Reputational damage** — Public breach notification laws (all 50 U.S. states have one) force the embarrassment to be public.
4. **Loss of license** — Banks revoked, broker-dealers de-registered, healthcare providers excluded.
5. **Contractual impact** — Customers exit, SLAs trigger penalties, MSAs allow termination for cause.

Add a sixth that CompTIA sometimes hides: **individual criminal liability**. [[Sarbanes-Oxley]] §906 holds CEOs and CFOs personally criminally liable for false certifications (up to 20 years and $5M). Executives go to prison; this is not theoretical.

### Compliance Monitoring

Compliance isn't a yearly photograph — it's a continuous video.

- **Due diligence / due care** — Due diligence is the *investigation* (vetting a vendor, reading their [[SOC 2]]); due care is the *ongoing prudent action* (patching, training, monitoring).
- **Attestation and acknowledgment** — A signed statement that something is true. Internal example: every employee acknowledges the [[AUP]] annually. External example: management *attests* in a [[SOC 2]] report that controls are designed and operating effectively.
- **Internal vs. external monitoring** — Internal teams run [[SIEM]] dashboards, control self-assessments, and [[GRC]] tooling. External monitoring is performed by independent auditors, regulators, or third-party assessors ([[QSA]] for PCI, [[3PAO]] for FedRAMP).
- **Automation** — Modern programs use [[continuous controls monitoring]] (CCM), [[CSPM]] for cloud posture, and configuration-as-code scans to produce evidence automatically rather than via screenshot-and-spreadsheet.

> **Exam trap:** "Attestation" on the exam usually means a **signed, formal statement** — not just a checkbox. A user clicking "I agree" is acknowledgment; an officer signing under oath is attestation.

### Major Regulations and Frameworks (know these by heart)

| Framework | Domain | Who it covers | Key requirement |
|-----------|--------|---------------|-----------------|
| [[GDPR]] | EU privacy | Anyone processing EU resident data | Lawful basis, [[DPO]], 72-hour breach notice, data subject rights |
| [[HIPAA]] | U.S. health | Covered entities & business associates | Privacy Rule, Security Rule (admin/physical/technical safeguards), Breach Notification Rule |
| [[PCI DSS]] | Payment cards | Anyone storing/processing/transmitting cardholder data | 12 requirements, annual [[ROC]] or [[SAQ]] |
| [[SOX]] | U.S. public companies | SEC-listed companies | Internal controls over financial reporting (§404), executive certification (§302/906) |
| [[GLBA]] | U.S. financial | Banks, insurers, brokers | Safeguards Rule, privacy notices |
| [[FERPA]] | U.S. education | Schools receiving federal funds | Student record privacy |
| [[CCPA]]/[[CPRA]] | California consumer | Businesses meeting CA thresholds | Right to know, delete, opt-out of sale |
| [[FISMA]] | U.S. federal | Federal agencies & contractors | NIST [[RMF]], categorize/select/implement/assess/authorize/monitor |
| [[CMMC]] | DoD supply chain | DoD contractors | Tiered cyber maturity (Level 1–3) |
| [[NIST CSF]] | Voluntary | Anyone | Identify, Protect, Detect, Respond, Recover, Govern (2.0) |
| [[ISO 27001]] | International | Anyone | ISMS with Annex A controls, certifiable |
| [[SOC 2]] | Service orgs | SaaS/MSPs/processors | Trust Services Criteria — Security (required), Availability, Confidentiality, Processing Integrity, Privacy |

> **Exam trap:** [[SOC 2]] is **not a regulation** — it's an [[AICPA]] auditing standard. Customers *contractually require* it. Don't pick "regulation" if a question asks what SOC 2 is; pick "attestation report" or "framework."

### Privacy-Specific Compliance

Privacy is its own beast within compliance. Key terms:

- **Data subject** — the human the data is about
- **Data controller** — decides *why and how* personal data is processed
- **Data processor** — processes data on behalf of the controller
- **Data Protection Officer ([[DPO]])** — required under [[GDPR]] for public authorities and orgs doing large-scale monitoring or processing of special categories. Reports to highest management, cannot be dismissed for performing duties.
- **Privacy Impact Assessment ([[PIA]])** / **DPIA** under GDPR — formal analysis required before high-risk processing
- **Right to be forgotten** (GDPR Art. 17), **right to access** (Art. 15), **right to portability** (Art. 20)
- **Data residency / sovereignty** — laws requiring data to physically reside in or not leave a jurisdiction (Russia, China, India have strong versions; EU restricts transfers to "non-adequate" countries)

### Compliance Lifecycle

A practical sequence Security+ candidates should be able to articulate:

1. **Identify obligations** — what laws/regulations/contracts apply? (Done by [[Legal]] + [[GRC]].)
2. **Map obligations to controls** — which technical and administrative safeguards satisfy each requirement? Crosswalks are common ([[NIST 800-53]] ↔ ISO 27001 ↔ HIPAA ↔ PCI).
3. **Implement controls** — technical configurations, policies, training.
4. **Document** — policies, procedures, [[SOPs]], control narratives.
5. **Monitor** — continuous logging, [[SIEM]] alerting, control testing.
6. **Report** — internal dashboards and external attestations.
7. **Remediate** — close gaps before they become findings.
8. **Re-assess** — laws change (CPRA replaced CCPA, NIS2 updated NIS, etc.), so the cycle restarts.

### Roles & Responsibilities

| Role | Compliance responsibility |
|------|---------------------------|
| **Board / Audit committee** | Ultimate oversight; receives external audit results |
| **CEO/CFO** | Sign attestations under SOX; personally liable |
| **CISO** | Owns security control implementation and evidence |
| **Chief Compliance Officer / Chief Privacy Officer** | Owns regulatory mapping and reporting |
| **[[DPO]]** | Privacy compliance under GDPR specifically |
| **Internal audit** | Independent assurance to the board |
| **External auditor / QSA / 3PAO** | Independent third-party attestation |
| **Asset owner / data owner** | Classification, access decisions |
| **Custodian** | Day-to-day technical control operation |

### Evidence: What Auditors Actually Want

Compliance work translates to *evidence production*. Typical artifacts:

- **Policies and procedures** with version history and approval
- **Configuration screenshots/exports** (firewall rules, IAM policies, encryption settings)
- **Logs** — authentication events, privileged access, configuration changes, retained per regulatory minimum
- **Training records** — completion dates, scores, attestations
- **Risk assessments** and remediation tracking
- **Vulnerability scan reports** with remediation timestamps
- **Change tickets** with approvals
- **Penetration test reports** (annual or after major changes)
- **Vendor due diligence packets** ([[SOC 2]] reports, ISO certificates, BAAs, DPAs)
- **Incident response records** — ticket history, post-mortems

### CompTIA exam traps to watch

- **Compliance ≠ security.** A control can be compliant on paper and still fail in practice. The exam loves scenarios where a passed audit precedes a breach.
- **Frameworks vs. regulations.** [[NIST CSF]] is voluntary guidance; [[HIPAA]] is law. Both can apply simultaneously.
- **Attestation vs. certification.** [[SOC 2]] is an *attestation* (auditor opinion); [[ISO 27001]] is a *certification* (formal credential).
- **PCI DSS scope.** Only systems that store, process, or transmit cardholder data are in scope — segmentation is the primary scope-reduction tool.
- **GDPR fine ceiling** — up to **4% of global annual revenue or €20M, whichever is higher**.

## Related concepts

[[GDPR]] · [[HIPAA]] · [[PCI DSS]] · [[SOX]] · [[GLBA]] · [[FERPA]] · [[CCPA]] · [[NIST 800-53]] · [[NIST CSF]] · [[ISO 27001]] · [[SOC 2]] · [[FedRAMP]] · [[CMMC]] · [[Audits and Assessments]] · [[Risk Management]] · [[Data Roles and Responsibilities]] · [[DPO]] · [[PIA]] · [[Data Sovereignty]] · [[Right to be Forgotten]] · [[Privacy]] · [[GRC]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
