# password manager

## What it is
Think of it as a bank vault where every safety deposit box holds a different key — and you only need to remember the master combination. A password manager is an encrypted application that generates, stores, and autofills unique credentials for each service, protected by a single master password (and ideally MFA). The vault contents are encrypted locally or in the cloud using strong algorithms like AES-256.

## Why it matters
In credential stuffing attacks, adversaries take breach dumps from one site and automatically test those username/password pairs across hundreds of other services — exploiting the fact that users reuse passwords. A password manager defeats this entirely by ensuring every site gets a unique, randomly generated credential; even if one database is breached, the stolen password is useless everywhere else.

## Key facts
- **Master password is the single point of failure** — if compromised or forgotten, access to all stored credentials is at risk; strong master passwords + MFA are non-negotiable
- **Two deployment models**: local/offline vaults (e.g., KeePass — encrypted file you control) vs. cloud-based (e.g., Bitwarden — syncs across devices, introduces remote attack surface)
- **Zero-knowledge architecture** means the vendor never sees your plaintext passwords; encryption/decryption happens client-side before any cloud sync
- **Autofill protects against phishing** — a properly implemented manager won't autofill credentials on a lookalike domain (e.g., paypa1.com vs. paypal.com)
- **Password managers can be targeted directly** — the 2022 LastPass breach exposed encrypted vaults; weak master passwords made those vaults crackable offline via brute force

## Related concepts
[[credential stuffing]] [[multi-factor authentication]] [[AES encryption]] [[key derivation function]] [[phishing]]