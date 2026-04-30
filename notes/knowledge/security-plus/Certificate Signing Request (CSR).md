---
domain: "cryptography"
tags: [pki, certificates, tls, authentication, openssl, asymmetric-cryptography]
---
# Certificate Signing Request (CSR)

A **Certificate Signing Request (CSR)** is a block of encoded text submitted to a **Certificate Authority (CA)** to apply for a [[Digital Certificate|digital certificate]]. It contains the applicant's [[Public Key Infrastructure|public key]] and identifying information, and is cryptographically signed with the corresponding private key to prove the requester controls it. CSRs are a foundational component of [[Public Key Infrastructure (PKI)]] and enable the [[TLS/SSL]] protocol to authenticate servers, clients, and services on the internet.

---

## Overview

The CSR mechanism was formalized in the **PKCS #10** standard (RFC 2986), defining a structured format for certificate requests. When an entity—such as a web server, VPN gateway, or email server—needs a certificate, it generates a public/private key pair locally. The private key never leaves the requester's system. The CSR packages the public key along with identification fields (called the **Distinguished Name** or DN) into a standardized format and signs the entire structure with the private key, cryptographically proving the requester possesses the private key that corresponds to the embedded public key.

Certificate Authorities receive the CSR and perform **domain validation (DV)**, **organization validation (OV)**, or **extended validation (EV)** procedures depending on the certificate type requested. During DV, the CA may verify ownership by checking DNS TXT records, HTTP challenge files, or email confirmation. For OV and EV, manual vetting of legal business identity is required. Once the CA is satisfied, it signs the certificate with its own private key, binding the requester's identity to their public key and producing a trusted [[X.509]] certificate.

CSRs are encoded in one of two formats: **PEM** (Privacy Enhanced Mail, Base64-encoded, surrounded by `-----BEGIN CERTIFICATE REQUEST-----` headers) or **DER** (Distinguished Encoding Rules, binary format). PEM is most common in Unix/Linux environments and web server configurations. Both formats carry identical data; the difference is purely encoding. Most tools including OpenSSL, Windows CertReq, and Java Keytool can interconvert them.

In enterprise environments, CSRs flow through internal **private CAs**—such as Microsoft Active Directory Certificate Services (AD CS) or HashiCorp Vault—rather than public CAs like DigiCert or Let's Encrypt. This allows organizations to issue certificates for internal services that wouldn't qualify for public trust. Internal PKI is critical for mutual TLS authentication, VPN certificates, S/MIME email signing, and code signing. Understanding CSR workflow is therefore essential both for public-facing HTTPS infrastructure and private enterprise security operations.

The CSR does **not** contain the private key, expiration dates, or validity period—those elements are determined and added by the CA during certificate issuance. The CA may also alter some fields, such as replacing a requested validity period with one compliant with its own policy (e.g., browser-trusted CAs cap TLS certificates at 398 days per CA/Browser Forum requirements).

---

## How It Works

### Step-by-Step CSR Lifecycle

**1. Generate a Private Key and CSR**

Using OpenSSL (the most common tool), generate a 2048-bit or 4096-bit RSA private key and CSR simultaneously:

```bash
# Generate private key and CSR in one command
openssl req -new -newkey rsa:4096 -nodes -keyout server.key -out server.csr

# You will be prompted for Distinguished Name fields:
# Country Name (2 letter code) [AU]: US
# State or Province Name (full name): California
# Locality Name (city): San Francisco
# Organization Name: ACME Corporation
# Organizational Unit Name: IT Security
# Common Name (FQDN): www.acmecorp.com
# Email Address: admin@acmecorp.com
# Challenge password: (leave blank for automated submission)
```

**2. Generate from an Existing Private Key**

If you already have a private key:

```bash
openssl req -new -key existing.key -out server.csr
```

**3. Use a Configuration File for SANs (Subject Alternative Names)**

Modern certificates require SANs for all hostnames. Create `csr.conf`:

```ini
[req]
default_bits       = 4096
prompt             = no
default_md         = sha256
distinguished_name = dn
req_extensions     = req_ext

[dn]
C  = US
ST = California
L  = San Francisco
O  = ACME Corporation
OU = IT Security
CN = www.acmecorp.com

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = www.acmecorp.com
DNS.2 = acmecorp.com
DNS.3 = api.acmecorp.com
IP.1  = 192.168.10.50
```

Generate with config file:

```bash
openssl req -new -key server.key -out server.csr -config csr.conf
```

**4. Inspect the CSR Contents**

Before submitting, always verify the CSR contains correct information:

```bash
openssl req -text -noout -verify -in server.csr
```

Output will show:
- Subject (DN fields)
- Public key algorithm and size
- Signature algorithm used to sign the CSR
- Extensions requested (SANs)
- Verification: `verify OK` confirms the CSR signature is valid

**5. Submit to a Certificate Authority**

