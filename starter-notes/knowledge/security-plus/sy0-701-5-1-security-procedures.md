```yaml
---
domain: "5.0 - Security Program Management and Oversight"
section: "5.1"
tags: [security-plus, sy0-701, domain-5, change-management, procedures, governance]
---
```

# 5.1 - Security Procedures

Security procedures form the backbone of organizational security governance, establishing formal processes for managing change, onboarding/offboarding personnel, maintaining playbooks for incident response, and implementing governance structures. This section is critical for the Security+ exam because it tests your understanding of how enterprises operationalize security at scale—not just deploying tools, but managing the human and organizational factors that determine whether security succeeds or fails. Mastering these procedures demonstrates that you understand security is a program, not a one-time project.

---

## Key Concepts

### Change Management & Change Control
- **Change Management**: The broader philosophy of how to safely introduce modifications to infrastructure, software, or configurations (upgrades, firewall rule changes, port modifications).
- **Change Control**: The formal documented process that governs all changes—including scope determination, risk analysis, planning, approval workflows, backout plans, and documentation.
- **Change Control Board (CCB)**: The governance body responsible for reviewing, approving, and tracking all proposed changes.
- **Risk Assessment in Change**: Every change carries risk; the process must identify and mitigate those risks *before* implementation.
- **Backout Plan**: A documented rollback procedure if the change causes unexpected problems.
- **Critical Detail**: Change management is one of the most frequently overlooked yet common risks in enterprise environments.

### Onboarding
- **Definition**: The formal process of integrating new employees or transfers into the organization with full IT provisioning.
- **Components**:
  - Signing IT agreements (may be part of employee handbook or separate [[Acceptable Use Policy (AUP)]]).
  - Creating user accounts and associating them with proper groups and departments.
  - Provisioning preconfigured hardware (laptops, tablets, mobile devices).
  - Assigning appropriate access rights and permissions.
- **Security Gate**: Ensures new users cannot access systems before proper vetting and agreements are in place.

### Offboarding
- **Definition**: The process of revoking access and recovering company assets when an employee leaves, is terminated, or transfers.
- **Key Decisions**:
  - What happens to hardware (return, wipe, repurpose, destroy)?
  - What happens to data (archive, delete, transfer, audit)?
  - Account status (deactivate vs. delete—often deactivated but not deleted for audit trail purposes).
- **Critical**: Must be pre-planned rather than ad-hoc to avoid data loss, unauthorized access, or compliance violations.

### Playbooks
- **Definition**: Conditional, step-by-step procedures for responding to specific security scenarios.
- **Characteristics**:
  - Broad process documentation (e.g., data breach investigation, ransomware recovery).
  - Manual checklist format that can be automated.
  - Often integrated with [[SOAR]] (Security Orchestration, Automation, and Response) platforms.
- **Value**: Enables consistency across response teams and allows third-party tool integration for more effective incident handling.

### Monitoring and Revision
- **Continuous Process**: Security posture must be regularly updated as threats evolve.
- **Triggers for Change**:
  - New security concerns or emerging threats.
  - Changes to organizational risk appetite or compliance requirements.
  - Individual procedure updates (tighter [[Change Control]], additional validation steps).
  - Lessons learned from incidents or near-misses.

### Governance Structures
- **Boards**: Panels of specialists responsible for gathering and synthesizing information for committees; typically advisory.
- **Committees**: Subject-matter expert groups that consider board input, make decisions on specific topics, and report findings back to the board.
- **Government Entities**: Unique governance model with legal constraints, administrative requirements, and political oversight; often subject to public scrutiny.
- **Centralized vs. Decentralized**:
  - **Centralized**: Single location with one group of decision makers; consistent policy application but potentially slower response.
  - **Decentralized**: Decision-making distributed across multiple locations or individuals; faster local decisions but potential inconsistency.

---

## How It Works (Feynman Analogy)

**The Restaurant Kitchen Analogy:**

Imagine a restaurant kitchen with 50 chefs. Without procedures, chaos ensues—chefs change recipes without telling others, new hires don't know where ingredients are stored, fired chefs leave their keys behind, and when a health inspector shows up, no one knows who prepared which dish.

Now add *procedures*:
- **Change Management**: Before any chef modifies a recipe, they propose it to the head chef, who evaluates how it affects other dishes. If approved, the head chef documents it, trains the team, and keeps the old recipe until everyone confirms the new one works.
- **Onboarding**: Every new chef reads a handbook, gets keys and equipment, is assigned a station, and works under supervision until certified.
- **Offboarding**: When a chef leaves, keys are collected, their recipes are archived, and their station is cleaned and reassigned.
- **Playbooks**: The kitchen has laminated cards for "How to Handle a Fire" or "What to Do if We Run Out of Chicken"—everyone knows the steps.
- **Governance**: A head chef (board) gathers input; sous chefs (committee) decide if recipes change; the head chef approves or rejects.

**Technical Reality**: Organizations are like that kitchen. Without [[Change Control]], a single misconfigured firewall rule (the new recipe) breaks authentication for 1,000 users. Without onboarding, a new admin gets overprivileged credentials and becomes a breach vector. Without offboarding, a departed employee's account remains active and is abused by an attacker. Playbooks ensure your [[incident response]] team doesn't panic and miss critical steps during a [[ransomware]] attack. Governance ensures decisions are documented and defensible during audits or litigation.

---

## Exam Tips

- **Change Management vs. Change Control**: The exam may ask you to distinguish between these. Remember: *Management* is the philosophy (how to approach change safely); *Control* is the formal process (the actual steps, board, documentation). Change *Control* is a subset of change *Management*.

