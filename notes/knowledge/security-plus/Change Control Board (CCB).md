---
domain: "Governance, Risk, and Compliance"
tags: [change-management, governance, risk-management, compliance, itil, security-controls]
---
# Change Control Board (CCB)

A **Change Control Board (CCB)** is a formally constituted group of stakeholders responsible for reviewing, evaluating, approving, or rejecting proposed changes to an organization's IT systems, infrastructure, software, or security configurations. Also called a **Change Advisory Board (CAB)** in [[ITIL]] frameworks, the CCB serves as the authoritative decision-making body within the [[Change Management]] process, ensuring that modifications are introduced in a controlled, risk-assessed manner. The CCB is a foundational element of [[IT Governance]] and is directly referenced in frameworks such as [[NIST SP 800-53]], [[ISO 27001]], and [[CMMI]].

---

## Overview

The Change Control Board exists because uncontrolled changes to IT infrastructure represent one of the most significant sources of outages, security vulnerabilities, and compliance failures in modern organizations. When system administrators, developers, or engineers make ad hoc changes without review, they may inadvertently introduce configuration errors, open firewall ports, weaken cryptographic settings, or create dependency conflicts that cascade into service disruptions. A CCB provides the formal oversight mechanism to prevent this class of failure.

In practice, the CCB is a committee composed of representatives from multiple organizational functions. A typical CCB might include the Chief Information Security Officer (CISO) or a security representative, IT operations leads, system owners, application developers, compliance officers, and business unit stakeholders. The exact composition varies by organization size and industry vertical. In a small organization, the CCB might be two or three people meeting weekly; in a large enterprise or government contractor, the CCB may be a formal weekly or bi-weekly meeting with dozens of attendees, documented minutes, and regulatory audit trails.

The CCB process is not merely bureaucratic ceremony — it has measurable security value. The 2003 Northeast Blackout, while not a cybersecurity incident, was partly attributed to software defects that would have been caught by rigorous change review. In the cybersecurity domain, the 2010 Stuxnet attack exploited the gap between sanctioned operational states and actual system configuration. Unauthorized or poorly reviewed changes create exactly the kind of configuration drift that attackers exploit. The CCB is the primary control that keeps operational environments aligned with their intended, security-reviewed baseline.

Most enterprise change management processes distinguish between different categories of change. **Standard changes** are pre-approved, low-risk, routine tasks (e.g., applying a vendor-approved patch to a non-critical system). **Normal changes** require full CCB review and follow the complete request, assessment, approval, implementation, and review cycle. **Emergency changes** bypass the standard scheduling cycle due to urgency — such as patching an actively exploited zero-day — but still require retroactive CCB review and documentation. This tiered categorization prevents the CCB from becoming a bottleneck while maintaining accountability.

The CCB also plays a critical role in maintaining the **Configuration Management Database (CMDB)**, which tracks the current and historical state of all configuration items (CIs) within the organization. Every approved change should result in an update to the CMDB, creating an auditable record of what was changed, who authorized it, and when it was implemented. This linkage between change control and configuration management is foundational to both operational stability and security compliance.

---

## How It Works

The CCB process follows a structured lifecycle. Below is a detailed walkthrough of the standard change control workflow as implemented in typical enterprise environments.

### Step 1: Change Request Submission (RFC)

A **Request for Change (RFC)** is submitted by the change initiator — a developer, sysadmin, security analyst, or vendor — through a ticketing system such as ServiceNow, Jira Service Management, or Remedy. The RFC must include:

- **Description of the change** — What exactly will be modified (firewall rule, software version, configuration parameter, etc.)
- **Business justification** — Why the change is necessary
- **Risk assessment** — Potential impact if the change fails or introduces a vulnerability
- **Rollback plan** — Documented steps to revert if the change causes issues
- **Implementation window** — Proposed maintenance window with date and time
- **Testing evidence** — Results from dev/test environment validation

```
RFC #: CHG-2024-0447
Title: Update OpenSSL to 3.0.9 on prod-web-01 through prod-web-12
Requestor: jsmith@corp.local
Date Submitted: 2024-11-10
Priority: High
Category: Security Patch
Affected CIs: prod-web-01, prod-web-02, ..., prod-web-12
Business Impact: Addresses CVE-2023-5363 (CVSS 7.5)
Risk: Low — vendor patch tested in staging for 7 days
Rollback: Revert to OpenSSL 3.0.7 via package manager snapshot
Implementation Window: 2024-11-16, 02:00–04:00 UTC
```

### Step 2: Initial Triage and Categorization

Before CCB review, a **Change Manager** or designated coordinator reviews the RFC for completeness, categorizes it (standard, normal, or emergency), and assigns a priority level. Incomplete RFCs are returned to the submitter.

### Step 3: Technical and Security Review

Subject matter experts perform a pre-CCB assessment:

- **Security team** reviews for potential attack surface changes (new open ports, weakened cipher suites, privilege escalation risks)
- **Network team** reviews for routing or firewall impacts
- **Application team** reviews for dependency and compatibility issues

