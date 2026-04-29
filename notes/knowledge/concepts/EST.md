# EST

## What it is
Think of EST like a DMV that issues driver's licenses, but for cryptographic certificates — and it works entirely over HTTPS instead of requiring you to show up in person. EST (Enrollment over Secure Transport) is a protocol defined in RFC 7030 that allows clients to request and renew X.509 certificates from a Certificate Authority using HTTPS as the transport layer, replacing the older SCEP protocol with stronger security defaults.

## Why it matters
When a company deploys thousands of IoT devices or network equipment that each need unique TLS certificates, EST automates that enrollment process securely. Without proper EST implementation, attackers could intercept certificate requests over poorly secured SCEP channels (which historically used weak encryption like 3DES) and issue fraudulent certificates — enabling man-in-the-middle attacks against internal infrastructure.

## Key facts
- EST operates over **HTTPS on port 443** (or 8443), leveraging TLS for transport security — no separate security layer needed like SCEP required
- Defined in **RFC 7030**; designed as a modern replacement for SCEP (Simple Certificate Enrollment Protocol)
- Supports **client certificate authentication, HTTP Basic Auth, and digest authentication** for proving identity during enrollment
- EST endpoints follow a standard URI format: `/.well-known/est/` making discovery predictable and automatable
- EST supports **full enrollment, re-enrollment, and CA certificate retrieval** — the complete certificate lifecycle in one protocol

## Related concepts
[[PKI]] [[X.509 Certificates]] [[SCEP]] [[TLS]] [[Certificate Authority]]