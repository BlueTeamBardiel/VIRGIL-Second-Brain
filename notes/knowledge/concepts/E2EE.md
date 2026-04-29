# E2EE

## What it is
Like passing a locked box where only you have the key and only your recipient has the matching key — the postal service, the courier, and every warehouse along the route sees nothing but a sealed container. End-to-End Encryption (E2EE) is a communication model where data is encrypted on the sender's device and can only be decrypted by the intended recipient, meaning no intermediary server, provider, or ISP can read the plaintext content.

## Why it matters
In 2021, a legal battle involving Apple and the FBI highlighted E2EE's power: iMessage content stored in transit is unreadable even to Apple, so law enforcement subpoenas to Apple yield nothing useful. Conversely, when WhatsApp's metadata (not content) was subpoenaed, investigators could still map communication patterns — demonstrating that E2EE protects *content* but not necessarily *metadata*, a critical distinction in threat modeling.

## Key facts
- E2EE uses **asymmetric cryptography** (public/private key pairs) for key exchange, then typically switches to symmetric keys (e.g., AES-256) for bulk data encryption — this hybrid model is called a **Key Encapsulation Mechanism (KEM)**
- **Signal Protocol** is the gold standard implementation, used by Signal, WhatsApp, and Meta Messenger — it provides **forward secrecy** via rotating session keys
- E2EE does **not** protect metadata: who communicated, when, how often, and message size remain visible to providers
- **Transport encryption (TLS)** is *not* E2EE — TLS decrypts at the server, meaning the provider can read your data; E2EE ensures the server never holds plaintext
- Key management is E2EE's weakness — if private keys are compromised or backed up to unencrypted cloud storage, the entire model collapses

## Related concepts
[[Asymmetric Encryption]] [[Forward Secrecy]] [[Public Key Infrastructure]] [[Transport Layer Security]] [[Key Management]]