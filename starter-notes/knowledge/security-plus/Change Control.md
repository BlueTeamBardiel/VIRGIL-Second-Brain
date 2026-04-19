---
domain: "governance-risk-compliance"
tags: [change-management, itil, configuration-management, risk-management, compliance, security-operations]
---
# Change Control

**Change control** (also called **change management** in ITIL terminology) is a formal process governing how modifications to IT systems, infrastructure, software, and configurations are proposed, reviewed, approved, implemented, and documented. It exists to minimize the risk that unauthorized or poorly planned changes will introduce [[Vulnerabilities]], outages, or compliance violations. Change control is a foundational element of [[IT Service Management (ITSM)]] and is directly tied to concepts like [[Configuration Management]] and [[Patch Management]].

---

## Overview

Change control emerged from the recognition that a significant proportion of IT outages and security incidents are caused not by external attackers but by internal changes gone wrong — a misconfigured firewall rule, an untested software update, or an ad-hoc server modification made during a crisis. Studies by organizations such as Gartner and ITIL's parent body Axelos have long cited "change-related failures" as responsible for 60–80% of unplanned downtime in enterprise environments. By imposing structure around the change lifecycle, organizations reduce the blast radius of any single modification.

The ITIL framework (Information Technology Infrastructure Library), now on version 4, defines change control as one of its core practices. ITIL distinguishes between three categories of change: **standard changes** (pre-approved, low-risk, repeatable — e.g., adding a user account), **normal changes** (require full CAB review and approval — e.g., upgrading a database engine), and **emergency changes** (expedited process for critical situations — e.g., applying a zero-day patch). This tiered approach prevents the bureaucratic overhead of full review for every minor action while ensuring scrutiny is applied where risk is highest.

In regulated industries — healthcare (HIPAA), finance (SOX, PCI DSS), government (FISMA, FedRAMP) — change control is not merely a best practice but a compliance mandate. Auditors will request **change logs**, **change advisory board (CAB) minutes**, and evidence of **rollback procedures** as part of routine assessments. A missing change ticket for a system modification can constitute a finding, even if the modification itself was entirely benign. This compliance dimension gives change control significant legal and financial weight.

From a cybersecurity perspective, change control serves as a detective and preventive control. If a configuration drift is discovered on a server — say, a new service is running or a firewall rule has been added — a mature change control process allows security teams to immediately determine whether the change was authorized. If no corresponding change request (CR) exists, the anomaly is treated as a potential [[Unauthorized Access]] or [[Insider Threat]] event. This is the essential link between change control and [[Security Information and Event Management (SIEM)]] systems that monitor for configuration drift.

Change control also underpins **software development lifecycles (SDLC)**. In DevSecOps environments, change control manifests as pull request approvals, mandatory code review gates, branch protection rules, and automated pipeline checks before code reaches production. The underlying philosophy is identical to ITIL change control — no modification reaches a production environment without review, approval, and an audit trail — but the mechanisms are version-control-native rather than ticket-based.

---

## How It Works

### The Change Request Lifecycle

Change control follows a defined lifecycle from inception to closure. The specifics vary by organization and framework, but the core stages are consistent:

**1. Initiation — Submitting a Change Request (CR)**

A requester submits a change request, typically through an ITSM platform (ServiceNow, Jira Service Management, Remedy). The CR must contain:
- Description of the change and its business justification
- Systems and services affected (CIs — Configuration Items — from the [[CMDB]])
- Risk assessment (impact and likelihood)
- Implementation plan with step-by-step instructions
- Test plan
- Backout/rollback plan
- Proposed maintenance window

**2. Review and Risk Assessment**

A change manager or change coordinator reviews the CR for completeness. Risk is assessed using a matrix:

| Risk Level | Criteria | CAB Required? |
|---|---|---|
| Low / Standard | Pre-approved template, minimal impact | No |
| Medium / Normal | Moderate impact, tested in non-prod | Yes — full CAB |
| High / Emergency | Critical outage or security threat | Yes — emergency CAB |

**3. Change Advisory Board (CAB) Review**

For normal and emergency changes, the CAB convenes. The CAB typically includes:
- Change manager (chair)
- IT operations representatives
- Application owners
- Security team representative
- Business stakeholders for high-impact changes

The CAB votes to approve, reject, or request more information. All decisions are documented.

**4. Scheduling and Communication**

Approved changes are scheduled into a **maintenance window**, often during off-peak hours (e.g., 02:00–04:00 Saturday). Stakeholders are notified via email or automated ITSM notifications. The **Forward Schedule of Change (FSC)** is updated — a calendar all teams reference to avoid conflicts.

**5. Implementation**

The implementer executes the change according to the approved plan. Best practices include:

```bash
# Example: Document every command run during implementation
# Log to a timestamped file for audit trail
script -a /var/log/change-CR12345-$(date +%Y%m%d-%H%M%S).log

# Verify system state before change
systemctl status nginx
ss -tlnp | grep :443
sha256sum /etc/nginx/nginx.conf

# Apply the change
sudo apt-get install --only-upgrade nginx

# Verify system state after change
systemctl status nginx
nginx -t
```

