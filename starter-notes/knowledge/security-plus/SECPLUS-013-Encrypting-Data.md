---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 013
source: rewritten
---

# Encrypting Data
**Protecting sensitive information stored on physical devices requires strategic encryption approaches tailored to scope and sensitivity.**

---

## Overview
When you need to safeguard information residing on storage media—whether SSDs, traditional hard drives, or other persistent storage—encryption becomes essential. The Security+ exam emphasizes [[data at rest]] protection as a foundational security control. Understanding which encryption granularity to deploy (full volume versus individual files) and which tools accomplish each task is critical for security professionals managing confidentiality of stored assets.

---

## Key Concepts

### Data at Rest
**Analogy**: Imagine a filing cabinet in a locked safe. The cabinet holds documents, and [[data at rest]] is like those documents sitting safely inside—they're not moving, but they still need protection against someone breaking into that safe.
**Definition**: Information stored on physical media that is not actively being transmitted or processed. This contrasts with [[data in transit]] (moving across networks) and [[data in use]] (being actively processed by applications).
- Requires protection regardless of the storage device type
- Can be encrypted at multiple granularity levels
- Applies to databases, file systems, and block storage

---

### Full Disk/Volume Encryption
**Analogy**: Think of shrink-wrapping an entire package before shipping—everything inside gets protected as one unit, rather than wrapping individual items separately.
**Definition**: [[Full disk encryption]] (or [[full volume encryption]]) encrypts all data on an entire storage device using a single [[symmetric encryption]] key, making the entire volume inaccessible without proper authentication.

| **Operating System** | **Native Tool** | **Scope** | **Key Management** |
|---|---|---|---|
| Windows | [[BitLocker]] | Full volume/disk | TPM or USB recovery key |
| macOS | [[FileVault]] | Full volume/disk | User password or recovery key |
| Linux | [[LUKS]] (Linux Unified Key Setup) | Full volume/disk | Passphrase-based |
| Cross-platform | Third-party solutions | Varies | Depends on implementation |

**When to Use**: 
- Protecting entire systems (especially mobile/portable devices)
- Meeting compliance requirements (HIPAA, GDPR)
- Rapid decommissioning of hardware

---

### File-Level Encryption
**Analogy**: Instead of wrapping the entire package, you seal only the sensitive documents inside the cabinet with individual locks—some items remain accessible, others stay protected.
**Definition**: [[File-level encryption]] protects individual files or folders while leaving the rest of the file system unencrypted. Only specified data objects are encrypted using a [[symmetric key]].

**Windows EFS (Encrypting File System)**:
- Built into [[NTFS]] file system
- Accessed via Advanced Attributes on file/folder properties
- Select "Encrypt contents to secure data"
- Uses [[Data Encryption Standard]] (DES) or [[Advanced Encryption Standard]] (AES) internally
- Integrates with user credentials for transparent decryption

**Cross-Platform Options**:
- macOS: Third-party encrypted containers
- Linux: eCryptfs, EncFS
- Windows/macOS/Linux: Commercial tools (VeraCrypt, 7-Zip with encryption)

**When to Use**:
- Encrypting sensitive documents on mixed-use systems
- Selective protection without full-disk overhead
- Protecting data within shared environments

---

### Transparent Database Encryption
**Analogy**: Imagine a secured filing system where documents automatically lock when filed and unlock when accessed—the librarian never manually turns the key, it happens invisibly.
**Definition**: [[Transparent Data Encryption]] (TDE) automatically encrypts data as it's written to database storage and decrypts it when retrieved, using a [[symmetric encryption]] key, without requiring application code changes.

**Key Characteristics**:
- Uses symmetric key (typically [[AES]]) for all data in the database
- Encryption/decryption happens automatically at storage I/O level
- Transparent to application layer
- Protects data files on disk only (not in-memory or in-transit)

