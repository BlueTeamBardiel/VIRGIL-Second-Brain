---
domain: "cryptography"
tags: [encryption, symmetric-cryptography, aes, block-cipher, cryptographic-standards, security-plus]
---
# AES (Advanced Encryption Standard)

**AES (Advanced Encryption Standard)** is a **symmetric block cipher** standardized by the **National Institute of Standards and Technology (NIST)** in 2001, replacing the aging [[DES (Data Encryption Standard)]]. It encrypts data in fixed 128-bit blocks using keys of 128, 192, or 256 bits, and is the most widely deployed encryption algorithm in the world, underpinning everything from [[TLS (Transport Layer Security)]] to full-disk encryption.

---

## Overview

AES was born from a competitive public evaluation process launched by NIST in 1997. The agency solicited algorithms to replace DES, which had become vulnerable to brute-force attacks due to its 56-bit key length. After five years of public analysis, the Belgian cipher **Rijndael**, designed by Joan Daemen and Vincent Rijmen, was selected and standardized as FIPS 197. Unlike DES, which used a Feistel network, Rijndael uses a **substitution-permutation network (SPN)**, a design choice that contributes to its efficiency on both hardware and software platforms.

AES operates on a 4×4 matrix of bytes called the **state**, transforming it through a series of rounds. The number of rounds depends on key size: 10 rounds for 128-bit keys, 12 rounds for 192-bit keys, and 14 rounds for 256-bit keys. Each round applies a sequence of mathematical transformations that ensure both **confusion** (obscuring the relationship between plaintext and ciphertext) and **diffusion** (spreading the influence of each plaintext bit across the ciphertext).

In practice, AES is found virtually everywhere. It secures Wi-Fi traffic via [[WPA2]] and [[WPA3]], protects HTTPS sessions via [[TLS (Transport Layer Security)]], encrypts stored data in [[BitLocker]] and [[VeraCrypt]], secures VPN tunnels in [[IPsec]] and [[OpenVPN]], and is mandated for U.S. government classified information (AES-256 for TOP SECRET). Hardware acceleration via AES-NI (AES New Instructions) CPU extensions, introduced by Intel in 2010, means AES encryption imposes negligible performance overhead on modern systems — often running at multiple gigabytes per second.

AES itself is a **cipher primitive** — it only defines how to encrypt a single 128-bit block. To encrypt arbitrary-length data, AES must be used in a **mode of operation** such as CBC, CTR, GCM, or ECB. The choice of mode dramatically affects security properties. For example, AES-GCM provides authenticated encryption, while AES-ECB is considered dangerously insecure for most uses because identical plaintext blocks produce identical ciphertext blocks.

---

## How It Works

### State and Key Expansion

AES begins by arranging the 16-byte (128-bit) plaintext block into a 4×4 byte **state matrix**. The encryption key is expanded using a **key schedule** algorithm (the Rijndael key schedule) into a series of **round keys** — one for the initial step plus one per round. For a 128-bit key, this produces 11 round keys (176 bytes total).

```
Plaintext (16 bytes) → 4×4 State Matrix:
  [b0]  [b4]  [b8]  [b12]
  [b1]  [b5]  [b9]  [b13]
  [b2]  [b6]  [b10] [b14]
  [b3]  [b7]  [b11] [b15]
```

### Initial Round
Before the main rounds begin, an **AddRoundKey** operation XORs the state with the first round key.

### Main Rounds (repeated 9, 11, or 13 times for 128/192/256-bit keys)

Each main round consists of four transformations in this order:

**1. SubBytes**
Each byte in the state is replaced by a corresponding byte from a fixed 16×16 lookup table called the **S-Box** (substitution box). The S-Box is constructed using multiplicative inverses in GF(2⁸) followed by an affine transformation. This step provides **confusion**.

```
Example: byte value 0x53 → S-Box lookup → 0xED
```

**2. ShiftRows**
Each row of the state matrix is cyclically shifted left by a different offset:
- Row 0: no shift
- Row 1: shift left by 1
- Row 2: shift left by 2
- Row 3: shift left by 3

This ensures that bytes from different columns are spread across the state, contributing to **diffusion**.

**3. MixColumns**
Each column of the state is treated as a four-term polynomial over GF(2⁸) and multiplied by a fixed polynomial `c(x) = 3x³ + x² + x + 2`. This operation mixes bytes within each column, ensuring that each output byte depends on all four input bytes of the column — the main source of diffusion.

**4. AddRoundKey**
The state is XORed with the current round key. This is the only step that involves the key material, making it the source of key-dependent transformation.

### Final Round
The final round omits **MixColumns** (to make decryption symmetric in structure) and performs: SubBytes → ShiftRows → AddRoundKey.

