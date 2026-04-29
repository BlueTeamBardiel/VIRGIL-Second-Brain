---
domain: "cryptography"
tags: [certificates, pki, tls, authentication, x509, cryptography]
---
# Certificates

A **digital certificate** is a cryptographically signed electronic document that binds a [[Public Key]] to an identity, enabling secure communication and authentication across untrusted networks. Certificates are the foundational trust mechanism of the modern internet, underpinning [[TLS/SSL]], [[Code Signing]], email encryption, and enterprise [[PKI (Public Key Infrastructure)]]. The binding of identity to key is validated by a trusted third party called a [[Certificate Authority (CA)]].

---

## Overview

Digital certificates solve the fundamental problem of key distribution and identity assurance in [[Asymmetric Cryptography]]. Without certificates, there is no reliable way to verify that a public key actually belongs to the entity claiming ownership — an adversary could substitute their own key in a [[Man-in-the-Middle Attack]]. Certificates solve this by having a trusted authority (a CA) cryptographically sign a document that asserts "this public key belongs to this identity," creating a chain of trust that clients can verify.

The dominant certificate standard is **X.509**, defined in ITU-T Recommendation X.509 and profiled for internet use in RFC 5280. An X.509 certificate contains the subject's distinguished name, the subject's public key, the issuer (CA) name, validity period (NotBefore and NotAfter timestamps), a serial number, and one or more extensions such as Subject Alternative Names (SANs), Key Usage, and Extended Key Usage. The entire structure is signed with the CA's private key, meaning any tampering with the certificate contents invalidates the signature.

Trust is hierarchical. At the top sits a **Root CA**, whose certificate is self-signed and pre-installed in operating system and browser trust stores (e.g., Mozilla NSS, Microsoft Certificate Trust List, Apple Keychain). Below the root sit **Intermediate CAs** (also called Subordinate CAs), which sign end-entity certificates for servers, users, or devices. This hierarchy exists for security: root CA private keys are kept offline in Hardware Security Modules (HSMs), rarely used, and heavily protected. Compromise of a root CA would invalidate trust for millions of certificates instantly.

Certificates have a defined lifecycle: they are requested, issued, deployed, renewed, and eventually revoked or expired. **Certificate Revocation** is the mechanism by which a CA declares a certificate no longer trustworthy before its natural expiry — typically because the private key was compromised, the organization's status changed, or the certificate was mis-issued. Revocation is communicated via **Certificate Revocation Lists (CRLs)** or the **Online Certificate Status Protocol (OCSP)**. The 2011 DigiNotar breach demonstrated catastrophically what happens when a CA is compromised: fraudulent certificates were issued for Google, Mozilla, and intelligence agencies, enabling nation-state surveillance.

In enterprise environments, organizations deploy **private PKI** using software like Microsoft Active Directory Certificate Services (AD CS), HashiCorp Vault, or open-source EJBCA. Private PKI enables internal certificate issuance for services, VPNs, client authentication, and code signing without paying public CAs. The explosion of internal microservices and zero-trust architectures has made private PKI a critical operational competency for security teams.

---

## How It Works

### Certificate Structure (X.509 v3)

An X.509 certificate contains the following fields:

```
Certificate:
  Version: 3 (0x2)
  Serial Number: 04:00:00:00:00:01:15:4b:5a:c3:94 (unique per CA)
  Signature Algorithm: sha256WithRSAEncryption
  Issuer: C=US, O=DigiCert Inc, CN=DigiCert TLS RSA SHA256 2020 CA1
  Validity:
    Not Before: Jan  1 00:00:00 2024 GMT
    Not After : Jan  1 23:59:59 2025 GMT
  Subject: CN=www.example.com, O=Example Corp, C=US
  Subject Public Key Info:
    Public Key Algorithm: rsaEncryption
    RSA Public Key: (2048 bit)
  X509v3 Extensions:
    Subject Alternative Name: DNS:www.example.com, DNS:example.com
    Key Usage: Digital Signature, Key Encipherment
    Extended Key Usage: TLS Web Server Authentication
    CRL Distribution Points: http://crl3.digicert.com/...
    Authority Information Access: OCSP - URI:http://ocsp.digicert.com
    Subject Key Identifier: ...
    Authority Key Identifier: ...
    Basic Constraints: CA:FALSE
```

### Certificate Issuance Process

1. **Key Generation**: The applicant generates a public/private key pair locally. The private key never leaves their control.
2. **CSR Creation**: A **Certificate Signing Request (CSR)** is generated, containing the public key and requested subject information, signed with the applicant's private key to prove key possession.
3. **Submission**: The CSR is submitted to a CA along with proof of identity (domain validation, organization validation, or extended validation).
4. **Validation**: The CA verifies the identity claim:
   - **DV (Domain Validation)**: CA verifies control of the domain via DNS TXT record, HTTP file, or email.
   - **OV (Organization Validation)**: CA additionally verifies legal organization existence.
   - **EV (Extended Validation)**: Rigorous legal and physical verification.
