# Password Vaulting

## What it is
Like a bank safe-deposit box where you keep all your valuables locked behind one master key, a password vault is an encrypted repository that stores all your credentials behind a single master password. It generates, stores, and auto-fills unique, complex passwords for every account, eliminating the human tendency to reuse weak credentials across services.

## Why it matters
In the 2012 LinkedIn breach, 117 million reused credentials were dumped publicly — attackers then performed **credential stuffing** against banking and email sites, compromising accounts that never touched LinkedIn. A password vault defeats this attack by ensuring every service gets a unique 20-character random password, so one breach never cascades into many.

## Key facts
- Password vaults encrypt the credential database using **AES-256**, with the master password never stored — only a derived key via **PBKDF2, bcrypt, or Argon2** is used to unlock it
- Two deployment models exist: **local vaults** (KeePass — database stays on your device) vs. **cloud vaults** (1Password, Bitwarden — synced but the provider never holds your decryption key)
- Enterprise vaults add **Privileged Access Management (PAM)** capabilities: session recording, just-in-time access, and automatic credential rotation for service accounts
- The master password is the single point of failure — if lost, recovery is often impossible; if compromised, all credentials are exposed, making **MFA on the vault itself** critical
- NIST SP 800-63B explicitly recommends password managers as a countermeasure against password reuse and supports long passphrases as master credentials

## Related concepts
[[Credential Stuffing]] [[Privileged Access Management]] [[Multi-Factor Authentication]] [[Key Derivation Functions]] [[Zero-Knowledge Encryption]]