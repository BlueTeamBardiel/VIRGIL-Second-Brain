---
domain: "cryptography"
tags: [pki, certificates, tls, authentication, trust, x509]
---
# Certificate Chain

A **certificate chain** (also called a **chain of trust**) is a sequence of [[X.509 Certificate|X.509 certificates]] that links an end-entity certificate back to a trusted [[Root Certificate Authority|root Certificate Authority (CA)]], establishing cryptographic proof of identity. Each certificate in the chain is signed by the one above it, creating a hierarchical trust model used in [[TLS/SSL]], code signing, and email encryption. Without a valid chain, a [[Public Key Infrastructure (PKI)|PKI]]-based system cannot verify whether a certificate is trustworthy.

---

## Overview

The certificate chain model exists because it is impractical and insecure to have a single root CA sign every certificate on the internet. Instead, trust is delegated downward through a hierarchy. A **root CA** sits at the top — its certificate is self-signed and pre-installed in operating systems and browsers as an inherently trusted anchor. Root CAs are kept offline in highly secured environments (air-gapped HSMs, physical vaults) precisely because their compromise would invalidate trust for every certificate they have ever issued.

Between the root CA and end-entity certificates sit one or more **intermediate CAs** (also called **subordinate CAs**). These intermediates are signed by the root (or another intermediate), and they in turn sign certificates for servers, users, or devices. This layered design means the root CA's private key is rarely used, dramatically reducing exposure. If an intermediate CA is compromised, it can be revoked and replaced without invalidating the root or every other intermediate in the ecosystem.

The **end-entity certificate** (also called a **leaf certificate**) is what a web server presents during a TLS handshake. It contains the server's public key, its domain name (Common Name or Subject Alternative Names), validity period, and the digital signature of the issuing intermediate CA. A client that receives this certificate checks whether the issuing intermediate's certificate is trusted, then checks whether *that* certificate was signed by a trusted root, completing the chain validation.

Real-world certificate chains typically have two or three levels (root → intermediate → end-entity), though longer chains are possible. Browser vendors and OS vendors maintain **trust stores** — curated lists of root CA certificates that are trusted by default. Mozilla's NSS store, Microsoft's Windows Root Certificate Program, and Apple's Root Certificate Program are the primary examples. A certificate is only trusted if its chain terminates at one of the roots in the relevant trust store.

---

## How It Works

### Chain Structure

```
Root CA Certificate (self-signed, in trust store)
    └── Intermediate CA Certificate (signed by Root CA)
            └── End-Entity Certificate (signed by Intermediate CA)
```

### Step-by-Step TLS Handshake Chain Validation

1. **Client initiates TLS** — The client sends a `ClientHello` to the server on port 443 (HTTPS).
2. **Server presents its certificate chain** — During the `Certificate` message of the TLS handshake, the server sends its leaf certificate plus any intermediate CA certificates. The root is *not* sent because it is assumed to already be in the client's trust store.
3. **Client receives and orders the chain** — The client constructs the chain by matching each certificate's `Issuer` field to the next certificate's `Subject` field.
4. **Signature verification at each link** — Starting from the leaf, the client verifies the digital signature on each certificate using the public key in the issuing certificate above it. This is an asymmetric cryptographic verification (typically RSA or ECDSA).
5. **Root trust anchor check** — The top of the chain must be a self-signed certificate that exists in the client's trust store. If it does, the chain is anchored.
6. **Validity and revocation checks** — For each certificate in the chain, the client verifies:
   - The current date falls within the `NotBefore` and `NotAfter` validity window
   - The certificate has not been revoked (via [[Certificate Revocation List (CRL)]] or [[OCSP]])
   - The certificate's `KeyUsage` and `ExtendedKeyUsage` extensions are appropriate for its role
7. **Chain accepted or rejected** — If all checks pass, the handshake proceeds. If any link fails, the client presents an error (e.g., `ERR_CERT_AUTHORITY_INVALID` in Chrome).

### Examining a Certificate Chain with OpenSSL

```bash
# View the full certificate chain presented by a server
openssl s_client -connect example.com:443 -showcerts

# Verify a certificate chain manually (cert.pem, intermediate.pem, root.pem)
openssl verify -CAfile root.pem -untrusted intermediate.pem cert.pem

# View certificate details including issuer and subject
openssl x509 -in cert.pem -noout -text | grep -E "Subject:|Issuer:|Not Before|Not After"

# Check OCSP status using the OCSP URI embedded in the certificate
openssl x509 -in cert.pem -noout -ocsp_uri
openssl ocsp -issuer intermediate.pem -cert cert.pem -url http://ocsp.example.com -resp_text
```

### Certificate Fields Relevant to Chain Building

| Field | Purpose |
|---|---|
| `Subject` | The identity this certificate represents |
| `Issuer` | The CA that signed this certificate |
| `Authority Key Identifier` | Key ID of the signing CA (helps disambiguate when multiple intermediates exist) |
| `Subject Key Identifier` | Key ID of this certificate's public key |
| `Basic Constraints: CA:TRUE` | Indicates this certificate may sign other certificates |
| `Path Length Constraint` | Limits how many additional CAs can appear below this one |

