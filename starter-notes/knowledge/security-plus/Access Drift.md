---
domain: "Identity and Access Management"
tags: [access-control, privilege-management, identity, least-privilege, compliance, iam]
---
# Access Drift

**Access drift** (also called **privilege creep** or **permission creep**) is the gradual accumulation of [[Access Rights]] and [[Permissions]] beyond what a user, account, or system requires to perform its current role. Over time, as personnel change roles, complete projects, or receive temporary elevated access that is never revoked, the effective permissions of an identity diverge significantly from the [[Principle of Least Privilege]]. Left unchecked, access drift creates substantial attack surface and is a primary enabler of [[Insider Threat]] and [[Lateral Movement]] by adversaries.

---

## Overview

Access drift emerges from the natural lifecycle of users and systems within an organization. When an employee is hired, they are granted permissions appropriate to their initial role. As they rotate through teams, take on special projects, receive temporary administrative access to complete tasks, or simply accumulate resources over years of employment, their permission set grows. The critical failure is that organizations routinely grant new access without revoking old access, creating a continuously expanding footprint of entitlements that no longer reflects operational need.

This phenomenon is not limited to human users. Service accounts, application identities, and machine credentials suffer from the same lifecycle failures. A service account created for a one-time data migration may retain read/write access to production databases years after the migration completed. Container workloads may inherit broad IAM roles created during rapid development cycles. Cloud infrastructure provisioned with permissive Identity and Access Management (IAM) policies during a prototype phase often carries those same policies into production without review.

The scale of the problem is amplified in modern hybrid environments. Organizations managing on-premises [[Active Directory]], cloud IAM in AWS, Azure, or GCP, SaaS application entitlements in platforms like Salesforce or GitHub, and privileged access management (PAM) systems must track permissions across fundamentally different authorization models simultaneously. A user might be appropriately scoped in Active Directory but hold an AWS IAM policy with `AdministratorAccess` attached from a year-old deployment. No single tool traditionally provided unified visibility, making drift nearly invisible until an audit or incident surfaced it.

The consequences of access drift became globally visible in several high-profile breaches. The 2020 SolarWinds supply chain compromise exploited service accounts and broad cloud permissions that had accumulated over time, allowing adversaries to move laterally across Microsoft 365 tenants and exfiltrate data. Internal audits following the breach revealed that many accounts had far more privilege than their documented function required, a textbook manifestation of drift at enterprise scale. Similarly, post-incident analyses of cloud data breaches routinely identify overpermissioned IAM roles as the primary enabler of data exfiltration.

Regulatorily, access drift directly conflicts with compliance frameworks including [[NIST SP 800-53]], [[ISO 27001]], [[SOC 2]], [[PCI-DSS]], and [[HIPAA]]. These frameworks mandate periodic access reviews, role-based access control (RBAC), and the enforcement of least privilege as baseline controls. Failure to control access drift results not only in technical risk but in audit findings, regulatory penalties, and potential breach of contract obligations.

---

## How It Works

Access drift is a process-failure vulnerability rather than a single technical exploit. Understanding its mechanics requires tracing the identity lifecycle across common enterprise scenarios.

### Stage 1: Initial Provisioning
A new employee joins the organization. The IT help desk creates an Active Directory account and assigns them to the `Marketing_Staff` security group. This group grants:
- Read access to the `\\fileserver\marketing` share
- Access to the CRM application with standard user rights
- Email account provisioning

At this point, access is appropriate and aligned with role.

### Stage 2: Temporary Elevation
Six months later, the employee assists with a database migration project. The DBA team requests temporary access to the SQL Server instance:

```sql
-- Temporary access grant in SQL Server
USE [ProductionDB];
CREATE USER [jsmith] FOR LOGIN [DOMAIN\jsmith];
ALTER ROLE [db_datareader] ADD MEMBER [jsmith];
ALTER ROLE [db_datawriter] ADD MEMBER [jsmith];
GO
```

The project completes in three weeks. No remediation ticket is filed to remove the SQL access. The user retains `db_datareader` and `db_datawriter` permissions indefinitely.

### Stage 3: Role Change
The employee is promoted to Marketing Manager. A new group membership is added:

```powershell
# Adding new group membership in PowerShell
Add-ADGroupMember -Identity "Marketing_Managers" -Members "jsmith"
```

However, no one removes the original `Marketing_Staff` membership. No one reviews whether the permissions from both groups are additive in a problematic way. The user now holds all staff permissions *plus* all manager permissions.

### Stage 4: Cross-Department Work
The employee joins a cross-functional task force requiring access to the Finance shared drive. Access is provisioned:

```powershell
# Direct ACL grant on file share
$acl = Get-Acl "\\fileserver\finance\q3_reports"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "DOMAIN\jsmith", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow"
)
$acl.SetAccessRule($rule)
Set-Acl "\\fileserver\finance\q3_reports" $acl
```

