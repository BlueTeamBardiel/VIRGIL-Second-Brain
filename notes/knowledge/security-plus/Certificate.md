---
domain: "cryptography"
tags: [certificates, pki, tls, authentication, x509, cryptography]
---
# Certificate

A **digital certificate** is a cryptographically signed electronic document that binds a [[Public Key]] to an identity (person, organization, device, or service), enabling trusted authentication and encrypted communication. Certificates form the backbone of [[Public Key Infrastructure (PKI)]] and are issued by a trusted third party called a [[Certificate Authority (CA)]]. Without certificates, modern [[TLS/SSL]] encryption and identity verification over the internet would be impossible.

---

## Overview

Digital certificates solve a fundamental problem in public-key cryptography: how do you know that the public key you received actually belongs to the party you think it does? Without a trusted binding mechanism, an attacker could substitute their own public key and intercept communications — a classic [[Man-in-the-Middle Attack]]. Certificates address this by having a trusted Certificate Authority cryptographically sign a document asserting that a specific public key belongs to a specific identity. Any party that trusts the CA can therefore transitively trust the key-identity binding.

The most widely used certificate format is **X.509**, defined in RFC 5280 and used across TLS, S/MIME, code signing, and many other security protocols. An X.509 certificate contains the subject's distinguished name, their public key, the issuer's distinguished name, a validity period, a serial number, and the CA's digital signature over all that data. Modern certificates also contain extensions such as Subject Alternative Names (SANs), key usage constraints, and pointers to revocation services.

Certificates exist within a **trust hierarchy**. At the top sits a **Root CA**, a self-signed certificate that is pre-installed in operating system and browser trust stores (e.g., Mozilla NSS, Microsoft Root Program). Beneath that are one or more **Intermediate CAs** that issue **end-entity certificates** (also called leaf certificates) to actual servers, users, or devices. This chain structure means Root CAs can be kept offline and protected while Intermediate CAs handle day-to-day issuance, limiting exposure if any CA is compromised.

The global web PKI is governed through programs operated by browser and OS vendors. Public CAs must undergo annual audits (WebTrust or ETSI), comply with the CA/Browser Forum Baseline Requirements, and log all issued certificates to **Certificate Transparency (CT) logs** — publicly auditable append-only records that allow detection of misissued certificates. The CT ecosystem, championed by Google, has significantly reduced the window for undetected certificate misissuance.

Certificates are not limited to HTTPS. They authenticate clients in **802.1X network access control**, sign software packages and executables, secure email via **S/MIME**, authenticate VPN peers in **IPsec IKE**, and provide identity in smart card and PIV-based authentication systems. Essentially, any system requiring cryptographically verifiable identity typically relies on certificates.

---

## How It Works

### Certificate Structure (X.509 v3)

A DER-encoded X.509 certificate contains the following fields:

```
TBSCertificate (To-Be-Signed Certificate):
  Version           : v3 (integer 2)
  SerialNumber      : Unique integer assigned by CA
  Signature Alg     : e.g., sha256WithRSAEncryption
  Issuer            : CN=DigiCert TLS RSA SHA256 2020 CA1, O=DigiCert...
  Validity:
    NotBefore       : 2024-01-15 00:00:00 UTC
    NotAfter        : 2025-02-15 23:59:59 UTC
  Subject           : CN=www.example.com, O=Example Inc, C=US
  SubjectPublicKeyInfo:
    Algorithm       : rsaEncryption
    PublicKey       : (2048-bit modulus + exponent)
  Extensions:
    SubjectAltName  : DNS:www.example.com, DNS:example.com
    KeyUsage        : Digital Signature, Key Encipherment
    ExtKeyUsage     : TLS Web Server Authentication
    CRLDistribPoints: http://crl.digicert.com/...
    AuthInfoAccess  : OCSP http://ocsp.digicert.com
    BasicConstraints: CA:FALSE
SignatureAlgorithm  : sha256WithRSAEncryption
SignatureValue      : (CA's RSA signature over DER-encoded TBSCertificate)
```

### Certificate Issuance Process

1. **Key Generation** — The applicant generates a public/private key pair (RSA 2048/4096-bit, ECDSA P-256/P-384, or Ed25519).
2. **CSR Creation** — A **Certificate Signing Request (CSR)** is created containing the public key and desired subject information, signed with the private key to prove possession:
   ```bash
   openssl genrsa -out server.key 4096
   openssl req -new -key server.key -out server.csr \
     -subj "/CN=www.example.com/O=Example Inc/C=US"
   ```
3. **Validation** — The CA validates the requester's control or identity. Three validation levels exist:
   - **DV (Domain Validated)**: Only domain control is verified (automated DNS/HTTP challenge)
   - **OV (Organization Validated)**: Organization existence is verified against business records
   - **EV (Extended Validation)**: Rigorous legal and operational vetting
