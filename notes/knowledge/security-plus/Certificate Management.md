---
domain: "Cryptography & PKI"
tags: [certificates, pki, tls, x509, cryptography, security-operations]
---
# Certificate Management

**Certificate management** is the process of creating, issuing, deploying, renewing, revoking, and auditing **digital certificates** within a [[Public Key Infrastructure (PKI)]]. These certificates, typically conforming to the **X.509 standard**, bind cryptographic public keys to identities (users, servers, devices) and are signed by a trusted [[Certificate Authority (CA)]]. Effective certificate management is critical for maintaining encrypted communications, establishing trust, and preventing service outages caused by expired or compromised certificates.

---

## Overview

Digital certificates are the cornerstone of authenticated, encrypted communication on the internet and inside enterprise networks. A certificate acts as a cryptographically verifiable identity document: it contains a subject's public key, identifying information, validity period, and a digital signature from a trusted CA. When a browser connects to an HTTPS website, the server presents its certificate, the browser verifies the CA's signature against its trusted root store, and a [[TLS Handshake]] is completed — all without prior knowledge of the server.

The lifecycle of a certificate is a structured pipeline with well-defined stages. It begins with key generation and a **Certificate Signing Request (CSR)**, proceeds through CA validation and issuance, deployment onto endpoints and services, ongoing monitoring for expiration, and eventually revocation or renewal. In large organizations, thousands of certificates may be active simultaneously across web servers, load balancers, email gateways, VPN endpoints, code-signing pipelines, and client authentication systems. Without automated tooling, manual management quickly becomes unmanageable and error-prone.

Certificate mismanagement is responsible for a significant category of real-world security incidents. Expired certificates have caused outages at major services including LinkedIn, Spotify, and even government infrastructure. Unrevoked certificates belonging to terminated employees or decommissioned servers represent persistent attack surfaces. More critically, a compromised or rogue CA can issue fraudulent certificates enabling [[Man-in-the-Middle (MitM) Attack]]s that are nearly impossible for end users to detect without additional mechanisms like [[Certificate Transparency]] or [[HTTP Public Key Pinning (HPKP)]].

