---
domain: "cryptography"
tags: [code-signing, pki, integrity, authentication, software-supply-chain, certificates]
---
# Code Signing

**Code signing** is the practice of applying a [[Digital Signature]] to software executables, scripts, and packages to cryptographically verify the **identity of the publisher** and the **integrity of the code**. It relies on [[Public Key Infrastructure]] (PKI) to bind a developer or organization's identity to a specific piece of software, ensuring that the code has not been tampered with since it was signed. Code signing is a foundational control in [[Software Supply Chain Security]] and is enforced by operating systems, app stores, and enterprise policy engines.

---

## Overview

Code signing emerged as a practical response to the explosion of software distribution over untrusted networks, particularly the internet. Before code signing became standard, users had no reliable way to verify whether a downloaded executable came from the claimed vendor or whether it had been modified in transit or at rest by a malicious actor. Microsoft's Authenticode, introduced in the mid-1990s, was one of the earliest widespread implementations, and today virtually every major platform — Windows, macOS, iOS, Android, and Linux (via GPG-signed packages or Secure Boot) — incorporates code signing as a core security mechanism.

At its core, code signing is an application of [[Asymmetric Cryptography]]. A developer or organization obtains a **code signing certificate** from a trusted [[Certificate Authority]] (CA). This certificate binds the publisher's public key to their verified identity (individual or organization). The developer then uses their **private key** to generate a cryptographic hash of the software artifact and sign that hash, producing a signature that is bundled with the software. When a user or operating system executes the software, it re-hashes the file, decrypts the signature using the public key embedded in the certificate, compares the two hashes, and validates the certificate chain up to a trusted root CA.