### Bundling Certificates Correctly

Web servers must be configured to serve the full chain (leaf + intermediates). Missing intermediate certificates is one of the most common TLS misconfigurations:

```nginx
# Nginx — combine leaf + intermediate into a single file
cat server.crt intermediate.crt > chained.crt

ssl_certificate     /etc/ssl/chained.crt;
ssl_certificate_key /etc/ssl/server.key;
```

```apache
# Apache — use SSLCertificateChainFile (Apache < 2.4.8) or SSLCertificateFile with bundle
SSLCertificateFile      /etc/ssl/server.crt
SSLCertificateChainFile /etc/ssl/intermediate.crt
SSLCertificateKeyFile   /etc/ssl/server.key
```

---

## Key Concepts

- **Root Certificate Authority (Root CA):** The top-level trust anchor in a PKI hierarchy. Its certificate is self-signed, meaning it vouches for itself. It is trusted only because it is pre-installed in a trust store by an OS or browser vendor after that CA undergoes an external audit (e.g., WebTrust).

- **Intermediate CA (Subordinate CA):** A CA whose certificate is signed by the root CA or another intermediate. Intermediates do the actual day-to-day signing of end-entity certificates, keeping the root CA offline and protected. Compromise of an intermediate can be remediated by revoking its certificate without invalidating the root.

- **End-Entity Certificate (Leaf Certificate):** The certificate issued to the actual subject — a web server, user, device, or code-signing identity. It has `CA:FALSE` in the Basic Constraints extension, meaning it cannot sign other certificates.

- **Trust Store:** A curated collection of root CA certificates that a system, browser, or application trusts implicitly. Examples include the Windows Certificate Store (`certmgr.msc`), the Mozilla NSS store used by Firefox, and the Java keystore (`cacerts`). Adding a custom root to a trust store makes all certificates that chain to it trusted automatically.

- **Path Length Constraint:** An X.509 extension (`pathLenConstraint`) on CA certificates that limits how deep the certificate chain can extend below that CA. A `pathLenConstraint: 0` on an intermediate means it can only sign leaf certificates, not other CAs.

- **Chain of Trust vs. Web of Trust:** Chain of trust is the hierarchical PKI model used in TLS — trust flows downward from a central root. The [[Web of Trust]] (used in [[PGP/GPG]]) is a decentralized model where individuals vouch for each other's keys with no central authority.

- **AIA (Authority Information Access):** An X.509 extension that contains URLs pointing to the issuer's certificate and OCSP responder. Clients can use the `caIssuers` URL to automatically download missing intermediate certificates, which is why some browsers can construct incomplete chains that other tools cannot.

---

## Exam Relevance

**SY0-701 Domain Mapping:** This topic falls under Domain 1 (General Security Concepts) and Domain 4 (Cryptography and PKI).

**Key exam facts to memorize:**

- The **root CA** is the ultimate trust anchor. It is self-signed. It lives in the trust store.
- **Intermediate CAs** exist to protect the root CA by keeping it offline. If an intermediate is compromised, only it (and certificates it signed) need to be revoked — not the entire root hierarchy.
- **Certificate validation** requires checking the signature, validity period, revocation status, and key usage at every level of the chain.
- A **missing intermediate certificate** will cause TLS errors even if the root and leaf are both valid — the chain must be complete.
- **Pinning** (HTTP Public Key Pinning / certificate pinning) is the practice of hardcoding expected certificates or public keys — this can break legitimate chain updates.

**Common question patterns:**

- *"A user receives a certificate error when visiting an internal site. The cert was issued by the company's internal CA. What is the most likely fix?"* → Install the internal root CA certificate in the user's trust store.
- *"Which type of CA is typically kept offline to protect the root of trust?"* → Root CA.
- *"A server's certificate is valid, but clients still receive chain errors. What is missing?"* → Intermediate CA certificate not served by the server.
- *"What extension in a certificate indicates it can be used to sign other certificates?"* → `Basic Constraints: CA:TRUE`.

**Gotcha:** Don't confuse the **certificate chain** (trust hierarchy) with the **certificate bundle** (a file containing multiple certs). They're related but distinct concepts. Also, the root certificate is *not* sent during TLS — only the leaf and intermediates are.

---

## Security Implications

### Compromise of a CA

The most catastrophic attack against the certificate chain model is the compromise of a CA's signing key. In 2011, **DigiNotar**, a Dutch CA, was breached and attackers issued hundreds of fraudulent certificates including wildcards for `*.google.com`. This enabled large-scale [[Man-in-the-Middle (MitM)|man-in-the-middle attacks]] against Iranian users. DigiNotar was removed from all trust stores and subsequently went bankrupt. Similarly, **Comodo** (2011) saw nine fraudulent certificates issued after a reseller's systems were compromised.

