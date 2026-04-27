---
domain: "identity and access management"
tags: [access-control, iam, authorization, authentication, security-fundamentals, least-privilege]
---
# Access Controls

**Access controls** are security mechanisms that regulate who or what can view, use, or interact with resources in a computing environment. They form the backbone of the **CIA triad** by enforcing [[confidentiality]], [[integrity]], and [[availability]] through structured policies governing [[authentication]] and [[authorization]]. Access controls span physical, administrative, and technical domains, and are a foundational pillar of both enterprise security architecture and regulatory compliance frameworks such as NIST 800-53 and ISO 27001.

---

## Overview

Access controls exist because not every user, process, or system should have unrestricted access to every resource. Without them, a single compromised credential or malicious insider could access payroll databases, delete production files, or exfiltrate intellectual property without any system-level resistance. The fundamental premise is simple: grant the minimum permissions necessary for a subject to perform its function — a principle known as **least privilege**.

At the highest level, access control involves three actors: a **subject** (the entity requesting access, such as a user or process), an **object** (the resource being accessed, such as a file, database, or network share), and an **access control policy** (the ruleset that determines whether the subject's request is permitted). This subject-object-policy triad is evaluated at every access attempt, whether you are logging into a Linux server, opening a file on a Windows share, or hitting an API endpoint.

Access control frameworks have evolved considerably over decades. Early systems used simple password-based gatekeeping. Modern environments leverage multi-factor authentication, attribute-based policies, zero-trust architectures, and hardware security modules. The proliferation of cloud infrastructure has further complicated access control, introducing federated identity systems, service account permissions, and cross-account resource sharing — all of which expand the attack surface if misconfigured.

Regulatory frameworks mandate specific access control implementations. HIPAA requires access controls protecting electronic protected health information (ePHI). PCI-DSS requires that cardholder data be accessible only on a need-to-know basis with unique user IDs. NIST SP 800-53 dedicates an entire control family (AC) to access control requirements. These regulations exist because data breaches are overwhelmingly caused by access control failures — either through excessive permissions, missing authentication, or broken authorization logic.

Access controls are also categorized by their **timing relative to an incident**: preventive controls stop unauthorized access before it occurs (firewalls, locked doors, MFA), detective controls identify when unauthorized access has happened (audit logs, SIEM alerts), and corrective controls restore systems after a breach (account revocation, incident response). This layered approach is called **defense in depth**.

---

## How It Works

Access control enforcement is a multi-stage pipeline that begins the moment a subject attempts to access an object. Understanding each stage is essential for both implementation and for identifying where controls can fail.

### Stage 1: Identification

The subject declares who it is. This might be a username entered at a login prompt, a service account name in an API call header, or a machine certificate presented during a TLS handshake. Identification alone provides no security — it is simply a claim.

```
# Example: SSH identification — the client presents a username
ssh alice@192.168.1.10
```

### Stage 2: Authentication

The subject proves its identity using one or more factors. The three classic categories are:
- **Something you know**: password, PIN, security question
- **Something you have**: hardware token, smart card, TOTP app
- **Something you are**: fingerprint, retina scan, facial recognition

Modern systems combine factors for **Multi-Factor Authentication (MFA)**. Linux PAM (Pluggable Authentication Modules) handles authentication stacks locally:

```bash
# /etc/pam.d/sshd — require Google Authenticator TOTP after password
auth required pam_google_authenticator.so
auth required pam_unix.so
```

Windows Active Directory uses **Kerberos** for network authentication. A client requests a **Ticket Granting Ticket (TGT)** from the Key Distribution Center (KDC) on TCP/UDP port 88, then exchanges it for service tickets to access specific resources — never transmitting the user's password over the network.

### Stage 3: Authorization

After authentication, the system checks whether the authenticated subject has permission to perform the requested action on the object. This is evaluated against an **Access Control List (ACL)** or a **policy engine**.

```bash
# Linux file permissions — subject: alice, object: /etc/shadow
ls -la /etc/shadow
# -rw-r----- 1 root shadow 1234 Jan 1 00:00 /etc/shadow
# root: rw-, shadow group: r--, others: ---
# alice is not root and not in shadow group → DENIED
```

On Windows, ACLs are stored as Security Descriptors on every SECURABLE OBJECT. Use `icacls` to inspect them:

```cmd
icacls C:\SensitiveData\payroll.xlsx
# Output:
# BUILTIN\Administrators:(F)
# DOMAIN\HR-Team:(RX)
# Everyone: (none)
```

### Stage 4: Audit / Accountability

Every access attempt — successful or denied — should be logged. This supports forensic investigation, compliance reporting, and anomaly detection. On Linux, `auditd` records file access events:

```bash
# Add an audit rule to monitor reads on /etc/passwd
auditctl -w /etc/passwd -p r -k passwd_read

# View audit log
ausearch -k passwd_read
```

Windows Security Event Log captures logon events (Event ID 4624 = successful logon, 4625 = failed logon, 4663 = object access attempt).

### Access Control Models in Practice

**Discretionary Access Control (DAC)**: The resource owner sets permissions. Linux filesystem permissions and Windows NTFS ACLs are DAC implementations. Flexible, but permissions can be misconfigured or over-granted.

**Mandatory Access Control (MAC)**: The OS enforces policies that users cannot override. SELinux and AppArmor implement MAC on Linux. Used in classified government systems (Bell-LaPadula model).

```bash
# Check SELinux status
sestatus
getenforce  # Returns: Enforcing, Permissive, or Disabled

# See SELinux context on a file
ls -Z /var/www/html/index.html
# system_u:object_r:httpd_sys_content_t:s0
```

**Role-Based Access Control (RBAC)**: Permissions are assigned to roles, and subjects are assigned to roles. This is the dominant enterprise model — Active Directory security groups, AWS IAM roles, and Kubernetes RBAC all use this paradigm.

```yaml
# Kubernetes RBAC — grant pod-reader role in namespace "dev"
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: dev
subjects:
- kind: User
  name: alice
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

**Attribute-Based Access Control (ABAC)**: Access decisions evaluate multiple attributes of the subject, object, environment, and action simultaneously. AWS IAM condition keys implement ABAC — for example, denying access unless the request originates from a specific IP range AND uses MFA.

```json
{
  "Effect": "Deny",
  "Action": "s3:*",
  "Resource": "*",
  "Condition": {
    "BoolIfExists": {"aws:MultiFactorAuthPresent": "false"}
  }
}
```

---

## Key Concepts

- **Least Privilege**: Every subject should be granted only the minimum permissions required to perform its intended function. A web server process should not run as root; a read-only reporting account should not have INSERT permissions on a database.
- **Separation of Duties (SoD)**: Critical operations are divided among multiple subjects so no single person can commit fraud or error unilaterally. A developer who writes code should not also be the person who approves it for production deployment.
- **Need to Know**: Even within a role that permits general access to a category of data, access to specific items should only be granted when operationally necessary. A security analyst may have access to *all* logs but should only actively review logs *relevant to their current investigation*.
- **Access Control List (ACL)**: A list attached to an object that specifies which subjects have which permissions. File system ACLs, network ACL rules on routers, and AWS S3 bucket ACLs all implement this concept.
- **Privilege Escalation**: The process by which a subject gains access rights beyond what was originally authorized — either through a software vulnerability, misconfiguration, or deliberate exploit. This is one of the most critical attack vectors access controls must defend against.
- **Zero Trust**: A modern security model that eliminates implicit trust based on network location. Every access request — even from inside the corporate network — must be authenticated, authorized, and continuously validated. Built on the principle "never trust, always verify."
- **Federated Identity**: A mechanism allowing a subject's identity from one domain (an Identity Provider, or IdP) to be trusted for access in another domain (a Service Provider). SAML 2.0, OAuth 2.0, and OpenID Connect are the dominant protocols.
- **Time-of-Check to Time-of-Use (TOCTOU)**: A race condition vulnerability where the state of a resource changes between when access was authorized (checked) and when it is actually used. Critical in file system and database access control contexts.

---

## Exam Relevance

The Security+ SY0-701 exam tests access control across multiple domains, particularly within **Domain 4.0: Security Operations** and **Domain 5.0: Security Program Management and Oversight**. Expect questions covering:

**Common Question Patterns:**
- Scenario questions asking you to identify the *most appropriate* access control model for a given situation (MAC for high-security classified environments, RBAC for enterprise role management, DAC for resource-owner-controlled environments)
- Questions distinguishing between **authentication** (proving identity) and **authorization** (permission to act) — these terms are frequently conflated by candidates
- Identification of **preventive vs. detective vs. corrective** control types — a locked door is preventive, a camera is detective, a revoked access card is corrective
- Questions about **physical access controls**: mantrap/access control vestibule, badge readers, biometrics, and how they layer with technical controls

**Critical Distinctions to Memorize:**
- **Identification ≠ Authentication ≠ Authorization** — know the order and difference
- **DAC** = owner controls permissions (Linux `chmod`, Windows NTFS)
- **MAC** = system enforces policy, owner cannot override (SELinux, classified systems)
- **RBAC** = permissions tied to roles, not individuals (most enterprise environments)
- **ABAC** = fine-grained, evaluates multiple attributes simultaneously
- **Rule-Based Access Control** (sometimes confused with RBAC): access based on rules, such as time-of-day restrictions or firewall ACLs — not the same as *Role*-Based

**Common Gotchas:**
- The exam may call a **mantrap** an **access control vestibule** — know both terms
- **Implicit deny** is a default-deny posture: if no rule explicitly permits an action, it is denied. Firewalls and many IAM systems use this model
- **Context-aware authentication** (also called **adaptive authentication**) considers behavioral attributes like login time, device, and geolocation — this maps to ABAC concepts on the exam
- MFA is a **compensating control** for weak passwords, not a replacement for strong password policy

---

## Security Implications

Access control failures are the leading cause of data breaches. The OWASP Top 10 lists **Broken Access Control** as the #1 most critical web application security risk (A01:2021), present in 94% of applications tested.

**Common Attack Vectors:**

- **Privilege Escalation**: CVE-2021-4034 (PwnKit) allowed any unprivileged user on a Linux system to gain full root privileges by exploiting a flaw in `pkexec`, bypassing all DAC/MAC controls entirely. CVE-2020-0787 (Windows Background Intelligent Transfer Service) allowed local privilege escalation to SYSTEM.
- **Insecure Direct Object Reference (IDOR)**: An attacker modifies a URL or API parameter to access another user's data. Example: changing `/api/invoices/1042` to `/api/invoices/1043` to retrieve another customer's invoice — if the server only checks that the user is authenticated (not that they own record 1043), authorization has failed.
- **Credential Stuffing and Brute Force**: Stolen credential lists are used to authenticate as legitimate users, bypassing authorization controls entirely by presenting valid credentials. Have I Been Pwned tracks billions of leaked credentials used in these attacks.
- **Token Hijacking and Session Fixation**: In federated identity systems, stealing an OAuth Bearer Token grants the attacker the full permissions of the token holder without needing a password.
- **Misconfigured Cloud IAM**: The 2019 Capital One breach (affecting over 100 million customers) was caused by a misconfigured Web Application Firewall combined with an overly permissive IAM role attached to an EC2 instance, allowing the attacker to use the Server Side Request Forgery (SSRF) vulnerability to retrieve AWS credentials from the instance metadata service.
- **Kerberoasting**: Attackers with any valid domain account can request Kerberos service tickets for any service principal name (SPN) in Active Directory and crack them offline — extracting service account credentials and potentially gaining privileged access.

**Detection Indicators:**
- Repeated authentication failures (Event ID 4625 on Windows)
- Logons at unusual hours or from unexpected geolocations
- Sudden privilege changes or new role assignments
- Service accounts interactively logging in (should never occur)
- Access to objects outside of established baselines (UEBA systems detect this)

---

## Defensive Measures

**1. Implement Least Privilege Rigorously**

Audit all user and service account permissions quarterly. Use tools like `BloodHound` in assessment mode to map Active Directory permission paths and find over-privileged accounts. In cloud environments, use AWS IAM Access Analyzer or Azure Access Review to identify unused permissions.

```bash
# Find all SUID binaries on a Linux system (potential privilege escalation vectors)
find / -perm -4000 -type f 2>/dev/null
```

**2. Enforce Multi-Factor Authentication**

Deploy MFA universally for all human accounts, especially privileged ones. Use phishing-resistant MFA (FIDO2/WebAuthn hardware keys like YubiKeys) for administrator accounts — TOTP apps are better than SMS, but FIDO2 is the gold standard.

**3. Implement Privileged Access Management (PAM)**

Use PAM solutions (CyberArk, HashiCorp Vault, BeyondTrust) to vault privileged credentials, enforce just-in-time access, and record all privileged sessions. Service accounts should never have static long-lived passwords.

```bash
# HashiCorp Vault — generate a dynamic database credential (lives for 1 hour)
vault read database/creds/readonly-role
# Returns: username=v-root-readonly-abc123, password=A1B2-xyz, lease_duration=1h
```

**4. Apply Default-Deny (Implicit Deny)**

Configure all firewalls, IAM policies, and application authorization layers to deny all access unless explicitly permitted. In AWS, IAM uses implicit deny by default — all actions are denied unless a policy grants them.

**5. Segregate Roles and Implement SoD**

Separate the development, testing, and production environments with distinct access controls. Use break-glass procedures for emergency privileged access with mandatory post-use review.

**6. Log and Monitor All Access**

Forward authentication and authorization logs to a centralized [[SIEM]] (Splunk, Wazuh, Elastic Security). Configure alerts for:
- Any successful login outside business hours
- First-time access to sensitive resources
- Administrative account usage
- Bulk file access or downloads

**7. Regular Access Reviews (Recertification)**

Schedule quarterly access reviews where managers certify that their direct reports still require their current permissions. Automatically revoke access when employees change roles or leave the organization (joiner-mover-leaver process).

---

## Lab / Hands-On

### Lab 1: Linux Filesystem ACLs (30 min)

Explore extended ACLs on Linux, which go beyond the basic owner/group/other model:

```bash
# Install ACL tools (Debian/Ubuntu)
sudo apt install acl