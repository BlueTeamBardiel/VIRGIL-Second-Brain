# Certificate Revocation

## What it is
Like a hotel that issues key cards — if a guest is caught stealing, you don't wait for their checkout date, you deactivate the card immediately. Certificate revocation is the process of invalidating a digital certificate *before* its scheduled expiration date, typically because the private key was compromised, the CA made an error, or the entity is no longer trusted.

## Why it matters
In 2011, the DigiNotar CA was compromised and attackers issued fraudulent certificates for Google.com, enabling man-in-the-middle attacks against Iranian Gmail users. Browsers had to rapidly revoke trust in DigiNotar's entire certificate chain — demonstrating that revocation infrastructure is a critical last line of defense when a CA itself is breached.

## Key facts
- **CRL (Certificate Revocation List):** A CA-published list of revoked serial numbers; clients download it periodically, making it potentially stale and bandwidth-heavy.
- **OCSP (Online Certificate Status Protocol):** Real-time revocation checking by querying a responder with a specific certificate's serial number; reduces latency compared to full CRL downloads.
- **OCSP Stapling:** The *server* periodically fetches and caches a signed OCSP response, then "staples" it to the TLS handshake — eliminating the privacy leak of clients querying OCSP responders directly.
- **Revocation reasons (RFC 5280):** Include `keyCompromise`, `cACompromise`, `affiliationChanged`, `superseded`, and `cessationOfOperation` — knowing these reason codes appears on exams.
- **Soft-fail vs. Hard-fail:** Most browsers use soft-fail (proceed if OCSP is unreachable), which attackers can exploit by blocking OCSP responses — a known weakness in current revocation systems.

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Authority]] [[TLS Handshake]] [[OCSP Stapling]] [[Digital Certificates]]