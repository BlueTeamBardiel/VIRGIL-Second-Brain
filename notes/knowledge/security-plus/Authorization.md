---
domain: "Identity and Access Management"
tags: [authorization, access-control, iam, permissions, security-fundamentals, least-privilege]
---
# Authorization

**Authorization** is the process of determining what actions, resources, or data an authenticated identity is permitted to access within a system. It is the second pillar of the **AAA framework** ([[AAA - Authentication, Authorization, and Accounting]]), occurring after [[Authentication]] has confirmed *who* the subject is, and before [[Accounting]] records *what* was done. Authorization enforces [[Access Control]] policy by granting or denying requests based on defined rules, roles, or attributes.

---

## Overview

Authorization exists because authentication alone is insufficient for security. Knowing *who* someone is does not answer *what they should be allowed to do*. A hospital network may authenticate thousands of users, but a billing clerk must not access surgical records, and a nurse must not approve payroll. Authorization creates these boundaries by evaluating a subject's request against a policy engine and returning a permit or deny decision.

The concept is rooted in the principle of **least privilege** — every user, process, or system should have the minimum access necessary to perform its function. This limits the blast radius of compromised credentials or insider threats. Without authorization controls, any authenticated user would effectively be an administrator, a catastrophic security posture that violates virtually every compliance framework including PCI-DSS, HIPAA, and ISO 27001.

Authorization operates on three fundamental questions: **who** is making the request (the subject), **what** they are trying to do (the action), and **where or on what** they are acting (the object or resource). These map to the access control triple: subject → action → object. A policy might read: "Members of the *finance* group may *read and write* the */reports/quarterly* directory." The authorization engine evaluates every request against rules of this form in real time.

Modern authorization is rarely a simple yes/no database lookup. Complex environments use federated identity providers, attribute-based rules, time-of-day constraints, geolocation restrictions, and risk scores. Platforms like AWS IAM, Azure RBAC, and Google Cloud IAM implement layered authorization models that evaluate dozens of policy documents before rendering a final decision. Zero-trust architectures further demand that authorization be re-evaluated continuously, not just at session initiation.

It is critical to distinguish authorization from authentication — a distinction the Security+ exam tests heavily. Authentication answers "Are you who you say you are?" Authorization answers "Are you allowed to do what you are trying to do?" A valid username and password grants authentication; a signed JWT bearing the `admin` role claim grants authorization to administrator functions.

---

## How It Works

### The Authorization Decision Flow

When a subject attempts to access a resource, the following sequence occurs:

1. **Request Initiation** — The subject (user, service, process) sends a request to a resource server or application.
2. **Identity Presentation** — The subject presents a credential token (session cookie, [[JWT - JSON Web Token]], OAuth access token, Kerberos service ticket) obtained during authentication.
3. **Policy Retrieval** — The **Policy Decision Point (PDP)** retrieves applicable authorization policies for the subject's identity, roles, and the requested resource.
4. **Evaluation** — The PDP evaluates the request against all applicable rules. In AWS IAM, for example, an explicit `Deny` always overrides any `Allow`.
5. **Decision Rendered** — The PDP returns `Permit`, `Deny`, `Not Applicable`, or `Indeterminate`.
6. **Enforcement** — The **Policy Enforcement Point (PEP)** — the API gateway, OS kernel, database proxy, or application middleware — enforces the decision by allowing or blocking the action.
7. **Accounting** — The outcome is logged for audit and forensic purposes ([[SIEM]]).

### RBAC in Practice (Linux Example)

Role-Based Access Control maps users to roles and roles to permissions:

```bash
# Create a group (role) for developers
sudo groupadd developers

# Add user alice to the developers role
sudo usermod -aG developers alice

# Set directory permissions so only developers can write
sudo chown root:developers /var/app/code
sudo chmod 775 /var/app/code

# Verify
ls -la /var/app/
# drwxrwxr-x  2 root developers 4096 Jan 10 09:00 code
```

### ABAC Policy Example (AWS IAM JSON)

