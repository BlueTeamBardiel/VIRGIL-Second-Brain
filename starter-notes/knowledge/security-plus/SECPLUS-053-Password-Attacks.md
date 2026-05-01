---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 053
source: rewritten
---

# Password Attacks
**Understanding how adversaries exploit weak credential storage and authentication mechanisms.**

---

## Overview
Password attacks represent one of the most direct threats to system security because credentials are the gateway to everything an organization protects. Throughout your IT career, you'll encounter applications—unfortunately—that fail to properly secure stored passwords, creating catastrophic vulnerabilities when attackers gain access to credential databases. For Security+ professionals, understanding password attack vectors is essential because it directly informs how you design, audit, and remediate authentication systems.

---

## Key Concepts

### Plaintext Password Storage
**Analogy**: Storing passwords in plaintext is like leaving your house keys on a sign next to your front door—anyone who finds the location immediately has complete access without needing to figure anything out.

**Definition**: [[Plaintext]] credential storage refers to saving usernames and passwords in their original, unencrypted form within databases or configuration files. This is sometimes called "in the clear" storage.

When attackers gain database access through [[SQL Injection]], [[File Disclosure]], or [[Data Breach]], they instantly obtain every credential without additional work. There is no recovery option other than completely discontinuing the vulnerable application or requiring the developer to redesign the authentication system entirely.

---

### Hashing for Password Protection
**Analogy**: [[Hashing]] is like converting a book into a unique fingerprint—even a tiny change in the book creates a completely different fingerprint, and you can never recreate the original book from the fingerprint alone.

**Definition**: [[Hashing]] converts variable-length input (passwords) into a fixed-length output string, often called a [[Message Digest]] or [[Fingerprint]]. This cryptographic function ensures that different passwords produce distinctly different hash values.

**Key Properties**:
- One-way transformation (cannot reverse to plaintext)
- Deterministic (same input always produces same output)
- Avalanche effect (tiny input change = completely different output)
- Fixed output length regardless of input size

| Characteristic | Plaintext | Hashed |
|---|---|---|
| Reversible | Yes (vulnerability) | No (secure) |
| Stored directly | Password itself | Cryptographic digest |
| Database breach impact | Immediate compromise | Requires cracking |
| User-to-hash ratio | One password = one hash | One unique hash per unique password |

---

### Common Password Attack Methods

#### Dictionary Attacks
**Analogy**: Instead of randomly guessing every possible combination, you're flipping through a list of common words and trying each one methodically—like going through a restaurant menu instead of creating your own dishes.

**Definition**: [[Dictionary Attacks]] use pre-compiled lists of common passwords, words, and previously compromised credentials to systematically attempt authentication or crack hashes.

---

#### Brute Force Attacks
**Analogy**: You're trying every single key on an enormous keyring until one works—exhausting but eventually guaranteed to succeed given enough time.

**Definition**: [[Brute Force Attacks]] attempt every possible password combination systematically, starting from simple credentials and increasing complexity.

**Factors affecting feasibility**:
- Password length and complexity requirements
- [[Computational Power]] available
- [[Hash Algorithm]] strength
- [[Salt]] usage (additional security layer)

---

#### Rainbow Tables
**Analogy**: Instead of computing password hashes on the fly, you've pre-built a massive lookup table comparing common passwords to their hashes—it's like having a cheat sheet already written before the test.

**Definition**: [[Rainbow Tables]] are pre-computed databases containing millions of plaintext passwords and their corresponding hash values, allowing attackers to perform instant "cracking" through simple lookup rather than computation.

**Defense**: [[Salt]] (random data added to passwords before hashing) defeats rainbow tables by making each hash unique even for identical passwords.

---

#### Credential Stuffing
**Analogy**: You've discovered a list of usernames and passwords from one breached service, so you automatically try those same combinations across dozens of other websites—many users reuse credentials everywhere.

**Definition**: [[Credential Stuffing]] leverages previously compromised username/password pairs from one data breach to attempt unauthorized access across multiple unrelated services.

