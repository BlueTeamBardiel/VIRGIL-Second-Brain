---
domain: "cryptography"
tags: [encryption, symmetric, algorithm, block-cipher, cryptography, aes]
---
# AES

**Advanced Encryption Standard (AES)** is a **symmetric block cipher** standardized by NIST in 2001 (FIPS 197) that replaced [[DES]] as the global standard for encrypting sensitive data. It operates on fixed 128-bit blocks of plaintext using key sizes of 128, 192, or 256 bits, making it suitable for everything from [[TLS]] sessions to full-disk encryption. AES is the foundational encryption algorithm behind protocols including [[WPA2]], [[IPsec]], and [[BitLocker]].

---

## Overview

AES emerged from a public competition launched by NIST in 1997 to replace the aging [[DES]] standard, which had become vulnerable to brute-force attacks due to its short 56-bit key. The winning candidate, **Rijndael**, was designed by Belgian cryptographers Joan Daemen and Vincent Rijmen. NIST formally standardized it as AES in November 2001 under FIPS Publication 197. Unlike DES, AES was designed from the ground up to resist differential and linear cryptanalysis while remaining computationally efficient on both hardware and software platforms.

AES is a **substitution-permutation network (SPN)**, which means it achieves confusion and diffusion through alternating layers of substitution (replacing bytes with other values) and permutation (rearranging bytes). This is structurally different from the Feistel network used by DES. The cipher operates on a 4×4 matrix of bytes called the **state**, transforming it through multiple rounds of operations derived from the key. The number of rounds depends on key length: 10 rounds for 128-bit, 12 for 192-bit, and 14 for 256-bit keys.

In real-world deployments, AES is almost never used in its raw **ECB (Electronic Codebook) mode**, which is insecure for most purposes because identical plaintext blocks produce identical ciphertext blocks, revealing patterns. Instead, it is combined with **modes of operation** such as CBC (Cipher Block Chaining), CTR (Counter), or GCM (Galois/Counter Mode). GCM is particularly important because it provides both encryption and **authenticated encryption with associated data (AEAD)**, meaning it guarantees both confidentiality and integrity in a single operation — a critical property in modern protocols like TLS 1.3.

AES has been subjected to over two decades of intense cryptanalytic scrutiny and remains unbroken in its full-round form. The best known theoretical attacks (such as biclique cryptanalysis against AES-128) reduce the effective security by only a few bits, making brute-force infeasible with current and near-future classical computing. The primary real-world weaknesses are not in the algorithm itself but in **implementation flaws**, **poor key management**, and **weak modes of operation** — not the cipher's mathematical structure.

---

## How It Works

### Block and Key Setup

AES operates on a **4×4 byte matrix** (the "state") representing 128 bits of data. Before encryption begins, the original key is expanded using the **Key Schedule** algorithm into a set of round keys — one per round plus an initial one. For AES-128, this generates 11 round keys (each 128 bits); for AES-256, it generates 15 round keys.

```
Plaintext (128 bits / 16 bytes):
┌──┬──┬──┬──┐
│b0│b4│b8│b12│
│b1│b5│b9│b13│  ← 4×4 State Matrix
│b2│b6│b10│b14│
│b3│b7│b11│b15│
└──┴──┴──┴──┘
```

### Round Structure

Each AES encryption consists of:

1. **Initial Round Key Addition** — XOR the plaintext state with the first round key (AddRoundKey)
2. **N-1 Full Rounds** (9 for AES-128, 11 for AES-192, 13 for AES-256), each containing:
   - **SubBytes** — Non-linear byte substitution using a lookup table (S-Box)
   - **ShiftRows** — Cyclically shift each row of the state matrix left by 0, 1, 2, 3 positions
   - **MixColumns** — Multiply each column by a fixed polynomial in GF(2⁸)
   - **AddRoundKey** — XOR with the current round key
3. **Final Round** — Same as above but **without MixColumns**

### Step-by-Step Visualization (AES-128)

```
Input: Plaintext + Key
         ↓
    AddRoundKey (Round 0)
         ↓
    ┌─────────────────┐
    │  SubBytes        │ ← S-Box lookup (non-linearity)
    │  ShiftRows       │ ← Diffusion across rows
    │  MixColumns      │ ← Diffusion across columns
    │  AddRoundKey     │ ← Inject round key
    └─────────────────┘
    Repeat × 9 (AES-128)
         ↓
    SubBytes
    ShiftRows
    AddRoundKey (no MixColumns in final round)
         ↓
    Ciphertext
```

### Modes of Operation

AES alone is a block cipher — it needs a mode to encrypt data longer than 128 bits:

