# File Encryption

## What it is
Like locking a diary inside a safe where even the locksmith can't read it without your specific combination, file encryption transforms readable data into scrambled ciphertext using a mathematical key. Only someone possessing the correct decryption key can reverse the process and recover the original plaintext. It protects data-at-rest, ensuring that even if storage media is stolen, the contents remain unreadable.

## Why it matters
In 2021, a laptop containing unencrypted VA patient records was stolen from a contractor's car — exposing thousands of veterans' PII. Had the files been encrypted with something like AES-256, the physical theft would have been a hardware loss only, not a data breach. This is exactly why regulations like HIPAA and PCI-DSS mandate encryption for sensitive stored data.

## Key facts
- **AES-256** (Advanced Encryption Standard) is the gold standard for file encryption — symmetric, fast, and NIST-approved for TOP SECRET data
- **Symmetric encryption** uses one key for both encrypt/decrypt (faster); **asymmetric** uses a public/private keypair (used to securely exchange symmetric keys)
- **Full Disk Encryption (FDE)** tools like BitLocker (Windows) and FileVault (macOS) encrypt entire volumes, protecting all files automatically at the OS level
- **Ransomware exploits the same mechanism** — attackers encrypt your files with their key, then demand payment for decryption (e.g., WannaCry used AES-128 + RSA-2048)
- File encryption does **NOT** protect data-in-transit — that requires TLS/SSL; encryption scope (at-rest vs. in-transit) is a frequent exam distinction

## Related concepts
[[Ransomware]] [[BitLocker]] [[Symmetric vs Asymmetric Encryption]] [[Data-at-Rest Protection]] [[Public Key Infrastructure]]