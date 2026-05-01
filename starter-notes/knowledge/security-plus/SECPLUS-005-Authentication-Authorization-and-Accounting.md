---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 005
source: rewritten
---

# Authentication, Authorization, and Accounting
**The three-pillar framework that verifies who you are, controls what you can access, and documents everything you do.**

---

## Overview
The [[AAA Framework]] forms the backbone of access control in modern security systems. You'll encounter AAA concepts throughout the Security+ exam because they apply to nearly every authentication scenario—from [[VPN]] connections to network device access. Understanding how these three components work together (and separately) is essential for securing any IT infrastructure.

---

## Key Concepts

### Identification
**Analogy**: Imagine walking into a bank and telling the teller "I'm John Smith." You've announced who you are, but they have no proof yet—that's identification.
**Definition**: The process where a user claims an identity on a system, typically by providing a [[username]] or account name. This is simply a claim with no verification attached.
[[Authentication]] | [[Authorization]] | [[Accounting]]

### Authentication
**Analogy**: The bank teller now asks for your driver's license and verifies it matches the name you claimed. That verification process is authentication.
**Definition**: The verification mechanism that confirms a user is actually who they claim to be. This involves checking credentials against known secrets, such as [[passwords]], [[multi-factor authentication]], [[biometric]] data, or [[certificates]].

**Authentication Methods**:

| Method | Description | Strength |
|--------|-------------|----------|
| [[Password]] | Single secret known only to user | Low |
| [[Multi-Factor Authentication (MFA)]] | Combines 2+ authentication factors | High |
| [[Public Key Infrastructure (PKI)]] | Certificate-based verification | Very High |
| [[Biometrics]] | Fingerprint, facial recognition, iris scan | High |
| [[TACACS+]] | Network authentication protocol | Medium-High |
| [[RADIUS]] | Centralized authentication service | Medium-High |

### Authorization
**Analogy**: After the bank verifies you're John Smith, they check what accounts you own and what transactions you're allowed to make. A regular customer can't access the vault—that's authorization.
**Definition**: The process of determining what resources, systems, and data a verified user is permitted to access. [[Authorization]] happens *after* [[authentication]] succeeds and is based on user roles, group memberships, and access control policies.

**Key Authorization Concepts**:
- [[Role-Based Access Control (RBAC)]] — Access granted based on job position
- [[Attribute-Based Access Control (ABAC)]] — Access granted based on user attributes and environmental conditions
- [[Access Control List (ACL)]] — Explicit permissions attached to resources
- [[Principle of Least Privilege]] — Users receive only minimum access needed

### Accounting
**Analogy**: The bank records every deposit, withdrawal, and account change in a ledger. If something goes wrong later, they can review the complete transaction history.
**Definition**: The tracking and logging of user activities, resource consumption, and security events. [[Accounting]] creates an audit trail that records *who* did *what*, *when*, and *how much*. This supports compliance, forensics, and incident investigation.

**Accounting Data Captured**:
- [[Login]] timestamps and [[logout]] times
- Data transmitted/received amounts
- Commands executed
- Resources accessed
- Failed access attempts
- Configuration changes

### The AAA Framework in Action
**Comparison Table**:

| Component | Purpose | Question Asked | Example |
|-----------|---------|-----------------|---------|
| [[Authentication]] | Verify identity | "Are you really Sarah?" | Check password against hash |
| [[Authorization]] | Grant permissions | "Should Sarah access this file?" | Check if Sarah's role allows file access |
| [[Accounting]] | Document activity | "What did Sarah do?" | Log shows Sarah accessed file at 2:34 PM, copied 5MB |

---

## Exam Tips

### Question Type 1: Distinguishing the Three A's
- *"A user provides their username and password to log into a system. What AAA process is occurring?"* → [[Authentication]]
  - **Trick**: Don't confuse identification (the username claim) with authentication (verifying the password)
  
- *"A network administrator assigns a user to the 'Finance' group, which grants read-only access to the accounting database. What AAA process is occurring?"* → [[Authorization]]
  - **Trick**: Authorization happens *after* authentication succeeds; it's about permissions, not verification