4. **Signing** — The CA hashes the TBSCertificate with SHA-256 (or configured algorithm), then encrypts the hash with its private key, producing the signature.
5. **Delivery** — The signed certificate is returned to the applicant in PEM or DER format.

### Certificate Validation (Client Side)

When a TLS client receives a server certificate, it performs:

```
1. Chain Building     → Construct path from leaf → intermediates → trusted root
2. Signature Verify   → Verify each certificate's signature using the issuer's public key
3. Validity Period    → Check NotBefore ≤ now ≤ NotAfter
4. Revocation Check   → Query CRL or OCSP to confirm not revoked
5. Name Matching      → Verify hostname matches CN or SAN entries
6. Key Usage          → Confirm TLS Server Auth is in Extended Key Usage
7. Path Length        → Verify BasicConstraints CA:FALSE for leaf certs
```

### Inspecting Certificates

```bash
# View certificate details (PEM format)
openssl x509 -in cert.pem -text -noout

# View a live server's certificate chain
openssl s_client -connect www.example.com:443 -showcerts

# Check certificate expiry
openssl x509 -in cert.pem -noout -dates

# Verify certificate against CA bundle
openssl verify -CAfile ca-bundle.crt server.crt

# Decode a CSR
openssl req -in server.csr -text -noout

# Check OCSP revocation status
openssl ocsp -issuer intermediate.crt -cert server.crt \
  -url http://ocsp.digicert.com -text
```

### Common Certificate File Formats

| Format | Extension | Encoding | Description |
|--------|-----------|----------|-------------|
| PEM | `.pem`, `.crt`, `.cer`, `.key` | Base64 ASCII | Most common; begins with `-----BEGIN CERTIFICATE-----` |
| DER | `.der`, `.cer` | Binary | Compact binary form of ASN.1 structure |
| PKCS#12 | `.pfx`, `.p12` | Binary | Bundles cert + private key + chain, password-protected |
| PKCS#7 | `.p7b`, `.p7c` | Base64 or Binary | Certificate chain only; no private key |

```bash
# Convert PEM to DER
openssl x509 -in cert.pem -outform DER -out cert.der

# Convert PEM to PKCS#12 (bundle cert + key)
openssl pkcs12 -export -out bundle.pfx -inkey server.key -in server.crt \
  -certfile intermediate.crt

# Extract cert from PKCS#12
openssl pkcs12 -in bundle.pfx -nokeys -out cert.pem
```

---

## Key Concepts

- **X.509**: The ITU-T standard (RFC 5280) defining the format of public key certificates. Version 3 introduced extensions that carry SANs, key usage constraints, and revocation pointers critical to modern PKI.

- **Certificate Chain (Chain of Trust)**: The ordered sequence of certificates from a leaf/end-entity certificate up through one or more Intermediate CAs to a Root CA. Validation fails if any link in the chain is broken, expired, or revoked.

- **Certificate Revocation**: The mechanism by which a CA declares a certificate invalid before its natural expiry. Implemented via **CRL (Certificate Revocation List)** — a periodically published signed list of revoked serial numbers — or **OCSP (Online Certificate Status Protocol)**, which provides real-time per-certificate status responses.

- **Subject Alternative Name (SAN)**: An X.509 v3 extension listing all DNS names, IP addresses, email addresses, or URIs the certificate is valid for. Since 2017 the CN field is ignored for hostname matching by major browsers; SANs are now mandatory. A **wildcard certificate** uses `*.example.com` as a SAN to cover one level of subdomains.

- **Certificate Pinning**: A security hardening technique where an application hardcodes (pins) the expected certificate or public key hash, rejecting any certificate not matching — even if signed by a trusted CA. Used in mobile apps and high-security services to defeat CA compromise attacks.

- **OCSP Stapling**: An optimization where the web server pre-fetches and caches the CA's OCSP response, then staples it to the TLS handshake. This eliminates client privacy leakage to OCSP servers and reduces handshake latency.

- **Certificate Transparency (CT)**: A framework requiring publicly trusted CAs to log every issued certificate to append-only, cryptographically verifiable CT logs. Browsers enforce SCTs (Signed Certificate Timestamps) proving certificates were logged, enabling domain owners to monitor for misissued certificates via tools like `crt.sh`.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Certificates appear primarily in Domain 1.4 (Cryptographic Solutions) and Domain 4.4 (Identity and Access Management).

**High-Frequency Exam Topics:**

- Know the **three validation types**: DV, OV, EV — and which provides the strongest identity assurance (EV).
- Distinguish **CRL vs OCSP**: CRL is a downloaded list (periodic, larger); OCSP is real-time per-certificate query. OCSP stapling solves OCSP privacy concerns.
- Understand **certificate uses**: TLS/HTTPS, code signing, S/MIME, client authentication, [[802.1X]].
- Know **wildcard certificates** cover only one subdomain level (`*.example.com` covers `www.example.com` but NOT `a.b.example.com`).
- Know **SAN certificates** (multi-domain/UCC) can list multiple distinct domains.
- Self-signed certificates are not trusted by default — only appropriate for internal/dev use.

