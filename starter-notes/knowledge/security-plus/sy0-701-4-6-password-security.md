```yaml
---
domain: "4.0 - Security Operations"
section: "4.6"
tags: [security-plus, sy0-701, domain-4, password-security, authentication, access-control]
---
```

# 4.6 - Password Security

## Overview

Password security is a foundational pillar of [[access control]] and [[authentication]] in any organization. This section covers the mechanisms, policies, and technologies that protect accounts from unauthorized access through weak credentials, brute-force attacks, and credential compromise. For the Security+ exam, you must understand password complexity requirements, expiration policies, password managers, and the emerging shift toward [[passwordless authentication]] — all critical components of a defense-in-depth security posture in environments like [[Active Directory]] and enterprise systems.

---

## Key Concepts

- **Password Complexity**: Requirement that passwords contain a mix of character types (uppercase, lowercase, numbers, special characters) to increase entropy and resist dictionary attacks and brute-force attempts.

- **Password Entropy**: A measure of randomness and unpredictability in a password. Higher entropy = greater resistance to guessing and [[brute-force attack]]s. Achieved through length, character variety, and avoiding common words or patterns.

- **Minimum Password Length**: Security+ emphasizes at least 8 characters as a baseline, though this threshold increases as computational power grows. NIST guidance increasingly favors length over complexity.

- **Password Age**: The length of time since a password was last changed. Systems track this to enforce periodic updates and detect stale credentials.

- **Password Expiration**: A policy-driven mechanism forcing users to change passwords after a set interval (30, 60, 90 days, or even 7–15 days for critical systems). After expiration, the old password becomes invalid.

- **Password History**: System enforcement that prevents users from reusing recent passwords, forcing them to create genuinely new credentials and closing the loop of predictable password rotation.

- **Brute-Force Attack**: Attacker methodology attempting many password combinations rapidly. Strong passwords (length + entropy) exponentially increase the time required to crack them.

- **Dictionary Attack**: A variant of brute-force using real words or common phrases rather than random character combinations. Resisted by avoiding single words and obvious phrases in passwords.

- **Password Manager**: Encrypted software or service that stores, generates, and auto-fills credentials for multiple accounts. Examples include 1Password, Bitwarden, LastPass, and built-in OS solutions (Windows Credential Manager, macOS Keychain).

- **Centralized Password Management**: Enterprise solutions (e.g., [[Active Directory]] password vaults, privileged access management [PAM] tools) that provide administrative control, recovery, auditing, and compliance reporting across the organization.

- **Passwordless Authentication**: Authentication mechanisms that eliminate passwords entirely, relying instead on possession factors (security keys, hardware tokens), inherence factors ([[biometrics]] like fingerprint or facial recognition), or other cryptographic methods.

- **Multi-Factor Authentication (MFA)**: Combining passwords with additional authentication factors (something you have, something you are, somewhere you are) to increase security even if a password is compromised.

- **Credential Compromise**: Unauthorized access to stored or transmitted passwords due to weak implementation, poor password practices, or [[breach]]es. A primary driver for passwordless adoption.

---

## How It Works (Feynman Analogy)

**The Analogy:**

Imagine a safe deposit box at a bank. A weak password is like a lock with only 3 digits (000–999). An attacker with a simple tool can try all combinations in minutes. A strong password is like a lock with 12 randomly mixed letters, numbers, and symbols—millions of possible combinations that would take years to exhaust even with modern computers.

Now, imagine the bank requires you to change your lock combination every 90 days. This prevents an attacker who stole your old combination from using it indefinitely. Finally, imagine the bank won't let you return to a combination you used in the last five years (password history), and they also offer you a fingerprint scanner instead of a lock altogether (passwordless authentication).

**The Technical Reality:**

Each character in a password adds exponential entropy. An 8-character password with 95 possible characters per position (uppercase, lowercase, digits, symbols) yields 95^8 = ~6.6 trillion combinations. [[Brute-force attack]]s and [[hashing]] algorithms (like [[bcrypt]], [[Argon2]], or salted [[SHA-256]]) are slowed by computational cost. Expiration policies force periodic credential rotation, limiting the window of exposure if a password leaks. Password managers solve the human problem—users cannot remember 50+ unique strong passwords, so centralized encrypted storage backed by a single strong master password becomes practical. Passwordless solutions replace the password entirely with [[cryptographic]] keys or biometric verification, eliminating the weakest link: human password management.