Enterprise certificate management generally distinguishes between **public-facing certificates** (issued by globally trusted commercial CAs such as DigiCert, Sectigo, or Let's Encrypt) and **internal certificates** (issued by a private CA operated by the organization, using tools like Microsoft Active Directory Certificate Services or HashiCorp Vault). Internal PKI allows organizations to issue certificates for internal hostnames, devices, and service accounts that would not be eligible for public CA issuance, but it requires careful root trust distribution so all clients trust the internal CA.

Modern certificate management is increasingly driven toward automation using the **ACME protocol** (RFC 8555), which allows clients to automatically prove domain control and obtain certificates without human intervention. Let's Encrypt pioneered this approach and now issues the majority of publicly trusted TLS certificates. Within enterprises, platforms like Venafi, Keyfactor, and HashiCorp Vault PKI provide centralized discovery, issuance, and renewal orchestration across heterogeneous environments.

---

## How It Works

### 1. Key Generation

The certificate lifecycle begins with generating an asymmetric key pair. The private key must never leave the requesting system unprotected.

```bash
# Generate a 2048-bit RSA private key
openssl genrsa -out server.key 2048

# Generate a 4096-bit RSA private key (stronger, slower)
openssl genrsa -out server.key 4096

# Generate an ECDSA P-256 key (modern, smaller, faster)
openssl ecparam -name prime256v1 -genkey -noout -out server-ec.key
```

### 2. Certificate Signing Request (CSR)

The CSR packages the public key with subject identity information and is sent to a CA for signing. The CA never receives the private key.

```bash
# Generate a CSR interactively
openssl req -new -key server.key -out server.csr

# Generate a CSR non-interactively with Subject Alternative Names (SANs)
openssl req -new -key server.key -out server.csr \
  -subj "/C=US/ST=Virginia/L=McLean/O=COCYTUS Lab/CN=lab.cocytus.local" \
  -addext "subjectAltName=DNS:lab.cocytus.local,DNS:www.lab.cocytus.local,IP:10.0.0.10"

# Inspect a CSR before submission
openssl req -text -noout -verify -in server.csr
```

### 3. CA Signing and Issuance

A **self-signed CA** (for lab/internal use) or commercial CA signs the CSR, producing a certificate. The CA attaches its digital signature using its private key — this is what establishes the chain of trust.

```bash
# Create a self-signed root CA certificate (10-year validity)
openssl req -x509 -newkey rsa:4096 -keyout ca.key -out ca.crt \
  -days 3650 -nodes \
  -subj "/C=US/O=COCYTUS Internal CA/CN=COCYTUS Root CA"

# Sign a CSR with your CA (issue a 1-year certificate)
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
  -CAcreateserial -out server.crt -days 365 \
  -extensions v3_req -extfile san.ext
```

The `san.ext` file for Subject Alternative Names:
```ini
[v3_req]
subjectAltName = DNS:lab.cocytus.local, IP:10.0.0.10
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
```

### 4. Certificate Deployment

Certificates must be deployed to the correct service with proper chain inclusion:

```bash
# Verify a certificate and its chain
openssl verify -CAfile ca.crt server.crt

# Inspect certificate content (expiration, SANs, issuer)
openssl x509 -in server.crt -text -noout

# Test a live TLS endpoint
openssl s_client -connect lab.cocytus.local:443 -showcerts

# Check certificate expiration date only
openssl x509 -enddate -noout -in server.crt

# Check expiration of a live host
echo | openssl s_client -connect example.com:443 2>/dev/null \
  | openssl x509 -noout -dates
```

### 5. Renewal and Revocation

**Renewal** should occur before expiration — typically 30–90 days prior. **Revocation** is the invalidation of a certificate before its natural expiration and is communicated via:

- **CRL (Certificate Revocation List)**: A periodically published signed list of revoked serial numbers. Downloaded at intervals — has latency.
- **OCSP (Online Certificate Status Protocol)**: Real-time revocation query over HTTP, port **80**. The CA responds with "good," "revoked," or "unknown."
- **OCSP Stapling**: The server pre-fetches and caches its own OCSP response, reducing client-CA round trips and improving privacy.

```bash
# Revoke a certificate using OpenSSL CA
openssl ca -revoke compromised.crt -keyfile ca.key -cert ca.crt

# Generate an updated CRL
openssl ca -gencrl -keyfile ca.key -cert ca.crt -out ca.crl

# Query OCSP manually
openssl ocsp -issuer ca.crt -cert server.crt \
  -url http://ocsp.example.com -resp_text
```

### 6. ACME Automation (Let's Encrypt)

```bash
# Install Certbot and obtain a certificate with auto-renewal
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

# Test renewal process
sudo certbot renew --dry-run

# Certificates stored in: /etc/letsencrypt/live/yourdomain.com/
```

ACME uses HTTP-01 (port 80 token challenge), DNS-01 (TXT record challenge), or TLS-ALPN-01 (port 443) to prove domain ownership before issuance.

---

## Key Concepts

- **X.509**: The ITU-T standard defining the format of public key certificates. Every TLS certificate is an X.509 v3 certificate containing fields like Subject, Issuer, Serial Number, Validity, Public Key, and Extensions (SANs, Key Usage, CRL/OCSP URLs).

- **Chain of Trust**: The hierarchical model where a **Root CA** (self-signed, stored in OS/browser trust stores) signs **Intermediate CA** certificates, which in turn sign **End-Entity (leaf) certificates**. Root CA private keys are kept offline — compromise would be catastrophic.

- **Certificate Revocation**: The process of invalidating a certificate before expiration due to key compromise, CA compromise, or change in affiliation. Implemented via **CRL** (batch, file-based) or **OCSP** (real-time, protocol-based). Neither is perfectly reliable — browsers increasingly use "soft-fail" behavior and Google's CRLSets as alternatives.

- **Certificate Pinning**: A technique where an application hard-codes the expected certificate or public key hash, rejecting any certificate — even a validly signed one — that does not match. Prevents CA-based MitM attacks but creates operational fragility during legitimate certificate rotation.

- **Subject Alternative Names (SANs)**: X.509 v3 extension that specifies additional identities a certificate is valid for — additional hostnames, IP addresses, email addresses, or URIs. The **Common Name (CN) field is deprecated** for hostname validation; SANs are the authoritative field per RFC 2818.

- **Certificate Transparency (CT)**: A public, append-only log system (RFC 6962) where CAs are required to submit all issued certificates. Browsers like Chrome require CT compliance. Enables detection of mis-issued or fraudulent certificates. Logs are operated by Google, Cloudflare, DigiCert, and others.

- **PKCS Standards**: A family of cryptography standards relevant to certificates: **PKCS#10** defines the CSR format; **PKCS#12 (.p12/.pfx)** bundles a certificate, chain, and private key in a password-protected file; **PKCS#7 (.p7b)** bundles certificates without private keys; **PEM** format uses Base64 with `-----BEGIN CERTIFICATE-----` headers and is the most common.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Certificate Management falls primarily under **Domain 1: General Security Concepts** (1.4 – Cryptographic Solutions) and **Domain 4: Security Operations** (4.1 – Security Techniques).

**High-frequency exam topics and gotchas:**

- **Know the difference between CRL and OCSP**: CRL is a file downloaded periodically (has latency, can be stale). OCSP is a real-time protocol query. OCSP Stapling moves the OCSP query to the server side. Questions often test which provides the most *current* revocation status — the answer is **OCSP**.

- **Certificate pinning vs. Certificate stapling**: These sound similar but are different. *Pinning* = client locks to a specific cert/key. *Stapling* = server attaches a pre-fetched OCSP response to the TLS handshake.

- **Wildcard certificates**: A wildcard like `*.example.com` covers one subdomain level only (e.g., `mail.example.com`) but NOT `deep.mail.example.com`. A wildcard cannot cover the apex domain `example.com` by itself.

- **Self-signed vs. CA-signed**: Self-signed certificates generate browser warnings because they aren't in the trust store. They are valid for internal/lab use if the CA cert is distributed to clients. Exam questions about "untrusted certificate" warnings in a *new internal deployment* often point to missing CA trust distribution, not a broken certificate.

- **Key escrow vs. Key archival**: Key escrow = third-party holds keys (often for legal intercept). Key archival = backup of encryption keys for recovery. Both relate to certificate management but are distinct concepts.

- **Certificate Attributes**: Know what's in a certificate: Version, Serial Number, Signature Algorithm, Issuer, Validity (Not Before/Not After), Subject, Subject Public Key Info, and Extensions. The exam may present a certificate field and ask what it represents.

- **RA (Registration Authority)**: Handles identity verification on behalf of the CA but does not issue certificates directly. Offloads the vetting workload from the CA itself.

- **Common trick question**: A certificate with an expired date on a *client machine with a wrong system clock* will appear invalid even if the cert is fine. Always verify system time when troubleshooting certificate errors.

---

## Security Implications

### Expired Certificates
Expired certificates cause service outages and are a common negligence finding in security audits. In 2020, Microsoft Teams suffered a multi-hour global outage due to an expired authentication certificate. In 2021, the root certificate expiry of IdenTrust's DST Root CA X3 broke HTTPS on older Android devices that had not updated their trust stores.

### Rogue Certificate Issuance
In 2011, the Dutch CA **DigiNotar** was compromised and attackers issued fraudulent certificates for `*.google.com`, `*.mozilla.com`, and hundreds of other high-value domains. This enabled real-world MitM attacks against Iranian users. DigiNotar was subsequently removed from all major trust stores and went bankrupt. This incident directly motivated the development of **Certificate Transparency**.

In 2015, CNNIC (China Internet Network Information Center) and an intermediate CA it operated (MCS Holdings) issued unauthorized certificates for Google domains. CNNIC was removed from Chrome and Firefox trust stores.

### Private Key Compromise
If a certificate's private key is leaked (e.g., accidentally committed to a public GitHub repository, exposed via [[Heartbleed]] CVE-2014-0160), the certificate must be immediately revoked and reissued. Heartbleed allowed extraction of private keys from vulnerable OpenSSL implementations without leaving a trace.

### Weak Key Parameters
Certificates using RSA keys smaller than 2048 bits or MD5/SHA-1 signature algorithms are considered cryptographically weak. The **FREAK attack** (CVE-2015-0204) and **DROWN attack** (CVE-2016-0800) exploited weak export-grade cipher configurations tied to certificate handling.

### Certificate Misconfiguration
- Missing SANs causing hostname validation failure
- Certificates deployed on wrong servers
- Incomplete certificate chains (missing intermediate) causing validation failures in some clients
- Overly broad wildcards increasing blast radius of compromise

### Shadow IT / Unmanaged Certificates
Certificates provisioned outside central management (shadow IT) are frequently forgotten, expire unexpectedly, or use weak parameters. Unauthorized internal CAs can issue certificates that bypass corporate security controls.

---

## Defensive Measures

### Automated Certificate Lifecycle Management
Deploy a Certificate Lifecycle Management (CLM) platform to maintain a complete inventory:
- **HashiCorp Vault PKI Secrets Engine**: Full-featured internal CA with short-lived certificate issuance (minutes to days), automatic revocation, and REST API integration.
- **Venafi** / **Keyfactor**: Enterprise CLM platforms providing discovery across network endpoints, policy enforcement, and automated renewal.
- **Certbot with systemd timers**: For Let's Encrypt automation on Linux systems.

### Certificate Inventory and Discovery
```bash
# Scan network for certificates using nmap
nmap -p 443,8443,8080 --script ssl-cert 192.168.1.0/24

# Use Masscan for faster large-scale discovery
masscan -p443 10.0.0.0/8 --rate=1000

# Check certificate expiration across multiple hosts (bash loop)
for host in web01 web02 mail01; do
  echo -n "$host: "
  echo | openssl s_client -connect ${host}:443 2>/dev/null \
    | openssl x509 -noout -enddate 2>/dev/null
done
```

### Certificate Monitoring
- Configure **certificate expiration alerts** at 90, 60, and 30 days before expiry.
- Use **Certificate Transparency monitoring** via tools like [crt.sh](https://crt.sh) or Cert Spotter to detect unauthorized certificate issuance for your domains.
- Implement