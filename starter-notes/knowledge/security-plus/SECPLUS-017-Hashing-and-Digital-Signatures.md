---
tags: [knowledge, security-plus, secplus]
created: 2026-05-01
cert: CompTIA Security+
exam: SY0-701
chapter: 017
source: rewritten
---

# Hashing and Digital Signatures
**Cryptographic hashing transforms data into fixed-length digital fingerprints, while digital signatures prove authenticity and prevent denial of responsibility.**

---

## Overview
Hashing and digital signatures are foundational cryptographic mechanisms tested extensively on Security+. Understanding their distinct purposes—hashing for [[integrity]] verification and digital signatures for [[authentication]] and [[non-repudiation]]—is critical for both practical security implementation and exam success. These concepts work together to protect data in transit and at rest.

---

## Key Concepts

### Cryptographic Hashing
**Analogy**: A cryptographic hash works like a tamper-evident seal on an envelope. No matter what's inside, the seal produces the same unique imprint each time you inspect it. Change even one letter in the envelope's contents, and the seal's imprint becomes completely different—revealing any tampering instantly.

**Definition**: A [[hash function]] processes input data of any size and produces a fixed-length output (called a [[hash value]], [[message digest]], or [[digital fingerprint]]) using mathematical algorithms. This process is [[one-way]] and [[deterministic]]—you cannot reverse-engineer the original data from the hash.

**Key Characteristics**:
- **One-way function**: Input → Hash (irreversible)
- **Deterministic**: Same input always produces identical output
- **Avalanche effect**: Tiny input changes produce completely different hashes
- **Fixed output length**: Regardless of input size

---

### Hash Algorithms
**Analogy**: Different hash algorithms are like different security cameras in a building. Some are older models (less reliable), some are newer and clearer (more secure). The newer the camera, the better the protection.

**Definition**: [[Hash algorithms]] are the mathematical procedures that transform data into hashes. Common algorithms include:

| Algorithm | Output Size | Status | Use Case |
|-----------|------------|--------|----------|
| [[MD5]] | 128 bits (32 hex chars) | Deprecated ⚠️ | Legacy systems only |
| [[SHA-1]] | 160 bits (40 hex chars) | Deprecated ⚠️ | Legacy compliance only |
| [[SHA-256]] | 256 bits (64 hex chars) | Current Standard ✓ | General purpose |
| [[SHA-384]] | 384 bits (96 hex chars) | Current Standard ✓ | High-security applications |
| [[SHA-512]] | 512 bits (128 hex chars) | Current Standard ✓ | Maximum security |
| [[BLAKE2]] | Variable (128-512 bits) | Modern Alternative ✓ | Performance-critical systems |

**Key Point**: [[SHA-256]] is the exam benchmark—it produces a 64-character hexadecimal string from any input.

---

### Hash vs. Encryption
**Analogy**: Encryption is like a locked safe (you can open it with the right key). Hashing is like turning something into powder (you can never reassemble it back to the original).

**Definition**: [[Encryption]] scrambles data so authorized parties can unscramble it. [[Hashing]] irreversibly transforms data into a one-way digest.

| Characteristic | [[Hashing]] | [[Encryption]] |
|---|---|---|
| Reversible? | ❌ No | ✅ Yes (with key) |
| Purpose | [[Integrity]] verification | Confidentiality |
| Key required? | ❌ No | ✅ Yes |
| Can recreate original? | ❌ No | ✅ Yes |
| Output predictable? | ✅ Yes (same input = same hash) | ❌ No (unless ECB mode) |

---

### Digital Signatures
**Analogy**: A digital signature works like a notarized document. The notary (private key holder) stamps the document with a unique seal that proves they reviewed it and it hasn't changed since. Anyone can verify the stamp, but only the notary can create it.

**Definition**: A [[digital signature]] is a cryptographic mechanism that uses [[asymmetric cryptography]] (public/private key pairs) to prove [[authentication]], [[non-repudiation]], and [[integrity]]. The signer uses their private key to create a signature; verifiers use the signer's public key to confirm authenticity.

**How Digital Signatures Work**:
1. Hash the original message using [[SHA-256]] (or similar)
2. Encrypt the hash using your [[private key]]
3. Send the message + encrypted hash to recipient
4. Recipient decrypts hash using your [[public key]]
5. Recipient hashes the received message
6. If hashes match → signature is valid and authentic

---

### Integrity Verification
**Analogy**: You download a file from the internet. The website also publishes a hash alongside the file. Download the file, run it through the same hash algorithm, and compare. If your hash matches the published hash, you know nobody tampered with the file during download.

**Definition**: [[Integrity verification]] uses hashing to confirm that data has not been modified since the hash was created. Any change to the data—intentional or accidental—produces a different hash.

**Practical Example**:
- Website publishes: `SHA-256: a3f9b2e1c4d8f7...` (for file.iso)
- You download file.iso
- You run: `sha256sum file.iso` → `a3f9b2e1c4d8f7...`
- ✅ Match = file is intact

---

### Non-Repudiation
**Analogy**: Signing a contract with your signature proves you signed it. You can't later claim "I didn't sign that" because your signature is unique to you. Digital signatures work the same way legally.

**Definition**: [[Non-repudiation]] is the assurance that the signer cannot deny creating or sending a message. Since only the holder of a private key can create signatures with that key, they cannot repudiate (deny) their involvement.

**Why This Matters**:
- ✅ Proves WHO created the message
- ✅ Proves WHEN it was signed
- ✅ Prevents "I didn't send that" claims
- ✅ Legally binding in contracts

