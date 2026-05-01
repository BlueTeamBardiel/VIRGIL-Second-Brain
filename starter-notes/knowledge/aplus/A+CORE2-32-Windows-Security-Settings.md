---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 32
source: rewritten
---

# Windows Security Settings
**Understanding user authentication methods and account management is foundational to securing Windows systems and passing the A+ exam.**

---

## Overview

Windows computers require authentication before granting access to the operating system and its resources. The way you authenticate—and what type of account you're using—determines your permissions, data synchronization capabilities, and where your credentials are stored. For the A+ Core 2 exam, you need to distinguish between local accounts, Microsoft accounts, and domain accounts, plus know how to manage them through built-in Windows tools.

---

## Key Concepts

### Local User Accounts

**Analogy**: Think of a local user account like a key that only works on one specific front door—your home computer. You cut it yourself, it doesn't talk to any master locksmith, and if you lose the key, only you can make a new one.

**Definition**: A [[local user account]] is an authentication credential stored directly on the individual Windows machine. It has no connection to external systems and grants access only to that specific computer. [[permissions]] for a local account apply only to that device.

**Where to find them**: Right-click **This PC** → **Manage** → **Local Users and Groups** → **Users**

```
compmgmt.msc
```

| Aspect | Local Account |
|--------|---------------|
| Stored Location | On individual computer only |
| Cloud Sync | No |
| Multi-device Access | No |
| Setup Complexity | Simple |
| Typical User | Home users, standalone systems |

---

### Microsoft Accounts

**Analogy**: A Microsoft account is like having a master key made by Microsoft that works across multiple doors (your devices). Show your ID once, and your settings, files, and preferences follow you everywhere.

**Definition**: A [[Microsoft account]] is a cloud-based authentication system that synchronizes user settings, preferences, and configuration data across multiple Windows devices. When you sign in with a Microsoft account, your profile data lives in the cloud and replicates whenever you log into a different device with the same credentials.

**Key features**:
- Settings sync (wallpaper, browser bookmarks, app preferences)
- Access to Microsoft Store apps
- OneDrive integration
- Single sign-on across devices

---

### Domain Accounts (Active Directory)

**Analogy**: A domain account is like working for a large corporation with a centralized security office. Your boss (the domain controller) maintains a master record of every employee, their access level, and what they're allowed to touch. When you show up to any building, security checks with headquarters.

**Definition**: A [[domain account]] is an [[Active Directory]]-based credential managed by an organization's central directory service, not by Microsoft or the individual computer. Domain accounts are deployed in enterprise environments where [[Group Policy]] and centralized management are critical. Credentials authenticate against a [[domain controller]], not the local machine.

**Also called**: Domain login, Active Directory credentials

| Feature | Local Account | Microsoft Account | Domain Account |
|---------|--------------|-------------------|----------------|
| Management | Local computer | Microsoft cloud | Organization's domain controller |
| Multi-device sync | No | Yes | Yes (via GPO) |
| Enterprise use | No | No | Yes |
| Requires internet | No | Yes (sync only) | Yes (authentication) |
| [[Group Policy]] support | Limited | No | Full |

---

### Built-in Default Accounts

**Analogy**: Every brand-new house comes with a master key installed by the contractor—that's the Administrator account. Sometimes there's also a guest entrance for visitors.

**Definition**: Windows installations include pre-configured system accounts that exist regardless of user setup:

- **Administrator**: Full [[system permissions]] and unrestricted access to all resources and settings
- **Guest**: Heavily restricted account, typically disabled by default, intended for temporary visitors
- **SYSTEM**: Internal account Windows uses for system processes (not a login account)

---

## Exam Tips

### Question Type 1: Account Type Identification
- *"A user in an office environment needs to authenticate against a central server and receive group policies. Which account type should they use?"* → **Domain account** — look for keywords like "enterprise," "organization," "group policy," or "central management"
- *"A home user wants their browser bookmarks to sync between their laptop and tablet. What must they set up?"* → **Microsoft account** — sync across devices = cloud account
- *"You're configuring a standalone computer with no network. What's the simplest authentication method?"* → **Local account** — standalone systems don't need domain infrastructure

**Trick**: The exam loves asking about domain vs. Microsoft accounts. Domain accounts require [[Active Directory]] and work offline after first login (cached credentials). Microsoft accounts require internet for initial setup but can work offline after. Don't confuse them!

### Question Type 2: Account Management Tools
- *"Where do you manage local user accounts on Windows 10/11?"* → **Computer Management** (compmgmt.msc) → **Local Users and Groups** OR **Settings** > **Accounts**
- *"Which tool grants domain account privileges?"* → [[Active Directory Users and Computers]] (on domain controllers or admin workstations)

**Trick**: The 220-1202 exam assumes you know **compmgmt.msc** is the command for Computer Management. It's faster than navigating the GUI.

---

## Common Mistakes

### Mistake 1: Confusing Microsoft Accounts with Domain Accounts
**Wrong**: "A domain account is just a Microsoft account for businesses."
**Right**: Domain accounts are stored on organizational [[domain controllers]] running [[Active Directory]]. Microsoft accounts are cloud-stored by Microsoft. They use different authentication backends entirely.
**Impact on Exam**: You could choose the wrong account type for an enterprise scenario. The exam tests whether you know that domain accounts provide [[Group Policy]] enforcement—Microsoft accounts do not.

### Mistake 2: Thinking Local Accounts Don't Sync Anything
**Wrong**: "Local accounts have zero functionality beyond that one computer."
**Right**: Local accounts work fine on a single computer. If you want *settings sync*, upgrade to a Microsoft account. If you need *enterprise management*, use a domain account. Local accounts are still secure and appropriate for many scenarios.
**Impact on Exam**: You might incorrectly assume a home user *must* use a Microsoft account. They can use a local account—it's just their choice whether to sync settings.

### Mistake 3: Forgetting Built-in Accounts Exist
**Wrong**: "The Administrator account only exists if you create it."
**Right**: Windows creates an Administrator account and several system accounts at installation. You may not see them in the normal login screen if they're disabled, but they exist in Local Users and Groups.
**Impact on Exam**: The exam might ask what accounts exist "by default" on a fresh Windows installation. Know that Administrator, SYSTEM, and Guest all exist automatically.

### Mistake 4: Mixing Up Account Management Tools
**Wrong**: Using Settings > Accounts for managing local user groups and permissions.
**Right**: Use **Computer Management** > **Local Users and Groups** for full account management (creating groups, changing permissions). Settings > Accounts is for basic personal account configuration.
**Impact on Exam**: You'll lose points if you recommend the wrong tool. The exam expects you to know **compmgmt.msc** for serious account administration.

---

## Related Topics
- [[Active Directory]]
- [[Group Policy]]
- [[Domain Controller]]
- [[User Permissions and Privileges]]
- [[Windows User Account Control (UAC)]]
- [[NTFS File Permissions]]
- [[Authentication and Authorization]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]] | [[Core 2]]*