---

## Exam Tips

- **Complexity vs. Length**: The exam often asks which is more important. While complexity matters, **length is increasingly prioritized** by modern security frameworks ([[NIST]] SP 800-63). A 20-character passphrase is stronger than an 8-character complex string.

- **Expiration Policy Pitfall**: Candidates confuse **password age** (how long it's been since change) with **password expiration** (when it stops working). Know that expiration forces a change; age is just a metric. Also, frequent forced changes (every 15 days) may cause users to write passwords down—a security anti-pattern.

- **Password Managers as a Solution**: The exam recognizes password managers as a **best practice for entropy without memorization burden**. They reduce weak passwords and password reuse, which are leading breach causes. Built-in OS managers ([[Windows Credential Manager]], Keychain) are acceptable; enterprise solutions add audit trails and recovery.

- **Passwordless ≠ Password-Free**: A passwordless solution (e.g., facial recognition + security key) may still include a password as a secondary factor or fallback. Read questions carefully—are they asking about primary authentication or total elimination?

- **Critical Systems**: High-value targets (domain controllers, administrative accounts, payment systems) require **shorter expiration cycles** (7–15 days) and stricter complexity rules. This is a direct Security+ testable distinction.

---

## Common Mistakes

- **Overestimating Password Expiration Effectiveness**: Many candidates believe mandatory 90-day rotations eliminate breach risk. In reality, if a password is compromised mid-cycle, expiration won't protect you retroactively. Expiration is one control, not a silver bullet; it's most effective paired with [[MFA]] and breach detection.

- **Confusing Passwordless with Perfect**: Passwordless authentication (e.g., Windows Hello, FIDO2 security keys) is more secure than passwords but introduces new attack vectors (biometric spoofing, key loss, phishing links that bypass password-focused defenses). The exam wants you to recognize it as **an improvement, not a guarantee**.

- **Ignoring Password History in Scenario Questions**: If a question asks how to prevent users from cycling the same password repeatedly, the answer is **password history policy**, not just expiration. This is a common trap—expiration alone doesn't prevent reuse.

---

## Real-World Application

In your homelab, [[Active Directory]] enforces password policies at the domain level (complexity, minimum length, expiration, history) for all user accounts and service principals. For administrative accounts and PAM scenarios, you would implement a centralized password manager or vault (e.g., HashiCorp Vault, CyberArk) to rotate credentials automatically, audit access, and ensure no plaintext passwords are logged in [[Wazuh]] or syslog. For external access, tools like [[Tailscale]] can leverage [[OAuth]] or [[SAML]] (passwordless federation) instead of local password stores, reducing the attack surface. This multi-layered approach—policy enforcement, encrypted storage, and passwordless federation—mirrors enterprise security operations and directly aligns with Security+ expectations.

---

## Deep Dive: Password Security Architecture

### Complexity Requirements
Password complexity policies mandate:
- **Minimum length**: 8+ characters (increasingly 12–16 for sensitive accounts)
- **Character diversity**: Mix of upper/lowercase, digits, special characters
- **Entropy calculation**: Each additional character type exponentially increases crack time

A 12-character passphrase ("correct-horse-battery-staple") offers ~40 bits of entropy and is more memorable and secure than "P@ssw0rd!" (~28 bits).

### Password Age and Expiration Lifecycle
1. **Initial Creation**: User sets password; system records creation timestamp and stores hash (not plaintext).
2. **Age Tracking**: System monitors time since last change. At threshold (e.g., 60 days), users receive expiration warnings.
3. **Expiration Enforcement**: After grace period, password becomes invalid. User must change it on next login.
4. **History Checking**: New password is hashed and compared against previous hashes (1–12 generations retained). System rejects if match found.
5. **Critical Systems**: Domains with high-value accounts (Domain Admin, Exchange, SQL Server) reduce expiration to 7–15 days.

### Password Manager Deployment Models

**Personal/Built-in:**
- Windows Credential Manager (stores encrypted credentials locally)
- macOS Keychain (biometric-unlocked credential store)
- Browser password managers (Firefox, Chrome)
- Standalone (Bitwarden, 1Password)

**Enterprise:**
- [[Active Directory]] Vault or Microsoft Identity Manager (stores recovery passwords)
- HashiCorp Vault (API-driven, rotation automation)
- Delinea (formerly Thycotic) Secret Server (PAM-focused)
- CyberArk (privileged access management, audit, MFA)

Each includes:
- Encrypted storage (AES-256 or equivalent)
- Master password or [[MFA]] unlock
- Auto-fill and generation of strong passwords
- Audit logs and compliance reporting

### Passwordless Authentication Methods

**Possession-Based:**
- FIDO2 Security Keys (hardware tokens resistant to phishing)
- Windows Hello for Business (PIN + biometric unlock)
- Smart Cards + [[PKI]]

**Inherence-Based:**
- Facial recognition (Windows Hello Face, Apple FaceID)
- Fingerprint (Windows Hello Fingerprint, mobile biometrics)
- Iris scanning (less common, high security)

**Location/Context-Based:**
- Geofencing (only authenticate from known networks)
- Device compliance checks (TrustScore in [[Zero Trust]])
- Risk-based adaptive [[MFA]]

**Hybrid (Passwordless Primary + Password Secondary):**
- FIDO2 key for login + password for account recovery
- Biometric unlock + PIN fallback
- This hybrid model is most common in enterprise because 100% passwordless breaks backward compatibility and creates single points of failure.

---

## Related Security Controls

- **[[Authentication]]**: The act of verifying identity; password is one method.
- **[[Authorization]]**: Granting access based on authenticated identity; not password-dependent.
- **[[MFA]]/[[2FA]]**: Multi-factor authentication strengthens password-based systems.
- **[[Encryption]]**: Passwords at rest (in managers) and in transit (over [[TLS]]) must be encrypted.
- **[[Hashing]]**: Passwords should never be stored in plaintext; salted hashes ([[bcrypt]], [[Argon2]]) are standard.
- **[[LDAP]]** / [[Active Directory]]: Centralized authentication and policy enforcement.
- **[[OAuth]]** / [[SAML]]**: Federated authentication reducing local password dependency.
- **[[Zero Trust]]**: Architecture assuming no implicit trust; password strength is one micro-segmentation factor.
- **[[Incident Response]]**: Compromised credentials require immediate resets and audit trails via [[SIEM]]/[[Wazuh]].

---

## Wiki Links

[[Security+]] | [[SY0-701]] | [[4.0 - Security Operations]] | [[Authentication]] | [[Authorization]] | [[Access Control]] | [[CIA Triad]] | [[Brute-Force Attack]] | [[Dictionary Attack]] | [[Encryption]] | [[Hashing]] | [[bcrypt]] | [[Argon2]] | [[SHA-256]] | [[Cryptography]] | [[MFA]] | [[2FA]] | [[Biometrics]] | [[FIDO2]] | [[PKI]] | [[Digital Certificates]] | [[Zero Trust]] | [[Defense-in-Depth]] | [[Active Directory]] | [[LDAP]] | [[OAuth]] | [[SAML]] | [[TLS]] | [[HTTPS]] | [[Privileged Access Management]] | [[PAM]] | [[SIEM]] | [[Wazuh]] | [[Incident Response]] | [[Breach]] | [[Credential Compromise]] | [[NIST]] | [[Compliance]] | [[Audit]] | [[Logging]] | [[Windows Credential Manager]] | [[Keychain]] | [[Vault]] | [[1Password]] | [[Bitwarden]] | [[LastPass]] | [[CyberArk]] | [[Delinea]] | [[HashiCorp Vault]] | [[Windows Hello]] | [[Smart Card]] | [[Security Key]] | [[Tailscale]] | [[Kali Linux]] | [[Metasploit]] | [[Wireshark]]

---

## Tags

`domain-4` `security-plus` `sy0-701` `password-security` `authentication` `access-control` `compliance` `enterprise-security`

---

**Last Updated**: [Current Date]  
**Exam Weight**: ~2–3% of 28% domain (1–2 questions per exam expected)  
**Difficulty**: Medium (concepts straightforward; policies require scenario judgment)

```

---
_Ingested: 2026-04-16 00:19 | Source: professor-messer-sy0-701-comptia-security-plus-course-notes-v107.pdf_
