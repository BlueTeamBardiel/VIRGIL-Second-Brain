---
tags: [knowledge, aplus, core-2-(220-1202)]
created: 2026-04-30
cert: CompTIA A+
chapter: 50
source: rewritten
---

# Security Best Practices
**Encryption transforms readable data into unreadable gibberish that only authorized people with the right key can decode.**

---

## Overview

[[Encryption]] is the cornerstone of modern data protection, scrambling information so that even if someone steals it, they can't read it. For the A+ exam, you need to understand where encryption happens (at rest vs. in transit), what tools Windows uses, and how [[encryption keys]] factor into your security strategy. This directly impacts real-world scenarios where you're protecting user data and company assets.

---

## Key Concepts

### Full Disk Encryption (FDE)

**Analogy**: Imagine a vault that locks up your entire house at once—every room, every drawer, everything inside gets protected by the same master lock. You only need one key to open everything.

**Definition**: [[Full Disk Encryption]] (also called [[FDE]]) encrypts an entire storage volume, protecting all data stored on that drive simultaneously.

| Aspect | Details |
|--------|---------|
| **Scope** | Entire drive/volume |
| **Windows Tool** | [[BitLocker]] |
| **macOS Tool** | [[FileVault]] |
| **Linux Tool** | [[LUKS]] |
| **Data State** | [[Data at Rest]] |

**Key Detail**: This is protecting "[[data at rest]]"—information sitting dormant on your hard drive, not moving across a network.

---

### Selective File/Folder Encryption

**Analogy**: Instead of locking the whole house, you're just putting individual documents in a safe within the house. Only the papers you care about get extra protection.

**Definition**: [[Selective encryption]] protects individual files or folders rather than the entire disk, offering granular control built into the [[file system]].

**Where You'll Find It**:
- Windows: Right-click file → Properties → Advanced → Encrypt contents
- macOS: Built into [[APFS]] file system
- Linux: Extended attributes or dedicated encryption tools

---

### Portable Device Encryption

**Analogy**: You're putting your important papers in a briefcase with a combination lock before you leave the office. If you lose the briefcase, the papers stay safe.

**Definition**: [[USB encryption]] and [[removable media encryption]] protect data on portable devices you carry, ensuring that lost or stolen hardware doesn't expose sensitive information.

**Why This Matters**: USB drives are the #1 way data walks out the door. Encrypted USB = peace of mind if it goes missing.

---

### Encryption Keys & Key Management

**Analogy**: The encryption key is like the master password to your vault. If someone gets the key, they can unlock everything. If you lose the key, you're locked out forever.

**Definition**: [[Encryption keys]] are the mathematical data used to lock (encrypt) and unlock (decrypt) information. Keys are typically:
- **Stored locally** on your machine
- **Integrated with login** (stored in [[BIOS]] or [[TPM]])
- **Centralized** in [[Active Directory]] for enterprise environments

**Critical Practice**: Always back up your encryption keys and recovery passwords. Losing them = losing access to your own data permanently.

| Key Storage Method | Pros | Cons |
|-------------------|------|------|
| **Local/TPM** | Fast, automatic with login | Lost if hardware fails |
| **Active Directory** | Centralized, recoverable | Requires network access |
| **External Backup** | Ultimate failsafe | Must be stored securely |

---

### Brute Force Attacks

**Analogy**: A burglar trying every key on a keyring one by one until something opens the door. It takes forever with a big keyring, but enough time and determination wins.

**Definition**: A [[brute force attack]] is when an attacker systematically tries every possible [[password]] or [[encryption key]] combination until one works.

**Why Encryption Beats Brute Force**:
- Modern [[AES-256]] encryption would take billions of years to brute force with current computers
- Long, complex passwords exponentially increase attack time
- [[Account lockout policies]] and [[rate limiting]] stop automated attacks

---

## Exam Tips

### Question Type 1: Identifying the Right Encryption Tool
- *"A company wants to encrypt all data on Windows workstations to protect against theft. Which tool should they use?"* → [[BitLocker]]
- *"A macOS user needs to encrypt their entire drive. What's the native solution?"* → [[FileVault]]
- **Trick**: Don't confuse [[BitLocker]] (full disk, Windows) with [[EFS]] (file-level, older Windows). BitLocker is the modern standard for A+.

### Question Type 2: Data at Rest vs. In Transit
- *"Which encryption method protects data stored on a hard drive?"* → [[Data at Rest]] encryption ([[FDE]] or selective file encryption)
- *"Which protects data moving across the network?"* → [[Data in Transit]] ([[TLS]]/[[SSL]], [[VPN]])
- **Trick**: "At rest" = storage device. "In transit" = network. The exam loves this distinction.

### Question Type 3: Key Management Scenarios
- *"An employee loses their laptop with BitLocker enabled. What should the IT department check first?"* → Do we have a recovery key backed up in [[Active Directory]]?
- **Trick**: The question isn't asking you to unlock the drive—it's testing whether you understand that keys must be backed up centrally.

---

## Common Mistakes

### Mistake 1: Thinking Encryption is a Password
**Wrong**: "I password-protected my folder, so it's encrypted."
**Right**: [[Encryption]] scrambles the actual data mathematically. A password protects access to encrypted data—they're not the same thing.
**Impact on Exam**: You'll face questions asking "Does setting a password encrypt data?" The answer is no—you need actual encryption tools like BitLocker.

### Mistake 2: Forgetting the Encryption Key Backup
**Wrong**: "We encrypted all drives with BitLocker, so we're done."
**Right**: If you lose the recovery key, you lose access to the entire drive. Recovery keys must be backed up to [[Active Directory]] or a secure location.
**Impact on Exam**: Scenario questions will ask "What's the most important step before enabling BitLocker?" Answer: secure key storage.

### Mistake 3: Confusing File-Level and Full-Disk Encryption
**Wrong**: "File encryption protects everything on the drive."
**Right**: File encryption only protects individual files. [[FDE]] protects the entire drive including the [[file system]] itself.
**Impact on Exam**: A question might ask which method prevents access to files even when the drive is removed. Answer: [[FDE]], because the whole drive is locked.

### Mistake 4: Not Backing Up Encrypted Data
**Wrong**: "Since it's encrypted, I don't need to back it up."
**Right**: Encryption protects against theft, not hardware failure. You need both encryption AND backups.
**Impact on Exam**: Questions about disaster recovery + security will test whether you understand both are necessary.

---

## Related Topics
- [[BitLocker]]
- [[FileVault]]
- [[Data at Rest]]
- [[Data in Transit]]
- [[Encryption Keys]]
- [[Active Directory]]
- [[TPM (Trusted Platform Module)]]
- [[Brute Force Attacks]]
- [[Password Security]]
- [[Backup and Recovery]]
- [[USB Security]]
- [[AES Encryption]]

---

*Source: Rewritten from Professor Messer CompTIA A+ Core 2 (220-1202) Security Best Practices | [[A+]] | [[CompTIA]]*