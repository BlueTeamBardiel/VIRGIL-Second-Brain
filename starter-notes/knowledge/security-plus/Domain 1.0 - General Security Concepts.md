---
domain: "Security+"
tags: [security-concepts, cryptography, authentication, access-control, security-controls, exam-domain]
---
# Domain 1.0 - General Security Concepts

**Domain 1.0** of the CompTIA Security+ SY0-701 exam establishes the foundational vocabulary and conceptual framework that underpins all of cybersecurity practice. This domain covers **security controls**, **cryptographic principles**, **authentication mechanisms**, and **zero trust architecture** — concepts that appear repeatedly across all other exam domains and real-world security work. Understanding this material deeply is non-negotiable; it is the shared language spoken across [[Access Control Models]], [[Cryptography]], and [[Identity and Access Management]].

---

## Overview

Domain 1.0 accounts for **12% of the Security+ SY0-701 exam** and serves as the conceptual bedrock for everything else in the certification. Where later domains focus on applied threats, architecture, or operations, Domain 1.0 asks: *what are we actually doing when we "do security"?* It answers by defining the types of controls we apply, the models we use to make decisions, the cryptographic tools we deploy, and the authentication factors we rely on. Without internalizing these fundamentals, a practitioner cannot reason clearly about why any specific security measure matters.

The domain begins with **security control categories and types**. Controls are classified by *category* — managerial (administrative), operational, and technical — and by *type* — preventive, deterrent, detective, corrective, compensating, and directive. This two-axis classification system lets security teams build defense-in-depth strategies that cover every angle: a locked server room door is a physical, preventive control; a security awareness training program is a managerial, directive control; a SIEM alert is a technical, detective control. Real security programs deliberately stack controls across multiple categories and types so that no single failure creates a catastrophic breach.

The **CIA Triad** — Confidentiality, Integrity, and Availability — forms the philosophical core of this domain. Every security decision is ultimately a trade-off analysis among these three properties. Encrypting a database at rest improves confidentiality but may introduce latency that affects availability. Requiring MFA improves the integrity of authentication but may reduce usability. Security professionals must be able to articulate which property a given control protects and what trade-offs are being accepted. The triad is extended in some frameworks by adding **Non-repudiation** (ensuring a party cannot deny an action) and **Authenticity** (verifying identity and data origin).

**Cryptography** occupies a major portion of Domain 1.0. Candidates must understand symmetric encryption (same key for encryption and decryption), asymmetric encryption (public/private key pairs), hashing (one-way functions), and the use cases for each. They must know specific algorithms — AES, RSA, ECC, SHA-256, HMAC — not as implementers but as informed decision-makers who can choose the right tool for the right job. The domain also introduces PKI (Public Key Infrastructure), digital signatures, and certificate authorities, which bridge cryptographic theory into operational reality.

Finally, Domain 1.0 addresses **authentication and authorization concepts** including multi-factor authentication, single sign-on, federation, and the emerging **Zero Trust** security model. Zero Trust is not a product but a philosophy: *never trust, always verify*. Every access request — regardless of network location — must be authenticated, authorized, and continuously validated. This model directly counters the old perimeter-based "castle and moat" approach that failed so catastrophically in incidents like the 2013 Target breach and the 2020 SolarWinds attack.

---

## How It Works

### Security Control Framework

Security controls are organized along two independent axes that can be combined to describe any specific control precisely:

**Category (the "who implements it" axis):**
- **Technical** — implemented by technology (firewalls, encryption, IDS/IPS)
- **Managerial/Administrative** — implemented through policy, process, and governance (security policies, risk assessments, training)
- **Operational** — implemented by people following procedures (guard rotations, change management, incident response procedures)
- **Physical** — implemented through physical means (locks, cameras, badge readers, bollards)

**Type (the "what it does" axis):**
- **Preventive** — stops an attack before it succeeds (firewall ACL, locked door)
- **Deterrent** — discourages attack without blocking it (warning signs, visible cameras)
- **Detective** — identifies an attack in progress or after the fact (SIEM, IDS, audit logs)
- **Corrective** — reduces impact after an attack (patching after exploitation, restoring from backup)
- **Compensating** — alternative control when primary cannot be implemented (camera in place of a lock that cannot be installed)
- **Directive** — directs users toward secure behavior (acceptable use policies, security training)

A single real-world security measure can belong to multiple categories and types simultaneously. A badge-entry door is Physical + Preventive. A CCTV system is Physical + Detective + Deterrent.

### The CIA Triad in Practice

```
Confidentiality:
  - Encryption at rest (AES-256)
  - Encryption in transit (TLS 1.3)
  - Access control lists
  - Data classification

Integrity:
  - Hashing (SHA-256, SHA-3)
  - Digital signatures
  - HMAC (Hash-based Message Authentication Code)
  - File integrity monitoring (Tripwire, AIDE)

Availability:
  - Redundancy (RAID, clustering)
  - Backups (3-2-1 rule)
  - DDoS mitigation (Cloudflare, Akamai)
  - UPS and generator systems
```

