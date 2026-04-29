# Trezor

## What it is
Like a bank vault bolted to your keychain that never hands over the keys — only signs the transaction inside itself — a Trezor is a hardware wallet (cold storage device) that generates and stores cryptocurrency private keys in an isolated, offline environment. The private key never leaves the physical device, even during transaction signing.

## Why it matters
In the 2020 Ledger data breach, attackers exfiltrated customer contact information and used it for phishing campaigns to steal seed phrases — the master recovery codes for hardware wallets. This illustrates that even secure hardware fails when the *human* holding the seed phrase is socially engineered; physical security of the device is only half the threat model. A Trezor protects against remote software attacks but cannot protect a user who types their 24-word seed phrase into a phishing website.

## Key facts
- Trezor uses a **BIP-39 seed phrase** (typically 24 words) as the human-readable backup for all stored private keys — compromise the seed, compromise everything
- Transactions are **signed on-device**; the host computer only sees the signed output, never the private key itself (air-gap signing model)
- Trezor Model T supports **passphrase encryption** (a 25th word), creating a hidden wallet even if the seed phrase is stolen
- The device uses a **secure element-adjacent architecture** with open-source firmware, making it auditable but occasionally criticized compared to closed secure-element designs
- Supply chain attacks are a documented threat vector — tampered devices shipped with pre-loaded seed phrases have been used to steal funds before users even set up the wallet

## Related concepts
[[Cold Storage]] [[Private Key Infrastructure]] [[Hardware Security Module (HSM)]] [[Seed Phrase Security]] [[Supply Chain Attack]]