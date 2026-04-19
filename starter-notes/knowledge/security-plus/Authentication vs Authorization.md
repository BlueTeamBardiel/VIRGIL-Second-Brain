---
domain: "Identity and Access Management"
tags: [authentication, authorization, iam, access-control, identity, security-fundamentals]
---
# Authentication vs Authorization

**Authentication** (AuthN) is the process of verifying *who* an entity is, while **Authorization** (AuthZ) determines *what* that verified entity is permitted to do. These two concepts form the backbone of [[Identity and Access Management]] and are foundational to virtually every security control in modern IT infrastructure — from web applications to [[Active Directory]] to cloud IAM policies. Confusion between the two is one of the most common errors in both exam settings and real-world security design.

---

## Overview

Authentication and authorization are sequential, interdependent processes, but they are fundamentally distinct in purpose and implementation. Authentication answers the question: "Are you who you claim to be?" It involves presenting credentials — something you know (password), something you have (smart card, TOTP token), or something you are (fingerprint, retinal scan) — and having those credentials validated against a trusted authority. Only after successful authentication does the system know *which* identity it is dealing with.

Authorization answers the follow-up question: "What are you allowed to do?" Once the system knows your identity, it consults an access control policy — whether that's a file permission list, a Role-Based Access Control (RBAC) matrix, an Access Control List (ACL), or a policy engine like AWS IAM — to determine which resources you can access and what operations you can perform on them. Authorization happens *after* authentication; you cannot authorize an unknown identity.

The distinction matters enormously in practice. A misconfigured authorization system can allow authenticated users to access resources they should not have — this is a horizontal or vertical privilege escalation scenario. Conversely, a broken authentication system means the identity being authorized cannot be trusted at all. The two failures produce entirely different attack classes and require different mitigations.

In enterprise environments, these responsibilities are often handled by separate systems. Authentication might be delegated to an [[Identity Provider]] (IdP) such as Microsoft Entra ID (formerly Azure AD), Okta, or a Kerberos Key Distribution Center (KDC). Authorization is then enforced by resource servers, firewalls, or policy engines that consume identity tokens (e.g., SAML assertions, OAuth 2.0 access tokens, Kerberos service tickets) issued by the IdP.

A useful real-world analogy: authentication is the airport security checkpoint that verifies your passport and boarding pass. Authorization is the gate agent checking whether your ticket permits you to board the specific flight, sit in first class, or bring a carry-on. Both steps must succeed, in order, for you to reach your destination.

---

## How It Works

### Authentication Flow

Authentication mechanisms vary by protocol, but the general pattern is consistent:

1. **Identity Claim**: The subject presents an identifier — a username, email address, certificate Subject Alternative Name (SAN), or Kerberos principal.
2. **Credential Presentation**: The subject provides proof — a password hash, a signed challenge response, a one-time password (OTP), or a biometric template.
3. **Verification**: An authentication authority (local SAM database, LDAP directory, RADIUS server, OAuth IdP) validates the proof against stored data.
4. **Session Establishment**: On success, the system issues a session token, Kerberos ticket, JWT, or SAML assertion representing the authenticated session.

**Example: Kerberos (Windows Domain Authentication)**
```
Client → KDC (AS): AS-REQ (username + pre-auth encrypted timestamp)
KDC (AS) → Client: AS-REP (TGT encrypted with krbtgt key + session key)
Client → KDC (TGS): TGS-REQ (TGT + service SPN requested)
KDC (TGS) → Client: TGS-REP (Service Ticket encrypted with service account key)
Client → Application Server: AP-REQ (Service Ticket presented)
Application Server → Client: AP-REP (mutual auth confirmation)
```
Port: **UDP/TCP 88** (Kerberos), **TCP 389/636** (LDAP/LDAPS for user lookup)

**Example: OAuth 2.0 / OIDC Authentication**
```
User → Client App: Login request
Client App → Authorization Server: Authorization Code Request (redirect)
User → Authorization Server: Authenticates (credentials, MFA)
Authorization Server → Client App: Authorization Code
Client App → Authorization Server: Token Request (code + client_secret)
Authorization Server → Client App: ID Token (JWT) + Access Token
```

**Verifying a JWT locally (Python):**
```python
import jwt

token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."
public_key = open("public_key.pem").read()

decoded = jwt.decode(
    token,
    public_key,
    algorithms=["RS256"],
    audience="https://api.example.com"
)
print(decoded)  # Contains sub (subject/identity), exp, iat, roles
```

### Authorization Flow

After authentication produces a verified identity, authorization enforcement works as follows:

1. **Policy Lookup**: The system retrieves the access control policy for the requested resource. This may be a UNIX file permission bitmask, an ACL entry in Active Directory, an AWS IAM policy document, or a database row-level security rule.
2. **Attribute Evaluation**: The identity's attributes (group memberships, roles, claims, clearance level) are compared against the policy.
3. **Decision**: The Policy Decision Point (PDP) renders a **Permit** or **Deny** verdict.
4. **Enforcement**: The Policy Enforcement Point (PEP) — a kernel, API gateway, firewall, or application middleware — enforces the decision.