### Mis-issued Certificates

CAs have historically mis-issued certificates for domains they should not have had authority over. The Certificate Transparency ([[Certificate Transparency (CT)|CT]]) log system was created specifically to provide public auditability of all issued certificates. Every publicly-trusted certificate must now be logged in a CT log, and browsers enforce this requirement.

### Chain Validation Vulnerabilities

- **CVE-2009-2408 (NSS Null Byte Injection):** An attacker could include a null byte (`\0`) in a certificate's CN to fool naive string-handling parsers into accepting `evil.com\0.legitimate.com` as a valid cert for `legitimate.com`.
- **CVE-2014-0092 (GnuTLS certificate verification bypass):** A code-level bug caused GnuTLS to return a success code even when certificate chain verification failed, allowing any certificate to be trusted.
- **MITM via Rogue CA:** Nation-state actors and enterprises deploying SSL inspection appliances act as a "rogue" intermediate CA. This is technically valid if the enterprise root is installed in employee trust stores, but represents a privacy/integrity concern.

### Path Traversal / Downgrade Attacks

Attackers who can intercept traffic may attempt to serve a forged chain that terminates at a root the victim trusts but that was issued fraudulently. [[Certificate Pinning]] and [[HSTS]] are mitigations. [[DANE (DNS-Based Authentication of Named Entities)|DANE]] ties certificate validation to DNSSEC records, providing an alternative trust anchor.

---

## Defensive Measures

### Monitor Certificate Transparency Logs

Enroll your domains in CT monitoring services (e.g., **crt.sh**, **Facebook's Certificate Transparency Monitoring**, **Cert Spotter**) to receive alerts when any CA issues a certificate for your domains — including fraudulent ones.

```bash
# Query crt.sh for all certificates issued for a domain
curl -s "https://crt.sh/?q=%.example.com&output=json" | jq '.[].name_value' | sort -u
```

### Implement CAA DNS Records

**Certification Authority Authorization (CAA)** DNS records restrict which CAs are allowed to issue certificates for your domain. Any CA that follows the CA/Browser Forum baseline requirements must check CAA records before issuing.

```dns
; Only Let's Encrypt and DigiCert may issue for this domain
example.com.  CAA  0 issue "letsencrypt.org"
example.com.  CAA  0 issue "digicert.com"
example.com.  CAA  0 iodef "mailto:security@example.com"
```

### Validate Your Own Chain

Regularly audit your server's certificate configuration:

```bash
# Check with SSL Labs (requires internet access)
# https://www.ssllabs.com/ssltest/

# Local check with testssl.sh
testssl.sh --chain --warnings https://example.com

# Check that the full chain is served
openssl s_client -connect example.com:443 2>/dev/null | openssl x509 -noout -subject -issuer
```

### Enforce Certificate Pinning for High-Value Applications

For mobile apps and critical internal services, pin the intermediate or leaf certificate's public key hash to detect MITM even with a trusted CA:

```
# HTTP header for HPKP (deprecated but illustrative)
Public-Key-Pins: pin-sha256="base64=="; max-age=5184000; includeSubDomains

# Modern approach: use TLS configuration with expected certificate fingerprints
# or implement in application code using the platform's TLS API
```

### Maintain Internal PKI Hygiene

- Keep root CA keys in [[Hardware Security Module (HSM)|HSMs]] and offline
- Use short validity periods for intermediate CA certificates (2–3 years max)
- Implement CRL/OCSP infrastructure and monitor its availability
- Document and enforce a certificate lifecycle management process (issuance, renewal, revocation)

---

## Lab / Hands-On

### Build a Three-Tier PKI with OpenSSL

```bash
# 1. Create the Root CA
mkdir -p ~/pki/{root-ca,intermediate-ca,certs}/{private,certs,crl,newcerts}
cd ~/pki/root-ca

# Generate root CA key (keep this private and offline)
openssl genrsa -aes256 -out private/root-ca.key.pem 4096

# Self-sign the root CA certificate (valid 20 years)
openssl req -key private/root-ca.key.pem -new -x509 -days 7300 \
  -sha256 -extensions v3_ca \
  -out certs/root-ca.cert.pem \
  -subj "/C=US/ST=Lab/O=[YOUR-LAB] Lab Root CA/CN=[YOUR-LAB] Root CA"

# Verify root CA
openssl x509 -in certs/root-ca.cert.pem -noout -text | grep -E "Subject:|Issuer:|CA:"

# 2. Create the Intermediate CA
cd ~/pki/intermediate-ca
openssl genrsa -aes256 -out private/intermediate.key.pem 4096

# Create CSR for intermediate CA
openssl req -key private/intermediate.key.pem -new -sha256 \
  -out intermediate.csr.pem \
  -subj "/C=US/ST=Lab/O=[YOUR-LAB] Lab/CN=[YOUR-LAB] Intermediate CA"

# Sign the intermediate CSR with the root CA (valid 10 years)
cd ~/pki/root-ca
openssl