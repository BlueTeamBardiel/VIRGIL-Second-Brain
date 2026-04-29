# BIP-39

## What it is
Like converting a complex locker combination into a memorable phrase of ordinary words, BIP-39 (Bitcoin Improvement Proposal 39) is a standard that transforms a cryptographically random seed (128–256 bits of entropy) into a human-readable sequence of 12–24 common words called a mnemonic phrase. This phrase can deterministically regenerate the entire hierarchy of private keys for a cryptocurrency wallet.

## Why it matters
In 2019 and 2020, attackers ran "seed phrase phishing" campaigns where fake wallet recovery sites prompted victims to enter their 12-24 word mnemonic phrases — instantly handing over complete control of all funds. Because BIP-39 phrases encode the root key for every derived address, a single disclosure is a total and irreversible compromise; there is no "change your password" recovery option.

## Key facts
- BIP-39 uses a fixed wordlist of **2048 words**; each word encodes 11 bits of entropy, so 12 words = 132 bits (128 bits entropy + 4-bit checksum)
- The **checksum** is derived from the first bits of a SHA-256 hash of the entropy, making random word sequences detectable as invalid
- The mnemonic is converted to a **512-bit seed** via PBKDF2-HMAC-SHA512 with 2048 iterations, optionally salted with a passphrase (sometimes called the "25th word")
- BIP-39 is **not encrypted by default** — possession of the phrase equals possession of all funds, making physical security critical
- The optional passphrase creates a completely different wallet from the same words, enabling **plausible deniability** under duress (a legitimate defensive strategy)

## Related concepts
[[Hierarchical Deterministic Wallets (BIP-32)]] [[PBKDF2]] [[Entropy and Randomness]] [[Phishing]] [[Key Management]]