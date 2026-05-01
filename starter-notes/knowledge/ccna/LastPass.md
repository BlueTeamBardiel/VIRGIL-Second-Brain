# LastPass

## What it is
Think of it as a bank vault where you only need to remember the combination to the front door — everything else inside is locked in separate steel boxes. LastPass is a cloud-based password manager that stores encrypted user credentials in a centralized vault, protected by a single master password using zero-knowledge architecture, meaning LastPass itself cannot read your stored data.

## Why it matters
In 2022, LastPass suffered a major breach where attackers exfiltrated encrypted password vaults along with unencrypted metadata (URLs, usernames, cost center data). Even though vault contents were encrypted with AES-256, weak or reused master passwords left millions of users vulnerable to offline brute-force attacks — a textbook example of why vault encryption is only as strong as the master credential protecting it.

## Key facts
- Uses **PBKDF2-SHA256** with 100,100 iterations (at breach time) to derive the encryption key from the master password, slowing brute-force attempts
- Follows a **zero-knowledge model**: encryption/decryption happens locally on the client device, so LastPass servers store only ciphertext
- The 2022 breach revealed that **unencrypted metadata** (website URLs) was stored alongside encrypted credentials — a critical architectural flaw
- Supports **MFA integration** (TOTP, hardware tokens) as a second layer beyond the master password
- Credential vaults are encrypted with **AES-256 in CBC mode** at the individual vault level

## Related concepts
[[Password Manager Security]] [[AES Encryption]] [[PBKDF2]] [[Zero-Knowledge Architecture]] [[Credential Stuffing]]