---

#### Spray Attacks
**Analogy**: Instead of repeatedly guessing one person's password, you try a single common password against hundreds of user accounts—like trying "password123" against everyone's account instead of trying everything against one person.

**Definition**: [[Spray Attacks]] (also [[Password Spraying]]) attempt a small number of commonly-used passwords across many user accounts, avoiding account lockout thresholds while exploiting poor password choices.

---

## Exam Tips

### Question Type 1: Storage and Protection Methods
- *"An organization discovers its application stores passwords as plaintext. What is the BEST immediate action?"* → Discontinue the application and require developer remediation; no alternative exists that adequately protects credentials.
- **Trick**: Candidates sometimes suggest "just encrypt the passwords"—but [[Encryption]] allows decryption if keys are compromised. [[Hashing]] is irreversible, making it superior for password storage.

---

### Question Type 2: Attack Methodology Identification
- *"An attacker uses pre-computed hash-to-plaintext lookup tables. Which attack is this?"* → [[Rainbow Tables]].
- **Trick**: Don't confuse with [[Dictionary Attacks]]—rainbow tables involve pre-computation; dictionary attacks compute hashes in real-time during the attack.

---

### Question Type 3: Defense Mechanisms
- *"How does adding random data to passwords before hashing improve security?"* → [[Salt]] prevents rainbow table attacks because identical passwords produce different hashes.
- **Trick**: [[Salt]] does NOT slow down [[Brute Force Attacks]] meaningfully—it only defeats pre-computed tables. [[Key Stretching]] and [[Bcrypt]] slow brute force.

---

## Common Mistakes

### Mistake 1: Confusing Encryption and Hashing for Password Storage
**Wrong**: "We'll use [[AES Encryption]] to protect stored passwords—that's secure."
**Right**: Passwords should use [[Hashing]], not encryption. Encryption is reversible (especially dangerous if encryption keys are compromised). Hashing is irreversible.
**Impact on Exam**: Security+ expects you to distinguish that encryption is for data you need to read back (databases, files); hashing is for passwords you never need to decrypt, only verify.

---

### Mistake 2: Assuming Salt Prevents Brute Force
**Wrong**: "If we use salt, brute force attacks become impossible."
**Right**: [[Salt]] prevents rainbow table attacks and ensures identical passwords produce different hashes. [[Brute Force]] still works but must compute hashes during the attack (slower, but not prevented). [[Key Stretching]] algorithms ([[Bcrypt]], [[PBKDF2]]) actually slow brute force.
**Impact on Exam**: Questions specifically test whether you know salt's actual function versus what it does NOT prevent.

---

### Mistake 3: Treating All Password Attacks as Equivalent
**Wrong**: "Dictionary attacks and brute force are basically the same thing."
**Right**: [[Dictionary Attacks]] use curated word lists (fast, effective against real passwords). [[Brute Force]] tries every combination (slow, but guaranteed to find any password eventually if given time).
**Impact on Exam**: Scenario questions ask which attack is "most likely to succeed quickly"—the answer depends on password composition and wordlist quality.

---

### Mistake 4: Not Recognizing Credential Stuffing Requirements
**Wrong**: "Credential stuffing only works if the target system uses plaintext passwords."
**Right**: [[Credential Stuffing]] works against systems with hashed passwords too—the attacker already knows the plaintext passwords from a different breach and simply tries them for authentication (not attempting to crack hashes).
**Impact on Exam**: This distinction separates credential stuffing (authentication attack) from hash cracking (offline attack).

---

## Related Topics
- [[Authentication Mechanisms]]
- [[Encryption vs. Hashing]]
- [[Key Stretching]]
- [[Bcrypt]]
- [[PBKDF2]]
- [[Salting]]
- [[Rainbow Tables]]
- [[Multi-Factor Authentication]]
- [[Account Lockout Policies]]
- [[Access Control]]
- [[Cryptography Fundamentals]]

---

*Source: Professor Messer CompTIA Security+ SY0-701 | [[Security+]]*