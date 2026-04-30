---
domain: "cryptography"
tags: [pki, certificates, tls, authentication, trust, cryptography]
---
# Certificate Authority

A **Certificate Authority (CA)** is a trusted third-party entity responsible for issuing, signing, revoking, and managing [[Digital Certificates]] that bind a public key to an identity. CAs form the backbone of [[Public Key Infrastructure (PKI)]], enabling the trust model that underlies [[TLS/SSL]], code signing, email encryption, and device authentication. Without CAs, entities on the internet would have no reliable way to verify that a public key actually belongs to who it claims to belong to.

---

## Overview

Certificate Authorities exist to solve the **key distribution and authentication problem** inherent in asymmetric cryptography. If Alice wants to encrypt a message to Bob, she needs Bob's public key — but how does she know the public key she receives actually belongs to Bob and not an attacker performing a [[Man-in-the-Middle Attack]]? A CA solves this by acting as a mutually trusted third party. The CA cryptographically signs a certificate containing Bob's public key and identity information. Alice trusts the CA, verifies the CA's signature on the certificate, and therefore trusts the binding between the key and Bob's identity.

CAs operate within a hierarchical trust model. At the top sits the **Root CA**, a self-signed entity whose public key is embedded directly into operating systems and browsers — this is the ultimate anchor of trust. Root CAs rarely issue end-entity certificates directly; instead, they sign **Intermediate CA** certificates, which in turn issue end-entity (leaf) certificates to organizations and individuals. This chain creates what is called the **certificate chain** or **chain of trust**. If any certificate in the chain is compromised or revoked, the entire sub-tree of certificates it signed loses validity.

