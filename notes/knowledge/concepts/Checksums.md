# Checksums

## What it is
Like a bank teller counting a stack of bills twice to confirm the total before handing it over, a checksum runs a mathematical operation across a block of data and produces a short fixed-value "count" — if even one bit changes, the count comes out wrong. Precisely: a checksum is a value computed from data using an algorithm (e.g., CRC32, MD5, SHA-256) that allows a receiver to verify the data arrived — or was stored — without modification.

## Why it matters
In 2016, attackers compromised the Linux Mint website and swapped the official ISO download with a backdoored version. Users who bothered to compare the published MD5 checksum against their downloaded file saw an immediate mismatch — a clear signal the file had been tampered with before installation. This is a textbook supply-chain integrity check saved by a simple hash comparison.

## Key facts
- Checksums ≠ cryptographic hashes by default: CRC32 detects *accidental* corruption but is trivially manipulated by attackers; SHA-256 is collision-resistant and suitable for security purposes.
- A checksum does **not** provide confidentiality — it only confirms integrity.
- MD5 and SHA-1 are considered cryptographically broken (collision attacks demonstrated); Security+ expects you to prefer SHA-2 (SHA-256/SHA-512) or SHA-3.
- HMAC wraps a hash with a secret key, providing both integrity *and* authentication — addressing the weakness that a plain checksum doesn't prove *who* generated it.
- File integrity monitoring tools (e.g., Tripwire) store baseline checksums of system files and alert when values deviate — a core host-based defense technique.

## Related concepts
[[Hashing]] [[HMAC]] [[File Integrity Monitoring]] [[Digital Signatures]] [[Supply Chain Attacks]]