**Encryption Scope in Databases**:
- **Whole database**: All tables, indexes, logs encrypted
- **Selective columns**: Only sensitive columns encrypted (e.g., Social Security numbers, credit cards)
- **Search limitation**: Encrypted columns cannot be queried efficiently without decryption overhead

**When to Use**:
- Regulatory compliance (PCI-DSS for payment data, HIPAA for health records)
- Protecting database backups
- Meeting data residency security requirements

---

## Exam Tips

### Question Type 1: Identifying Correct Encryption Method
- *"A Windows administrator needs to encrypt only sensitive HR files on a shared server while leaving other files accessible. Which solution is most appropriate?"* → **EFS (Encrypting File System)** — provides file-level granularity without full-volume impact
- *"An organization must ensure all data on employee laptops is encrypted to meet GDPR compliance. Which approach is best?"* → **BitLocker (Windows) / FileVault (macOS)** — full-disk encryption protects all data
- **Trick**: Don't confuse [[full disk encryption]] (faster, simpler) with [[file-level encryption]] (more granular, higher overhead). Exam questions test your ability to match the right tool to the requirement.

### Question Type 2: Database Protection Scenarios
- *"A financial services firm stores credit card data in a PostgreSQL database. How should they protect this data at rest?"* → **Transparent Data Encryption (TDE)** — automatically protects stored data without application changes
- **Trick**: TDE protects data at rest in the database, but NOT data extracted into memory or transmitted over the network—don't assume it's a complete security solution.

### Question Type 3: Cross-Platform Considerations
- *"An organization uses Windows, macOS, and Linux workstations. Which encryption method works uniformly across all platforms?"* → **Third-party tools** like VeraCrypt or encrypted containers—native solutions are OS-specific
- **Trick**: BitLocker and FileVault are platform-specific; the exam tests whether you recognize this limitation.

---

## Common Mistakes

### Mistake 1: Treating Full-Disk and File-Level Encryption as Interchangeable
**Wrong**: "We'll just use EFS on all files because it's more granular than BitLocker."
**Right**: Choose based on use case—full-disk encryption for comprehensive protection, file-level for selective security on shared systems. Full-disk is simpler operationally; file-level is more flexible.
**Impact on Exam**: Questions test scenario-based decisions. A question asking "protect an entire laptop" expects full-disk answers; "protect only payroll spreadsheets" expects file-level answers.

### Mistake 2: Assuming TDE Encrypts Data in All States
**Wrong**: "If we enable TDE, our database data is completely secure everywhere."
**Right**: TDE protects data at rest on storage media only. It does NOT encrypt data in memory, in backups (unless separately encrypted), or in transit over the network.
**Impact on Exam**: Expect questions asking what TDE does and doesn't protect—you need to identify it as a storage-layer control, not an end-to-end security solution.

### Mistake 3: Confusing Encryption Keys with Passwords
**Wrong**: "BitLocker uses the user's Windows password as the encryption key."
**Right**: BitLocker uses a complex cryptographic key (stored in [[TPM]] or on a USB recovery key); the password may unlock access to that key, but they're not the same.
**Impact on Exam**: Security+ questions test whether you understand key management versus authentication—these are distinct security functions.

### Mistake 4: Overlooking Compliance and Performance Trade-offs
**Wrong**: "Full-disk encryption has no performance penalty."
**Right**: Encryption adds CPU overhead (though modern hardware mitigates this). File-level encryption allows selective protection but increases management complexity. TDE adds I/O latency.
**Impact on Exam**: Real-world scenarios ask you to balance security requirements against organizational constraints—recognize these trade-offs.

---

## Related Topics
- [[Symmetric Encryption]]
- [[Advanced Encryption Standard (AES)]]
- [[Data Encryption Standard (DES)]]
- [[Trusted Platform Module (TPM)]]
- [[Data in Transit]]
- [[Data in Use]]
- [[Backup Encryption]]
- [[Key Management]]
- [[NTFS]]
- [[File System Security]]
- [[Database Security]]
- [[Compliance and Encryption]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]] | [[Cryptography and Data Protection]]*