| Mode | Full Name | IV Required | Authenticates? | Notes |
|------|-----------|-------------|----------------|-------|
| ECB | Electronic Codebook | No | No | **Insecure** — never use |
| CBC | Cipher Block Chaining | Yes | No | Padding oracle attacks possible |
| CTR | Counter | Yes (nonce) | No | Stream cipher behavior |
| GCM | Galois/Counter Mode | Yes (nonce) | **Yes** | Modern standard; used in TLS 1.3 |
| CCM | Counter with CBC-MAC | Yes | Yes | Used in WPA3, 802.11 |

### OpenSSL Command Examples

```bash
# Encrypt a file with AES-256-CBC
openssl enc -aes-256-cbc -salt -in plaintext.txt -out encrypted.enc -k "MyPassphrase"

# Decrypt
openssl enc -aes-256-cbc -d -in encrypted.enc -out decrypted.txt -k "MyPassphrase"

# Encrypt with AES-256-GCM (modern preferred mode)
openssl enc -aes-256-gcm -salt -in plaintext.txt -out encrypted.gcm -k "MyPassphrase"

# Display AES cipher info
openssl enc -ciphers | grep aes

# Generate a random 256-bit key (hex)
openssl rand -hex 32

# Generate a random 128-bit IV
openssl rand -hex 16
```

### Python Example (AES-GCM with PyCryptodome)

```python
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes

# Encryption
key = get_random_bytes(32)          # 256-bit key
nonce = get_random_bytes(16)        # 128-bit nonce
cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
ciphertext, tag = cipher.encrypt_and_digest(b"Secret message to encrypt")

print(f"Ciphertext: {ciphertext.hex()}")
print(f"Auth Tag:   {tag.hex()}")

# Decryption + verification
cipher_dec = AES.new(key, AES.MODE_GCM, nonce=nonce)
plaintext = cipher_dec.decrypt_and_verify(ciphertext, tag)
print(f"Decrypted:  {plaintext.decode()}")
```

### Key Sizes and Security Levels

```
AES-128: 128-bit key → 10 rounds  → 128-bit security (NIST: acceptable through 2030+)
AES-192: 192-bit key → 12 rounds  → 192-bit security
AES-256: 256-bit key → 14 rounds  → 256-bit security (quantum-resistant candidate)
```

---

## Key Concepts

- **Symmetric Encryption**: AES uses the **same key for both encryption and decryption**. The key must be securely shared between parties before communication — this key exchange problem is typically solved by [[asymmetric encryption]] algorithms like [[RSA]] or [[ECDH]].

- **S-Box (Substitution Box)**: A **fixed 256-byte lookup table** used in the SubBytes step that provides non-linearity to the cipher. The S-Box is mathematically derived from the multiplicative inverse in GF(2⁸) combined with an affine transformation, ensuring it has no fixed points and resists linear approximation.

- **Key Schedule**: The algorithm by which AES **expands the original encryption key** into multiple round keys. For AES-128, the 16-byte key becomes 176 bytes of round key material. The schedule uses the S-Box and round constants (Rcon values) to create distinct, dependent subkeys.

- **GF(2⁸) (Galois Field)**: AES arithmetic is performed in the **finite field GF(2⁸)**, where bytes are treated as polynomials and operations (especially MixColumns) are polynomial multiplication modulo an irreducible polynomial (x⁸ + x⁴ + x³ + x + 1). This ensures that MixColumns is invertible and provides maximum diffusion.

- **AEAD (Authenticated Encryption with Associated Data)**: A property provided by modes like **GCM**, where the cipher simultaneously provides **confidentiality, integrity, and authenticity**. The authentication tag (typically 128 bits) detects any tampering with the ciphertext. Associated data (like packet headers) can be authenticated without being encrypted.

- **Padding**: Raw AES in CBC mode requires input to be a **multiple of 16 bytes**. PKCS#7 padding is the standard approach — if the plaintext is 3 bytes short of a full block, 3 bytes each with value `0x03` are appended. CTR and GCM modes operate as stream ciphers and do not require padding.

- **Initialization Vector (IV) / Nonce**: A **random or pseudo-random value** used in most modes to ensure that encrypting the same plaintext twice produces different ciphertext. IVs must never be reused with the same key in GCM mode (nonce reuse catastrophically breaks confidentiality and authenticity).

---

## Exam Relevance

### SY0-701 Focus Areas

The Security+ exam tests AES knowledge primarily in the context of **symmetric vs. asymmetric encryption**, **algorithm selection**, and **use-case identification**. Key exam patterns:

