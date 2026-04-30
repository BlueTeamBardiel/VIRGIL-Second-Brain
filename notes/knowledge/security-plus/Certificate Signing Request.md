---
domain: "cryptography"
tags: [pki, certificates, tls, x509, asymmetric-cryptography, authentication]
---
# Certificate Signing Request

A **Certificate Signing Request (CSR)** is a structured block of encoded data submitted to a **Certificate Authority (CA)** to apply for a [[Digital Certificate]]. It contains the applicant's [[Public Key Infrastructure|public key]], identifying information, and a digital signature proving possession of the corresponding [[Private Key]], enabling the CA to issue a trusted [[X.509 Certificate]] that binds an identity to a cryptographic key.

---

## Overview

A CSR serves as the formal application in the [[Public Key Infrastructure]] enrollment process. When an entity — whether a web server, a device, or a person — needs a certificate, it first generates a key pair using an asymmetric algorithm such as [[RSA]] or [[Elliptic Curve Cryptography|ECDSA]]. The private key never leaves the applicant's possession; instead, the public key is embedded in the CSR along with identity fields defined by the [[X.500]] Distinguished Name standard, including Common Name (CN), Organization (O), Organizational Unit (OU), Country (C), State (ST), and Locality (L).

The CSR format is standardized as **PKCS#10** (Public Key Cryptography Standard #10), defined in RFC 2986. The file is typically encoded in **DER** (Distinguished Encoding Rules, binary) or **PEM** (Privacy Enhanced Mail, Base64-encoded DER wrapped in `-----BEGIN CERTIFICATE REQUEST-----` headers). Most practitioners encounter CSRs in PEM format because it is human-readable and safe for email transmission. The CSR itself is not a certificate — it is simply an input to the CA's signing process.

Upon receiving a CSR, the CA performs **identity validation** according to its certificate policy. A Domain Validation (DV) CA may only verify DNS control, while an Extended Validation (EV) CA performs rigorous legal entity verification. If validation succeeds, the CA signs the applicant's public key and identity information using its own private key, producing a signed X.509 certificate. This chain of trust is the foundation of [[TLS/SSL]] security on the web and in enterprise networks.

CSRs are ubiquitous in enterprise environments. They are generated when provisioning HTTPS certificates for web servers ([[Apache HTTP Server|Apache]], [[Nginx]], IIS), configuring [[mutual TLS]] for API authentication, issuing certificates to VPN clients, code-signing certificates for software distribution, and enrolling devices in enterprise PKI through protocols such as [[SCEP]] (Simple Certificate Enrollment Protocol) and [[EST]] (Enrollment over Secure Transport). Understanding CSRs is therefore foundational to nearly all certificate lifecycle management activities.

---

## How It Works

### 1. Key Pair Generation

Before creating a CSR, the applicant generates an asymmetric key pair. The private key must be protected with strict file permissions or stored in hardware (an [[HSM]] or TPM).

```bash
# Generate a 4096-bit RSA private key
openssl genrsa -out server.key 4096

# Generate an ECDSA private key (P-256 curve — preferred for modern use)
openssl ecparam -name prime256v1 -genkey -noout -out server.key
```

### 2. Creating the CSR

The CSR is constructed by combining the public key extracted from the key pair with Distinguished Name fields and optional Subject Alternative Names (SANs), then signing the entire structure with the private key.

```bash
# Interactive CSR generation (prompts for DN fields)
openssl req -new -key server.key -out server.csr

# Non-interactive CSR with all fields inline
openssl req -new -key server.key -out server.csr \
  -subj "/C=US/ST=Virginia/L=Reston/O=YOUR-LAB Lab/OU=Infrastructure/CN=lab.cocytus.local"

# CSR with Subject Alternative Names (SANs) — critical for modern browsers
openssl req -new -key server.key -out server.csr \
  -subj "/CN=lab.cocytus.local" \
  -addext "subjectAltName=DNS:lab.cocytus.local,DNS:*.lab.cocytus.local,IP:192.168.10.1"
```

### 3. CSR Structure (PKCS#10)

The CSR contains three primary components as defined in RFC 2986:

```
CertificationRequest ::= SEQUENCE {
   certificationRequestInfo  CertificationRequestInfo,
   signatureAlgorithm        AlgorithmIdentifier,
   signature                 BIT STRING
}

CertificationRequestInfo ::= SEQUENCE {
   version       INTEGER { v1(0) },
   subject       Name,
   subjectPKInfo SubjectPublicKeyInfo,
   attributes    [0] IMPLICIT SET OF Attribute
}
```

### 4. Inspecting a CSR

Before submitting a CSR, always verify its contents:

```bash
# Human-readable decode
openssl req -in server.csr -text -noout

# Verify the CSR signature (proves private key possession)
openssl req -in server.csr -verify -noout

# Check specific fields with grep
openssl req -in server.csr -text -noout | grep -E "Subject:|DNS:|IP Address:"
```

