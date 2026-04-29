---
domain: "identity and access management"
tags: [access-control, iam, authentication, authorization, security-fundamentals, zero-trust]
---
# Access Control

**Access control** is the process of selectively restricting access to resources, systems, or physical locations to authorized entities while preventing unauthorized access. It is a foundational pillar of [[information security]], implementing the [[principle of least privilege]] and directly enforcing [[confidentiality]] within the [[CIA Triad]]. Access control governs not just *who* can access a resource, but *what* they can do with it and *under what conditions*.

---

## Overview

Access control exists because not every user, process, or system should have unrestricted access to every resource. In a corporate environment, a payroll employee needs access to salary data, but a junior IT technician should not. Without access control, any authenticated user could read, modify, or destroy data far outside their job function—a violation of the principle of least privilege and a massive security risk. The discipline formalizes the relationship between **subjects** (users, processes, services) and **objects** (files, databases, network segments, physical rooms).

Access control systems are built upon three sequential concepts: **identification** (claiming an identity), **[[authentication]]** (proving that identity), and **[[authorization]]** (determining what that proven identity is allowed to do). A fourth concept, **accountability**, is realized through [[audit logging]] and ensures that actions can be traced to the subject that performed them. These four elements together form the complete access control lifecycle and are sometimes collectively called **IAAA** (Identification, Authentication, Authorization, Accountability).

There are multiple *models* of access control, each with different trade-offs between administrative overhead, flexibility, and security strength. These models—DAC, MAC, RBAC, ABAC, and others—are not mutually exclusive; real-world systems often layer them. For example, a Linux filesystem uses Discretionary Access Control (DAC) via traditional Unix permissions, while a military information system might overlay Mandatory Access Control (MAC) using SELinux policies on top of those same permissions.

Access control spans both **logical** and **physical** domains. Logical access control governs network access, file permissions, API authorization, and database queries. Physical access control governs entry to buildings, server rooms, and data centers through mechanisms like badge readers, biometrics, and mantrap corridors. Security professionals must consider both domains holistically, since bypassing physical controls often renders logical controls irrelevant—an attacker with physical access to a server can boot from removable media and bypass OS-level permissions entirely.

Modern access control is increasingly context-aware, moving beyond simple username/password gating to evaluate device health, geolocation, time-of-day, and behavioral analytics before granting access. This shift is the core of [[Zero Trust Architecture]], which operates on the principle of "never trust, always verify," treating every access request as potentially hostile regardless of whether it originates from inside or outside the network perimeter.

---

## How It Works

Access control is implemented through a pipeline of policy enforcement components. Understanding the flow clarifies how a real request is evaluated.

### The Access Control Pipeline

1. **Subject makes a request** — A user attempts to open a file, connect to a database, or call an API endpoint.
2. **Identification** — The subject presents a claimed identity (username, certificate CN, API key).
3. **Authentication** — The system verifies the claim against a credential store ([[Active Directory]], LDAP, RADIUS, local `/etc/shadow`).
4. **Policy Decision Point (PDP)** — The system consults an access control policy (ACL, role table, security label) to determine if the authenticated subject is permitted to perform the requested action on the target object.
5. **Policy Enforcement Point (PEP)** — The decision is enforced: access is granted or denied.
6. **Audit log entry** — The decision and context are written to a log for accountability.

### Access Control Models in Practice

#### Discretionary Access Control (DAC)
The **resource owner** sets permissions. Most familiar from Unix/Linux filesystems and Windows NTFS ACLs.

```bash
# Linux: view file permissions
ls -la /etc/passwd
# -rw-r--r-- 1 root root 2847 Jan 10 08:00 /etc/passwd
# Owner: rw- | Group: r-- | Others: r--

# Change file permissions
chmod 640 /etc/sensitive_data.txt  # Owner rw, Group r, Others none
chown alice:finance /etc/sensitive_data.txt

# Windows: view NTFS ACL via PowerShell
Get-Acl -Path "C:\Finance\Payroll.xlsx" | Format-List
```

#### Mandatory Access Control (MAC)
The **operating system** enforces policy based on labels; individual owners cannot override it. Implemented in SELinux, AppArmor, and Trusted Solaris.

```bash
# SELinux: check enforcement mode
getenforce
# Enforcing

# View SELinux context labels on files
ls -Z /var/www/html/index.html
# system_u:object_r:httpd_sys_content_t:s0

# Check if a process is allowed to write to a path
sesearch --allow -s httpd_t -t shadow_t
# No results = httpd cannot read /etc/shadow — enforced by policy, not file perms
```

#### Role-Based Access Control (RBAC)
Permissions are assigned to **roles**, and subjects are assigned to roles. Used extensively in enterprise systems, cloud IAM (AWS IAM Roles), and database engines.

