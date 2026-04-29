# Web of Trust

## What it is
Like getting a job recommendation where your friend vouches for you, their friend vouches for them, and so on — instead of a single HR department stamping every hire, trust spreads person-to-person. Web of Trust (WoT) is a decentralized public key authentication model where individuals cryptographically sign each other's PGP/GPG keys, creating a network of peer-validated identities without relying on a central Certificate Authority.

## Why it matters
In 2019, attackers poisoned the SKS public keyserver network by uploading certificates with thousands of malicious third-party signatures on high-profile keys (including GnuPG developers). Clients importing those keys would freeze or crash during certificate parsing — demonstrating that the WoT's openness, which is its strength, also makes it vulnerable to signature flooding and poisoning attacks against the trust graph itself.

## Key facts
- **Trust levels in PGP WoT**: Unknown, Undefined, Marginal, Full, and Ultimate — a key requires either one "Full" trusted signature or two "Marginal" signatures to be considered valid by default
- **No revocation infrastructure**: Unlike PKI, there is no universal, reliable revocation mechanism; compromised keys may remain trusted across the network indefinitely
- **Contrast with PKI**: PKI uses a hierarchical Certificate Authority chain (top-down); WoT is flat and peer-based, making it resilient to single-point CA compromise but fragile against Sybil attacks
- **Fingerprint verification** is the gold standard in WoT — physically comparing key fingerprints at "key signing parties" is the intended method to establish initial trust
- **GPG's `--trust-model pgp`** implements WoT by default; organizations often switch to `direct` or `tofu` models to avoid WoT's complexity in enterprise environments

## Related concepts
[[Public Key Infrastructure]] [[PGP Encryption]] [[Certificate Authority]] [[Key Signing]] [[Sybil Attack]]