# VRF

## What it is
Think of a VRF like a hotel with multiple private elevator banks — guests on floor 3 can never accidentally wander into the executive penthouse corridor, even though they share the same building. A **Verifiable Random Function (VRF)** is a cryptographic primitive that takes a private key and an input to produce a pseudorandom output along with a publicly verifiable proof, guaranteeing the output was generated honestly without revealing the private key.

## Why it matters
In blockchain and lottery-style systems, a malicious operator could manipulate a standard random number generator to bias outcomes in their favor — a classic manipulation attack. VRFs solve this by allowing any observer to *verify* the randomness was generated correctly using the proof, without being able to predict or reproduce the output themselves. Chainlink's oracle network, for example, uses VRFs specifically to provide tamper-proof randomness for smart contracts.

## Key facts
- A VRF produces two outputs: a **pseudorandom value** and a **proof** — both are required for the scheme to be useful
- The proof allows anyone with the corresponding **public key** to verify correctness, but only the private key holder can generate it
- VRFs provide three security properties: **pseudorandomness**, **uniqueness** (one valid output per input/key pair), and **provability**
- VRFs are distinct from standard PRNGs — the output is *verifiable*, not just statistically random
- VRFs underpin **DNSSEC's NSEC3** records, preventing zone enumeration while proving non-existence of DNS records cryptographically

## Related concepts
[[Public Key Cryptography]] [[Digital Signatures]] [[DNSSEC]] [[Zero-Knowledge Proofs]] [[Pseudorandom Number Generator]]