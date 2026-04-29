# Cryptographic Storage

## What it is
Think of it like a bank vault where even the bank employees can't read what's inside your safety deposit box — only you hold the key. Cryptographic storage is the practice of protecting data at rest using encryption, hashing, or both, so that stored credentials, files, or databases are unreadable without the correct key or input. It ensures confidentiality and integrity of data even when physical or logical access to storage media is obtained.

## Why it matters
In the 2012 LinkedIn breach, over 117 million passwords were stolen — but they were hashed with unsalted SHA-1, allowing attackers to crack the majority using precomputed rainbow tables within days. Had LinkedIn used a proper adaptive hashing algorithm like bcrypt with unique salts per password, the breach's damage would have been drastically limited. This incident defines exactly what cryptographic storage failure looks like in production.

## Key facts
- **Hashing ≠ Encryption**: Hashing is one-way (passwords); encryption is reversible (files, databases). Using the wrong one for the wrong purpose is a critical vulnerability.
- **Salting** adds a unique random value to each password before hashing, defeating precomputed rainbow table attacks and ensuring identical passwords produce different hashes.
- **Adaptive algorithms** (bcrypt, scrypt, Argon2, PBKDF2) intentionally increase computational cost to slow brute-force attacks — preferred over MD5/SHA-1 for password storage.
- **Encryption at rest** (e.g., AES-256) protects database files, disk images, and backups — but key management determines whether the protection is real or illusory.
- OWASP classifies insecure cryptographic storage as a top vulnerability; Security+ maps this to the **"Cryptography and PKI"** domain and data protection controls.

## Related concepts
[[Password Hashing]] [[Salting and Peppering]] [[Encryption at Rest]] [[Key Management]] [[Rainbow Table Attacks]]