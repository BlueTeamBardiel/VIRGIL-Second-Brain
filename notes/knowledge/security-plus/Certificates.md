# Certificates

## What it is

In Minecraft, when you join a multiplayer server, the server has a unique signature tied to its IP — Mojang's session servers vouch that the player connecting is really who their username claims, signed by Mojang's authentication system. Anyone forging that identity gets booted. That's exactly what **digital certificates** do — they're tamper-proof ID cards signed by a trusted third party that prove a public key actually belongs to who it says it does.

A **digital certificate** is an X.509-formatted electronic document binding a public key to an identity (person, server, device), signed by a trusted [[Certificate Authority]] to enable authentication and encrypted communication.

## Why it matters

Without certificates, every TLS handshake is a coin flip — you have no way to prove the server you're talking to isn't an attacker performing a [[man-in-the-middle attack]]. Stolen, expired, or mis-issued certs lead directly to phishing sites that look legitimate, browser trust warnings that get clicked through, and compliance failures under PCI-DSS, HIPAA, and FedRAMP. SY0-701 Objective 1.4 expects you to know certificate types, fields, formats, and revocation mechanisms cold; CompTIA's favorite trap is confusing **OCSP stapling** with plain **OCSP**, or asking which file extension carries a private key vs. just the public cert.

## Key facts

### Anatomy of an X.509 certificate
| Field | Purpose |
|---|---|
| **Version** | X.509 v3 is current |
| **Serial Number** | Unique per CA |
| **Signature Algorithm** | e.g., SHA-256 with RSA |
| **Issuer** | The [[Certificate Authority]] that signed it |
| **Validity Period** | notBefore / notAfter dates |
| **Subject** | Who the cert identifies (CN, O, OU) |
| **Subject Public Key Info** | The public key being vouched for |
| **Extensions** | [[Subject Alternative Name]] (SAN), Key Usage, Extended Key Usage |
| **CA Signature** | Issuer's signature over the above |

### Certificate types
- **[[Domain Validation]] (DV)** — proves domain control only; cheap, fast, automated (Let's Encrypt). Padlock, but no identity assurance.
- **[[Organization Validation]] (OV)** — CA verifies the requesting organization exists.
- **[[Extended Validation]] (EV)** — rigorous legal entity verification; once gave the green address bar (mostly deprecated in modern browsers).
- **[[Wildcard Certificate]]** — `*.example.com` covers any single-level subdomain. Convenient, but compromise = total subdomain takeover.
- **[[Subject Alternative Name]] (SAN)** — multiple specific hostnames in one cert (`mail.example.com`, `vpn.example.com`).
- **[[Self-signed Certificate]]** — signed by its own private key. Free, but no external trust; fine for internal labs, fatal for public services.
- **[[Code Signing Certificate]]** — proves software publisher identity and that binary wasn't tampered with.
- **[[Root Certificate]]** — top of the trust chain, self-signed, pre-installed in OS/browser trust stores.
- **[[Machine/Computer Certificate]]**, **[[User Certificate]]**, **[[Email Certificate]]** (S/MIME) — same X.509 plumbing, different subjects.

### Certificate file formats
| Extension | Encoding | Contains |
|---|---|---|
| **.PEM** | Base64 ASCII (`-----BEGIN CERTIFICATE-----`) | Cert, key, or chain |
| **.DER** | Binary | Single cert, no key |
| **.CRT / .CER** | PEM or DER | Public cert |
| **.KEY** | PEM | Private key (guard with your life) |
| **.PFX / .P12** | Binary, password-protected | Cert + private key + chain (PKCS#12) |
| **.P7B / .P7C** | Base64 (PKCS#7) | Cert chain, no private key |

CompTIA loves to ask which format includes the private key. Answer: **PFX/P12**. PEM *can* but doesn't have to.

### Trust chain
**Root CA → Intermediate CA → End-entity (leaf) certificate.** Browsers ship with root CAs pre-trusted. Intermediates sign leaves so the root can stay offline in a vault. Break any link, trust collapses.

### Revocation mechanisms
- **[[Certificate Revocation List]] (CRL)** — CA publishes a signed list of revoked serial numbers. Clients download periodically. Bandwidth-heavy, latency-prone.
- **[[Online Certificate Status Protocol]] (OCSP)** — client asks CA in real time: "is serial N still good?" Faster than CRL but creates a privacy leak (CA sees who you visit) and a CA-availability dependency.
- **[[OCSP Stapling]]** — server fetches its own OCSP response from the CA, signs it with a timestamp, and "staples" it to the TLS handshake. Solves both privacy and CA-load problems. **This is the CompTIA-favored answer for "improving OCSP."**
- **[[Certificate Pinning]]** — client hard-codes which cert/CA to expect for a given service; rejects everything else even if technically valid. Defeats rogue-CA attacks.

### Reasons to revoke
Key compromise, CA compromise, change of affiliation, superseded, cessation of operation. Common exam distractor: "expiration" — expired certs aren't *revoked*, they just timed out.

### CSR and key lifecycle
1. Generate keypair on the server.
2. Create a **[[Certificate Signing Request]] (CSR)** — contains public key + subject info, signed by the matching private key.
3. Submit CSR to CA.
4. CA validates, issues signed cert.
5. Install cert + chain on server. **Private key never leaves the server.**

### Key escrow vs. key recovery
**[[Key Escrow]]** — a third party holds a copy of the private key (compliance, lawful access). **[[Key Recovery]]** — a documented process to retrieve a lost key. Different things; CompTIA will swap them.

## Related concepts

[[Public Key Infrastructure]] · [[Certificate Authority]] · [[Registration Authority]] · [[TLS]] · [[Asymmetric Encryption]] · [[Digital Signature]] · [[OCSP Stapling]] · [[Certificate Pinning]] · [[Certificate Signing Request]] · [[Key Escrow]] · [[Hardware Security Module]]

---
*Source: VIRGIL knowledge base — 2026-05-08*