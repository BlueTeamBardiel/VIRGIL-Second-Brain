# DANE

## What it is
Think of DANE as stapling your TLS certificate directly to your DNS record — instead of trusting a random notary, you trust the deed registry itself. DNS-Based Authentication of Named Entities (DANE) is a protocol defined in RFC 6698 that uses DNSSEC-signed TLSA records to bind a TLS certificate to a specific domain, eliminating reliance on third-party Certificate Authorities.

## Why it matters
In 2011, the DigiNotar CA was compromised and issued fraudulent certificates for Google.com, enabling man-in-the-middle attacks against hundreds of thousands of Iranian users. DANE would have prevented this: even with a rogue CA-issued certificate, the attacker's cert wouldn't match the TLSA record pinned in the victim domain's DNSSEC-signed zone, and compliant clients would reject the connection outright.

## Key facts
- **TLSA record types** specify four combinations: which certificate to pin (CA or end-entity), and how to match it (full cert, SubjectPublicKeyInfo, or hash).
- **Requires DNSSEC** — without DNSSEC signing the zone, DANE provides no security guarantee, since TLSA records themselves could be spoofed.
- **Certificate Usage field** values: 0 (PKIX-TA), 1 (PKIX-EE), 2 (DANE-TA), 3 (DANE-EE) — DANE-EE(3) is most common for mail servers.
- **Widely adopted for SMTP**: MTA-STS and DANE/SMTP are the two competing standards for authenticating mail server TLS; DANE is preferred in high-security deployments.
- **Browser support is minimal** — Chrome and Firefox don't natively support DANE for HTTPS; it's most operationally relevant for email (SMTP) and XMPP.

## Related concepts
[[DNSSEC]] [[PKI]] [[Certificate Transparency]] [[MTA-STS]] [[TLS]]