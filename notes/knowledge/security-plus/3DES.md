---
domain: "cryptography"
tags: [encryption, symmetric, block-cipher, legacy, deprecated, des]
---
# 3DES

**Triple DES (3DES)**, formally designated as **TDEA (Triple Data Encryption Algorithm)**, is a symmetric-key [[block cipher]] that applies the original [[DES]] cipher three times to each 64-bit block of data. It was designed as a stopgap measure to extend the useful life of DES after its 56-bit key length became computationally vulnerable to brute-force attacks, and was widely deployed across banking, payment systems, and enterprise environments before being superseded by [[AES]].

---

## Overview

3DES emerged in the late 1990s as a practical response to DES's diminishing security margins. The original [[DES]] algorithm, standardized by NIST in 1977, uses a 56-bit key that became feasible to brute-force as computing power advanced — famously demonstrated by the EFF's "Deep Crack" machine, which cracked a DES key in under 23 hours in 1999. Rather than immediately replacing DES with an entirely new algorithm, the cryptographic community devised a method of applying DES encryption three sequential times, dramatically increasing effective key strength without requiring new hardware that had been purpose-built for DES operations.

The algorithm operates on 64-bit (8-byte) blocks of plaintext, the same block size inherited from DES. This relatively small block size became a significant liability in the modern era, as it makes 3DES susceptible to birthday attacks when large volumes of data are encrypted under the same key — a vulnerability concretely demonstrated by the **SWEET32** attack (CVE-2016-2183) in 2016, which could recover plaintext from HTTPS or OpenVPN sessions using 3DES after collecting approximately 785 GB of traffic.

3DES was formally standardized in ANSI X9.52 and NIST SP 800-67, and became deeply embedded in financial infrastructure. The **EMV standard** (Europay, Mastercard, Visa) for chip-and-PIN cards used 3DES as its primary encryption mechanism for years. The **ANSI X9.9** standard for financial message authentication also relied on it, meaning that ATMs, point-of-sale terminals, and interbank transfer systems worldwide ran 3DES for decades. This legacy deployment created significant migration challenges even after its weaknesses were well understood.

NIST began formally deprecating 3DES in 2017 (NIST SP 800-131A Rev. 2) and disallowed its use for new applications from 2023 onward, with full disallowance for all purposes effective through 2024. Despite this, 3DES remains present in legacy financial systems, older TLS configurations, and embedded devices where firmware upgrades are impractical. Understanding 3DES is therefore essential not only from a historical cryptography perspective, but because security practitioners still encounter it regularly during audits, penetration tests, and vulnerability assessments of production environments.

## How It Works

### The EDE Construction

3DES uses an **Encrypt-Decrypt-Encrypt (EDE)** structure applied sequentially using either two or three independent DES keys. The formal operation for encryption is:

```
Ciphertext = E_K3( D_K2( E_K1( Plaintext ) ) )
```

And for decryption:

```
Plaintext = D_K1( E_K2( D_K3( Ciphertext ) ) )
```

Where `E_Kn` means "encrypt with key Kn" and `D_Kn` means "decrypt with key Kn." The asymmetric Encrypt-Decrypt-Encrypt pattern was chosen deliberately: when all three keys are identical (K1 = K2 = K3), the algorithm degenerates to single DES, providing backward compatibility with legacy systems.

### Key Options (Keying Options)

NIST SP 800-67 defines three keying options:

| Keying Option | Description | Effective Key Length | Security Level |
|---|---|---|---|
| **Option 1 (3TDEA)** | K1 ≠ K2 ≠ K3, all independent | 168 bits | ~112 bits effective |
| **Option 2 (2TDEA)** | K1 = K3, K1 ≠ K2 | 112 bits | ~80 bits effective |
| **Option 3 (deprecated)** | K1 = K2 = K3 | 56 bits | Equivalent to DES |

The effective security of Keying Option 1 is only ~112 bits (not 168) due to **meet-in-the-middle attacks**, which reduce the theoretical search space. Keying Option 3 is entirely deprecated and provides no additional security over single DES.

### Internal DES Round Structure

Each of the three DES passes operates on the 64-bit block as follows:

1. **Initial Permutation (IP):** The 64-bit input block is permuted according to a fixed transposition table.
2. **Key Schedule:** A 56-bit key (from the 64-bit input, ignoring every 8th parity bit) generates 16 subkeys of 48 bits each via PC-1 and PC-2 permutations.
3. **16 Feistel Rounds:** The block is split into 32-bit halves (L and R). Each round computes:
   ```
   L(n) = R(n-1)
   R(n) = L(n-1) XOR f(R(n-1), K(n))
   ```
   The function `f` involves expansion permutation (32→48 bits), XOR with subkey, **S-box substitution** (48→32 bits via 8 S-boxes), and P-box permutation.