For security changes, this may include running vulnerability scans against the proposed configuration in a test environment:

```bash
# Verify the patched OpenSSL version in staging
openssl version -a
# Output: OpenSSL 3.0.9 19 Sep 2023

# Run Nessus scan against staging server post-patch
nessus-cli scan --target staging-web-01 --policy "Web Application Security"

# Check TLS configuration after update
nmap --script ssl-enum-ciphers -p 443 staging-web-01.corp.local

# Verify no regressions in cipher strength
testssl.sh https://staging-web-01.corp.local
```

### Step 4: CCB Meeting and Decision

The CCB convenes (in-person, video call, or asynchronous collaboration) and reviews the RFC along with the technical assessment. Possible outcomes:

| Decision | Meaning |
|---|---|
| **Approved** | Change proceeds as submitted |
| **Approved with Conditions** | Change approved with modifications or additional controls required |
| **Deferred** | Change needs more information or testing; resubmit |
| **Rejected** | Change is denied — risk outweighs benefit, or better alternatives exist |

All decisions are recorded in the ticketing system with rationale. Board members' votes or consensus positions are documented for audit purposes.

### Step 5: Implementation

Approved changes are implemented during the authorized maintenance window. Change implementers follow the documented procedure step-by-step:

```bash
# Example: Controlled OpenSSL patch deployment with validation
# Run on each server via Ansible playbook

ansible-playbook -i production_inventory patch_openssl.yml \
  --extra-vars "target_version=3.0.9" \
  --check  # dry run first

# After dry run validation, execute:
ansible-playbook -i production_inventory patch_openssl.yml \
  --extra-vars "target_version=3.0.9"

# Post-implementation validation
ansible -i production_inventory prod-web -m command \
  -a "openssl version"
```

### Step 6: Post-Implementation Review (PIR)

After the change, the implementer documents actual results versus expected results, confirms the rollback plan was not needed (or documents if it was triggered), and closes the ticket. The CCB reviews PIR data at the next meeting, and CMDB records are updated.

### Step 7: Audit Trail Preservation

All documentation — RFC, technical reviews, CCB decision, implementation log, PIR — is retained in accordance with organizational retention policies and regulatory requirements (often 3–7 years under frameworks like [[PCI-DSS]] and [[HIPAA]]).

---

## Key Concepts

- **Request for Change (RFC):** The formal document initiating the change control process. Contains all required information for CCB evaluation including scope, risk, rollback procedures, and testing evidence. No change should proceed without an approved RFC.

- **Configuration Management Database (CMDB):** A repository tracking all configuration items (CIs) — servers, applications, network devices, certificates — and their relationships. The CCB ensures all approved changes are reflected in the CMDB, maintaining an accurate, auditable picture of the IT environment.

- **Change Advisory Board (CAB):** The ITIL-specific term for what many organizations call the CCB. In ITIL 4, the CAB is a group that supports the change authority in assessing, prioritizing, and scheduling changes. The terms are often used interchangeably in exam contexts.

- **Emergency Change:** A change that must bypass normal scheduling due to critical urgency — typically a response to an active exploit, zero-day, or major outage. Emergency changes require expedited (often out-of-band) CCB or change authority approval and mandatory retroactive review.

- **Rollback Plan:** A documented, tested procedure for reverting a change if it produces unexpected negative outcomes. The CCB will typically reject RFCs that lack a credible rollback plan, as it indicates insufficient risk analysis.

- **Change Freeze:** A period during which no non-emergency changes are permitted. Common during high-risk business periods (fiscal year-end, major product launches, holiday retail seasons). The CCB enforces change freezes as a risk mitigation strategy.

- **Configuration Drift:** The gradual divergence between a system's documented, approved baseline and its actual current state. Often caused by unauthorized or improperly documented changes. The CCB process is the primary control preventing configuration drift.

---

## Exam Relevance

The CCB and change management process appear consistently in the SY0-701 exam under **Domain 1: General Security Concepts** and **Domain 5: Security Program Management and Oversight**.

**Key exam facts to memorize:**

- The CCB is the body that **approves or rejects** changes. The exam will test whether you know that changes require formal approval *before* implementation (not after).
- **Emergency changes** still require documentation and review — they are not exempt from the change management process, only expedited. This is a common distractor.
- The CCB connects directly to **least privilege** and **separation of duties** — the person who requests a change should not be the same person who approves it.
- Change management is a **preventive control** — it prevents unauthorized or destabilizing changes from entering production environments.
- The exam may present a scenario where an admin bypasses the CCB "just this once" for a critical fix. The correct answer involves following the emergency change process rather than acting unilaterally.
- Know the difference between **change management** (process for controlling changes) and **configuration management** (tracking the state of systems). They are related but distinct.
- The CCB supports **integrity** in the CIA triad by ensuring only authorized modifications are made to systems.

**Common question patterns:**

