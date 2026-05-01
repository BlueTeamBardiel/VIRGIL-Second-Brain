---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 096
source: rewritten
---

# Identity and Access Management
**The systematic process of verifying who users are, granting them appropriate permissions, and tracking their actions across distributed computing environments.**

---

## Overview
Modern organizations operate across multiple platforms—desktops, laptops, mobile devices, on-premises data centers, and cloud infrastructure—with diverse user populations requiring different levels of access. [[Identity and Access Management (IAM)]] is the disciplined framework that ensures only authorized individuals can access the specific resources they need, exactly when they need them, while maintaining comprehensive audit trails. For Security+ candidates, IAM represents one of the foundational pillars of an organization's security posture and directly supports compliance, risk mitigation, and operational efficiency.

---

## Key Concepts

### Identity and Access Management (IAM)
**Analogy**: Think of IAM like a nightclub's guest management system—you verify who someone is (identity), check what they're allowed to do (access rights), grant them entry to appropriate areas (authorization), and track everywhere they go throughout the night (logging).

**Definition**: The complete lifecycle process spanning from initial user onboarding through continuous access management to final offboarding, encompassing [[authentication]], [[authorization]], [[accounting]], and [[access revocation]].

| IAM Phase | Purpose | Timing |
|-----------|---------|--------|
| Provisioning | Grant initial access | Onboarding |
| Modification | Adjust permissions | Role changes, promotions |
| Monitoring | Track user activities | Ongoing |
| Deprovisioning | Remove access | Offboarding, separation |

### Authentication
**Analogy**: Authentication is like showing your driver's license at airport security—you're proving you are who you claim to be through verifiable evidence.

**Definition**: The process of verifying a user's claimed identity through credentials such as [[username]]/[[password]], [[multi-factor authentication (MFA)]], biometrics, or certificates.

### Authorization
**Analogy**: After the security guard confirms you're on the guest list (authentication), authorization is the wristband that determines which areas of the venue you can actually enter.

**Definition**: The mechanism that determines what authenticated users are permitted to do, access, or modify based on their assigned roles, permissions, and [[access control lists (ACLs)]].

### Accounting and Logging
**Analogy**: Like a security camera system that records who entered each room and when—creating an evidence trail of all activities.

**Definition**: The comprehensive monitoring, recording, and analysis of user actions and resource access, creating audit trails for [[compliance]], investigation, and threat detection via [[logs]] and [[Security Information and Event Management (SIEM)]].

### User Provisioning
**Analogy**: Onboarding is like setting up a new employee's desk—you gather requirements, assign equipment, create access credentials, and establish their workspace.

**Definition**: The initial process of creating user accounts, assigning [[group memberships]], configuring permissions, and enabling access to systems and applications when employees, contractors, or vendors join the organization.

### User Deprovisioning
**Analogy**: Offboarding is systematically disassembling that same desk—collecting equipment, disabling credentials, removing group memberships, and ensuring no residual access remains.

**Definition**: The controlled removal of user access rights and system accounts upon employee departure, contractor completion, or role termination to prevent [[unauthorized access]] and [[privilege creep]].

### Access Control Models

| Model | Mechanism | Best Used For |
|-------|-----------|---------------|
| [[Role-Based Access Control (RBAC)]] | Permissions assigned via job roles | Large organizations with defined positions |
| [[Attribute-Based Access Control (ABAC)]] | Dynamic decisions based on user/resource attributes | Complex, fine-grained environments |
| [[Access Control Lists (ACL)]] | Explicit allow/deny rules per resource | Granular, object-level control |
| [[Mandatory Access Control (MAC)]] | Labels and classifications enforce access | High-security, classified environments |

---

## Exam Tips

### Question Type 1: IAM Process and Lifecycle
- *"A contractor completes their project on Friday. What must IT do to maintain security compliance?"* → Immediately deprovision all access, disable accounts, revoke credentials, audit remaining permissions
- **Trick**: Candidates often forget that deprovisioning must be immediate and comprehensive—delayed removal creates a critical vulnerability window

### Question Type 2: Authentication vs. Authorization
- *"Which process verifies a user's identity with a password?"* → [[Authentication]]
- *"Which process determines if that user can access the payroll database?"* → [[Authorization]]
- **Trick**: These concepts are frequently confused; remember: authentication = "who are you?" and authorization = "what can you do?"

### Question Type 3: Multi-User Access Scenarios
- *"Your organization has employees, vendors, and customers. How should access permissions differ?"* → Each group receives only the minimum permissions required for their specific function ([[principle of least privilege]])
- **Trick**: The exam may present a scenario where everyone gets the same permissions—this is the wrong answer

### Question Type 4: Compliance and Logging
- *"Why is logging user access activities essential in regulated industries?"* → Provides audit trails, demonstrates compliance, enables breach investigation, and supports forensic analysis
- **Trick**: Logging alone isn't enough—organizations must actively monitor, review, and maintain logs according to retention policies

---

## Common Mistakes

### Mistake 1: Conflating Authentication with Authorization
**Wrong**: "We authenticated the user, so they have access to all company systems."
**Right**: Authentication verifies identity; authorization separately determines what resources each authenticated user can access.
**Impact on Exam**: Questions specifically test your ability to distinguish these processes. A user can be successfully authenticated but still denied access to certain resources via authorization controls.

### Mistake 2: Neglecting Ongoing Access Reviews
**Wrong**: "After onboarding, user permissions don't need attention until offboarding."
**Right**: Organizations must continuously review and adjust permissions as users change roles, get promoted, move departments, or no longer need specific access.
**Impact on Exam**: The exam emphasizes that IAM is a continuous lifecycle, not a one-time event. Expect questions about periodic access reviews and [[privilege creep]].

### Mistake 3: Inadequate Deprovisioning
**Wrong**: "Disabling the user's email account is sufficient offboarding."
**Right**: Complete deprovisioning requires disabling all system accounts, revoking application access, removing group memberships, collecting hardware, and verifying no residual access remains.
**Impact on Exam**: Incomplete offboarding represents a significant security failure. Questions may present partial deprovisioning scenarios where you must identify what's missing.

### Mistake 4: Assuming Logging Is Automatic Compliance
**Wrong**: "We have audit logs enabled, so we're compliant."
**Right**: Logging must be configured appropriately, monitored actively, stored securely, retained per policy, and reviewed regularly to detect suspicious activities.
**Impact on Exam**: Compliance questions require understanding that logging is one component of a comprehensive [[accounting]] strategy.

### Mistake 5: Overprovisioning vs. Principle of Least Privilege
**Wrong**: "It's easier to give all users broad permissions instead of managing individual access."
**Right**: Every user should receive only the minimum permissions necessary to perform their job function, reducing breach impact and privilege misuse.
**Impact on Exam**: Security+ heavily emphasizes [[principle of least privilege]]. Questions will test your ability to identify overprovisioned access scenarios.

---

## Related Topics
- [[Authentication]]
- [[Authorization]]
- [[Multi-Factor Authentication (MFA)]]
- [[Role-Based Access Control (RBAC)]]
- [[Attribute-Based Access Control (ABAC)]]
- [[Access Control Lists (ACL)]]
- [[Principle of Least Privilege]]
- [[Privilege Creep]]
- [[Onboarding and Offboarding]]
- [[Compliance and Auditing]]
- [[Single Sign-On (SSO)]]
- [[Directory Services]]
- [[SIEM]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*