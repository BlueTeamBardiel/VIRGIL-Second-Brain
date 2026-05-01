---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 28
source: rewritten
---

# Logical Security
**Controlling who can access what resources by granting only the minimum necessary permissions to prevent unauthorized system compromise.**

---

## Overview

Logical security is the digital gatekeeper system that determines which users can do what on your network. Unlike physical security (locks and badges), logical security lives in permissions, authentication, and access controls. For the A+ exam, you need to understand how organizations prevent both external attackers AND internal threats by limiting what each user and application can actually do.

---

## Key Concepts

### Least Privilege

**Analogy**: Imagine a restaurant where every employee gets a master key to all areas. If one employee steals a key or gets tricked into opening the vault, the entire restaurant is compromised. Instead, the manager only gives the dishwasher access to the kitchen sink area, the server access to the dining room, and the accountant access to the safe—nothing more.

**Definition**: [[Least Privilege]] is a security principle where users, applications, and processes receive only the minimum access rights required to complete their assigned job functions. Nothing extra, nothing "just in case."

**Why it matters**: When [[malware]] or an attacker breaches one user account running with admin rights, they instantly own your entire network. With least privilege, a compromised account is a limited account.

---

### Zero Trust Architecture

**Analogy**: Traditional networks are like a castle with massive walls (border security) but anyone inside the castle can roam freely. Zero Trust says: treat your network like a high-security bank where every employee, visitor, and delivery truck must show ID and get scanned—no matter where they're coming from, whether the lobby or the back door.

**Definition**: [[Zero Trust]] is a security model that assumes no device, user, or application is inherently trustworthy—whether inside or outside the network perimeter. Every entity must authenticate and authorize before accessing resources.

| Aspect | Traditional Network | Zero Trust |
|--------|-------------------|-----------|
| Perimeter Focus | Heavy border security only | Security everywhere |
| Internal Trust | Assumed after firewall | Never assumed |
| Authentication | Usually required once | Continuous verification |
| Lateral Movement | Easy within network | Blocked/monitored |
| Risk Profile | High interior exposure | Low across all zones |

**Implementation Reality**: Organizations using zero trust deploy [[MFA]] (multi-factor authentication), [[microsegmentation]], continuous monitoring, and verification on every internal transaction—not just entry points.

---

### Access Control Lists (ACLs)

**Analogy**: Think of an ACL like a nightclub's VIP list. The bouncer checks your name: if you're on the approved list, you're in; if you're not listed, you're out—simple as that.

**Definition**: [[Access Control Lists]] are detailed registers that specify exactly which users or groups can perform which actions on specific resources (files, folders, printers, network shares). Each entry grants or denies permission.

**Common ACL Actions**:
- Read (view contents)
- Write (modify contents)
- Execute (run/launch)
- Delete (remove)
- Change Permissions (modify ACL itself)

---

### Authentication vs. Authorization

**Analogy**: Authentication is showing your driver's license to prove you're really you (identity verification). Authorization is the bouncer checking the list and saying "OK, you're on the VIP list, you can enter the back room" (permission granting).

| Element | Authentication | Authorization |
|---------|----------------|---------------|
| Question Asked | "Are you who you claim?" | "What are you allowed to do?" |
| Method | Passwords, biometrics, [[MFA]] | [[ACLs]], role-based access, policies |
| Happens When | First login / access request | After authentication succeeds |
| Examples | Login credentials verified | User can modify File X but not File Y |

**Code Block - Conceptual**:
```
User attempts access
     ↓
[AUTHENTICATE: Verify identity via password/MFA]
     ↓
IF identity confirmed:
  [AUTHORIZE: Check ACL for permissions]
    ↓
    IF permissions exist:
      Grant access
    ELSE:
      Deny access
ELSE:
  Deny access
```

---

### Privilege Escalation & Privilege Creep

**Analogy**: You start as a junior cashier (limited access to the register). Over five years, you get promoted, switch departments, and nobody removes your old cashier access. Now you can access the register, inventory, payroll, and the safe—even though you only need the payroll access for your current job.

**Definition**: [[Privilege Creep]] occurs when users accumulate excess permissions over time as they change roles, departments, or responsibilities without anyone revoking their old access rights. [[Privilege Escalation]] is when a user (or attacker) intentionally or accidentally gains higher-level permissions than intended.

**Why it matters for A+**: Regularly auditing user permissions (called *access reviews*) prevents security disasters. One day a disgruntled employee realizes they still have admin access from 2018.

---

### Role-Based Access Control (RBAC)

**Analogy**: Instead of giving each employee individual keys, you create job titles (roles) like "Manager," "Developer," and "Accountant"—each role gets a standard keyring. New employees inherit their role's keyring immediately.

**Definition**: [[Role-Based Access Control]] groups users into roles, and each role receives a predefined set of permissions. Users inherit permissions based on their role assignment, not individual ad-hoc grants.

**RBAC in Practice**:
- **Role**: Sales Associate
- **Permissions**: Read customer database, modify own sales records, print invoices
- **Limitations**: Cannot access HR records, cannot modify other associates' data, cannot delete database entries

