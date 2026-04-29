# Public Key Infrastructure

## What it is
Think of PKI like a chain of notaries: you trust a document because a notary you already trust vouched for another notary, who vouched for the person who signed it. PKI is a hierarchical system of policies, roles, and technologies that manages the creation, distribution, storage, revocation, and validation of digital certificates. It binds public keys to verified identities through Certificate Authorities (CAs), enabling trusted encrypted communication at scale.

## Why it matters
In 2011, the Dutch CA DigiNotar was compromised, and attackers issued fraudulent certificates for google.com — allowing Iranian ISPs to intercept Gmail traffic through a man-in-the-middle attack on ~300,000 users. This attack exposed what happens when a single trusted CA is corrupted: every browser that inherently trusted DigiNotar became a liability until it was forcibly removed from trusted root stores, taking DigiNotar bankrupt within months.

## Key facts
- **Root CA → Intermediate CA → End-entity certificate** is the standard chain of trust; the root CA is kept offline to minimize exposure
- **Certificate Revocation List (CRL)** and **OCSP (Online Certificate Status Protocol)** are the two mechanisms for checking if a certificate has been revoked before its expiration date
- **X.509** is the standard format for PKI certificates; it contains the subject, issuer, public key, validity period, and digital signature
- A **wildcard certificate** (e.g., `*.example.com`) secures all subdomains but creates single-point-of-failure risk if the private key is compromised
- **Certificate pinning** is a defense technique where an application hardcodes an expected certificate or public key, preventing trust in fraudulent CA-issued replacements

## Related concepts
[[Digital Certificates]] [[Certificate Authority]] [[Man-in-the-Middle Attack]] [[Asymmetric Encryption]] [[OCSP Stapling]]