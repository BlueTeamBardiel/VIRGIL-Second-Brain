# symmetric encryption

## What it is
Imagine you and a friend share a single physical key that locks and unlocks the same padlock — whoever holds that key can both seal and open the box. Symmetric encryption works exactly like this: one secret key is used to both encrypt and decrypt data. Both parties must possess the same key before communication begins, making secure key distribution the central challenge.

## Why it matters
In 2013, attackers deploying CryptoLocker ransomware used symmetric AES encryption to lock victims' files, then protected *that* key with asymmetric encryption — meaning without paying the ransom, victims had no path to decryption. This attack illustrated that symmetric encryption is powerful enough to make data permanently inaccessible when the key is withheld. It also demonstrated why key management is the real battlefield, not the algorithm itself.

## Key facts
- **AES (Advanced Encryption Standard)** is the gold standard — supports 128, 192, and 256-bit key lengths; AES-256 is used by the U.S. government for TOP SECRET data
- Symmetric encryption is **significantly faster** than asymmetric encryption, making it the choice for bulk data encryption (disk encryption, TLS session data)
- **Key distribution problem**: both parties must share the secret key securely before encrypted communication can begin — this is why hybrid encryption (TLS) exists
- Common symmetric algorithms: **AES, 3DES, ChaCha20**; DES is considered broken (56-bit key, crackable in hours)
- Modes of operation matter: **ECB mode is insecure** (identical plaintext blocks produce identical ciphertext); **CBC, GCM, and CTR** modes are preferred for real deployments

## Related concepts
[[asymmetric encryption]] [[key management]] [[AES]] [[hybrid encryption]] [[block cipher modes]]