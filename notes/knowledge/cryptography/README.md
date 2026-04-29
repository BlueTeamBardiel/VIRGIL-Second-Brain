# Cryptography Fundamentals — What Every IT Pro Needs to Know
> You don't need to implement it. You need to know when it's broken.

Cryptography is the foundation of nearly every security control — HTTPS, VPNs, SSH, BitLocker, S/MIME, password storage, certificate authentication. You don't need to write encryption code, but you do need to know the difference between AES and DES, why MD5 passwords are trivially crackable, what happens when a TLS certificate expires, and why "we encrypt everything" is meaningless without knowing which algorithm and key length. This is the vocabulary of secure system design.

---

## Symmetric Encryption

One key. Same key encrypts and decrypts. Fast, good for bulk data.

### AES — Advanced Encryption Standard
The current standard. What "we use encryption" usually means.

- **Key sizes:** 128-bit, 192-bit, 256-bit. All are secure. AES-256 is standard for "high security."
- **Modes:** ECB (don't use — identical plaintext = identical ciphertext), CBC (common, IV required), GCM (provides authentication too — preferred for new implementations)
- **Speed:** Hardware-accelerated on all modern CPUs (AES-NI instruction set). Very fast.
- **Used in:** [[TLS]]/HTTPS, BitLocker, FileVault, WPA2/3, 7-Zip, VeraCrypt

### DES / 3DES — Don't Use
**DES (56-bit):** Broken. Crackable in hours with commodity hardware. Deprecated in 2001.

**3DES (Triple DES):** DES run three times with different keys. Effectively 112-bit security. Still found in legacy systems (old payment networks, ATMs). Deprecated by NIST in 2023. **Migrate anything using 3DES.**

### ChaCha20
Modern alternative to AES used in TLS 1.3 and WireGuard. Preferred for platforms without AES hardware acceleration (some mobile/IoT devices). Secure, fast, well-studied.

---

## Asymmetric Encryption

Two keys: **public key** (share with everyone) and **private key** (never share). What you encrypt with one key can only be decrypted with the other. Slow — used for key exchange and signatures, not bulk data.

### RSA
The dominant asymmetric algorithm for decades.
- **Key sizes:** 1024-bit (broken), 2048-bit (minimum acceptable), 4096-bit (high security)
- **1024-bit RSA is dead.** Factorable with sufficient compute. Certificate authorities stopped issuing 1024-bit certs in 2014.
- **2048-bit is the current minimum** for TLS certificates and SSH keys. Use 4096-bit for long-lived keys.
- **Used in:** TLS certificate key exchange (being replaced by ECDHE), SSH (RSA host keys and user keys), S/MIME, PGP

### ECC — Elliptic Curve Cryptography
Smaller keys, same security level, much faster than RSA.

| ECC Key | RSA Equivalent |
|---|---|
| 256-bit | 3072-bit RSA |
| 384-bit | 7680-bit RSA |

- **ECDSA:** Elliptic Curve Digital Signature Algorithm. Used in TLS 1.3, SSH, code signing.
- **ECDH/ECDHE:** Key exchange. The "E" means ephemeral — new key per session (perfect forward secrecy).
- **Curve25519/Ed25519:** Modern, safe curves. What `ssh-keygen -t ed25519` generates. Preferred for new SSH keys.

**Why it matters for IT:** When you generate SSH keys, `ed25519` is better than `rsa`. When you see an expired cert with a 1024-bit RSA key, that's a finding, not just a renewal ticket.

---

## Hashing

A one-way function. Input of any length → fixed-length output (digest). Same input always produces same output. Cannot reverse the hash to get the original.

**Not encryption.** A hash is not encrypted data — there is no key, no decryption.

### MD5
**Broken for security purposes.** Output: 128-bit digest.

- Collision vulnerabilities: attackers can create two different inputs with the same MD5 hash
- Fast (this is the problem for passwords — billions of hashes/second on a GPU)
- **Do not use for:**  passwords, certificates, security-sensitive integrity checks
- **Still used for:** non-security file integrity checks (download verification, deduplication), legacy systems

### SHA-1
**Deprecated.** Output: 160-bit digest. Collision demonstrated in 2017 (SHAttered attack). Certificate authorities stopped using SHA-1 for certs in 2016. Browsers show errors for SHA-1 certs.

### SHA-256 / SHA-3
**Current standard.** Output: 256-bit (SHA-256) or configurable (SHA-3).

- SHA-256: Part of SHA-2 family. What "secure hashing" means today. Used in TLS, code signing, blockchain, Git.
- SHA-3: Different underlying algorithm (Keccak), NIST standard since 2015. Not SHA-2 with another round. Use when standards require it or as an alternative if SHA-2 is compromised.

### HMAC
Hash-based Message Authentication Code. Uses a secret key + hash function to produce an authentication tag. Verifies both integrity AND authenticity. Used in API authentication, JWT tokens, TLS MAC.

```
HMAC-SHA256(key, message) → 256-bit tag
# Verify: receiver computes same HMAC with shared key, compares
```

---

## Password Hashing — Why It Matters for Help Desk

When a database is breached, what gets stolen depends on how passwords were stored:

| Storage Method | Crack Time for "password123" |
|---|---|
| Plaintext | Instant (just read it) |
| MD5 | < 1 second (precomputed rainbow tables or GPU) |
| SHA-256 (unsalted) | < 1 second (rainbow tables) |
| SHA-256 + salt | Minutes to hours (GPU) |
| bcrypt (cost 10) | Hours to days (slow by design) |
| Argon2id | Days to weeks (memory-hard) |

**Why slow hashing matters:** bcrypt is deliberately slow — designed to take 100ms per hash. MD5 can hash 10 billion passwords per second on a GPU. That difference is the entire margin between "passwords leaked, everyone's account is fine" and "every account on your site was compromised in hours."

**The salt:** A random value added to each password before hashing. Prevents rainbow tables (precomputed hash tables). Even if two users have the same password, their salted hashes differ.

**IT implications:**
- When a breach notice says "passwords were stored as MD5 hashes," assume they're all cracked
- When a breach says "passwords were bcrypt hashed with per-user salts," most users are protected
- If you're reviewing a web app, check what password hashing they use. SHA-256 without bcrypt/Argon2 = finding

---

## PKI — Public Key Infrastructure

PKI is the system that makes HTTPS work. It answers the question: "How do I know this server is really example.com and not an attacker?"

### Components
- **Certificate:** Binds a public key to an identity (domain, organization, person). Contains: subject, public key, issuer, validity period, signature.
- **Certificate Authority (CA):** Trusted entity that issues and signs certificates. Operating systems and browsers ship with a list of ~150 trusted root CAs.
- **Chain of Trust:** Most certs are signed by an intermediate CA, which is signed by a root CA. Browsers verify the chain up to a trusted root.
- **CRL (Certificate Revocation List):** List of revoked certificates. Browsers check this before trusting a cert. Slow (downloaded periodically).
- **OCSP (Online Certificate Status Protocol):** Real-time revocation check. Faster than CRL. OCSP stapling (server pre-fetches and includes the OCSP response) is even faster.

### What Breaks When a Certificate Expires
- Browser shows "Your connection is not private" → users click through or leave → site effectively down
- API calls fail (strict TLS verification in code doesn't prompt users, just fails silently)
- Internal services (LDAP, SMTP, monitoring) may stop communicating
- Smart card and certificate-based authentication breaks immediately

**Certificate monitoring:** Set up alerts at 90, 30, 14 days before expiry. Tools: `openssl`, Certbot auto-renewal, Let's Encrypt, Splunk TLS cert monitoring.

```bash
# Check certificate expiry
echo | openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -dates

# Check all certs in a directory
for f in /etc/ssl/certs/*.pem; do
    echo "$f:"; openssl x509 -noout -enddate -in "$f"; 
done

# Certificate details
openssl x509 -noout -text -in certificate.pem
```

---

## TLS/SSL — Securing Transport

TLS (Transport Layer Security) is the protocol that provides HTTPS. "SSL" is the old, broken version — technically everything modern is TLS, but "SSL" persists colloquially.

### Version Status
| Version | Status | Action |
|---|---|---|
| SSL 2.0, SSL 3.0 | Broken, retired | Disable immediately |
| TLS 1.0 | Deprecated (2020) | Disable — PCI DSS non-compliant |
| TLS 1.1 | Deprecated (2020) | Disable |
| TLS 1.2 | Current minimum | Keep but prefer 1.3 |
| TLS 1.3 | Current best | Use this |

### TLS Handshake (Simplified)
1. Client sends supported cipher suites and TLS versions
2. Server selects cipher suite, sends certificate
3. Client verifies certificate (chain of trust, expiry, hostname)
4. Key exchange (ECDHE in TLS 1.3 — ephemeral keys, forward secrecy)
5. Both sides derive session keys from the exchange
6. Encrypted data transfer begins

**Perfect Forward Secrecy (PFS):** ECDHE (Elliptic Curve Diffie-Hellman Ephemeral) generates a new key pair for each session. Even if the server's private key is later stolen, past sessions cannot be decrypted. TLS 1.3 mandates PFS.

### Check TLS Config
```bash
# Check what TLS versions and ciphers a server supports
nmap --script ssl-enum-ciphers -p 443 example.com

# Using openssl to force a specific TLS version
openssl s_client -connect example.com:443 -tls1_2
openssl s_client -connect example.com:443 -tls1    # should fail on modern servers

# Online: ssllabs.com/ssltest — grade A to F, detailed report
```

---

## Common Crypto Failures in the Wild

| Failure | What It Means | Impact |
|---|---|---|
| MD5/SHA-1 for passwords | Crackable in seconds with GPU | Full account compromise |
| Self-signed certificate | No CA validation — anyone can spoof it | MITM attack possible |
| Expired certificate | Past validity period | Service disruption, security warnings |
| Hardcoded keys in code | Key shipped with application | Anyone with code has the key |
| Weak cipher suites (RC4, DES, EXPORT) | Cryptographically broken | Traffic decryptable |
| IV/nonce reuse with AES-GCM | Same nonce + same key = authentication bypass | Catastrophic |
| TLS 1.0/1.1 enabled | Deprecated, known attacks (BEAST, POODLE) | Downgrade attack risk |
| Certificate pinning absent | MITM attacks via rogue CA | Credential theft |

---

## Where You'll Encounter Crypto in IT

| Context | Crypto Used | What Can Go Wrong |
|---|---|---|
| HTTPS | TLS 1.2/1.3, AES-GCM, ECDHE | Expired certs, weak cipher suites, mixed content |
| VPN | IPsec (AES, SHA, DH groups) or TLS | Weak DH groups, outdated IKE configs |
| SSH | Ed25519, RSA, ECDSA, AES | Weak host keys, no key rotation, password auth enabled |
| Email | S/MIME (RSA, AES), TLS for transit, SPF/DKIM | Unsigned emails (spoofable), no DMARC |
| Disk encryption | BitLocker (AES-256), LUKS (AES), FileVault | No TPM binding, recovery key not backed up |
| Password storage | bcrypt, Argon2 (good) or MD5/SHA-1 (bad) | Breach impact depends entirely on this |
| Code signing | RSA, ECDSA | Expired code signing cert = app won't run |
| Tokens/sessions | HMAC-SHA256 (JWT) | Weak secret, no expiry, algorithm confusion |

---

## Tags
`[[Cryptography]]` `[[CySA+]]` `[[Security+]]` `[[PKI]]` `[[TLS]]` `[[Hashing]]` `[[Passwords]]` `[[AES]]` `[[RSA]]` `[[SSH]]`