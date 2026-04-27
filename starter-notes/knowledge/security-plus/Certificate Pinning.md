---
domain: "cryptography and PKI"
tags: [certificate-pinning, tls, pki, mobile-security, ssl, application-security]
---
# Certificate Pinning

**Certificate pinning** (also called **SSL pinning** or **public key pinning**) is a security technique in which an application hardcodes or bundles a trusted [[TLS Certificate]] (or its public key hash) so that it only accepts connections to servers presenting that exact credential, bypassing the normal [[Certificate Authority]] trust chain. This mechanism defends against [[Man-in-the-Middle Attack]]s even when an attacker possesses a rogue certificate signed by a trusted CA. It is widely used in mobile applications, embedded systems, and high-value API clients.

---

## Overview

The standard [[TLS Handshake]] relies on a chain of trust rooted in Certificate Authorities whose root certificates are pre-installed in the operating system or browser. This model has a critical weakness: any CA trusted by the OS can issue a certificate for any domain. If an attacker compromises a CA, bribes an insider, or installs a rogue root certificate on the device (common in corporate [[SSL Inspection]] proxies), they can intercept encrypted traffic transparently. Certificate pinning eliminates this weakness for specific applications by declaring in advance exactly which certificate or key material the server is permitted to present.

Pinning was popularized by Google, which began pinning its own certificates in Chrome around 2011. The technique became a near-universal standard in mobile app development after high-profile incidents such as the DigiNotar CA compromise in 2011, where fraudulent certificates were issued for Google, Mozilla, and intelligence agencies. Because mobile apps are compiled binaries distributed directly to end users, they are well-suited to embed trust anchors that the OS trust store cannot override.

There are two primary pinning strategies. **Certificate pinning** embeds the full DER-encoded certificate or its SHA-256 fingerprint. **Public key pinning** embeds only the hash of the certificate's SubjectPublicKeyInfo (SPKI) field. Public key pinning is generally preferred because it survives certificate renewal as long as the same key pair is retained, whereas certificate pinning requires an app update every time the certificate expires.

A significant operational challenge with pinning is **pin rotation** — updating the embedded trust anchor before the pinned certificate expires without breaking existing deployments. Best practices require shipping at least one backup pin in the application so that a certificate renewal does not immediately lock out all users. Poor pin management has caused high-profile outages; in 2015, Microsoft accidentally blocked Windows Update by pinning an intermediate CA certificate that was later replaced during routine PKI maintenance.

HTTP Public Key Pinning (HPKP) was a standards-based attempt to bring pinning to web browsers via an HTTP response header (`Public-Key-Pins`), defined in RFC 7469. It was deprecated by all major browsers by 2020 due to widespread abuse as a denial-of-service vector (attackers who could briefly hijack a connection could set a malicious pin, permanently locking users out) and operational complexity. Modern web applications instead rely on [[Certificate Transparency]] and CAA DNS records for similar protections.

---

## How It Works

### The Standard TLS Chain of Trust (Baseline)

In normal TLS, a client validates the server certificate by walking up the chain:
1. Server presents its leaf certificate.
2. Client checks the signature against the intermediate CA certificate.
3. Client checks the intermediate against its trusted root CA store.
4. Client verifies validity period, hostname (SAN/CN matching), and revocation status via [[OCSP]] or [[CRL]].

Any trusted root CA can issue for any domain — this is the exploitable assumption.

### Pinning the Certificate or Public Key

The application developer extracts the pin at build time and bundles it in the app binary or configuration file.

**Extracting a SHA-256 SPKI pin from a live server (OpenSSL):**

```bash
# Connect to the server and extract the public key hash (SPKI pin)
openssl s_client -connect api.example.com:443 -servername api.example.com 2>/dev/null \
  | openssl x509 -pubkey -noout \
  | openssl pkey -pubin -outform DER \
  | openssl dgst -sha256 -binary \
  | openssl enc -base64
```

This produces a Base64-encoded SHA-256 hash, such as:
```
47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=
```

**Extracting a certificate fingerprint directly:**

```bash
openssl s_client -connect api.example.com:443 2>/dev/null \
  | openssl x509 -fingerprint -sha256 -noout
# Output: SHA256 Fingerprint=AB:CD:EF:12:...
```

### Android Implementation (OkHttp / Java)

```java
// Using OkHttp 4.x — the most common Android HTTP client
OkHttpClient client = new OkHttpClient.Builder()
    .certificatePinner(
        new CertificatePinner.Builder()
            // Primary pin (current certificate key)
            .add("api.example.com",
                 "sha256/47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=")
            // Backup pin (next certificate key, pre-generated)
            .add("api.example.com",
                 "sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=")
            .build()
    )
    .build();
```

