---
domain: "cryptography"
tags: [pki, certificates, trust, authentication, tls, cryptography]
---

# Certificate Authority (CA)

A **Certificate Authority (CA)** is a trusted entity responsible for issuing, signing, revoking, and managing [[Digital Certificate|digital certificates]] that bind cryptographic public keys to verified identities. CAs form the backbone of [[Public Key Infrastructure (PKI)]], enabling secure communications over untrusted networks by establishing a chain of trust. Without CAs, systems like [[TLS/SSL]] would be unable to cryptographically verify that a web server, email address, or user is who they claim to be.

---

## Overview

Certificate Authorities exist because asymmetric cryptography alone cannot solve the problem of identity verification. Any party can generate a public/private key pair and claim any identity — the CA solves this by acting as a trusted third party that verifies an entity's identity before signing a certificate that binds a public key to that identity. When a browser connects to `https://example.com`, it verifies that the server's certificate was signed by a CA it already trusts, completing the cryptographic handshake.

CAs operate within a hierarchical model. At the top sits the **Root CA**, which is self-signed and serves as the ultimate anchor of trust. Root CA certificates are embedded directly into operating systems, browsers, and applications — the Mozilla Root Program, Microsoft Root Certificate Program, and Apple Root Program independently curate these lists. Because the Root CA's private key compromise would be catastrophic, Root CAs are typically kept **offline** (air-gapped), and day-to-day certificate issuance is delegated to **Intermediate CAs** (also called Subordinate CAs). This creates a **certificate chain** (or **chain of trust**): Root CA → Intermediate CA → End-Entity Certificate.

The global public CA ecosystem is operated by a relatively small number of commercial entities such as DigiCert, Sectigo, GlobalSign, and Let's Encrypt. Let's Encrypt, operated by the Internet Security Research Group (ISRG), democratized TLS by providing free, automated, domain-validated certificates and now issues over 300 million certificates. Browsers only trust certificates issued by CAs in their root store, which is why self-signed certificates generate warnings — they have no third-party attestation.

Organizations also operate **Private (Internal) CAs** for their own infrastructure. Tools like Microsoft Active Directory Certificate Services (AD CS), HashiCorp Vault PKI, and open-source solutions like Step-CA or Easy-RSA allow enterprises to issue certificates for internal servers, VPN clients, code signing, and user authentication without relying on public CAs. Internal CAs must be distributed to endpoints via Group Policy, MDM profiles, or configuration management tools so that clients can validate the chain of trust.

Certificate issuance involves multiple **validation levels** that reflect how thoroughly the CA verified the requester's identity. **Domain Validation (DV)** only confirms domain control, **Organization Validation (OV)** additionally verifies the legal entity, and **Extended Validation (EV)** involves a rigorous vetting process and historically triggered the "green bar" in browsers. While EV has lost its visual distinction in modern browsers, it still provides stronger identity assurance and is used by high-value targets like financial institutions.

---

## How It Works

### Certificate Lifecycle: From Request to Trust

#### 1. Key Generation and CSR Creation

The entity requesting a certificate generates a public/private key pair and creates a **Certificate Signing Request (CSR)**. The CSR contains the public key, requested identity information (Common Name, SANs, Organization), and a signature made with the private key to prove possession.

```bash
# Generate a 4096-bit RSA private key
openssl genrsa -out server.key 4096

# Generate a CSR for a web server
openssl req -new -key server.key -out server.csr \
  -subj "/C=US/ST=California/O=Example Corp/CN=www.example.com"

# View the CSR contents
openssl req -text -noout -in server.csr
```

#### 2. Submission and Validation

The CSR is submitted to the CA (via HTTPS portal, ACME protocol, or proprietary API). The CA performs identity validation:

- **DV**: Validates domain control via DNS TXT record, HTTP file challenge (ACME), or email to admin@domain
- **OV/EV**: CA staff verify business registration, legal existence, and authorization

```bash
# Automated DV via ACME protocol using Certbot (Let's Encrypt)
certbot certonly --standalone -d example.com -d www.example.com

# DNS challenge for wildcard certificates
certbot certonly --manual --preferred-challenges dns \
  -d *.example.com
```

#### 3. Certificate Signing

