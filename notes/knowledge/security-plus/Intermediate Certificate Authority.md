# Intermediate Certificate Authority

## What it is
Think of it like a regional franchise manager: the CEO (Root CA) doesn't personally hire every employee, so they authorize regional managers (Intermediate CAs) to do it on their behalf. An Intermediate Certificate Authority is a CA that sits between the Root CA and end-entity certificates in a PKI chain, trusted transitively because it holds a certificate signed by the Root CA. This structure forms a **certificate chain** (or chain of trust) that browsers and systems validate before trusting a site.

## Why it matters
In 2011, DigiNotar — a Dutch CA — was compromised, and attackers issued fraudulent certificates for Google.com, enabling man-in-the-middle attacks against Iranian dissidents. Because DigiNotar operated as an intermediate issuer, browsers could revoke trust in that specific intermediate without destroying the entire PKI ecosystem — illustrating exactly why the isolation layer exists. If Root CAs issued end-entity certs directly and were compromised, the entire trust chain would collapse with no surgical fix.

## Key facts
- Root CAs are kept **offline** (air-gapped); Intermediate CAs operate online to handle day-to-day certificate issuance — this limits root key exposure
- A compromised intermediate CA can be **revoked individually** via CRL or OCSP without invalidating the Root CA's trust anchor
- Browsers validate certificates by walking the chain: **End-Entity → Intermediate CA → Root CA**
- Intermediate CA certificates are themselves signed by the Root CA, making them **cross-certified subordinates**
- The **path length constraint** (BasicConstraints extension) limits how many additional CAs an intermediate can authorize beneath it, preventing runaway chain depth

## Related concepts
[[Root Certificate Authority]] [[Chain of Trust]] [[Certificate Revocation List]] [[Online Certificate Status Protocol]] [[Public Key Infrastructure]]