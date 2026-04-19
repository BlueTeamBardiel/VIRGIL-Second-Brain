---
domain: "governance, risk, and compliance"
tags: [change-management, grc, security-controls, itil, configuration-management, compliance]
---
# Change Management

**Change management** is a formal, structured process for requesting, reviewing, approving, implementing, and documenting modifications to an organization's IT infrastructure, systems, software, and configurations. It is a foundational pillar of [[IT Service Management (ITIL)]] and is directly referenced in the **CompTIA Security+ SY0-701** exam as a critical [[Administrative Controls|administrative control]] that reduces operational risk and prevents unauthorized or poorly planned changes from causing outages, security gaps, or compliance violations. Without change management, even well-intentioned modifications can introduce [[Vulnerabilities|vulnerabilities]], break dependencies, or create untracked configuration drift.

---

## Overview

Change management exists because uncontrolled changes are one of the leading causes of IT outages and security incidents. Studies by industry groups like Gartner and the IT Process Institute have consistently found that 60–80% of unplanned downtime is directly caused by changes made without proper testing, approval, or rollback planning. In a security context, an unapproved firewall rule change, a rushed patch applied to a production system without testing, or a misconfigured cloud storage bucket created outside the standard provisioning process can all expose an organization to significant risk — both technical and regulatory.

Formally, change management traces its roots to the **IT Infrastructure Library (ITIL)**, a set of best-practice frameworks originally developed by the UK government in the 1980s. ITIL defines a change as "the addition, modification, or removal of anything that could have an effect on IT services." The framework distinguishes between types of changes, establishes a **Change Advisory Board (CAB)**, and requires every change to follow a lifecycle from initial request through post-implementation review. ISO/IEC 20000, the international standard for IT service management, similarly mandates formal change management procedures for certification.

In modern enterprises, change management is enforced through **IT Service Management (ITSM) platforms** such as ServiceNow, Jira Service Management, or BMC Remedy. These tools provide a digital workflow where changes are logged as tickets, routed for approval, tracked through implementation, and closed with documented outcomes. Integration with [[Configuration Management Database (CMDB)]] systems allows stakeholders to understand the blast radius of a proposed change — which services, servers, and users will be affected before the change is made.

From a cybersecurity standpoint, change management directly supports several security objectives. It creates an **audit trail** that satisfies compliance requirements under frameworks like [[PCI DSS]], [[HIPAA]], [[SOC 2]], and [[NIST SP 800-53]]. Control CM-3 in NIST 800-53, for example, explicitly requires organizations to determine the types of changes that are configuration-controlled, review and approve changes with explicit consideration of security and privacy impacts, and document approved changes. This audit trail is also invaluable during [[Incident Response]] — knowing exactly what changed, when, and by whom dramatically accelerates root cause analysis.

Change management also intersects with [[DevSecOps]] and [[CI/CD Pipeline Security]]. In agile and DevOps environments, traditional heavyweight change processes can become bottlenecks. Modern organizations often implement **lightweight change models** or automated approval pipelines for low-risk, pre-tested changes, while still requiring full CAB review for major or emergency changes. The key is that governance exists at every layer, even if the velocity differs.

---

## How It Works

### The Change Lifecycle

Change management follows a well-defined lifecycle. The exact terminology varies between frameworks (ITIL v3 vs. ITIL 4, for instance), but the core steps are consistent:

**1. Change Request (RFC — Request for Change)**
A stakeholder identifies a need for a change and submits a formal **Request for Change (RFC)**. This document captures:
- Description of the change and its business justification
- Systems, services, and users affected (the **scope**)
- Proposed implementation date and maintenance window
- **Rollback plan** — how to reverse the change if it fails
- Risk assessment (low, medium, high, critical)
- Testing steps and success criteria

In ServiceNow, an RFC is created as a Change Request ticket. In a homelab context, this could be a simple Git commit message with a linked issue, or a structured document in a wiki like Confluence.

**2. Change Assessment and Categorization**
Changes are classified by type:

| Type | Description | Approval Required |
|------|-------------|-------------------|
| **Standard** | Pre-approved, low-risk, routine (e.g., password reset, adding a user) | Pre-approved template |
| **Normal** | Non-emergency, goes through full review cycle | CAB approval |
| **Emergency** | Must be implemented immediately (active breach, critical outage) | Emergency CAB or single approver |
| **Major** | Large-scale, high-impact changes | Full CAB + executive sign-off |

**3. Change Advisory Board (CAB) Review**
The **CAB** is a committee of stakeholders — typically including IT operations, security, application owners, and business representatives — that reviews normal and major change requests. The CAB evaluates:
- Risk to availability, integrity, and confidentiality
- Resource requirements
- Scheduling conflicts with other changes or blackout windows
- Completeness of the rollback plan

In many organizations, a **Forward Schedule of Changes (FSC)** is published weekly, listing all approved upcoming changes so teams can coordinate.

**4. Change Approval or Rejection**
The CAB approves, rejects, or requests modifications to the RFC. Approval grants the implementer authority to execute the change within the defined maintenance window. Rejection requires the requester to address identified concerns and resubmit.

