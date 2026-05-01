---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 112
source: rewritten
---

# Risk Management Strategies
**Organizations employ multiple tactical approaches to handle identified risks within their security posture.**

---

## Overview
Every organization faces security risks that cannot be completely eliminated. Rather than attempting to neutralize every threat, security leaders must choose strategic methods to manage these risks effectively. Understanding the four primary risk management strategies is essential for Security+ exam success, as questions frequently test your ability to distinguish when each approach is most appropriate.

---

## Key Concepts

### Risk Transfer
**Analogy**: Imagine owning a house in a hurricane zone. Rather than building an indestructible fortress yourself, you buy insurance and let the insurance company absorb the financial impact if disaster strikes.

**Definition**: [[Risk transfer]] involves shifting responsibility for a potential threat to a third party, typically through contractual agreements or insurance policies.

| Characteristic | Details |
|---|---|
| Primary Method | [[Cyber insurance]], outsourcing security functions, vendor contracts |
| Cost | Usually involves premiums or service fees |
| Liability Shift | Moves financial responsibility to external party |
| Best For | High-impact, low-probability events |

---

### Risk Acceptance
**Analogy**: Like a restaurant owner accepting that some food waste is inevitable—you acknowledge the problem exists, calculate its cost, and decide it's cheaper to tolerate it than prevent it completely.

**Definition**: [[Risk acceptance]] occurs when an organization acknowledges a risk exists and deliberately chooses to live with it rather than implement expensive controls.

| Aspect | Details |
|---|---|
| Common Situation | Most frequently chosen strategy in practice |
| Decision Factor | Cost of mitigation exceeds potential loss |
| Management Role | Leadership formally approves the risk |
| Documentation | Must be recorded and tracked |

---

### Risk Acceptance with Exemptions
**Analogy**: A school has a "no phones in classrooms" policy, but the drama teacher needs one for emergency productions—so they get a documented exception slip.

**Definition**: [[Risk exemption]] allows an organization to accept risk while formally excluding specific systems, departments, or circumstances from standard security policies.

**Common Scenario**: A manufacturing facility purchases specialized equipment running legacy Windows that the manufacturer prohibits from receiving [[patch management|patches]]. Despite the organization's policy requiring all devices receive monthly Microsoft updates within 30 days, management approves an exemption—provided the equipment remains air-gapped from the network.

| Element | Example |
|---|---|
| Policy Requirement | All systems patched within 30 days |
| Conflicting Situation | Equipment manufacturer forbids OS patching |
| Solution | Documented exemption approval |
| Compensating Control | Device isolated from network |

---

### Risk Acceptance with Exceptions
**Analogy**: A hospital has a "surgery within 24 hours" rule, but if the patient needs additional testing, they temporarily extend that deadline for that specific case.

**Definition**: [[Risk exception]] permits temporary or targeted deviations from security policy when circumstances prevent full compliance, acknowledged with formal approval.

**Common Scenario**: An organization requires all patches deployed within 3 days of release. During testing, the monthly patch set causes a critical business application to crash. Management approves a temporary exception to delay deployment until the vendor releases a hotfix, accepting the interim vulnerability.

| Distinction | Exemption | Exception |
|---|---|---|
| Duration | Ongoing/permanent | Temporary/case-by-case |
| Scope | Specific systems/departments | Specific incidents/time periods |
| Documentation | Standing approval | Individual request approvals |

---

## Exam Tips

### Question Type 1: Identifying the Strategy
- *"Your organization purchases cyber liability insurance to cover potential breach costs. What risk strategy is this?"* → Risk transfer. The insurance company now bears the financial impact.
- **Trick**: Don't confuse transfer with mitigation—transfer means moving responsibility, not reducing the threat itself.

### Question Type 2: Exemption vs. Exception
- *"A legacy system cannot receive security patches per manufacturer specifications. What approach allows continued operation?"* → Risk exemption with compensating controls (like network isolation).
- **Trick**: Exemptions are usually permanent for specific assets; exceptions handle temporary compliance gaps.

### Question Type 3: Acceptance Scenarios
- *"Management decides the cost of implementing full disk encryption is $500,000 annually, but potential data loss is estimated at $100,000. They choose not to implement it. What occurred?"* → Risk acceptance—they formally acknowledged and accepted the risk.
- **Trick**: Acceptance requires management decision and documentation; passive ignorance is not acceptance.

---

## Common Mistakes

### Mistake 1: Confusing Transfer with Mitigation
**Wrong**: "We bought insurance, so our risk is mitigated."
**Right**: Transfer shifts financial responsibility; the threat still exists. [[Risk mitigation]] reduces the actual likelihood or impact of the threat.
**Impact on Exam**: You'll lose points distinguishing between the four strategies if you blur these definitions.

### Mistake 2: Treating Exemptions as Permanent Loopholes
**Wrong**: A system gets one exemption, so it never needs compliance again.
**Right**: Exemptions require periodic review, compensating controls, and management re-approval.
**Impact on Exam**: Scenario questions test whether you understand exemptions must be actively managed, not just granted forever.

### Mistake 3: Assuming Acceptance Means No Documentation
**Wrong**: "The company accepts this risk, so we don't need to track it."
**Right**: Accepted risks must be formally documented, including who approved it, the risk level, and monitoring plans.
**Impact on Exam**: Risk acceptance questions emphasize that organizational leadership must formally acknowledge and sign off on accepted risks.

### Mistake 4: Mixing Exception Timing
**Wrong**: Using an "exception" for a permanent hardware limitation.
**Right**: Exceptions handle temporary situations; permanent non-compliance requires an exemption.
**Impact on Exam**: The exam tests your precision—these terms have specific meanings in risk frameworks.

---

## Related Topics
- [[Risk Assessment]]
- [[Risk Mitigation]]
- [[Patch Management]]
- [[Cyber Insurance]]
- [[Compliance Exceptions]]
- [[Risk Register]]
- [[Compensating Controls]]
- [[Security Policy]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*