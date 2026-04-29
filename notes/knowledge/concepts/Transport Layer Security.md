# Transport Layer Security

## What it is
Think of TLS like a diplomatic pouch: before any letters are exchanged, both parties verify each other's credentials and agree on a secret sealing wax pattern that only they know — after that, every letter is sealed, tamper-evident, and unreadable to anyone else. TLS is a cryptographic protocol that provides confidentiality, integrity, and authentication for data in transit between two endpoints. It operates at the transport layer, wrapping application-layer protocols like HTTP, SMTP, and FTP in an encrypted tunnel.

## Why it matters
In 2014, the POODLE attack demonstrated that forcing a TLS connection to downgrade to SSL 3.0 allowed attackers to decrypt session cookies using a padding oracle technique — stealing authenticated sessions without ever cracking the encryption directly. This is why modern configurations explicitly disable SSL 3.0 and TLS 1.0/1.1, accepting only TLS 1.2 or 1.3. Hardening TLS cipher suites is now a baseline compliance requirement under PCI-DSS and NIST guidelines.

## Key facts
- TLS 1.3 (RFC 8446) eliminates the RSA key exchange entirely, enforcing **forward secrecy** by default through ephemeral Diffie-Hellman (DHE/ECDHE)
- The **TLS handshake** authenticates the server (and optionally the client) via X.509 certificates before any application data flows
- **Cipher suites** define the negotiated combination of key exchange, authentication, bulk encryption, and MAC algorithms (e.g., `TLS_AES_256_GCM_SHA384`)
- TLS **does not protect against** endpoint compromise — it only secures data in transit
- **Certificate pinning** is a defense against rogue CAs issuing fraudulent certificates for legitimate domains

## Related concepts
[[Public Key Infrastructure]] [[Certificate Authority]] [[HTTPS]] [[Diffie-Hellman Key Exchange]] [[Man-in-the-Middle Attack]]