**5. Implementation**
The change is executed during the approved maintenance window. The implementer follows the documented steps exactly. Deviations from the approved plan are treated as a new unauthorized change and should trigger a new RFC or an emergency process.

**6. Testing and Validation**
After implementation, the change is tested against the defined success criteria. For a network change:

```bash
# Verify new firewall rule is active (Linux iptables example)
sudo iptables -L -n -v | grep 10.0.0.50

# Test connectivity post-change
ping -c 4 10.0.0.50
traceroute 10.0.0.50

# Confirm service availability
curl -I https://internal-app.example.com
```

For a Windows patch deployment:
```powershell
# Verify patch installation
Get-HotFix -Id KB5028185
# Check service status post-patch
Get-Service -Name "wuauserv" | Select-Object Status, StartType
```

**7. Change Closure and Post-Implementation Review (PIR)**
The change ticket is updated with the actual outcome — success, partial success, or rollback. A **Post-Implementation Review (PIR)** is conducted for major changes to evaluate whether the expected outcomes were achieved and to capture lessons learned.

### Blackout Windows and Freeze Periods
Organizations define **change freeze periods** — windows during which no changes are permitted — typically around:
- Major business events (fiscal year-end, product launches)
- Holiday periods (Thanksgiving through New Year is common)
- Audit periods

These are enforced through ITSM platform configuration that blocks change approvals during freeze windows.

### Emergency Change Process
Emergency changes bypass the standard CAB cycle but are not exempt from documentation. The typical emergency process:
1. Verbal or expedited approval from a designated emergency approver (e.g., CISO, CTO)
2. Implementation
3. **Retroactive documentation** within 24–48 hours
4. Post-incident review

Emergency changes that skip documentation are a major audit finding and a common source of persistent, untracked vulnerabilities.

---

## Key Concepts

- **Request for Change (RFC):** The formal document or ticket that initiates the change management process. Contains the change description, scope, risk assessment, rollback plan, and implementation steps. No RFC means no authorized change.

- **Change Advisory Board (CAB):** A cross-functional committee responsible for reviewing, approving, or rejecting normal and major change requests. The CAB ensures changes are evaluated from technical, security, and business perspectives before implementation.

- **Rollback Plan:** A documented, tested procedure for reverting a change to the previous known-good state if the implementation fails or causes unexpected problems. The absence of a rollback plan is a critical gap and should result in RFC rejection.

- **Maintenance Window:** A pre-approved, scheduled time period during which changes may be implemented, typically chosen to minimize impact on business operations (e.g., 2:00–5:00 AM Sunday). Changes implemented outside their approved window are treated as unauthorized.

- **Configuration Management Database (CMDB):** A repository that stores information about configuration items (CIs) — servers, applications, network devices — and their relationships. The CMDB enables impact assessment for proposed changes and is tightly integrated with the change management process. See [[Configuration Management Database (CMDB)]].

- **Forward Schedule of Changes (FSC):** A published calendar of all approved upcoming changes. Used by operations teams to prevent scheduling conflicts and to alert stakeholders of planned service impacts.

- **Change Freeze / Blackout Period:** A defined window during which changes to production systems are prohibited, typically around high-risk business periods or audit cycles.

- **Post-Implementation Review (PIR):** A formal review conducted after a major change is closed to assess whether objectives were met, identify problems encountered, and document lessons learned for future changes.

- **Unauthorized Change:** Any modification to IT infrastructure made without following the change management process. Unauthorized changes are a primary target in security audits and a common root cause in breach investigations.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Change management falls under **Domain 5.0 — Security Program Management and Oversight**, specifically under governance, risk management, and compliance concepts. It also appears in operational security contexts throughout the exam.

**Key exam themes for SY0-701:**

- **Change management as an administrative control:** Know that change management is categorized as an administrative/managerial control, not a technical one. It compensates for the risk of unauthorized or poorly implemented changes.

- **The approval process question type:** Scenario questions often describe a situation where a system was patched and broke, or a configuration was changed and a breach occurred. The correct answer almost always involves checking whether proper change management procedures were followed — RFC submission, CAB approval, rollback plan documentation.

- **Emergency vs. standard vs. normal changes:** Be able to categorize change types. The exam may describe a scenario and ask which change category applies. Remember: emergency changes still require retroactive documentation.

- **Rollback plans are not optional:** If a scenario mentions a change was approved without a rollback plan, that is the security finding. Rollback plans are non-negotiable for change approval.

- **Change management supports non-repudiation and accountability:** The audit trail created by change management supports [[Non-Repudiation]] — you can prove who approved and implemented a change, which is critical for forensic investigations.

- **Gotcha — "Unauthorized change" is distinct from "undocumented change":** The exam distinguishes between changes made without approval (unauthorized) and changes that were made but not documented after the fact (undocumented). Both are findings, but unauthorized changes represent the greater security violation.

