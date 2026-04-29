# GPG

## What it is
Think of GPG like a public lockbox in a town square: anyone can drop a message in using your publicly posted combination, but only you have the private key to open it. GPG (GNU Privacy Guard) is an open-source implementation of the OpenPGP standard (RFC 4880) that provides cryptographic privacy and authentication through asymmetric key pairs, supporting encryption, decryption, and digital signing of files and communications.

## Why it matters
In 2016, whistleblowers and journalists used GPG-encrypted channels to safely exchange sensitive documents — the same infrastructure SecureDrop relies on to protect sources from nation-state surveillance. Conversely, attackers have exploited misconfigured GPG key servers by flooding them with certificate spam (the 2019 SKS keyserver poisoning attack), rendering legitimate public keys unusable and disrupting encrypted workflows.

## Key facts
- Uses **asymmetric cryptography**: your public key encrypts, your private key decrypts; your private key signs, your public key verifies
- Implements the **Web of Trust** model — trust is established through peer signatures on keys, unlike PKI's centralized Certificate Authority hierarchy
- Default algorithm suite includes **RSA or Ed25519** for signing and **AES-256** for symmetric encryption of the actual payload (hybrid encryption)
- A GPG **fingerprint** is a SHA-1 or SHA-256 hash of the public key — used to verify key authenticity out-of-band (e.g., reading it aloud over a phone call)
- GPG **does not provide forward secrecy** by default — if your private key is compromised later, past encrypted messages can be decrypted

## Related concepts
[[Public Key Infrastructure]] [[Digital Signatures]] [[Asymmetric Encryption]] [[S/MIME]] [[Key Management]]