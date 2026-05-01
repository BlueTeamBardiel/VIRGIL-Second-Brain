---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 04
source: rewritten
---

# Upgrading Windows
**Choose between preserving your digital life or hitting the reset button completely.**

---

## Overview

When deploying a new [[Windows]] operating system, you face a critical fork in the road: evolve what you have or start from scratch. Understanding the distinction between these two paths is essential for the A+ exam because real-world support scenarios require you to choose the right approach for each situation. This decision shapes everything from data preservation to user satisfaction.

---

## Key Concepts

### In-Place Upgrade

**Analogy**: Think of renovating a house while you're still living in it. You're upgrading the walls and systems, but your furniture, photos, and belongings stay exactly where you left them.

**Definition**: An [[in-place upgrade]] is a [[Windows]] installation method that layers a new [[operating system]] on top of an existing one, preserving all [[applications]], [[user accounts]], [[user profiles]], [[registry]] settings, and stored data. The OS files get replaced or updated, but the user environment remains intact.

**Key Preservation Elements**:
| What Gets Kept | Details |
|---|---|
| [[User Profiles]] | All local user accounts and their settings |
| [[Applications]] | Previously installed programs remain functional |
| [[User Data]] | Documents, downloads, and personal files |
| [[Registry]] | System configurations and customizations |
| [[Group Policy]] Settings | Domain and local policy configurations |

**When to Choose In-Place Upgrade**:
- Multiple [[user accounts]] on a single machine
- Custom [[applications]] or specialized software configurations
- Users have extensive personalized settings
- Time is critical (faster deployment)
- You want to minimize [[data loss]] risk

### Clean Installation

**Analogy**: Like demolishing a house and building a brand new one from the foundation up. Everything is fresh, but you need to rebuild everything from scratch.

**Definition**: A [[clean installation]] (also called [[fresh install]]) completely wipes the [[hard drive]], removes all previous [[operating system]] files, [[applications]], and user data, then installs a new [[Windows]] instance on bare metal.

**What Gets Deleted**:
- All [[user accounts]] and [[user profiles]]
- All [[applications]] and installed software
- All personal files and documents
- All system configurations and customizations
- Entire [[file system]] structure

**When to Choose Clean Installation**:
- System is heavily infected with [[malware]]
- [[Hard drive]] has accumulated corruption errors
- Migrating to new hardware with different architecture
- Need absolute performance optimization
- No valuable user data remains on the system
- Complete security reset is required

### Pre-Upgrade Considerations

**Backup Strategy**: Before any upgrade attempt, verify that critical data exists on external storage or backup media. An [[in-place upgrade]] should theoretically preserve everything, but hardware failures or unexpected errors can happen.

**Hardware Compatibility**: Check that your processor, [[RAM]], and storage meet minimum [[Windows]] requirements for the target version. Some upgrades may require drivers for newer [[kernel]] versions.

**Application Compatibility**: Test that mission-critical software supports the new [[Windows]] version. Legacy applications sometimes break after OS upgrades.

```
Pre-Upgrade Checklist:
✓ Backup critical user data
✓ Verify hardware meets minimum requirements
✓ Check application compatibility
✓ Disable antivirus temporarily during upgrade
✓ Ensure adequate free disk space (15-20GB recommended)
✓ Document current network configuration
✓ Take system image before proceeding
```

---

## Exam Tips

### Question Type 1: Upgrade vs. Clean Install Scenario
- *"A user has three [[local user accounts]] with custom [[desktop]] configurations and specialized CAD software. The system is stable but running outdated [[Windows 7]]. What's the best deployment method?"* → **In-place upgrade** preserves accounts, configs, and software; minimal downtime.
- *"A laptop is severely infected with [[ransomware]] affecting the [[Windows]] system files. User data is recovered to external [[SSD]]. What's required?"* → **Clean installation** because system integrity is compromised; [[malware]] may persist through [[in-place upgrade]].
- **Trick**: The exam often presents scenarios where both *seem* viable. Read carefully—if the question emphasizes "preserving existing configurations" → upgrade. If it mentions "removing all traces" or "infection" → clean install.

### Question Type 2: Technical Consequences
- *"After an [[in-place upgrade]], a legacy application throws [[DLL]] errors. Why?"* → The new [[Windows]] version may have deprecated [[API|APIs]] or changed [[library]] versions; [[backward compatibility]] isn't guaranteed.
- **Trick**: Don't assume upgrades are always safer. They can introduce compatibility problems that a clean install might avoid.

### Question Type 3: Resource Requirements
- *"An [[in-place upgrade]] requires approximately ___ GB of free disk space?"* → **15-20 GB** minimum; the process needs room for temporary files and redundancy.
- **Trick**: The exam loves asking about storage. Remember: clean installs need similar space, but upgrades need extra breathing room.

---

## Common Mistakes

### Mistake 1: Assuming In-Place Upgrade Always Works
**Wrong**: "An [[in-place upgrade]] is always safe because it preserves everything."
**Right**: Upgrades can fail if hardware incompatibilities exist, if corrupted [[registry]] entries exist, or if the system doesn't meet minimum requirements. Corrupted user profiles can break after an upgrade.
**Impact on Exam**: You might select "upgrade" when the scenario actually describes a system so corrupted it needs a [[clean installation]]. Look for red flags: system hangs, [[blue screen]] errors, or malware presence.

### Mistake 2: Confusing Data Loss Risk
**Wrong**: "A clean install is dangerous because you lose all data."
**Right**: A clean install *deletes* the [[operating system]] partition, but if data is on a *separate partition* or external drive, it's safe. The user must back up beforehand, but the data itself doesn't disappear unless you format the wrong drive.
**Impact on Exam**: Questions sometimes describe scenarios where data is already external. Recognize that a clean install becomes the *better* choice if the system is damaged.

### Mistake 3: Overlooking Application Licensing
**Wrong**: "An [[in-place upgrade]] automatically reactivates all [[Windows]] licenses."
**Right**: While the [[Windows license]] typically transfers to the upgraded system, third-party [[application licenses]] (like Microsoft Office, Adobe Creative Suite) *may not* automatically recognize the new system configuration. Re-authentication might be required.
**Impact on Exam**: A question might ask about post-upgrade support calls. The answer: "Users must re-license their applications" is often buried in multi-part scenarios.

### Mistake 4: Forgetting About Disk Space Requirements
**Wrong**: "If the drive has 5GB free, an [[in-place upgrade]] will work."
**Right**: [[Windows]] upgrades need 15-20GB of temporary working space, even on drives with existing data.
**Impact on Exam**: A troubleshooting scenario might describe an upgrade that failed halfway. Low disk space is a common culprit the exam tests.

---

## Related Topics
- [[Windows Installation Methods]]
- [[User Profiles and Registry]]
- [[System Backup and Recovery]]
- [[Hardware Requirements and Compatibility]]
- [[Windows Activation and Licensing]]
- [[Application Compatibility Troubleshooting]]
- [[File System Structure (NTFS)]]
- [[Device Driver Management]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 2 (220-1202) | [[A+]] | [[Windows Operating Systems]]*