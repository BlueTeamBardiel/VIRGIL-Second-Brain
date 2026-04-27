---
domain: "identity and access management"
tags: [authentication, identity, access-control, cryptography, protocols, security-fundamentals]
---
# Authentication

**Authentication** is the process of verifying that an entity — a user, device, or service — is genuinely who or what it claims to be, forming the first pillar of the **AAA (Authentication, Authorization, and Accounting)** framework. It is distinct from [[authorization]], which determines *what* an authenticated entity is permitted to do, and from [[identification]], which is merely the act of asserting an identity. Authentication mechanisms underpin virtually every security boundary in modern infrastructure, from logging into a workstation to establishing a [[TLS]] session between servers.

---

## Overview

Authentication exists because digital systems cannot rely on physical presence or visual recognition to confirm identity. In a networked environment, any actor can claim to be any other — without a rigorous verification mechanism, there is no basis for trust. Authentication solves this by requiring the claimant to produce evidence that only the legitimate entity should possess, know, or inherently have. The strength of that evidence determines the assurance level of the authentication event.

Historically, authentication began with simple shared secrets: a username and password. This model, while intuitive, is fundamentally fragile. Passwords can be guessed, intercepted, reused, or stolen in bulk through database breaches. The security industry has responded by layering additional factors — possession of a hardware token, biometric characteristics, or cryptographic keys — and by evolving toward password-less paradigms altogether. The trajectory of authentication design consistently moves toward higher assurance with lower user friction.

Authentication occurs at multiple layers of a system stack simultaneously. A user authenticates to their operating system via [[Kerberos]] or local credential verification. Their browser authenticates the web server using a [[TLS certificate]] issued by a trusted [[Certificate Authority]]. The web application then authenticates the user via a session cookie, [[OAuth 2.0]] token, or SAML assertion. Each of these events is a distinct authentication act with its own protocol, assurance level, and failure mode. Understanding where each occurs is critical for security analysis.

Modern enterprise authentication is rarely local. Directory services such as [[Active Directory]] and [[LDAP]]-based systems centralize identity stores, allowing a single set of credentials to authenticate a user to thousands of resources. [[Single Sign-On (SSO)]] systems like [[SAML]], [[OpenID Connect]], and [[OAuth 2.0]] federate this trust across organizational boundaries and into cloud services. This consolidation improves usability but creates a high-value target — compromising the identity provider (IdP) can yield access to every federated resource simultaneously.

Authentication assurance is formally described by the NIST SP 800-63 Digital Identity Guidelines, which defines three Authenticator Assurance Levels (AAL1, AAL2, AAL3). AAL1 requires at least single-factor authentication. AAL2 requires multi-factor authentication (MFA). AAL3 requires hardware-based cryptographic authenticators and verifier impersonation resistance. These levels map directly to risk decisions: a high-value financial transaction might require AAL3, while reading a public knowledge base article might require only AAL1.

---

## How It Works

### The Core Authentication Exchange

Every authentication protocol follows a common abstract pattern:

1. **Identification** — The claimant presents an identity claim (e.g., username, certificate subject, account ID).
2. **Challenge** — The verifier presents a challenge, explicitly (a nonce, a CAPTCHA, a push notification) or implicitly (prompting for credentials).
3. **Response** — The claimant provides authentication evidence (password hash, signed token, biometric match, OTP).
4. **Verification** — The verifier checks the response against its reference data (stored hash, public key, enrollment template).
5. **Result** — The verifier issues an authentication result: success (session token, ticket, assertion) or failure.

### Password-Based Authentication

The most common mechanism. The server stores a **hashed and salted** version of the password. During authentication:

```
User submits: username="alice", password="S3cur3P@ss!"
Server retrieves: stored_hash = bcrypt("S3cur3P@ss!" + salt)
Server computes: bcrypt(submitted_password + salt)
Server compares: computed_hash == stored_hash → PASS
```

Modern storage uses adaptive hash functions: **bcrypt**, **Argon2id**, or **scrypt**. These are intentionally slow, making brute-force attacks computationally expensive.

**NEVER** use MD5 or SHA-1 alone for password storage — they are fast hash functions designed for data integrity, not password storage.

### Challenge-Response Authentication (NTLM Example)

Windows NTLM uses a challenge-response to avoid transmitting the password over the wire:

```
Client → Server: NEGOTIATE_MESSAGE (capabilities)
Server → Client: CHALLENGE_MESSAGE (8-byte nonce)
Client → Server: AUTHENTICATE_MESSAGE (NT hash of password XOR'd with nonce)
Server verifies via domain controller or local SAM
```

This avoids password transmission but is vulnerable to [[Pass-the-Hash]] attacks because the NT hash *is* the authenticator.

### Kerberos (Port 88/TCP and UDP)

Used in Active Directory environments:

