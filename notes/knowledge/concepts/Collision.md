# Collision

## What it is
Imagine two different people showing up to a party with the same name tag — the bouncer can't tell them apart. A collision in cryptography occurs when two distinct inputs produce the identical hash output from a hash function. This violates the fundamental guarantee that a hash should uniquely fingerprint its input.

## Why it matters
MD5 collision attacks broke real-world trust in certificate signing. In 2008, researchers exploited MD5 collisions to forge a rogue Certificate Authority certificate, meaning they could create a fraudulent cert that browsers trusted as legitimate — a direct attack on HTTPS infrastructure. This is why MD5 and SHA-1 are now deprecated for certificate signing in favor of SHA-256 and above.

## Key facts
- **Birthday attack** is the primary collision exploitation technique — it exploits the statistical reality that finding *any* two matching inputs requires far fewer attempts than finding a match for one *specific* input (birthday paradox)
- **MD5** produces a 128-bit digest and is fully collision-broken; avoid for integrity verification
- **SHA-1** was theoretically broken by Google's **SHAttered attack (2017)**, which produced two different PDFs with the same SHA-1 hash
- A hash function is considered **collision-resistant** (not collision-proof) — collisions are mathematically unavoidable in any fixed-length output function, but finding them should be computationally infeasible
- For Security+: collision resistance is one of three core hash properties alongside **pre-image resistance** and **second pre-image resistance**

## Related concepts
[[Hash Function]] [[Birthday Attack]] [[MD5]] [[SHA-256]] [[Integrity]]