For a **public CA** (e.g., DigiCert, Sectigo), paste the contents of `server.csr` into the CA's web portal. For an **internal CA** using OpenSSL:

```bash
# Sign the CSR with your internal CA (produces the certificate)
openssl x509 -req -in server.csr \
  -CA ca.crt -CAkey ca.key \
  -CAcreateserial \
  -out server.crt \
  -days 365 \
  -sha256 \
  -extfile csr.conf \
  -extensions req_ext
```

For **Windows AD CS** environments, use `certreq`:

```powershell
# Submit CSR to AD CS
certreq -submit -config "CA-Server\CA-Name" server.csr server.crt

# Or request via web enrollment
# https://ca-server/certsrv
```

**6. Install the Signed Certificate**

After the CA returns the signed `.crt` file, install it on the server:

```bash
# Verify the certificate matches the private key (modulus must match)
openssl rsa -noout -modulus -in server.key | openssl md5
openssl x509 -noout -modulus -in server.crt | openssl md5
# Both hashes must be identical

# Configure in Nginx
server {
    listen 443 ssl;
    ssl_certificate     /etc/ssl/certs/server.crt;
    ssl_certificate_key /etc/ssl/private/server.key;
}
```

### CSR Structure (ASN.1 / PKCS #10)

A CSR has three components per RFC 2986:
1. **CertificationRequestInfo** – Subject DN, public key, optional attributes (SANs live here as extensions)
2. **signatureAlgorithm** – Algorithm used to sign the request (e.g., `sha256WithRSAEncryption`)
3. **signature** – Digital signature over CertificationRequestInfo using the private key

---

## Key Concepts

- **Distinguished Name (DN):** A structured identifier embedded in the CSR consisting of Country (C), State (ST), Locality (L), Organization (O), Organizational Unit (OU), and Common Name (CN). The CN for web server certificates should be the fully qualified domain name (FQDN), though modern practice relies on SANs instead of CN for hostname validation.

- **Subject Alternative Name (SAN):** An X.509 extension that lists additional hostnames, IP addresses, email addresses, or URIs the certificate should be valid for. Since 2017, browsers ignore the CN field for hostname validation and rely exclusively on SANs. Any CSR for a public TLS certificate must include SANs.

- **PKCS #10:** The cryptographic standard (RFC 2986) defining the CSR format. It specifies the ASN.1 structure, required fields, and signature requirements. Also referred to as a "certification request message format."

- **Key Pair Generation:** The CSR process requires generating an asymmetric key pair. The **private key** must be generated and stored securely by the requester and never transmitted; the **public key** is embedded in the CSR. RSA 2048-bit is the minimum acceptable size; RSA 4096-bit or ECDSA P-256/P-384 are recommended for new deployments.

- **Certificate Authority (CA) Signing:** The CA validates the identity claims in the CSR and, if satisfied, produces an [[X.509]] certificate by signing the requester's public key and DN with the CA's own private key. This CA signature is what establishes trust in the resulting certificate.

- **PEM vs DER Encoding:** PEM format (Base64 + ASCII headers) is human-readable and commonly used in Linux/Apache/Nginx environments. DER format is binary and common in Windows and Java environments. OpenSSL can convert between them: `openssl req -in server.csr -out server.der -outform DER`

- **Certificate Transparency (CT):** When public CAs sign certificates, they submit them to CT logs (RFC 6962). This means certificates issued from your CSR become publicly visible. Attackers can mine CT logs to enumerate subdomains and infrastructure—a technique used in OSINT and reconnaissance.

---

## Exam Relevance

**Security+ SY0-701 Domain Mapping:** CSRs fall under Domain 3.0 (Implementation) — specifically 3.3 (Implement and configure wireless security settings) and 3.9 (Implement public key infrastructure).

**High-Probability Exam Topics:**

- **Know the CSR workflow sequence:** Key pair generation → CSR creation → CA submission → validation → certificate issuance → installation. The exam may present this as a drag-and-drop ordering question.

- **Understand what a CSR contains vs. what it does NOT contain:** A CSR contains the public key, DN fields, and optionally requested extensions. It does **not** contain the private key, validity dates, serial number, or the CA's signature—those are added by the CA.

- **RA vs. CA distinction:** A **Registration Authority (RA)** accepts and validates CSRs but does not sign certificates—it passes validated requests to the CA. The CA performs the actual signing. Exam questions may test whether you know which entity performs which function.

- **PKCS standards confusion:** Know that CSRs use **PKCS #10**. PKCS #12 is for exporting certificates with private keys (.pfx/.p12 files). PKCS #7 is for certificate chains. These are commonly confused in exam scenarios.

- **Common Name vs. SAN:** Exam questions may ask about certificate errors where the CN matches but the browser still rejects it—the answer is missing or incorrect SANs.