- "A sysadmin needs to patch a critical zero-day immediately. What should they do?" → Follow the **emergency change process**, not bypass the CCB entirely.
- "What is the purpose of a change control board?" → To evaluate and approve/reject proposed changes before implementation.
- "Which document initiates the formal change management process?" → **Request for Change (RFC)**.

---

## Security Implications

Weaknesses in the CCB process create significant attack surface and operational risk:

**Unauthorized Change as an Attack Vector:** Attackers who gain elevated access often make changes to persist in an environment — adding accounts, modifying firewall rules, installing backdoors. Without a functioning CCB and integrity monitoring, these changes may go undetected for extended periods. The **SolarWinds SUNBURST** incident (2020) involved attackers modifying legitimate software builds — a change that no CCB reviewed because it occurred in the attacker-compromised build pipeline, illustrating the limits of CCB controls and the need for complementary [[File Integrity Monitoring (FIM)]] and [[Supply Chain Security]] controls.

**Insider Threat via CCB Manipulation:** A malicious insider with CCB participation authority could approve changes that introduce vulnerabilities or weaken security controls. This is why **separation of duties** requires that high-risk changes have multi-stakeholder approval and why external audits of CCB records are important.

**Change Fatigue and Rubber-Stamping:** In organizations with very high change volume, CCB members may approve changes without rigorous review — a phenomenon called "rubber-stamping." This organizational weakness has contributed to outages and security incidents. The 2021 Facebook outage (configuration change causing BGP route withdrawal) occurred in an environment where a change to the backbone routers propagated without adequate review catching the cascading impact.

**Stale CMDB Data:** If the CMDB is not updated with every approved change, it becomes unreliable. Security teams relying on stale CMDB data for vulnerability management or incident response may miss affected systems or incorrectly scope their response. An inaccurate CMDB is a direct consequence of CCB process failures.

**CVE-Adjacent Risk:** While there is no CVE assigned to "CCB failures" (process failures aren't assigned CVEs), many CVE exploitation post-mortems reveal that the vulnerable software version was running in production far longer than it should have been because the patch went through an inefficient or backlogged CCB process. CCB efficiency is therefore directly correlated with Mean Time to Remediate (MTTR) for known vulnerabilities.

---

## Defensive Measures

**Establish Clear CCB Charter and Authority:** Document the CCB's mandate, membership, decision authority, quorum requirements, and meeting cadence in a formal policy. Ambiguous authority leads to ad hoc decisions that bypass the process.

**Implement a Tiered Change Classification System:**
```
Standard Changes:  Pre-approved, low risk, templated (auto-approve in ITSM tool)
Normal Changes:    Full RFC + CCB review required (weekly CAB meeting)
Emergency Changes: Expedited approval path + mandatory PIR within 5 business days
```

**Enforce RFC Completeness Gates in ITSM Tools:** Configure ServiceNow, Jira, or Remedy to require mandatory fields — risk rating, rollback plan, test evidence — before an RFC can be submitted to the CCB queue. Prevent incomplete tickets from reaching the board.

**Integrate Change Management with CI/CD Pipelines:**
```yaml
# Example: GitHub Actions workflow requiring change ticket validation
- name: Validate Change Ticket
  run: |
    TICKET=$(git log -1 --pretty=%B | grep -oP 'CHG-\d+')
    if [ -z "$TICKET" ]; then
      echo "ERROR: No approved change ticket in commit message"
      exit 1
    fi
    # Call ITSM API to verify ticket is in 'Approved' state
    STATUS=$(curl -s "https://itsm.corp.local/api/changes/$TICKET" \
      -H "Authorization: Bearer $ITSM_TOKEN" | jq -r '.status')
    if [ "$STATUS" != "Approved" ]; then
      echo "ERROR: Change ticket $TICKET is not in Approved state (Status: $STATUS)"
      exit 1
    fi
```

**Link Change Management to FIM and SIEM:** Deploy [[File Integrity Monitoring (FIM)]] tools (Tripwire, OSSEC, Wazuh) and correlate alerts with approved changes. Any file system or configuration change that does not correspond to an approved RFC should generate a security alert.

```bash
# Wazuh rule example: Alert on filesystem change without matching change ticket
# In /var/ossec/rules/local_rules.xml
<rule id="100200" level="10">
  <if_matched_sid>550</if_matched_sid>  <!-- FIM modification event -->
  <description>File modification detected without approved change ticket</description>
  <group>change_management,integrity_violation</group>
</rule>
```

**Regular CCB Process Audits:** Quarterly, audit a random sample of implemented changes to verify: RFC was approved before implementation, implementation matched the approved scope, CMDB was updated, and PIR was completed. Report metrics to CISO and IT leadership.

**Mandatory CCB Training:** All personnel who submit, review, or implement changes should complete annual training on the change management process, risk assessment methodology, and emergency change procedures.

---

## Lab / Hands-On

Build a functional change management workflow in your homelab using open-source tools:

### Option 1: osTicket as a Lightweight ITSM for RFCs

```bash
# Deploy osTicket with Docker
docker run -d \
  --name osticket \
  -p 8080:80