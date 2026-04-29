# OCSP

## What it is
Like calling a pharmacy to verify a prescription is still valid before filling it — rather than checking a printed list of revoked prescriptions from last week. OCSP (Online Certificate Status Protocol) is a real-time protocol used to check whether a specific X.509 digital certificate has been revoked, replacing the need to download entire Certificate Revocation Lists (CRLs). A client sends a certificate serial number to an OCSP responder, which replies with "good," "revoked," or "unknown."

## Why it matters
In 2011, the DigiNotar CA was compromised and issued fraudulent certificates for Google domains. Browsers using OCSP could query in real-time and receive revoked status for those certificates — but attackers discovered that stripping OCSP requests (the "OCSP stapling bypass" or soft-fail problem) meant browsers would silently accept the fraudulent cert rather than block the connection. This soft-fail behavior remains a critical weakness: if the OCSP responder is unreachable, most clients default to trusting the certificate anyway.

## Key facts
- **OCSP stapling** allows the web server to attach (staple) a pre-fetched, CA-signed OCSP response to the TLS handshake, reducing latency and protecting user privacy by not exposing browsing habits to the CA
- OCSP responses are typically valid for hours to days and are signed by the CA or a delegated OCSP responder
- **Soft-fail vs. hard-fail**: most browsers use soft-fail (allow if OCSP is unreachable), making OCSP susceptible to denial-of-service-based bypass attacks
- OCSP Must-Staple is a certificate extension that forces hard-fail behavior, requiring a valid stapled response or the connection is rejected
- OCSP supersedes CRL for most use cases because CRLs can grow large and become stale between publishing intervals

## Related concepts
[[PKI]] [[Certificate Revocation List]] [[TLS Handshake]] [[X.509 Certificates]] [[Certificate Authority]]