The task force dissolves after two quarters. The ACL entry remains.

### Stage 5: Cloud Resource Accumulation
The employee begins using AWS for marketing analytics. An IAM policy is attached:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*",
        "athena:*",
        "glue:*"
      ],
      "Resource": "*"
    }
  ]
}
```

The wildcard resource scope is broader than needed but was copy-pasted from documentation during rapid provisioning. Over time, additional policies accumulate on this IAM user.

### Effective Permissions at Year Three
By year three, the employee's effective access profile includes:
- `Marketing_Staff` group (original, unnecessary)
- `Marketing_Managers` group (current role)
- SQL Server `db_datareader` + `db_datawriter` on ProductionDB (orphaned)
- Finance share `Modify` ACL (orphaned)
- AWS IAM with `s3:*`, `athena:*`, `glue:*` on `*` resources (overpermissioned)
- Multiple SaaS application roles accumulated from project access requests

### Detection via Tooling
Access drift can be quantified using tools like `AccessChk` from Sysinternals:

```cmd
accesschk.exe -u jsmith -d \\fileserver\finance /accepteula
```

Or via PowerShell for AD group enumeration:

```powershell
# Enumerate all group memberships recursively
Get-ADPrincipalGroupMembership -Identity "jsmith" -Recursive | 
    Select-Object Name, GroupCategory, GroupScope |
    Sort-Object Name
```

For AWS, the IAM Access Analyzer or the AWS CLI can reveal unused permissions:

```bash
# Generate credential report
aws iam generate-credential-report
aws iam get-credential-report --output text --query Content | base64 -d

# Check last used service data for an IAM user
aws iam get-service-last-accessed-details \
  --job-id $(aws iam generate-service-last-accessed-details \
  --arn arn:aws:iam::123456789012:user/jsmith \
  --query JobId --output text)
