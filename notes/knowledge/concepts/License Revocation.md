# License Revocation

## What it is
Like a bouncer crossing your name off the VIP list mid-party — you had valid access, but that access has been explicitly cancelled before it naturally expires. License revocation is the process of invalidating a previously issued digital certificate or software license before its scheduled expiration date, rendering it untrusted or unusable immediately.

## Why it matters
In 2011, the certificate authority DigiNotar was compromised, and attackers issued fraudulent SSL certificates for Google.com. Browsers needed to revoke trust in *all* DigiNotar-issued certificates immediately — this crisis exposed the weakness of revocation infrastructure when CRL servers became overwhelmed and OCSP checks were being soft-failed, meaning browsers accepted potentially fraudulent certificates rather than blocking them.

## Key facts
- **Certificate Revocation Lists (CRLs)** are signed lists published by CAs containing serial numbers of revoked certificates; browsers download these periodically, creating a lag window.
- **OCSP (Online Certificate Status Protocol)** enables real-time revocation checking by querying a CA's responder server, but introduces latency and privacy concerns.
- **OCSP Stapling** solves the privacy problem — the *server* caches and presents the signed OCSP response to clients, eliminating direct client-to-CA queries.
- **Soft-fail vs. hard-fail**: Most browsers default to soft-fail (trust the cert if revocation check fails), making revocation largely ineffective when infrastructure is unavailable.
- Revocation reasons are standardized (RFC 5280): `keyCompromise`, `cACompromise`, `affiliationChanged`, `superseded`, `cessationOfOperation`, and `certificateHold`.

## Related concepts
[[Public Key Infrastructure]] [[Certificate Authority]] [[OCSP Stapling]] [[Digital Certificates]] [[Certificate Transparency]]