**Common Question Patterns:**
- *"Which algorithm provides the strongest symmetric encryption?"* → **AES-256**
- *"Which cipher mode provides both encryption AND authentication?"* → **GCM** (AEAD)
- *"A developer encrypts images and can see patterns in the ciphertext — what is the problem?"* → **ECB mode** (use of ECB reveals plaintext patterns)
- *"Which is faster for bulk data encryption, AES or RSA?"* → **AES** (symmetric ciphers are orders of magnitude faster)
- *"What is the block size of AES?"* → **128 bits** (regardless of key size — this is a common trap)

**Critical Gotchas:**
- AES block size is **always 128 bits**. Key size (128/192/256) does NOT change block size.
- AES-256 provides **256-bit security against classical attacks** but only ~128-bit security against Grover's quantum algorithm — still considered quantum-resistant for the near term.
- ECB mode is **explicitly wrong** for any real-world scenario — exam questions use it as the incorrect answer option.
- **CBC mode is vulnerable to padding oracle attacks** (e.g., POODLE-style); GCM is the modern replacement.
- AES is **not a hashing algorithm** — it is reversible with the key. Do not confuse with SHA or MD5.
- The exam categorizes AES under **symmetric** encryption alongside 3DES, Blowfish, and ChaCha20.

**Key Numbers to Memorize:**
```
Block size:          128 bits (always)
Key sizes:           128, 192, 256 bits
Rounds (128-bit):    10
Rounds (192-bit):    12
Rounds (256-bit):    14
Standard:            FIPS 197 (2001)
```

---

## Security Implications

### Algorithm-Level Attacks

AES has no known practical full-round attack. The strongest theoretical attacks include:

- **Biclique Cryptanalysis (2011)** — Reduces AES-128 security from 2¹²⁸ to 2¹²⁶·² operations. Completely impractical; noted only for academic completeness.
- **Related-Key Attacks** — Weaknesses in the AES-256 key schedule allow theoretical related-key attacks under 2⁹⁹·⁵ operations (Biryukov & Khovratovich, 2009). Only relevant when an attacker controls key selection — not applicable to normal deployments.
- **Square Attack / Integral Cryptanalysis** — Applicable to reduced-round versions of AES (7 rounds or fewer). Full 10/12/14-round AES is unaffected.

### Implementation Vulnerabilities

Real-world AES vulnerabilities are almost always implementation failures:

- **Padding Oracle Attacks (e.g., POODLE, BEAST)** — Exploiting CBC mode when the server leaks information about padding validity. **CVE-2014-3566 (POODLE)** demonstrated this against SSLv3's CBC cipher suites.
- **Nonce Reuse in GCM** — Reusing a nonce with the same key in GCM mode completely destroys both confidentiality and authenticity. The attacker can recover the authentication key and XOR-cancel the keystream. Sony PlayStation 3 ECDSA nonce reuse (similar principle) led to its complete compromise.
- **Cache-Timing Side-Channel Attacks** — AES S-Box lookups via table-based implementations can leak key information through CPU cache timing (Bernstein's cache-timing attack, 2005). AES-NI hardware instructions (Intel/AMD) mitigate this by performing AES operations in dedicated hardware with constant-time behavior.
- **Weak Key Derivation** — Using a password directly as a key without proper KDF (PBKDF2, Argon2, scrypt) creates weak effective key entropy regardless of AES key size.

### Quantum Computing Considerations

Grover's algorithm theoretically reduces AES key search complexity to the square root of the original: AES-128 → 2⁶⁴ operations, AES-256 → 2¹²⁸ operations. NIST recommends **AES-256** for post-quantum security. AES-256 remains a NIST-approved algorithm in its **Post-Quantum Cryptography** transition guidance (NIST IR 8413).

---

## Defensive Measures

### Algorithm and Mode Selection

```
✅ Use AES-256-GCM for new implementations (authenticated encryption)
✅ Use AES-256-CBC with HMAC if GCM unavailable (Encrypt-then-MAC)
✅ Use AES-128-GCM where performance is critical and 128-bit security is sufficient
❌ Never use AES-ECB in any production context
❌ Avoid AES-CBC without a separate MAC/HMAC
❌ Do not use deprecated modes: OFB, CFB without authentication
```

### Key Management

- **Never hardcode keys** in source code. Use secrets managers (HashiCorp Vault, AWS KMS, Azure Key Vault).
- **Rotate keys** regularly. NIST SP 800-57 recommends AES-256 keys have a maximum cryptoperiod of 2 years for symmetric originator-usage.
- **Derive keys from passwords** using PBKDF2 (minimum 100,000 iterations), Argon2id, or bcrypt — never use raw passwords as AES keys.
- **