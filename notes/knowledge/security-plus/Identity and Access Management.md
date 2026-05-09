# Identity and Access Management

## What it is

In Assassin's Creed, your hidden blade only deploys because Altaïr cut off his ring finger as proof of brotherhood — the Assassins know who he is, the Bureau Leader verifies he belongs, and only then does Malik hand him a target dossier with the specific permissions to act. That's exactly what Identity and Access Management does — it confirms who you are, proves you belong, and grants only the privileges your role requires.

**Identity and Access Management (IAM)** is the framework of policies, processes, and technologies used to provision, authenticate, authorize, and de-provision digital identities across the lifecycle of users, devices, and services accessing organizational resources.

## Why it matters

When IAM fails, attackers don't need to break the door — they walk in with a valid badge. Stolen credentials remain the leading initial access vector in real breaches, and orphaned accounts from sloppy de-provisioning are how former employees end up exfiltrating customer lists. For SY0-701 Objective 4.6, you must know **provisioning/de-provisioning**, **permission assignments**, **identity proofing**, **federation**, **SSO** (SAML, OAuth, OIDC), **interoperability**, **attestation**, **access controls** (MAC, DAC, RBAC, ABAC, rule-based), **MFA factors and attributes**, **password concepts**, and **privileged access management**. CompTIA's favorite trap: confusing **authentication** (proving identity) with **authorization** (granting permissions) — they will write a question where the right answer hinges on that distinction.

## Key facts

### The IAM Lifecycle

| Phase | What happens | Failure mode |
|---|---|---|
| **[[Provisioning]]** | Account created, attributes assigned, initial access granted | Excessive birthright access |
| **[[Identity Proofing]]** | Verifying the human matches the claimed identity | Synthetic identity fraud |
| **[[Authentication]]** | Proving you are who you claim | Credential theft |
| **[[Authorization]]** | Determining what you can do | Privilege creep |
| **[[Attestation]]** | Periodic review confirming access is still appropriate | Orphaned accounts |
| **[[De-provisioning]]** | Removing access when role changes or employment ends | Insider data theft |

### Authentication Factors

- **Something you know** — [[Password]], PIN, security question
- **Something you have** — [[Smart card]], [[Hardware token]], [[TOTP]] app, [[FIDO2]] key
- **Something you are** — [[Biometrics]] (fingerprint, retina, facial)
- **Somewhere you are** — [[Geolocation]], IP-based
- **Something you do** — Behavioral biometrics, gait, keystroke dynamics

[[MFA]] requires factors from **different categories**. Two passwords is not MFA. CompTIA loves this trap.

### Access Control Models

| Model | Decision basis | Example |
|---|---|---|
| **[[MAC]]** (Mandatory) | System-enforced labels (TS/S/C/U) | Military classification |
| **[[DAC]]** (Discretionary) | Object owner decides | Windows NTFS, Unix `chmod` |
| **[[RBAC]]** (Role-Based) | User's assigned role | "Accountants can read GL" |
| **[[ABAC]]** (Attribute-Based) | Policy evaluating attributes | "Managers in EU during business hours" |
| **[[Rule-Based Access Control]]** | Pre-defined rules independent of identity | Firewall ACLs, time-of-day restrictions |

### Federation and SSO Protocols

| Protocol | Purpose | Format | Typical use |
|---|---|---|---|
| **[[SAML]]** 2.0 | Federated SSO | XML assertions | Enterprise web SSO |
| **[[OAuth]]** 2.0 | Delegated **authorization** | Bearer tokens | API access |
| **[[OpenID Connect]]** (OIDC) | **Authentication** layer on OAuth 2.0 | JWT ID tokens | Modern web/mobile login |
| **[[Kerberos]]** | On-prem SSO with tickets | TGT/TGS | Active Directory (port 88) |
| **[[LDAP]]** / **[[LDAPS]]** | Directory queries | Hierarchical DN | AD lookups (389/636) |
| **[[RADIUS]]** | AAA for network access | UDP (1812/1813) | Wi-Fi, VPN |
| **[[TACACS+]]** | AAA, separates AuthN/AuthZ | TCP 49 | Network device admin |

OAuth ≠ authentication. OIDC adds authentication on top. CompTIA will test this.

### Privileged Access Management ([[PAM]])

- **[[Just-in-time access]]** — privileges granted on request, expire automatically
- **[[Password vaulting]]** — credentials checked out, rotated after use
- **[[Ephemeral credentials]]** — short-lived secrets, no standing privilege
- **Session recording and monitoring** — every privileged action logged
- **Break-glass accounts** — emergency access, heavily audited

### Password Concepts

- **Length > complexity** — current guidance favors longer passphrases
- **[[Password Manager]]** — generates and stores unique credentials
- **[[Passwordless]]** — FIDO2/WebAuthn, certificates, biometrics replace passwords
- **Password policies** — length, complexity, age, history, lockout threshold
- **[[Knowledge-based authentication]]** (KBA) — security questions, weak in practice

### Permissions Hygiene

- **[[Principle of Least Privilege]]** — minimum access needed for the job
- **[[Separation of Duties]]** — no single person controls a complete sensitive process
- **[[Privilege Creep]]** — accumulated access from role changes; killed by **attestation reviews**
- **[[Service Accounts]]** — non-human identities; require vaulting, rotation, no interactive login

## Related concepts

[[Zero Trust]] · [[Conditional Access]] · [[Single Sign-On]] · [[Directory Services]] · [[Active Directory]] · [[Kerberos]] · [[SAML]] · [[OAuth]] · [[OIDC]] · [[MFA]] · [[FIDO2]] · [[RBAC]] · [[ABAC]] · [[PAM]] · [[Principle of Least Privilege]] · [[Separation of Duties]] · [[Identity Proofing]] · [[Federation]]

---
*Source: VIRGIL knowledge base — 2026-05-08*