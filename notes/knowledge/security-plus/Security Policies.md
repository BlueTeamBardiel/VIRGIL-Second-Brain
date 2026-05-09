# Security Policies

## What it is

In Apex Legends, before you drop into Kings Canyon you accept the rules: no third-party software, no teaming in solo modes, report cheaters, and Respawn can ban you for violations. Those rules existed before you queued up — they define what "playing" means and what gets you removed. That's exactly what **security policies** do — they are the written rules an organization sets *before* anyone touches a system, defining acceptable behavior and the consequences of breaking it.

A **security policy** is a formal, management-approved document that establishes an organization's security objectives, mandates specific behaviors and controls, and assigns accountability for protecting information assets.

## Why it matters

Without documented policies, you cannot enforce, audit, or prosecute. Auditors fail you, regulators fine you, and a fired employee sues for wrongful termination because "nobody told me I couldn't email the customer database to my Gmail." Policies are the legal and operational foundation that turns vague intent into enforceable action.

**Exam angle:** SY0-701 Objective 5.1 lists policies explicitly — AUP, Information Security, Business Continuity, Disaster Recovery, Incident Response, SDLC, Change Management. CompTIA's favorite trap is making you distinguish **policy** (what/why, mandatory, high-level) from **standard** (specific requirements), **procedure** (step-by-step), and **guideline** (recommended, optional). If the question says "step-by-step instructions," it is *not* a policy.

## Key facts

### The policy hierarchy

| Document | Purpose | Mandatory? | Example |
|---|---|---|---|
| [[Policy]] | What and why | Yes | "All data must be encrypted at rest" |
| [[Standard]] | Specific requirements | Yes | "Use AES-256" |
| [[Procedure]] | Step-by-step how | Yes | "Run `cryptsetup luksFormat`..." |
| [[Guideline]] | Recommended best practice | No | "Consider rotating keys quarterly" |

### Policies named in SY0-701 Objective 5.1

- **[[Acceptable Use Policy]] (AUP)** — Defines permitted use of company assets (laptops, email, internet). The document HR waves at you when someone gets caught streaming on the corporate network.
- **[[Information Security Policy]]** — The umbrella document declaring the org's overall security posture, scope, and management commitment. Usually signed by the CEO or CISO.
- **[[Business Continuity]] (BC) Policy** — How the business keeps operating during disruption. Focuses on **business processes**.
- **[[Disaster Recovery]] (DR) Policy** — How **IT systems** specifically get restored after a disaster. BC's technical sibling. Includes [[RTO]] and [[RPO]] targets.
- **[[Incident Response Policy]]** — Defines what an incident is, who responds, and the phases: Preparation → Identification → Containment → Eradication → Recovery → Lessons Learned.
- **[[Software Development Lifecycle]] (SDLC) Policy** — Mandates secure coding, code review, and testing requirements throughout development. Often paired with [[DevSecOps]].
- **[[Change Management]] Policy** — Requires that modifications to production are reviewed, approved, tested, documented, and reversible. Stops the "I just pushed it to prod on Friday at 5pm" disaster.

### Supporting governance documents you should also recognize

- **[[Password Policy]]** — Complexity, length, rotation, history, lockout thresholds.
- **[[Data Classification]] Policy** — Public, Internal, Confidential, Restricted.
- **[[BYOD]] Policy** — Rules for personal devices on corporate networks.
- **[[Onboarding and Offboarding]] Policies** — Account provisioning and the much more critical *deprovisioning*.

### Properties of a good policy

- **Approved** by senior management (gives it teeth)
- **Reviewed** at least annually or after significant change
- **Communicated** via [[Security Awareness Training]] — unread policy is unenforceable policy
- **Acknowledged** with signed user attestation
- **Enforceable** with defined consequences

### Common exam traps

- A "policy" that contains command-line steps is actually a **procedure**.
- BCP ≠ DRP. BC keeps the *business* running; DR restores the *IT*.
- AUP is for **users**; Information Security Policy is the **organizational** umbrella.
- Change Management is about **process control**, not patch management — though patches go through it.

## Related concepts

[[Governance Risk and Compliance]] · [[Security Awareness Training]] · [[Standard Operating Procedure]] · [[Separation of Duties]] · [[Least Privilege]] · [[Data Classification]] · [[Risk Management]] · [[Compliance Frameworks]]

---
*Source: VIRGIL knowledge base — 2026-05-08*