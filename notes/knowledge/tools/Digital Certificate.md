# Digital Certificate

## What it is
Think of a digital certificate like a notarized passport — it's not enough to claim who you are, you need a trusted third party to stamp and sign the document. Precisely, a digital certificate is an electronic document that binds a public key to an identity (person, server, or organization), signed by a trusted Certificate Authority (CA) using the X.509 standard. It lets strangers on the internet verify "yes, this public key actually belongs to example.com."

## Why it matters
In 2011, the Dutch CA DigiNotar was compromised, and attackers issued fraudulent certificates for Google.com — allowing Iranian ISPs to perform man-in-the-middle attacks against ~300,000 Gmail users who had no idea their "secure" HTTPS connection was being intercepted. This attack illustrates why certificate chain validation and CA trustworthiness are critical: a compromised root CA poisons everything it has ever signed.

## Key facts
- Certificates follow the **X.509 standard** and contain: subject, issuer, public key, validity period, serial number, and the CA's digital signature
- The **chain of trust** runs: Root CA → Intermediate CA → End-entity certificate; browsers ship with pre-trusted root CAs
- **Certificate Revocation** is handled via CRL (Certificate Revocation List) or the faster **OCSP (Online Certificate Status Protocol)**
- **Wildcard certificates** (e.g., *.example.com) cover all subdomains but represent a wider blast radius if compromised
- Certificate **pinning** hardcodes an expected certificate or public key into an application, defeating rogue CA attacks at the cost of operational flexibility

## Related concepts
[[Public Key Infrastructure (PKI)]] [[Certificate Authority]] [[Man-in-the-Middle Attack]] [[TLS/SSL]] [[OCSP Stapling]]