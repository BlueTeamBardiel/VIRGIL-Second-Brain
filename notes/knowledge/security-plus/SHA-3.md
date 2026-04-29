# SHA-3

## What it is
Imagine your old house key design got leaked, so instead of just copying the key slightly, a locksmith builds an entirely new locking *mechanism* from scratch. SHA-3 is exactly that — when theoretical weaknesses emerged in SHA-1 and MD5's shared design lineage, NIST didn't patch the old approach; they standardized a completely different algorithm called **Keccak**, based on a "sponge construction" rather than the Merkle-Damgård structure used by its predecessors.

## Why it matters
In 2004-2005, cryptanalysts demonstrated collision attacks against MD5 and SHA-1, proving that attackers could forge digital signatures and fraudulent certificates. SHA-3 was designed specifically so that even if SHA-2 were someday broken (they share architectural similarities), organizations would have a structurally unrelated fallback — like keeping a spare key cut by a completely different locksmith using a different blank.

## Key facts
- SHA-3 was standardized by NIST in **2015** (FIPS 202) after a public competition lasting from 2007–2012
- Uses a **sponge construction**: data is "absorbed" into internal state, then "squeezed" out — fundamentally different from SHA-1/SHA-2's Merkle-Damgård design
- Produces the same output sizes as SHA-2: **224, 256, 384, and 512 bits**
- SHA-3 is **not faster than SHA-2** in software; SHA-2 remains the more common choice — SHA-3 is the insurance policy
- SHA-3 also defines **SHAKE128 and SHAKE256**, extendable-output functions (XOFs) that produce variable-length hashes, useful in cryptographic protocols like post-quantum schemes

## Related concepts
[[SHA-2]] [[Hashing Algorithms]] [[Digital Signatures]] [[MD5]] [[Collision Attack]] [[NIST Cryptographic Standards]]