---

### Multi-Factor Authentication (MFA)

**Analogy**: Your ATM card alone isn't enough to withdraw cash—you also need your PIN. The card proves *who you have* (something you possess), the PIN proves *what you know* (something you know). Together they authenticate your identity far better than either alone.

**Definition**: [[MFA]] requires users to provide two or more types of evidence before gaining access. Common factors include:
- **Something you know**: Password, PIN, security question
- **Something you have**: Phone, security key, smartcard
- **Something you are**: Fingerprint, facial recognition, iris scan
- **Somewhere you are**: Geographic location verification

**On the A+ Exam**: MFA dramatically reduces account compromise risk even if passwords are weak. A stolen password without the second factor is useless.

---

## Exam Tips

### Question Type 1: Principle Identification
- *"A user needs to access only the sales database for their daily work. Which security principle should you apply?"* → **Least Privilege** — grant only database access, no file server, no admin rights
- **Trick**: The exam might describe a scenario where IT gives users admin rights "to avoid calls" or "for convenience"—recognize this as *violating* least privilege and be ready to identify it as wrong

### Question Type 2: Zero Trust vs. Traditional Network
- *"Your organization implements a security model where every access request—internal or external—requires authentication. What is this called?"* → **Zero Trust**
- **Trick**: Don't confuse "zero trust" with "no trust in users" (paranoia). It's about *verification*, not paranoia

### Question Type 3: Authentication Method Matching
- *"Which MFA combination is most secure: password + security question OR password + push notification to phone?"* → **Password + push notification** — security questions can be researched/guessed; phone possession factor adds real security
- **Trick**: Exam may list two factors that seem similar but one is weaker (e.g., two passwords vs. password + biometric)

### Question Type 4: ACL Scenario
- *"User A needs to read files but not modify them. How do you configure the ACL?"* → Grant **Read** permission, deny or omit **Write** permission
- **Trick**: Remember that ACLs can explicitly deny (which overrides allow) or simply omit permissions (implicit deny)

---

## Common Mistakes

### Mistake 1: Confusing Least Privilege with "No Permissions"
**Wrong**: "Least privilege means users get almost no access—they'll constantly ask IT for permissions."
**Right**: Least privilege means users get *exactly* the permissions they need to do their job, no more, no less. A developer needs compiler access and code repository access, and they *should* have that immediately.
**Impact on Exam**: You might see scenarios where IT denies legitimate access requirements. Recognize this as *not* least privilege; it's over-restriction. The answer is usually "grant the minimum necessary permissions for that role."

---

### Mistake 2: Treating Zero Trust as "Never Trust Any Device"
**Wrong**: "Zero trust means we treat employee laptops the same as unknown internet-of-things devices."
**Right**: Zero trust means verification is *continuous* and *required*, but you can still trust a device that successfully authenticates and maintains compliance. It's "trust, but verify"—not "never trust."
**Impact on Exam**: A question might ask how zero trust handles an employee's company laptop. The answer isn't "reject it"—it's "require authentication and validation, then grant access based on compliance status."

---

### Mistake 3: Assuming MFA is Only Passwords + Texts
**Wrong**: "MFA = password + SMS text code."
**Right**: MFA is any combination of two or more factor types. SMS, app notifications, hardware keys, biometrics, email codes, and others all qualify. SMS is actually considered weaker than app-based or hardware-based factors.
**Impact on Exam**: When selecting the most secure MFA method, pick hardware key or app-based factor over SMS. Recognize SMS interception as a weakness (SIM swapping attacks).

---

### Mistake 4: Forgetting Authorization Happens *After* Authentication
**Wrong**: "Authentication and authorization are the same thing—they both control who can access what."
**Right**: Authentication is identity verification (am I really you?). Authorization is permission granting (what can you actually do?). You must authenticate first; authorization follows automatically if credentials are valid.
**Impact on Exam**: Scenario: "User logs in with correct password but still cannot access a file." The issue is not authentication (that succeeded); it's **authorization** (no permission in the ACL). Recognize this distinction.

---

### Mistake 5: Not Recognizing Privilege Creep as a Real Threat
**Wrong**: "If someone has extra permissions they're not using, it doesn't matter—they just won't use them."
**Right**: Extra permissions represent a risk. If that account is compromised by malware or a social engineer, the attacker gains all accumulated permissions. A compromised account with 5 years of creep can access systems it has no business touching.
**Impact on Exam**: Questions about user audits, access reviews, or off-boarding processes are identifying privilege creep. The correct answer always involves removing unnecessary permissions during role changes or departures.

---

## Related Topics
- [[Authentication Methods]] (passwords, biometrics, smart cards)
- [[Access Control Models]] (DAC, MAC, RBAC)
- [[Network Segmentation & Microsegmentation]]
- [[User Account Management]] (creation, modification, deletion)
- [[Principle of Least Privilege Applications]]
- [[Security Policy & Compliance]]
- [[Encryption & Data Protection]]
- [[Audit Logs & Monitoring]]

---

*Source: CompTIA A+ Core 2 (220-1202) Logical Security | [[A+]] Study Companion*