# SSL

## What it is
Think of SSL like a wax seal on a medieval letter — it proves the sender is who they claim to be and shows tampering if broken. SSL (Secure Sockets Layer) is a cryptographic protocol that establishes an encrypted, authenticated channel between a client and server using a handshake that negotiates cipher suites and exchanges certificates.

## Why it matters
In 2014, the POODLE attack (Padding Oracle On Downgraded Legacy Encryption) demonstrated that attackers could force browsers to fall back to SSL 3.0 — a 20-year-old protocol — and then exploit its flawed CBC padding to decrypt session cookies. This is why modern servers explicitly disable SSL 3.0 and all SSL versions, accepting only TLS 1.2 or 1.3.

## Key facts
- SSL is **cryptographically broken** — all versions (SSL 2.0, 3.0) are deprecated; TLS replaced it, but the term "SSL" is still colloquially misused
- The SSL/TLS handshake involves: **ClientHello → ServerHello → Certificate → Key Exchange → Finished** — cipher suite negotiation happens in the first two messages
- SSL uses **port 443** for HTTPS; unencrypted HTTP uses port 80
- SSL 3.0 is vulnerable to **POODLE**; SSL 2.0 is vulnerable to **DROWN** (cross-protocol attacks against servers still supporting it)
- SSL certificates contain the server's **public key**, issuing CA, validity period, and the **Subject Alternative Name (SAN)** — exams test that CN alone is deprecated for hostname validation

## Related concepts
[[TLS]] [[PKI]] [[Certificate Authority]] [[Man-in-the-Middle Attack]] [[Cipher Suites]]