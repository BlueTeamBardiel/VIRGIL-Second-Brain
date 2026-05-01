---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 097
source: rewritten
---

# Access Controls
**The systematic enforcement of permission policies that grant or deny user access to organizational resources after authentication.**

---

## Overview
Once a user proves their identity through [[Authentication]], the security framework must determine what they're allowed to access—this determination process is called access control. Access control is the practical enforcement of organizational policies that decide whether a user can view, modify, or execute specific data and resources. For Security+, understanding access control models is critical because they form the foundation of how systems protect sensitive information from both external threats and insider misuse.

---

## Key Concepts

### Principle of Least Privilege
**Analogy**: Imagine a new employee at a bank—they get keys only to the areas their job requires (the teller window), not to the vault, executive offices, or server room. Extra access creates unnecessary risk.

**Definition**: A [[Security Principles|foundational security principle]] where users receive the absolute minimum [[Permissions|permissions]] and [[Rights|rights]] needed to complete their assigned job functions, with no excess access granted.

**Impact**: 
- Reduces damage from compromised accounts
- Limits malware scope if user's account is exploited
- Prevents privilege creep over time

---

### Access Control Models

| Model | Decision Logic | Best For | Complexity |
|-------|----------------|----------|-----------|
| [[DAC (Discretionary Access Control)]] | Resource owner decides | Flexible, user-managed environments | Low |
| [[MAC (Mandatory Access Control)]] | System labels & rules enforce | High-security, classified environments | High |
| [[RBAC (Role-Based Access Control)]] | User's assigned role grants permissions | Enterprise organizations | Medium |
| [[ABAC (Attribute-Based Access Control)]] | Multiple attributes evaluated together | Complex, dynamic policies | Very High |

### Discretionary Access Control (DAC)
**Analogy**: Like a document you create—you decide who can read, edit, or delete it. The owner has full control to share or restrict access.

**Definition**: An [[Access Control Models|access control model]] where the resource owner or administrator explicitly assigns permissions to individual users or [[Groups (Access Control)|groups]]. The owner maintains discretion over access decisions.

**Characteristics**:
- User-centric permission assignment
- Flexible and easy to implement
- Found in NTFS, Unix file systems
- Risk: Users may grant excessive access

### Mandatory Access Control (MAC)
**Analogy**: Like a military classified document system—the security label on the document determines who can access it, regardless of what the document owner wants.

**Definition**: An [[Access Control Models|access control model]] where the system administrator enforces access decisions based on predefined [[Security Labels|security labels]] and rules, not user preference. Every resource carries a [[Classification|classification label]], and users have [[Clearance|clearance levels]].

**Key Features**:
- Administrator controls all permissions
- Based on [[Data Classification]] levels
- Access occurs only when user clearance ≥ resource classification
- Common in government and defense sectors

### Role-Based Access Control (RBAC)
**Analogy**: At a hospital, a nurse role automatically grants access to patient records, medication dispensers, and wards—not because of individual negotiation, but because that's what the nurse role includes.

**Definition**: An [[Access Control Models|access control model]] where permissions are assigned to [[Roles (Access Control)|roles]] rather than individual users. When a user is assigned a role, they inherit all associated permissions.

**Benefits**:
- Simplifies administration at scale
- Reduces permission errors
- Aligns with organizational structure
- Easy to audit and review

### Attribute-Based Access Control (ABAC)
**Analogy**: A concert venue grants entry based on multiple attributes—age (≥18), ticket type (VIP or general), date, and time. You need ALL attributes to match.

**Definition**: An [[Access Control Models|access control model]] where access decisions evaluate multiple user, resource, environment, and action [[Attributes (Access Control)|attributes]] simultaneously using conditional logic rules.

**Example Scenario**: A salesperson can access customer financial records IF:
- (User department = Sales) AND
- (Resource classification = Confidential) AND
- (Time is during business hours) AND
- (Location = Corporate network)

---

## Exam Tips

### Question Type 1: Identifying the Correct Model
- *"Your organization requires that all access decisions be controlled by system labels and security clearances. No user can override these settings. Which model is this?"* → [[MAC (Mandatory Access Control)|MAC]]
- **Trick**: Don't confuse "controlled by administrator" with MAC—RBAC is also admin-controlled, but MAC specifically uses labels and clearances.

### Question Type 2: Least Privilege Application
- *"A database administrator should have access to production databases but not payroll systems. What principle is being applied?"* → [[Principle of Least Privilege]]
- **Trick**: Questions may describe excessive access as "efficient" or "convenient"—always choose the most restrictive option.

### Question Type 3: Model Comparison
- *"Which model best supports complex, conditional access rules based on time, location, and department?"* → [[ABAC (Attribute-Based Access Control)|ABAC]]
- **Trick**: RBAC can't evaluate environmental attributes like time/location; that's ABAC's strength.

### Question Type 4: Implementation Scenario
- *"A small organization needs quick, flexible access control without extensive administration overhead. Which model fits best?"* → [[DAC (Discretionary Access Control)|DAC]]
- **Trick**: DAC seems chaotic but is appropriate for small, trust-based environments.

---

## Common Mistakes

### Mistake 1: Confusing RBAC with Role-Based Privileges
**Wrong**: "RBAC means users can change their own roles based on what they need."
**Right**: RBAC means administrators assign roles, and roles carry pre-determined permissions; users cannot change their assignments.
**Impact on Exam**: Questions testing whether users control or administrators control access often hinge on this distinction.

### Mistake 2: Thinking Least Privilege Only Applies to DAC
**Wrong**: "Least privilege is a principle for discretionary systems only."
**Right**: Least privilege applies across ALL access control models—it's a universal security best practice for permission assignment.
**Impact on Exam**: Any question about permission minimization should reference least privilege, regardless of which model is in use.

### Mistake 3: Equating MAC with Encryption
**Wrong**: "MAC protects data by encrypting it based on classification."
**Right**: MAC controls access via security labels and clearances; encryption is a separate data protection mechanism.
**Impact on Exam**: MAC questions focus on permission rules and labels, not encryption methods.

### Mistake 4: Assuming ABAC is Always Better
**Wrong**: "ABAC is the most secure model, so it's always the right choice."
**Right**: ABAC is complex and difficult to manage; simpler models are appropriate for simpler environments.
**Impact on Exam**: Questions ask which model "best fits" a scenario, not which is "most secure"—context matters.

### Mistake 5: Forgetting Access Control Follows Authentication
**Wrong**: "Access control and authentication are the same process."
**Right**: [[Authentication]] proves you are who you claim; [[Access Control]] determines what you can access after authentication succeeds.
**Impact on Exam**: Multi-step security questions distinguish these clearly—mixing them up results in wrong answers.

---

## Related Topics
- [[Authentication (AuthN)]]
- [[Authorization (AuthZ)]]
- [[Data Classification]]
- [[Security Labels]]
- [[Permissions vs Rights]]
- [[Identity and Access Management (IAM)]]
- [[Principle of Least Privilege]]
- [[Defense in Depth]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*