```sql
-- SQL Server: create a role and assign permissions
CREATE ROLE FinanceReadOnly;
GRANT SELECT ON dbo.Payroll TO FinanceReadOnly;
GRANT SELECT ON dbo.Invoices TO FinanceReadOnly;

-- Assign user to role
ALTER ROLE FinanceReadOnly ADD MEMBER alice_smith;

-- Revoke role membership
ALTER ROLE FinanceReadOnly DROP MEMBER alice_smith;
```

```bash
# AWS CLI: attach a policy to an IAM role
aws iam attach-role-policy \
  --role-name FinanceReadOnlyRole \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

#### Attribute-Based Access Control (ABAC)
Access decisions evaluate **multiple attributes**: subject attributes (department, clearance level), object attributes (classification, owner), environment attributes (time, location, device compliance).

```json
// Example ABAC policy (XACML-like concept)
{
  "effect": "permit",
  "condition": {
    "subject.department": "Finance",
    "subject.clearance": "Confidential",
    "object.classification": "Confidential",
    "environment.time": "08:00-18:00",
    "environment.device_compliant": true
  }
}
```

### Network Access Control (NAC)
At the network layer, access control is enforced through 802.1X port authentication, firewall ACLs, and VLAN segmentation.

```bash
# Cisco IOS: apply ACL to interface (permit only SSH from management subnet)
ip access-list extended MGMT_ACCESS
 permit tcp 10.10.10.0 0.0.0.255 any eq 22
 deny   ip any any log

interface GigabitEthernet0/1
 ip access-group MGMT_ACCESS in

# Linux iptables: restrict access to port 443 to a specific subnet
iptables -A INPUT -p tcp --dport 443 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j DROP
```

---

## Key Concepts

- **Subject**: An active entity that requests access to a resource. This can be a human user, a service account, a running process, or a device. Subjects are the *who* in access control.

- **Object**: A passive resource that a subject wants to act upon—files, database rows, API endpoints, network services, or physical rooms. Objects have associated permissions or labels that define who may interact with them and how.

- **Policy Decision Point (PDP)**: The component that evaluates an access request against the defined policy and returns an authorization decision (permit/deny). In network environments, a RADIUS or TACACS+ server acts as a PDP.

- **Policy Enforcement Point (PEP)**: The component that intercepts the request and enforces the PDP's decision. A firewall, a web application gateway, or an OS kernel are all PEPs in different contexts.

- **Principle of Least Privilege (PoLP)**: Every subject should be granted only the minimum access rights required to perform its function, and no more. Violations of PoLP are among the most common root causes of security breaches.

- **Separation of Duties (SoD)**: No single subject should have enough access to complete a high-risk transaction alone. A classic example: the employee who creates vendor payments should not also be able to approve them. SoD is a fraud-prevention control built into access control design.

- **Need to Know**: Even if a subject has the clearance level to access a classification of data, they should only access specific items within that classification that are necessary for their work. This is the MAC complement to PoLP.

- **Access Control List (ACL)**: A data structure attached to an object that enumerates which subjects are permitted to perform which operations. Most filesystem and network permissions are implemented as ACLs.

- **Capability**: The inverse of an ACL—a token or ticket held by a subject that grants specific access rights to an object. [[Kerberos]] tickets and OAuth tokens are capability-based access control mechanisms.

- **Privilege Creep**: The gradual accumulation of access rights by a user over time—typically as they change roles—without old rights being revoked. Regular **access reviews** (also called re-certification) are the countermeasure.

---

## Exam Relevance

The SY0-701 exam tests access control deeply across multiple domains. Expect scenario-based questions that require you to identify the *correct access control model* for a described environment.

**High-frequency topic areas:**

- **Memorize the four access control models and their distinguishing characteristics.** The exam frequently presents a scenario and asks which model is in use:
  - DAC: owner sets permissions — think Linux `chmod`, Windows NTFS
  - MAC: OS enforces labels — think SELinux, government/military systems
  - RBAC: permissions via roles — think enterprise AD groups, database roles
  - ABAC: attribute-based policies — think cloud IAM conditional policies, "most flexible model"

- **Rule-Based Access Control** (sometimes confused with RBAC): Uses *rules* rather than roles — firewall ACLs are the canonical example. Rules apply uniformly to all subjects matching the rule condition. The exam distinguishes this from RBAC.

- **Physical vs. Logical access control**: The exam tests knowledge of physical controls (mantraps, fences, badge readers, guards) as access control mechanisms—not just logical permissions.

- **Know the IAAA framework** and be able to distinguish authentication from authorization. A common distractor: "the system checked the user's password" is authentication, not authorization. "The system checked whether the user is in the Finance role before showing payroll data" is authorization.

- **Gotcha — DAC and MAC**: In MAC environments, even the *owner* of a file cannot grant access that exceeds the object's security label. The system policy overrides owner discretion. This is a frequent trick question.

- **Gotcha — RBAC vs. ABAC**: RBAC uses *predefined roles*; ABAC can make decisions on combinations of any attributes without predefined roles. The exam may ask which supports "dynamic, context-aware access decisions" — the answer is ABAC.

- **Privilege creep and access reviews**: Questions may describe a scenario where employees accumulate permissions over time — the correct answer is to implement periodic **access reviews/re-certification** and enforce PoLP.

---

## Security Implications

Access control failures are consistently in the **OWASP Top 10** (listed as "Broken Access Control," the #1 most critical web application vulnerability since 2021). They represent the single most impactful class of security vulnerability because they enable unauthorized users to act as privileged users.

### Common Attack Vectors

- **Privilege Escalation**: An attacker with low-privilege access exploits a misconfiguration or vulnerability to obtain higher privileges. Vertical privilege escalation targets higher permission levels (user → admin); horizontal privilege escalation accesses other users' data at the same permission level.

- **Insecure Direct Object Reference (IDOR)**: A web application exposes internal object IDs in URLs or API calls without verifying that the authenticated user is authorized to access that specific object. Example: changing `GET /api/invoice?id=1042` to `id=1043` to access another user's invoice.

- **ACL Misconfiguration**: Overly permissive ACLs on file shares, S3 buckets, or database objects. The 2019 Capital One breach involved an SSRF vulnerability combined with an over-permissive IAM role that allowed the attacker to exfiltrate 100 million customer records from S3.

- **Privilege Creep Exploitation**: An employee accumulates access to 15 systems over 3 years through role changes. Without access reviews, any of those systems remains an attack surface if that account is compromised.

- **CVE-2021-44228 (Log4Shell) — Access Control bypass context**: Beyond the RCE aspect, the incident demonstrated how over-privileged service accounts allowed attackers to pivot through internal systems once initial access was gained—access control depth mattered significantly.

- **Token/Capability Theft**: Stealing OAuth tokens, Kerberos tickets (pass-the-ticket), or API keys bypasses authentication entirely and abuses legitimate capabilities. The attacker becomes the subject in the system's view.

- **Confused Deputy Problem**: A high-privilege service is tricked by a lower-privilege actor into performing actions on the attacker's behalf. Cross-site request forgery (CSRF) is a web-layer example; privilege escalation via SUID binaries is a Unix-layer example.

---

## Defensive Measures

### Design Principles
- **Implement least privilege by default**: Start with zero access and grant only what is explicitly required. Never use "allow all" as a starting position.
- **Enforce separation of duties** for high-value transactions: financial approvals, infrastructure changes, and key management should require multiple authorizing parties.
- **Conduct periodic access reviews**: Schedule quarterly reviews of role memberships and permission grants. Use an identity governance platform (SailPoint, Saviynt, Microsoft Entra ID Governance) to automate access certification workflows.

### Technical Controls

```bash
# Linux: find SUID binaries (potential privilege escalation vectors)
find / -perm -4000 -type f 2>/dev/null

