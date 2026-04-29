# Password managers

## What it is
Think of a password manager like a high-security bank vault where you only need to remember the combination to the front door — everything else inside is locked in individual steel boxes. A password manager is an encrypted application that generates, stores, and auto-fills unique credentials for each account, protected by a single master password or passphrase. All stored credentials are encrypted (typically AES-256) and decrypted locally or via a zero-knowledge cloud model.

## Why it matters
In the 2012 LinkedIn breach, 117 million credentials were exposed — and because users reused passwords, attackers performed **credential stuffing** attacks against banking and email accounts years later. A password manager prevents this by ensuring each site gets a unique, randomly generated password, so one breach cannot cascade into full account takeover across services.

## Key facts
- Password managers use **AES-256 encryption** and often **PBKDF2, bcrypt, or Argon2** to derive the encryption key from the master password, adding brute-force resistance
- **Zero-knowledge architecture** means the provider cannot decrypt your vault — only the client-side master password can unlock it
- Local (offline) managers like KeePass store the vault on-device; cloud-based managers like Bitwarden sync across devices but introduce an attack surface on the provider
- The **single point of failure** risk: if the master password is compromised or forgotten, all stored credentials may be lost or exposed
- NIST SP 800-63B explicitly recommends using password managers and generating long, unique passwords rather than enforcing complex rotation policies

## Related concepts
[[Credential Stuffing]] [[Multi-Factor Authentication]] [[Encryption]] [[Key Derivation Functions]] [[Zero-Knowledge Proof]]