**6. Post-Implementation Review (PIR)**

After implementation, the implementer confirms success or failure and updates the CR ticket. If the change fails, the rollback plan is executed immediately. A PIR meeting is held for significant changes to capture lessons learned.

**7. Closure**

The change manager closes the CR, archives all documentation, and updates the CMDB with the new configuration state.

### Emergency Change Process

Emergency changes bypass the standard CAB timeline. An emergency CAB (eCAB) — often just 2-3 key approvers via phone or chat — convenes within hours. Documentation is completed *after* implementation (post-implementation documentation) to avoid dangerous delays. All emergency changes receive enhanced scrutiny in their PIR to prevent "emergency" becoming a routine workaround for the standard process.

### Integration with Configuration Management

Change control integrates tightly with the [[Configuration Management Database (CMDB)]]. Every approved change updates CI records. Unauthorized changes detected via [[Configuration Management]] tools (Puppet, Chef, Ansible) or [[File Integrity Monitoring (FIM)]] (AIDE, Tripwire) that lack corresponding CRs trigger security alerts.

```bash
# Example: AIDE file integrity check detecting unauthorized change
aide --check
# Output showing unexpected modification:
# changed: /etc/ssh/sshd_config
# Attributes changed: p.b.m.c.sha256

# Security team cross-references with ITSM — no CR found — incident opened
```

---

## Key Concepts

- **Change Request (CR):** The formal document or ticket that captures all details of a proposed change, including justification, risk assessment, implementation plan, test plan, and rollback procedure. No change to a production system should occur without an approved CR.

- **Change Advisory Board (CAB):** A cross-functional governance body that reviews and approves normal and high-risk changes. The CAB ensures that changes receive multi-stakeholder scrutiny and that their organizational impact is fully understood before approval.

- **Forward Schedule of Change (FSC):** A calendar or register of all approved upcoming changes, their maintenance windows, and affected systems. Used to prevent conflicting changes from occurring simultaneously and to communicate planned downtime to stakeholders.

- **Configuration Item (CI):** Any component of the IT infrastructure that is tracked and managed — servers, network devices, applications, virtual machines, firewall rule sets. CIs are stored in the CMDB and their state is updated with every approved change.

- **Rollback Plan:** A pre-approved, documented procedure to revert a system to its previous state if a change fails or causes unexpected problems. Mandatory for all normal and emergency changes; a change without a viable rollback plan should not be approved.

- **Maintenance Window:** A scheduled period (often nights or weekends) during which changes are implemented to minimize impact on business operations. Windows are published in the FSC and communicated to stakeholders in advance.

- **Configuration Drift:** The gradual deviation of a system's actual configuration from its documented, authorized baseline. Drift can result from unauthorized changes, failed rollbacks, or manual "firefighting" interventions, and is a key security risk that change control aims to prevent.

- **Post-Implementation Review (PIR):** A formal review conducted after a change is closed to assess whether it achieved its objectives, whether there were unexpected impacts, and what lessons can be applied to future changes.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping:** Change control appears primarily under **Domain 5.0 — Security Program Management and Oversight**, specifically within risk management, compliance, and operational security topics.

**Key exam angles:**

- **Change control as a preventive control:** Questions may ask which control prevents unauthorized modifications to production systems. Change control/change management is the answer, not just patch management.

- **Emergency vs. Standard vs. Normal changes:** Know the three ITIL categories. Exam questions often describe a scenario and ask which type of change is being described. An emergency change is reactive and expedited; a standard change is pre-approved and routine; a normal change requires full CAB review.

- **CAB composition and purpose:** Understand that the CAB is a *governance* body, not an implementation team. Its role is review and approval, not execution.

- **Separation of duties in change control:** The person who requests a change should not be the sole approver. This is a classic [[Separation of Duties]] question that intersects with change control.

- **Rollback and documentation:** Exam questions may emphasize that a change with no rollback plan is a risk management failure, not just a procedural one.

- **Change control and incident response:** Know the relationship — if an incident is traced to an unauthorized change (no CR), that is both a security incident AND a change control failure.

**Common gotchas:**
- Do not confuse **change control** (IT governance process) with **version control** (software development tool like Git). They are related but distinct.
- "Change management" in ITIL context means the same thing as "change control" — the SY0-701 exam may use either term.
- Emergency changes still require authorization — they are expedited, not uncontrolled.

---

## Security Implications

### Unauthorized Changes as an Attack Vector

One of the most dangerous aspects of poor change control is that attackers who gain privileged access to systems can make changes that persist undetected if no baseline exists to compare against. The 2020 **SolarWinds SUNBURST** attack is a definitive example: malicious code was injected into the Orion software build process. A mature change control process with integrity verification of build artifacts would have flagged the unauthorized modification to the build pipeline, though the sophistication of the attack was specifically designed to bypass such controls by compromising the change process itself.

