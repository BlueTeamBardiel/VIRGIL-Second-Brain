# Password Management

## What it is
Think of passwords like house keys: most people cut one key and hand copies to everyone, but a locksmith would tell you each door needs a unique key stored on a labeled hook. Password management is the systematic practice of creating, storing, rotating, and auditing credentials using tools (password managers) and policies that enforce uniqueness, complexity, and controlled access.

## Why it matters
In the 2012 LinkedIn breach, 117 million passwords were hashed with unsalted SHA-1 — a format so weak that attackers cracked the majority within days and used them for credential stuffing attacks against Gmail, banking sites, and corporate VPNs years later. A password manager with enforced unique credentials per site would have contained the blast radius to a single compromised account.

## Key facts
- **Password length beats complexity**: NIST SP 800-63B recommends minimum 8 characters for user-chosen passwords, but prioritizes length and rejects mandatory special-character rotation policies as counterproductive
- **Password managers use a master password + AES-256 encrypted vault**, often with PBKDF2 or Argon2 key derivation to slow brute-force attempts against the vault itself
- **Credential stuffing** exploits password reuse across sites — attackers automate login attempts using breached username/password pairs at scale
- **Password spraying** attacks one common password (e.g., `Summer2024!`) across many accounts to avoid account lockout thresholds — countermeasure is MFA + monitoring for distributed login failures
- **Privileged Account Management (PAM)** solutions like CyberArk vault and rotate credentials for admin/service accounts automatically, generating audit trails for compliance

## Related concepts
[[Multi-Factor Authentication]] [[Credential Stuffing]] [[Privileged Access Management]] [[Hashing and Salting]] [[Account Lockout Policies]]