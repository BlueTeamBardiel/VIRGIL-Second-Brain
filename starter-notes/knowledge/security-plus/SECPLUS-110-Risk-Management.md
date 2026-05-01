---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 110
source: rewritten
---

# Risk Management
**The systematic process of identifying, evaluating, and controlling threats before they impact organizational operations.**

---

## Overview
Risk management forms the backbone of organizational security strategy by enabling companies to spot vulnerabilities and threats proactively rather than responding to disasters after they occur. As organizations scale upward, their attack surface expands proportionally—more systems, more users, more entry points—making structured [[Risk Management]] essential for survival. Understanding how to assess, classify, and mitigate risk is a core Security+ competency that separates reactive incident responders from strategic security professionals.

---

## Key Concepts

### Risk Assessment
**Analogy**: Think of a home inspector walking through a house before purchase—systematically checking the roof, foundation, wiring, and plumbing to identify what might fail and how costly repairs would be.

**Definition**: A formal evaluation process that identifies potential [[Threats]], determines their likelihood and impact, and prioritizes which risks deserve immediate attention.

| Assessment Type | Frequency | Trigger | Example |
|---|---|---|---|
| **Ad Hoc** | One-time | Specific project/event | [[Merger and Acquisition|M&A]] due diligence |
| **Project-Based** | Single occurrence | New technology deployment | Software installation risk evaluation |
| **Continuous/Ongoing** | Recurring | [[Change Management]] process | Every system change assessment |

### Threats and Vulnerabilities
**Analogy**: A threat is a person with a gun; a vulnerability is an unlocked door. The gun is useless without the open door, but the open door is dangerous with the threat present.

**Definition**: [[Threats]] represent potential harmful events (internal or external), while [[Vulnerabilities]] are weaknesses in systems, processes, or people that threats can exploit.

### Risk Qualification
**Analogy**: Like a triage nurse in an ER assigning patients to urgent care, critical, or routine—organizations must categorize risks by severity and impact.

**Definition**: The process of assigning measurable values to risk probability and consequence, enabling data-driven decision-making about resource allocation.

### Change Control Integration
**Analogy**: Before launching a new product, companies conduct safety testing. Similarly, before deploying any system change, risk assessment ensures you're not introducing new attack vectors.

**Definition**: [[Change Management]] processes mandate [[Risk Assessment]] as a mandatory checkpoint, ensuring every modification receives security evaluation before implementation.

---

## Exam Tips

### Question Type 1: Risk Assessment Timing
- *"An organization is deploying a new database system. When should risk assessment occur?"* → During the planning phase, before implementation (sometimes during vendor evaluation)
- **Trick**: Test-takers often confuse "after deployment" with proper risk management. Assessment happens BEFORE changes go live.

### Question Type 2: Internal vs. External Risks
- *"Which of the following represents an internal risk to the organization?"* → Disgruntled employee sabotage, inadequate access controls, poor patch management
- **Trick**: "External" doesn't always mean "from outside the firewall"—focus on the SOURCE of the threat actor instead.

### Question Type 3: Risk Assessment Frequency
- *"What type of risk assessment occurs with every change in the change control process?"* → Continuous/ongoing assessment
- **Trick**: Don't confuse "ad hoc" (one-time) with "change control risk assessment" (recurring for every change ticket).

---

## Common Mistakes

### Mistake 1: Confusing "Ad Hoc" with "Unplanned"
**Wrong**: "Ad hoc risk assessments are unstructured and happen randomly when incidents occur."
**Right**: "Ad hoc assessments are *planned, formal evaluations* triggered by specific one-time events (acquisition, new software) rather than recurring processes."
**Impact on Exam**: You might select "ongoing assessment" for a merger scenario when "ad hoc assessment" is the correct answer.

### Mistake 2: Treating Risk Assessment as One-Time Activity
**Wrong**: "We did a risk assessment last year, so we're secure now."
**Right**: Risk assessment is continuous in change-driven environments; new risks emerge with every system modification and threat landscape shift.
**Impact on Exam**: Questions about [[Change Management]] expect you to recognize that risk assessment repeats for EACH change, not annually.

### Mistake 3: Underestimating Internal Threats
**Wrong**: "Risk management focuses on external hackers and malware."
**Right**: Risk assessment must evaluate both external threats AND internal risks (insider threats, inadequate controls, human error).
**Impact on Exam**: Questions asking "what organizational risk" often include employee-based threats that test-takers overlook.

### Mistake 4: Separating Risk Assessment from Change Control
**Wrong**: "Risk assessment and change control are unrelated processes."
**Right**: [[Change Control]] REQUIRES risk assessment as a mandatory step before approving any change.
**Impact on Exam**: When a question describes a change scenario, expect the answer to involve risk evaluation as part of the approval workflow.

---

## Related Topics
- [[Change Management]]
- [[Threat Modeling]]
- [[Vulnerability Assessment]]
- [[Risk Mitigation]]
- [[Business Impact Analysis]]
- [[Merger and Acquisition Security]]
- [[Compliance and Regulatory Requirements]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*