```
1. Client → KDC (AS): Authentication Service Request (AS-REQ)
   - Includes: username, timestamp encrypted with user's key (derived from password)
2. KDC → Client: AS-REP
   - TGT (Ticket Granting Ticket) encrypted with krbtgt key
   - Session key encrypted with user's key
3. Client → KDC (TGS): Ticket Granting Request
   - Presents TGT + authenticator
4. KDC → Client: Service Ticket (TGS-REP)
5. Client → Service: AP-REQ with service ticket
6. Service decrypts ticket, verifies, grants access
```

```bash
# Request a Kerberos ticket on Linux
kinit alice@CORP.LOCAL
klist  # View current tickets
```

### Certificate-Based Authentication (mTLS)

Mutual TLS authenticates both client and server using X.509 certificates:

```
1. TLS handshake begins (Client Hello)
2. Server presents certificate → Client validates against trusted CA
3. Server requests client certificate
4. Client presents certificate → Server validates against trusted CA or CRL/OCSP
5. Both parties derive session keys from DH exchange
6. Encrypted session established with mutual identity assurance
```

```bash
# Test mTLS with curl
curl --cert client.crt --key client.key --cacert ca.crt https://service.corp.local/api
```

### TOTP (Time-Based One-Time Passwords — RFC 6238)

Used in authenticator apps (Google Authenticator, Authy, FreeOTP):

```
TOTP = HMAC-SHA1(shared_secret, floor(current_unix_time / 30))
Result truncated to 6 digits
Valid for a 30-second window (typically ±1 window for clock drift)
```

```python
import pyotp
totp = pyotp.TOTP("JBSWY3DPEHPK3PXP")  # Base32 secret
print(totp.now())         # Current OTP
print(totp.verify("123456"))  # Verify a code
```

### LDAP Authentication (Port 389/TCP, LDAPS 636/TCP)

```bash
# Simple bind authentication test
ldapsearch -H ldap://dc01.corp.local -D "cn=alice,dc=corp,dc=local" \
  -w 'P@ssw0rd' -b "dc=corp,dc=local" "(uid=alice)"

# Anonymous bind (check if allowed — security risk)
ldapsearch -H ldap://dc01.corp.local -x -b "dc=corp,dc=local"
```

### RADIUS Authentication (Port 1812/UDP)

Used for network access control (Wi-Fi, VPN, 802.1X):

```
Supplicant → Authenticator (AP/Switch) → RADIUS Server
Access-Request (username + password hashed with shared secret)
← Access-Accept / Access-Reject / Access-Challenge
```

---

## Key Concepts

- **Something You Know (Type 1 Factor)** — Knowledge-based authenticators: passwords, PINs, security questions. The weakest category individually; susceptible to guessing, phishing, and database compromise.
- **Something You Have (Type 2 Factor)** — Possession-based authenticators: TOTP apps, hardware security keys (YubiKey), smart cards, SMS OTP. Stronger than knowledge factors when combined; SMS OTP is considered the weakest possession factor due to SIM-swapping vulnerability.
- **Something You Are (Type 3 Factor)** — Inherence-based authenticators: fingerprints, retinal scans, facial recognition, voice patterns. High usability but raises privacy concerns and can be spoofed with sufficient effort; cannot be changed if compromised.
- **Multi-Factor Authentication (MFA)** — Requiring two or more distinct factor *types* simultaneously. A password + TOTP code = MFA. Two passwords = NOT MFA (same factor type). MFA dramatically reduces account takeover risk, even against credential-stuffing attacks.
- **Authenticator Assurance Level (AAL)** — NIST SP 800-63B classification: AAL1 (single factor), AAL2 (MFA, software or hardware), AAL3 (hardware cryptographic authenticator with verifier impersonation resistance, e.g., FIDO2/WebAuthn with PIN).
- **Federated Identity** — Delegating authentication to a trusted external Identity Provider (IdP) via SAML 2.0, OpenID Connect, or WS-Federation. The relying party trusts assertions made by the IdP rather than verifying credentials directly.
- **Context-Aware / Adaptive Authentication** — Adjusting authentication requirements based on risk signals: user location, device health, time of day, behavioral biometrics. If a user who normally logs in from Boston suddenly authenticates from Kyiv, step-up authentication is triggered.
- **Passwordless Authentication** — Eliminating shared secrets entirely in favor of public-key cryptography (FIDO2/WebAuthn, passkeys). The private key never leaves the device; the server stores only the public key. Resistant to phishing and credential stuffing by design.

---

## Exam Relevance

**SY0-701 Domain Mapping:** This topic falls primarily under **Domain 4.0 — Security Operations** and **Domain 5.0 — Security Program Management**, with significant overlap into **Domain 1.0 — General Security Concepts** (AAA framework).

**High-Frequency Exam Patterns:**

- **Distinguishing Authentication vs. Authorization vs. Accounting** — Exam questions frequently test whether you know that authentication = *who are you*, authorization = *what can you do*, accounting = *what did you do*. These are commonly presented as scenario questions where you must identify which AAA component is missing.

