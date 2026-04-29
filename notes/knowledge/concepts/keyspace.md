# keyspace

## What it is
Think of a combination lock: if it has 3 dials with digits 0–9, the keyspace is all 1,000 possible combinations (10³). In cryptography, **keyspace** is the complete set of all possible keys that an encryption algorithm could use — determined by key length in bits, where an n-bit key produces 2ⁿ possible values.

## Why it matters
In a brute-force attack, an attacker systematically tries every possible key until they find the right one. A 56-bit DES key has only 2⁵⁶ (~72 quadrillion) possibilities — which sounds enormous, but specialized hardware cracked it in under 22 hours in 1999. This is exactly why modern standards mandate AES-128 (2¹²⁸ possibilities), making exhaustive search computationally infeasible with current technology.

## Key facts
- A 128-bit keyspace contains ~340 undecillion (3.4 × 10³⁸) possible keys — brute-forcing it at a billion attempts per second would take longer than the age of the universe
- DES (56-bit keyspace) is considered **cryptographically broken** precisely because its keyspace is too small
- Larger keyspace ≠ stronger algorithm — a huge keyspace with a weak algorithm (like poor key scheduling) can still be vulnerable
- Keyspace exhaustion is the theoretical basis for brute-force and dictionary attacks; dictionary attacks shrink the **effective keyspace** by targeting only probable passwords
- NIST recommends minimum 128-bit symmetric keys and 2048-bit RSA keys because asymmetric algorithms have different keyspace-to-security ratios

## Related concepts
[[brute-force attack]] [[key length]] [[entropy]] [[dictionary attack]] [[AES]]