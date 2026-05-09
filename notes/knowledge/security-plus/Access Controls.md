# Access Controls

## What it is

In League of Legends, the Baron Pit is gated. You can ward it, but you can't actually claim Hand of Baron unless your team lands the killing blow, and even then the buff is bound to your team's identity — enemy champions standing in the pit get nothing. The pit decides *who* gets in, *what* they can do there, and *what* they walk away with. That's exactly what access controls do — they decide which subjects can perform which actions on which resources.

Access controls are the mechanisms that enforce authorization decisions, restricting subjects (users, processes) to permitted operations on objects (files, systems, data) according to a defined policy.

## Why it matters

Without working access controls, authentication is theater — you've checked someone's ID at the door, then handed them the keys to every room. Broken or missing access controls produce the most expensive headlines in the industry: privilege escalation, insider data theft, ransomware blast radius, and every HIPAA/PCI/SOX finding that ends in a fine. SY0-701 Objective **4.6** explicitly lists access control models the candidate must distinguish, and CompTIA's favorite trap is forcing you to choose between **MAC**, **DAC**, **RBAC**, **ABAC**, and **rule-based** when the scenario describes only one decisively — read for *who decides* (owner? system? attribute engine?) before picking.

## Key facts

### The five models you must know cold

| Model | Who sets permissions | Decision based on | Classic example |
|---|---|---|---|
| **[[DAC]]** (Discretionary) | The **owner** of the object | Owner's discretion / ACL | NTFS file permissions, Linux `chmod` |
| **[[MAC]]** (Mandatory) | The **system / security policy** | **Labels** + clearance | SELinux, military classified systems |
| **[[RBAC]]** (Role-Based) | Admin, via roles | User's assigned **role** | "Accountants" group gets GL access |
| **[[ABAC]]** (Attribute-Based) | Policy engine | **Attributes** of subject, object, action, environment | "Allow if user.dept=HR AND time<18:00 AND device.compliant=true" |
| **[[Rule-Based Access Control]]** | Admin-defined **rules** applied to all | Conditions/triggers, not identity | Firewall ACL, time-of-day login restrictions |

CompTIA distinguishes **role-based** (tied to job function) from **rule-based** (tied to conditions). Mixing these is the #1 wrong answer.

### Core principles enforced through access controls

- **[[Principle of Least Privilege]]** — minimum rights to do the job, nothing more.
- **[[Separation of Duties]]** — no single user completes a sensitive transaction end-to-end.
- **[[Need to Know]]** — even with clearance, access requires task justification.
- **[[Implicit Deny]]** — anything not explicitly allowed is denied. The default-deny posture.
- **[[Job Rotation]]** and **[[Mandatory Vacation]]** — detective controls that surface fraud.

### Identity-related access controls

- **[[Access Control List]] (ACL)** — ordered list of permit/deny entries on a resource.
- **[[Group-Based Access Control]]** — permissions assigned to groups, users inherit.
- **[[Time-of-Day Restrictions]]** — login windows; common rule-based control.
- **[[Geofencing]]** / **[[Geolocation]]** — deny based on physical or IP location.
- **[[Conditional Access]]** — modern ABAC implementation in Azure/Entra, evaluating device posture, risk score, location.

### Privileged access management

- **[[PAM]] (Privileged Access Management)** — vaults credentials, enforces just-in-time elevation, records sessions.
- **[[Just-in-Time Access]]** — admin rights granted for a limited window, then revoked.
- **[[Ephemeral Credentials]]** — short-lived secrets that expire automatically.

### Failure modes the exam loves

| Failure | What happens |
|---|---|
| **[[Privilege Creep]]** | User accumulates rights across role changes; never loses old ones |
| **[[Authorization Bypass]]** | Flaw lets request skip the access decision (IDOR, broken object-level auth) |
| **[[Privilege Escalation]]** | Vertical (user→admin) or horizontal (user→other user) |
| Missing **implicit deny** | Default-allow firewall rules permit unintended traffic |

## Related concepts

[[Authentication]] · [[Authorization]] · [[Accounting]] · [[IAM]] · [[Zero Trust]] · [[Identity Provider]] · [[Federation]] · [[SSO]] · [[Kerberos]] · [[LDAP]] · [[SAML]] · [[OAuth]] · [[Security Labels]] · [[Bell-LaPadula]] · [[Biba]]

---
*Source: VIRGIL knowledge base — 2026-05-08*