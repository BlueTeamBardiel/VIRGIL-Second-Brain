---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 62
source: rewritten
---

# Change Management
**The structured framework that prevents chaos when modifying IT infrastructure.**

---

## Overview

In IT environments, modifications to systems, software, and networks happen constantly—from monthly [[Windows]] patches to [[firewall]] rule updates. Without a formal process governing these changes, you risk catastrophic failures: unplanned [[downtime]], network outages, and organizational disruption. Change management exists to balance necessary updates with system stability by implementing controlled procedures that minimize risk and allow for quick recovery if something breaks.

---

## Key Concepts

### Change Management Process

**Analogy**: Think of change management like a pharmaceutical approval process. You wouldn't just inject a new drug into patients without testing, documentation, and a rollback plan if side effects appear. Similarly, IT changes need documentation, testing windows, approval steps, and an escape hatch.

**Definition**: A structured methodology that governs how modifications are proposed, approved, implemented, and validated before they go live in production environments. This includes scheduling windows, implementation procedures, rollback procedures, and post-implementation verification.

Key elements include:
- [[RFC (Request for Change)]] submission and approval
- [[Change window]] scheduling
- Implementation timeline and duration
- [[Rollback procedures]] for failure scenarios
- Testing and validation checkpoints

### Uncontrolled Change Environment

**Analogy**: Imagine a kitchen where every cook can add whatever ingredients they want whenever they want without telling anyone. Dishes would become unpredictable, ingredients would clash, and nobody would know what went wrong.

**Definition**: An organizational state where staff members implement modifications without authorization, documentation, or coordination—creating unpredictable system behavior and making troubleshooting nearly impossible.

**Consequences**:
| Issue | Impact |
|-------|--------|
| Undocumented changes | Impossible to audit or troubleshoot |
| Conflicting modifications | Systems fail unexpectedly |
| No rollback plan | Extended [[downtime]] |
| Compliance violations | Security and regulatory problems |

### Change Window

**Analogy**: Like scheduling surgery during off-hours when the hospital has fewer patients, a change window is the designated time slot when modifications won't impact active users.

**Definition**: A pre-approved time period—typically nights, weekends, or planned maintenance windows—when system changes are deployed to minimize user disruption and [[downtime]].

### Rollback Procedure

**Analogy**: Like having a fire extinguisher nearby when you cook—it's insurance that if something goes wrong, you can quickly return to the known-good state.

**Definition**: Documented steps to restore systems to their previous working configuration if the implemented change causes problems or unexpected behavior.

---

## Exam Tips

### Question Type 1: Identifying Change Management Elements
- *"A technician updated the company's DNS settings without filing a ticket or notifying the network team. What process was violated?"* → [[Change Management Process]]; specifically the lack of documentation, approval, and notification procedures.
- **Trick**: The exam tests whether you understand that bypassing procedures—even for "quick fixes"—violates change management. Speed is never an excuse.

### Question Type 2: Rollback Scenarios
- *"After a software patch was deployed, critical systems began crashing. What should happen next?"* → Execute the documented [[rollback procedure]] to restore the previous version immediately.
- **Trick**: Don't confuse troubleshooting with rolling back. If you have a tested rollback plan, execute it immediately—troubleshooting can happen later on non-production systems.

### Question Type 3: Change Window Planning
- *"When should server maintenance changes be scheduled?"* → During a [[change window]]—typically off-hours when production usage is minimal (nights, weekends, or planned maintenance periods).
- **Trick**: The question might suggest "whenever it's convenient" or "during business hours if urgent." Neither is correct without formal change management approval. Even emergencies follow abbreviated procedures, not ad-hoc deployment.

---

## Common Mistakes

### Mistake 1: Treating Emergency Changes Differently
**Wrong**: Emergency situations require skipping documentation and approval steps to respond quickly.
**Right**: Emergency changes still follow the [[Change Management Process]]—they just use an expedited approval track rather than the standard 2-week review cycle. Documentation and rollback plans remain mandatory.
**Impact on Exam**: A+ tests whether you understand that change management is *always* required, not situational.

### Mistake 2: Confusing Change Management with Troubleshooting
**Wrong**: If a change breaks something, start investigating the root cause and applying fixes.
**Right**: If a change breaks something, immediately execute the [[rollback procedure]] to restore stability, then troubleshoot the issue on non-production systems.
**Impact on Exam**: The exam rewards defensive thinking—stop the bleeding first, diagnose later.

### Mistake 3: Assuming Individual IT Staff Can Approve Their Own Changes
**Wrong**: Technicians can implement changes to systems under their responsibility without additional approval.
**Right**: All changes—regardless of who makes them—require formal [[RFC (Request for Change)]] submission and approval from change management (often a Change Advisory Board or CAB).
**Impact on Exam**: This separates "checking your work" (good) from "independent authorization" (required).

### Mistake 4: Overlooking Documentation as Optional
**Wrong**: Small changes like updating a single setting don't require documentation if the technician remembers what they did.
**Right**: Every change requires documentation: what changed, who approved it, when it was implemented, and how to roll it back. Memory is not an acceptable record.
**Impact on Exam**: 220-1202 expects you to understand that documentation is non-negotiable for auditing, compliance, and troubleshooting.

---

## Related Topics
- [[RFC (Request for Change)]]
- [[Downtime]] and [[Availability]]
- [[System Maintenance Windows]]
- [[Rollback Procedure]]
- [[Change Advisory Board (CAB)]]
- [[IT Governance]]
- [[Patch Management]]
- [[Configuration Management]]

---

*Source: Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]]*