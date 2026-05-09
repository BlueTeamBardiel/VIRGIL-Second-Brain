# Hashing and Digital Signatures

## What it is

In Helldivers 2, when you call down a Hellpod, you punch a precise directional code into your Stratagem wrist-pad — up, down, left, right — and the orbital ship verifies that exact sequence before launching ordnance to your coordinates. If even one input is wrong, the Stratagem fails and nothing drops. Now imagine the ship also stamps each launched pod with your personal Helldiver insignia, so when it lands your squad knows it came from *you* and not a spoofed Automaton signal trying to drop a hostile payload on your position. That two-part mechanic — a fixed-length input code that fails on any deviation, plus a personal stamp proving origin — is exactly how [[hashing]] and [[digital signatures]] work together.

In plain English, **hashing** is a one-way mathematical function that takes any input (a file, a password, a message) and produces a fixed-length fingerprint. Change one bit of the input and the fingerprint changes drastically. You cannot reverse the fingerprint back into the original. **Digital signatures** layer on top: they combine a hash of a message with the sender's [[private key]] to prove both that the message hasn't been altered (integrity) and that it really came from the claimed sender (authenticity and non-repudiation).

Technically, a **cryptographic hash function** is a deterministic algorithm `H(x) → y` that maps arbitrary-length input `x` to a fixed-length output `y` (the digest), with three required properties: **preimage resistance** (given `y`, you cannot find `x`), **second preimage resistance** (given `x₁`, you cannot find a different `x₂` where `H(x₁) = H(x₂)`), and **collision resistance** (you cannot find any pair `x₁ ≠ x₂` where their hashes match). A **digital signature** is the encryption of a hash digest using the signer's private key; verification is performed by anyone using the signer's [[public key]] to decrypt the signature and compare it to a freshly computed hash of the received message.

## Why it matters

Hashing and digital signatures are the load-bearing beams under almost every trust decision a modern system makes. When your laptop installs a Windows update, it verifies the update's digital signature before executing a single instruction — without that check, an attacker who hijacked the download could ship malware signed as "Microsoft" and your machine would happily run it. When you log into a server, your password isn't compared to a stored copy; it's hashed and the hash is compared. When a [[TLS]] handshake completes, the certificate is trusted because a [[Certificate Authority]] digitally signed it. When Git tells you a commit is valid, it's checking SHA-1 (and increasingly SHA-256) hashes of every object in the tree.

