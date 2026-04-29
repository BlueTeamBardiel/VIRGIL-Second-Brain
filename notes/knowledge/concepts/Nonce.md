# nonce

## What it is
Like a ticket stub that's torn in half the moment you use it — valid once, useless forever after. A nonce is a cryptographic value used exactly one time in a communication protocol, typically a random or pseudo-random number, to ensure that old messages cannot be replayed in a new context.

## Why it matters
In authentication protocols, an attacker who captures a valid login exchange can attempt a **replay attack** — resending the captured credentials to impersonate the user. A nonce defeats this by requiring that each authentication session include a fresh, unpredictable value; if the server has already seen that nonce, it rejects the request outright, making captured traffic worthless.

## Key facts
- **Nonce = Number Used Once** — the name is literally a contraction of this phrase
- In **TLS handshakes**, both client and server generate nonces that feed into session key derivation, ensuring each session produces unique encryption keys even with the same certificates
- **WPA2 uses a 4-way handshake** with nonces (ANonce/SNonce) to derive the Pairwise Transient Key (PTK) — this is exactly what KRACK attacked by forcing nonce reuse
- A nonce does **not** need to be secret, only unique and unpredictable; its job is freshness, not secrecy
- **Nonce reuse is catastrophic**: in AES-GCM, reusing a nonce with the same key allows an attacker to recover the plaintext and forge authentication tags

## Related concepts
[[replay attack]] [[initialization vector]] [[challenge-response authentication]] [[AES-GCM]] [[TLS handshake]]