If the server presents a certificate whose SPKI hash does not match either pin, OkHttp throws `javax.net.ssl.SSLPeerUnverifiedException` and the connection is rejected.

### iOS Implementation (NSURLSession / Swift)

```swift
// Implement URLSessionDelegate for custom certificate validation
class PinnedSessionDelegate: NSObject, URLSessionDelegate {
    let pinnedPublicKeyHash = "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU="

    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust,
              let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0),
              let publicKey = SecCertificateCopyKey(certificate) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }

        // Extract and hash the public key, compare with pinned value
        // (full key extraction omitted for brevity — use TrustKit in production)
        let serverHash = extractSPKIHash(from: publicKey)
        if serverHash == pinnedPublicKeyHash {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
```

In production iOS apps, the **TrustKit** library provides a well-tested pinning implementation with reporting and backup pin support.

### Validation Flow During Connection

```
App initiates TLS → Server sends certificate chain
       ↓
App extracts leaf certificate public key (SPKI)
       ↓
App computes SHA-256 of DER-encoded SPKI
       ↓
App compares hash against pinned set
       ↓
Match? → Connection proceeds normally
No Match? → SSLPeerUnverifiedException / NSURLErrorCancelled → Connection aborted
```

The comparison happens **after** the normal TLS validation, so the certificate must also be cryptographically valid — pinning is an additional constraint, not a replacement for normal chain validation.

---

## Key Concepts

- **SPKI Pin**: The SHA-256 hash of the SubjectPublicKeyInfo field of a certificate — the preferred pin type because it is key-bound, not certificate-bound, surviving renewals where the same key pair is reused.
- **Certificate Fingerprint Pin**: A hash of the entire DER-encoded certificate binary; simpler to compute but invalidated every time the certificate is reissued, even with the same key.
- **Backup Pin**: A secondary pin embedded in the app pointing to a key pair that has been generated but not yet deployed; required for safe key rotation and recommended as a minimum of one per hostname.
- **Pin Rotation**: The operational process of updating the hardcoded trust anchor in a deployed application before the current certificate expires; requires coordinated app updates and backend certificate changes within the overlap window.
- **HPKP (HTTP Public Key Pinning)**: A now-deprecated RFC 7469 standard that allowed servers to instruct browsers to pin their public keys via the `Public-Key-Pins` HTTP response header; abandoned due to catastrophic misconfiguration risks and hostile-pin abuse.
- **Dynamic Pinning**: An approach where the pin is fetched from a trusted endpoint at runtime rather than hardcoded at build time; reduces rotation complexity but introduces a bootstrapping trust problem — the initial fetch must itself be secured.
- **Trust on First Use (TOFU)**: A related pattern where the first observed certificate is pinned automatically; provides protection against future MITM attacks but not the initial connection.
- **CAA Record**: A DNS-based mechanism (`Certification Authority Authorization`) that restricts which CAs may issue certificates for a domain; a complementary control to pinning for web contexts.

---

## Exam Relevance

**Security+ SY0-701** tests certificate pinning primarily under Domain 4 (Operations and Incident Response) and Domain 1 (Threats, Attacks, and Vulnerabilities) in the context of mobile security and application hardening.

**Common question patterns:**
- *Scenario*: A mobile banking app continues to fail with SSL errors after the company renewed its web certificate. What was likely not updated? → **The pinned certificate in the app binary.**
- *Which technique prevents MITM attacks even when an attacker has a CA-signed rogue certificate?* → **Certificate pinning.**
- *What is the risk of HPKP?* → **An attacker who briefly hijacks traffic can set a malicious pin, permanently locking legitimate users out (pin bombing/hostile pinning).**
- *Distinguish certificate pinning from certificate stapling* → Pinning embeds trusted endpoint credentials in the client; [[OCSP Stapling]] embeds revocation status in the server's TLS handshake response.

**Gotchas for exam candidates:**
- Certificate pinning does **not** replace TLS — it supplements it. The certificate must still pass normal validation.
- Corporate SSL inspection proxies **intentionally break** certificate pinning by inserting a proxy certificate; many enterprise MDM solutions deploy the proxy CA as a trusted root, but if the app pins a specific leaf cert, the proxy's substituted cert will still fail.
- **Public key pinning ≠ certificate pinning** — know the distinction and why SPKI pinning is operationally superior.
- HPKP is **deprecated** — do not recommend it as a current solution on the exam.

