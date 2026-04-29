# X.509 Certificate

## What it is
Think of it as a tamper-evident government ID card for servers and software — it binds a public key to an identity, and a trusted authority stamps it as legitimate. Precisely, X.509 is an ITU-T standard defining the format of public key certificates used in PKI, TLS/SSL, and digital signatures. The certificate contains the subject's identity, their public key, validity dates, and a digital signature from a Certificate Authority (CA) vouching for the whole package.

## Why it matters
In 2011, the CA DigiNotar was compromised, and attackers issued fraudulent X.509 certificates for Google.com — allowing Iranian ISPs to perform a man-in-the-middle attack against ~300,000 users who believed they were talking to the real Google. The browsers trusted the certificate because it carried a valid CA signature; the identity was a lie. This incident killed DigiNotar as a business and accelerated adoption of Certificate Transparency logs to detect rogue certificates.

## Key facts
- **Fields you must know:** Subject, Issuer, Serial Number, Validity Period (Not Before / Not After), Subject Public Key Info, and the CA's digital signature
- **Version 3** introduced extensions, including Subject Alternative Names (SANs), which allow one certificate to cover multiple domains (wildcard certs use `*.example.com`)
- Certificate trust is hierarchical: Root CA → Intermediate CA → End-entity certificate; browsers ship with ~150 pre-trusted root CAs
- **Revocation mechanisms:** CRL (Certificate Revocation List) and OCSP (Online Certificate Status Protocol) — OCSP Stapling reduces privacy leakage and latency
- A self-signed certificate has the same entity as both Subject and Issuer — it provides encryption but **zero third-party identity assurance**

## Related concepts
[[Public Key Infrastructure]] [[Certificate Authority]] [[TLS Handshake]] [[Certificate Transparency]] [[OCSP Stapling]]