### Decryption
AES decryption applies the inverse of each transformation (InvSubBytes, InvShiftRows, InvMixColumns, AddRoundKey) in reverse order. The key schedule runs in reverse. Decryption is slightly less efficient than encryption in software, though hardware implementations often optimize both paths equally.

### Modes of Operation

```
Mode     | Authenticated | Parallelizable | IV Required | Use Case
---------|---------------|----------------|-------------|------------------
ECB      | No            | Yes            | No          | NEVER (insecure)
CBC      | No            | Decrypt only   | Yes         | Legacy TLS, disk
CTR      | No            | Yes            | Yes (nonce) | High-speed streams
GCM      | Yes (GHASH)   | Yes            | Yes (nonce) | TLS 1.3, modern
CCM      | Yes           | No             | Yes         | IoT, 802.11i
```

### Practical Usage Examples

**OpenSSL — encrypt a file with AES-256-CBC:**
```bash
openssl enc -aes-256-cbc -salt -pbkdf2 -in plaintext.txt -out encrypted.bin -k "MySecretPassphrase"
```

**OpenSSL — decrypt:**
```bash
openssl enc -d -aes-256-cbc -pbkdf2 -in encrypted.bin -out decrypted.txt -k "MySecretPassphrase"
```

**Python — AES-256-GCM with PyCryptodome:**
```python
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes

key = get_random_bytes(32)          # 256-bit key
nonce = get_random_bytes(16)        # 128-bit nonce
cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
ciphertext, tag = cipher.encrypt_and_digest(b"Hello, [YOUR-LAB]!")

print(f"Ciphertext: {ciphertext.hex()}")
print(f"Auth Tag:   {tag.hex()}")
```

**Linux — check for AES-NI CPU support:**
```bash
grep -m1 aes /proc/cpuinfo
# Look for "aes" in flags
```

---

## Key Concepts

- **Symmetric Encryption**: AES uses the **same key for both encryption and decryption**, unlike asymmetric algorithms like [[RSA]] or [[ECC (Elliptic Curve Cryptography)]]. This means key distribution must be handled securely — often via asymmetric key exchange (e.g., in TLS handshakes).

