---
domain: "PKI and Cryptography"
tags: [pki, certificates, revocation, tls, x509, cryptography]
---
# Certificate Revocation List

A **Certificate Revocation List (CRL)** is a digitally signed, time-stamped list published by a **Certificate Authority (CA)** that enumerates all [[Digital Certificate|digital certificates]] that have been revoked before their scheduled expiration date. CRLs are a foundational component of [[Public Key Infrastructure (PKI)]] and allow relying parties — browsers, servers, and applications — to verify that a certificate has not been invalidated due to compromise, mis-issuance, or policy violation. The mechanism is defined in [[X.509]] standards and further specified in [[RFC 5280]].

---

## Overview

When a certificate is issued, it is implicitly trusted until its `notAfter` date. However, circumstances may arise that make a certificate untrustworthy before expiration — the private key may be stolen, the organization may cease operations, a CA may discover it issued a certificate in error, or a subscriber may request revocation upon employee departure. Without a revocation mechanism, attackers who possess a stolen private key can continue to impersonate a legitimate entity for years. The CRL solves this by providing a regularly updated blacklist that clients can consult before trusting a certificate.

CRLs are published at a **CRL Distribution Point (CDP)**, a URL embedded within the certificate itself under the `CRL Distribution Points` extension. This URL typically points to an HTTP endpoint hosted by the CA (or a delegated server), from which clients download the CRL file in DER or PEM format. Clients cache the CRL for a period defined by the CRL's `nextUpdate` field, after which a fresh copy must be fetched. This caching behavior is both a performance feature and a known security weakness.

The CRL format itself is defined by the [[X.509]] v2 standard. Each entry in the CRL contains the serial number of the revoked certificate, the date of revocation, and optionally a **reason code** indicating why revocation occurred. Reason codes are defined in RFC 5280 and include values such as `keyCompromise (1)`, `cACompromise (2)`, `affiliationChanged (3)`, `superseded (4)`, `cessationOfOperation (5)`, `certificateHold (6)`, and `removeFromCRL (8)`. The `certificateHold` reason is notable because it allows temporary suspension of a certificate — a capability absent from [[OCSP]].

In large PKI deployments, CRLs can grow to several megabytes, particularly for enterprise or government CAs with high certificate issuance volumes. To address scalability, the **Delta CRL** was introduced: rather than downloading the full CRL, clients can download a smaller delta file containing only changes since the last full CRL was issued. The full CRL is called the **Base CRL**, and the delta supplements it. Both are published separately, and clients must hold both to determine current revocation status.