**Linux file permission check (simplified kernel logic):**
```bash
# File: /etc/shadow  Permissions: 640  Owner: root  Group: shadow
ls -la /etc/shadow
# -rw-r----- 1 root shadow 1423 Jan 10 09:00 /etc/shadow

# User 'alice' (uid=1001, groups=alice,shadow):
# Kernel checks: alice != root → not owner
# alice in group shadow? Yes → apply group permissions (r--)
# alice can READ but NOT WRITE /etc/shadow
```

**AWS IAM Policy (JSON) — Authorization document:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:ListBucket"],
      "Resource": "arn:aws:s3:::company-logs/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": "10.0.0.0/8"}
      }
    }
  ]
}
```
This policy *authorizes* the identity to read from a specific S3 bucket, but only from a private IP range — even a fully authenticated user is denied if they connect from the wrong network.

---

## Key Concepts

- **Authentication (AuthN)**: The process of verifying identity by validating credentials against a trusted authority. Produces a verified principal that can be referenced by authorization systems. Failure here means the entire access chain is compromised.
- **Authorization (AuthZ)**: The process of determining what permissions a verified identity holds for a given resource. Implemented through ACLs, RBAC, ABAC, or MAC policies. Happens strictly *after* authentication.
- **AAA Framework**: **Authentication, Authorization, and Accounting** — the three pillars of access management. Accounting (logging who did what and when) completes the triad and is essential for auditing and forensics. Implemented by protocols such as [[RADIUS]] and [[TACACS+]].
- **Principle of Least Privilege (PoLP)**: A core authorization doctrine stating that subjects should be granted only the minimum permissions necessary to perform their legitimate function. Violations are a primary cause of insider threat and lateral movement damage.
- **Access Control Models**: The framework governing how authorization decisions are structured. Key models include **DAC** (Discretionary — owner sets permissions), **MAC** (Mandatory — system enforces labels), **RBAC** (Role-Based — permissions tied to roles), and **ABAC** (Attribute-Based — policies use environmental attributes like time, location, device posture).
- **Federation and Delegation**: Mechanisms allowing one system to trust authentication decisions made by another. OAuth 2.0 delegates authorization to a resource owner; SAML federates authentication across organizational boundaries. A critical distinction: OAuth 2.0 is an *authorization* framework, not an authentication protocol (OIDC adds the identity layer on top).
- **Token vs. Session**: Post-authentication, identity is carried by a session cookie (stateful, server-side) or a cryptographic token like a JWT (stateless, self-contained). JWTs embed authorization claims (roles, scopes) directly in the token, blurring the boundary between AuthN and AuthZ artifacts.

---

## Exam Relevance

The Security+ SY0-701 exam tests authentication vs. authorization primarily within **Domain 4.0 (Security Operations)** and **Domain 5.0 (Security Program Management)**, specifically around access control models and IAM implementation.

**High-probability question patterns:**

- **Scenario questions** will describe a situation and ask whether the problem is an *authentication* or *authorization* failure. Key tell: if the user *can't log in* → authentication. If the user *logs in successfully but can't access a resource they should* → authorization. If the user *accesses a resource they shouldn't* → authorization failure (misconfigured ACL/policy).
- **AAA Protocol questions**: Know that **RADIUS** encrypts only the password in the Access-Request packet; **TACACS+** encrypts the *entire* payload. TACACS+ separates authentication, authorization, and accounting into discrete functions — RADIUS combines AuthN and AuthZ.
- **OAuth vs. OIDC**: The exam commonly asks about the purpose of each. **OAuth 2.0 = authorization** (grants access tokens for resource access). **OpenID Connect (OIDC) = authentication** (adds ID tokens to OAuth for identity verification). This is a deliberate trick.
- **MFA factors**: Know the three factor categories (knowledge, possession, inherence) and that combining two of the *same* category (two passwords) is **not** MFA — it's two-factor verification of the same type, and still single-factor authentication.
- **SAML, OAuth, OIDC, Kerberos**: Be able to match each to its primary use case (SSO, API authorization, federated identity, domain authentication respectively).

**Common gotchas:**
- A certificate on a web server authenticates the *server* to the *client*, not the user. Don't confuse TLS server authentication with user authentication.
- "Access denied after successful login" is always an **authorization** problem. The exam will include answer choices with "authentication" to trap you.

---

## Security Implications

**Authentication Vulnerabilities:**
- **Credential Stuffing / Password Spraying**: Attackers exploit weak passwords or reused credentials. No MFA = no second layer of defense. Responsible for the 2022 Uber breach (MFA fatigue via push bombing).
- **Pass-the-Hash (PtH)**: In Windows environments, NTLM authentication can be abused by capturing a user's NTLM hash and replaying it without knowing the plaintext password. **CVE-2012-0002** (MS12-020) and numerous subsequent advisories. Tools: Mimikatz, Impacket's `psexec.py`.
- **Kerberoasting**: Authenticated domain users can request service tickets for any SPN-registered service account. The ticket is encrypted with the service account's password hash and can be cracked offline. No CVE needed — it's a protocol feature misuse.
- **JWT Attacks**: Algorithm confusion (setting `alg: none`), weak HMAC secrets, and key confusion attacks (RS256→HS256 substitution) allow forging authentication tokens. **CVE-2022-21449** (Psychic Signatures — Java ECDSA bypass) allowed signing of arbitrary JWTs.

**Authorization Vulnerabilities:**
- **Insecure Direct Object Reference (IDOR)**: A user changes `?account_id=1001` to `?account_id=1002` and accesses another user's data. The server authenticates the user but fails to verify they are *authorized* for that specific object. Consistently appears in OWASP Top 10 as **Broken Access Control**.
- **Privilege Escalation**: Vertical escalation (gaining higher privileges) via misconfigured sudo rules (`NOPASSWD: ALL`), SUID binaries, or token impersonation. Horizontal escalation (accessing peer accounts) via IDOR, session fixation.
- **OAuth Misconfiguration**: Overly broad scopes, missing `state` parameter (CSRF), open redirect URIs. The 2012 Facebook OAuth flaw allowed account takeover via redirect URI manipulation.

---

## Defensive Measures

**Authentication Hardening:**
- Enforce **MFA** on all privileged accounts and internet-facing services. Use FIDO2/WebAuthn hardware keys (YubiKey) for phishing-resistant authentication. Push-based MFA (Duo, Microsoft Authenticator) is better than SMS but vulnerable to fatigue attacks.
- Implement **account lockout policies** and **adaptive authentication** (risk-based step-up for anomalous logins). Tools: Azure AD Conditional Access, Okta Adaptive MFA, Duo's Risk-Based Authentication.
- Deploy a **Password Manager** and enforce minimum complexity via [[Have I Been Pwned]] API integration (checking against known-breached passwords), supported natively in Microsoft Entra ID Password Protection.
- Disable NTLM authentication where possible; enforce Kerberos. Deploy **Microsoft Defender for Identity** (formerly ATA) to detect PtH, Kerberoasting, and Golden Ticket attacks.

**Authorization Hardening:**
- Apply **Principle of Least Privilege** systematically. Conduct quarterly **access reviews** (recertification campaigns) using tools like SailPoint, Saviynt, or native Azure AD Access Reviews.
- Implement **RBAC** rather than direct user-to-resource assignments. Define roles by job function; avoid role explosion (too many fine-grained roles become unmanageable).
- For APIs, enforce **scope validation** on every request, not just at login. Use an API Gateway (Kong, AWS API Gateway, NGINX with OAuth) to centralize authorization enforcement.
- Log **all authorization decisions** (permit and deny) to a [[SIEM]]. Alert on repeated denials (potential enumeration), cross-tenant access, or access outside business hours.

**Specific configurations:**
```bash
# Linux: Audit file access attempts (authorization events) with auditd
auditctl -w /etc/sudoers -p rwa -k sudoers_change
auditctl -w /etc/shadow -p r -k shadow_read_attempt