- **Factor Type Classification** — Be prepared to classify authenticators correctly: a PIN is Type 1 (something you know), not Type 2 even if entered on a physical device. A hardware token displaying a code is Type 2. A fingerprint reader is Type 3. Exam distractors often conflate the device with the factor.

- **MFA vs. 2FA vs. Dual-Factor** — The exam treats these as effectively synonymous. The critical point: factors must be *different types*. Two knowledge factors (password + security question) is NOT MFA.

- **Protocol Ports** — Know these cold:
  - Kerberos: **88**
  - LDAP: **389** (plaintext), LDAPS: **636** (encrypted)
  - RADIUS: **1812** (auth), **1813** (accounting)
  - TACACS+: **49** (TCP)
  - DIAMETER: **3868**

- **TACACS+ vs. RADIUS** — RADIUS encrypts only the password in the Access-Request; TACACS+ encrypts the entire payload. TACACS+ separates authentication, authorization, and accounting into distinct processes. TACACS+ is preferred for device administration; RADIUS for network access (802.1X).

- **Common Gotchas:**
  - SSO reduces the number of authentication events, which *reduces* the attack surface *per resource* but *increases* the impact of a single credential compromise.
  - Biometrics generate **false acceptance rate (FAR)** and **false rejection rate (FRR)** errors — the **crossover error rate (CER)** is where they intersect and represents the balance point.
  - **Federation ≠ SSO** — Federation enables SSO across organizational boundaries, but SSO can exist within a single organization without federation.

---

## Security Implications

### Attack Vectors

**Credential Stuffing:** Automated use of username/password pairs from data breaches against other services. Effective because users reuse passwords. Mitigation: MFA, breach password monitoring (Have I Been Pwned API), rate limiting.

**Phishing and Adversary-in-the-Middle (AiTM):** Tools like **Evilginx2** and **Modlishka** act as reverse proxies, relaying credentials and session cookies in real time. These attacks bypass traditional MFA by stealing the post-authentication session token. Mitigation: phishing-resistant MFA (FIDO2/WebAuthn), token binding.

**Pass-the-Hash (PtH):** Capturing the NTLM hash from memory (via Mimikatz `sekurlsa::logonpasswords`) and using it directly without knowing the plaintext password. The hash is functionally equivalent to the password in NTLM authentication.

```powershell
# Attacker perspective (requires admin): extract NTLM hashes
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords"
# Use captured hash for lateral movement
pth-winexe -U CORP/Administrator%aad3b435b51404eeaad3b435b51404ee:8846f7eaee8fb117ad06bdd830b7586c //target-host cmd.exe
```

**Kerberoasting:** Requesting service tickets for accounts with SPNs (Service Principal Names) and cracking the ticket offline, since tickets are encrypted with the service account's password hash:

```bash
# Enumerate SPNs and request tickets
GetUserSPNs.py -request CORP.LOCAL/alice:'Password123' -dc-ip 192.168.1.10
# Crack offline
hashcat -m 13100 kerberoast_hashes.txt rockyou.txt
```

**SIM Swapping:** Social engineering a mobile carrier to transfer a victim's phone number to attacker-controlled SIM. Defeats SMS-based MFA entirely. Documented in the 2019 Twitter CEO Jack Dorsey account takeover and the 2022 Coinbase breach.

**Brute Force and Password Spraying:** Brute force tries many passwords against one account (risks lockout). Password spraying tries one common password across many accounts (evades lockout policies). Spray tools: `Spray`, `MSOLSpray` for Microsoft 365, `kerbrute` for Kerberos.

### Real Incidents

- **2020 SolarWinds (SUNBURST):** Attackers forged SAML tokens (Golden SAML attack) after compromising the on-premises AD FS signing certificate, gaining access to cloud resources without triggering authentication anomalies.
- **2022 Uber Breach:** Attacker obtained VPN credentials from dark web, then bombarded the employee with MFA push notifications (MFA fatigue/push bombing) until the employee accepted one.
- **CVE-2021-42278 / CVE-2021-42287 (noPac):** Allowed privilege escalation to Domain Admin by exploiting Kerberos PAC logic, effectively forging high-privilege Kerberos tickets.

---

## Defensive Measures

### Password Controls
- Enforce minimum 12-character passwords per NIST SP 800-63B; **remove complexity rules** and periodic rotation requirements — NIST explicitly recommends against arbitrary rotation as it encourages weak patterns.
- Screen new passwords against known breach databases using the **Have I Been Pwned k-anonymity API** or tools like `pass_audit`.
- Store passwords with **Argon2id** (first choice), bcrypt (work factor ≥ 12), or scrypt. Never MD5, SHA-1, or unsalted SHA-256.

### MFA Deployment
- Prioritize **FIDO2/WebAuthn** (hardware security keys or device-bound passkeys) — the only MFA resistant to real-time ph