**Common Gotchas:**

- A certificate with a valid signature from a trusted CA **can still be invalid** if it's expired, revoked, or the hostname doesn't match the SAN.
- **Root CAs are self-signed** — their signature is verified by checking against the trust store, not against a parent CA.
- The Security+ exam may present scenarios: *"Users receive a certificate warning on the internal site"* → answer is likely **self-signed certificate** or **expired certificate** or **untrusted internal CA**.
- **Pinning** can cause outages during legitimate certificate rotation — know it as a double-edged security control.
- A **CSR does not contain the private key** — it contains the public key only.

---

## Security Implications

### Attack Vectors

**Certificate Misissuance**: A CA (public or private) issues a certificate for a domain to an unauthorized party. This was exploited in the **DigiNotar breach (2011)**, where Iranian attackers compromised the Dutch CA and issued fraudulent certificates for `*.google.com`, enabling mass surveillance of ~300,000 Iranian Gmail users. DigiNotar was removed from all trust stores and went bankrupt.

**BGP Hijacking + Certificate Issuance**: In **2018**, BGP routes for Amazon Route 53 DNS were hijacked, redirecting DNS queries for `myetherwallet.com` to attacker-controlled servers. Because Let's Encrypt uses HTTP-01 ACME challenges, the attacker obtained a valid DV certificate for the domain, making the phishing site appear fully legitimate with a valid padlock.

**Weak Key Attacks**: RSA keys below 1024-bit can be factored. In 2012, researchers (Heninger et al.) discovered that ~0.2% of TLS public keys shared prime factors due to poor entropy during key generation on embedded devices — allowing private key recovery.

**BEAST, POODLE, FREAK, DROWN**: These TLS protocol-level attacks are not certificate vulnerabilities per se, but relate to weak cipher suites negotiated in TLS sessions protected by certificates — reinforcing that certificates alone don't guarantee security.

**Certificate Pinning Bypass**: Mobile apps with certificate pinning can be defeated using tools like **Frida** (dynamic instrumentation) or **SSLUnpinning** Xposed module, which hook the TLS validation functions at runtime to accept any certificate.

**Zombie CAs / Untrusted Private CAs**: In enterprise environments, self-signed internal CAs installed in workstation trust stores can be leveraged by attackers who compromise AD to issue arbitrary fraudulent certificates — especially relevant in [[Active Directory Certificate Services (AD CS)]] attacks (ESC1–ESC11 escalation paths documented by SpecterOps in 2021).

**CVE-2020-0601 (CurveBall / ChainOfFools)**: A Windows CryptoAPI vulnerability where elliptic curve parameters in a certificate were not fully validated, allowing an attacker to forge signatures on ECC-signed certificates — including those used for code signing and TLS.

---

## Defensive Measures

**Monitor Certificate Transparency Logs:**
- Register your domains with [crt.sh](https://crt.sh) or use services like **Cert Spotter** (SSLMate), **Facebook CT Monitor**, or **Cloudflare CT Radar** to receive alerts for any certificate issued for your domains.
- Hunt for typosquatting certificates: `site:crt.sh "%.example.com"` equivalent queries.

**Enforce Strong Cryptographic Standards:**
```
# Recommended key/algorithm requirements
- RSA: minimum 2048-bit (prefer 4096-bit for CAs)
- ECDSA: P-256 or P-384 (preferred for performance)
- Signature hash: SHA-256 minimum (SHA-384/512 for CAs)
- Avoid: MD5, SHA-1 (deprecated), RSA-1024
```

**Certificate Lifecycle Management:**
- Maintain a **certificate inventory** — tools: `certbot`, **Venafi**, **Keyfactor**, **EJBCA**, or even a spreadsheet with expiry dates and responsible owners.
- Automate renewal with **ACME protocol** (Let's Encrypt / `certbot` / `acme.sh`) to eliminate manual renewal failures.
- Set monitoring alerts at 90, 30, and 7 days before expiry.

**Implement OCSP Stapling (nginx example):**
```nginx
ssl_stapling on;
ssl_stapling_verify on;
ssl_trusted_certificate /etc/ssl/certs/ca-bundle.crt;
resolver 1.1.1.1 8.8.8.8 valid=300s;
```

**AD CS Hardening (Windows Enterprise):**
- Audit AD CS templates for vulnerable configurations using **Certify** or **PSPKIAudit**
- Disable `ENROLLEE_SUPPLIES_SUBJECT` on templates unless explicitly required
- Require manager approval for sensitive templates
- Enable CA audit logging: `certutil -setreg CA\AuditFilter 127`

**TLS Configuration:**
- Use **Mozilla SSL Configuration Generator** (modern profile) to generate hardened server configs
- Enforce **HTTP Strict Transport Security (HSTS)** with `includeSubDomains` and `preload`
- Consider **CAA DNS records** to