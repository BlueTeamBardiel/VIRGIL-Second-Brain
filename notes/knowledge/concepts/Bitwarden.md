# Bitwarden

## What it is
Think of Bitwarden as a bank vault where instead of cash, you store every key to every door you own — and the vault itself is made of glass so anyone can inspect that it's actually secure. Bitwarden is an open-source, end-to-end encrypted password manager that stores credentials in an AES-256-encrypted vault, synchronized across devices via cloud or self-hosted server. Users authenticate with a single master password, which never leaves the device in plaintext.

## Why it matters
In the 2021 Colonial Pipeline ransomware attack, attackers leveraged a compromised, reused VPN password — exactly the kind of credential hygiene failure a password manager prevents. Bitwarden defends against credential stuffing and password reuse attacks by generating and storing unique, high-entropy passwords per site, meaning one breached service cannot cascade into account takeover elsewhere.

## Key facts
- Uses **AES-256-CBC** encryption with **PBKDF2-SHA256** (default 600,000 iterations) for key derivation from the master password — making offline brute-force attacks computationally prohibitive
- **Zero-knowledge architecture**: Bitwarden's servers store only ciphertext; decryption occurs client-side only, so even a server breach exposes no plaintext credentials
- **Open-source** codebase allows independent security audits — a significant trust differentiator over closed-source alternatives like LastPass
- Supports **TOTP (Time-Based One-Time Passwords)** generation, acting as a built-in authenticator app for MFA-enabled accounts
- Can be **self-hosted** using Docker, giving organizations full data sovereignty — relevant for compliance frameworks like HIPAA or SOC 2

## Related concepts
[[Password Manager]] [[AES-256 Encryption]] [[PBKDF2]] [[Credential Stuffing]] [[Multi-Factor Authentication]] [[Zero-Knowledge Encryption]]