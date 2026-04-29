# end-to-end encryption

## What it is
Imagine sending a letter inside a locked box where only you hold one key and your recipient holds the other — even the postal service never sees the contents. End-to-end encryption (E2EE) is a communication model where data is encrypted on the sender's device and can only be decrypted by the intended recipient, meaning no intermediary server — not even the service provider — can read the plaintext. The cryptographic keys exist only at the endpoints.

## Why it matters
In 2016, the FBI demanded Apple create a backdoor to break E2EE on the San Bernardino shooter's iPhone. Apple refused, arguing that weakening E2EE for one case creates a vulnerability exploitable by anyone — including hostile nation-states. This case illustrates why E2EE is both a critical privacy defense and a persistent target for government-mandated backdoors.

## Key facts
- E2EE uses **asymmetric key exchange** (e.g., Diffie-Hellman) to establish a shared secret, then typically switches to symmetric encryption (AES) for bulk data transfer — this hybrid approach is used by Signal Protocol.
- E2EE protects against **man-in-the-middle attacks** only if endpoint identity is verified; unverified key exchange leaves the door open for key substitution attacks.
- **Transport encryption (TLS)** is NOT E2EE — TLS encrypts data in transit but the server decrypts it, meaning the provider can read your messages.
- Metadata (who you talk to, when, how often) is generally **not protected** by E2EE — only message content is.
- Apps claiming E2EE must be verified: backdoors, key escrow, or logging at endpoints can silently negate all protections.

## Related concepts
[[asymmetric encryption]] [[public key infrastructure]] [[man-in-the-middle attack]] [[Transport Layer Security]] [[perfect forward secrecy]]