Attribute-Based Access Control uses attributes of the subject, resource, and environment:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::company-reports/*",
      "Condition": {
        "StringEquals": {
          "aws:PrincipalTag/Department": "Finance",
          "s3:prefix": "quarterly/"
        },
        "IpAddress": {
          "aws:SourceIp": "203.0.113.0/24"
        }
      }
    }
  ]
}
```

This policy grants S3 read access only to principals tagged as Finance department, only for the `quarterly/` prefix, and only from a specific IP range — a multi-attribute decision characteristic of ABAC.

### OAuth 2.0 Authorization Flow (Authorization Code Grant)

OAuth 2.0 is the dominant protocol for delegated authorization in web applications:

```
User → App: "I want to access my Google Drive files"
App → Authorization Server: GET /authorize?response_type=code
                             &client_id=CLIENT_ID
                             &redirect_uri=https://app.example/callback
                             &scope=drive.readonly
                             &state=RANDOM_STATE
Authorization Server → User: "App requests read-only Drive access. Allow?"
User → Authorization Server: Grants consent
Authorization Server → App: 302 Redirect to /callback?code=AUTH_CODE
App → Authorization Server: POST /token
                             client_id=CLIENT_ID
                             client_secret=SECRET
                             code=AUTH_CODE
                             grant_type=authorization_code
Authorization Server → App: {"access_token": "TOKEN", "scope": "drive.readonly"}
App → Resource Server: GET /drive/files
                        Authorization: Bearer TOKEN
Resource Server: Validates token scope, returns files
```

The critical authorization element here is the **scope** — it limits what the access token can do, enforcing least privilege for delegated access.

### XACML Policy Enforcement Architecture

XACML (eXtensible Access Control Markup Language) formalizes the PDP/PEP model:

- **PAP (Policy Administration Point)** — Where policies are written and stored
- **PDP (Policy Decision Point)** — Evaluates requests against policies
- **PEP (Policy Enforcement Point)** — Intercepts requests and enforces PDP decisions
- **PIP (Policy Information Point)** — Provides additional attributes (LDAP queries, database lookups) to the PDP during evaluation

---

## Key Concepts

- **[[Least Privilege]]** — The principle that every subject should have only the minimum permissions required for their role. Excess privilege creates attack surface for both external attackers and insider threats.
- **[[RBAC - Role-Based Access Control]]** — Permissions are assigned to roles, and users are assigned to roles. Simplifies management at scale. Example: all members of the `DBA` role can connect to the production database.
- **[[ABAC - Attribute-Based Access Control]]** — Decisions are made based on attributes of the subject, resource, action, and environment. More granular and context-aware than RBAC. Example: access allowed only if `user.clearance >= resource.classification AND time.hour BETWEEN 09:00 AND 17:00`.
- **[[MAC - Mandatory Access Control]]** — The OS or system enforces access based on security labels (classifications). Users cannot change permissions on objects they own. Used in government/military environments (SELinux, AppArmor in enforcing mode).
- **[[DAC - Discretionary Access Control]]** — The resource owner determines access permissions. Users can grant access to their own files. Standard on Linux/Windows filesystems. More flexible but less secure than MAC.
- **[[Rule-Based Access Control]]** — Access is governed by system-wide rules regardless of role, such as firewall ACLs: "Deny all traffic from 192.168.0.0/16 to port 22."
- **[[Privilege Creep]]** — The gradual accumulation of access rights over time as a user changes roles without having old permissions revoked. A major audit finding and insider threat risk.
- **[[Separation of Duties]]** — No single individual should have sufficient permissions to complete a sensitive transaction alone, reducing fraud risk. Example: the developer who writes code cannot also deploy to production.
- **Implicit Deny** — In secure authorization systems, anything not explicitly permitted is denied by default. AWS IAM, firewall ACLs, and most enterprise access control frameworks operate this way.

---

## Exam Relevance

**SY0-701 Domain Mapping:** Authorization appears primarily in Domain 1 (General Security Concepts) and Domain 4 (Security Operations), particularly within Identity and Access Management (IAM) objectives.

**High-Priority Exam Topics:**

- **Know the AAA distinction cold.** Exam questions frequently present a scenario and ask which AAA component is being described. Authentication = identity verification. Authorization = permission enforcement. Accounting = logging/auditing.
- **RBAC vs. ABAC vs. MAC vs. DAC** — Expect scenario questions. "A military system assigns security labels to all files and users cannot change them" = MAC. "A manager grants a contractor access to their project folder" = DAC.
- **Least privilege and need-to-know** are tested together. Need-to-know is a MAC concept often applied to classified information; least privilege is the broader technical principle.
- **Privilege creep** is frequently presented as a finding in access review scenarios. The correct answer for remediation is an **access recertification** or **user access review**.
- **OAuth 2.0 scope** is tested as an example of authorization in federated/cloud contexts. Understand that OAuth 2.0 is an *authorization* protocol, not an authentication protocol — that's what [[OpenID Connect]] adds on top.

**Common Gotchas:**

- Do not confuse **authentication** with **authorization**. A locked door that requires a key is authentication (the key proves who you are). A different door that the key *doesn't open* is authorization (you're authenticated but not authorized).
- **Role-based** ≠ **Rule-based**. Role-based assigns permissions to roles. Rule-based uses conditional rules like firewall ACLs.
- **Zero Trust** doesn't eliminate authorization — it *strengthens* it by requiring continuous re-authorization rather than trusting an established session.

---

## Security Implications

### Broken Access Control (OWASP #1)

Broken Access Control has ranked #1 in the OWASP Top 10 since 2021. Common manifestations include:

- **Insecure Direct Object Reference (IDOR)** — Accessing resources by manipulating IDs. Example: changing `GET /api/invoices/1042` to `/api/invoices/1041` to read another user's invoice.
- **Missing Function-Level Access Control** — Admin endpoints accessible without admin role because the UI hides the link but the API doesn't enforce authorization server-side.
- **Path Traversal** — Bypassing directory-level authorization with `../../etc/passwd`.

**Real-World Incident:** The 2019 Facebook IDOR vulnerability allowed attackers to remove any user from a group by exploiting a missing authorization check in the Groups API, affecting hundreds of millions of accounts.

### Privilege Escalation

Attackers who gain a foothold with low-privilege credentials seek to escalate to administrator or root:

- **Vertical Privilege Escalation** — Gaining higher privileges than assigned (e.g., regular user → root via [[CVE-2021-4034]] PwnKit, a SUID bit exploitation in pkexec).
- **Horizontal Privilege Escalation** — Accessing another user's resources at the same privilege level (e.g., IDOR attacks).

**CVE-2021-4034 (PwnKit):** A local privilege escalation in Polkit's `pkexec` utility, present in all major Linux distributions since 2009. An unprivileged local user could execute arbitrary code as root. This is a textbook authorization failure where the authorization check in the SUID binary could be bypassed.

### JWT Authorization Vulnerabilities

- **Algorithm Confusion (CVE-2015-9235):** Early JWT libraries accepted `"alg": "none"`, allowing attackers to forge tokens without a signature, bypassing all authorization checks.
- **Weak Secret Signing:** JWTs signed with weak HMAC secrets can be brute-forced offline, allowing attackers to forge tokens with arbitrary role claims.

### Token Scope Overprivilege

OAuth applications requesting broad scopes (`scope=*` or `scope=admin`) violate least privilege. Compromised broad-scope tokens expose far more resources than necessary.

---

## Defensive Measures

### Implement Strict Access Control Models

```bash
# SELinux: Enforce MAC on a Linux system
sudo setenforce 1  # Switch to enforcing mode
sudo sestatus      # Verify: SELinux status: enabled, Current mode: enforcing

# Check SELinux policy denials
sudo ausearch -m avc -ts recent | grep denied
```

### Principle of Least Privilege in AWS

```bash
# Audit IAM users for overly broad permissions
aws iam get-account-authorization-details \
    --filter User \
    --query 'UserDetailList[*].[UserName,AttachedManagedPolicies]'

# Use IAM Access Analyzer to find overly permissive policies
aws accessanalyzer list-analyzers
aws accessanalyzer list-findings --analyzer-arn <analyzer-arn>
```

### Implement Regular Access Recertification

Conduct quarterly access reviews using:
- **SailPoint IdentityNow** or **Saviynt** for enterprise PAM/IGA
- **AWS IAM Access Advisor** to identify unused permissions
- **Azure AD Access Reviews** for periodic entitlement validation

```bash
# AWS: Find IAM users with permissions unused for 90+ days
aws iam generate-credential-report
aws iam get-credential-report --query 'Content' --output text | base64 -d
```

### Secure JWT Implementation

```python
import jwt
from datetime import datetime, timedelta

# Always specify algorithm explicitly — never accept 'none'
token = jwt.encode(
    {
        "sub": "alice",
        "role": "analyst",           # Role claim for authorization
        "scope": "reports:read",     # Scope for resource-level authorization
        "exp": datetime.utcnow() + timedelta(hours=1),
        "iat": datetime.utcnow()
    },
    secret_key,
    algorithm="HS256"   # Explicit algorithm — never use 'none'
)

# Decode with strict algorithm enforcement
payload = jwt.decode(
    token,
    secret_key,
    algorithms=["HS256"]    # Allowlist, not just a hint
)
```

### Additional Defensive Controls

- **Enforce implicit deny as default** in all access control systems — firewalls, IAM policies, application middleware.
- **Separate duty-sensitive roles** — no single account should have both `write` and `deploy` in production pipelines.
- **Implement time-based access controls** for privileged accounts — use [[PAM - Privileged Access Management]] solutions like CyberArk or HashiCorp Vault for just-in-time access.
- **Audit authorization logs** continuously with a [[SIEM]] — failed authorization attempts (HTTP 403, `sudo` failures, Windows Event 4625) are key indicators of reconnaissance and privilege escalation.
- **Input validation** at the API layer to prevent IDOR — never trust client-supplied IDs for authorization decisions; always re-validate server-side.

---

## Lab / Hands-On

### Lab 1: Explore Linux DAC and Escalate to RBAC with Sudo

```bash
# Create two users and a shared group
sudo useradd -m alice
sudo useradd -m bob
sudo groupadd project-alpha

# Assign both to the group
sudo usermod -aG project-alpha alice
sudo usermod -aG project-alpha bob

# Create a shared directory with group-based authorization
sudo mkdir /srv/project-alpha
sudo chown root:project-alpha /srv/project-alpha
sudo chmod 2770 /srv/project-alpha  # setgid ensures new files inherit group