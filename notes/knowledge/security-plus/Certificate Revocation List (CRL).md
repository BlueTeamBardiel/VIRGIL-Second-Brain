---
domain: "cryptography"
tags: [pki, certificates, revocation, tls, x509, authentication]
---
# Certificate Revocation List (CRL)

A **Certificate Revocation List (CRL)** is a digitally signed, time-stamped list published by a [[Certificate Authority (CA)]] that enumerates [[X.509 Certificate|digital certificates]] that have been revoked before their scheduled expiration date. CRLs are a foundational component of [[Public Key Infrastructure (PKI)]], allowing relying parties to verify that a certificate has not been invalidated due to compromise, misuse, or policy violation. Unlike [[Online Certificate Status Protocol (OCSP)]], which provides real-time per-certificate status, CRLs are batch documents downloaded and cached periodically.

---

## Overview

When a CA issues a digital certificate, it also commits to maintaining revocation information for the lifetime of that certificate. Certificates may need to be revoked for many reasons: the private key was compromised, the certificate was issued in error, the certificate holder's organizational affiliation changed, or a subordinate CA was found to be untrustworthy. Without a reliable revocation mechanism, a stolen private key paired with a still-valid certificate could enable identity fraud, man-in-the-middle attacks, or unauthorized authentication indefinitely until the certificate's natural expiration.

The CRL standard is defined in **RFC 5280** (Internet X.509 PKI Certificate and CRL Profile), which supersedes RFC 3280. A CRL is itself a signed ASN.1-encoded DER or PEM document. It contains a list of revoked certificate serial numbers, the date each was revoked, and optionally a reason code (e.g., keyCompromise, affiliationChanged, superseded, cessationOfOperation, certificateHold). The CRL is signed by the issuing CA's private key, ensuring its authenticity and integrity, and it carries a `nextUpdate` field indicating when the next CRL will be published.

CRLs are distributed through **CRL Distribution Points (CDPs)**, which are URLs embedded inside issued certificates in the `cRLDistributionPoints` extension. These URLs typically point to HTTP endpoints (not HTTPS, to avoid circular dependency issues), LDAP directories, or file shares. Relying parties — browsers, OS certificate stores, TLS libraries — are responsible for downloading the CRL from the CDP, caching it, and checking revoked serial numbers during certificate validation.

In large enterprise or public PKI deployments, CRLs can become quite large. Microsoft Active Directory Certificate Services (AD CS), for example, supports **Delta CRLs** — incremental CRL documents that only list certificates revoked since the last full (Base) CRL was published. This reduces bandwidth and processing overhead while maintaining timely revocation coverage. The Base CRL and Delta CRL together provide a complete revocation picture.

Despite being a mature standard, CRLs have well-documented scalability and timeliness limitations. The window between a compromise occurring and the next CRL publication can be hours or days, during which a revoked certificate remains trusted by clients that have cached the previous CRL. This latency, combined with the "soft-fail" behavior of many TLS clients (which accept certificates when CRL download fails rather than rejecting them), means revocation checking has historically been weaker in practice than in theory — a key driver for the development of OCSP, [[OCSP Stapling]], and ultimately [[Certificate Transparency (CT)]] logs.

---

## How It Works

### CRL Issuance and Structure

A CRL is issued by the same CA that issued the certificates it covers. The CA maintains a revocation database. When an administrator or automated process submits a revocation request, the CA records the serial number, revocation date, and reason. At the scheduled publication interval (e.g., every 24 hours for a Base CRL, every 4 hours for a Delta CRL), the CA generates and signs a new CRL.

The CRL document structure in ASN.1 notation (simplified):

```
CertificateList ::= SEQUENCE {
  tbsCertList          TBSCertList,
  signatureAlgorithm   AlgorithmIdentifier,
  signatureValue       BIT STRING
}

TBSCertList ::= SEQUENCE {
  version              INTEGER OPTIONAL,     -- v2
  signature            AlgorithmIdentifier,
  issuer               Name,
  thisUpdate           Time,
  nextUpdate           Time OPTIONAL,
  revokedCertificates  SEQUENCE OF SEQUENCE {
    userCertificate    CertificateSerialNumber,
    revocationDate     Time,
    crlEntryExtensions Extensions OPTIONAL
  } OPTIONAL,
  crlExtensions        [0] EXPLICIT Extensions OPTIONAL
}
```

Key fields:
- **thisUpdate**: The date/time the CRL was issued
- **nextUpdate**: The deadline by which the next CRL will be issued; clients should not trust the CRL beyond this time
- **revokedCertificates**: The list of serial numbers and revocation metadata
- **cRLNumber** (extension): Monotonically increasing sequence number for ordering CRLs
- **deltaCRLIndicator** (extension): Present only in Delta CRLs; references the Base CRL number it extends

### How Clients Validate Using CRLs