5. **Signing**: The CA creates the certificate structure, hashes it (e.g., SHA-256), and encrypts the hash with its private key to create the digital signature.
6. **Delivery**: The signed certificate is returned to the applicant and deployed on their server/service.

### Generating a CSR with OpenSSL

```bash
# Generate a 2048-bit RSA private key
openssl genrsa -out server.key 2048

# Generate a CSR (you will be prompted for subject information)
openssl req -new -key server.key -out server.csr \
  -subj "/CN=www.example.com/O=Example Corp/C=US"

# Inspect the CSR
openssl req -text -noout -in server.csr

# Create a self-signed certificate (for testing)
openssl req -x509 -days 365 -key server.key -in server.csr -out server.crt

# Inspect any certificate
openssl x509 -text -noout -in server.crt
```

### TLS Handshake Certificate Usage

During a [[TLS Handshake]], the server presents its certificate to the client:
1. Client sends `ClientHello` with supported cipher suites.
2. Server responds with `ServerHello` and its **Certificate** message.
3. Client validates the certificate chain up to a trusted root in its trust store.
4. Client verifies the server's hostname matches the certificate's CN or SAN.
5. Client verifies the certificate is within its validity period and not revoked.
6. Key exchange proceeds using the server's public key (or via Diffie-Hellman with the cert used for authentication).

### Checking Certificate Details from the Command Line

```bash
# Retrieve and display a server's certificate
openssl s_client -connect www.example.com:443 -showcerts </dev/null 2>/dev/null \
  | openssl x509 -text -noout

# Check certificate expiry
echo | openssl s_client -servername example.com -connect example.com:443 2>/dev/null \
  | openssl x509 -noout -dates

# Verify a certificate chain
openssl verify -CAfile ca-bundle.crt server.crt

# Check OCSP status
openssl ocsp -issuer intermediate.crt -cert server.crt \
  -url http://ocsp.example.com -resp_text
```

### Certificate Chain Validation

A client performs the following chain validation steps:
1. Find the issuer of the end-entity certificate.
2. Locate the issuer's certificate (intermediate CA) — often bundled in the TLS handshake.
3. Verify the issuer's signature on the end-entity cert.
4. Repeat up the chain until reaching a self-signed root.
5. Check that the root is in the local trust store.
6. Verify validity periods, key usage extensions, and revocation status at each level.

---

## Key Concepts

- **X.509**: The ITU-T standard defining the format of public key certificates used in TLS, S/MIME, code signing, and most PKI implementations. Version 3 added the critical **Extensions** mechanism enabling SANs, key usage constraints, and policy OIDs.
- **Certificate Authority (CA)**: An entity trusted to sign certificates, attesting that the subject's identity has been validated. CAs are trusted either by inclusion in OS/browser trust stores (public CAs) or by manual installation (private/enterprise CAs).
- **Subject Alternative Name (SAN)**: An X.509v3 extension that lists additional valid hostnames, IP addresses, email addresses, or URIs for a certificate. SANs replaced the Common Name (CN) field for hostname validation per RFC 2818 and are required by modern browsers. A **wildcard certificate** covers all first-level subdomains (e.g., `*.example.com`).
- **Certificate Revocation List (CRL)**: A CA-published, digitally signed list of serial numbers of revoked certificates. Clients download and cache the CRL to check if a certificate has been revoked. CRLs can become large and stale; OCSP was developed as a more efficient alternative.
- **OCSP Stapling**: An optimization where the server proactively obtains a time-stamped, CA-signed OCSP response and includes it in the TLS handshake, eliminating the need for the client to query the OCSP responder separately. This improves performance and privacy (the CA never learns which sites clients are visiting).
- **Certificate Pinning**: A hardening technique where an application explicitly trusts only specific certificates or public keys, rather than any certificate signed by a trusted CA. Widely used in mobile applications to prevent MitM attacks using fraudulently issued certificates; however, mismanagement causes certificate pinning outages.
- **Certificate Transparency (CT)**: An RFC 6962 framework requiring publicly trusted CAs to log all issued certificates to publicly auditable, append-only CT logs. This enables domain owners to detect mis-issued or fraudulent certificates. Browsers like Chrome require CT compliance for trusted certificates.
- **Key Usage vs. Extended Key Usage**: **Key Usage** (critical extension) restricts what cryptographic operations the key may perform (e.g., Digital Signature, Key Encipherment). **Extended Key Usage (EKU)** further specifies application-level purposes such as `id-kp-serverAuth` (TLS server), `id-kp-clientAuth` (TLS client), or `id-kp-codeSigning`.
- **PEM vs. DER vs. PFX**: Certificates are encoded in different formats: **PEM** (Base64 ASCII, most common on Linux/web servers, `.crt`, `.pem`), **DER** (binary ASN.1, common on Java systems, `.der`, `.cer`), and **PFX/PKCS#12** (binary bundle containing certificate + private key, password-protected, `.pfx`, `.p12`, common on Windows).

