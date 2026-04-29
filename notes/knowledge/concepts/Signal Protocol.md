# Signal Protocol

## What it is
Imagine passing a note where every word is written in a new cipher key that only exists for that sentence, then immediately destroyed — that's essentially what Signal Protocol does. It is an open-source cryptographic protocol that provides end-to-end encryption with **forward secrecy** and **break-in recovery** by continuously generating and discarding ephemeral keys through a mechanism called the Double Ratchet Algorithm. It underpins WhatsApp, Signal Messenger, and Google Messages.

## Why it matters
In 2016, when the FBI demanded Apple unlock an iPhone, secure messaging was front-and-center in the encryption debate. Signal Protocol's architecture means that even if a threat actor compromises a server or steals a long-term private key today, they cannot decrypt yesterday's conversations — because those session keys were already destroyed. This mathematically limits the blast radius of any single key compromise.

## Key facts
- **Double Ratchet Algorithm** combines the Diffie-Hellman ratchet (key agreement) and a symmetric-key ratchet (chain keys) to generate unique per-message encryption keys
- **Forward Secrecy** (Perfect Forward Secrecy): compromise of long-term keys does NOT expose past session traffic
- **Break-in Recovery (Future Secrecy)**: after a compromise, security automatically restores itself as new DH ratchet steps occur
- Uses **X3DH (Extended Triple Diffie-Hellman)** for the initial key exchange between parties who may be offline
- Keys are generated and stored **on endpoints only** — the server never holds decryption keys, making server breaches far less catastrophic

## Related concepts
[[End-to-End Encryption]] [[Perfect Forward Secrecy]] [[Diffie-Hellman Key Exchange]] [[Asymmetric Encryption]] [[Key Management]]