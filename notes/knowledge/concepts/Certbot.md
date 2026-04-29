# Certbot

## What it is
Think of Certbot as a robot notary that automatically stamps and renews your website's identity papers before they expire. Precisely, Certbot is an open-source ACME protocol client developed by the Electronic Frontier Foundation (EFF) that automates the issuance, installation, and renewal of TLS/SSL certificates from Let's Encrypt, a free Certificate Authority.

## Why it matters
In 2018, a misconfigured Certbot renewal job on a production server caused certificate expiration that dropped HTTPS entirely, exposing all traffic in plaintext — including session tokens. Defenders rely on Certbot's `--dry-run` and automated cron/systemd renewal timers to prevent exactly this failure mode, since expired certificates are a leading cause of unintended plaintext transmission and user-facing security warnings that attackers exploit via downgrade attacks.

## Key facts
- Certbot uses the **ACME (Automated Certificate Management Environment)** protocol (RFC 8555) to prove domain ownership through HTTP-01, DNS-01, or TLS-ALPN-01 challenges before issuing a certificate.
- Let's Encrypt certificates issued via Certbot are valid for **90 days**, intentionally short to encourage automation and limit exposure from key compromise.
- Certbot stores certificates in `/etc/letsencrypt/live/<domain>/` with separate files: `fullchain.pem` (cert + chain) and `privkey.pem` (private key).
- The **HTTP-01 challenge** requires port 80 to be publicly accessible; the **DNS-01 challenge** allows wildcard certificates and works without an open web server.
- Certbot operates under the principle of **least privilege** when configured correctly — the `--webroot` plugin avoids running as root by writing challenge files to an existing document root.

## Related concepts
[[TLS/SSL Certificates]] [[Public Key Infrastructure (PKI)]] [[Certificate Authority]] [[HTTPS]] [[Man-in-the-Middle Attack]]