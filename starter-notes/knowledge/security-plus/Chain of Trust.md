---
domain: "cryptography"
tags: [pki, certificates, trust, authentication, cryptography, security]
---
# Chain of Trust

The **Chain of Trust** (also called a **certificate chain** or **trust chain**) is a hierarchical sequence of [[digital certificates]] that links an end-entity certificate back to a universally trusted [[Root Certificate Authority (CA)]]. Each link in the chain is cryptographically signed by the entity above it, allowing any party to verify authenticity without needing to know every issuer directly. This mechanism underpins [[Public Key Infrastructure (PKI)]] and is foundational to secure communications on the internet, including [[TLS/SSL]], code signing, and email security.

---

## Overview

The Chain of Trust exists to solve a fundamental problem in distributed cryptographic systems: how can two parties who have never communicated before establish that a certificate is authentic and trustworthy? The answer is delegation. A small set of globally recognized **Root CAs** — whose public keys are pre-installed in operating systems and browsers — certify **Intermediate CAs**, which in turn certify end-entity certificates (such as a website's TLS certificate). Because every entity in the chain vouches for the one below it using a digital signature, a relying party only needs to trust the root to implicitly trust the entire chain.

Root CAs are intentionally kept offline and air-gapped to minimize exposure. Their private keys are among the most guarded secrets in the industry, stored in Hardware Security Modules (HSMs) inside physically secured facilities. Because the root is offline, Intermediate CAs handle the day-to-day issuance of certificates. This architectural separation means that if an Intermediate CA is compromised, it can be revoked without invalidating the Root CA or every certificate in existence — the damage is compartmentalized.

Trust anchors are the starting point for any chain validation. Operating systems like Windows, macOS, and Linux distributions ship with a **trust store** — a curated list of trusted Root CA certificates. Mozilla maintains its own trust store (NSS), which is used by Firefox and many Linux distributions. Apple, Microsoft, and Google each maintain separate trust stores, and inclusion in these stores requires CAs to undergo rigorous audits (e.g., WebTrust or ETSI). This is why a certificate issued by a CA not in a trust store will generate an "untrusted certificate" warning in browsers.

The chain of trust model is not limited to web PKI. It appears in **Secure Boot**, where firmware verifies bootloader signatures, which verify OS kernel signatures, establishing a chain from hardware to software. It appears in **code signing** (e.g., Microsoft Authenticode, Apple notarization), **S/MIME** email signing, **SSH certificate authorities**, and **document signing** in PDF workflows. In each case, the same principle applies: a root of trust vouches for intermediate signers, who vouch for end entities.

A critical property of the chain of trust is that it is only as strong as its weakest link. Historical incidents such as the DigiNotar breach in 2011, where an intermediate CA was fully compromised and used to issue fraudulent certificates for Google domains, demonstrated that a single broken link can undermine trust for millions of users globally. This has driven the development of mechanisms like **Certificate Transparency (CT)**, **OCSP stapling**, and **CAA DNS records** to provide additional layers of accountability.

---

## How It Works

### Certificate Chain Structure

A typical TLS chain of trust has three layers:

```
Root CA Certificate (Self-signed, in trust store)
    └── Intermediate CA Certificate (signed by Root)
            └── End-Entity Certificate (signed by Intermediate)
```

When a browser connects to `https://example.com`, the server presents its end-entity certificate along with the intermediate certificate(s). The browser then performs **chain validation**:

### Step-by-Step Validation Process

**Step 1 — Receive the Certificate Chain**
The server sends its leaf certificate and one or more intermediate certificates in the TLS `Certificate` handshake message (TLS Record Type 0x0b).

**Step 2 — Build the Chain**
The client (browser/OS) walks up the chain: it reads the `Issuer` field of the end-entity cert and finds the matching `Subject` in the intermediate cert. It repeats this until it reaches a certificate whose `Issuer` matches its own `Subject` — a self-signed Root CA.

**Step 3 — Verify Each Signature**
At each step, the client verifies that the digital signature on the certificate was made by the private key corresponding to the public key in the issuer's certificate. This uses the signature algorithm specified in the cert (e.g., `sha256WithRSAEncryption` or `ecdsa-with-SHA384`).

**Step 4 — Check Certificate Properties**
For each certificate in the chain, the client checks:
- **Validity period**: `notBefore` and `notAfter` fields must bracket the current time
- **Key Usage / Extended Key Usage**: Intermediate CAs must have `keyCertSign` in Key Usage; TLS server certs must have `serverAuth` in EKU
- **Basic Constraints**: CA certificates must have `CA:TRUE` and optionally a `pathLenConstraint` limiting how many more intermediates can exist below
- **Revocation status**: via CRL (Certificate Revocation List) or OCSP (Online Certificate Status Protocol)

**Step 5 — Anchor at the Root**
The chain is valid if it terminates at a certificate in the local trust store. The root cert itself is trusted implicitly — its signature is not externally verified.

### Inspecting a Chain with OpenSSL

```bash
# View the full certificate chain presented by a server
openssl s_client -connect example.com:443 -showcerts

# Verify a certificate against a specific CA bundle
openssl verify -CAfile /etc/ssl/certs/ca-certificates.crt server.crt

# Inspect certificate fields (Subject, Issuer, validity, extensions)
openssl x509 -in server.crt -text -noout

# Check OCSP revocation status
openssl ocsp -issuer intermediate.crt -cert server.crt \
  -url http://ocsp.example.com -resp_text
```

### Viewing the Chain in a Browser

In Chrome: click the padlock → "Connection is secure" → "Certificate is valid" → "Details" tab. The chain is displayed top-down from Root → Intermediate → Leaf.

### Building a Certificate Chain File (PEM Bundle)

When configuring a web server (e.g., Nginx), you must concatenate the leaf and intermediate certs into a single bundle:

```bash
# Correct order: leaf first, then intermediate(s), root is typically omitted
cat server.crt intermediate.crt > fullchain.pem

# Nginx configuration
ssl_certificate     /etc/nginx/ssl/fullchain.pem;
ssl_certificate_key /etc/nginx/ssl/server.key;
```

### Path Length Constraints

The `pathLenConstraint` extension in a CA certificate limits how many additional CA certificates may follow in the chain. A root CA with `pathLen:1` can sign an intermediate, but that intermediate **cannot** itself sign another CA — only end-entity certs. This is a critical control against unauthorized sub-CAs.

---

## Key Concepts

- **Root CA**: The topmost certificate authority, self-signed, whose certificate is embedded in trust stores. Root CAs are offline entities — their private keys are stored in HSMs and are never used for routine operations. Examples include DigiCert Global Root G2, ISRG Root X1 (Let's Encrypt), and GlobalSign Root CA.

- **Intermediate CA** (Subordinate CA): A CA whose certificate is signed by the Root CA (or another Intermediate CA). Intermediates do the actual work of issuing certificates. Using intermediates protects the Root CA private key; if an intermediate is compromised, only that intermediate and its issued certs need to be revoked, not the entire root hierarchy.

- **End-Entity Certificate** (Leaf Certificate): The certificate issued to the actual subject — a website, a user, a code signing identity, or a device. This cert cannot sign other certificates (`CA:FALSE` in Basic Constraints). It contains the public key that corresponds to the subject's private key.

- **Trust Anchor**: A certificate or public key that is trusted by policy, not by cryptographic proof from a higher authority. In practice, the certificates in your OS or browser trust store are the trust anchors. Everything else derives its trust from them.

- **Path Validation**: The process defined in RFC 5280 for verifying a certification path. It involves checking signatures, validity periods, name constraints, policy constraints, key usage, and revocation status for every certificate in the chain from the trust anchor down to the leaf.

- **Certificate Transparency (CT)**: A public append-only log of issued certificates (RFC 6962). CAs are required to submit certificates to CT logs before or immediately after issuance. Browsers like Chrome require CT proofs (SCTs — Signed Certificate Timestamps) embedded in or delivered with TLS certificates. CT makes it possible to detect unauthorized or misissued certificates.

- **Cross-Certification**: When two Root CAs sign each other's certificates, creating a web of trust. This was historically used to extend trust between PKI hierarchies. Let's Encrypt's ISRG Root X1 was cross-signed by DST Root CA X3 to achieve broader compatibility during its early adoption phase.

---

## Exam Relevance

**SY0-701 Domain Mapping**: This topic appears primarily in **Domain 1 – General Security Concepts** (1.4 — cryptographic solutions) and **Domain 4 – Security Architecture** (PKI and certificate management).

**Common Question Patterns**:

- **Scenario**: A browser displays "Your connection is not private — NET::ERR_CERT_AUTHORITY_INVALID." What is the most likely cause? → The certificate chain cannot be traced to a trusted Root CA (missing intermediate, self-signed cert, or untrusted CA).

- **Definition questions**: Distinguish between Root CA, Intermediate CA, and Registration Authority (RA). The RA handles identity verification and certificate requests but does **not** issue certificates — issuance is the CA's job.

- **Trust store questions**: Where are root CA certificates stored on a Windows machine? → **Certificate Store** (accessible via `certmgr.msc` or `certlm.msc`). On Linux, typically `/etc/ssl/certs/` or the NSS database.

- **Path length / constraint questions**: If a Root CA has `pathLenConstraint: 0`, how many intermediate CAs can exist below it? → **Zero** — the root can only sign end-entity certs directly. `pathLen:0` means no additional CAs in the path after this one.

**Gotchas**:
- The Root CA certificate IS self-signed — its `Subject` and `Issuer` fields are identical. Don't confuse "self-signed" with "untrusted" in the CA context; roots are self-signed by design.
- **Revocation applies to every cert in the chain**, not just the leaf. A revoked intermediate CA invalidates all certs it issued.
- The exam may test that CRL and OCSP are **revocation** mechanisms, not authentication mechanisms.
- **Registration Authority (RA)** ≠ **CA**. An RA can accept and validate certificate requests but the CA is the entity that actually signs and issues.

---

## Security Implications

### Attack Vectors

**Rogue CA / Compromised Intermediate CA**
The 2011 **DigiNotar breach** is the canonical example. Attackers gained access to DigiNotar's certificate issuance systems and generated over 500 fraudulent certificates, including a wildcard `*.google.com` certificate used in a man-in-the-middle attack against Iranian Gmail users. The attack succeeded because the fraudulent cert chained to a trusted root. DigiNotar was subsequently removed from all major trust stores, bankrupting the company.

**BGP Hijacking + Certificate Issuance**
In 2018, attackers hijacked BGP routes to Amazon's Route 53 DNS to steal $150,000 in Ethereum. More directly relevant: BGP hijacks can redirect OCSP and certificate validation traffic, potentially enabling OCSP stapling forgery or Domain Validation (DV) certificate issuance via DNS-01 or HTTP-01 challenges on hijacked routes.

**Weak Root Inclusion Controls**
**CVE-2023-32360** and similar vulnerabilities relate to trust store manipulation. Malware or a compromised software update can install rogue root CA certificates into the OS trust store, enabling the attacker to intercept all TLS traffic with valid-appearing certificates. This technique was used by Superfish adware (2015) pre-installed on Lenovo laptops, which installed its own root CA and used it to intercept HTTPS connections.

**Inadequate Path Validation**
Some TLS libraries have historically had bugs in chain validation (e.g., **CVE-2009-2408** — null byte injection in CN fields; **CVE-2014-6321** — Microsoft Schannel buffer overflow). These can allow forged certificates to pass validation.

**Name Constraint Violations**
Intermediate CAs can be issued without Name Constraints, meaning a CA issued to `corp.internal` PKI could theoretically issue valid-looking certs for `google.com` if there's no name constraint limiting what domains the intermediate can certify.

### Detection

- Monitor CT logs for unauthorized certificates issued for your domains using tools like **crt.sh**, **Facebook Certificate Transparency Monitor**, or **Certspotter**.
- Deploy **CAA (Certification Authority Authorization)** DNS records to restrict which CAs may issue certs for your domain.
- Alert on new certificates appearing in your trust store (Windows Event ID 4898 for ADCS; Linux — audit `/etc/ssl/certs/`).

---

## Defensive Measures

### CAA DNS Records
Add CAA records to your domain's DNS to restrict certificate issuance:
```
example.com. 300 IN CAA 0 issue "letsencrypt.org"
example.com. 300 IN CAA 0 issue "digicert.com"
example.com. 300 IN CAA 0 issuewild ";"
example.com. 300 IN CAA 0 iodef "mailto:security@example.com"
```
The `issuewild ";"` line prohibits any CA from issuing wildcard certificates.

### Certificate Transparency Monitoring
```bash
# Use certspotter to watch for new certs issued for your domain
# Install via: go install software.sslmate.com/src/certspotter/cmd/certspotter@latest
certspotter -watchlist watchlist.txt

# Query crt.sh manually via its API
curl -s "https://crt.sh/?q=example.com&output=json" | jq '.[].name_value'
```

### OCSP Stapling (Nginx)
Ensure your server staples OCSP responses to eliminate client-side OCSP requests and prevent privacy leaks / OCSP soft-fail vulnerabilities:
```nginx
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
ssl_trusted_certificate /etc/nginx/ssl/chain.pem;
```

### Trust Store Hardening
- **Windows**: Use Group Policy to restrict which root CAs are trusted (`Computer Configuration → Windows Settings → Security Settings → Public Key Policies → Certificate Path Validation Settings`). Enable the **Disallowed** store to explicitly block specific CAs.
- **Linux**: Remove unnecessary root certificates from `/usr/local/share/ca-certificates/` and run `update-ca-certificates`.
- **Browser pinning**: Consider HPKP (deprecated) or its successor **Expect-CT** to enforce CT log verification.

### Internal PKI Best Practices
- Keep Root CA **offline** — only bring it online to sign intermediate CA certificates (which should be infrequent, perhaps once every 5-10 years).
- Issue Intermediate CA certs with short validity periods (2-4 years) and use `pathLenConstraint` to limit chain depth.
- Use an HSM for all CA private key operations (`SoftHSM2` for lab; `YubiHSM2` or cloud HSM for production).
- Implement **ADCS** (Active Directory Certificate Services) in enterprise environments with role separation: separate servers for Root CA, Issuing CA, and Online Responder (OCSP).

---

## Lab / Hands-On

### Build a 3-Tier PKI with OpenSSL

```bash
# ── Step 1: Create Root CA ──────────────────────────────────────
mkdir -p ~/pki/{root,intermediate,certs}
cd ~/pki/root

# Generate Root CA private key (keep this offline!)
openssl genrsa -aes256 -out root