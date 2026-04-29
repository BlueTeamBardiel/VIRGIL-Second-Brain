# Windows EFS

## What it is
Like a lockbox only *you* can open — even if someone steals the whole safe — EFS (Encrypting File System) is a Windows feature that transparently encrypts files and folders at the NTFS level using a per-user certificate and symmetric key pair. It operates below the application layer, meaning encryption and decryption happen automatically when the authorized user accesses the file.

## Why it matters
In a real-world scenario, an attacker who gains physical access to a drive and pulls it to mount on another machine will find EFS-protected files completely unreadable — the raw data is AES-encrypted and tied to a certificate stored in the original user's profile. However, EFS becomes an attacker *tool* in ransomware-style abuse: malware running as the victim user can silently EFS-encrypt files and then delete the user's certificate, effectively holding data hostage without any third-party ransomware binary needed.

## Key facts
- EFS uses a **hybrid encryption model**: files are encrypted with a symmetric FEK (File Encryption Key), which is itself encrypted with the user's RSA public key
- The **Data Recovery Agent (DRA)** — typically the domain administrator — holds a backup decryption capability, making enterprise recovery possible without the original user's certificate
- EFS is **unavailable on FAT/FAT32** volumes; it requires NTFS
- If a user's **EFS certificate and private key are lost** (e.g., corrupted profile, no backup), the encrypted files are permanently unrecoverable without a DRA
- EFS protects **at rest only** — files decrypted in memory or shared over a network are exposed in plaintext; it does not protect against a logged-in attacker with the same credentials

## Related concepts
[[BitLocker]] [[NTFS Permissions]] [[Public Key Infrastructure (PKI)]] [[Certificate Authority]] [[Data Recovery Agent]]