---

## Security Implications

### Bypassing Pinning (Attack Vectors)

The primary attack against certificate pinning is **runtime hook injection** using tools like **Frida** or **Objection**. These dynamic instrumentation frameworks can patch the in-memory SSL validation logic of a running app to always return success, regardless of the server certificate presented:

```bash
# Using Objection (Frida-based) to bypass Android SSL pinning
objection --gadget "com.example.banking" explore
# Within Objection console:
android sslpinning disable
```

This is the standard technique used in mobile penetration testing and bug bounty research. It requires a rooted Android device or jailbroken iOS device, or a repackaged APK with a Frida gadget embedded.

**Other bypass techniques:**
- **Custom ROM / Debug Build**: Rooted device with SSL kill switch installed.
- **Xposed Framework modules** (Android): Modules like `SSLUnpinning` or `JustTrustMe` patch the Java SSL classes system-wide.
- **Recompilation**: Decompile the APK (using `apktool`), modify the network security config or smali bytecode to remove pin checks, recompile and re-sign.
- **Network Security Configuration Abuse** (Android): If an app incorrectly relies solely on `network_security_config.xml` rather than code-level pinning, this XML can be modified in a repackaged APK.

### Real-World CVEs and Incidents

- **CVE-2016-2402 (OkHttp)**: A vulnerability where hostname verification could be bypassed in certain OkHttp versions, partially undermining pinning implementations built on top of it.
- **DigiNotar Breach (2011)**: The watershed incident motivating widespread pinning adoption; attackers issued 531 fraudulent certificates including for `*.google.com`, used to intercept Iranian Gmail users. Google's hardcoded pins for Google domains in Chrome were the primary detection mechanism.
- **HPKP "Ransom" Attacks**: Proof-of-concept attacks demonstrated that a temporary MITM attacker could set hostile HPKP headers with max-age of months or years, effectively DoSing the legitimate site for all affected users.
- **Superfish/eDellRoot (2015)**: Pre-installed adware on Lenovo laptops installed a self-signed root CA, allowing MITM of all TLS traffic — a scenario where pinning in sensitive apps would have been the only reliable defense.

---

## Defensive Measures

### For Application Developers

1. **Use SPKI pinning, not certificate pinning**, to decouple pin validity from certificate expiry cycles.
2. **Always include at least one backup pin** for a key pair that is securely generated, stored offline, and ready to deploy. OkHttp and TrustKit both support multi-pin sets natively.
3. **Set pin expiry windows** — if using HPKP (legacy), set `max-age` to a short value (≤30 days) until you have validated the operational process.
4. **Implement a reporting endpoint** — both TrustKit (iOS) and custom Android implementations can POST pin failure reports to a server, providing early warning of MITM attacks or misconfiguration.
5. **Use established libraries** rather than hand-rolling validation:
   - **Android**: OkHttp `CertificatePinner`, TrustKit-Android
   - **iOS**: TrustKit, Apple's `NSURLSession` with custom delegates
   - **Python**: `requests` library with `ssl` module + manual fingerprint verification
   - **.NET**: `HttpClientHandler.ServerCertificateCustomValidationCallback`

```python
# Python: manual certificate fingerprint verification
import ssl
import hashlib
import socket
import base64

PINNED_HASH = "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU="

def get_cert_spki_hash(hostname, port=443):
    ctx = ssl.create_default_context()
    with socket.create_connection((hostname, port)) as sock:
        with ctx.wrap_socket(sock, server_hostname=hostname) as ssock:
            cert_der = ssock.getpeercert(binary_form=True)
            # For full SPKI extraction, use cryptography library
            from cryptography import x509
            from cryptography.hazmat.primitives import serialization
            cert = x509.load_der_x509_certificate(cert_der)
            spki = cert.public_key().public_bytes(
                serialization.Encoding.DER,
                serialization.PublicFormat.SubjectPublicKeyInfo
            )
            digest = hashlib.sha256(spki).digest()
            return base64.b64encode(digest).decode()

observed = get_cert_spki_hash("api.example.com")
assert observed == PINNED_HASH, f"PIN MISMATCH: {observed}"
```

### For Enterprise Security Teams

- **MDM Policies**: Deploy mobile device management solutions (Jamf, Intune) that prevent sideloading of modified APKs and prevent rooting/jailbreaking.
- **Runtime Application Self-Protection (RASP)**: Solutions like Guardsquare DexGuard