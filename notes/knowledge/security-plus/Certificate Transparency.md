# Certificate Transparency

## What it is
Imagine every notary in the world had to record every document they stamped in a single public logbook anyone could inspect — Certificate Transparency does exactly that for SSL/TLS certificates. It's a framework (RFC 6962) that requires Certificate Authorities (CAs) to submit every issued certificate to public, append-only, cryptographically verifiable logs, allowing anyone to audit what certificates exist for a domain.

## Why it matters
In 2017, Google caught Symantec issuing thousands of unauthorized certificates — some for domains like google.com — without domain owners' knowledge. Because CT logs are public, domain owners can monitor them for misissued certificates and revoke rogue certs before attackers exploit them for man-in-the-middle attacks or phishing on legitimate-looking HTTPS sites.

## Key facts
- CT logs use **Merkle trees**, making them tamper-evident — any modification to historical entries is mathematically detectable
- Browsers like Chrome (since 2018) **require** valid Signed Certificate Timestamps (SCTs) embedded in certificates, or the TLS connection is rejected
- Domain owners can monitor CT logs using tools like **crt.sh** or Facebook's Certificate Transparency Monitoring to detect unauthorized issuance
- CAs must submit certificates **before or at issuance** and receive an SCT receipt proving the cert was logged
- CT does **not** prevent misissue — it provides *accountability and auditability*, not prevention; revocation still requires separate action (CRL/OCSP)

## Related concepts
[[Public Key Infrastructure]] [[Certificate Authority]] [[TLS/SSL]] [[OCSP Stapling]] [[Man-in-the-Middle Attack]]