---

## Exam Relevance

The Security+ SY0-701 exam tests certificates heavily across multiple domains. Key areas:

**Domain 1.4 / 4.4 — Cryptography and PKI:**
- Know the **types of certificates**: DV, OV, EV, wildcard (`*.example.com`), SAN/multi-domain, self-signed, code signing, email (S/MIME), root, intermediate, and machine/device certificates.
- Understand **certificate chaining**: root → intermediate → end-entity. Know why intermediates exist (to protect root keys).
- Know **revocation mechanisms**: CRL (downloaded list), OCSP (real-time query), OCSP Stapling (server includes response in handshake).
- Differentiate **CSR** (request to CA, contains public key) from the **certificate** (CA-signed response).

**Common Question Patterns:**
- A user gets a "certificate not trusted" error — most likely cause is a **missing intermediate CA** in the chain, or a **self-signed certificate** not in the trust store.
- Certificate expired — renewal required; this is an **availability** issue, not a direct confidentiality issue.
- Which certificate type would you use for all subdomains of a domain? → **Wildcard certificate**.
- Which certificate provides the highest level of identity assurance? → **EV (Extended Validation)**.
- OCSP vs CRL: OCSP is **real-time**, CRL is **downloadable list**; OCSP stapling moves the lookup to the server.

**Gotchas:**
- **Wildcard certificates only cover one level**: `*.example.com` covers `mail.example.com` but NOT `smtp.mail.example.com`.
- **Self-signed certificates provide encryption but NOT authentication** — they protect against passive eavesdropping but not MitM.
- Certificate pinning is a **defense**, not always examined — but know it prevents rogue CA attacks.
- PFX/PKCS#12 contains the **private key** as well as the certificate — treat it as sensitive material.
- The **Subject field CN** has been deprecated for hostname validation; modern validation uses **SAN** exclusively.

---

## Security Implications

### Mis-Issuance and Rogue Certificates
A CA that is compromised or coerced can issue certificates for any domain, enabling undetectable MitM attacks. The **DigiNotar (2011)** breach resulted in fraudulent certificates for `*.google.com` and `*.cia.gov` being used by Iranian intelligence to intercept citizen communications. The CA was subsequently removed from all trust stores and went bankrupt. Similarly, **Symantec CA (2017)** was distrusted by Google Chrome after issuing thousands of mis-issued certificates, eventually requiring Symantec to sell its CA business.

### Weak Key Generation
Certificates using RSA keys below 2048 bits or using SHA-1 signatures are considered cryptographically weak. NIST deprecated SHA-1 for digital signatures in 2011, and browsers began rejecting SHA-1 certificates in 2017. Certificates using 512-bit or 1024-bit RSA keys were practically factorable with commodity hardware using Number Field Sieve algorithms.

### Certificate Transparency Bypass and Monitoring Gaps
Before CT became mandatory, CAs could issue certificates without public logging. Attackers who compromised a CA could issue certificates that were invisible to domain owners. CT mitigates this but requires active monitoring — organizations must subscribe to CT log monitoring services to receive alerts about certificates issued for their domains.

### Private Key Compromise
If the private key associated with a certificate is stolen (e.g., extracted from an insufficiently protected web server, leaked in a code repository, or stolen via vulnerability), an attacker can impersonate the server. The certificate must be immediately revoked and a new key/certificate pair generated. The **Heartbleed (CVE-2014-0160)** vulnerability in OpenSSL allowed remote extraction of private keys from server memory, requiring mass certificate revocation and reissuance across the internet.

### Short-Lived vs. Long-Lived Certificates
Long certificate lifetimes increase the window of exposure if a key is compromised. The industry trend has moved toward shorter lifetimes: Let's Encrypt issues 90-day certificates, and Apple announced plans to support only 47-day certificates by 2027. Automation is required to manage short-lived certificates at scale.

### AD CS Misconfiguration (ESC Vulnerabilities)
Microsoft Active Directory Certificate Services misconfigurations are a rich attack surface. **ESC1–ESC13** (documented by SpecterOps) describe escalation paths where overly permissive certificate templates allow low-privileged users to request certificates that enable domain administrator authentication, Kerberos ticket forging, and persistent access. CVE-2022-26923 (Certifried) allowed a standard domain user to obtain a certificate impersonating a domain controller.

---

## Defensive Measures

### Certificate Lifecycle Management
- Maintain an **inventory** of all certificates in the environment, including expiry dates, issuing CA, and associated services. Tools: `cert-manager` (Kubernetes), HashiCorp Vault, Venafi, or a simple cron job using `openssl s_client`.
- **Automate renewal** using ACME protocol clients (Certbot, `acme.sh`, Caddy's built-in ACME) to prevent expiry-related outages. Let's Encrypt's ACME protocol is defined in RFC 8555.
- Set