1. **Certificate Received**: A client (e.g., a web browser establishing a TLS session) receives the server's X.509 certificate during the [[TLS Handshake]].
2. **Extract CDP URL**: The client reads the `cRLDistributionPoints` extension from the certificate to find the CRL URL.
3. **Download CRL**: The client makes an HTTP GET request to the CDP URL (typically over port **80**). LDAP-based CDPs use port **389**.
4. **Cache Check**: If the client already has a cached CRL with a `nextUpdate` time in the future, it may skip the download.
5. **Signature Verification**: The client verifies the CRL's digital signature using the CA's public key to ensure authenticity and integrity.
6. **Serial Number Lookup**: The client searches the CRL for the certificate's serial number.
7. **Decision**:
   - Serial number **not found** → certificate is not revoked; proceed.
   - Serial number **found** → certificate is revoked; reject the connection.
   - CRL **download failed** → behavior depends on client policy: hard-fail (reject) or soft-fail (accept). Most clients soft-fail.

### Examining CRLs with OpenSSL

**Download and inspect a CRL from a live certificate:**

```bash
# First, extract the CDP URL from a certificate
openssl x509 -in server.crt -noout -text | grep -A 4 "CRL Distribution"

# Example output:
# X509v3 CRL Distribution Points:
#   Full Name:
#     URI:http://crl.example.com/issuing-ca.crl

# Download the CRL
curl -s http://crl.example.com/issuing-ca.crl -o issuing-ca.crl

# If DER-encoded, convert to PEM first
openssl crl -inform DER -in issuing-ca.crl -out issuing-ca.pem

# Inspect CRL contents
openssl crl -in issuing-ca.pem -noout -text
```

**Sample CRL output:**
```
Certificate Revocation List (CRL):
        Version 2 (0x1)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=Example Issuing CA, O=Example Corp, C=US
        Last Update: Jan 15 08:00:00 2025 GMT
        Next Update: Jan 16 08:00:00 2025 GMT
        CRL extensions:
            X509v3 CRL Number:
                42
Revoked Certificates:
    Serial Number: 0A1B2C3D4E5F
        Revocation Date: Jan 10 14:32:00 2025 GMT
        CRL entry extensions:
            X509v3 CRL Reason Code:
                Key Compromise
    Serial Number: 06F7E8D9CA01
        Revocation Date: Jan 12 09:15:00 2025 GMT
```

**Check if a specific certificate serial is revoked:**
```bash
# Get serial number from cert
SERIAL=$(openssl x509 -in server.crt -noout -serial | cut -d= -f2)

# Search CRL for the serial
openssl crl -in issuing-ca.pem -noout -text | grep -i "$SERIAL"
```

### Active Directory Certificate Services (AD CS) CRL Configuration

```powershell
# View current CRL configuration on AD CS
certutil -getreg CA\CRLPeriod
certutil -getreg CA\CRLDeltaPeriod

# Manually publish a CRL immediately
certutil -CRL

# Publish a Delta CRL
certutil -CRL delta

# View CRL publication intervals
certutil -getreg CA\CRLPeriodUnits
# Default: 1 week for Base CRL

# Verify a certificate against published CRL
certutil -verify server.crt
```

### CRL Distribution Point URL Types

| Type | Protocol | Port | Example |
|------|----------|------|---------|
| HTTP | HTTP | 80 | `http://crl.ca.com/root.crl` |
| LDAP | LDAP | 389 | `ldap:///CN=CA,DC=corp,DC=com?certificateRevocationList` |
| File | File | N/A | `file:///\\server\crls\root.crl` |

---

## Key Concepts

- **Base CRL**: The complete, authoritative list of all currently revoked certificates issued by a CA. Published on a regular schedule (e.g., weekly or daily). Can become very large in high-volume PKIs.
- **Delta CRL**: An incremental CRL containing only certificates revoked since the last Base CRL was published. Identified by the `deltaCRLIndicator` extension. Allows more frequent updates with smaller file sizes.
- **CRL Distribution Point (CDP)**: A URL embedded in an issued certificate's `cRLDistributionPoints` extension that points to where the applicable CRL can be downloaded. Multiple CDPs can be listed for redundancy.
- **Revocation Reason Codes**: Standardized codes defined in RFC 5280 explaining why a certificate was revoked: `keyCompromise` (0), `cACompromise` (1), `affiliationChanged` (2), `superseded` (3), `cessationOfOperation` (4), `certificateHold` (6), `removeFromCRL` (8), `privilegeWithdrawn` (9), `aACompromise` (10).
- **CRL Staleness**: The condition where a cached CRL's `nextUpdate` time has passed but a client cannot retrieve a fresh CRL. Policy dictates whether stale CRLs cause hard or soft failures.
- **Indirect CRL**: A CRL issued by an entity other than the CA that issued the certificates it covers, indicated by the `indirectCRL` extension. Allows CRL consolidation across multiple CAs.
- **CRL Number Extension**: A monotonically increasing integer in each CRL that allows relying parties to detect if they have the most recent CRL and to correctly apply Delta CRLs to the correct Base CRL.
- **Certificate Hold**: A temporary revocation reason code (`certificateHold`) that suspends a certificate without permanently revoking it; the certificate can later be reinstated with `removeFromCRL`.

