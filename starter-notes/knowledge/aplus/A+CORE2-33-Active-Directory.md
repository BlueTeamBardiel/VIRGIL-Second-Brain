---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 33
source: rewritten
---

# Active Directory
**Microsoft's centralized identity and resource management system that authenticates users and controls access across entire networks.**

---

## Overview

Active Directory (AD) is the backbone of enterprise [[Windows]] networking — imagine it as a massive rolodex that knows *everyone* on your network and *what they're allowed to do*. When you're working in corporate environments, AD manages user accounts, computers, printers, file shares, and pretty much every network resource that needs permission controls. For the A+ exam, you need to understand that AD serves two critical roles: it's both an [[authentication]] source (verifying who you are) and an authorization manager (deciding what you can access).

---

## Key Concepts

### Active Directory Database

**Analogy**: Think of Active Directory like a bouncer at an exclusive nightclub who has a master guest list, knows everyone's VIP status, and decides which sections of the club each person can enter.

**Definition**: A centralized repository that stores all [[user accounts]], [[computer objects]], [[group policies]], [[permissions]], and network resources. It acts as the single source of truth for identity and access control across your entire network infrastructure.

| Aspect | Function |
|--------|----------|
| [[Authentication]] | Verifies login credentials (username/password validation) |
| [[Authorization]] | Determines what resources a user can access |
| [[Centralization]] | Single database serves entire organization |
| [[Replication]] | Data syncs across multiple servers for redundancy |

---

### Windows Domain

**Analogy**: A Windows domain is like a country with a central government — all citizens (computers/users) belong to that nation and follow its rules, rather than being independent city-states.

**Definition**: A logical grouping of networked computers, users, printers, and other resources that share a common [[Active Directory]] database and security policy framework. Your computer joins a domain (like "MICROSOFT.com") rather than working in standalone mode.

**Example Domain Structure**:
```
acmecorp.local
├── Sales Department
│   ├── User: john.smith
│   ├── Computer: SALES-PC-01
│   └── Printer: OfficeJet-Sales
├── Engineering Department
│   ├── User: jane.doe
│   └── Computer: ENG-WORKSTATION-02
└── HR Department
    └── User: hr.manager
```

---

### Authentication vs. Authorization

**Analogy**: Authentication is showing your ID at the airport (proving you are who you say you are); authorization is your boarding pass (determining which flight you're allowed on).

| Feature | [[Authentication]] | [[Authorization]] |
|---------|----------|----------------|
| Purpose | Verify user identity | Grant access to resources |
| Question Answered | "Are you who you claim?" | "What can you access?" |
| Active Directory Role | Checks credentials against database | Evaluates [[group memberships]] and [[ACLs]] |
| Example | Username/password validation | Permission to open shared folder |

---

### Group Policy & Permissions

**Analogy**: [[Group Policy]] is like company handbook rules that apply to entire departments at once, rather than writing individual instruction manuals for every employee.

**Definition**: [[Group Policy Objects (GPOs)]] allow administrators to apply configurations, security settings, and [[permissions]] to groups of users and computers simultaneously. Once a [[user account]] is added to a [[security group]], they automatically inherit all permissions assigned to that group.

**Permission Management Workflow**:
```
Administrator → Creates Security Group → Assigns Permissions → 
Adds Users to Group → Users Inherit Access
```

---

### Domain Controller

**Analogy**: A [[Domain Controller]] is like the main post office in a city — it's the central hub that processes all mail (authentication requests) and maintains the master address book (user database).

**Definition**: A [[Windows Server]] running Active Directory that authenticates users, stores security policies, and manages replication of directory data to other domain controllers for fault tolerance.

---

## Exam Tips

### Question Type 1: Authentication & Authorization Scenarios
- *"A user cannot access a shared file on the network. You've confirmed their password is correct. What should you check first?"* → Verify they're a member of the appropriate [[security group]] with [[file share permissions]]
- **Trick**: Don't confuse "can log in" (authentication works) with "can access resources" (authorization fails). Many questions test this distinction.

### Question Type 2: Domain vs. Workgroup
- *"A company wants centralized user management across 200 computers. Should they use a domain or workgroup?"* → Domain (workgroups are peer-to-peer with no centralization)
- **Trick**: Workgroups seem simpler but don't scale; exams love asking why enterprises need domains.

### Question Type 3: Administrator Responsibilities
- *"What task is most appropriate for an Active Directory administrator?"* → Resetting user passwords, adjusting [[file share permissions]], applying [[group policies]]
- **Trick**: Help desk resets passwords; AD admins manage infrastructure and policies. Know the role difference.

---

## Common Mistakes

### Mistake 1: Treating Authentication as Authorization
**Wrong**: "If a user can log into their computer, they can access all network resources."
**Right**: Successful login (authentication) doesn't grant resource access. That requires separate [[authorization]] through [[group membership]] and [[ACLs]].
**Impact on Exam**: Questions intentionally mix these concepts. A user might have valid credentials but lack permission to open a file share — you need to troubleshoot both layers.

### Mistake 2: Confusing Domain with Workgroup
**Wrong**: "Domains and workgroups do the same thing — domains are just bigger."
**Right**: Workgroups are decentralized (each computer manages its own users); domains are centralized (one [[Active Directory]] database manages all users).
**Impact on Exam**: Scenario questions ask which to recommend. Always pick domain for enterprises, workgroup only for small peer networks.

### Mistake 3: Assuming All IT Staff Can Modify Active Directory
**Wrong**: "Help desk technicians should be able to create new security groups and assign permissions."
**Right**: Only [[Active Directory]] administrators should modify directory structure; help desk has limited permissions (reset passwords, unlock accounts).
**Impact on Exam**: Role-based access control (RBAC) questions will test whether you assign correct privileges to the right jobs.

### Mistake 4: Forgetting That Permissions Stack via Groups
**Wrong**: "I'll assign each user individual permissions to each resource."
**Right**: Add users to [[security groups]], then assign permissions once to the group. Much more scalable and maintainable.
**Impact on Exam**: Efficiency questions reward group-based permission models over individual assignments.

---

## Related Topics
- [[Windows Server]]
- [[User Accounts & Groups]]
- [[Group Policy Objects (GPO)]]
- [[NTFS Permissions]]
- [[File Share Permissions]]
- [[Network Authentication Protocols]]
- [[Domain Controller]]
- [[Workgroup]]
- [[Active Directory Users and Computers (ADUC)]]

---

*Source: CompTIA A+ Core 2 (220-1202) Domain 3: Security | [[A+]] Certification*