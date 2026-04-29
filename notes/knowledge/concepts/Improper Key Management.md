# Improper Key Management

## What it is
Imagine a master key to every office in a skyscraper stored under the front door mat — that's improper key management. It refers to the failure to securely generate, store, distribute, rotate, or revoke cryptographic keys, leaving the encryption they protect effectively meaningless regardless of algorithm strength.

## Why it matters
In 2012, researchers discovered that millions of RSA public keys in the wild shared prime factors — meaning the private keys could be mathematically reconstructed. This happened because embedded devices generated keys with weak entropy at boot time, a generation failure that rendered strong 2048-bit RSA completely breakable. No attack on the algorithm was needed; the key management failed before encryption even started.

## Key facts
- **Hardcoded keys** in source code are one of the most common failures — tools like truffleHog and GitGuardian scan repositories specifically for this mistake.
- **Key rotation** is mandatory in most compliance frameworks (PCI-DSS, NIST 800-57); failure to rotate means a compromised key exposes all past and future data encrypted under it.
- **Separation of duties** requires that no single person or system holds both the encrypted data and the key — violating this collapses the security model entirely.
- **Key escrow** must be protected as rigorously as the keys themselves; compromising the escrow agent is functionally equivalent to stealing every key it holds.
- NIST SP 800-57 defines key lifecycle stages: pre-activation, active, suspended, deactivated, compromised, and destroyed — skipping **destruction** leaves keys exploitable indefinitely.

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Management]] [[Hardware Security Module (HSM)]] [[Cryptographic Algorithm Weaknesses]] [[Secrets Management]]