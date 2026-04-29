# Full disk encryption

## What it is
Like sealing every document in a safe before locking the office — even if someone steals the entire filing cabinet, they read nothing without the combination. Full disk encryption (FDE) cryptographically scrambles all data on a storage device at rest, including the OS, swap space, and temp files, so the drive is unreadable without the correct key or passphrase during boot.

## Why it matters
In 2020, a VA contractor left an unencrypted laptop in a car; it was stolen and exposed thousands of veterans' PII — a breach that would have been a non-event with FDE enabled. FDE is the direct technical control that converts a stolen laptop from a data breach into a minor property crime, since the attacker recovers only ciphertext they cannot feasibly decrypt.

## Key facts
- **BitLocker** (Windows) uses AES-128 or AES-256 and stores the key in a **TPM chip**, binding decryption to the specific hardware platform
- **Pre-boot authentication (PBA)** requires credentials before the OS loads, adding a factor beyond TPM auto-unlock
- FDE protects **data at rest only** — once the volume is mounted and unlocked, data in memory or in transit is exposed as normal
- On the Security+ exam, FDE is mapped to the control objective of protecting **confidentiality** against physical theft, not against malware or network attacks
- Self-Encrypting Drives (SEDs) implement FDE in hardware firmware; the **Opal standard** (TCG Opal) governs interoperability between SEDs and management software

## Related concepts
[[Data at Rest Encryption]] [[Trusted Platform Module (TPM)]] [[BitLocker]] [[Pre-boot Authentication]] [[Cold Boot Attack]]