- **Self-signed certificates:** If an entity signs its own CSR (skipping an external CA), the result is a self-signed certificate. These generate browser warnings because no trusted third party has vouched for the identity. This is acceptable for internal testing but not production public-facing services.

**Gotcha:** The exam sometimes phrases questions around *who* generates the CSR. The answer is always the **requester (server owner)**, not the CA. The CA only receives and processes it.

---

## Security Implications

### Private Key Compromise
If an attacker obtains the private key associated with a submitted CSR, they can impersonate the server for the entire certificate lifetime. This risk is heightened when CSRs and private keys are generated on insecure systems or transmitted insecurely. The 2011 **DigiNotar breach** demonstrated how CA compromise allows fraudulent certificates to be issued for arbitrary CSRs, enabling man-in-the-middle attacks against Google, intelligence agencies, and others—affecting 300,000+ Iranian users.

### Weak Key Generation
CSRs generated with weak parameters are a systemic vulnerability. The **ROCA vulnerability (CVE-2017-15361)** affected Infineon TPM chips that generated RSA keys with a predictable prime pattern—meaning private keys could be factored from the public key embedded in the CSR. Approximately 760,000 certificates issued by Estonian government ID systems were affected.

### CSR Injection / Attribute Manipulation
Malicious actors have exploited insufficient validation of CSR fields to inject special characters into DN fields, causing issues in CA web interfaces (XSS, LDAP injection, SQL injection). Always validate and sanitize CSR content before processing in CA software.

### BGP Hijacking for DV Validation
Domain Validation relies on controlling DNS or HTTP endpoints. In 2018, attackers used BGP route hijacking to redirect DNS for MyEtherWallet, effectively stealing domain control and enabling fraudulent DV certificate issuance. This demonstrates that DV validation, while convenient, has systemic weaknesses.

### Certificate Transparency Log Exposure
Every public certificate issued from a CSR is logged in CT logs (crt.sh, Google Transparency Report). Attackers actively monitor these logs to identify new subdomains, staging environments, and internal hostnames accidentally exposed through public certificate issuance—enabling targeted reconnaissance and attack planning.

### Forgotten/Orphaned CSRs
Organizations often generate multiple CSRs for the same domain during reissue cycles and lose track of which private keys correspond to which deployed certificates. This creates operational security debt and complicates incident response when a certificate needs emergency revocation.

---

## Defensive Measures

### Key Protection
- Generate private keys only on the target system or a Hardware Security Module ([[HSM]]). Never generate keys on a CA or intermediate system.
- Use HSMs (YubiHSM, Thales, AWS CloudHSM) for production certificate private keys to make key extraction physically resistant.
- Enforce strict file permissions: `chmod 600 server.key` and root-only ownership.

### Key Size and Algorithm Policy
- Enforce minimum RSA 2048-bit; prefer 4096-bit or ECDSA P-256/P-384 for new issuance.
- Reject CSRs using MD5 or SHA-1 signatures in CA policy configurations.
- Use AD CS issuance policy templates to enforce key requirements organizationally.

### Certificate Lifecycle Management
- Deploy a certificate management platform (Venafi, Keyfactor, HashiCorp Vault, or ACME-based automation via Certbot/cert-manager).
- Maintain an inventory mapping every certificate to its private key, issuing CA, expiry date, and responsible owner.
- Automate renewal with ACME protocol (Let's Encrypt) to eliminate manual CSR processes for DV certificates.

### Internal CA Hardening
- Implement AD CS security hardening per Microsoft and SpecterOps guidance—disable Web Enrollment unless necessary, audit certificate templates for dangerous configurations (ESC1–ESC8 attack paths).
- Require manager approval for certificate templates that allow Subject Alternative Names to be specified by the requester (prevents privilege escalation via certificate enrollment).
- Enable CA audit logging and forward to SIEM.

### CT Log Monitoring
- Use services like Facebook Certificate Transparency (cert.sh, Cloudflare's CT monitor) to receive alerts when certificates are issued for your domains—detecting unauthorized certificate issuance.
- Implement [[DNS CAA Records]] (`dig CAA acmecorp.com`) to restrict which CAs may issue certificates for your domains, reducing risk from CA compromise.

### Validation Practices
- Use OV or EV certificates for externally facing infrastructure where organization identity matters.
- Verify CSR content before submission: confirm correct CN, SANs, key size, and signing algorithm.
- Cross-check that the certificate returned from the CA matches the original CSR before deployment.

---

## Lab / Hands-On

### Lab 1: Full CSR Lifecycle with OpenSSL (Self-Signed CA)

```bash
# Step 1: Create a local CA
mkdir -p ~/pki/{ca,server}
cd ~/pki/ca

# Generate CA private key
openssl genrsa -aes256 -out ca.key 4096

# Generate CA self-signed certificate (10 year validity)
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt \
  -subj "/C=US/ST=Lab/O=YOUR-LAB Lab CA/CN=YOUR-LAB Root CA"

# Step 2: Generate