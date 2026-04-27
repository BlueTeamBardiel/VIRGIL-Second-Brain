---
domain: "identity-and-access-management"
tags: [authentication, mfa, identity, access-control, security-controls, cryptography]
---
# 2FA

**Two-Factor Authentication (2FA)** is a security mechanism that requires users to present two distinct forms of evidence — called **authentication factors** — before being granted access to a system, application, or resource. It is a subset of the broader [[Multi-Factor Authentication]] (MFA) framework and significantly reduces the risk of unauthorized access stemming from [[credential compromise]]. 2FA operates on the principle that requiring something you *know* plus something you *have* (or *are*) makes account takeover exponentially more difficult than relying on [[passwords]] alone.

---

## Overview

The motivation for 2FA arises from the fundamental weakness of single-factor authentication: passwords. Passwords can be guessed, phished, reused across sites, leaked in [[data breaches]], or cracked offline. According to Verizon's Data Breach Investigations Reports, compromised credentials consistently account for over 80% of hacking-related breaches. A second factor adds a layer of proof that an attacker typically cannot obtain simply by stealing a password database.

2FA was formalized and widely adopted following large-scale breaches in the 2010s. Google made 2FA available to all users in 2011, and industry standards bodies like the IETF and NIST began publishing guidance — most notably NIST Special Publication 800-63B (Digital Identity Guidelines) — that shaped how organizations implement second-factor controls. NIST 800-63B classifies authenticators into three assurance levels (AAL1, AAL2, AAL3) and provides specific guidance on which second-factor methods meet each level.

There are three canonical factor categories: **Knowledge factors** (something you know — passwords, PINs, security questions), **Possession factors** (something you have — hardware tokens, smartphones running authenticator apps, smart cards), and **Inherence factors** (something you are — fingerprints, facial recognition, retinal scans). True 2FA must combine factors from *two different categories*. Using a password plus a security question is technically single-factor (both are knowledge-based) and does not constitute genuine 2FA.

In practice, 2FA implementations range from SMS one-time passwords (OTPs) to hardware [[FIDO2]] security keys. Each method sits on a spectrum of convenience versus security. SMS OTPs are widely deployed but vulnerable to SIM-swapping attacks. Time-based OTP (TOTP) apps like Google Authenticator and Authy offer better security with no carrier dependency. Hardware tokens such as RSA SecurID or [[YubiKey]] devices provide the strongest commonly deployed second-factor controls, and FIDO2/[[WebAuthn]] hardware keys are considered phishing-resistant and are recommended by NIST AAL3.

The Security+ SY0-701 exam domain 4.6 (Identity and Access Management) and domain 2.4 (Authentication and Authorization) both include MFA/2FA concepts. Candidates should understand the factor categories, distinguish between TOTP and HOTP, understand the weaknesses of SMS-based OTP, and know when hardware tokens map to specific assurance levels.

---

## How It Works

### Authentication Flow

The general 2FA authentication flow involves two sequential verification steps after the user initiates a login:

```
User → Enter Username + Password → Server validates credentials
                                          ↓ (success)
                              Server requests second factor
                                          ↓
                User provides OTP / hardware token / biometric
                                          ↓ (success)
                              Access granted + session token issued
```

### TOTP (Time-Based One-Time Password) — RFC 6238

TOTP is the most widely used software-based second factor. It builds on HOTP (HMAC-based OTP, RFC 4226) by replacing a counter with the current Unix timestamp.

**Algorithm:**
1. During enrollment, the server generates a **shared secret** (typically a 20-byte random value encoded as Base32).
2. The secret is delivered to the user via a QR code (which encodes an `otpauth://` URI).
3. At login time, both the server and client independently compute:

```
TOTP(K, T) = HOTP(K, T)
           = Truncate(HMAC-SHA1(K, T))

Where:
  K = shared secret
  T = floor(current_unix_time / 30)   # 30-second time step
```

4. The resulting 6–8 digit code is valid for one 30-second window (servers typically accept ±1 window for clock drift).
5. Codes are invalidated after use to prevent replay attacks.

**Example `otpauth://` URI (encoded in QR code):**
```
otpauth://totp/MyService:user@example.com?secret=JBSWY3DPEHPK3PXP&issuer=MyService&algorithm=SHA1&digits=6&period=30
```

**Generating a TOTP manually with Python:**
```python
import hmac
import hashlib
import struct
import time
import base64

def get_totp(secret_base32: str, digits: int = 6, period: int = 30) -> str:
    key = base64.b32decode(secret_base32.upper())
    t = int(time.time()) // period
    msg = struct.pack(">Q", t)
    h = hmac.new(key, msg, hashlib.sha1).digest()
    offset = h[-1] & 0x0F
    code = struct.unpack(">I", h[offset:offset+4])[0] & 0x7FFFFFFF
    return str(code % (10 ** digits)).zfill(digits)

print(get_totp("JBSWY3DPEHPK3PXP"))
```