Attack scenarios where these primitives fail are catastrophic. The 2017 SHA-1 collision (Google's "SHAttered" research) meant attackers could craft two different PDFs with the same hash — one benign, one malicious — and any system relying on SHA-1 for integrity would treat them as identical. The 2020 SolarWinds breach succeeded partly because the malicious DLL was **legitimately signed** with SolarWinds' code-signing certificate after attackers compromised the build pipeline; the signature was valid, so endpoint defenses trusted it. Pass-the-hash attacks against [[NTLM]] exploit the fact that Windows historically authenticated using the *hash itself* rather than the password, so stealing the hash was as good as stealing the password.

For the SY0-701 exam, Objective 1.4 ("Explain the importance of using appropriate cryptographic solutions") puts hashing and signatures front and center. You will see questions distinguishing hashing from encryption, identifying the right algorithm for a scenario, explaining what property a digital signature provides (hint: confidentiality is *not* one of them), and recognizing attacks like collision, birthday, and pass-the-hash.

> **CompTIA exam trap:** Hashing is **not** encryption. Encryption is reversible with a key; hashing is one-way with no key. If a question describes "encrypting a password before storing it," the answer is almost always wrong — passwords should be **hashed and salted**, not encrypted.

## Key facts

### Properties hashing provides

| Property | Provided by hashing alone? | Notes |
|---|---|---|
| Integrity | ✅ Yes | Detects any modification to data |
| Authentication | ❌ No | Need [[HMAC]] or signature |
| Non-repudiation | ❌ No | Need digital signature |
| Confidentiality | ❌ Never | Hashing does not hide data; it fingerprints it |
| Obfuscation | ⚠️ Partial | Only with [[salt]] and key stretching for passwords |

### Common hash algorithms (memorize these)

| Algorithm | Output size | Status | Use cases |
|---|---|---|---|
| MD5 | 128-bit | **Broken** — collision attacks practical since 2004 | Legacy checksums only; never security |
| SHA-1 | 160-bit | **Deprecated** — SHAttered (2017) | Legacy Git, old TLS certs (now banned) |
| SHA-2 (SHA-256, SHA-384, SHA-512) | 256/384/512-bit | **Secure** | TLS, code signing, blockchain, general use |
| SHA-3 | Variable (224–512) | **Secure** | NIST alternative based on Keccak sponge construction |
| RIPEMD-160 | 160-bit | Aging | Bitcoin addresses |
| BLAKE2 / BLAKE3 | Variable | Secure, very fast | High-performance hashing |

> **Exam tip:** If you see **MD5** or **SHA-1** in an answer choice for a *security* purpose (signing, password storage, certificate integrity), it's almost certainly the wrong answer. They survive only for non-security checksums.

### Password hashing — a special case

General-purpose hashes like SHA-256 are **too fast** for passwords. An attacker with a GPU can compute billions of SHA-256 hashes per second, making brute-force and rainbow table attacks devastating. Password hashing requires **deliberately slow, memory-hard** algorithms combined with a per-user **[[salt]]**.

| Algorithm | Type | Notes |
|---|---|---|
| bcrypt | Adaptive (work factor) | Industry standard since 1999, 72-char limit |
| scrypt | Memory-hard | Resists GPU/ASIC attacks via RAM cost |
| Argon2 (Argon2id) | Memory-hard | **PHC winner (2015)**, current best practice |
| PBKDF2 | Iterative | NIST-approved, used in WPA2, BitLocker; weaker against GPUs |

**Salt** is a random, per-user value concatenated with the password before hashing. It defeats [[rainbow tables]] (precomputed hash lookups) because the attacker would need a separate table for every salt value. **Pepper** is a similar concept but stored separately (often in an HSM or app config) and shared across all users — it adds defense-in-depth if the database alone leaks.

> **CompTIA exam trap:** Salt is stored **alongside** the hash in plaintext — that's fine. Its job is not to be secret; its job is to make every hash unique so identical passwords don't produce identical hashes, and to defeat precomputation.

### Hash-based attacks

- **Collision attack** — finding any two inputs with the same hash. Birthday paradox math means a collision in an n-bit hash is found in roughly 2^(n/2) operations, not 2^n. This is why 128-bit MD5 fell — only 2^64 operations needed.
- **Birthday attack** — exploits the birthday paradox to find collisions much faster than brute-forcing the full output space.
- **Preimage attack** — finding *any* input that produces a target hash (much harder than collision).
- **Pass-the-hash (PtH)** — reusing a captured NTLM hash to authenticate without ever knowing the plaintext password. Mitigated by [[Kerberos]], Credential Guard, and disabling NTLM.
- **Length extension attack** — affects Merkle–Damgård constructions like MD5, SHA-1, SHA-2 when used naively as MACs. Defeated by HMAC or SHA-3.

### Digital signatures: the mechanism

A digital signature combines hashing with [[asymmetric encryption]]. The flow:

**Signing (sender):**
1. Compute `H = hash(message)`
2. Encrypt `H` with sender's **private key** → signature `S`
3. Send `message || S`

**Verification (receiver):**
1. Compute `H' = hash(received message)`
2. Decrypt `S` with sender's **public key** → `H`
3. If `H == H'`, signature is valid

This single construction provides three guarantees:

| Guarantee | How |
|---|---|
| **Integrity** | If message changes, `H'` won't match `H` |
| **Authentication** | Only holder of private key could have produced `S` |
| **Non-repudiation** | Sender cannot later deny signing — only their key could have done it |

> **CompTIA exam trap:** Digital signatures use the **sender's private key to sign** and the **sender's public key to verify**. This is the *opposite* of encryption-for-confidentiality, where you encrypt with the **recipient's public key**. Get the key direction right or you'll lose easy points.

### Digital signature algorithms

| Algorithm | Basis | Notes |
|---|---|---|
| **RSA** signatures | Integer factorization | Most common; uses PKCS#1 v1.5 or PSS padding |
| **DSA** | Discrete log | NIST FIPS 186; largely superseded |
| **ECDSA** | Elliptic curve discrete log | Smaller keys, faster; used in TLS 1.3, Bitcoin, SSH |
| **EdDSA (Ed25519)** | Edwards-curve | Modern, deterministic, resistant to bad RNG; SSH, modern TLS |

### HMAC vs. digital signatures

Both provide integrity and authentication, but they differ critically:

| Property | HMAC | Digital Signature |
|---|---|---|
| Key type | Symmetric (shared secret) | Asymmetric (public/private) |
| Non-repudiation | ❌ No (either party could have made it) | ✅ Yes |
| Speed | Very fast | Slower (asymmetric ops) |
| Key distribution | Hard (shared secret problem) | Easier (PKI) |
| Use cases | TLS record protection, API request signing | Code signing, certificates, legal documents |

**HMAC** = `H((K ⊕ opad) || H((K ⊕ ipad) || message))` — a hash function used twice with a key, producing a keyed message authentication code that resists length-extension attacks.

### Digital certificates and the chain of trust

A [[digital certificate]] (X.509) is a digitally signed binding between an identity (domain name, organization) and a public key. The signer is a [[Certificate Authority]] whose own certificate is signed by another CA, all the way up to a **root CA** whose certificate is self-signed and pre-installed in OS/browser trust stores. The signature on each cert is what makes the whole [[PKI]] work — break the hash function and you break the web.

> **Why CompTIA tests this:** Real-world TLS, code signing, S/MIME email, and document signing all collapse if you don't understand the signature chain. Expect a scenario like "the CA's signature on a certificate verifies what?" — answer: the binding between the subject's identity and their public key.

### Code signing

Software publishers sign executables with a code-signing certificate. The OS verifies the signature before execution.

- Windows: **Authenticode (uses .pfx/.p7b certificates, signed with `signtool.exe`)
- macOS: **codesign** (requires Apple Developer ID; notarization required for distribution outside App Store)
- Linux/RPM: **GPG-signed** packages (`rpm --checksig`)
- Linux/DEB: **dpkg-sig** or **debsign**
- Container images: **cosign** (Sigstore project) for OCI image signatures
- JAR files: **jarsigner**

Code signing provides **authenticity** (proves who signed) and **integrity** (proves nothing was modified after signing). It does NOT provide confidentiality — signed code is not encrypted. CompTIA loves this distinction. Stuxnet famously used valid stolen code-signing certificates, proving that signature trust hinges on key custody.

### Hashing in password storage

Storing raw password hashes is insufficient — fast hashes (SHA-256, MD5) enable rainbow table and brute-force attacks. Modern password storage uses **slow, memory-hard hashes** with per-user salt:

| Algorithm | Notes |
|---|---|
| **bcrypt** | Adaptive cost factor; ~25 years of field use |
| **scrypt** | Memory-hard; resists ASIC/GPU acceleration |
| **Argon2id** | Winner of 2015 Password Hashing Competition; current best practice |
| **PBKDF2** | NIST-approved; iteration count tuned upward over time |

> **CompTIA exam trap:** SHA-256 is NOT a password hash. Using SHA-256 for passwords is a vulnerability finding on every audit.

## Related concepts

[[SHA-2]] · [[SHA-3]] · [[MD5]] · [[SHA-1]] · [[HMAC]] · [[RSA]] · [[ECDSA]] · [[Ed25519]] · [[Salting]] · [[Key Stretching]] · [[bcrypt]] · [[Argon2]] · [[PBKDF2]] · [[Birthday Attack]] · [[Collision Attack]] · [[Code Signing]] · [[Certificates]] · [[Public Key Infrastructure]] · [[Non-repudiation]] · [[Pass-the-Hash]] · [[Rainbow Table]] · [[TLS]]

---
*Source: VIRGIL knowledge base — 2026-05-08*
