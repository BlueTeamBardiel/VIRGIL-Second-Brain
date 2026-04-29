# integrity

## What it is
Like a wax seal on a medieval letter — if the seal is broken or forged, you know the message was tampered with. Integrity is the security property guaranteeing that data has not been altered in an unauthorized or undetected way from its original state. It ensures that what you receive is exactly what was sent.

## Why it matters
In 2020, the SolarWinds supply chain attack succeeded partly because attackers modified software build files, and the resulting malicious updates were distributed with valid digital signatures — making the tampered code appear legitimate. Had robust integrity checks been applied to the build pipeline itself (file hashes, reproducible builds), the modification could have been detected before distribution.

## Key facts
- Hashing algorithms (MD5, SHA-1, SHA-256) produce a fixed-length digest; any change to input data produces a completely different hash, enabling tamper detection
- **MD5 and SHA-1 are considered cryptographically broken** for integrity purposes — SHA-256 or higher is the current standard
- HMAC (Hash-based Message Authentication Code) combines a hash with a secret key, providing both integrity *and* authentication — preventing an attacker from simply re-hashing a modified message
- Digital signatures provide integrity + authentication + non-repudiation, making them stronger than standalone hashes
- Integrity is the "I" in the **CIA Triad** (Confidentiality, Integrity, Availability) — often the most overlooked of the three

## Related concepts
[[CIA Triad]] [[hashing]] [[digital signatures]] [[HMAC]] [[non-repudiation]]