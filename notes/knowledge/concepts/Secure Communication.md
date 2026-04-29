# Secure Communication

## What it is
Like a diplomatic pouch sealed with wax and carried by a trusted courier — only the intended recipient can open it — secure communication ensures that data in transit cannot be read, altered, or forged by anyone intercepting the channel. Precisely: it is the use of cryptographic protocols (encryption, authentication, and integrity checking) to protect data exchanged between two or more parties across an untrusted network.

## Why it matters
In 2011, a DigiNotar CA compromise allowed attackers to issue fraudulent TLS certificates, enabling man-in-the-middle attacks against 300,000+ Iranian Gmail users — their "secure" HTTPS connections were being silently intercepted and decrypted. This demonstrated that secure communication depends not just on encryption, but on the trustworthiness of the entire certificate infrastructure beneath it.

## Key facts
- **TLS 1.3** (current standard) eliminates weak cipher suites, mandatory forward secrecy via ephemeral Diffie-Hellman, and reduces handshake latency to one round trip
- **Perfect Forward Secrecy (PFS)** ensures that compromise of a long-term private key does NOT decrypt past recorded sessions, because session keys are ephemeral
- **Certificate pinning** mitigates rogue CA attacks by hardcoding expected certificates or public keys directly into an application
- **Downgrade attacks** (e.g., POODLE, BEAST) force connections to negotiate weaker legacy protocols (SSL 3.0, TLS 1.0); mitigated by disabling deprecated protocol versions server-side
- The **CIA triad mapping**: encryption → Confidentiality; MACs/digital signatures → Integrity; mutual TLS (mTLS) → Authentication/non-repudiation

## Related concepts
[[Public Key Infrastructure]] [[Man-in-the-Middle Attack]] [[Transport Layer Security]] [[Certificate Authority]] [[Perfect Forward Secrecy]]