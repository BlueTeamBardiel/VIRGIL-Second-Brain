# OpenSSL

## What it is
Think of OpenSSL as the Swiss Army knife of a master locksmith — it contains every tool needed to create locks, cut keys, verify identities, and test existing locks for weaknesses. Precisely, OpenSSL is an open-source cryptographic library and command-line toolkit that implements SSL/TLS protocols and a wide range of cryptographic functions, used by web servers, applications, and administrators worldwide to secure communications and manage certificates.

## Why it matters
In 2014, the Heartbleed vulnerability (CVE-2014-0160) exposed a catastrophic flaw in OpenSSL's heartbeat extension, allowing attackers to read 64KB chunks of server memory per request — repeatedly — leaking private keys, session tokens, and passwords without leaving a trace in logs. Because OpenSSL underpinned roughly two-thirds of the internet's HTTPS traffic at the time, a single library bug became a global incident requiring mass certificate revocation and reissuance.

## Key facts
- OpenSSL implements **SSLv2, SSLv3, TLS 1.0–1.3**, though older versions are deprecated and should be explicitly disabled
- The `openssl s_client` command is a critical pentesting tool for manually testing TLS handshakes, certificate chains, and cipher suites
- Heartbleed (CVE-2014-0160) was a **buffer over-read** bug in the heartbeat extension — not a flaw in TLS itself
- OpenSSL can generate **CSRs (Certificate Signing Requests)**, self-signed certificates, and perform key pair generation via CLI
- FIPS 140-2 validated builds of OpenSSL exist for government/compliance environments requiring approved cryptographic modules

## Related concepts
[[TLS/SSL]] [[Public Key Infrastructure]] [[Certificate Authority]] [[Heartbleed]] [[Cipher Suites]]