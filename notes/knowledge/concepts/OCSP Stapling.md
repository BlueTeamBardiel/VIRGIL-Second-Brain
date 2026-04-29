# OCSP Stapling

## What it is
Like a restaurant stapling the health inspector's fresh daily certificate to your menu so you don't have to call the health department yourself — OCSP Stapling lets a web server attach a pre-fetched, time-stamped certificate validity response directly to the TLS handshake. Instead of the client querying the Certificate Authority's Online Certificate Status Protocol responder, the server does it in advance and "staples" the signed proof alongside its certificate.

## Why it matters
Without stapling, every TLS connection triggers a separate client-side OCSP lookup — leaking browsing behavior to CAs and introducing latency. More critically, many browsers implement "soft-fail" behavior, meaning if the OCSP responder is unreachable (e.g., via DoS), the browser proceeds anyway — effectively nullifying revocation checking entirely. Stapling eliminates both the privacy leak and the soft-fail bypass risk.

## Key facts
- The stapled OCSP response is signed by the CA, so a malicious server cannot forge a "certificate is valid" response
- Stapled responses are cached and have a short validity window (typically 24–48 hours), balancing freshness with performance
- OCSP Must-Staple is an X.509 certificate extension that forces browsers to **hard-fail** if no valid stapled response is present — eliminating soft-fail weakness
- Defined in **RFC 6066** (TLS Certificate Status Request extension) and **RFC 6960** (OCSP protocol itself)
- Without stapling, a passive observer can correlate client IPs with specific certificate lookups at the CA's OCSP responder — a real privacy threat

## Related concepts
[[Certificate Revocation List (CRL)]] [[Public Key Infrastructure (PKI)]] [[TLS Handshake]] [[Certificate Transparency]] [[X.509 Certificates]]