- **Change Control Board Authority**: Expect questions on who approves changes. The CCB must review *all* changes (no shortcuts) and have a documented reason for approval or rejection. This is a common exam scenario.

- **Backout Plan**: Often tested as a scenario question. If a change goes wrong at 3 AM, what's the fallback? A solid answer mentions pre-tested rollback procedures, not just "we'll figure it out."

- **Playbooks vs. Policies**: Playbooks are tactical, step-by-step procedures. Policies are higher-level rules. An exam question might present a scenario and ask which is missing. Example: "We have a policy that data breaches must be reported within 24 hours, but our team doesn't know *how* to investigate"—you need a *playbook*.

- **Onboarding/Offboarding Governance**: The exam tests whether you understand that these aren't IT tasks alone—they require [[AUP]] agreements, manager sign-off, and often HR coordination. Offboarding especially: account deactivation (not deletion) is often the right answer because it preserves audit trails.

---

## Common Mistakes

- **Forgetting the "Pre-planned" Aspect of Offboarding**: Candidates often answer offboarding questions as if it's reactive. The exam emphasizes *planning ahead*—you determine what happens to hardware and data *before* someone leaves, not after. This prevents data loss and legal exposure.

- **Conflating Playbooks with Policies**: Playbooks are executable checklists; policies are governance statements. Saying "we have a policy for incident response" doesn't help if the response team doesn't have a step-by-step playbook. The exam rewards nuance here.

- **Underestimating Change Management Risk**: Candidates sometimes treat change management as a bureaucratic box to check. In reality, it's one of the most common attack vectors and failure points. A poorly executed change can cause outages, security gaps, or data loss. The exam tests whether you *internalize* that change is risky and requires discipline.

---

## Real-World Application

In Morpheus's [[[YOUR-LAB]]] homelab, security procedures translate directly: onboarding new lab users requires provisioning [[Active Directory]] accounts with proper group membership and [[Tailscale]] access; offboarding means disabling those accounts and auditing what data they accessed in [[Wazuh]]. Change management governs updates to [[Wazuh]] rules, [[Pi-hole]] DNS configurations, and [[Tailscale]] network policies—any misconfiguration could blind your SIEM or break network connectivity. Playbooks guide the incident response process when [[Wazuh]] alerts on suspicious [[Metasploit]] activity: steps include isolation, evidence collection via [[DFIR]] tools, and escalation. As Morpheus scales the homelab or manages it for others, governance structures (who approves changes, who reviews alerts) become critical to maintaining both security and compliance.

---

## [[Wiki Links]]

### Core Processes
- [[Change Management]]
- [[Change Control]]
- [[Change Control Board (CCB)]]
- [[Onboarding]]
- [[Offboarding]]
- [[Acceptable Use Policy (AUP)]]

### Procedures & Automation
- [[Playbooks]]
- [[SOAR]] (Security Orchestration, Automation, and Response)
- [[Incident Response]]
- [[Playbook Automation]]

### Governance & Oversight
- [[Governance Structures]]
- [[Boards]]
- [[Committees]]
- [[Centralized Governance]]
- [[Decentralized Governance]]

### Related Security Domains
- [[CIA Triad]]
- [[Risk Management]]
- [[Compliance]]
- [[Audit]]
- [[NIST]]

### Incident Response & Detection
- [[Incident Response]]
- [[DFIR]] (Digital Forensics and Incident Response)
- [[Forensics]]
- [[Malware]]
- [[Ransomware]]
- [[SIEM]]
- [[Wazuh]]
- [[Splunk]]

### Tools & Technologies
- [[Active Directory]]
- [[LDAP]]
- [[Tailscale]]
- [[VPN]]
- [[Firewall]]
- [[DNS]]
- [[Pi-hole]]
- [[Nmap]]
- [[Metasploit]]
- [[Wireshark]]
- [[Kali Linux]]

### Attack Vectors & Threats
- [[Phishing]]
- [[SQL Injection]]
- [[XSS]] (Cross-Site Scripting)
- [[Buffer Overflow]]
- [[MITRE ATT&CK]]

### Frameworks & Standards
- [[NIST]]
- [[Zero Trust]]

---

## Tags

`domain-5` `security-plus` `sy0-701` `change-management` `governance` `incident-response` `onboarding-offboarding` `playbooks` `procedures`

---

## Study Checklist for 5.1

- [ ] Understand the difference between change *management* (philosophy) and change *control* (process).
- [ ] Memorize the steps of the change control process: scope → risk analysis → plan → approval → implementation → backout plan → documentation.
- [ ] Know what goes into an onboarding checklist: agreements, account creation, group assignment, hardware provisioning.
- [ ] Know what goes into an offboarding checklist: hardware recovery, data handling, account deactivation (not deletion), access revocation.
- [ ] Understand playbooks as executable checklists integrated with [[SOAR]] for automation.
- [ ] Distinguish centralized vs. decentralized governance and when each is appropriate.
- [ ] Practice scenario questions: "An employee was terminated Friday but still has VPN access Monday. What failed?" (Answer: offboarding procedure).
- [ ] Practice scenario questions: "A junior admin wants to patch the production firewall. What's the correct process?" (Answer: [[Change Control]] Board review, backout plan, change window).

---

**Last Updated**: 2025 | **Exam Focus**: Domain 5.0 (Security Program Management) | **Confidence Level**: High-yield topic for SY0-701

---
_Ingested: 2026-04-16 00:24 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
