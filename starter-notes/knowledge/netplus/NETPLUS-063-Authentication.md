---
tags: [knowledge, netplus, network-plus]
created: 2026-05-01
cert: CompTIA Network+
exam: N10-009
chapter: 063
source: rewritten
---

# Authentication
**The process of verifying user identity and controlling system access through a structured framework of verification, permission, and monitoring.**

---

## Overview
Authentication is the foundational security mechanism that ensures only legitimate users gain entry to network resources. While most people think of authentication as simply entering a username and password, the reality involves a multi-layered system working behind the scenes. For Network+ professionals, understanding how identification, [[authentication]], [[authorization]], and [[accounting]] work together is critical for implementing secure network infrastructure.

---

## Key Concepts

### Identification
**Analogy**: Identification is like showing up to a concert venue and telling the bouncer your name—it's publicly available information that anyone might know, but it doesn't grant you entry.
**Definition**: The process of claiming who you are through a [[username]], [[email address]], or other public identifier that doesn't require secrecy.

| Characteristic | Details |
|---|---|
| Visibility | Publicly known or easily discoverable |
| Security Value | None on its own |
| Examples | Username, email, employee ID, user account name |
| Risk | Knowing someone's identifier does not compromise security |

---

### Authentication
**Analogy**: Think of authentication like using a key to unlock your front door—only you have the key, so presenting it proves you're really you.
**Definition**: The act of proving your claimed identity through something only you should possess or know, such as a [[password]], [[PIN]], [[biometric]], or [[multi-factor authentication]].

| Authentication Method | How It Works | Strength |
|---|---|---|
| Single-factor (Password) | Knowledge of secret credential | Basic |
| Multi-factor (MFA) | Combination of factors | Strong |
| [[Biometric]] | Physical characteristics | Very Strong |
| [[Hardware Token]] | Physical possession device | Very Strong |

**Common Authentication Factors**:
- Something you **know**: passwords, PINs, security questions
- Something you **have**: security tokens, smart cards, hardware keys
- Something you **are**: fingerprints, facial recognition, iris scans
- Somewhere you **are**: geolocation verification
- Something you **do**: behavioral biometrics, typing patterns

---

### Authorization
**Analogy**: After showing your concert ticket (authentication), authorization is the usher checking which sections you're allowed to access—VIP areas versus general admission.
**Definition**: The process of granting verified users specific permissions and access levels to [[network resources]], [[files]], [[directories]], and [[services]] based on their identity and role.

| Element | Purpose |
|---|---|
| [[Role-Based Access Control (RBAC)]] | Permissions assigned by job function |
| [[Attribute-Based Access Control (ABAC)]] | Permissions based on user attributes |
| [[Access Control List (ACL)]] | Specific resource permissions |
| Principle of Least Privilege | Users receive minimum necessary access |

**Authorization doesn't verify identity—it controls what verified users can do.**

---

### Accounting
**Analogy**: Accounting is like a security camera recording everyone who enters and leaves the building, creating an audit trail of who did what and when.
**Definition**: The process of tracking, logging, and monitoring all user activities—login times, logout times, resource access, and actions taken—for security audits and compliance.

**What gets logged**:
- User login/logout timestamps
- Accessed resources and files
- Failed authentication attempts
- Configuration changes
- Network traffic from specific users

**Why it matters**: Creates accountability, enables forensic investigation, and supports compliance requirements.

---

## The AAA Framework

| Framework Component | Focus | Question Answered |
|---|---|---|
| **Authentication** | Identity verification | "Are you really who you claim to be?" |
| **Authorization** | Access control | "What are you allowed to do?" |
| **Accounting** | Activity tracking | "What did you do, when, and where?" |

**Example flow**: You log in with credentials (authentication) → system grants you access to finance folders only (authorization) → every file you open is logged with timestamp (accounting).

---

## Exam Tips

### Question Type 1: Identifying AAA Components
- *"A network administrator needs to ensure that employees can only access files relevant to their department. Which AAA component does this describe?"* → **Authorization** (controlling what verified users can access)
- **Trick**: Confusing authentication (verifying WHO you are) with authorization (controlling WHAT you can do). Authentication happens first; authorization follows.

### Question Type 2: Authentication Methods
- *"Which authentication method combines something you know with something you have?"* → **Multi-factor authentication (MFA)**
- **Trick**: Single-factor authentication using only a password is no longer considered best practice, but many legacy systems still use it.

### Question Type 3: Accounting Scenarios
- *"A security audit requires tracking when users accessed sensitive files. Which AAA component provides this?"* → **Accounting** (logging and monitoring)
- **Trick**: Many candidates confuse accounting with authorization—remember: accounting is about the audit trail, not access control.

---

## Common Mistakes

### Mistake 1: Treating Identification as Authentication
**Wrong**: "Since I know the CEO's username, I can authenticate as them."
**Right**: Identification (username) is public; authentication requires secret credentials only the user possesses.
**Impact on Exam**: Questions may present a scenario involving leaked usernames—the correct answer is that this doesn't compromise security without the corresponding password/factors.

### Mistake 2: Conflating Authorization with Authentication
**Wrong**: "Once authorized, the user is authenticated."
**Right**: Authentication establishes identity; authorization grants permissions. They're sequential, not synonymous.
**Impact on Exam**: Scenario-based questions often test whether you understand that authentication must occur before authorization decisions are made.

### Mistake 3: Ignoring Accounting's Security Value
**Wrong**: "Accounting is just administrative overhead, not real security."
**Right**: Accounting creates accountability, enables breach detection, and provides forensic evidence.
**Impact on Exam**: Compliance and incident response questions heavily feature accounting requirements; underestimating its importance costs points.

### Mistake 4: Assuming All Factors Are Equally Strong
**Wrong**: "Any two-factor authentication is equally secure."
**Right**: MFA effectiveness depends on factor diversity—password + password ≠ password + fingerprint.
**Impact on Exam**: Questions about authentication strength require understanding which factor combinations are truly multi-factor.

---

## Related Topics
- [[Multi-Factor Authentication (MFA)]]
- [[Password Security]]
- [[Role-Based Access Control (RBAC)]]
- [[Access Control Lists (ACL)]]
- [[RADIUS Protocol]]
- [[TACACS+]]
- [[LDAP and Active Directory]]
- [[Single Sign-On (SSO)]]
- [[Public Key Infrastructure (PKI)]]
- [[Biometric Authentication]]
- [[Network Security Best Practices]]

---

*Source: Professor Messer CompTIA Network+ N10-009 | [[Network+]]*