The CA signs the validated CSR using its private key (typically the Intermediate CA's key), producing an X.509 v3 certificate. The certificate encodes:

- **Subject**: The entity's identity
- **Issuer**: The CA's Distinguished Name
- **Validity Period**: Not Before / Not After timestamps
- **Public Key**: The subject's public key
- **Extensions**: Subject Alternative Names (SANs), Key Usage, Extended Key Usage, CRL Distribution Points, OCSP URLs
- **Signature**: CA's digital signature over the entire certificate content

```bash
# Sign a CSR with your own CA (for internal PKI)
openssl x509 -req -in server.csr \
  -CA ca.crt -CAkey ca.key -CAcreateserial \
  -out server.crt -days 365 -sha256 \
  -extfile v3.ext

# v3.ext contents for SAN support:
# authorityKeyIdentifier=keyid,issuer
# basicConstraints=CA:FALSE
# keyUsage = digitalSignature, nonRepudiation, keyEncipherment
# subjectAltName = @alt_names
# [alt_names]
# DNS.1 = example.com
# DNS.2 = www.example.com
```

#### 4. Certificate Distribution and Installation

The signed certificate is returned to the requester and installed on the relevant service (web server, mail server, etc.).

```bash
# Inspect a deployed certificate
openssl s_client -connect example.com:443 -showcerts </dev/null 2>/dev/null \
  | openssl x509 -text -noout

# Check certificate expiration
openssl x509 -enddate -noout -in server.crt

# Verify certificate chain
openssl verify -CAfile ca-chain.crt server.crt
```

#### 5. Revocation

If a certificate is compromised or no longer valid, the CA revokes it. Clients check revocation status via:

- **CRL (Certificate Revocation List)**: Periodically downloaded list of revoked serial numbers, distributed via HTTP on port **80**
- **OCSP (Online Certificate Status Protocol)**: Real-time per-certificate query, port **80** (HTTP), operated by the CA's OCSP responder
- **OCSP Stapling**: Server pre-fetches OCSP response and staples it to the TLS handshake, improving privacy and performance

```bash
# Check OCSP status manually
openssl ocsp -issuer intermediate.crt -cert server.crt \
  -url http://ocsp.example-ca.com -resp_text

# Check CRL
openssl crl -in revoked.crl -text -noout
```

#### Relevant Ports and Protocols

| Protocol | Port | Purpose |
|----------|------|---------|
| HTTPS (certificate download) | 443/TCP | CA web portals, ACME |
| HTTP (CRL/OCSP) | 80/TCP | Revocation checking |
| LDAP (CRL distribution) | 389/TCP | Enterprise CRL retrieval |
| EST (RFC 7030) | 443/TCP | Automated certificate enrollment |
| SCEP | 80 or 443 | Network device enrollment |

---

## Key Concepts

- **Root CA**: The self-signed, top-level CA whose certificate is embedded in trust stores. Its private key must be protected with extreme rigor — typically stored offline in an HSM with M-of-N key ceremony procedures. Compromise of the Root CA invalidates the entire PKI hierarchy beneath it.

- **Intermediate CA (Subordinate CA)**: A CA whose certificate is signed by the Root CA (or another Intermediate). Intermediates perform actual day-to-day certificate issuance. Using intermediates limits the exposure of the Root CA's private key and allows the Root to remain offline.

- **Chain of Trust (Certificate Chain)**: The ordered sequence of certificates from an end-entity certificate up to a trusted Root CA. Each certificate in the chain is signed by the one above it. TLS clients validate the entire chain during handshake.

- **X.509**: The ITU-T standard defining the format of public key certificates used in PKI. X.509 v3 introduced **extensions**, which allow additional metadata such as Subject Alternative Names (SANs), Key Usage constraints, and policy information to be included in certificates.

- **Certificate Transparency (CT)**: A Google-initiated framework (RFC 6962) requiring publicly trusted CAs to log all issued certificates to publicly auditable, append-only CT logs. Browsers like Chrome enforce CT for all publicly trusted certificates, allowing domain owners to monitor for unauthorized certificate issuance via tools like `crt.sh`.

- **Registration Authority (RA)**: An entity that handles identity verification on behalf of a CA but does not itself sign certificates. Common in enterprise environments where the RA performs vetting and then forwards approved CSRs to the CA for signing.

- **Certificate Pinning**: A technique where a client hard-codes the expected certificate or public key for a specific server, bypassing normal chain-of-trust validation. Reduces risk from compromised CAs but creates operational complexity.

- **HSM (Hardware Security Module)**: Tamper-resistant hardware device used to store and operate upon CA private keys. CA best practice and a compliance requirement in many frameworks. Examples include Thales Luna, Entrust nShield, and cloud-based options like AWS CloudHSM.

---

## Exam Relevance

**SY0-701 Domain Mapping**: This topic falls primarily under **Domain 1.4** (Cryptographic solutions) and **Domain 4.6** (Certificate management).

**High-Frequency Question Patterns:**

1. **Hierarchy questions**: You will almost certainly see a scenario asking which CA type should be kept offline. The answer is always the **Root CA**. Intermediate CAs are online to perform signing operations.

2. **Revocation method distinctions**: Know that **CRL** is a downloaded list (periodic, can be stale), **OCSP** is real-time per-certificate checking, and **OCSP Stapling** improves performance by having the server cache and deliver the OCSP response.

3. **CA types**: Distinguish between **Public CA** (trusted by browsers, third-party commercial), **Private/Internal CA** (enterprise self-operated), and **Self-signed certificates** (no CA involvement, no third-party trust).

4. **Validation levels**: DV = domain control only, OV = organization verified, EV = extended vetting. SY0-701 expects you to know these distinctions and their appropriate use cases.

5. **Registration Authority (RA)**: Don't confuse RA with CA — the RA validates identity, the CA signs. Questions may present scenarios asking which entity should perform a specific function.

**Common Gotchas:**

- A **self-signed certificate** is NOT issued by a CA — it is signed by its own private key. Do not confuse this with an internal CA issuing a certificate.
- The **Root CA certificate is self-signed** — this is the one legitimate case where a self-signed certificate is trusted, because it's explicitly added to the trust store by administrators.
- **Certificate pinning** bypasses CA validation — understand both its security benefit (MITM resistance) and its operational risk (hard to update).
- Remember: certificate validity ≠ certificate trustworthiness. A valid (non-expired, properly signed) certificate can still be **revoked**.

---

## Security Implications

### CA Compromise

A compromised CA is one of the most severe PKI failures possible. In **2011, DigiNotar** (a Dutch CA) was breached by Iranian state-sponsored actors who issued fraudulent certificates for `*.google.com`, `*.cia.gov`, and 500+ other domains. These certificates were used for large-scale MITM attacks against Iranian citizens. DigiNotar was removed from all major trust stores within weeks and subsequently went bankrupt. The incident demonstrated that a single compromised intermediate CA could undermine the security of the entire web for its victims.

In **2012, Trustwave** admitted to issuing a subordinate CA certificate to an enterprise customer for SSL inspection (corporate MITM), which allowed that customer to generate trusted certificates for any domain. This practice, while technically within the customer's network, violated CA/Browser Forum baseline requirements and resulted in Trustwave's removal from Firefox's trust program if continued.

### Mis-issuance

CAs can issue certificates to unauthorized parties through process failures or social engineering. Certificate Transparency logs (e.g., searchable at `crt.sh`) allow domain owners to detect certificates they didn't authorize. Tools like Facebook's CT Monitor and Google's Certificate Transparency Search enable automated monitoring.

### MITM via Rogue CA

An attacker with administrative access to an endpoint can install a rogue root CA certificate, allowing them to intercept and decrypt all TLS traffic from that machine. This technique is used by:

- **Corporate DLP/SSL inspection proxies** (legitimate but privacy-sensitive)
- **Superfish/eDellRoot**: Pre-installed adware/bloat that added rogue root CAs to Windows laptops (Lenovo 2015, Dell 2015)
- Malware that installs rogue root CAs to enable persistent MITM

### ALPACA and Cross-Protocol Attacks

Weaknesses in certificate validation logic can allow attackers to redirect TLS connections to services with certificates for different domains but issued by the same CA. Proper use of **Extended Key Usage** and **Subject Alternative Names** constrains certificates to their intended purpose and partially mitigates this.

### Relevant CVEs

- **CVE-2020-0601 (CurveBall)**: Windows CryptoAPI vulnerability allowing spoofing of ECC certificates, effectively breaking CA chain validation on affected Windows systems.
- **CVE-2022-0778**: OpenSSL infinite loop in BN_mod_sqrt() triggered by malformed certificates, causing DoS in certificate parsing.

---

## Defensive Measures

### For Organizations Operating Internal CAs

**Protect the Root CA:**
```
- Keep Root CA air-gapped (offline) — power it on only for Intermediate CA signing ceremonies
- Store Root CA private key in a FIPS 140-2 Level 3 or higher HSM
- Require M-of-N (e.g., 3-of-5) smart card authentication for Root CA operations
- Document all Root CA operations in a tamper-evident physical log
- Store Root CA in a physically secure facility with dual-person access control
```

**Certificate Lifecycle Management:**
- Deploy a certificate inventory tool (e.g., **Venafi**, **Keyfactor**, **CertCentral**) to track all issued certificates and expiration dates
- Set alerting at 60, 30, and 7 days before certificate expiration
- Automate renewal using ACME, EST, or SCEP where possible
- Enforce minimum key lengths: RSA ≥ 2048-bit (prefer 4096), ECDSA P-256 or P-384
- Prohibit SHA-1 signatures; enforce SHA-256 minimum

**Microsoft AD CS Hardening:**
```powershell
# Audit AD CS configuration with Certify (BloodHound team)
.\Certify.exe find /vulnerable

# Check for ESC1 (misconfigured certificate templates)
# Ensure no templates allow Subject Alternative Name specification by requester
# unless explicitly required

# Review CA permissions
certutil -catemplates
```

**Network Controls:**
- Restrict CA management interfaces to dedicated management VLANs
- Block outbound port 80/443 from CAs to the internet (offline Root CAs should have no network)
- Monitor CRL/OCSP infrastructure availability — unavailability can cause client errors

### For Certificate Consumers

**Enable Certificate Transparency Monitoring:**
```bash
# Monitor your domains on crt.sh via API
curl -s "https://crt.sh/?q=%.example.com&output=json" | \
  jq '.[].name_value' | sort -u

# Use certspotter for automated monitoring
go install github.com/SSLMate/certspotter/cmd/certspotter@latest
certspotter -watchlist domains.txt
```

**Configure OCSP Stapling (nginx):**
```nginx
ssl