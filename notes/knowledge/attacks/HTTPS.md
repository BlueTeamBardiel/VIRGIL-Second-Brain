# HTTPS

## What it is
Like a sealed, tamper-evident envelope handed between two people who've verified each other's identity — HTTPS is HTTP wrapped in TLS (Transport Layer Security), encrypting data in transit and authenticating the server via digital certificates. It ensures that what you send reaches the intended destination privately and without modification.

## Why it matters
In a classic Man-in-the-Middle (MitM) attack on plain HTTP, an attacker on a coffee shop Wi-Fi can silently intercept login credentials as they travel in cleartext. HTTPS defeats this by encrypting the session and binding the server's identity to a CA-signed certificate — if an attacker tries to intercept, the certificate won't match, and the browser throws a warning. This is why HSTS (HTTP Strict Transport Security) exists: to prevent browsers from ever falling back to HTTP.

## Key facts
- HTTPS operates on **port 443** by default; HTTP uses port 80
- TLS 1.2 and TLS 1.3 are current standards; SSLv3, TLS 1.0, and TLS 1.1 are deprecated and considered weak
- Certificates are issued by **Certificate Authorities (CAs)**; a compromised CA can issue fraudulent certificates for any domain (see: DigiNotar breach, 2011)
- **HSTS** instructs browsers to only use HTTPS for a domain, preventing SSL stripping attacks where an attacker downgrades the connection to HTTP
- A padlock icon indicates an encrypted channel — **not** that the site is trustworthy or legitimate; phishing sites routinely use valid HTTPS certificates

## Related concepts
[[TLS]] [[Certificate Authority]] [[Man-in-the-Middle Attack]] [[HSTS]] [[SSL Stripping]]