While CRLs remain widely deployed — particularly in enterprise PKI, code signing, and government systems — their use in public web TLS has declined in favor of [[OCSP]] and browser-embedded revocation data (such as Chrome's CRLSets). Mozilla Firefox and major browsers have largely soft-failed on CRL and OCSP checks for end-entity certificates, relying instead on certificate transparency logs and vendor-curated revocation data.

---

## How It Works

### Certificate Issuance and CDP Embedding

When a CA issues a certificate, it embeds the URL of its CRL Distribution Point in the certificate extension `id-ce-cRLDistributionPoints (OID 2.5.29.31)`. You can inspect this with OpenSSL:

```bash
openssl x509 -in certificate.pem -noout -text | grep -A 10 "CRL Distribution"
```

Example output:
```
X509v3 CRL Distribution Points:
    Full Name:
      URI:http://crl.example-ca.com/issuing-ca.crl
```

### CRL Retrieval

A client that wishes to verify revocation status:

1. Parses the certificate's CDP extension to find the CRL URL.
2. Issues an HTTP GET request (typically over **port 80**) to download the CRL file.
3. Verifies the digital signature on the CRL using the CA's public key (the same CA that issued the certificate).
4. Checks whether the certificate's serial number appears in the CRL.
5. Checks the CRL's `nextUpdate` field — if the current time is past `nextUpdate`, the CRL is stale and the client must fetch a new one.

```bash
# Download a CRL manually
curl -o ca.crl http://crl.example-ca.com/issuing-ca.crl

# Convert DER format to PEM
openssl crl -inform DER -in ca.crl -outform PEM -out ca.crl.pem

# Display CRL contents
openssl crl -in ca.crl.pem -text -noout
```

Example CRL output:
```
Certificate Revocation List (CRL):
        Version 2 (0x1)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=Example Issuing CA, O=Example Corp, C=US
        Last Update: Jun  1 00:00:00 2025 GMT
        Next Update: Jun  8 00:00:00 2025 GMT
Revoked Certificates:
    Serial Number: 3A2F...
        Revocation Date: May 15 14:23:01 2025 GMT
        CRL entry extensions:
            X509v3 CRL Reason Code:
                Key Compromise
```

### Checking a Certificate Against a CRL

```bash
# Verify certificate revocation status against a CRL
openssl verify -crl_check -CRLfile ca.crl.pem -CAfile ca-chain.pem certificate.pem
```

### Delta CRL Workflow

1. CA publishes full **Base CRL** (e.g., weekly).
2. CA publishes **Delta CRL** (e.g., every few hours) containing only revocations since the base.
3. Client downloads base + delta, merges them in memory, and checks the combined set.
4. Delta CRL is identified by the extension `id-ce-deltaCRLIndicator` and references the `CRLNumber` of the base it supplements.

### CRL Signing

CRLs are signed by the CA using its private key. The signature ensures that no one can tamper with the revocation list or remove entries. In some architectures, a dedicated **CRL Signing Certificate** with key usage `cRLSign` is used, separate from the CA's main certificate-signing key.

### Publication Schedule and Validity Window

| Field | Meaning |
|---|---|
| `thisUpdate` | Timestamp when this CRL was generated |
| `nextUpdate` | Timestamp when a new CRL will be available |
| Validity window | `thisUpdate` → `nextUpdate` (typically hours to days) |

A common enterprise configuration publishes a full CRL every 7 days and a delta CRL every 4 hours, balancing freshness against download overhead.

---

## Key Concepts

- **CRL Distribution Point (CDP):** The URL embedded in an issued certificate from which clients can download the corresponding CRL. A single certificate may list multiple CDPs for redundancy, and clients typically try them in order.

- **Revocation Reason Code:** A numeric code included in each CRL entry indicating *why* a certificate was revoked. The most security-critical code is `keyCompromise (1)`, which signals that the private key was exposed; this is the only reason for which backdating the revocation date is explicitly permitted by RFC 5280.

- **Delta CRL:** A partial CRL that contains only revocations added since the last published Base CRL, identified by the `deltaCRLIndicator` extension. Delta CRLs dramatically reduce download sizes in large PKIs but require clients to hold the base CRL as well.

- **CRL Caching and Staleness:** Clients cache downloaded CRLs until `nextUpdate`. If a certificate is compromised and revoked *after* a client last downloaded the CRL but *before* `nextUpdate`, the client will not be aware of the revocation during the cache window — a fundamental timeliness gap.

- **Indirect CRL:** A CRL that lists revoked certificates from multiple CAs, not just the issuing CA. The `issuingDistributionPoint` extension marks a CRL as indirect. This allows a single CRL to serve as a consolidated revocation source for an entire PKI hierarchy.

- **CRL Number:** A monotonically increasing integer assigned to each successive CRL issuance, defined as the `cRLNumber` extension. This allows clients to determine if they have the latest version and allows delta CRLs to reference a specific base.

- **Soft-Fail vs. Hard-Fail:** When a client cannot retrieve a CRL (network error, server unavailable), it must decide whether to proceed with the connection (**soft-fail**, the common browser default) or reject it (**hard-fail**, the more secure but operationally disruptive option). Most browsers default to soft-fail, meaning CRL unavailability does not block connections.

---

## Exam Relevance

**SY0-701 Domain: 1.4 — Explain the importance of using appropriate cryptographic solutions.**

### Key Points for the Exam

- **CRL vs. OCSP:** Know both mechanisms. CRLs are downloaded entirely by the client (pull model). OCSP provides per-certificate real-time status via a responder (query model). OCSP Stapling embeds the OCSP response in the TLS handshake, eliminating a separate client query.
- **Revocation ≠ Expiration:** A revoked certificate is invalidated *before* its `notAfter` date. An expired certificate is simply past its validity period. Both make a certificate untrusted, but for different reasons.
- **CRL Distribution Point** is an extension field inside the certificate — not a separate document or external database requiring manual lookup.

### Common Question Patterns

- *"Which mechanism allows a CA to invalidate a certificate before expiration?"* → CRL or OCSP (revocation mechanisms).
- *"A user's certificate private key was stolen. What should the administrator do?"* → Revoke the certificate (triggering CRL update), then re-issue.
- *"What is the primary disadvantage of CRLs compared to OCSP?"* → CRLs can be large and are only as fresh as the last download/cache interval.
- *"Which revocation method embeds the status response in the TLS handshake?"* → [[OCSP Stapling]].

### Gotchas

- The **reason code `certificateHold`** is a *temporary* suspension, not permanent revocation — this nuance sometimes appears in exam questions.
- CRLs are signed by the **CA's private key** — if you see an answer suggesting the certificate holder signs the CRL, it is wrong.
- A certificate may list **multiple CDP URLs** (redundancy), but the CA publishes the same CRL at all of them.
- **Delta CRLs require the base CRL** — a client cannot use only the delta.

---

## Security Implications

### The Revocation Gap

The most fundamental weakness of CRLs is the **revocation gap**: the window between when a certificate is revoked and when a client learns about it. If a CRL has a 7-day validity window and was downloaded 6 days ago, a certificate revoked today will still appear valid to that cached client for up to one more day. Attackers who compromise a private key have this window to operate undetected.

### CRL Soft-Fail Exploitation

Because most clients default to soft-fail behavior, an attacker performing a **man-in-the-middle attack** can block access to the CRL Distribution Point (via DNS poisoning, firewall rules, or network manipulation). The client, unable to retrieve the CRL, proceeds with the connection anyway. This was demonstrated during the **DigiNotar compromise (2011)**, where fraudulent certificates issued by the compromised Dutch CA were used for months before widespread revocation awareness.

### CRL Replay Attack

A CRL is valid until its `nextUpdate` timestamp. An attacker who captures a CRL *before* a particular certificate was added to it can replay that older CRL to a client that doesn't enforce strict freshness checking, making a revoked certificate appear valid. Proper implementations check that `thisUpdate` is not unreasonably old.

### CRL Signing Key Compromise

If a CA's CRL signing key is compromised, an attacker could publish a **forged CRL** that omits entries for certificates they control, or even adds entries for legitimate certificates to perform a denial-of-service. This is why the CRL signing key must be protected with the same rigor as the CA key itself.

### Large CRL Denial of Service

An attacker can force excessive CRL downloads in environments that disable caching or have very short `nextUpdate` windows, creating bandwidth exhaustion on the CRL distribution server. Well-configured CDN-backed CRL endpoints mitigate this.

### Notable Incidents

- **DigiNotar (2011):** A Dutch CA was compromised; fraudulent certificates were issued for Google, intelligence agencies, and others. CRL-based revocation was slow to propagate and ineffective for many users, highlighting the gap problem. The CA was ultimately declared untrusted entirely and went bankrupt.
- **Comodo Affiliate Compromise (2011):** Nine fraudulent certificates were issued; rapid revocation via CRL and OCSP was issued, but the incident demonstrated how quickly stolen certificates can be weaponized.

---

## Defensive Measures

### Enforce Hard-Fail Revocation Checking

For internal enterprise PKI, configure applications and OS certificate stores to **hard-fail** when CRL retrieval fails:

```powershell
# Windows: Enable hard-fail CRL checking via Group Policy
# Computer Configuration > Windows Settings > Security Settings >
# Public Key Policies > Certificate Path Validation Settings
# > Revocation tab > "Require that all revocations along the certification path are checked"
```

For Java applications:
```bash
-Dcom.sun.net.ssl.checkRevocation=true
-Dcom.sun.security.enableCRLDP=true
```

### Minimize CRL Validity Windows

Configure your CA to issue CRLs with short validity windows and publish delta CRLs frequently:

```ini
# Example Windows CA policy (certutil -setreg CA\CRLPeriodUnits)
CRLPeriodUnits = 7          # Base CRL: every 7 days
CRLPeriod = Days
CRLDeltaPeriodUnits = 4     # Delta CRL: every 4 hours
CRLDeltaPeriod = Hours
```

### Distribute CRLs via Redundant CDN

Host CRL files behind a CDN or load-balanced HTTP servers. CRL servers should have high availability (99.99% SLA) because unreachable CDPs cause soft-fail bypasses. Use multiple CDP URLs in issued certificates:

```
CDP 1: http://crl1.pki.example.com/issuing.crl
CDP 2: http://crl2.pki.example.com/issuing.crl
```

### Implement OCSP Alongside CRL

Deploy [[OCSP]] as a complementary mechanism for real-time checks. For web-facing services, configure [[OCSP Stapling]] on the web server to eliminate client-side OCSP/CRL latency:

```nginx
# Nginx OCSP Stapling
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 valid=300s;
```

### Monitor CRL Issuance

Alert when:
- A CRL's `nextUpdate` has passed without a new CRL being published (CA service issue).
- Unexpected serial numbers appear in the CRL (potential unauthorized revocation).
- CRL file size grows anomalously fast (mass revocation event).

### Private CA Best Practices (Microsoft ADCS / OpenSSL)

```bash
# OpenSSL CA: Configure CRL generation in openssl.cnf
[ CA_default ]
crl_extensions = crl_ext
default_crl_days = 7

[ crl_ext ]
authorityKeyIdentifier = keyid:always
```

---

## Lab / Hands-On

### Lab 1: Build a CA and Generate a CRL with OpenSSL

```bash
# Create CA directory structure
mkdir -p ~/lab-ca/{certs,crl,newcerts,private}
chmod 700 ~/lab-ca/private
touch ~/lab-ca/