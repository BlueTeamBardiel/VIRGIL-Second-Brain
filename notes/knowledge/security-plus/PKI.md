# PKI

## What it is
Think of PKI like a chain of notaries — where each notary is vouched for by a more senior notary, all the way up to a Grand Notary everyone agrees to trust. Public Key Infrastructure is the complete framework of hardware, software, policies, and standards used to issue, manage, distribute, and revoke digital certificates that bind public keys to verified identities. It enables asymmetric encryption at scale across the internet.

## Why it matters
In 2011, the Dutch Certificate Authority DigiNotar was compromised, and attackers issued fraudulent certificates for Google.com — allowing them to perform man-in-the-middle attacks against ~300,000 Iranian Gmail users whose traffic appeared legitimately encrypted. This attack demonstrated that the entire PKI trust chain collapses if a single CA is rogue or breached; browsers responded by blacklisting DigiNotar entirely, bankrupting the company within weeks.

## Key facts
- **Root CA** sits at the top of the trust chain; its certificate is self-signed and pre-installed in browsers/OS trust stores
- **Certificate Revocation** is handled via **CRL** (Certificate Revocation List) or **OCSP** (Online Certificate Status Protocol) — OCSP is faster and more real-time
- **Registration Authority (RA)** handles identity verification on behalf of the CA but cannot issue certificates itself
- **Certificate pinning** hardens applications by hardcoding expected certificates, bypassing the standard chain-of-trust validation entirely
- X.509 is the standard format for digital certificates; it contains the subject, issuer, public key, validity period, and digital signature

## Related concepts
[[Digital Certificates]] [[Asymmetric Encryption]] [[Certificate Authority]] [[Man-in-the-Middle Attack]] [[OCSP]]