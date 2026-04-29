# Root Certificate Authority

## What it is
Think of a Root CA like the Vatican of trust — every bishop (intermediate CA) and priest (end-entity certificate) derives their authority from this single, supreme institution. Precisely: a Root CA is a self-signed certificate authority at the top of a PKI trust chain whose public key is pre-installed in operating systems and browsers, making it the ultimate trust anchor for validating all certificates beneath it.

## Why it matters
In 2011, attackers compromised DigiNotar, a Dutch Root CA, and issued over 500 fraudulent certificates — including one for `*.google.com` — enabling man-in-the-middle attacks against Iranian Gmail users. Because browsers inherently trusted DigiNotar's root, every certificate it signed was automatically trusted until browsers manually removed DigiNotar from their trusted root stores, destroying the company entirely.

## Key facts
- Root CA certificates are **self-signed** — they have no higher authority validating them; trust is established by pre-installation in the OS/browser trust store
- Root CAs are kept **offline (air-gapped)** in production environments to protect the private key; day-to-day signing is delegated to intermediate CAs
- Compromise of a Root CA private key requires **mass revocation** and removal from trust stores — a catastrophic, near-unrecoverable event
- The trust store on Windows is managed via **Group Policy / Windows Update**; on Linux, typically via `/etc/ssl/certs/`
- Certificate pinning is a defense technique that bypasses Root CA trust entirely by hardcoding expected certificates directly into applications

## Related concepts
[[Public Key Infrastructure]] [[Intermediate Certificate Authority]] [[Certificate Revocation List]] [[Certificate Pinning]] [[Man-in-the-Middle Attack]]