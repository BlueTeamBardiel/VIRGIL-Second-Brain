# TLS certificate

## What it is
Think of it like a notarized passport issued by a trusted government office — it proves you are who you claim to be, and anyone can verify the stamp is real. Precisely, a TLS certificate is an X.509-formatted digital document that binds a public key to an entity's identity, signed by a Certificate Authority (CA) to cryptographically vouch for its authenticity. It enables both encryption and identity verification during the TLS handshake.

## Why it matters
In a **man-in-the-middle attack**, an adversary can intercept traffic between a client and server by presenting a fraudulent certificate. If the client's browser flags the certificate as untrusted (wrong CA, expired, mismatched domain), the attack is exposed — this is precisely why browsers maintain a curated list of trusted root CAs and why certificate pinning exists as a defense. The 2011 DigiNotar breach demonstrated catastrophically what happens when a CA is compromised: attackers issued fraudulent Google certificates and intercepted Iranian users' Gmail traffic.

## Key facts
- TLS certificates use **X.509 standard** and contain the subject's public key, issuer (CA), validity period, serial number, and digital signature
- **Certificate chain of trust**: Root CA → Intermediate CA → End-entity certificate; browsers trust root CAs embedded in the OS/browser store
- Certificates are identified by **Common Name (CN)** or **Subject Alternative Names (SANs)** for multi-domain coverage
- **Certificate Revocation** is handled via CRL (Certificate Revocation List) or OCSP (Online Certificate Status Protocol) — OCSP Stapling improves performance
- Certificates are **not the same as encryption** — a valid certificate can exist on a malicious phishing site using HTTPS; look for trust, not just the padlock

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Authority]] [[TLS Handshake]] [[Certificate Pinning]] [[OCSP Stapling]]