### HOTP (HMAC-Based OTP) — RFC 4226

HOTP uses a **counter** instead of time. The counter increments with each authentication attempt. This is used in hardware tokens like classic RSA SecurID devices. The risk is counter desynchronization if a user generates codes without completing authentication.

### SMS OTP

1. User enters credentials; server sends a one-time code via SMS to the registered phone number.
2. User enters the code within a short validity window (typically 5–10 minutes).
3. Server validates the code against what was sent.

**Weakness:** The SMS channel itself is not authenticated — it is vulnerable to SS7 protocol attacks, SIM-swapping, and real-time phishing proxies.

### FIDO2 / WebAuthn Hardware Keys

WebAuthn (W3C standard) combined with the CTAP2 protocol forms the FIDO2 specification:

1. Server sends a **challenge** (random nonce) to the browser.
2. Browser relays the challenge to the security key (USB/NFC/BLE).
3. The key signs the challenge using its **private key** bound to the specific relying party (origin).
4. Browser sends the signed assertion back to the server.
5. Server verifies the signature using the stored **public key**.

```
Relying Party (Server) ←→ Browser (WebAuthn API) ←→ Authenticator (YubiKey)
         |                          |                         |
    Sends challenge          Relays challenge          Signs with private key
    Verifies signature       Relays response           bound to origin
```

This flow is **phishing-resistant** because the origin is cryptographically bound to the key registration — a fake site cannot use a captured assertion against the real site.

### Push-Based 2FA (e.g., Duo Security)

1. User logs in with credentials.
2. Authentication server sends a push notification to the user's registered smartphone app.
3. User approves (or denies) the request in the app.
4. App communicates approval to the authentication server via HTTPS.
5. Access is granted or denied.

---

## Key Concepts

- **TOTP (Time-Based One-Time Password):** An OTP algorithm defined in RFC 6238 that generates a short-lived numeric code based on a shared secret and the current time, renewed every 30 seconds. Used by apps like Google Authenticator, Authy, and Microsoft Authenticator.

- **HOTP (HMAC-Based OTP):** Defined in RFC 4226, generates OTPs based on a shared secret and an incrementing counter rather than time. Used in hardware tokens; subject to counter drift if codes are generated but not used.

- **Shared Secret:** A cryptographic seed value established during 2FA enrollment, stored on both the server and the authenticator device. Compromise of this secret allows an attacker to generate valid OTPs independently.

- **SIM Swapping:** An attack in which a threat actor convinces a mobile carrier to transfer the victim's phone number to a SIM card the attacker controls, thereby receiving all SMS OTPs and defeating SMS-based 2FA. Famously used in the 2019 Twitter executive account compromises.

- **FIDO2 / WebAuthn:** A W3C and FIDO Alliance standard for public-key cryptography-based authentication using hardware security keys or platform authenticators (Touch ID, Windows Hello). Considered phishing-resistant because credentials are origin-bound.

- **Authenticator App:** A mobile application (Google Authenticator, Authy, Microsoft Authenticator) that implements TOTP/HOTP and stores the shared secret locally, generating codes without network connectivity.

- **Step-Up Authentication:** A security model in which a higher-risk action (e.g., changing a password, accessing sensitive data) triggers an additional authentication challenge mid-session, even if the user already authenticated with 2FA at login.

- **AAL (Authenticator Assurance Level):** NIST SP 800-63B framework levels — AAL1 (single factor acceptable), AAL2 (requires MFA, approves TOTP/hardware tokens), AAL3 (requires hardware-backed phishing-resistant authenticator + verifier impersonation resistance).

---

## Security Implications

### Attack Vectors Against 2FA

**1. Real-Time Phishing (Adversary-in-the-Middle)**
Tools like **Evilginx2** and **Modlishka** act as reverse proxies, intercepting both credentials and OTP codes in real time. The victim authenticates against the proxy, which relays credentials and the OTP to the real service, obtaining a session cookie. The attacker captures this cookie and replays it. This defeats TOTP but not FIDO2 (because origin binding breaks the attack).

**2. SIM Swapping**
The attacker social-engineers a carrier employee to port the victim's number, intercepting all future SMS OTPs. High-profile incidents include:
- **2019 Twitter breach** — attackers SIM-swapped employees and executives to gain access to the admin panel.
- **Crypto exchange account takeovers** — numerous cases resulting in millions of dollars in losses.

**3. SS7 Protocol Exploitation**
SS7 (Signaling System No. 7), the protocol underpinning global telecom routing, has known vulnerabilities (CVE-2014-7883 class issues) that allow attackers with SS7 access to intercept SMS messages without SIM swapping. Nation-state actors and specialized criminal groups have demonstrated this capability.

