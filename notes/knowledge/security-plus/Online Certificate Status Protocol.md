# Online Certificate Status Protocol

## What it is
Like calling a bank's fraud hotline to check if a credit card is still valid before accepting payment — instead of consulting a massive printed list of cancelled cards. OCSP is a real-time protocol (RFC 6960) that allows clients to query a Certificate Authority's responder to check whether a specific X.509 digital certificate has been revoked, without downloading the entire Certificate Revocation List.

## Why it matters
During the 2011 DigiNotar breach, attackers issued fraudulent certificates for Google.com that were used to intercept Iranian users' encrypted traffic. Browsers using OCSP could query the CA and receive a revocation response — but a weakness called "soft-fail" meant browsers accepted connections even when the OCSP responder was unreachable, letting attackers block OCSP traffic and keep the fraudulent certs working.

## Key facts
- OCSP queries are sent to the **OCSP Responder URL** embedded in the certificate's Authority Information Access (AIA) extension
- Responses are signed by the CA and contain one of three statuses: **Good**, **Revoked**, or **Unknown**
- **OCSP Stapling** (RFC 6066) has the web server pre-fetch and attach the signed OCSP response to the TLS handshake, reducing latency and protecting user privacy by hiding browsing habits from the CA
- **Soft-fail** vs **Hard-fail**: soft-fail allows connection if OCSP is unreachable (default, weaker); hard-fail blocks the connection (more secure but risks availability)
- OCSP is faster and lighter than CRLs but introduces a privacy concern — the CA learns which sites users visit unless stapling is used

## Related concepts
[[Certificate Revocation List]] [[Public Key Infrastructure]] [[Transport Layer Security]] [[X.509 Certificates]] [[Certificate Transparency]]