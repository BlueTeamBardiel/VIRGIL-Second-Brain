# Intermediate Certificate

## What it is
Think of it like a franchise manager between corporate headquarters and the local store — they're not the ultimate authority, but they're trusted by headquarters to vouch for the stores below them. An intermediate certificate is a subordinate CA certificate that sits between the root CA and end-entity certificates in a PKI chain, inheriting trust from the root while issuing certificates to servers or users. This design keeps the root CA offline and protected while day-to-day signing operations continue uninterrupted.

## Why it matters
In 2011, the Dutch CA DigiNotar was compromised, and attackers used its intermediate CA authority to issue fraudulent certificates for Google, enabling man-in-the-middle attacks against Iranian Gmail users. Had stricter intermediate CA controls and certificate transparency been enforced, the rogue certificates would have been detected far sooner. This incident directly accelerated adoption of Certificate Transparency logs and tighter intermediate CA auditing requirements.

## Key facts
- The full **chain of trust** must be presented during a TLS handshake: end-entity cert → intermediate cert(s) → root cert; missing intermediates cause "untrusted certificate" errors even if the root is trusted.
- Root CAs are kept **air-gapped and offline**; intermediate CAs do the actual day-to-day signing, limiting exposure of the root private key.
- Intermediate certificates have **path length constraints** (Basic Constraints extension) that limit how many additional subordinate CAs can be chained below them.
- If an intermediate CA is compromised, it can be **revoked via CRL or OCSP** without burning the root CA, preserving the entire trust hierarchy.
- Browsers and OSes ship with **pre-trusted root CAs only**; intermediate certificates must be explicitly served by the web server or fetched by the client.

## Related concepts
[[Public Key Infrastructure]] [[Certificate Authority]] [[Chain of Trust]] [[Certificate Revocation List]] [[Certificate Transparency]]