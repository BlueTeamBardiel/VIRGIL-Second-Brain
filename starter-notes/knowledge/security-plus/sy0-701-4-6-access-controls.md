```yaml
---
domain: "4.0 - Security Operations"
section: "4.6"
tags: [security-plus, sy0-701, domain-4, access-controls, authorization, authentication]
---
```

# 4.6 - Access Controls

Access controls are the mechanisms that enforce **who** can access **what** resources and **when**. This section of the Security+ exam focuses on the different models and methods organizations use to grant, deny, and manage user permissions—distinguishing between **authentication** (proving who you are) and **authorization** (what you're allowed to do). Understanding these models is critical because weak access controls are a primary vector for insider threats, privilege escalation, and unauthorized data access, and they directly support the [[CIA Triad]] principle of **Confidentiality**.

---

## Key Concepts

- **Authorization**: The process of determining and enforcing what rights a user or system has; policy definition and enforcement combined.
  
- **Least Privilege**: The principle that users and applications should have only the **minimum rights necessary** to perform their job. All user accounts must be limited; applications should run with minimal privileges. Never allow users to run with administrative privileges—this limits the scope of malicious behavior if an account is compromised.

- **Role-Based Access Control (RBAC)**: Users are assigned to roles (Manager, Director, Team Lead, Project Manager) and permissions are granted implicitly based on that role. In Windows, this is implemented via **Groups**. Example: "You are in Shipping and Receiving, so you can use the shipping software."

- **Mandatory Access Control (MAC)**: The operating system enforces access based on **security clearance levels**. Every object is labeled (Confidential, Secret, Top Secret, etc.) with predefined rules set by administrators. Users **cannot change these settings**—the OS controls access, not the user.

- **Discretionary Access Control (DAC)**: Used in most modern operating systems. The **owner of a resource controls who has access**. Very flexible but weak security. Example: You create a spreadsheet and decide who can view or edit it; you can modify access at any time.

- **Rule-Based Access Control**: A generic term for access decisions based on **conditions other than identity**. System-enforced rules are associated with objects, and the system checks [[Access Control Lists (ACLs)]] for that object. Examples: Lab network access only 9 AM–5 PM; only Chrome browsers allowed for specific web forms.

- **Attribute-Based Access Control (ABAC)**: A "next-generation" authorization model that considers **multiple parameters and context**:
  - Resource information
  - IP address
  - Time of day
  - Desired action
  - Relationship to data
  - Combines and evaluates many criteria simultaneously

- **Time-of-Day Restrictions**: Access is allowed only during specific hours or days of the week. Nearly all security devices support this; difficult to implement in 24-hour environments. Examples: Training room network inaccessible midnight–6 AM; Conference room access limited after 8 PM; R&D databases available 8 AM–6 PM only.

- **Policy Definition vs. Policy Enforcement**: Policy definition is determining what rights should exist; policy enforcement is ensuring those rights are actually exercised and not exceeded.

---

## How It Works (Feynman Analogy)

Imagine a library with different sections—General Reading, Research, and Rare Books. 

- **DAC** is like the General Reading section where patrons (owners) decide if their personal books are public or private; very flexible but chaotic.
- **MAC** is like a government archives facility where the *institution* decides all access rules (Confidential, Secret, Top Secret) based on security clearance; individuals have no say.
- **RBAC** is like assigning librarian roles: a "Circulation Clerk" can check out books; a "Reference Librarian" can access databases; a "Director" can approve new acquisitions. You get capabilities based on your job title, not per-request.
- **ABAC** is the most sophisticated: "The rare-book vault opens only to the Research Librarian, on weekdays, between 10 AM–4 PM, from the secured workstation IP, if they're performing a cataloging task."

In technical reality, **authorization** systems use these models to enforce [[CIA Triad|confidentiality]] and prevent unauthorized access. A compromised account with full admin privileges is far more dangerous than one with minimal, role-based access—hence **Least Privilege** is the golden rule.

---

## Exam Tips

- **Distinguish Authorization from Authentication**: The exam loves to confuse these. **Authentication** = proving who you are (username/password, [[MFA]]). **Authorization** = what you're allowed to do once authenticated. You'll see questions like: "Which controls access to resources?" (Authorization) vs. "Which verifies identity?" (Authentication).

- **Recognize RBAC vs. DAC vs. MAC in scenarios**: 
  - RBAC questions mention "roles," "job titles," or "Windows groups."
  - DAC questions mention "owner decides" or "very flexible."
  - MAC questions mention "clearance levels," "labels," or "OS enforces."
  - ABAC questions mention "complex criteria," "multiple parameters," or "context-aware."

- **Least Privilege is a principle, not a model**: Don't confuse it with RBAC or other models. It's a best practice that applies across all models. Expect scenario questions where you identify when Least Privilege is being violated (e.g., "All users run as admin" = violation).

- **ABAC is "next-generation"**: If a question asks about a system that evaluates IP address, time of day, resource type, and user role all together, it's ABAC. This is often presented as the most advanced/flexible option.

- **Time-of-Day Restrictions are rarely standalone**: The exam will emphasize that time-of-day is supplementary, not the primary control. Watch for questions asking if time-of-day alone is sufficient (answer: no).

---

## Common Mistakes

- **Confusing DAC with RBAC**: DAC is owner-based and weak; RBAC is role-based and implicit (you get permissions by your role). Candidates often think "user controls access" = RBAC, but that's actually DAC. RBAC is *administrator-controlled* role assignments.

- **Assuming MAC means "mandatory Multi-factor Authentication"**: MAC = **Mandatory Access Control** (OS-enforced clearance model), not [[MFA]]. The exam uses the acronym in a completely different context. Context is everything.

- **Thinking Least Privilege is only for users**: Common mistake is to apply it only to user accounts. Least Privilege applies to **applications and services too**. A database service should not run as `root`; a web app should not have access to the entire filesystem.

---

## Real-World Application

In **[YOUR-LAB]** (Morpheus's homelab), access controls manifest as:
- **RBAC via [[Active Directory]]**: Different groups (Admins, Operators, Users) grant implicit permissions to resources, [[Tailscale]] nodes, and [[Wazuh]] dashboards.
- **Least Privilege in automation**: Services like [[Wazuh]] agents run with minimal permissions; only the [[SIEM]] aggregation engine needs elevated access to ingest logs from multiple sources.
- **Time-of-Day restrictions**: Lab networks might be accessible only during maintenance windows; test data access restricted to business hours to reduce exposure.
- **ABAC-like logic in [[Wazuh]]**: Rules trigger based on multiple criteria (IP, time, event type, user identity) rather than a single access rule.

---

## [[Wiki Links]]

- [[Authorization]] / [[Authentication]]
- [[Access Control Lists (ACLs)]]
- [[Role-Based Access Control (RBAC)]]
- [[Mandatory Access Control (MAC)]]
- [[Discretionary Access Control (DAC)]]
- [[Attribute-Based Access Control (ABAC)]]
- [[Least Privilege]]
- [[Active Directory]]
- [[LDAP]]
- [[MFA]]
- [[CIA Triad]]
- [[Zero Trust]]
- [[Wazuh]]
- [[Tailscale]]
- [[SIEM]]
- [[Incident Response]]
- [[NIST]]
- [[Security Operations]]

---

## Tags

```
domain-4, security-plus, sy0-701, access-controls, authorization, rbac, mac, dac, abac, least-privilege, acl
```

---

## Study Checklist

- [ ] Memorize the five main access control models and their characteristics.
- [ ] Practice distinguishing RBAC (role-based) from DAC (owner-based) in scenario questions.
- [ ] Understand why MAC is rarely used outside government/military and why DAC is weak.
- [ ] Know that ABAC is "next-gen" and context-aware.
- [ ] Review how Least Privilege applies to users, applications, and services.
- [ ] Learn the limitations of time-of-day restrictions.
- [ ] Create a comparison table: Model | Who Decides | Flexibility | Security | Common Use
- [ ] Link access controls to [[CIA Triad|confidentiality]] enforcement.

---

**Last Updated:** 2025  
**Source:** CompTIA Security+ SY0-701 Study Guide (Professor Messer)  
**Related Notes:** [[4.0 - Security Operations]], [[Authentication vs Authorization]], [[Privilege Management]]

```

---
_Ingested: 2026-04-16 00:18 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
