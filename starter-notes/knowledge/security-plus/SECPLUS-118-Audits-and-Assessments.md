---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 118
source: rewritten
---

# Audits and Assessments
**Security examinations serve as proactive checkpoints to discover vulnerabilities before threat actors do.**

---

## Overview
While "audit" might sound punitive, it's actually a defensive security practice that examines your entire IT ecosystem for compliance gaps and hidden weaknesses. For Security+, understanding the difference between internal and external audits, plus how they pair with attestation, separates candidates who understand governance from those who don't. Think of audits as your organization's annual health checkup—catching problems early prevents catastrophic breaches later.

---

## Key Concepts

### Internal Audits
**Analogy**: Like a store manager doing inventory before corporate headquarters visits—you're checking your own house first.
**Definition**: Examinations performed by personnel within your organization to verify [[compliance]], validate [[risk management]] controls, and ensure [[security policies]] are actually being followed.
- Can be self-directed or committee-managed
- Lower cost than third-party audits
- May lack objectivity but faster to conduct
- Often triggers remediation before external review

[[Audit Committee]] typically initiates and oversees internal audit scheduling.

---

### External Audits
**Analogy**: Like hiring a home inspector before selling—an unbiased third party validates what you claim about your security posture.
**Definition**: Independent reviews conducted by outside organizations to provide objective assessment of [[IT infrastructure]], [[security controls]], and compliance status.
- Third-party perspective eliminates internal bias
- Results carry more credibility with regulators
- More expensive and time-consuming
- Often required for regulatory compliance

---

### Attestation
**Analogy**: Like a notary's stamp on a legal document—it's a professional's sworn statement that the audit findings are accurate.
**Definition**: A formal declaration of truth or accuracy regarding audit results, typically issued by an [[auditor]] or third party after completing their examination.
- Follows the completion of an audit
- Provides official verification for stakeholders
- May be required by [[compliance frameworks]]
- Carries legal or professional liability

| Concept | Purpose | Who Issues | Timing |
|---------|---------|-----------|--------|
| [[Audit]] | Find problems | Internal/External staff | Ongoing/Scheduled |
| [[Attestation]] | Certify findings | Auditor or authority | After audit completes |

---

### Security Audit Scope
**Analogy**: Deciding what to include in a restaurant health inspection—you can check just the kitchen, or the entire operation.
**Definition**: The breadth and depth of systems, processes, and documentation examined during an audit engagement.

Typical audit examinations cover:
- [[Network architecture]] and device inventory
- [[Software assets]] and patch management status
- [[Access controls]] and privilege management
- Policy adherence and procedure documentation
- [[Vulnerability]] exposure and threat readiness

---

### Self-Assessment
**Analogy**: Like a student self-grading their own practice test before the real exam.
**Definition**: An internal preliminary review where an organization evaluates its own security posture against standards before a formal audit occurs.
- Identifies obvious gaps early
- Allows time for remediation
- Lower cost than formal audits
- Often precedes formal audits

---

### Audit Committee
**Analogy**: Like a board of directors for security—they approve missions, allocate resources, and review results.
**Definition**: Designated organizational group responsible for [[risk management]] decisions, audit approval, and oversight of compliance initiatives.
- Authorizes audit scope and timing
- Reviews findings and remediation
- Escalates critical issues to leadership
- Often includes representatives from IT, legal, finance

---

## Exam Tips

### Question Type 1: Audit vs. Attestation
- *"After your security team completes a comprehensive network review, what formal assurance would stakeholders receive?"* → **Attestation** (the verified statement of findings)
- *"Your organization wants to discover compliance gaps internally before external review. What should you conduct first?"* → **Self-assessment or internal audit**
- **Trick**: Don't confuse the *process* (audit) with the *verification* (attestation)—they're sequential, not interchangeable.

### Question Type 2: Internal vs. External Authority
- *"Which audit type is typically required by regulatory bodies like regulators?"* → **External audit** (independent verification required for compliance)
- *"Your [[audit committee]] wants faster feedback on control effectiveness at lower cost. What's the priority?"* → **Internal audit**
- **Trick**: External audits aren't always "better"—they're more objective but slower and costlier.

### Question Type 3: Audit Scope
- *"A security audit examines network infrastructure, software inventory, and access controls. What's missing from this scope?"* → Look for policy/procedure documentation or [[vulnerability assessment]] results
- **Trick**: Comprehensive audits touch *all* layers—not just technical systems.

---

## Common Mistakes

### Mistake 1: Thinking Audits Are Purely Punitive
**Wrong**: "We avoid audits because they only find problems and cause trouble."
**Right**: Audits are *preventive security investments*—they catch issues your competitors' attackers might exploit.
**Impact on Exam**: Questions test whether you understand audits as proactive security, not compliance theater. Expect scenarios rewarding early audit detection.

### Mistake 2: Confusing Audit with Attestation
**Wrong**: "After an audit, we issue an audit report and that's attestation."
**Right**: [[Attestation]] is a *separate formal declaration* of the audit's accuracy—it's what gives findings credibility.
**Impact on Exam**: Watch for questions where stakeholders need *verified proof*, not just audit documentation.

### Mistake 3: Assuming Internal Audits Equal External Audits
**Wrong**: "We do internal audits, so we don't need third-party audits."
**Right**: Internal audits catch obvious gaps; external audits provide [[compliance]] validation regulators demand.
**Impact on Exam**: Regulatory-focused questions almost always require external audit involvement.

### Mistake 4: Forgetting the [[Audit Committee]] Role
**Wrong**: "IT leadership runs audits whenever they want."
**Right**: The [[audit committee]] *authorizes, schedules, and oversees* audits—they control the process.
**Impact on Exam**: Governance questions often test whether you know the audit committee's authority.

### Mistake 5: Overlooking Self-Assessment Value
**Wrong**: "Self-assessments aren't real audits, so skip them."
**Right**: Self-assessments are *cost-effective early warning systems* that enable faster remediation before formal audits.
**Impact on Exam**: Look for scenarios rewarding organizations that self-assess regularly.

---

## Related Topics
- [[Compliance Frameworks]] ([[HIPAA]], [[PCI DSS]], [[SOC 2]])
- [[Risk Management]] and risk assessment processes
- [[Vulnerability Assessment]] and penetration testing
- [[Security Policies]] and governance
- [[Audit Committee]] structure and authority
- [[Attestation]] standards
- [[Internal Controls]] evaluation
- [[Third-Party Risk Management]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*