- **Integration with configuration management:** Know that change management and [[Configuration Management]] are related but distinct. Change management governs the *process* of making changes; configuration management governs the *state* of systems. The CMDB is the tool that bridges both.

**Common wrong answers to avoid:**
- Selecting technical controls (firewalls, IDS) as the solution when the scenario is about process failures
- Confusing change management with [[Patch Management]] — patching is one *type* of change that goes through the change management process
- Assuming emergency changes don't need documentation — they always do, just retroactively

---

## Security Implications

### Unauthorized Changes as an Attack Vector
Attackers who gain privileged access to systems frequently make unauthorized changes to persist access, exfiltrate data, or degrade defenses. Without change management controls, these modifications may go undetected for extended periods. The **2020 SolarWinds Orion supply chain attack** is a landmark example: attackers modified the SolarWinds build system, injecting the SUNBURST backdoor into a legitimate software update. Because the modification occurred in the build pipeline — a system where change management was not rigorously applied — it bypassed traditional security controls and affected approximately 18,000 organizations before detection.

### Configuration Drift
When changes are made outside the formal process — even with good intentions — systems accumulate undocumented modifications that deviate from the approved baseline. This **configuration drift** creates hidden vulnerabilities. A firewall rule added informally "just for testing" and never removed can become a persistent exposure. [[CIS Benchmarks]] and [[NIST SP 800-128]] both emphasize that configuration drift is a primary source of exploitable weaknesses.

### Privilege Escalation Through Change Requests
Attackers with access to ITSM platforms may submit fraudulent RFCs to get malicious changes approved by unwitting reviewers. Social engineering attacks targeting CAB members or ITSM administrators have been observed in targeted intrusions. This attack vector highlights the importance of authenticating RFC submitters and using [[Multi-Factor Authentication (MFA)]] for ITSM platform access.

### Change-Induced Vulnerabilities
A famous example of a change-induced security failure: In 2017, **Equifax** was breached in part because a change to their SSL/TLS inspection infrastructure caused their [[Intrusion Detection System (IDS)]] to stop inspecting encrypted traffic for approximately 19 months. The failure was not caught because there was no robust change management process verifying that security controls remained functional after the change — a direct failure of post-implementation review.

### Insider Threat
Change management creates accountability that deters insider threats. Without an RFC and approval trail, a malicious insider can make unauthorized changes and claim ignorance. The audit trail in a properly functioning ITSM system creates **non-repudiation** for all changes.

---

## Defensive Measures

### Enforce RFC Requirements Technically
Configure ITSM platforms so that implementation steps (e.g., ticket closure) cannot be completed without mandatory fields — rollback plan, approver signature, implementation results. In ServiceNow, this is done through workflow state transition conditions.

### Integrate Change Management with CI/CD Pipelines
Use tools like **Jira + Jira Service Management**, **GitLab's built-in change management**, or **ServiceNow DevOps** to automatically create change records from pipeline deployments. Require change ticket references in commit messages:

```bash
# Enforce ticket reference in Git commits via pre-commit hook
# .git/hooks/commit-msg
#!/bin/bash
COMMIT_MSG=$(cat "$1")
if ! echo "$COMMIT_MSG" | grep -qE "^(CHG|INC|PRB)-[0-9]+"; then
    echo "ERROR: Commit message must reference a change ticket (e.g., CHG-12345)"
    exit 1
fi
```

### Implement File Integrity Monitoring (FIM)
Deploy [[File Integrity Monitoring (FIM)]] tools like **OSSEC**, **Wazuh**, **Tripwire**, or **AIDE** to detect unauthorized changes to critical files. Any FIM alert not correlated with an approved change ticket should trigger an incident investigation.

```bash
# AIDE (Advanced Intrusion Detection Environment) - initialize database
sudo aide --init
sudo mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
# Run a check
sudo aide --check
```

### Use a CMDB for Impact Analysis
Maintain an accurate CMDB (open-source option: **Ralph**, **NetBox** for network infrastructure) to ensure that change requestors can identify all affected systems before implementation. Require CMDB validation as part of RFC submission.

### Separate Duty Controls
Enforce [[Separation of Duties]] in the change management process: the person who requests a change should not be the sole approver, and ideally should not be the sole implementer. In AWS, use IAM policies that require a second human reviewer to approve infrastructure changes via AWS Config change records.

### Define and Enforce Blackout Windows
Program blackout periods into your ITSM platform. In ServiceNow, use the **Change Schedule** module to configure conflict detection that alerts when a change is scheduled during a freeze window.

### Regular Audits of Change Records
Schedule quarterly reviews of closed change tickets to identify:
- Changes closed without documented testing results
- Emergency changes that lacked retroactive documentation
- Patterns of the same person requesting and approving their own changes

---

## Lab / Hands-On

### Exercise 1: Build a Simple Change Management Workflow in Gitea + Markdown

If you're running **Gitea** in your homelab, you can simulate a lightweight change management system using issue templates and branch protection rules.

**Step 1: Create an RFC Issue Template**
```markdown
<!-- .gitea/issue_template/RFC.md -->
---
name