- **Block Cipher**: AES processes data in fixed **128-bit (16-byte) blocks**. Data longer than one block requires a mode of operation; data shorter than one block requires **padding** (e.g., PKCS#7).

- **Key Sizes**: AES supports **128-bit, 192-bit, and 256-bit keys**, corresponding to 10, 12, and 14 rounds respectively. AES-128 is currently considered secure; AES-256 is mandated for U.S. government TOP SECRET classification and provides greater margin against future quantum attacks.

- **AES-GCM (Galois/Counter Mode)**: The **preferred authenticated encryption mode** in modern protocols like TLS 1.3. GCM combines CTR mode encryption with a GHASH authentication tag, providing both **confidentiality and integrity** in a single pass. The authentication tag (typically 128 bits) detects tampering.

- **AES-NI**: **Hardware acceleration instructions** built into most modern x86/x64 CPUs (Intel since Westmere 2010, AMD since Bulldozer 2011). AES-NI implements the SubBytes and MixColumns steps directly in silicon, providing 5–10× speed improvement and resistance to certain timing side-channel attacks.

- **Initialization Vector (IV) / Nonce**: A **random or unique value** used alongside the key in modes like CBC and GCM. IVs do not need to be secret but must be unpredictable (CBC) or unique (GCM). Reusing a GCM nonce with the same key catastrophically compromises both confidentiality and authentication.

- **FIPS 197**: The **Federal Information Processing Standard** that formally defines AES. Compliance with FIPS 197 is required for many government and regulated-industry applications. FIPS-validated implementations are listed in NIST's Cryptographic Module Validation Program (CMVP).

---

## Exam Relevance

**SY0-701 Domain Mapping:** Domain 1.4 (Cryptographic Solutions) — AES is explicitly tested in the Security+ exam as the primary example of a symmetric encryption algorithm.

**High-Priority Facts for the Exam:**

- AES is **symmetric** — same key for encrypt and decrypt. If a question describes key exchange happening before encryption, AES is likely the symmetric component.
- AES block size is always **128 bits**, regardless of key size. Key sizes are 128, 192, or 256 bits.
- **AES-256** is the answer to questions about "strongest" or "government-approved" encryption for classified data.
- AES-GCM provides **authenticated encryption** — the exam may test whether you understand that GCM offers both confidentiality AND integrity.
- **ECB mode is insecure** — the exam may present a scenario where ECB leaks patterns (the "ECB penguin" problem) and ask you to identify the flaw.

**Common Question Patterns:**

1. *"Which algorithm is a symmetric block cipher used by the U.S. government?"* → AES
2. *"A developer encrypts each block independently with the same key. What vulnerability exists?"* → ECB mode reveals patterns
3. *"Which AES mode provides both encryption and authentication?"* → GCM (or CCM)
4. *"What is the block size of AES?"* → 128 bits (do not confuse with key size)
5. *"Which key length of AES is required for TOP SECRET classification?"* → 256-bit

**Common Gotchas:**

- **AES key size ≠ block size.** Block size is always 128 bits; key sizes vary. Candidates confuse these frequently.
- **AES replaced DES, not RSA.** AES is symmetric; RSA is asymmetric. They solve different problems.
- **3DES is not AES.** Triple DES was an interim replacement for DES; AES superseded 3DES. 3DES is deprecated as of 2023 (NIST SP 800-131A).
- **CBC requires padding; GCM does not** (it's a stream mode variant). Padding oracle attacks apply to CBC, not GCM.

---

## Security Implications

### Theoretical Attacks
AES has no known practical full breaks. The best known cryptanalytic attack on AES is a **biclique attack** (2011, Bogdanov et al.), which reduces the computational complexity of brute-forcing AES-128 from 2¹²⁸ to approximately 2¹²⁶·¹. This improvement is entirely theoretical — it provides no practical advantage given current or foreseeable computing capabilities.

### Quantum Computing Threat
[[Grover's Algorithm]] theoretically halves the effective key length of symmetric ciphers. This would reduce AES-128 security to roughly 64-bit equivalent — potentially vulnerable to future quantum computers. AES-256 would be reduced to 128-bit equivalent, still considered secure. This is why NIST recommends AES-256 for long-term sensitive data and post-quantum transition planning.

### Side-Channel Attacks
The most realistic attacks against AES target **implementations**, not the algorithm itself:
- **Cache-Timing Attacks (CACHE):** Software AES implementations using table lookups (T-tables) can leak key information through CPU cache access patterns. AES-NI hardware instructions largely eliminate this.
- **Power Analysis:** Measuring power consumption during AES operations on embedded devices (smartcards, IoT) can reveal key bytes. Countermeasures include masking and blinding.
- **Padding Oracle Attacks (POODLE-style):** Applicable to AES-CBC with PKCS#7 padding. An attacker who can query whether decryption produces valid padding can decrypt ciphertext byte-by-byte. CVE-2014-3566 (POODLE) demonstrated this against SSL 3.0. Mitigation: use AES-GCM instead of AES-CBC where possible.

### Implementation Vulnerabilities
- **Nonce Reuse in GCM (CVE-2016-0270 and others):** Reusing a (key, nonce) pair in AES-GCM allows an attacker to XOR two ciphertexts and recover both plaintexts, and also forge authentication tags. This was exploited in real TLS implementations.
- **Weak Key Derivation:** AES itself is strong, but keys derived from weak passwords using PBKDF1 or no KDF are trivially brute-forced. The strength of AES is only as good as the key generation process.
- **ECB Mode Information Leakage:** Using AES-ECB to encrypt structured data (e.g., images, database records) reveals patterns because identical plaintext blocks produce identical ciphertext blocks. The famous "ECB penguin" — an encrypted bitmap that still shows the original image's outline — illustrates this concretely.

---

## Defensive Measures

### Algorithm and Mode Selection
- **Use AES-256-GCM** for new implementations. It provides authenticated encryption, parallelizes well, and is mandated by TLS 1.3 cipher suites (e.g., `TLS_AES_256_GCM_SHA384`).
- **Never use AES-ECB.** There is no legitimate use case for ECB with data longer than one block.
- **Prefer AES-GCM over AES-CBC** to eliminate padding oracle attack surface.
- For disk encryption, AES-XTS (XEX-based Tweaked CodeBook mode with ciphertext Stealing) is the standard — used by BitLocker and macOS FileVault.

### Key Management
- **Use a proper Key Derivation Function (KDF)** when deriving keys from passwords: PBKDF2, bcrypt, scrypt, or Argon2. Never use raw SHA hashes.
- **Rotate encryption keys** on a defined schedule (annually for data at rest; per-session for data in transit).
- **Use a Hardware Security Module (HSM)** or [[TPM (Trusted Platform Module)]] for key storage in high-security environments.
- **Implement envelope encryption**: encrypt data with a Data Encryption Key (DEK), then encrypt the DEK with a Key Encryption Key (KEK) stored in an HSM or cloud KMS (AWS KMS, Azure Key Vault, HashiCorp Vault).

### Configuration Hardening
**Disable weak TLS cipher suites (Apache example):**
```apache
SSLCipherSuite TLS_AES_256_GCM_SHA384:TLS_AES_128_GC