4. **Final Permutation (IP⁻¹):** The inverse of the initial permutation is applied to produce the ciphertext block.

3DES chains three complete 16-round DES passes, giving an equivalent of 48 Feistel rounds total.

### Block Size Implication and Padding

Because 3DES operates on 64-bit blocks, plaintext must be padded to a multiple of 8 bytes. **PKCS#7 padding** is the most common scheme:

```python
import pyDes

key = b'ABCDEFGHIJKLMNOPQRSTUVWX'  # 24 bytes = 3 x 8-byte DES keys
iv  = b'InitVect'                   # 8-byte IV for CBC mode

cipher = pyDes.triple_des(
    key,
    pyDes.CBC,
    iv,
    pad=None,
    padmode=pyDes.PAD_PKCS5
)

plaintext  = b'Attack at dawn!!'
ciphertext = cipher.encrypt(plaintext)
decrypted  = cipher.decrypt(ciphertext)

print(f"Ciphertext (hex): {ciphertext.hex()}")
print(f"Decrypted:        {decrypted}")
```

### Modes of Operation

3DES supports the same modes as DES:

- **ECB (Electronic Codebook):** Each block encrypted independently. Insecure for most uses (identical plaintext blocks produce identical ciphertext).
- **CBC (Cipher Block Chaining):** Each plaintext block XORed with the previous ciphertext block before encryption. Requires an IV. Most common secure mode for 3DES.
- **CFB / OFB / CTR:** Stream-cipher-like modes converting the block cipher into a stream cipher.

For legacy interoperability checks using OpenSSL:

```bash
# Encrypt with 3DES-CBC (for testing/audit purposes only)
openssl enc -des-ede3-cbc \
    -in plaintext.txt \
    -out encrypted.bin \
    -K 4142434445464748494a4b4c4d4e4f505152535455565758 \
    -iv 496e697456656374

# Decrypt
openssl enc -d -des-ede3-cbc \
    -in encrypted.bin \
    -out decrypted.txt \
    -K 4142434445464748494a4b4c4d4e4f505152535455565758 \
    -iv 496e697456656374

# Check if a server supports 3DES cipher suites in TLS
nmap --script ssl-enum-ciphers -p 443 target.example.com | grep -i "3des\|des-cbc3"

# Using testssl.sh for comprehensive cipher audit
./testssl.sh --cipher-per-proto target.example.com 2>/dev/null | grep -i "3DES"
```

---

## Key Concepts

- **Block Cipher:** A cipher that encrypts fixed-size chunks (blocks) of data; 3DES uses a **64-bit (8-byte) block size**, the same as DES, which is considered small by modern standards and contributes to birthday-attack vulnerability.
- **Feistel Network:** The underlying structure of DES and by extension 3DES; a symmetric construction where data is split, one half is processed through a round function with a subkey, and the halves are swapped — enabling identical hardware/software for both encryption and decryption with key order reversed.
- **Meet-in-the-Middle Attack:** An attack that explains why Double-DES provides only marginally more security than single DES; an attacker encrypts from one end and decrypts from the other, meeting in the middle of the key space. This reduces 3TDEA (168-bit key) to approximately **112 bits of effective security**.
- **SWEET32 Attack (CVE-2016-2183):** A birthday-bound attack against 64-bit block ciphers; after approximately **2³² blocks (~32 GB per session)** are encrypted with the same key, collision probability becomes significant, allowing partial plaintext recovery. In practice, ~785 GB of total traffic was needed against TLS sessions.
- **EDE (Encrypt-Decrypt-Encrypt):** The operational mode of 3DES where the middle operation uses decryption rather than encryption; this design provides backward compatibility with single DES when all three keys are equal, and was pragmatically chosen to leverage existing DES hardware.
- **Keying Option 1 vs. Option 2:** **3TDEA** (three independent keys, 168-bit key material) is considered the only still-permissible variant for legacy use, while **2TDEA** (K1=K3, 112-bit) was disallowed for new use after 2015 due to its reduced security margin approaching 80 bits, which is below NIST's minimum recommendation.
- **NIST Deprecation Timeline:** NIST SP 800-131A Rev. 2 (2019) deprecated 3DES for all new applications after 2023 and set full disallowance (including legacy use) for 2024, making it non-compliant for any FIPS 140-3 validated implementation going forward.