**Configuration changes as lateral movement:** Attackers with administrative access often modify firewall rules, add user accounts, install backdoor services, or alter sudoers files. Without change control and [[File Integrity Monitoring (FIM)]], these modifications may go undetected for weeks or months — consistent with the industry average dwell time of 200+ days before breach detection.

### Insider Threat Vector

Malicious insiders exploit weak change control by making unauthorized changes during off-hours, exploiting emergency change exemptions, or using personal privileged accounts rather than shared service accounts (which would be more visible). A 2016 incident at a major financial institution involved a database administrator using an undocumented "emergency" access procedure to exfiltrate data while ostensibly performing maintenance — the lack of real-time change verification enabled the attack.

### Supply Chain Risk

Change control weaknesses in vendor environments propagate downstream. If a software vendor does not control changes to their build environment (as in SolarWinds), customers cannot independently verify the integrity of delivered software. This is why modern frameworks like **SLSA (Supply chain Levels for Software Artifacts)** and **NIST SP 800-161** emphasize change control requirements extending to supply chain partners.

### CVE Context

**CVE-2021-44228 (Log4Shell):** The chaotic emergency response to Log4Shell revealed change control gaps in thousands of organizations. Systems running Log4j were not properly tracked in CMDBs, meaning organizations could not quickly determine which systems needed patching. Organizations with mature change control and accurate CMDBs completed their response in hours; those without struggled for weeks.

---

## Defensive Measures

**1. Implement a Formal ITSM Platform**
Deploy ServiceNow, Jira Service Management, or open-source alternatives like GLPI or iTop. Configure mandatory fields for all change requests — no CR closes without a rollback plan, test plan, and post-implementation sign-off.

**2. Enforce CMDB Accuracy**
Integrate your CMDB with discovery tools (ServiceNow Discovery, Lansweeper, Netbox) to automatically detect new CIs. Establish a process to update CI records every time a change CR is closed. An inaccurate CMDB is worse than no CMDB because it creates false confidence.

**3. Deploy File Integrity Monitoring (FIM)**
Tools like **Tripwire**, **AIDE**, **Wazuh**, or **Qualys FIM** detect unauthorized file and configuration changes in real time. All FIM alerts should be correlated against open change tickets in the ITSM platform.

```bash
# AIDE initial database creation (run after verified good state)
sudo aide --init
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Schedule daily checks
echo "0 6 * * * root /usr/bin/aide --check >> /var/log/aide/aide-check.log 2>&1" \
  >> /etc/cron.d/aide-check
```

**4. Implement Infrastructure as Code (IaC) with Mandatory Review Gates**
Use Terraform, Ansible, or Puppet with Git-based workflows. Enforce branch protection rules requiring pull request approval before merging to production branches. This gives you an immutable audit trail of every infrastructure change.

```yaml
# GitHub branch protection rule (via API or UI)
# Require pull request reviews before merging
# Required approving reviews: 2
# Require status checks to pass before merging
# Restrict pushes that create matching branches
```

**5. Segregate Change Roles**
Enforce [[Separation of Duties]]: requesters cannot approve their own changes. Implementers should not also be change managers. Use RBAC in your ITSM platform to enforce this technically, not just through policy.

**6. Configure SIEM Alerting for Change Correlation**
Ingest ITSM change data into your [[SIEM]]. Create correlation rules that alert when a privileged action (user creation, firewall rule modification, service installation) occurs outside an approved change window or without a matching open CR.

**7. Regular Change Process Audits**
Quarterly, audit a random sample of implemented changes: Did they have approved CRs? Were rollback plans present? Were PIRs completed? Report findings to leadership. Trend this metric over time.

---

## Lab / Hands-On

### Lab 1: GLPI Open-Source ITSM Change Management

Deploy GLPI (free ITSM platform) in your homelab to practice real change management workflows.

```bash
# Deploy GLPI via Docker
docker run -d \
  --name glpi \
  -p 8080:80 \
  -e MARIADB_HOST=glpi-db \
  -e MARIADB_DATABASE=glpi \
  -e MARIADB_USER=glpi \
  -e MARIADB_PASSWORD=glpipass \
  --link glpi-db:glpi-db \
  diouxx/glpi

# Access at http://localhost:8080
# Navigate to: Changes > Create Change
# Practice creating Standard, Normal, and Emergency change requests
```

### Lab 2: AIDE File Integrity Monitoring with Change Correlation

```bash
# Install AIDE on Ubuntu/Debian
sudo apt install aide -y

# Configure AIDE to monitor critical paths
sudo nano /etc/aide/aide.conf
# Add custom rules:
# /etc/ssh    PERMS+SHA256+CONTENT
# /etc/nginx  PERMS+SHA256+CONTENT
# /etc/cron.d PERMS+SHA256+CONTENT

# Initialize baseline database
sudo aideinit
sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Simulate