- *"A [[SIEM]] collects logs showing that user 'jsmith' logged in at 9:00 AM, accessed 3 files, and logged out at 5:15 PM. What AAA process is occurring?"* → [[Accounting]]
  - **Trick**: Accounting is purely about documenting activity—it doesn't grant or deny access

### Question Type 2: Protocol and Service Recognition
- *"Which protocol provides centralized authentication and accounting for network devices?"* → [[RADIUS]] (authentication and accounting) or [[TACACS+]] (authentication, authorization, and accounting)
  - **Trick**: RADIUS and [[TACACS+]] both do accounting, but TACACS+ also separates authorization

- *"A company needs to log all administrative actions on network switches for compliance. What AAA component is this addressing?"* → [[Accounting]]

### Question Type 3: Scenario-Based AAA
- *"A VPN concentrator authenticates a remote user, then consults an access control policy before granting access to internal resources. Which two AAA processes are described?"* → [[Authentication]] then [[Authorization]]
  - **Trick**: The VPN concentrator might also send accounting data to a [[SIEM]]—watch for all three processes

---

## Common Mistakes

### Mistake 1: Confusing Identification with Authentication
**Wrong**: "Identification and authentication are the same thing—they both confirm who the user is."
**Right**: [[Identification]] is merely claiming an identity (username); [[authentication]] is proving that claim through credential verification (password, [[MFA]], [[biometrics]]).
**Impact on Exam**: You may be asked to identify which process occurs first. Identification always precedes authentication. If you conflate them, you'll miss questions about the order and purpose of each step.

### Mistake 2: Thinking Authorization Controls Access Before Authentication
**Wrong**: "A user is authorized to access resources, so they don't need to authenticate."
**Right**: [[Authentication]] must happen first. Only after a user is verified should [[authorization]] rules be consulted.
**Impact on Exam**: Questions may describe a sequence of security checks. If you don't recognize that authentication precedes authorization, you'll misinterpret which process provides what protection.

### Mistake 3: Confusing Authorization with Accounting
**Wrong**: "Accounting determines whether a user can access a file—if they're not logged in the accounting system, they can't see it."
**Right**: [[Accounting]] records activity; it does not restrict access. [[Authorization]] controls access. Accounting merely documents what happened.
**Impact on Exam**: A question describing "logging all file access attempts" might trick you into saying "authorization," but it's actually describing [[accounting]].

### Mistake 4: Forgetting That Accounting Works on Authenticated Users Only
**Wrong**: "Accounting tracks all access attempts, including failed logins."
**Right**: While [[accounting]] *can* log failed authentication attempts, its primary purpose is documenting activities of *authenticated* users.
**Impact on Exam**: Some questions specify "logging user activities." If authentication failed, there's no authenticated user to account for. Watch for this distinction in scenario questions.

### Mistake 5: Misremembering RADIUS vs. TACACS+
**Wrong**: "Both RADIUS and TACACS+ provide full AAA services equally."
**Right**: [[RADIUS]] combines authentication and accounting but lacks separate authorization. [[TACACS+]] separates all three functions and provides more granular control.
**Impact on Exam**: You'll see comparison questions asking which protocol to choose when authorization granularity matters.

---

## Related Topics
- [[RADIUS]] — Network authentication protocol using UDP
- [[TACACS+]] — Enhanced authentication protocol using TCP
- [[Kerberos]] — Ticket-based authentication system
- [[LDAP]] — Directory service often used for authentication
- [[Public Key Infrastructure (PKI)]] — Certificate-based authentication foundation
- [[Multi-Factor Authentication (MFA)]] — Strengthens authentication beyond passwords
- [[Access Control Models]] — RBAC, ABAC, and other authorization frameworks
- [[Audit Logs and Logging]] — Data collection for accounting
- [[SIEM (Security Information and Event Management)]] — Centralized accounting data analysis
- [[VPN (Virtual Private Network)]] — Common real-world AAA implementation
- [[Firewall]] — Often acts as AAA enforcement point

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]] | [[AAA Framework]]*