# Review sudo permissions for privilege creep
sudo -l -U username

# Find SUID binaries (potential privilege escalation vectors)
find / -perm -4000 -type f 2>/dev/null
```

---

## Lab / Hands-On

### Lab 1: Observe Authentication vs. Authorization Failures in a Web App

Use **DVWA (Damn Vulnerable Web Application)** or **OWASP WebGoat** to distinguish the two failure types:

```bash
# Deploy DVWA via Docker
docker run --rm -it -p 80:80 vulnerables/web-dvwa

# Navigate to http://localhost
# Default credentials: admin / password  (Authentication)

# Attempt to access /dvwa/vulnerabilities/sqli/ as 'user' role
# Compare what admin vs. gordonb can access → Authorization difference
```

### Lab 2: JWT Inspection and Manipulation

```bash
# Install jwt_tool
pip3 install jwt_tool

# Decode a JWT without verification to inspect claims
python3 jwt_tool.py eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VyMSIsInJvbGUiOiJ1c2VyIn0.SIGNATURE

# Attempt algorithm confusion (alg:none attack) for lab understanding
python3 jwt_tool.py <token> -X a

# This demonstrates: authentication token carries authorization claims (role)
# Forging the token bypasses BOTH mechanisms simultaneously
```

### Lab 3: Active Directory — Authentication (Kerberos) vs. Authorization (ACL)

```powershell
# On a Windows Server DC in your homelab (Virtualbox/Proxmox)

# View Kerberos ticket for current user (Authentication artifact)
klist