The practical effect of code signing is twofold: it provides **authenticity** (you know who wrote the software) and **integrity** (you know the software hasn't been modified). What it does *not* inherently guarantee is that the software is *safe* or *free of vulnerabilities* — a legitimate, signed application can still be malicious if the developer is malicious, or if a legitimate developer's signing key is stolen. This distinction is critical for security practitioners and exam candidates alike.

Code signing interacts deeply with operating system security features. On Windows, [[User Account Control]] (UAC) presents different prompts depending on whether software is signed and by what type of certificate. Windows SmartScreen reputation systems use signing data to inform warnings. On macOS, **Gatekeeper** enforces signing policies, and Apple's **notarization** process adds an additional layer where Apple itself scans the software and issues a ticket. On Linux, package managers like `apt` and `dnf` use GPG signatures to verify package authenticity before installation.

In enterprise environments, code signing is integrated with [[Application Whitelisting]] and policies such as Windows Defender Application Control (WDAC) and AppLocker, which can require that all executed code be signed by specific trusted certificates. This dramatically reduces the attack surface for unsigned malware and living-off-the-land attacks that rely on unsigned scripts.

---

## How It Works

### The Signing Process

Code signing follows a strict sequence involving hashing, asymmetric encryption, and certificate validation.

**Step 1 — Obtain a Code Signing Certificate**

The developer purchases or generates a code signing certificate from a CA (e.g., DigiCert, Sectigo, GlobalSign) or an internal enterprise CA. The CA verifies the requester's identity through an Organization Validation (OV) or Extended Validation (EV) process. EV certificates require more rigorous vetting and carry higher trust in Windows SmartScreen.

```bash
# Generate a CSR for a code signing certificate using OpenSSL
openssl genrsa -out codesign.key 4096
openssl req -new -key codesign.key -out codesign.csr \
  -subj "/C=US/ST=Texas/O=ExampleCorp/CN=ExampleCorp Code Signing"
```

**Step 2 — Hash the Software Artifact**

Before signing, a cryptographic hash of the software binary is computed. Common algorithms are SHA-256 (required by modern Windows Authenticode) and SHA-384/512.

```bash
# Compute SHA-256 hash of a Windows executable
sha256sum myapplication.exe
# Output: e3b0c44298fc1c149afb... myapplication.exe

# Equivalent PowerShell command
Get-FileHash -Algorithm SHA256 .\myapplication.exe
```

**Step 3 — Sign the Hash with the Private Key**

The hash is encrypted (signed) using the developer's private key. In Authenticode, this process also embeds a timestamp from a Timestamping Authority (TSA) so the signature remains valid even after the certificate expires.

```bash
# Sign a Windows executable using signtool.exe (Windows SDK)
signtool sign /fd SHA256 /a /tr http://timestamp.digicert.com \
  /td SHA256 /f codesign.pfx /p password myapplication.exe

# Verify the signature
signtool verify /pa /v myapplication.exe
```

```bash
# Sign a macOS application bundle using codesign
codesign --sign "Developer ID Application: ExampleCorp (TEAMID)" \
  --timestamp --options runtime ./MyApp.app

# Verify
codesign --verify --deep --strict --verbose=2 ./MyApp.app
```

**Step 4 — Embed Signature in the Artifact**

The signature, certificate chain, and timestamp token are embedded directly into the PE (Portable Executable) file in a special section called the **WIN_CERTIFICATE** section, or alongside the package in detached signature files (common in RPM/DEB packages).

**Step 5 — Certificate Chain Validation at Runtime**

When the OS loads the executable:
1. It extracts the embedded certificate and signature.
2. It walks the certificate chain: `Leaf (Code Signing Cert) → Intermediate CA → Root CA`.
3. It checks each certificate for validity: dates, revocation status (via [[OCSP]] or [[CRL]]).
4. It recomputes the hash of the executable and compares it to the decrypted signature hash.
5. If everything matches and the root CA is in the OS trusted store, the signature is valid.

```powershell
# PowerShell: Check the Authenticode signature of a file
Get-AuthenticodeSignature -FilePath "C:\Program Files\App\myapp.exe" | 
  Select-Object Status, SignerCertificate, TimeStamperCertificate

# Check a certificate's thumbprint against known trusted signers
(Get-AuthenticodeSignature ".\myapp.exe").SignerCertificate.Thumbprint
```

**GPG Signing for Linux Packages**

```bash
# Import a distribution's signing key
gpg --import /etc/apt/trusted.gpg.d/ubuntu-keyring.gpg

# Verify a downloaded package manually
gpg --verify package.deb.sig package.deb

# Sign a custom package
gpg --armor --detach-sign package.tar.gz
```

**Timestamp Authorities (TSA)**

RFC 3161 defines the TSA protocol. The signer sends the hash of the signature to the TSA, which returns a signed timestamp token. This process uses port **318** (official) but most commercial TSAs operate over **HTTP/HTTPS (port 80/443)**.

---

## Key Concepts

- **Code Signing Certificate**: An X.509 certificate with an Extended Key Usage (EKU) OID of `1.3.6.1.5.5.7.3.3` (Code Signing), issued by a CA and binding a public key to a verified publisher identity.
- **Authenticode**: Microsoft's code signing technology embedded in the PE/COFF binary format; supports dual-signing (SHA-1 legacy + SHA-256 modern) and counter-signatures for timestamping.
- **Timestamping Authority (TSA)**: A trusted third-party service that issues RFC 3161-compliant timestamp tokens, allowing signed code to remain verifiable after the signing certificate expires.
- **Extended Validation (EV) Code Signing**: A higher-assurance certificate class requiring hardware token storage of the private key (HSM or USB token) and more rigorous CA vetting; grants immediate SmartScreen reputation on Windows.
- **Notarization (macOS)**: Apple's process beyond code signing where the developer submits the binary to Apple's automated scanning service, which issues a "notarization ticket" stapled to the app; required for distribution outside the Mac App Store on modern macOS versions.
- **Certificate Revocation**: The process by which a CA invalidates a code signing certificate before expiry (via CRL or OCSP), critical when a private key is compromised; operating systems check revocation status during validation.
- **Catalog Signing**: A Windows mechanism where a separate `.cat` (catalog) file contains hashes of multiple files, signed once; used extensively by Windows Update and driver signing to avoid modifying original binaries.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Code signing appears primarily under **Domain 1.0 (General Security Concepts)** — specifically cryptographic concepts and integrity controls — and **Domain 2.0 (Threats, Vulnerabilities, and Mitigations)** in the context of supply chain attacks.

**Key exam tips:**

- The Security+ exam frequently tests the **distinction between code signing and encryption**: code signing provides *integrity* and *authentication* (non-repudiation), NOT confidentiality. If a question asks what code signing protects against, think *tampering* and *impersonation*, not *eavesdropping*.
- Know that code signing uses **asymmetric cryptography**: the developer signs with their **private key**, and users verify with the **public key** in the certificate.
- **Non-repudiation** is a core benefit: once code is signed, the developer cannot deny having signed it (assuming key security).
- Understand the **chain of trust**: a code signing certificate is only as trustworthy as the CA that issued it. Compromised CAs (DigiNotar, 2011) are a recurring exam theme.
- Timestamping is tested as a reason signatures remain valid after certificate expiry — a common gotcha.
- Questions may present a scenario where malware is signed with a *stolen legitimate certificate* and ask whether the OS would warn the user — the correct answer is typically **no**, the OS would treat it as trusted.
- **Driver signing** on Windows 64-bit requires kernel-mode code to be signed by Microsoft's cross-certificate chain; unsigned drivers are blocked by default.

---

## Security Implications

### Weaknesses and Attack Vectors

**Stolen Signing Keys**: The most direct attack. If an attacker compromises a developer's private signing key, they can sign arbitrary malware that will be trusted by the OS. This occurred in the **ASUS ShadowHammer attack (2019)**, where attackers compromised ASUS's software update servers and signed malicious updates with ASUS's legitimate certificate, affecting ~1 million machines before discovery.

**Compromised Certificate Authorities**: If a CA is compromised, attackers can issue fraudulent code signing certificates for any organization. The **DigiNotar breach (2011)** and the **Comodo breach (2011)** demonstrated this catastrophic failure mode. While these cases involved TLS certificates primarily, the same attack model applies to code signing CAs.

**Stuxnet (2010)**: Used legitimate stolen certificates from Realtek Semiconductor and JMicron Technology to sign its rootkit drivers. This allowed Stuxnet to bypass Windows driver signing requirements and install kernel-level components undetected, representing one of the most sophisticated abuse of code signing in history.

**Certificate Validity Drift**: Signed malware with legitimate but expired certificates is still sometimes executed on improperly configured systems that don't enforce revocation checking, or on systems where revocation checking fails open (allows execution) due to network issues.

**CVE-2020-0601 ("CurveBall")**: A critical Windows vulnerability in `crypt32.dll` that allowed attackers to spoof ECC-based certificates, including code signing certificates. An attacker could forge a certificate that Windows would validate as legitimate, enabling signed malware without a real CA-issued certificate.

**Weak Hash Algorithms**: Legacy Authenticode signatures using SHA-1 are vulnerable to collision attacks. Microsoft deprecated SHA-1 Authenticode in 2016. However, old binaries still carrying SHA-1-only signatures in enterprise environments create a false sense of trust.

**Overprivileged Build Pipelines**: CI/CD systems with access to code signing certificates are high-value targets. The **SolarWinds Orion attack (2020)** involved attackers injecting malicious code into the build process before signing, meaning the malicious SUNBURST backdoor was legitimately signed with SolarWinds' certificate.

---

## Defensive Measures

**1. Protect Private Keys with Hardware Security Modules (HSMs)**

Store code signing private keys exclusively in FIPS 140-2 Level 2+ HSMs or hardware tokens. Never allow private keys to exist on developer workstations or build servers in plaintext.

```bash
# Example: Sign using a key stored in a PKCS#11 HSM
osslsigncode sign -pkcs11engine /usr/lib/engines/pkcs11.so \
  -pkcs11module /usr/lib/opensc-pkcs11.so \
  -certs codesign.pem -key "pkcs11:token=MyToken;id=%01" \
  -ts http://timestamp.digicert.com \
  -in unsigned.exe -out signed.exe
```

**2. Implement Certificate Pinning and Thumbprint Allowlisting**

In enterprise environments, use WDAC or AppLocker to only trust signatures from specific certificate thumbprints, not the entire CA hierarchy.

```powershell
# WDAC policy: Allow only apps signed by a specific leaf certificate
# Use New-CIPolicy and Set-RuleOption in PowerShell
New-CIPolicyRule -Level FilePublisher -DriverFilePath "C:\App\myapp.exe"
```

**3. Enforce Revocation Checking**

Configure operating systems and browsers to fail-closed on revocation checks (treat OCSP/CRL unavailability as revoked), rather than fail-open.

```powershell
# Windows: Force revocation checking via Group Policy
# Computer Configuration > Windows Settings > Security Settings >
# Public Key Policies > Certificate Path Validation Settings
# Enable: "Always check for revocation"

# Verify current setting via registry
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SystemCertificates\AuthRoot" |
  Select-Object EnableDisallowedCertAutoUpdate
```

**4. Secure CI/CD Signing Pipelines**

- Isolate signing operations to dedicated, air-gapped or minimally networked signing servers.
- Implement separation of duties: code review must be complete before signing is triggered.
- Use ephemeral signing environments that are torn down after each build.
- Log all signing operations to a SIEM with anomaly alerting on signing volume or off-hours activity.

**5. Monitor for Signed Malware Indicators**

Deploy EDR solutions configured to alert on:
- Known-bad certificate thumbprints (IOCs from threat feeds).
- Executables signed by CAs not in your approved list.
- Scripts (PowerShell, Python) signed with certificates not matching your internal CA.

```powershell
# Enumerate all signed executables in a directory and log their certificate info
Get-ChildItem -Path "C:\Suspicious\" -Filter "*.exe" -Recurse | ForEach-Object {
    $sig = Get-AuthenticodeSignature $_.FullName
    [PSCustomObject]@{
        File = $_.FullName
        Status = $sig.Status
        Thumbprint = $sig.SignerCertificate.Thumbprint
        Subject = $sig.SignerCertificate.Subject
        Issuer = $sig.SignerCertificate.Issuer
    }
} | Export-Csv signed_audit.csv -NoTypeInformation
```

**6. Enforce EV Certificates for Public Distribution**

Require EV code signing certificates for any software distributed to external customers, as EV certificates require HSM storage by policy and carry higher SmartScreen reputation.

---

## Lab / Hands-On

### Lab 1: Create a Self-Signed Code Signing Certificate and Sign a Script

This lab demonstrates the full signing workflow using OpenSSL and Windows tools in a homelab environment.

```bash
# Step 1: Generate a root CA (homelab only)
openssl genrsa -out labCA.