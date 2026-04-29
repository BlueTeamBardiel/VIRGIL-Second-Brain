# Bitcoin

## What it is
Like a public ledger nailed to the town square wall where everyone can read every transaction but no one can erase or alter past entries, Bitcoin is a decentralized, peer-to-peer cryptocurrency that uses a distributed blockchain to record transactions without requiring a central authority. Each transaction is cryptographically signed and bundled into blocks, chained together via SHA-256 hashing to make tampering computationally infeasible.

## Why it matters
Bitcoin is the dominant payment rail for ransomware operators precisely because transactions are pseudonymous — wallet addresses aren't inherently tied to real identities. In the 2021 Colonial Pipeline attack, attackers demanded ~75 Bitcoin (~$4.4M); the FBI later recovered ~63.7 Bitcoin by seizing the private key controlling the attacker's wallet, demonstrating that "untraceable" is a myth when operational security fails.

## Key facts
- Bitcoin addresses are **pseudonymous, not anonymous** — all transactions are permanently visible on the public blockchain, enabling forensic chain analysis
- Transactions are secured using **ECDSA (Elliptic Curve Digital Signature Algorithm)** with secp256k1 curve, not RSA
- The **51% attack** is a theoretical threat where a single entity controlling majority hash power could double-spend coins or rewrite recent blocks
- Bitcoin wallets store **private keys**, not coins — losing the private key means permanent, irrecoverable loss of funds
- **Blockchain immutability** is enforced by proof-of-work: altering a past block requires recalculating all subsequent blocks faster than the honest network

## Related concepts
[[Blockchain]] [[Ransomware]] [[Cryptographic Hashing]] [[Public Key Infrastructure]] [[Dark Web]]