# Subject Alternative Name

## What it is
Think of a SAN like a hotel key card programmed to open multiple rooms — one certificate, many valid doors. A Subject Alternative Name (SAN) is an X.509 certificate extension that allows a single TLS/SSL certificate to be valid for multiple hostnames, IP addresses, email addresses, or domain names simultaneously.

## Why it matters
When a company deploys a wildcard or multi-domain certificate incorrectly — omitting a SAN entry for a subdomain — attackers can exploit the certificate mismatch to trigger browser warnings, enabling phishing pages that look "broken enough" to confuse users. Conversely, defenders use SAN certificates to legitimately consolidate hundreds of subdomains under one certificate, reducing management overhead and attack surface from certificate sprawl.

## Key facts
- SANs have **replaced the Common Name (CN) field** as the authoritative source for hostname validation; modern browsers (Chrome since 2017) ignore the CN entirely and only check SANs.
- A single SAN certificate can cover **mixed types**: `DNS:example.com`, `IP:192.168.1.1`, and `email:admin@example.com` in the same cert.
- Wildcard entries in SANs (`*.example.com`) only match **one level deep** — they do NOT cover `sub.sub.example.com`.
- SAN misconfiguration is a common finding in **TLS certificate audits** and can lead to failed mutual TLS (mTLS) authentication in zero-trust architectures.
- Certificate Transparency (CT) logs expose all SANs publicly, which attackers use for **subdomain enumeration** during reconnaissance.

## Related concepts
[[X.509 Certificate]] [[Wildcard Certificate]] [[Certificate Transparency]] [[Public Key Infrastructure]] [[Transport Layer Security]]