---

## Exam Relevance

**SY0-701 Domain**: 1.0 General Security Concepts, 4.0 Security Operations (PKI, certificate management)

**Key exam facts to memorize:**
- CRL is a **list of revoked certificates**, not a list of valid certificates.
- CRLs are published by the **CA**, not the certificate subject.
- The `nextUpdate` field defines the **validity window** of a CRL — not certificate expiration.
- CRL Distribution Points are embedded in the **certificate itself**, in the `cRLDistributionPoints` extension.
- CRLs are typically distributed over **HTTP port 80** (not HTTPS) to avoid bootstrapping problems.
- **OCSP** is the real-time alternative to CRL; OCSP Stapling is the performance-optimized variant.
- **Soft-fail** behavior: if CRL cannot be fetched, most clients accept the certificate anyway — this is a known weakness.
- **Hard-fail** behavior: reject connection if CRL cannot be fetched — more secure but can cause availability issues.

**Common question patterns:**
- "Which mechanism allows a CA to invalidate a certificate before it expires?" → CRL (or OCSP)
- "A certificate was revoked but browsers are still accepting it for several hours. What is the most likely cause?" → CRL caching / CRL staleness
- "Which protocol provides real-time certificate revocation status?" → OCSP (not CRL)
- "What field in a CRL tells clients when they must fetch a new one?" → `nextUpdate`
- Questions may present a scenario where a compromised private key is discovered and ask what administrative action is needed → revoke the certificate (which causes it to appear on the CRL)

**Gotchas:**
- Don't confuse CRL with [[Certificate Transparency (CT)]] logs — CT logs track issuance, not revocation.
- "Certificate Hold" is revocation, not expiration — it can be reversed.
- Delta CRLs require the client to have the Base CRL — a Delta alone is insufficient.
- A CRL only covers certificates issued by *that specific CA* — it does not span the entire PKI hierarchy unless specifically configured.

---

## Security Implications

### Inherent Weaknesses

**CRL Latency Window**: The most significant security gap is the time between when a certificate is compromised and when revocation information reaches all clients. If a CA publishes CRLs daily, an attacker with a stolen private key has up to 24 hours (plus client cache age) to exploit it without being blocked by CRL checking. During the 2011 [[DigiNotar]] CA compromise, fraudulent certificates were in use for weeks before revocation occurred.

**Soft-Fail Default Behavior**: The vast majority of TLS clients implement soft-fail revocation checking. If a CRL distribution point is unreachable (network block, server outage, DNS failure), the client proceeds as if the certificate is valid. An attacker performing a targeted attack can block access to CRL distribution point URLs (e.g., via DNS poisoning, BGP hijacking, or local firewall rules) to neutralize revocation checking entirely. This was exploited in practice against some corporate VPN clients.

**CRL Stuffing / Denial of Service**: In high-volume PKIs, Base CRLs can grow to megabytes in size. Forcing clients to download large CRLs on every TLS handshake creates bandwidth and latency overhead, which is why clients cache aggressively — but this caching is itself a security weakness.

### Notable Incidents

- **DigiNotar (2011)**: A Dutch CA was compromised; fraudulent wildcard certificates were issued for `*.google.com` and hundreds of other domains. CRL revocation was delayed, and many clients continued to trust fraudulent certificates. This incident accelerated adoption of [[Certificate Transparency (CT)]] and [[OCSP Stapling]].
- **Flame malware (2012)**: Used a fraudulently issued Microsoft certificate obtained via an MD5 collision attack against a Microsoft CA. The certificate was eventually revoked via Windows Update rather than CRL, highlighting CRL's limitations for rapid response.
- **CVE-2023-0464 (OpenSSL)**: Excessive resource usage in certificate chain verification including CRL checking; an attacker could trigger a denial of service by presenting chains requiring extensive CRL processing.

### Attack Vectors

- **CRL Distribution Point Blocking**: Attacker intercepts or blocks HTTP requests to CDP URLs, causing soft-fail acceptance of a revoked certificate.
- **CRL Spoofing**: If an attacker can perform a MITM attack on the HTTP channel to the CDP, they could serve a stale or forged CRL (if signature verification is bypassed or the CA's key is compromised).
- **Revocation Oracle**: Monitoring which serial numbers appear in CRLs can leak information about certificate lifecycle events in an organization.

---

## Defensive Measures

### Configure Hard-Fail Revocation Checking

For high-security environments, configure TLS clients and application servers to **hard-fail** when CRL cannot be retrieved:

**Windows Group Policy (for Internet Explorer/Edge legacy):**
```
Computer Configuration → Windows Settings → Security Settings →
Public Key Policies → Certificate Path