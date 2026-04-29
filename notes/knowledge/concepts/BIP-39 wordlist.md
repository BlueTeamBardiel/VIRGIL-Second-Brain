# BIP-39 wordlist

## What it is
Like a standardized dictionary where each word is secretly a number from 0–2047, the BIP-39 wordlist is a curated set of 2048 English words used to encode cryptographic entropy into human-readable mnemonic seed phrases. Each word maps to an 11-bit binary value, allowing 12–24 common words to represent the master private key for an entire cryptocurrency wallet.

## Why it matters
In 2023, attackers conducting "seed phrase phishing" campaigns tricked victims into entering their 12-word recovery phrases into fake wallet recovery sites — because users *could* type those words, the keys were instantly compromised and funds drained within seconds. Defenders and forensic examiners use knowledge of the BIP-39 wordlist to identify seed phrases in memory dumps, chat logs, or screenshots during incident response.

## Key facts
- The full list contains exactly **2048 words**, chosen so that the first 4 letters of each word are unique — allowing unambiguous abbreviation
- A **12-word phrase** encodes 128 bits of entropy + 4 checksum bits; a **24-word phrase** encodes 256 bits + 8 checksum bits
- The **last word** of any valid BIP-39 phrase is not fully random — it encodes a checksum derived from SHA-256 of the entropy, meaning not all word combinations are valid
- Brute-forcing a 12-word phrase from the 2048-word space yields **2048¹²** combinations (~2¹³²), making exhaustive attack computationally infeasible
- BIP-39 phrases are **deterministic**: the same phrase always regenerates the same master key via PBKDF2-HMAC-SHA512 with the string "mnemonic" + optional passphrase as the salt

## Related concepts
[[Hierarchical Deterministic Wallets]] [[PBKDF2]] [[Entropy and Randomness]] [[Social Engineering]] [[Private Key Management]]