---

## Exam Relevance

**Security+ SY0-701** tests 3DES primarily in the context of algorithm comparison, legacy cryptography identification, and migration planning. Key facts to internalize:

**High-probability question patterns:**

1. **"Which algorithm is a predecessor/legacy version of AES?"** — The answer is DES, but 3DES is the transitional algorithm. Know the timeline: DES (1977) → 3DES (1998) → AES (2001).

2. **"An organization's legacy POS system uses 3DES. What is the primary concern?"** — The answer focuses on **weak/deprecated algorithm** and **small block size (64-bit)** leading to SWEET32 vulnerability, not just brute-force.

3. **"What is the effective key strength of 3DES?"** — Distinguish between **key material (168 bits)** and **effective security (~112 bits)**. Exam questions may try to trick you into saying 168 bits is the security level.

4. **"Which cipher suite should be disabled in TLS?"** — `TLS_RSA_WITH_3DES_EDE_CBC_SHA` (also known as cipher suite 0x000A) should be disabled. This appears in questions about hardening TLS configurations.

**Common gotchas:**

- Don't confuse 3DES's **64-bit block size** with its **key size**. The block is 64 bits; the key is 112 or 168 bits of material.
- 3DES is **symmetric** — same key for encryption and decryption. Don't conflate with asymmetric algorithms like RSA.
- The exam may present 3DES as providing "112 bits of security" — this is correct and reflects meet-in-the-middle reduction, not a flaw in implementation.
- Know that **AES replaced 3DES** as the federal standard following the AES competition, with AES officially adopted in FIPS 197 (2001).
- 3DES with **three independent keys** = Keying Option 1 = stronger. Two keys (Keying Option 2) = weaker.

---

## Security Implications

### SWEET32 Birthday Attack (CVE-2016-2183)

Discovered by Karthikeyan Bhargavan and Gaëtan Leurent at INRIA in 2016, SWEET32 exploits the birthday paradox against 64-bit block ciphers. When a block cipher with a 64-bit block size encrypts more than **2³² blocks** (roughly 32 GB) under the same key, the probability of a block collision exceeds 50%. In CBC mode, collisions in ciphertext blocks reveal the XOR of corresponding plaintext blocks, allowing incremental plaintext recovery.

**Attack scenario against HTTPS:**
- Attacker plants JavaScript on a page visited by target (cross-site or man-in-the-middle)
- JavaScript forces the browser to send many HTTPS requests containing predictable plaintext (e.g., session cookies)
- After ~785 GB of traffic (achievable in ~30 hours on a fast connection), attacker collects enough collisions to recover the session cookie
- Session cookie used for session hijacking

**TLS cipher suites affected:**
```
TLS_RSA_WITH_3DES_EDE_CBC_SHA       (0x000A)
TLS_DHE_RSA_WITH_3DES_EDE_CBC_SHA   (0x0016)
TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA (0xC012)
SSL_CK_DES_192_EDE3_CBC_WITH_MD5    (SSLv2)
```

### Brute Force Feasibility

While 112-bit effective security remains computationally infeasible for direct brute-force with current technology, the security margin is much tighter than AES-128 (128-bit full security). NIST considers 112 bits the **absolute minimum** for legacy-tolerant use cases, with a strong preference for 128+ bits in all new designs.

### Protocol Exposure Points

3DES appears in the following contexts where it may be encountered during security assessments:

- **TLS 1.0/1.1** cipher suites (both versions deprecated in RFC 8996)
- **SSH** legacy cipher negotiation (`3des-cbc` in OpenSSH)
- **IPsec IKEv1** phase 2 proposals
- **Kerberos** encryption types (des3-cbc-sha1, still present in older AD configurations)
- **PKCS#12 / PFX files** — often use 3DES internally for legacy compatibility
- **XML Encryption** (xmlenc) — `http://www.w3.org/2001/04/xmlenc#tripledes-cbc`

### Related CVEs

| CVE | Year | Description |
|---|---|---|
| CVE-2016-2183 | 2016 | SWEET32: Birthday attacks on 64-bit block ciphers in TLS and OpenVPN |
| CVE-2016-6329 | 2016 | OpenVPN: affected by SWEET32 via `BF-CBC` and `3DES-CBC` |
| CVE-2020-12653 | 2020 | Various embedded devices accepting 3DES in firmware update paths |

---

## Defensive Measures

### Disable 3DES in TLS (Web Servers)

**Nginx:**
```nginx
# /etc/nginx/nginx.conf or site config
ssl_protocols TLSv1.2