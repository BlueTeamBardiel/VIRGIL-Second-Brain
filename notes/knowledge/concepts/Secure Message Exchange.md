# Secure Message Exchange

## What it is
Think of it like passing a sealed, wax-stamped letter through a postal system where only the recipient has the unique seal-breaker — even the postal workers can't read it. Secure message exchange is the use of cryptographic protocols to ensure that data transmitted between two parties maintains **confidentiality** (only the intended recipient reads it), **integrity** (it wasn't tampered with), and **authentication** (it came from who it claims). It encompasses the combination of symmetric encryption, asymmetric key exchange, digital signatures, and hashing working in concert.

## Why it matters
In 2011, DigiNotar's compromised certificate authority allowed attackers to forge trusted certificates, enabling man-in-the-middle attacks against over 300,000 Iranian Gmail users — intercepting "secure" messages without detection. This attack illustrated that secure message exchange fails catastrophically when the trust infrastructure (certificate validation) is compromised, even if the underlying encryption algorithms are sound.

## Key facts
- **TLS (Transport Layer Security)** is the dominant protocol for secure message exchange on the web, using asymmetric crypto for key exchange and symmetric crypto for bulk data encryption
- A **digital signature** provides non-repudiation — the sender cannot later deny sending the message, because only their private key could have produced that signature
- **Perfect Forward Secrecy (PFS)** uses ephemeral session keys so that compromise of a long-term private key does NOT decrypt previously recorded sessions
- **S/MIME** and **PGP/GPG** are the two primary standards for securing email at the message layer (not just transport)
- The **CIA triad** is verified through: encryption (confidentiality), HMAC/hashing (integrity), and certificates/signatures (authentication)

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Digital Signatures]] [[Transport Layer Security (TLS)]] [[Perfect Forward Secrecy]] [[Man-in-the-Middle Attack]]