### Symmetric Encryption Mechanism

Symmetric encryption uses the **same key** for both encryption and decryption. The canonical modern algorithm is **AES (Advanced Encryption Standard)**:

1. Plaintext data is divided into 128-bit blocks
2. The key (128, 192, or 256 bits) is expanded via a key schedule
3. Data undergoes multiple rounds of substitution, permutation, mixing, and XOR operations
4. Output is ciphertext indistinguishable from random data

**Common modes of operation:**
- **CBC (Cipher Block Chaining)** — each block XORed with previous ciphertext; requires IV; vulnerable to padding oracle attacks
- **GCM (Galois/Counter Mode)** — provides both encryption and authentication (AEAD); preferred for TLS 1.3
- **ECB (Electronic Codebook)** — each block encrypted independently; *insecure* — identical plaintext blocks produce identical ciphertext blocks (the "penguin problem")

```bash
# AES-256-GCM encryption with OpenSSL
openssl enc -aes-256-gcm -salt -in plaintext.txt -out encrypted.bin -k "passphrase"

# Decryption
openssl enc -aes-256-gcm -d -in encrypted.bin -out decrypted.txt -k "passphrase"
```

### Asymmetric Encryption Mechanism

Asymmetric encryption uses a **mathematically linked key pair**: a public key (freely shared) and a private key (kept secret). RSA relies on the computational difficulty of factoring large prime products:

1. Select two large prime numbers *p* and *q*
2. Compute *n = p × q* (the modulus, e.g., 2048 or 4096 bits)
3. Public key = (n, e); Private key = (n, d) where *e × d ≡ 1 (mod φ(n))*
4. Encryption: *C = M^e mod n*
5. Decryption: *M = C^d mod n*

**Use cases:**
| Operation | Who uses which key |
|---|---|
| Encrypt for confidentiality | Sender encrypts with **recipient's public key** |
| Decrypt | Recipient decrypts with **their private key** |
| Sign for authenticity | Sender signs with **their private key** |
| Verify signature | Recipient verifies with **sender's public key** |

**ECC (Elliptic Curve Cryptography)** achieves equivalent security to RSA with much shorter key lengths — a 256-bit ECC key provides security comparable to a 3072-bit RSA key — making it preferred for mobile and IoT environments.

### Hashing

Hashing is a **one-way function** that produces a fixed-length digest from arbitrary input. Good cryptographic hash functions are:
- **Deterministic** — same input always yields same output
- **Pre-image resistant** — cannot recover input from output
- **Collision resistant** — infeasible to find two inputs producing the same hash
- **Avalanche effect** — small change in input causes dramatic change in output

```bash
# SHA-256 hash of a file
sha256sum /etc/passwd
# Output: a3f1c2...  /etc/passwd

# Verify file integrity
echo "expected_hash  filename" | sha256sum --check

# MD5 (deprecated for security, still seen in legacy systems)
md5sum file.txt

# HMAC-SHA256 (adds authentication to hashing)
openssl dgst -sha256 -hmac "secret_key" message.txt
```

| Algorithm | Output Size | Status |
|---|---|---|
| MD5 | 128 bits | **Broken** — collision attacks trivial |
| SHA-1 | 160 bits | **Deprecated** — SHAttered collision attack (2017) |
| SHA-256 | 256 bits | **Current standard** |
| SHA-3 (Keccak) | Variable | **Current** — different internal construction than SHA-2 |
| BLAKE2 | Variable | **Current** — faster than SHA-256 in software |

### Zero Trust Architecture

Zero Trust is implemented through several core technical mechanisms:

```
Traditional Model:      Zero Trust Model:
[Internet] --- [Firewall] --- [Trusted LAN]
                              User can access anything

[Internet] --- [Policy Engine] --- [Resource]
                    ↑
              Continuous verification:
              - Identity (who are you?)
              - Device posture (is this device healthy?)
              - Location/context (expected behavior?)
              - Least-privilege access (minimum permissions)
              - Session monitoring (ongoing validation)
```

Key Zero Trust components per NIST SP 800-207:
- **Policy Decision Point (PDP)** — the "brain" that evaluates access requests
- **Policy Enforcement Point (PEP)** — the "gatekeeper" that allows/denies access based on PDP decisions
- **Policy Information Point (PIP)** — data sources feeding the PDP (threat intel, identity stores, device compliance)

### Authentication Factors

```
Something You Know:    Password, PIN, security question
Something You Have:    TOTP token (Google Authenticator), hardware key (YubiKey), smart card
Something You Are:     Fingerprint, retina scan, facial recognition, voice recognition
Somewhere You Are:     Geolocation, network location (IP range)
Something You Do:      Typing cadence, gait analysis (behavioral biometrics)
```

