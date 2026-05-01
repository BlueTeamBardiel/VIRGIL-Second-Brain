---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 115
source: rewritten
---

# Agreement Types
**Formal and informal documents that establish expectations, responsibilities, and performance standards between organizations.**

---

## Overview
When you rely on external vendors or partners to deliver services or collaborate on projects, you need written agreements to define what "success" looks like and what happens if expectations aren't met. These agreements protect both parties by creating a shared understanding of obligations, performance metrics, and confidentiality requirements. For Security+, understanding these document types helps you recognize which agreements address uptime guarantees versus which establish foundational partnership goals.

---

## Key Concepts

### Service Level Agreement (SLA)
**Analogy**: Think of an SLA like a warranty on your car—the manufacturer promises specific performance (reliability, response time for repairs), and if they fail to deliver, there are consequences. Similarly, an SLA promises specific service performance metrics.

**Definition**: A [[Service Level Agreement]] is a binding contract that specifies measurable performance standards a [[Third-Party Service Provider]] must maintain, including [[uptime]] guarantees, [[response time]] requirements, and remedies for breaches.

**Key SLA Components:**
| Component | Purpose |
|-----------|---------|
| [[Uptime Guarantee]] | Specifies minimum availability (e.g., 99.9%) |
| [[Maximum Downtime]] | Defines acceptable unscheduled outages |
| [[Response Time]] | Time vendor has to react to incidents |
| [[Resolution Time]] | Time to fully restore service |
| [[Penalties/Credits]] | Financial consequences for non-compliance |
| [[Escalation Procedures]] | How issues get elevated if not resolved |

**Example**: An [[Internet Service Provider]] (ISP) might commit to no more than 4 hours of unscheduled downtime monthly, dispatch a technician within 2 hours, and maintain spare equipment on-site for hardware failures.

---

### Memorandum of Understanding (MOU)
**Analogy**: An MOU is like friends deciding to start a band together—they discuss broad ideas ("we'll make rock music"), set general boundaries ("we keep rehearsals confidential"), but don't sign a detailed contract yet.

**Definition**: A [[Memorandum of Understanding]] is a preliminary, informal document outlining high-level goals and general intentions between two organizations without creating strict legal obligations.

**Characteristics:**
- Non-binding or loosely binding
- Establishes broad partnership objectives
- Often includes [[Confidentiality Statements]]
- Precedes more formal agreements
- Flexible and easily modified

---

### Memorandum of Agreement (MOA)
**Analogy**: An MOA is like that band now writing down who plays which instrument, what songs they'll perform, and what happens if someone misses rehearsals—more specific than casual chat, but still not as detailed as a full recording contract.

**Definition**: A [[Memorandum of Agreement]] is a formalized document that details specific responsibilities, deliverables, and procedures between organizations with partial to full legal enforceability.

**MOA vs MOU Progression:**
| Aspect | [[MOU]] | [[MOA]] |
|--------|---------|---------|
| Formality | Very Informal | Moderately Formal |
| Legal Binding | Minimal/Advisory | Partially/Fully Binding |
| Detail Level | Broad Goals | Specific Obligations |
| Typical Use | Partnership Exploration | Active Collaboration |
| Modification | Easy | Requires Formal Amendment |

---

### Master Service Agreement (MSA)
**Analogy**: An MSA is the foundational rulebook that governs all future games between two teams—it sets the general terms once, so individual projects don't each need their own full contract.

**Definition**: A [[Master Service Agreement]] is an overarching contract that establishes general terms, conditions, and legal frameworks governing future [[Service Agreements]] or [[Purchase Orders]] between parties.

---

## Exam Tips

### Question Type 1: Matching Agreement Type to Scenario
- *"Your organization is exploring a partnership with a cloud vendor. You want to establish broad goals and confidentiality before committing to details. Which document should you use?"* → [[Memorandum of Understanding]] (MOU)
- **Trick**: Don't confuse MOU (preliminary exploration) with MOA (active implementation). MOUs come first.

### Question Type 2: SLA Components
- *"Your contract with a hosting provider guarantees 99.95% uptime annually. If they fall below this, they credit your account 10% of monthly fees. What is the 10% credit called?"* → [[Service Credit]] or [[Penalty Clause]]
- **Trick**: SLAs must include measurable metrics AND remedies; without both, it's just a promise.

### Question Type 3: Legal Enforceability
- *"Which agreement type is typically non-binding and used as a starting point for future negotiations?"* → [[Memorandum of Understanding]] (MOU)
- **Trick**: "Non-binding" doesn't mean worthless—it creates obligations in good faith, just not legal ones.

---

## Common Mistakes

### Mistake 1: Treating MOU and MOA as Identical
**Wrong**: "An MOU and MOA are the same thing—both establish partnership goals."
**Right**: An [[MOU]] is preliminary and informal (loose expectations); an [[MOA]] is formal and detailed (specific obligations and likely binding).
**Impact on Exam**: You'll see scenarios asking which document to use at different partnership stages. If the scenario says "initial exploration before we know details," pick MOU. If it says "we're ready to commit to specific responsibilities," pick MOA.

### Mistake 2: Confusing SLA Guarantees with Penalties
**Wrong**: "An SLA that promises 99.9% uptime automatically means the vendor loses a contract if they miss it."
**Right**: An [[SLA]] specifies what happens if targets are missed (e.g., credits, refunds, termination rights), but the penalty mechanism must be explicitly written.
**Impact on Exam**: Questions may test whether you know an SLA without defined remedies is incomplete. A promise without consequences isn't enforceable.

### Mistake 3: Assuming All Agreements Are Legally Binding
**Wrong**: "Every formal-sounding agreement document is a legal contract."
**Right**: [[MOUs]] are often intentionally non-binding (exploratory); [[MOAs]] and [[SLAs]] typically have legal teeth, but intent varies by jurisdiction and language.
**Impact on Exam**: Scenario questions might hinge on whether an organization can sue over a breach. If the document is an MOU, the answer might be "limited recourse"; if it's an SLA, legal action is more viable.

### Mistake 4: Overlooking Escalation and Response Time in SLAs
**Wrong**: "The most important SLA metric is uptime percentage."
**Right**: [[Response Time]], [[Resolution Time]], and [[Escalation Procedures]] are equally critical because they define how quickly issues get fixed, not just how often outages occur.
**Impact on Exam**: You may see a scenario where 99.9% uptime sounds great, but 48-hour response times are unacceptable for the use case. Both metrics matter.

---

## Related Topics
- [[Service Level Objectives (SLO)]]
- [[Third-Party Risk Management]]
- [[Vendor Management]]
- [[Uptime and Availability]]
- [[Incident Response Procedures]]
- [[Legal and Compliance Requirements]]
- [[Contract Negotiation]]
- [[Security Baselines in Agreements]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]] | Agreement Types & Vendor Management*