---

### Avalanche Effect
**Analogy**: Imagine a giant avalanche on a mountain. One small pebble dislodged causes an enormous cascade. A single character change in hashing creates a completely different output.

**Definition**: The [[avalanche effect]] means that changing even a single bit of input produces a drastically different hash output. This makes tampering immediately detectable.

**Example**:
```
Input: "My name is Professor Messer."
SHA-256: 3a1f5e8b2c4d9a7f6e5b3c2d1a8f7e6d5c4b3a2f1e9d8c7b6a5f4e3d2c1b0a

Input: "My name is Professor Messer!"  (period → exclamation)
SHA-256: 9f8e7d6c5b4a3f2e1d0c9b8a7f6e5d4c3b2a1f0e9d8c7b6a5f4e3d2c1b0aff
```
Only ONE character changed, but the entire hash is unrecognizable.

---

## Exam Tips

### Question Type 1: Identifying Hash Algorithm Purpose
- *"Which hash algorithm produces a 256-bit output displayed as 64 hexadecimal characters?"* → [[SHA-256]]
- *"An organization needs maximum security and performance. Which algorithm should they choose?"* → [[SHA-512]] or [[BLAKE2]]
- **Trick**: Don't confuse [[MD5]] or [[SHA-1]] as acceptable answers—they're deprecated. Exam will mark these wrong.

### Question Type 2: Hash vs. Encryption Distinction
- *"Your organization needs to prevent users from denying they sent a message. Which technology should you implement?"* → [[Digital signatures]] (encryption + hashing)
- *"Which technology allows data to be recovered if you have the key?"* → [[Encryption]] (NOT hashing)
- **Trick**: Questions may present scenarios where you're asked "which prevents tampering?"—both hashing AND encryption can, but hashing is the integrity-specific tool.

### Question Type 3: Digital Signature Components
- *"A digital signature uses which cryptographic process?"* → [[Asymmetric encryption]] (private key to sign, public key to verify)
- *"What does a digital signature NOT provide?"* → [[Confidentiality]] (digital signatures don't hide message content)
- **Trick**: Candidates often confuse "authentication" with "encryption." Digital signatures authenticate the sender, not encrypt the message.

### Question Type 4: Non-Repudiation Scenarios
- *"The CEO claims he didn't approve a financial transfer. Which technology would prove he did?"* → [[Digital signature]]
- *"Which security goal is ONLY provided by digital signatures, not hashing alone?"* → [[Non-repudiation]]
- **Trick**: Hashing alone gives you integrity; you need asymmetric cryptography (digital signatures) for non-repudiation.

### Question Type 5: Real-World Application
- *"Users downloading software from your site need assurance the file hasn't been modified. What should you publish alongside the download?"* → [[Hash value]] (e.g., SHA-256 checksum)
- *"Which technology allows contract signatories to prove they agreed to terms?"* → [[Digital signature]]
- **Trick**: Don't confuse "proving authenticity of sender" (digital signature) with "proving file integrity" (hash).

---

## Common Mistakes

### Mistake 1: Treating Hashing as Encryption
**Wrong**: "If I hash my password, it's encrypted and secure."
**Right**: Hashing is one-way and irreversible. You cannot decrypt a hash. It's secure because the original password cannot be recovered, but it's not encryption.
**Impact on Exam**: Questions testing whether you understand that [[hashing]] ≠ [[encryption]]. You might see scenarios asking "can this be reversed?" The answer for hashing is always "no."

### Mistake 2: Confusing MD5/SHA-1 as Current Standards
**Wrong**: "I'll use MD5 for file integrity checks; it's a cryptographic hash."
**Right**: [[MD5]] and [[SHA-1]] are deprecated due to collision vulnerabilities. [[SHA-256]] or higher is the current standard.
**Impact on Exam**: Security+ heavily emphasizes deprecated vs. current algorithms. Any answer suggesting MD5 or SHA-1 for NEW implementations is incorrect. These appear only in "legacy system" scenarios.

### Mistake 3: Missing that Digital Signatures Require Hashing
**Wrong**: "Digital signatures encrypt the entire message with the private key."
**Right**: Digital signatures hash the message first, then encrypt the hash. Encrypting an entire large message is inefficient; encrypting a 64-character hash is practical.
**Impact on Exam**: Questions may ask "what is the FIRST step in creating a digital signature?"—the answer is [[hash the message]].

### Mistake 4: Assuming One Hash Always Means One Input
**Wrong**: "Two different files can't have the same hash."
**Right**: [[Hash collisions]] are theoretically possible (though astronomically rare with SHA-256). This is why SHA-256 is preferred over MD5.
**Impact on Exam**: Know that weaker algorithms ([[MD5]], [[SHA-1]]) have practical collision vulnerabilities, making them unsuitable for security-critical applications.

### Mistake 5: Not Distinguishing Between Hash Output Formats
**Wrong**: "A hash can be represented in binary, hexadecimal, or base64."
**Right**: The hash VALUE is the same; only the REPRESENTATION differs. SHA-256 is always 256 bits—whether shown as 64 hex characters or 43 base64 characters, it's the same data.
**Impact on Exam**: Don't be confused if exam shows the same hash in different formats. Focus on the algorithm name and bit length, not the character count of the representation.

### Mistake 6: Forgetting Non-Repudiation Requires Asymmetric Cryptography
**Wrong**: "Hashing provides non-repudiation because it proves the data hasn't changed."
**Right**: [[Non-repudiation]] requires [[digital signatures]], which use [[asymmetric encryption]] (private/public key pairs).