# X.509

## What it is
Think of X.509 like a notarized ID card: it's not enough for someone to hand you a business card claiming they're a doctor — a trusted authority (the notary) must stamp and sign it. X.509 is the ITU-T standard that defines the structure of digital certificates, binding a public key to an identity through the cryptographic signature of a Certificate Authority (CA). It underpins TLS/SSL, S/MIME, code signing, and virtually every PKI deployment on the internet.

## Why it matters
In the 2011 DigiNotar breach, attackers compromised a Dutch CA and issued fraudulent X.509 certificates for Google.com, enabling man-in-the-middle attacks against Iranian users intercepting "valid" HTTPS traffic. The attack worked precisely because browsers trusted DigiNotar's root certificate — demonstrating that the entire X.509 trust model collapses when a CA is compromised, which is why certificate pinning and Certificate Transparency logs now exist as countermeasures.

## Key facts
- An X.509 certificate contains: version, serial number, issuer, subject, validity period (not before/not after), public key, and the CA's digital signature.
- Version 3 (X.509v3) introduced **extensions**, enabling Subject Alternative Names (SANs), key usage constraints, and CRL distribution points.
- Certificate revocation is handled via **CRL** (Certificate Revocation List) or **OCSP** (Online Certificate Status Protocol) — a revoked cert has a serial number listed but isn't automatically rejected without client-side checking.
- The **chain of trust** works from root CA → intermediate CA → end-entity certificate; root CAs are self-signed and stored in OS/browser trust stores.
- A certificate with a mismatched CN/SAN triggers a browser warning but does **not** break encryption — it breaks **authentication**, not confidentiality.

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Authority (CA)]] [[Transport Layer Security (TLS)]] [[Certificate Transparency]] [[OCSP Stapling]]