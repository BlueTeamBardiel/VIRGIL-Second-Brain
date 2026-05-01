---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 107
source: rewritten
---

# Security Procedures
**Implementing structured workflows and approval processes to minimize risk when modifying organizational systems.**

---

## Overview
Security procedures form the backbone of how organizations safely implement changes and integrate personnel into their infrastructure. For the Security+ exam, understanding formal change management and onboarding workflows demonstrates your grasp of [[Risk Management]] and operational security controls that prevent costly mistakes, system downtime, and security vulnerabilities.

---

## Key Concepts

### Change Management
**Analogy**: Think of change management like the blueprint review process before construction—you don't start building without checking plans, getting permits, and having a way to stop mid-project if problems emerge.

**Definition**: A structured set of controls and procedures executed every time a modification occurs on any organizational system, creating safeguards through deliberate planning, approval gates, and rollback capabilities.

**Related terms**: [[Change Control Board]], [[Risk Assessment]], [[Configuration Management]], [[Downtime Prevention]]

#### Change Management Process Steps

| Step | Purpose | Owner |
|------|---------|-------|
| **Scope Definition** | Identify what systems/files are affected (single server vs. enterprise-wide) | Change Requester |
| **Risk Evaluation** | Assess impact level and blast radius of the change | Security/IT Team |
| **Formal Planning** | Document exactly what will be modified and how | Change Manager |
| **Approval Submission** | Route change request through governance | Change Requester |
| **CCB Review** | Formal evaluation against organizational standards | Change Control Board |
| **Backout Planning** | Design rollback procedure before implementation | Technical Team |
| **Implementation** | Execute the approved change in controlled manner | Operations |
| **Documentation** | Record what was actually changed for compliance | Change Manager |

---

### Change Control Board (CCB)
**Analogy**: A CCB operates like a quality control checkpoint on an assembly line—nothing leaves the factory without multiple inspections, sign-offs, and a plan for recalls.

**Definition**: A cross-functional governance body responsible for evaluating proposed changes against organizational risk tolerance, business impact, and technical feasibility before authorizing implementation.

**Key responsibilities**:
- Analyze risk/benefit of each proposed change
- Schedule changes during appropriate maintenance windows
- Verify [[Backout Plan]] existence
- Approve or reject requests with documented reasoning
- Track change history and outcomes

---

### Backout Plan
**Analogy**: A backout plan is your parachute—you don't jump from a plane without verifying it works and knowing how to deploy it if needed.

**Definition**: A pre-designed, tested procedure to restore systems to their previous operational state if a change produces unintended consequences or failures.

**Essential elements**:
- Step-by-step rollback instructions
- Estimated time to restore service
- Resource/personnel requirements
- Communication protocols
- Testing validation before "go-live"

---

### Onboarding
**Analogy**: Like orienting a new employee on your first day of work—you need credentials, security training, access assignments, and someone checking you have everything before you start.

**Definition**: The structured process of integrating new personnel (hires or transfers) into an organization by provisioning accounts, granting appropriate [[Access Control|access]], delivering security training, and documenting their identity in organizational systems.

**Core onboarding components**:
- Account creation across all required systems
- [[Principle of Least Privilege]] access assignment
- Security awareness training delivery
- Equipment issuance (laptops, badges, credentials)
- Manager briefing and role clarification
- Baseline compliance verification

---

## Exam Tips

### Question Type 1: Change Management Workflow
- *"A database administrator requests permission to upgrade a production SQL server. Which step must occur BEFORE implementation?"* → **Change Control Board approval and backout plan validation** (not IT manager's verbal okay)
- **Trick**: The exam often shows informal approval (email from supervisor) as a decoy—you need the formal CCB process

### Question Type 2: Risk Assessment in Changes
- *"Your organization plans to patch a critical vulnerability across 200 workstations. What is the PRIMARY concern in scope planning?"* → **Understanding whether the patch affects all systems equally or has cascading dependencies** (not just patch size)
- **Trick**: "Urgent security patches" still require CCB approval—urgency doesn't bypass governance

### Question Type 3: Onboarding Security
- *"A new contractor joins your team but won't need access for 2 weeks. When should onboarding security procedures begin?"* → **Immediately upon hire notification, with access provisioning timed for start date** (not delayed until their first day)
- **Trick**: Questions conflate "onboarding timing" with "access activation timing"—they're separate

### Question Type 4: Backout Plan Scenarios
- *"During a firewall rule deployment, services fail. The backout plan calls for manual restoration taking 4 hours. What should have been verified BEFORE implementation?"* → **Backout plan execution and estimated restoration time within acceptable RTO** (not just existence of the plan)
- **Trick**: A written backout plan that's never tested is worthless

---

## Common Mistakes

### Mistake 1: Confusing "Change Request" with "Change Approval"
**Wrong**: A change request submitted to the IT help desk automatically means approval has been granted.
**Right**: Change requests undergo CCB evaluation; approval requires documented authorization from the board.
**Impact on Exam**: Questions about "who approves changes" will trick you if you skip the CCB step.

---

### Mistake 2: Treating Urgent Changes Differently
**Wrong**: Critical security patches don't need CCB approval—they bypass normal change procedures due to urgency.
**Right**: Even emergency changes follow formal procedures; the CCB may expedite review but still governs the process.
**Impact on Exam**: You'll see scenarios where "emergency" is presented as justification for skipping steps—resist this.

---

### Mistake 3: Viewing Onboarding as Only IT-Focused
**Wrong**: Onboarding is primarily about account provisioning and equipment setup.
**Right**: Onboarding includes [[Access Control]] assignment by role, [[Security Awareness Training]], policy briefing, and compliance baseline verification by multiple departments.
**Impact on Exam**: Questions test whether you understand security's role in onboarding beyond just "giving them a laptop."

---

### Mistake 4: Backout Plan as Documentation Only
**Wrong**: A backout plan is considered complete once written and filed away.
**Right**: Backout plans must be tested, have realistic rollback timeframes, and be understood by operations staff before any change goes live.
**Impact on Exam**: Expect scenarios asking what's missing when a change fails—the answer is often "the backout plan wasn't tested."

---

### Mistake 5: Scope Creep in Change Requests
**Wrong**: A change request's scope is naturally limited, so you don't need to explicitly define boundaries.
**Right**: Scope must be explicitly documented—what systems, files, versions, and dependencies are affected, and what's intentionally excluded.
**Impact on Exam**: Questions will describe vague change requests and ask what's missing before CCB review.

---

## Related Topics
- [[Risk Management]]
- [[Access Control]]
- [[Principle of Least Privilege]]
- [[Configuration Management]]
- [[Incident Response]]
- [[Security Awareness Training]]
- [[Compliance and Governance]]
- [[Business Continuity Planning]]
- [[Asset Management]]

---

*Source: Rewritten from Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*