### 5. Submitting to a CA

**Public CA (e.g., Let's Encrypt via ACME protocol):**
```bash
# Using certbot (ACME client) — CA validates DNS/HTTP challenge automatically
certbot certonly --standalone -d lab.example.com
```

**Internal CA (OpenSSL):**
```bash
# Sign the CSR with your internal CA (valid 365 days)
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
  -CAcreateserial -out server.crt -days 365 -sha256 \
  -extfile <(printf "subjectAltName=DNS:lab.cocytus.local")
```

**Microsoft AD CS (Active Directory Certificate Services):**
```powershell
# Submit CSR to enterprise CA via certreq
certreq -submit -attrib "CertificateTemplate:WebServer" server.csr server.crt
```

### 6. Certificate Deployment

```bash
# Verify certificate matches private key (modulus must match)
openssl rsa -noout -modulus -in server.key | openssl md5
openssl x509 -noout -modulus -in server.crt | openssl md5

# Configure Nginx with the issued certificate
server {
    listen 443 ssl;
    ssl_certificate     /etc/ssl/certs/server.crt;
    ssl_certificate_key /etc/ssl/private/server.key;
}
```

---

## Key Concepts

- **PKCS#10**: The standard format for CSRs, defined in RFC 2986. It specifies the ASN.1 structure containing the subject's DN, public key, optional attributes, and a self-signature. Virtually all CSRs encountered in practice conform to PKCS#10.

- **Distinguished Name (DN)**: The X.500 hierarchical naming structure embedded in a CSR's subject field. Key components are CN (Common Name — typically the FQDN), O (Organization), OU (Organizational Unit), C (two-letter country code), ST (State/Province), and L (Locality). Modern certificates increasingly rely on Subject Alternative Names rather than CN for hostname binding.

- **Subject Alternative Name (SAN)**: An X.509 v3 extension added to a CSR (and resulting certificate) that specifies additional valid identities — DNS names, IP addresses, email addresses, or URIs. Since 2017, major browsers have deprecated reliance on the CN field alone; SANs are now mandatory for proper hostname validation per RFC 6125.

- **Proof-of-Possession**: The self-signature on a CSR, created with the private key corresponding to the embedded public key, cryptographically proves the applicant possesses the private key. This prevents an attacker from submitting a CSR containing someone else's public key.

- **Certificate Template**: In Microsoft AD CS, a predefined policy object that specifies what type of certificate will be issued, which extensions are included, key usage attributes, validity period, and who is authorized to enroll. CSR attributes must match an available template for issuance to succeed.

- **PEM vs DER**: PEM (Privacy Enhanced Mail) encodes the binary DER format as Base64 with header/footer lines and is the most common format for files exchanged between systems. DER is the raw binary ASN.1 encoding used internally and by some Java-based systems. Both represent the same PKCS#10 structure.

- **CSR Attributes**: The optional `attributes` field in PKCS#10 can carry extension requests (such as requested key usages and SANs), challenge passwords (used by some CAs for revocation authentication), and unstructured names. Extension requests are the most practically important attribute.

---

## Exam Relevance

**SY0-701 Domain Mapping**: CSRs appear most prominently in **Domain 4.0 – Security Operations** (certificate management) and **Domain 1.0 – General Security Concepts** (PKI fundamentals).

**High-Frequency Exam Topics:**

- **CSR workflow sequence**: Know the exact order — *generate key pair → create CSR → submit to CA → CA validates → CA signs and returns certificate → install certificate*. Exam questions frequently test whether candidates know the CSR comes **before** the certificate is issued.

- **What the CSR contains**: The public key and identity information. The private key is **never** included in a CSR. Questions may try to trick you into selecting "private key" as a CSR component.

- **Who signs what**: The *applicant* signs the CSR (with their private key to prove possession). The *CA* signs the resulting certificate (with the CA's private key to establish trust). These are different signing operations.

- **PKCS standards**: Know PKCS#10 = CSR format. Related: PKCS#12 = certificate + private key bundle (.pfx/.p12), PKCS#7 = certificate chain format (.p7b).

- **RA vs CA distinction**: A **Registration Authority (RA)** may accept and validate CSRs but delegates the actual signing to the CA. The RA does not issue certificates itself.

**Common Gotchas:**

- SAN extension requests in a CSR do **not** guarantee the CA will honor them — the CA's policy (or certificate template) governs what extensions appear in the final certificate.
- A CSR has no validity period. Only the issued certificate has a validity window.
- "Self-signed certificate" means the entity acted as its own CA — the CSR's self-signature is not the same as a self-signed certificate.

---

## Security Implications

**Private Key Compromise During CSR Generation**: If the key pair is generated on an insecure system or the private key is transmitted alongside the CSR, an attacker who obtains the private key can impersonate the certificate holder entirely. This was exploited in cloud environments where private keys were inadvertently committed to source control repositories.

**Weak Key Parameters**: Historically, CSRs were generated with 512-bit or 1024-bit RSA keys, which are computationally feasible to factor. NIST SP 800-131A deprecated 1024-bit RSA in 2013. The **Debian OpenSSL vulnerability (CVE-2008-0166)** caused OpenSSL on Debian/Ubuntu systems to generate predictably weak keys due to a flawed random number seeder, compromising all CSRs and certificates generated on affected systems between 2006 and 2008. This resulted in a massive re-issuance exercise across the internet.

**CA Issuance Malpractice**: If a CA improperly validates a CSR, fraudulent certificates can be issued for domains or organizations the requester doesn't control. **Comodo (2011)** and **DigiNotar (2011)** suffered CA compromises where attackers obtained fraudulent certificates for high-value domains including `*.google.com` and `addons.mozilla.org`. DigiNotar's breach led to its complete distrust and bankruptcy.

**CSR Injection / Parameter Tampering**: In poorly implemented CA web interfaces, attackers have exploited insufficient input sanitization in DN fields — injecting null bytes (e.g., `evil.com\x00.legitimate.com`) to cause certificate CN to be parsed as `legitimate.com` by some certificate validation libraries (**Moxie Marlinspike's null-byte attack, BlackHat 2009**). Modern libraries and CAs validate against null bytes and other injection characters.

**Keyloggers and Memory Scraping During Key Generation**: On compromised endpoints, an attacker with kernel-level access can intercept the private key from memory during or immediately after key pair generation before it is written to disk, obtaining the key without ever accessing the key file.

**Orphaned CSRs**: CSRs submitted to public CAs but never completed leave a record of the applicant's intended domain and organizational structure in CA logs and [[Certificate Transparency]] logs, providing reconnaissance value to attackers.

---

## Defensive Measures

**Key Generation Security:**
- Generate key pairs on the system where the private key will ultimately reside — never generate keys on behalf of another system and transmit them.
- Use hardware-backed key generation ([[HSM]], TPM 2.0, or YubiKey) for high-value certificates. This ensures the private key is non-exportable.
- Enforce minimum key sizes: RSA ≥ 2048-bit (prefer 4096-bit for long-lived CAs), ECDSA P-256 or P-384 for TLS server certificates.

**CSR Validation Before Submission:**
```bash
# Always verify CSR contents before submitting
openssl req -in server.csr -text -noout | grep -A5 "Subject:"

# Confirm the signature is valid (private key matches)
openssl req -in server.csr -verify
```

**CA-Side Controls:**
- Implement **certificate policies** and **certificate templates** (AD CS) that restrict key usage, validity periods, and allowed SANs.
- Require multi-party approval for high-assurance certificate issuance.
- Log all CSR submissions and certificate issuances to a tamper-evident audit trail.
- Participate in [[Certificate Transparency]] — require SCTs (Signed Certificate Timestamps) in issued certificates so all issuances are publicly auditable.

**Private Key Protection:**
```bash
# Restrict private key file permissions (Linux)
chmod 600 /etc/ssl/private/server.key
chown root:ssl-cert /etc/ssl/private/server.key

# Encrypt private key with passphrase (for storage; automation requires passphrase-free keys or a secrets manager)
openssl rsa -aes256 -in server.key -out server.key.enc
```

**Organizational Policy:**
- Maintain a **certificate inventory** tracking all outstanding CSRs, issued certificates, expiry dates, and responsible owners. Tools: [[HashiCorp Vault]], Venafi, Keyfactor, or a self-hosted CMDB.
- Define a **certificate lifecycle policy** specifying who can request certificates, for what purposes, using which CA, with what key parameters.
- Implement automated renewal ([[ACME protocol]], Certbot, cert-manager in Kubernetes) to reduce manual processes that introduce human error.
- Monitor [[Certificate Transparency]] logs (crt.sh, Facebook CT Monitor) for unauthorized certificate issuances for your domains.

---

## Lab / Hands-On

### Lab 1: Build a Full CSR-to-Certificate Chain with OpenSSL

```bash
# Step 1: Create a simple internal CA
mkdir -p ~/pki/{ca,server}
cd ~/pki/ca

# Generate CA private key
openssl genrsa -aes256 -out ca.key 4096

# Generate self-signed CA certificate (valid 10 years)
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt \
  -subj "/C=US/ST=Virginia/O=YOUR-LAB Lab CA/CN=YOUR-LAB Root CA"

# Step 2: Generate server key and CSR
cd ~/pki/server
openssl genrsa -out server.key 4096

openssl req -new -key server.key -out server.csr \
  -subj "/C=US/ST=Virginia/O=YOUR-LAB Lab/CN=homelab.cocytus.local" \
  -addext "subjectAltName=DNS:homelab.cocytus.local,DNS:*.homelab.cocytus.local