**4. OTP Phishing / Social Engineering**
Attackers call victims posing as support staff and request the OTP code verbally, or use automated bots (OTP bots) that call victims and convince them to read out codes. This is particularly effective against less security-aware users.

**5. Malware / Authenticator App Compromise**
If an attacker achieves code execution on the device running the authenticator app, they can extract TOTP seeds from unprotected storage. On Android, Cerberus malware (2020) demonstrated the ability to extract Google Authenticator TOTP codes via accessibility service abuse.

**6. Account Recovery Bypass**
Many services offer 2FA bypass through account recovery (backup codes, SMS fallback, support ticket). Attackers exploit weak recovery mechanisms to bypass 2FA entirely — the 2FA implementation is only as strong as its recovery path.

**CVE Reference:**
- **CVE-2022-35914 (GLPI TOTP bypass):** A vulnerability in the GLPI IT service management platform allowed bypassing 2FA through a session manipulation flaw.
- **CVE-2021-44228 class concerns:** Log4Shell demonstrated that even authenticated services can be compromised through entirely separate vectors, rendering 2FA moot post-exploitation.

---

## Defensive Measures

### Choose the Right Factor Method

| Method | Phishing Resistant | SIM-Swap Immune | Offline Capable | Recommended |
|---|---|---|---|---|
| SMS OTP | ✗ | ✗ | ✗ | Last resort only |
| TOTP App | ✗ | ✓ | ✓ | Good baseline |
| Push Notification | ✗ | ✓ | ✗ | Medium security |
| Hardware Key (FIDO2) | ✓ | ✓ | ✓ | Recommended |

### Policy and Configuration

1. **Disable SMS 2FA for privileged accounts.** Enforce TOTP or hardware keys for administrators, service accounts, and any account with access to sensitive systems.

2. **Enforce 2FA enrollment at account creation** — do not allow deferred enrollment. In Duo Security:
   ```
   New User Policy → Require Enrollment at First Login
   ```

3. **Protect recovery codes.** Recovery backup codes should be treated as secrets equivalent to the primary password. Store them in a [[password manager]] or offline safe.

4. **Implement MFA fatigue countermeasures.** Rate-limit push notification requests and add number-matching to push approvals (Microsoft Authenticator's "number matching" feature mitigates push bombing attacks like the 2022 Uber breach).

5. **Monitor for 2FA bypass attempts.** Alert on:
   - Multiple failed OTP submissions from the same IP
   - Successful logins immediately after failed OTP attempts (potential recovery abuse)
   - Logins from new geolocations after successful 2FA

6. **Use FIDO2/WebAuthn for high-value accounts.** Configure Nginx or Apache to require WebAuthn at the application layer, or use an identity proxy.

7. **Google Workspace / Azure AD Policy Example (Azure Conditional Access):**
   ```
   Conditional Access Policy:
   - Users: All Users
   - Cloud Apps: All Cloud Apps
   - Conditions: Any Location except Trusted IPs
   - Grant Controls: Require MFA (FIDO2 or Microsoft Authenticator)
   - Session: Sign-in Frequency: 8 hours
   ```

8. **Audit TOTP secret storage.** Secrets must be stored encrypted at rest. In applications, never log OTP values — treat them with the same sensitivity as passwords.

---

## Lab / Hands-On

### Lab 1: Deploy a TOTP-Protected SSH Server

Use `google-authenticator` PAM module to add TOTP to SSH on an Ubuntu/Debian host:

```bash
# Install PAM module
sudo apt update && sudo apt install libpam-google-authenticator -y

# Generate TOTP secret for current user
google-authenticator
# Answer: y to time-based, y to update .google_authenticator,
# y to disallow multiple uses, y to allow 1-step window drift,
# y to rate limiting
# Save the QR code URL/secret into your authenticator app
```

```bash
# Configure PAM — edit /etc/pam.d/sshd
sudo nano /etc/pam.d/sshd

# Add at the top:
auth required pam_google_authenticator.so
```

```bash
# Configure SSHD to use challenge-response
sudo nano /etc/ssh/sshd_config

# Set:
ChallengeResponseAuthentication yes
AuthenticationMethods publickey,keyboard-interactive
UsePAM yes

sudo systemctl restart sshd
```

Now SSH logins require both a public key AND a TOTP code.

### Lab 2: Test TOTP Generation with Python

```bash
pip install pyotp qrcode[pil]
```

```python
import pyotp
import qrcode

# Generate a secret
secret = pyotp.random_base32()
print(f"Secret: {secret}")

# Generate current OTP
totp = pyotp.TOTP(secret)
print(f"Current OTP: {totp.now()}")
print(f"Valid: {totp.verify(totp.now())}")

# Generate provisioning URI (for QR code