There are two broad classes of CAs: **Public CAs** and **Private CAs**. Public CAs (DigiCert, Let's Encrypt, Sectigo, GlobalSign) are trusted by default in browsers and operating systems because they are included in root certificate stores maintained by Apple, Microsoft, Mozilla, and Google. Their root certificates are subject to rigorous audit requirements under the **CA/Browser Forum Baseline Requirements**. Private CAs are deployed internally by organizations for internal services, VPN authentication, device certificates, and other enterprise needs — they are not trusted by default outside the organization but are distributed via Group Policy or MDM to managed devices.

The CA ecosystem has evolved significantly in response to high-profile compromises. The 2011 **DigiNotar breach** — where an Iranian-linked attacker issued fraudulent wildcard certificates for google.com — led to DigiNotar's complete destruction as a business and demonstrated how a single compromised CA could undermine the security of millions of users. This incident accelerated adoption of **Certificate Transparency (CT)**, a system requiring all publicly trusted CAs to log every certificate they issue to public, append-only CT logs that can be audited by anyone.

Modern CA operations are governed by detailed policies documented in the **Certificate Policy (CP)** and **Certification Practice Statement (CPS)**, which describe the procedures, controls, and legal obligations of the CA. These documents define validation levels — **Domain Validation (DV)**, **Organization Validation (OV)**, and **Extended Validation (EV)** — which indicate how thoroughly the CA has verified the certificate requester's identity before issuance.

---

## How It Works

### Certificate Issuance Process

The process of obtaining a certificate from a CA involves several well-defined steps:

**1. Key Pair Generation**

The subscriber (the entity requesting a certificate) generates an asymmetric key pair. The private key is kept secret; the public key will be embedded in the certificate.

```bash
# Generate a 4096-bit RSA private key
openssl genrsa -out server.key 4096

# Generate an elliptic curve key (P-256, preferred for modern deployments)
openssl ecparam -name prime256v1 -genkey -noout -out server-ec.key
```

**2. Certificate Signing Request (CSR) Creation**

The subscriber creates a **Certificate Signing Request (CSR)**, a standardized file (PKCS#10 format) containing the public key and identity information the subscriber wants embedded in the certificate. The CSR is signed with the subscriber's private key to prove possession.

```bash
# Generate a CSR with Subject Alternative Names
openssl req -new -key server.key -out server.csr \
  -subj "/C=US/ST=Virginia/L=Arlington/O=YOUR-LAB Lab/CN=lab.cocytus.local" \
  -addext "subjectAltName=DNS:lab.cocytus.local,DNS:www.lab.cocytus.local"

# Inspect the CSR
openssl req -text -noout -verify -in server.csr
```

**3. Validation**

The CA performs identity verification appropriate to the certificate type:
- **DV**: Proves control of the domain (ACME challenge via HTTP, DNS, or TLS-ALPN)
- **OV**: Verifies legal existence of the organization via business registries
- **EV**: Extensive manual vetting including legal jurisdiction, operational existence, and physical address

**4. Certificate Signing**

The CA creates an X.509 certificate containing the subscriber's public key, identity fields, validity period, serial number, and extensions (key usage, extended key usage, Subject Alternative Names, CRL Distribution Points, OCSP URL). The CA hashes this data and signs it with its own private key.

```bash
# CA signs the CSR (internal/homelab CA scenario)
openssl x509 -req -days 365 \
  -in server.csr \
  -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out server.crt \
  -extfile <(printf "subjectAltName=DNS:lab.cocytus.local\nkeyUsage=digitalSignature,keyEncipherment\nextendedKeyUsage=serverAuth")

# Inspect the issued certificate
openssl x509 -text -noout -in server.crt
```

**5. Certificate Delivery and Installation**

The signed certificate is returned to the subscriber and installed on the server, device, or application.

### Verification Process (Relying Party)

When a client (browser, OS, application) encounters a certificate, it performs the following:

1. **Chain Building**: Constructs a path from the end-entity certificate up to a trusted Root CA
2. **Signature Validation**: Verifies each certificate's signature using the issuer's public key
3. **Validity Period Check**: Ensures `notBefore` and `notAfter` fields are satisfied
4. **Revocation Check**: Queries CRL (Certificate Revocation List) via HTTP or OCSP (Online Certificate Status Protocol) on TCP port 80
5. **Name Matching**: Verifies the hostname matches CN or Subject Alternative Names
6. **Policy Compliance**: Checks key usage extensions allow the intended operation

```bash
# Verify a certificate chain
openssl verify -CAfile ca-chain.crt server.crt

# Check OCSP status directly
openssl ocsp -issuer intermediate.crt -cert server.crt \
  -url http://ocsp.example.com -resp_text

# Fetch and display a server's certificate chain
openssl s_client -connect example.com:443 -showcerts </dev/null 2>/dev/null \
  | openssl x509 -noout -text
```

### ACME Protocol (Automated Certificate Management)

The **Automatic Certificate Management Environment (ACME)** protocol (RFC 8555) is used by Let's Encrypt and other CAs to automate DV certificate issuance. The client proves domain control by placing a file at a known HTTP path (HTTP-01 challenge) or creating a DNS TXT record (DNS-01 challenge).

```bash
# Issue a certificate using certbot (Let's Encrypt ACME client)
certbot certonly --standalone -d example.com -d www.example.com

# Using acme.sh for DNS-01 challenge
acme.sh --issue --dns dns_cloudflare -d '*.example.com'
```

---

## Key Concepts

- **Root CA**: The top-level CA in a hierarchy whose self-signed certificate is embedded in OS and browser trust stores. Root CA private keys are kept offline in Hardware Security Modules (HSMs) in physically secured facilities.
- **Intermediate CA** (Subordinate CA): A CA whose certificate is signed by the Root CA. Intermediate CAs perform day-to-day certificate issuance, isolating the Root CA from operational risk. Compromise of an Intermediate CA can be remediated by revoking its certificate without destroying the Root.
- **X.509**: The ITU-T standard defining the format of public key certificates. All TLS certificates are X.509 v3 certificates, which introduced the critical **extensions** field enabling SANs, key usage constraints, and CA/non-CA designation via the Basic Constraints extension.
- **Certificate Revocation List (CRL)**: A signed, time-stamped list published by a CA containing serial numbers of all certificates it has revoked before their natural expiry. CRLs are downloaded by clients from URLs embedded in the certificate's CRL Distribution Points (CDP) extension and served over HTTP (port 80).
- **Online Certificate Status Protocol (OCSP)**: A real-time revocation checking protocol (RFC 6960) that allows clients to query a CA's OCSP responder for the current status of a single certificate, avoiding the need to download an entire CRL. **OCSP Stapling** improves privacy and performance by having the web server obtain and cache the OCSP response, then "staple" it to the TLS handshake.
- **Certificate Transparency (CT)**: A framework requiring publicly trusted CAs to submit all issued certificates to public, append-only log servers. Browsers enforce CT compliance, and tools like `crt.sh` allow anyone to search CT logs for certificates issued for any domain, enabling detection of misissued or rogue certificates.
- **Registration Authority (RA)**: An entity that handles identity verification on behalf of a CA. The RA performs validation and approves or denies certificate requests but delegates the actual signing to the CA.
- **Hardware Security Module (HSM)**: A dedicated tamper-resistant hardware device used to store CA private keys and perform cryptographic operations. Examples include Thales Luna, Entrust nShield, and AWS CloudHSM. Use of HSMs is mandatory for publicly trusted CAs.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Certificate Authority concepts appear primarily in **Domain 1 (General Security Concepts)** under PKI and cryptography, and **Domain 4 (Security Operations)** under certificate management.

**High-Frequency Exam Topics**:
- Know the difference between Root CA, Intermediate CA, and leaf (end-entity) certificates and why the chain of trust matters
- Understand CRL vs. OCSP — the exam frequently tests which provides *real-time* status (OCSP) vs. a *periodically published list* (CRL)
- Know that **OCSP Stapling** moves the revocation check burden from the client to the server
- Distinguish **DV, OV, and EV** certificates by what each validates — domain control only, organizational identity, or extensive legal vetting
- Understand **certificate pinning** — hardcoding expected certificate/public key values in an application to prevent MITM even with a valid CA-signed certificate
- Know that **self-signed certificates** have no chain of trust to a trusted CA and generate browser warnings

**Common Gotchas**:
- The exam may present a scenario where a CA is "offline" — this is **correct behavior** for a Root CA whose key should never be exposed on a network
- **Key escrow** means a copy of a private key is held by a third party (often for recovery purposes) — distinguish this from certificate revocation
- **Cross-certification** allows two separate PKI hierarchies to establish mutual trust without sharing a root
- Certificate validity periods: Let's Encrypt issues 90-day certificates; publicly trusted CA maximum is currently 397 days (enforced by browsers)
- The **CN (Common Name) field is deprecated** for hostname matching; browsers use **Subject Alternative Names (SANs)** exclusively

---

## Security Implications

### CA Compromise

A compromised CA private key is catastrophic — the attacker can issue valid, trusted certificates for any domain. Historical examples:

- **DigiNotar (2011)**: Attacker compromised infrastructure and issued 500+ fraudulent certificates including a wildcard for `*.google.com`. Used to intercept 300,000+ Iranian Gmail users via MITM. DigiNotar was removed from all trust stores and ceased operations within weeks.
- **Comodo (2011)**: Nine fraudulent certificates issued for high-value domains (google.com, yahoo.com, skype.com) after reseller credential compromise.
- **ANSSI/France (2013)**: French government CA issued unauthorized certificates for Google domains for use in a corporate HTTPS inspection proxy — a policy violation, not a breach, but illustrative of insider misuse.

### Subordinate CA Misuse

If an organization is issued an **unconstrained subordinate CA certificate**, they can issue certificates for *any* domain, not just their own. This is why the CA/Browser Forum prohibits issuing unconstrained subordinate CA certificates to external organizations without intense auditing.

### BGP Hijacking + Fraudulent DV Certificates

Because DNS-01 and HTTP-01 ACME challenges rely on DNS resolution and HTTP reachability, **BGP hijacking attacks** can redirect traffic and allow an attacker to complete domain validation challenges for domains they don't legitimately control. This was demonstrated against a Brazilian bank in 2017 and against MyEtherWallet in 2018.

### CT Log Monitoring for Threat Detection

Certificate Transparency logs reveal when certificates are issued for your domains, enabling detection of:
- Phishing domains using typosquats with valid TLS certificates
- Rogue certificates issued for your domain by misbehaving CAs
- Shadow IT — internal teams obtaining public certificates for internal services

---

## Defensive Measures

**1. Implement Certificate Transparency Monitoring**
```bash
# Monitor CT logs for your domain using certspotter
certspotter -domains example.com -watchlist /etc/certspotter/watchlist

# Query crt.sh API for certificates issued for a domain
curl "https://crt.sh/?q=%.example.com&output=json" | jq '.[].name_value'
```

**2. Deploy CAA DNS Records**

**Certification Authority Authorization (CAA)** DNS records specify which CAs are authorized to issue certificates for your domain. Any CA that receives a certificate request for your domain must check the CAA record and refuse if not listed.

```dns
; Only allow Let's Encrypt to issue certificates for example.com
example.com.  IN  CAA  0 issue "letsencrypt.org"
example.com.  IN  CAA  0 issuewild ";"    ; Prohibit wildcard certificates
example.com.  IN  CAA  0 iodef "mailto:security@example.com"
```

**3. Configure OCSP Stapling (Nginx)**
```nginx
ssl_stapling on;
ssl_stapling_verify on;
ssl_trusted_certificate /etc/ssl/ca-chain.crt;
resolver 1.1.1.1 8.8.8.8 valid=300s;
resolver_timeout 5s;
```

**4. Internal PKI Hardening**
- Store Root CA private key offline on an air-gapped machine or HSM; only bring online for intermediate CA signing ceremonies
- Define certificate issuance policies using **Name Constraints** extensions to limit intermediate CAs to specific domain namespaces
- Implement **short certificate lifetimes** (90 days or less) to minimize blast radius from key compromise
- Enable audit logging for all CA operations — every certificate issuance, revocation, and key ceremony

**5. HPKP Successor: Expect-CT and Certificate Pinning**

HTTP Public Key Pinning (HPKP) is deprecated. Use `Expect-CT` headers for CT enforcement and implement application-level certificate pinning in mobile/thick-client apps for high-security services:
```http
Expect-CT: max-age=86400, enforce, report-uri="https://example.com/ct-report"
```

---

## Lab / Hands-On

### Build a Two-Tier Private CA with OpenSSL

```bash
# === TIER 1: ROOT CA (keep offline after creation) ===
mkdir -p ~/lab-pki/{root-ca,intermediate-ca,certs}/{private,certs,crl,newcerts,requests}
chmod 700 ~/lab-pki/root-ca/private

# Initialize database files
echo 1000 > ~/lab-pki/root-ca/serial
touch ~/