**MFA** requires two or more *different categories* of factors. Requiring two passwords is not MFA — it is 2FA but using only one factor category.

**TOTP (Time-based One-Time Password)** per RFC 6238:
1. Shared secret provisioned during setup (usually via QR code)
2. Current Unix timestamp divided by 30-second window
3. HMAC-SHA1(secret, time_counter) → truncated to 6-digit code
4. Both client and server compute same value independently

---

## Key Concepts

- **CIA Triad** — The three foundational security properties: **Confidentiality** (data accessible only to authorized parties), **Integrity** (data accurate and unaltered), and **Availability** (data and systems accessible when needed). Every security control maps back to protecting at least one of these properties.

- **Non-repudiation** — The cryptographic guarantee that a party cannot deny having sent or received a message. Achieved through **digital signatures** (asymmetric cryptography applied to a hash of the message). Critical in legal, financial, and compliance contexts.

- **Defense in Depth** — A security strategy employing **multiple layered controls** so that if one control fails, others remain effective. Borrowed from military doctrine; applied in security through combinations of technical, administrative, and physical controls across preventive, detective, and corrective types.

- **Least Privilege** — The principle that users, processes, and systems should have **only the minimum permissions necessary** to perform their authorized functions, and nothing more. Violations of this principle are a root cause in many data breaches (e.g., a compromised service account with Domain Admin privileges).

- **Zero Trust** — A security model built on the assumption that **no user, device, or network segment is inherently trusted**, regardless of physical or logical location. Every access request must be authenticated, authorized based on context, and continuously monitored. Defined formally in NIST SP 800-207.

- **Public Key Infrastructure (PKI)** — The **framework of policies, processes, and technologies** used to create, distribute, store, and revoke digital certificates. Core components include Certificate Authorities (CAs), Registration Authorities (RAs), Certificate Revocation Lists (CRLs), and the Online Certificate Status Protocol (OCSP).

- **Key Exchange** — The process of securely establishing a shared secret over an insecure channel. **Diffie-Hellman (DH)** allows two parties to derive an identical shared secret without ever transmitting it; **ECDHE** (Elliptic Curve Diffie-Hellman Ephemeral) provides forward secrecy because session keys are discarded after use.

- **Obfuscation vs. Encryption** — **Obfuscation** makes data harder to understand without a key but provides no mathematical security guarantee (e.g., Base64 encoding, steganography). **Encryption** provides mathematically provable confidentiality when implemented correctly. Obfuscation alone is *security through obscurity* and is not an acceptable primary control.

- **Salting** — Adding a **random value (salt)** to a password before hashing, stored alongside the hash. Prevents precomputed rainbow table attacks and ensures two users with the same password have different stored hashes. **bcrypt**, **scrypt**, and **Argon2** are purpose-built password hashing functions that include salting and are deliberately slow to resist brute force.

- **Federated Identity** — A system where **identity information is shared across organizational boundaries** using trust relationships. Standards include SAML 2.0, OAuth 2.0, and OpenID Connect (OIDC). Enables SSO across different organizations without sharing credential stores.

---

## Exam Relevance

### SY0-701 Specific Focus Areas

**Domain 1.0 is 12% of the exam** (approximately 14-17 questions). The SY0-701 update significantly expanded coverage of:
- Zero Trust concepts (previously minor, now heavily tested)
- Physical security controls (now explicitly listed under control categories)
- Quantum-resistant cryptography awareness (NIST post-quantum candidates: CRYSTALS-Kyber, CRYSTALS-Dilithium)

### Common Question Patterns

**Pattern 1: Control Category/Type Classification**
> *"An organization deploys a CCTV system in the data center. What type of control is this?"*
> The trap: CCTV is **both** Detective (records events) **and** Deterrent (discourages attackers). Read the question carefully — it may ask for *primary* function or give answer choices that force you to pick one. If "deterrent" is not an option, "detective" is the safe answer.

**Pattern 2: Which Cryptographic Algorithm for Which Scenario**
> *"A company needs to ensure non-repudiation for email communications. Which technology should be used?"*
> Answer: **Digital signatures** (asymmetric crypto signing a hash of the message). Non-repudiation requires the sender's private key, which only they control.

**Pattern 3: Authentication Factor Categorization**
> *"A user authenticates with a fingerprint and a PIN. How many factors are being used?"*
> Answer: **Two factors** (something you are + something you know). If a question says "password and security question," that is only **one factor** (two knowledge factors = still one category).

**Pattern 4: Symmetric vs. Asymmetric Use Cases**
> Remember: **Symmetric is fast → bulk data encryption**. **Asymmetric is slow → key exchange and signatures**. TLS uses asymmetric crypto to exchange a symmetric session key, then uses that symmetric key for the actual data stream.

### Critical Gotchas

- **MD5