# Audit all sudoers permissions
cat /etc/sudoers
sudo -l -U username

# Linux: enable and review audit logs for access control events
auditctl -w /etc/passwd -p rwa -k passwd_changes
ausearch -k passwd_changes

# Check for world-writable files (overly permissive DAC)
find /var/www -type f -perm -o+w 2>/dev/null
```

```powershell
# PowerShell: audit local group memberships
Get-LocalGroupMember -Group "Administrators"

# Find files with weak ACLs in sensitive directory
Get-ChildItem "C:\Finance" -Recurse | Get-Acl | 
  Where-Object { $_.Access | Where-Object { $_.IdentityReference -like "*Everyone*" } }

# Review effective permissions for a user on a file
(Get-Acl "C:\Finance\Payroll.xlsx").Access | 
  Format-Table IdentityReference, AccessControlType, FileSystemRights
```

### IAM Hardening
- Enable **Multi-Factor Authentication (MFA)** on all privileged accounts and, ideally, all accounts.
- Implement **Just-in-Time (JIT) privileged access**: accounts receive elevated rights only for the duration of a specific task (using tools like [[CyberArk]], [[Delinea]], or Microsoft PIM).
- Use **service principals and managed identities** instead of long-lived service account passwords in cloud environments.
- Enforce **password policies** and credential hygiene through Active Directory Group Policy or cloud IAM policies.
- Deploy **Network Access Control (NAC)** to enforce device compliance posture before granting network access (Cisco ISE, Aruba ClearPass).

### Monitoring
- Log all access control decisions (grants and denials) to a centralized [[SIEM]].
- Alert on: access denials exceeding threshold, access to sensitive objects outside business hours, new role assignments to privileged groups, SUID/SG