```

---

## Key Concepts

- **[[Principle of Least Privilege]] (PoLP):** The foundational security concept that states every user, process, and system should have only the minimum access rights necessary to perform its defined function — access drift is the direct violation of this principle over time.

- **[[Privilege Creep]]:** A synonym for access drift most commonly used in the context of human users accumulating permissions across role changes; emphasizes the incremental, gradual nature of the problem rather than a single provisioning failure.

- **[[Orphaned Permissions]]:** Access rights that remain assigned to a user or identity after the business justification for those rights no longer exists — the primary artifact of access drift, often invisible without systematic review.

- **[[Access Certification]] (Access Review):** A periodic, formal process in which system owners or managers review and certify that assigned access rights remain appropriate; the primary procedural control against access drift, mandated by most compliance frameworks.

- **[[Role-Based Access Control]] (RBAC):** An access control model that assigns permissions to roles rather than individuals, with users placed into roles — when properly maintained with defined role lifecycles, RBAC constrains drift by creating clear boundaries, but fails when roles themselves accumulate permissions or role assignments are not reviewed.

- **[[Joiner-Mover-Leaver]] (JML) Process:** An identity governance framework addressing three critical lifecycle events — when a user joins (provisioning), moves roles (re-provisioning and de-provisioning), and leaves (deprovisioning) — failures in the "Mover" and "Leaver" stages are the direct cause of most access drift.

- **[[Toxic Combinations]]:** Specific pairs or sets of permissions that, when held simultaneously, create high-risk conditions such as [[Segregation of Duties]] violations — for example, a user who can both initiate and approve financial transactions, a state often reached through drift rather than intentional design.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Access drift is primarily tested under **Domain 4.0 — Security Operations** (4.6: Identity and Access Management) and **Domain 5.0 — Security Program Management** (5.1: Policies, Processes, and Procedures), with overlap into **Domain 1.0 — General Security Concepts** regarding least privilege.

**Key Exam Facts:**
- The Security+ exam uses the term **privilege creep** more frequently than "access drift" — treat them as synonymous
- The primary *countermeasure* tested is **periodic access reviews** / **account audits** — know that these are a detective/corrective control
- The **principle of least privilege** is the preventive design principle; access reviews are the ongoing enforcement mechanism
- The **Joiner-Mover-Leaver** framework may appear in scenario questions about identity lifecycle management

**Common Question Patterns:**

> *"A security analyst reviews user accounts and finds that a recently promoted employee still retains access to systems from their previous role. What type of issue does this BEST describe?"*
> **Answer: Privilege creep / access drift**

> *"Which process BEST addresses the accumulation of excess permissions over time?"*
> **Answer: Periodic user access reviews / recertification campaigns**

> *"What principle, if consistently enforced, would PREVENT privilege creep?"*
> **Answer: Principle of least privilege**

**Gotchas:**
- Do not confuse privilege creep with **privilege escalation** — escalation is an *active attack* where an adversary gains higher privileges; creep is a *passive accumulation* through organizational process failure
- Time-limited access (just-in-time provisioning) is a modern answer to privilege creep — know that tools like [[CyberArk]], [[BeyondTrust]], and [[Azure PIM]] implement this
- The exam may present access drift as a compliance finding — connect it to SOX, PCI-DSS, or HIPAA audit failures

---

## Security Implications

**Attack Surface Expansion:** Each orphaned permission represents additional entry points for an adversary who compromises the associated account. If an attacker phishes a marketing employee's credentials and that employee holds SQL database write access from a two-year-old project, the adversary immediately gains access to production data without requiring any further exploitation.

**Lateral Movement Enablement:** Access drift is a force multiplier for [[Lateral Movement]] tactics. Adversaries who gain initial access to a low-privilege account routinely discover that, due to drift, the account holds broader permissions than its documented role suggests. The MITRE ATT&CK framework documents this under **T1078 — Valid Accounts**, where attackers leverage legitimately provisioned but excessively permissioned accounts to avoid detection.

**Insider Threat Amplification:** The [[Insider Threat]] risk associated with a disgruntled or malicious employee is directly proportional to their effective access. A departing employee who retains access to finance systems, source code repositories, and customer databases — all accumulated through legitimate drift — can exfiltrate significant data even after their primary account is notionally restricted to a new role.

**Real-World Incidents:**
- **Capital One Data Breach (2019, CVE context):** An overpermissioned AWS IAM role assigned to a web application firewall instance allowed an SSRF vulnerability to be escalated into full S3 bucket access across the account. The root cause included IAM policies that had accumulated broader permissions than the application required — a form of service account access drift.
- **SolarWinds Orion Compromise (2020):** Post-breach investigations revealed that the SUNBURST malware leveraged service principals and OAuth tokens with accumulated broad permissions across Azure AD tenants, enabling access to mail stores and sensitive data far beyond what legitimate Orion functionality required.
- **Uber Breach (2022):** An attacker used social engineering to access a contractor's VPN credentials, then discovered hard-coded credentials in network shares — but the blast radius was amplified because the accounts associated with those credentials had accumulated permissions across multiple internal tools through years of drift.

**Detection Indicators:**
- Users with group memberships in multiple departments or historical project groups
- Service accounts with last-used dates showing dormant entitlements
- Cloud IAM policies with wildcard actions or resources on active identities
- ACL entries for users whose department no longer requires that resource
- Accounts flagged in UEBA (User and Entity Behavior Analytics) for accessing resources inconsistent with peer group behavior

---

## Defensive Measures

### 1. Implement a Formal Joiner-Mover-Leaver (JML) Process
Define documented procedures for every identity lifecycle event:
- **Joiner:** Provision based on role template only; require manager approval for any deviation
- **Mover:** Treat role changes as a deprovisioning + reprovisioning event; explicitly revoke old access before or simultaneously with granting new access
- **Leaver:** Automate account disabling within hours of departure; schedule full deprovisioning within 30 days; transfer asset ownership explicitly

### 2. Conduct Regular Access Certification Campaigns
Schedule quarterly or semi-annual access reviews using an [[Identity Governance and Administration]] (IGA) platform such as **SailPoint IdentityNow**, **Saviynt**, or **Microsoft Entra Identity Governance**:

```
Access Review Cadence Recommendation:
- Privileged/Admin accounts:  Monthly
- Standard user accounts:     Quarterly  
- Service accounts:           Semi-annual
- Shared/generic accounts:    Quarterly with owner re-certification
```

### 3. Enforce Role-Based Access Control with Defined Role Catalogs
Maintain a documented role catalog that defines the exact permissions for each role. Use Active Directory security groups aligned to roles rather than granting permissions directly to users:

```powershell
# Audit direct user ACL grants (bypassing group-based RBAC)
# Identify users with direct file share permissions
$shares = Get-SmbShare
foreach ($share in $shares) {
    $acl = Get-Acl $share.Path
    $acl.Access | Where-Object { 
        $_.IdentityReference -notmatch "^BUILTIN\\" -and
        $_.IdentityReference -notmatch "^NT AUTHORITY\\" -and
        $_.IdentityReference -match "DOMAIN\\"
    } | Select-Object @{n='Share';e={$share.Name}}, IdentityReference, FileSystemRights
}
```

### 4. Deploy Just-In-Time (JIT) Privileged Access
Replace standing privileged access with on-demand, time-limited elevation using:
- **Azure Privileged Identity Management (PIM):** Eligible role assignments require activation with MFA and justification, expire automatically
- **CyberArk PAM / BeyondTrust:** Session-based privileged access with automatic credential rotation
- **AWS IAM Roles with AssumeRole:** Grant temporary credentials scoped to specific tasks rather than persistent IAM user permissions

```bash
# AWS: Assume a limited-duration role instead of persistent permissions
aws sts assume-role \
  --role-arn arn:aws:iam::123456789012:role/DatabaseMigrationRole \
  --role-session-name migration-session-jsmith \